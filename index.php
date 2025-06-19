<?php
session_start();

// Détermination de la langue
if (isset($_GET['lang'])) {
  $lang = $_GET['lang'];
  $_SESSION['lang'] = $lang;
} elseif (isset($_POST['lang'])) {
  $lang = $_POST['lang'];
  $_SESSION['lang'] = $lang;
} elseif (isset($_SESSION['lang'])) {
  $lang = $_SESSION['lang'];
} elseif (isset($_SERVER['HTTP_ACCEPT_LANGUAGE'])) {
  $lang = substr($_SERVER['HTTP_ACCEPT_LANGUAGE'], 0, 2);
} else {
  $lang = 'fr';
}

$supported = ['fr', 'en', 'ar'];
if (!in_array($lang, $supported)) {
  $lang = 'fr';
}

$translations = json_decode(file_get_contents("lang.json"), true);
$t = $translations[$lang];
?>
<!DOCTYPE html>
<html lang="<?= $lang ?>">
<head>
  <meta charset="UTF-8">
  <title><?= $t['title'] ?></title>
  <link rel="stylesheet" href="style.css">
  <link rel="alternate" hreflang="fr" href="index.php?lang=fr">
  <link rel="alternate" hreflang="en" href="index.php?lang=en">
  <link rel="alternate" hreflang="ar" href="index.php?lang=ar">
  <meta about="#me" property="schema:name" content="Amira Haouet" />
  <meta about="#me" property="schema:email" content="mailto:haouetamira@gmail.com" />
  <meta about="#me" property="schema:affiliation" content="Université Paris 13" />
</head>
<body>
  <div style="position:fixed; top:10px; right:10px;">
    <a href="?lang=fr">🇫🇷</a>
    <a href="?lang=en">🇬🇧</a>
    <a href="?lang=ar">🇸🇦</a>
  </div>

  <header vocab="https://schema.org/" typeof="Person">
    <h1 property="name"><?= $t['title'] ?></h1>
    <p property="jobTitle"><?= $t['intro'] ?></p>
  </header>

  <section>
    <h2><?= $t['objective'] ?></h2>
    <p><?= $t['objective_content'] ?></p>
  </section>

  <section>
    <h2><?= $t['skills'] ?></h2>
    <ul>
      <li><strong>Langages :</strong> C#, VB.NET, Python, Java, SQL, XML</li>
      <li><strong>Frameworks :</strong> Spring Boot, Angular</li>
      <li><strong>Web :</strong> HTML, CSS, JavaScript</li>
    </ul>
  </section>

  <section>
    <h2><?= $t['experience'] ?></h2>
    <ul>
      <li><strong>Apprentie Full Stack Engineer</strong> – Holy-Dis (2023–2026)</li>
      <li><strong>Stage Développeuse Full Stack</strong> – LATELIERS (2023)</li>
      <li><strong>Stage</strong> – BFI Groupe (2022)</li>
    </ul>
  </section>

  <section>
    <h2><?= $t['education'] ?></h2>
    <ul>
      <li><strong>Ingénierie Informatique</strong> – Sorbonne Paris Nord (2023–2026)</li>
      <li><strong>Licence Informatique (L3)</strong> – UPJV (2022–2023)</li>
      <li><strong>Licence Informatique</strong> – ISET Nabeul (2020–2022)</li>
    </ul>
  </section>

  <section>
    <h2><?= $t['contact'] ?></h2>
    <ul>
      <li><strong>Email :</strong> <a href="mailto:haouetamira@gmail.com">haouetamira@gmail.com</a></li>
      <li><strong>LinkedIn :</strong> <a href="https://www.linkedin.com/in/amira-haouet/" target="_blank">linkedin.com/in/amira-haouet</a></li>
    </ul>
  </section>

  <section>
    <h2><?= $t['video'] ?></h2>
    <iframe width="560" height="315" src="https://www.youtube.com/embed/XXXXXXX?hl=<?= $lang ?>" allowfullscreen></iframe>
  </section>

  <footer>
    <?= $t['footer'] ?> <a href="https://amira-haouet.github.io" target="_blank">amira-haouet.github.io</a>
  </footer>
</body>
</html>
