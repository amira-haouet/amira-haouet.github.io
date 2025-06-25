<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <!-- Paramètre pour la langue (défaut : français) -->
    <xsl:param name="lang" select="'fr'" />

    <!-- Configuration de sortie HTML5 -->
    <xsl:output method="html" 
                doctype-system="about:legacy-compat"
                indent="yes" 
                encoding="UTF-8" />

    <!-- Template principal -->
    <xsl:template match="/">
        <html lang="{$lang}" 
              prefix="foaf: http://xmlns.com/foaf/0.1/ 
                      dc: http://purl.org/dc/terms/
                      rdfs: http://www.w3.org/2000/01/rdf-schema#
                      xsd: http://www.w3.org/2001/XMLSchema#">
            
            <head>
                <!-- Liens alternatifs multilingues -->
                <link rel="alternate" href="fr.html" hreflang="fr" />
                <link rel="alternate" href="en.html" hreflang="en" />
                <link rel="alternate" href="ar.html" hreflang="ar" />
                <link rel="alternate" href="ja.html" hreflang="ja" />
                
                <meta charset="UTF-8" />
                
                <!-- Métadonnées Dublin Core -->
                <meta property="dc:creator" content="{portfolio/block[@id='personal_name']/content[@lang=$lang]}" />
                <meta property="dc:language" content="{$lang}" />
                <meta property="dc:title" content="{portfolio/block[@id='personal_title']/content[@lang=$lang]}" />
                <meta property="dc:description" content="{portfolio/block[@id='meta_description']/content[@lang=$lang]}" />
                <meta property="dc:date" content="{portfolio/block[@id='footer_year']/content[@lang=$lang]}" />
                
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                
                <title>
                    <xsl:value-of select="portfolio/block[@id='personal_name']/content[@lang=$lang]" /> – 
                    <xsl:value-of select="portfolio/block[@id='personal_title']/content[@lang=$lang]" />
                </title>
                
                <meta name="description" content="{portfolio/block[@id='meta_description']/content[@lang=$lang]}" />
                <meta name="keywords" content="{portfolio/block[@id='meta_keywords']/content[@lang=$lang]}" />
                <meta name="author" content="{portfolio/block[@id='personal_name']/content[@lang=$lang]}" />

                <!-- Favicons et styles -->
                <link rel="icon" href="/static/favicon.ico" type="image/x-icon" />
                <link rel="stylesheet" href="/static/css/style.css" />
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
                <link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
            </head>

            <body lang="{$lang}" vocab="http://xmlns.com/foaf/0.1/" typeof="foaf:Person">
                
                <!-- Écran de chargement -->
                <div class="loading-screen" id="loadingScreen">
                    <div class="loading-spinner"></div>
                    <div class="loading-text">
                        <xsl:value-of select="portfolio/block[@id='loading_text']/content[@lang=$lang]" />
                    </div>
                </div>
                
                <!-- Particules d'arrière-plan -->
                <div class="particles" id="particles"></div>

                <!-- Navigation -->
                <xsl:call-template name="navbar" />

                <!-- Section Hero -->
                <xsl:call-template name="hero-section" />

                <!-- Section À propos -->
                <xsl:call-template name="about-section" />

                <!-- Section Compétences -->
                <xsl:call-template name="skills-section" />

                <!-- Section Expérience -->
                <xsl:call-template name="experience-section" />

                <!-- Section Formation -->
                <xsl:call-template name="education-section" />

                <!-- Section Projets Web Sémantique -->
                <xsl:call-template name="semantic-web-section" />

                <!-- Section Vidéo -->
                <xsl:call-template name="video-section" />

                <!-- Section Contact -->
                <xsl:call-template name="contact-section" />

                <!-- Footer -->
                <xsl:call-template name="footer" />

                <!-- Scripts -->
                <button class="scroll-to-top" id="scrollToTop" aria-label="Haut de page">
                    <i class="fas fa-chevron-up"></i>
                </button>

                <script src="https://unpkg.com/aos@next/dist/aos.js" defer=""></script>
                <script src="https://cdn.jsdelivr.net/npm/@emailjs/browser@3/dist/email.min.js" defer=""></script>
                <script src="/static/js/portfolio.js" defer=""></script>

                <!-- Métadonnées JSON-LD pour SEO -->
                <xsl:call-template name="json-ld-metadata" />
            </body>
        </html>
    </xsl:template>

    <!-- Template pour la barre de navigation -->
    <xsl:template name="navbar">
        <nav class="navbar">
            <div class="nav-container">
                <div class="nav-logo" data-aos="fade-down">
                    <span property="foaf:name">
                        <xsl:value-of select="portfolio/block[@id='personal_name']/content[@lang=$lang]" />
                    </span>
                </div>
                
                <ul class="nav-menu">
                    <li class="nav-item">
                        <a href="#home" class="nav-link">
                            <xsl:value-of select="portfolio/block[@id='nav_home']/content[@lang=$lang]" />
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="#about" class="nav-link">
                            <xsl:value-of select="portfolio/block[@id='nav_about']/content[@lang=$lang]" />
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="#skills" class="nav-link">
                            <xsl:value-of select="portfolio/block[@id='nav_skills']/content[@lang=$lang]" />
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="#experience" class="nav-link">
                            <xsl:value-of select="portfolio/block[@id='nav_experience']/content[@lang=$lang]" />
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="#education" class="nav-link">
                            <xsl:value-of select="portfolio/block[@id='nav_education']/content[@lang=$lang]" />
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="#contact" class="nav-link nav-cta">
                            <xsl:value-of select="portfolio/block[@id='nav_contact']/content[@lang=$lang]" />
                        </a>
                    </li>
                </ul>

                <!-- Sélecteur de langue -->
                <div class="language-selector-nav">
                    <a href="?lang=fr" aria-label="Français">
                        <img src="/static/assets/fr.png" alt="FR" width="24" />
                    </a>
                    <a href="?lang=en" aria-label="English">
                        <img src="/static/assets/en.png" alt="EN" width="24" />
                    </a>
                    <a href="?lang=ar" aria-label="العربية">
                        <img src="/static/assets/ar.png" alt="AR" width="24" />
                    </a>
                    <a href="?lang=ja" aria-label="日本語">
                        <img src="/static/assets/ja.png" alt="JA" width="24" />
                    </a>
                </div>

                <div class="hamburger">
                    <span class="bar"></span>
                    <span class="bar"></span>
                    <span class="bar"></span>
                </div>
            </div>
        </nav>
    </xsl:template>

    <!-- Template pour la section Hero -->
    <xsl:template name="hero-section">
        <section id="home" class="hero">
            <div class="hero-container">
                <div class="hero-content" data-aos="fade-right">
                    <h1 property="foaf:name">
                        <xsl:value-of select="portfolio/block[@id='personal_name']/content[@lang=$lang]" />
                    </h1>
                    
                    <div class="typewriter">
                        <span class="typewriter-text"></span>
                    </div>
                    
                    <p class="hero-description" property="foaf:title">
                        <xsl:value-of select="portfolio/block[@id='personal_title']/content[@lang=$lang]" />
                    </p>
                    
                    <!-- Informations FOAF cachées -->
                    <div style="display: none;">
                        <span property="foaf:givenName">
                            <xsl:value-of select="portfolio/block[@id='personal_given_name']/content[@lang=$lang]" />
                        </span>
                        <span property="foaf:familyName">
                            <xsl:value-of select="portfolio/block[@id='personal_family_name']/content[@lang=$lang]" />
                        </span>
                        <span property="foaf:gender">
                            <xsl:value-of select="portfolio/block[@id='personal_gender']/content[@lang=$lang]" />
                        </span>
                    </div>
                    
                    <div class="hero-buttons">
                        <a href="#contact" class="btn btn-primary">
                            <xsl:value-of select="portfolio/block[@id='btn_contact']/content[@lang=$lang]" />
                        </a>
                        <a href="/static/assets/CvAmiraHAOUET_SP.pdf" download="" property="foaf:page" class="btn btn-secondary">
                            <xsl:value-of select="portfolio/block[@id='btn_download']/content[@lang=$lang]" />
                        </a>
                    </div>

                    <div class="social-links">
                        <a href="{portfolio/block[@id='account_linkedin_url']/content[@lang=$lang]}" target="_blank" property="foaf:account" typeof="foaf:OnlineAccount">
                            <i class="fab fa-linkedin"></i>
                            <span style="display: none;" property="foaf:accountServiceHomepage" resource="https://linkedin.com"></span>
                            <span style="display: none;" property="foaf:accountName">
                                <xsl:value-of select="portfolio/block[@id='account_linkedin_name']/content[@lang=$lang]" />
                            </span>
                        </a>
                        <a href="mailto:{portfolio/block[@id='personal_email']/content[@lang=$lang]}" property="foaf:mbox">
                            <i class="fas fa-envelope"></i>
                        </a>
                    </div>
                </div>
                
                <div class="hero-image" data-aos="fade-left">
                    <div class="image-wrapper">
                        <img src="/static/assets/profile.jpg" alt="{portfolio/block[@id='personal_name']/content[@lang=$lang]}" property="foaf:img" />
                    </div>
                </div>
            </div>
        </section>
    </xsl:template>

    <!-- Template pour la section À propos -->
    <xsl:template name="about-section">
        <section id="about" class="section" data-aos="fade-up">
            <div class="container">
                <div class="section-header">
                    <h2><xsl:value-of select="portfolio/block[@id='nav_about']/content[@lang=$lang]" /></h2>
                    <p class="section-subtitle">
                        <xsl:value-of select="portfolio/block[@id='subtitle_about']/content[@lang=$lang]" />
                    </p>
                </div>
                
                <div class="about-content">
                    <div property="foaf:currentProject" typeof="foaf:Project">
                        <p property="foaf:name">
                            <xsl:value-of select="portfolio/block[@id='current_project_ai']/content[@lang=$lang]" />
                        </p>
                    </div>
                    
                    <div property="foaf:interest">
                        <p>
                            <xsl:value-of select="portfolio/block[@id='personal_description']/content[@lang=$lang]" />
                        </p>
                    </div>
                </div>
            </div>
        </section>
    </xsl:template>

    <!-- Template pour la section Compétences -->
    <xsl:template name="skills-section">
        <section id="skills" class="section" data-aos="fade-up">
            <div class="container">
                <div class="section-header">
                    <h2><xsl:value-of select="portfolio/block[@id='skills_title']/content[@lang=$lang]" /></h2>
                    <p class="section-subtitle">
                        <xsl:value-of select="portfolio/block[@id='subtitle_skills']/content[@lang=$lang]" />
                    </p>
                </div>
                
                <div class="skills-grid">
                    <div property="foaf:topic_interest">
                        <h3>Langages de Programmation</h3>
                        <p>
                            <span property="foaf:topic_interest">
                                <xsl:value-of select="portfolio/block[@id='interest_python']/content[@lang=$lang]" />
                            </span>, 
                            <span property="foaf:topic_interest">
                                <xsl:value-of select="portfolio/block[@id='interest_csharp']/content[@lang=$lang]" />
                            </span>, 
                            <span property="foaf:topic_interest">Java</span>, 
                            <span property="foaf:topic_interest">JavaScript</span>
                        </p>
                    </div>
                    
                    <div property="foaf:topic_interest">
                        <h3>Technologies Web et Données</h3>
                        <p>
                            <span property="foaf:topic_interest">SQL</span>, 
                            <span property="foaf:topic_interest">XML</span>, 
                            <span property="foaf:topic_interest">
                                <xsl:value-of select="portfolio/block[@id='interest_rdf']/content[@lang=$lang]" />
                            </span>, 
                            <span property="foaf:topic_interest">
                                <xsl:value-of select="portfolio/block[@id='interest_sparql']/content[@lang=$lang]" />
                            </span>
                        </p>
                    </div>
                    
                    <div property="foaf:topic_interest">
                        <h3>Domaines d'Expertise</h3>
                        <p>
                            <span property="foaf:topic_interest">
                                <xsl:value-of select="portfolio/block[@id='interest_ai']/content[@lang=$lang]" />
                            </span>, 
                            <span property="foaf:topic_interest">
                                <xsl:value-of select="portfolio/block[@id='interest_semantic_web']/content[@lang=$lang]" />
                            </span>, 
                            <span property="foaf:topic_interest">
                                <xsl:value-of select="portfolio/block[@id='interest_fullstack']/content[@lang=$lang]" />
                            </span>
                        </p>
                    </div>
                </div>
            </div>
        </section>
    </xsl:template>

    <!-- Template pour la section Expérience -->
    <xsl:template name="experience-section">
        <section id="experience" class="section" data-aos="fade-up">
            <div class="container">
                <div class="section-header">
                    <h2><xsl:value-of select="portfolio/block[@id='experience_title']/content[@lang=$lang]" /></h2>
                    <p class="section-subtitle">
                        <xsl:value-of select="portfolio/block[@id='subtitle_experience']/content[@lang=$lang]" />
                    </p>
                </div>
                
                <div class="experience-list">
                    <div property="foaf:workplaceHomepage" typeof="foaf:Organization">
                        <h3>
                            <xsl:value-of select="portfolio/block[@id='exp_holydis_ai']/content[@lang=$lang]" />
                        </h3>
                        <div property="foaf:currentProject" typeof="foaf:Project">
                            <p property="foaf:name">
                                <xsl:value-of select="portfolio/block[@id='current_project_ai']/content[@lang=$lang]" />
                            </p>
                        </div>
                    </div>
                    
                    <div property="foaf:workplaceHomepage" typeof="foaf:Organization">
                        <h3>
                            <xsl:value-of select="portfolio/block[@id='exp_holydis_fs']/content[@lang=$lang]" />
                        </h3>
                        <div property="foaf:currentProject" typeof="foaf:Project">
                            <p property="foaf:name">Développement d'applications web complètes</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </xsl:template>

    <!-- Template pour la section Formation -->
    <xsl:template name="education-section">
        <section id="education" class="section" data-aos="fade-up">
            <div class="container">
                <div class="section-header">
                    <h2><xsl:value-of select="portfolio/block[@id='education_title']/content[@lang=$lang]" /></h2>
                    <p class="section-subtitle">
                        <xsl:value-of select="portfolio/block[@id='subtitle_education']/content[@lang=$lang]" />
                    </p>
                </div>
                
                <div class="education-list">
                    <div property="foaf:schoolHomepage" typeof="foaf:Organization">
                        <h3><xsl:value-of select="portfolio/block[@id='education_sorbonne']/content[@lang=$lang]" /></h3>
                        <p property="foaf:name">
                            <xsl:value-of select="portfolio/block[@id='org_sorbonne']/content[@lang=$lang]" />
                        </p>
                    </div>
                    
                    <div property="foaf:schoolHomepage" typeof="foaf:Organization">
                        <h3><xsl:value-of select="portfolio/block[@id='education_upjv']/content[@lang=$lang]" /></h3>
                        <p property="foaf:name">
                            <xsl:value-of select="portfolio/block[@id='org_upjv']/content[@lang=$lang]" />
                        </p>
                    </div>
                </div>
            </div>
        </section>
    </xsl:template>

    <!-- Template pour la section Web Sémantique -->
    <xsl:template name="semantic-web-section">
        <section id="ws" class="section" data-aos="fade-up">
            <div class="container">
                <div class="section-header">
                    <h2><xsl:value-of select="portfolio/block[@id='tp_ws_title']/content[@lang=$lang]" /></h2>
                </div>
                
                <div property="foaf:currentProject" typeof="foaf:Project">
                    <h3 property="foaf:name">
                        <xsl:value-of select="portfolio/block[@id='current_project_ws']/content[@lang=$lang]" />
                    </h3>
                    <ul>
                        <li property="foaf:topic_interest">
                            <xsl:value-of select="portfolio/block[@id='tp_ws_dtd']/content[@lang=$lang]" />
                        </li>
                        <li property="foaf:topic_interest">
                            <xsl:value-of select="portfolio/block[@id='tp_ws_xsd']/content[@lang=$lang]" />
                        </li>
                        <li property="foaf:topic_interest">
                            <xsl:value-of select="portfolio/block[@id='tp_ws_xslt']/content[@lang=$lang]" />
                        </li>
                        <li property="foaf:topic_interest">
                            <xsl:value-of select="portfolio/block[@id='tp_ws_rdf']/content[@lang=$lang]" />
                        </li>
                        <li property="foaf:topic_interest">
                            <xsl:value-of select="portfolio/block[@id='tp_ws_rdfa']/content[@lang=$lang]" />
                        </li>
                    </ul>
                </div>
            </div>
        </section>
    </xsl:template>

    <!-- Template pour la section Vidéo -->
    <xsl:template name="video-section">
        <section id="video" class="section" data-aos="fade-up">
            <div class="container">
                <div class="section-header">
                    <h2><xsl:value-of select="portfolio/block[@id='video_title']/content[@lang=$lang]" /></h2>
                </div>
                
                <div class="video-wrapper">
                    <xsl:value-of select="portfolio/block[@id='video_iframe']/content[@lang=$lang]" disable-output-escaping="yes" />
                </div>
            </div>
        </section>
    </xsl:template>

    <!-- Template pour la section Contact -->
    <xsl:template name="contact-section">
        <section id="contact" class="section" data-aos="fade-up">
            <div class="container">
                <div class="section-header">
                    <h2><xsl:value-of select="portfolio/block[@id='nav_contact']/content[@lang=$lang]" /></h2>
                    <p class="section-subtitle">
                        <xsl:value-of select="portfolio/block[@id='subtitle_contact']/content[@lang=$lang]" />
                    </p>
                </div>
                
                <div class="contact-info">
                    <p>Email : 
                        <a href="mailto:{portfolio/block[@id='personal_email']/content[@lang=$lang]}" property="foaf:mbox">
                            <xsl:value-of select="portfolio/block[@id='personal_email']/content[@lang=$lang]" />
                        </a>
                    </p>
                    <p>LinkedIn : 
                        <a href="{portfolio/block[@id='account_linkedin_url']/content[@lang=$lang]}" property="foaf:homepage" target="_blank">
                            <xsl:value-of select="portfolio/block[@id='account_linkedin_name']/content[@lang=$lang]" />
                        </a>
                    </p>
                    
                    <!-- Informations de localisation cachées -->
                    <div style="display: none;">
                        <span property="foaf:based_near" typeof="foaf:Organization">
                            <span property="foaf:name">
                                <xsl:value-of select="portfolio/block[@id='personal_location']/content[@lang=$lang]" />
                            </span>
                        </span>
                    </div>
                </div>
            </div>
        </section>
    </xsl:template>

    <!-- Template pour le Footer -->
    <xsl:template name="footer">
        <footer class="footer">
            <div class="container">
                <p>© <xsl:value-of select="portfolio/block[@id='footer_year']/content[@lang=$lang]" /> 
                   <span property="foaf:name">
                       <xsl:value-of select="portfolio/block[@id='personal_name']/content[@lang=$lang]" />
                   </span>. 
                   <xsl:value-of select="portfolio/block[@id='footer_rights']/content[@lang=$lang]" />
                </p>
                <p property="foaf:made">
                    <xsl:value-of select="portfolio/block[@id='footer_made']/content[@lang=$lang]" />
                </p>
            </div>
        </footer>
    </xsl:template>

    <!-- Template pour les métadonnées JSON-LD -->
    <xsl:template name="json-ld-metadata">
        <script type="application/ld+json">
        {
            "@context": "http://xmlns.com/foaf/0.1/",
            "@type": "Person",
            "name": "<xsl:value-of select="portfolio/block[@id='personal_name']/content[@lang=$lang]" />",
            "givenName": "<xsl:value-of select="portfolio/block[@id='personal_given_name']/content[@lang=$lang]" />",
            "familyName": "<xsl:value-of select="portfolio/block[@id='personal_family_name']/content[@lang=$lang]" />",
            "title": "<xsl:value-of select="portfolio/block[@id='personal_title']/content[@lang=$lang]" />",
            "mbox": "mailto:<xsl:value-of select="portfolio/block[@id='personal_email']/content[@lang=$lang]" />",
            "homepage": "<xsl:value-of select="portfolio/block[@id='account_linkedin_url']/content[@lang=$lang]" />",
            "img": "/static/assets/profile.jpg",
            "topic_interest": [
                "<xsl:value-of select="portfolio/block[@id='interest_ai']/content[@lang=$lang]" />",
                "<xsl:value-of select="portfolio/block[@id='interest_semantic_web']/content[@lang=$lang]" />", 
                "<xsl:value-of select="portfolio/block[@id='interest_fullstack']/content[@lang=$lang]" />",
                "<xsl:value-of select="portfolio/block[@id='interest_python']/content[@lang=$lang]" />",
                "<xsl:value-of select="portfolio/block[@id='interest_csharp']/content[@lang=$lang]" />",
                "<xsl:value-of select="portfolio/block[@id='interest_rdf']/content[@lang=$lang]" />",
                "<xsl:value-of select="portfolio/block[@id='interest_sparql']/content[@lang=$lang]" />"
            ],
            "currentProject": {
                "@type": "Project",
                "name": "<xsl:value-of select="portfolio/block[@id='current_project_ai']/content[@lang=$lang]" />"
            },
            "workplaceHomepage": {
                "@type": "Organization",
                "name": "<xsl:value-of select="portfolio/block[@id='org_holydis']/content[@lang=$lang]" />"
            },
            "schoolHomepage": [
                {
                    "@type": "Organization", 
                    "name": "<xsl:value-of select="portfolio/block[@id='org_sorbonne']/content[@lang=$lang]" />"
                },
                {
                    "@type": "Organization",
                    "name": "<xsl:value-of select="portfolio/block[@id='org_upjv']/content[@lang=$lang]" />"
                }
            ]
        }
        </script>
    </xsl:template>

</xsl:stylesheet>