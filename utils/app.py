from flask import Flask, request, session, render_template, url_for, send_file
from datetime import datetime
from lxml import etree
from dotenv import load_dotenv
import os

# === 0. Préparation ===
load_dotenv()
app = Flask(__name__, template_folder="templates", static_folder="static")
app.secret_key = os.environ.get('FLASK_SECRET_KEY', 'clé_dev_locale')
my_token = os.environ.get("MY_SECRET_TOKEN")


# === 1. Contexte global : injecter l'année ===
@app.context_processor
def inject_now():
    return {'now': datetime.now}

# === 2. Langues supportées ===
AVAILABLE_LANGS = ['fr', 'en', 'ar', 'ja']
DEFAULT_LANG = 'fr'

# === 3. Détection automatique de la langue ===
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

# === 4. Chargement XML et DTD dynamique (depuis static/)
def load_translations(xml_path="static/portfolio.xml", dtd_path="static/portfolio.dtd"):
    try:
        dtd = etree.DTD(dtd_path)
        xml_doc = etree.parse(xml_path)
        if not dtd.validate(xml_doc):
            raise RuntimeError("❌ Le XML n'est pas conforme au DTD.")
        translations = {}
        for block in xml_doc.findall('block'):
            bid = block.get("id")
            translations[bid] = {
                content.get("lang"): content.text
                for content in block.findall("content")
            }
        return translations
    except Exception as e:
        print(f"❌ Erreur de chargement XML : {e}")
        return {}

# === 5. Route principale ===
@app.route('/', methods=['GET', 'POST'])
def index():
    lang = session.get('lang', DEFAULT_LANG)
    translations = load_translations()
    texts = {
        bid: translations.get(bid, {}).get(lang, f"[{bid} missing in {lang}]")
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

# === 6. Transformation XML/XSLT côté serveur ===
@app.route('/xml-version')
def xml_transformed():
    xml_path = os.path.join('static', 'portfolio.xml')
    xsl_path = os.path.join('static', 'portfolio.xsl')
    try:
        dom = etree.parse(xml_path)
        xslt = etree.parse(xsl_path)
        transform = etree.XSLT(xslt)
        result = transform(dom)
        output_path = "/tmp/result.html"
        with open(output_path, 'wb') as f:
            f.write(etree.tostring(result, pretty_print=True, method="html"))
        return send_file(output_path, mimetype='text/html')
    except Exception as e:
        return f"❌ Erreur de transformation XML/XSLT : {e}"

# === 7. Fonction spéciale pour Vercel ===
def handler(request):
    return app(request.environ, start_response=lambda *args: None)

# === 8. Local uniquement : génération de pages statiques
def generate_static_pages(output_dir="static/static_site"):
    os.makedirs(output_dir, exist_ok=True)
    translations = load_translations()
    for lang in AVAILABLE_LANGS:
        with app.test_request_context(f"/?lang={lang}"):
            session['lang'] = lang
            html = render_template(
                "index.html",
                texts={bid: translations.get(bid, {}).get(lang, '') for bid in translations},
                current_lang=lang,
                alternates={l: f"{l}.html" for l in AVAILABLE_LANGS},
                available=AVAILABLE_LANGS
            )
            filename = f"{lang}.html" if lang != "fr" else "index.html"
            output_path = os.path.join(output_dir, filename)
            with open(output_path, "w", encoding="UTF-8") as f:
                f.write(html)
            print(f"✅ {filename} généré.")

def test_missing_translations(xml_path="static/portfolio.xml", langs=AVAILABLE_LANGS):
    try:
        tree = etree.parse(xml_path)
        root = tree.getroot()
        for block in root.findall("block"):
            id_ = block.get("id")
            langs_present = [c.get("lang") for c in block.findall("content")]
            for lang in langs:
                if lang not in langs_present:
                    print(f"❌ Bloc {id_} : traduction manquante pour '{lang}'")
    except Exception as e:
        print(f"Erreur de vérification des traductions : {e}")

if __name__ == '__main__':
    test_missing_translations()
    generate_static_pages()
    app.run(debug=True)
