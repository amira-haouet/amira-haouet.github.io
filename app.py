from flask import Flask, request, session, render_template, url_for, send_file
from datetime import datetime
from lxml import etree
import os

app = Flask(__name__, template_folder="templates", static_folder="static")
app.secret_key = 'clef_super_secrete_Amira'

# === 1. Contexte global : injecter l'année ===
@app.context_processor
def inject_now():
    return { 'now': datetime.now }

# === 2. Chargement XML + validation DTD ===
dtd = etree.DTD('data/portfolio.dtd')
xml_doc = etree.parse('data/portfolio.xml')
if not dtd.validate(xml_doc):
    raise RuntimeError("❌ portfolio.xml n'est pas conforme à portfolio.dtd")

# === 3. Extraction des textes { id: {lang: texte, …} } ===
translations = {}
for block in xml_doc.findall('block'):
    bid = block.get("id")
    translations[bid] = {
        content.get("lang"): content.text
        for content in block.findall("content")
    }

# === 4. Langues supportées ===
AVAILABLE_LANGS = ['fr', 'en', 'ar', 'ja']
DEFAULT_LANG = 'fr'

def detect_lang():
    g = request.args.get('lang')
    if g in AVAILABLE_LANGS:
        return g
    p = request.form.get('lang')
    if p in AVAILABLE_LANGS:
        return p
    if 'lang' in session and session['lang'] in AVAILABLE_LANGS:
        return session['lang']
    best = request.accept_languages.best_match(AVAILABLE_LANGS)
    return best or DEFAULT_LANG

@app.before_request
def pick_language():
    session['lang'] = detect_lang()

# === 5. Route principale ===
@app.route('/', methods=['GET', 'POST'])
def index():
    lang = session.get('lang', DEFAULT_LANG)
    texts = {
        bid: translations[bid].get(lang, f"[{bid} missing in {lang}]")
        for bid in translations
    }
    alternates = {
        l: url_for('index', lang=l, _external=True)
        for l in AVAILABLE_LANGS
    }
    return render_template(
        'index.html',
        texts=texts,
        current_lang=lang,
        alternates=alternates,
        available=AVAILABLE_LANGS
    )

# === 6. Générateur de pages statiques ===
def generate_static_pages(output_dir="static_site"):
    os.makedirs(output_dir, exist_ok=True)
    for lang in AVAILABLE_LANGS:
        with app.test_request_context(f"/?lang={lang}"):
            lang_code = detect_lang()
            session['lang'] = lang_code
            html = render_template(
                "index.html",
                texts={bid: translations[bid].get(lang_code, '') for bid in translations},
                current_lang=lang_code,
                alternates={l: f"{l}.html" for l in AVAILABLE_LANGS},
                available=AVAILABLE_LANGS
            )
            filename = f"{lang}.html" if lang != "fr" else "index.html"
            output_path = os.path.join(output_dir, filename)
            with open(output_path, "w", encoding="UTF-8") as f:
                f.write(html)

# === 7. Vérification des traductions manquantes ===
def test_missing_translations(xml_path="data/portfolio.xml", langs=AVAILABLE_LANGS):
    tree = etree.parse(xml_path)
    root = tree.getroot()
    for block in root.findall("block"):
        id_ = block.get("id")
        langs_present = [c.get("lang") for c in block.findall("content")]
        for lang in langs:
            if lang not in langs_present:
                print(f"❌ Bloc {id_} : traduction manquante pour '{lang}'")

# === 8. Transformation XSLT (optionnelle) ===
@app.route('/xml-version')
def xml_transformed():
    xml_path = os.path.join('static', 'portfolio.xml')
    xsl_path = os.path.join('xslt', 'transform.xsl')

    dom = etree.parse(xml_path)
    xslt = etree.parse(xsl_path)
    transform = etree.XSLT(xslt)
    result = transform(dom)

    with open('/tmp/result.html', 'wb') as f:
        f.write(etree.tostring(result, pretty_print=True, method="html"))

    return send_file('/tmp/result.html', mimetype='text/html')

# === 9. Fonction spéciale pour Vercel ===
def handler(request):
    return app(request.environ, start_response=lambda *args: None)

# === 10. Lancement local uniquement ===
if __name__ == '__main__':
    test_missing_translations()
    generate_static_pages()
    app.run(debug=True)
from dotenv import load_dotenv
load_dotenv()

import os
my_token = os.environ.get("MY_SECRET_TOKEN")
