<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:param name="lang" select="'fr'" />

  <xsl:template match="/">
    <html lang="{$lang}">
      <head>
        <meta charset="UTF-8" />
        <title>
          <xsl:value-of select="/translations/lang[@code=$lang]/title" />
        </title>
        <link rel="stylesheet" href="static/style.css" />
        <link rel="alternate" hreflang="fr" href="?lang=fr" />
        <link rel="alternate" hreflang="en" href="?lang=en" />
        <link rel="alternate" hreflang="ar" href="?lang=ar" />
      </head>

      <body>
        <div class="lang-buttons" style="position:fixed; top:10px; right:10px;">
          <a href="?lang=fr">FR</a> |
          <a href="?lang=en">EN</a> |
          <a href="?lang=ar">AR</a>
        </div>

        <header>
          <h1>
            <xsl:value-of select="/translations/lang[@code=$lang]/title" />
          </h1>
          <p>
            <xsl:value-of select="/translations/lang[@code=$lang]/intro" />
          </p>
        </header>

        <section>
          <h2>
            <xsl:value-of select="/translations/lang[@code=$lang]/objective" />
          </h2>
          <p>
            <xsl:value-of select="/translations/lang[@code=$lang]/objective_content" />
          </p>
        </section>

        <section>
          <h2>
            <xsl:value-of select="/translations/lang[@code=$lang]/skills" />
          </h2>
          <ul>
            <li>HTML, CSS, JavaScript</li>
            <li>Python, Java, SQL</li>
          </ul>
        </section>

        <section>
          <h2>
            <xsl:value-of select="/translations/lang[@code=$lang]/experience" />
          </h2>
          <ul>
            <li>Apprentie Full Stack – Holy-Dis</li>
            <li>Stage – LATELIERS</li>
          </ul>
        </section>

        <section>
          <h2>
            <xsl:value-of select="/translations/lang[@code=$lang]/education" />
          </h2>
          <ul>
            <li>Sorbonne Paris Nord – Ingénierie Informatique</li>
            <li>UPJV – L3 Informatique</li>
          </ul>
        </section>

        <section>
          <h2>
            <xsl:value-of select="/translations/lang[@code=$lang]/contact" />
          </h2>
          <ul>
            <li>Email : <a href="mailto:haouetamira@gmail.com">haouetamira@gmail.com</a></li>
            <li>LinkedIn : <a href="https://www.linkedin.com/in/amira-haouet" target="_blank">linkedin.com/in/amira-haouet</a></li>
          </ul>
        </section>

        <section>
          <h2>
            <xsl:value-of select="/translations/lang[@code=$lang]/video" />
          </h2>
          <iframe width="560" height="315" frameborder="0" >
            <xsl:attribute name="src">
              <xsl:value-of select="/translations/lang[@code=$lang]/video_url" />
            </xsl:attribute>
          </iframe>
        </section>

        <footer>
          <p>
            <xsl:value-of select="/translations/lang[@code=$lang]/footer" />
          </p>
        </footer>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
