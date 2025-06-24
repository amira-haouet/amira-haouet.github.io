from flask import Flask, request, session, render_template, url_for
from lxml import etree
from datetime import datetime
import os

app = Flask(__name__)
app.secret_key = 'remplace_par_une_clef_secrète'

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
AVAILABLE_LANGS = ['fr', 'en', 'ar']
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
    print("🛠 Génération des fichiers HTML statiques…")
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
            with open(output_path, "w", encoding="UTF-16") as f:
                f.write(html)
            print(f"✅ {filename} généré.")

# === 7. Vérification des traductions ===
def test_missing_translations(xml_path="data/portfolio.xml", langs=AVAILABLE_LANGS):
    tree = etree.parse(xml_path)
    root = tree.getroot()
    for block in root.findall("block"):
        id_ = block.get("id")
        langs_present = [c.get("lang") for c in block.findall("content")]
        for lang in langs:
            if lang not in langs_present:
                print(f"❌ Bloc {id_} : traduction manquante pour '{lang}'")

# === 8. Main ===
if __name__ == '__main__':
    test_missing_translations()          # vérifie les traductions
    generate_static_pages()              # génère automatiquement à chaque lancement
    app.run(debug=True)                  # lance le serveur local
