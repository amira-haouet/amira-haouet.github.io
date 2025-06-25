from flask import Flask, render_template, request
import os

app = Flask(__name__, template_folder="../templates", static_folder="../static")

# Dictionnaire de traductions
translations = {
    'fr': {
        'personal_name': 'Amira Haouet',
        'personal_title': 'Ingénieure Informatique',
        'meta_description': 'Portfolio multilingue d’Amira.',
        'meta_keywords': 'Amira, Portfolio, Informatique',
        'nav_home': 'Accueil',
        'nav_about': 'À propos',
        'nav_skills': 'Compétences',
        'nav_experience': 'Expérience',
        'nav_education': 'Éducation',
        'nav_contact': 'Contact',
        'btn_contact': 'Me contacter',
        'btn_download': 'Télécharger le CV',
        'personal_email': 'amira@example.com',
        'social_linkedin': 'https://www.linkedin.com/in/amira',
        'loading_text': 'Chargement...',
        'education_title': 'Éducation',
        'education_sorbonne': 'Université Sorbonne Paris Nord',
        'education_upjv': 'Université de Picardie Jules Verne',
        'subtitle_about': 'Mon parcours',
        'subtitle_skills': 'Compétences principales',
        'skills_title': 'Compétences',
        'skills_list': 'Python, Flask, XML, Web Sémantique...',
        'experience_title': 'Expérience',
        'exp_holydis_ai': 'Stage IA chez Holy-Dis (2024)',
        'exp_holydis_fs': 'Alternance Full Stack chez Holy-Dis (2025)',
        'subtitle_experience': 'Mes expériences professionnelles',
        'subtitle_education': 'Mes formations',
        'tp_ws_title': 'Travaux pratiques de Web Sémantique',
        'tp_ws_dtd': 'DTD pour site multilingue',
        'tp_ws_xsd': 'XSD structuré',
        'tp_ws_xslt': 'Feuille de style XSLT',
        'tp_ws_rdf': 'Fichier RDF Turtle',
        'tp_ws_rdfa': 'Annotations RDFa complètes',
        'video_title': 'Vidéo de présentation',
        'video_iframe': '<iframe src="https://www.youtube.com/embed/VIDE0_ID" frameborder="0" allowfullscreen></iframe>',
        'subtitle_contact': 'Contactez-moi par mail',
        'footer_rights': 'Tous droits réservés.'
    },
    'en': {
        'personal_name': 'Amira Haouet',
        'personal_title': 'Computer Engineer',
        'meta_description': 'Amira’s multilingual portfolio.',
        'meta_keywords': 'Amira, Portfolio, Computer Science',
        'nav_home': 'Home',
        'nav_about': 'About',
        'nav_skills': 'Skills',
        'nav_experience': 'Experience',
        'nav_education': 'Education',
        'nav_contact': 'Contact',
        'btn_contact': 'Contact Me',
        'btn_download': 'Download CV',
        'personal_email': 'amira@example.com',
        'social_linkedin': 'https://www.linkedin.com/in/amira',
        'loading_text': 'Loading...',
        'education_title': 'Education',
        'education_sorbonne': 'Sorbonne Paris Nord University',
        'education_upjv': 'University of Picardie Jules Verne',
        'subtitle_about': 'My background',
        'subtitle_skills': 'Core skills',
        'skills_title': 'Skills',
        'skills_list': 'Python, Flask, XML, Semantic Web...',
        'experience_title': 'Experience',
        'exp_holydis_ai': 'AI Intern at Holy-Dis (2024)',
        'exp_holydis_fs': 'Full Stack Apprentice at Holy-Dis (2025)',
        'subtitle_experience': 'Professional experiences',
        'subtitle_education': 'My academic background',
        'tp_ws_title': 'Semantic Web Labs',
        'tp_ws_dtd': 'Multilingual DTD',
        'tp_ws_xsd': 'Structured XSD',
        'tp_ws_xslt': 'XSLT stylesheet',
        'tp_ws_rdf': 'Turtle RDF file',
        'tp_ws_rdfa': 'Complete RDFa annotations',
        'video_title': 'Presentation Video',
        'video_iframe': '<iframe src="https://www.youtube.com/embed/VIDE0_ID" frameborder="0" allowfullscreen></iframe>',
        'subtitle_contact': 'Contact me by email',
        'footer_rights': 'All rights reserved.'
    }
    # Tu peux ajouter 'ar', 'ja', etc.
}

@app.route('/')
def index():
    lang = request.args.get('lang', 'fr')
    texts = translations.get(lang, translations['fr'])
    return render_template(
        'index.html',
        texts=texts,
        current_lang=lang,
        alternates={
            'fr': '/?lang=fr',
            'en': '/?lang=en',
            'ar': '/?lang=ar',
            'ja': '/?lang=ja'
        }
    )

# Obligatoire pour Vercel
def handler(request):
    return app(request.environ, start_response=lambda *args: None)
