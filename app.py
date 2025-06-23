from flask import Flask, request, session, render_template, redirect, url_for
from lxml import etree

app = Flask(__name__)
app.secret_key = 'remplace_par_une_clef_secrète'
from datetime import datetime

@app.context_processor
def inject_now():
    return { 'now': datetime.now }

# 1) Validation DTD + chargement XML
dtd = etree.DTD('dtd/portfolio.dtd')
xml_doc = etree.parse('portfolio.xml')
if not dtd.validate(xml_doc):
    raise RuntimeError("❌ portfolio.xml n'est pas conforme à portfolio.dtd")

# 2) Préparation du dictionnaire complet { id: {lang: texte, …}, … }
translations = {}
for block in xml_doc.findall('block'):
    bid = block.get('id')
    translations[bid] = {
        content.get('lang'): content.text
        for content in block.findall('content')
    }

# 3) Langues supportées et langue par défaut
AVAILABLE_LANGS = ['fr', 'en', 'ar']
DEFAULT_LANG = 'fr'

def detect_lang():
    # 1) GET
    g = request.args.get('lang')
    if g in AVAILABLE_LANGS:
        return g
    # 2) POST
    p = request.form.get('lang')
    if p in AVAILABLE_LANGS:
        return p
    # 3) session
    if 'lang' in session and session['lang'] in AVAILABLE_LANGS:
        return session['lang']
    # 4) Accept-Language
    best = request.accept_languages.best_match(AVAILABLE_LANGS)
    if best:
        return best
    # 5) défaut
    return DEFAULT_LANG

@app.before_request
def pick_language():
    lang = detect_lang()
    session['lang'] = lang

@app.route('/', methods=['GET', 'POST'])
def index():
    lang = session.get('lang', DEFAULT_LANG)
    # 4) Extraction des textes pour la langue courante
    texts = {
        bid: translations[bid].get(lang, '')
        for bid in translations
    }
    # 5) Préparation des liens <link rel="alternate">
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

if __name__ == '__main__':
    app.run(debug=True)
