<?xml version="1.0" encoding="UTF-16"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:param name="lang" select="'fr'" />

    <xsl:output method="html" indent="yes" encoding="UTF-16" />

    <xsl:template match="/">
        <html lang="{$lang}">
            <head>
                <meta charset="UTF-16" />
                <title>
                    <xsl:value-of select="portfolio/block[@id='personal_name']/content[@lang=$lang]" />
                </title>

                <link rel="stylesheet" href="/static/css/style.css" />
                <link rel="author" href="{{ texts['social_linkedin'] }}"/>


                <link rel="stylesheet" href="/static/css/style.css" />
                <link rel="icon" href="/static/favicon.ico" type="image/x-icon" />
                <link rel="stylesheet"
                    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
                <link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />


            </head>
            <body>
                <h1>
                    <xsl:value-of select="portfolio/block[@id='personal_name']/content[@lang=$lang]" />
                </h1>
                <h2>
                    <xsl:value-of
                        select="portfolio/block[@id='personal_title']/content[@lang=$lang]" />
                </h2>
                <p>Email: <xsl:value-of
                        select="portfolio/block[@id='personal_email']/content[@lang=$lang]" /></p>

                <h3>
                    <xsl:value-of
                        select="portfolio/block[@id='education_title']/content[@lang=$lang]" />
                </h3>
                <ul>
                    <li>
                        <xsl:value-of
                            select="portfolio/block[@id='education_sorbonne']/content[@lang=$lang]" />
                    </li>
                    <li>
                        <xsl:value-of
                            select="portfolio/block[@id='education_upjv']/content[@lang=$lang]" />
                    </li>
                </ul>

                <h3>
                    <xsl:value-of select="portfolio/block[@id='skills_title']/content[@lang=$lang]" />
                </h3>
                <p>
                    <xsl:value-of select="portfolio/block[@id='skills_list']/content[@lang=$lang]" />
                </p>

                <h3>
                    <xsl:value-of
                        select="portfolio/block[@id='experience_title']/content[@lang=$lang]" />
                </h3>
                <ul>
                    <li>
                        <xsl:value-of
                            select="portfolio/block[@id='exp_holydis_ai']/content[@lang=$lang]" />
                    </li>
                    <li>
                        <xsl:value-of
                            select="portfolio/block[@id='exp_holydis_fs']/content[@lang=$lang]" />
                    </li>
                </ul>

                <h3>
                    <xsl:value-of select="portfolio/block[@id='tp_ws_title']/content[@lang=$lang]" />
                </h3>
                <ul>
                    <li>
                        <xsl:value-of select="portfolio/block[@id='tp_ws_dtd']/content[@lang=$lang]" />
                    </li>
                    <li>
                        <xsl:value-of select="portfolio/block[@id='tp_ws_xsd']/content[@lang=$lang]" />
                    </li>
                    <li>
                        <xsl:value-of
                            select="portfolio/block[@id='tp_ws_xslt']/content[@lang=$lang]" />
                    </li>
                    <li>
                        <xsl:value-of select="portfolio/block[@id='tp_ws_rdf']/content[@lang=$lang]" />
                    </li>
                    <li>
                        <xsl:value-of
                            select="portfolio/block[@id='tp_ws_rdfa']/content[@lang=$lang]" />
                    </li>
                </ul>

                <h3>
                    <xsl:value-of select="portfolio/block[@id='video_title']/content[@lang=$lang]" />
                </h3>
                <div>
                    <xsl:value-of select="portfolio/block[@id='video_iframe']/content[@lang=$lang]"
                        disable-output-escaping="yes" />
                </div>

                <footer>
                    <p><xsl:value-of
                            select="portfolio/block[@id='footer_year']/content[@lang=$lang]" /> - <xsl:value-of
                            select="portfolio/block[@id='footer_rights']/content[@lang=$lang]" /></p>
                </footer>
                <script src="https://unpkg.com/aos@next/dist/aos.js" defer="defer"></script>
                <script src="https://cdn.jsdelivr.net/npm/@emailjs/browser@3/dist/email.min.js"
                    defer="defer"></script>
                <script src="/static/js/portfolio.js" defer="defer"></script>

            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>