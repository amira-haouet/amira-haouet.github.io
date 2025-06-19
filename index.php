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

// Charger le fichier JSON
$translations = json_decode(file_get_contents("lang.json"), true);
$t = $translations[$lang];
?>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <title>Portfolio - Amira Haouet</title>
<link rel="stylesheet" href="style.css">

</head>
<body>

  <header>
    <h1>Bienvenue sur le portfolio de Amira Haouet</h1>
    <p>Étudiante en informatique passionnée par le développement logiciel et l'intelligence artificielle.</p>
  </header>

  <section>
    <h2>Objectif Professionnel</h2>
    <p>Actuellement en alternance chez Holy-Dis, je développe mes compétences en développement full stack et en intelligence artificielle. Ce portfolio présente mes projets, mon parcours et mes compétences dans le cadre de ma formation en ingénierie informatique.</p>
  </section>

  <section>
    <h2>Compétences</h2>
    <ul>
      <li><strong>Langages :</strong> C#, VB.NET, Python, Java, SQL, XML</li>
      <li><strong>Frameworks :</strong> Spring Boot, Angular</li>
      <li><strong>Web :</strong> HTML, CSS, JavaScript</li>
    </ul>
  </section>

  <section>
    <h2>Expériences</h2>
    <ul>
      <li><strong>Apprentie Full Stack Engineer</strong> – Holy-Dis (2023–2026)</li>
      <li><strong>Stage Développeuse Full Stack</strong> – LATELIERS (2023)</li>
      <li><strong>Stage</strong> – BFI Groupe (2022)</li>
    </ul>
  </section>

  <section>
    <h2>Formation</h2>
    <ul>
      <li><strong>Ingénierie Informatique</strong> – Sorbonne Paris Nord (2023–2026)</li>
      <li><strong>Licence Informatique (L3)</strong> – UPJV (2022–2023)</li>
      <li><strong>Licence Informatique</strong> – ISET Nabeul (2020–2022)</li>
    </ul>
  </section>

  <section>
    <h2>Contact</h2>
    <ul>
      <li><strong>Email :</strong> <a href="mailto:haouetamira@gmail.com">haouetamira@gmail.com</a></li>
      <li><strong>LinkedIn :</strong> <a href="https://www.linkedin.com/in/amira-haouet/" target="_blank">linkedin.com/in/amira-haouet</a></li>
    </ul>
  </section>

  <footer>
    Voir en ligne : <a href="https://amira-haouet.github.io" target="_blank">amira-haouet.github.io</a>
  </footer>

</body>
</html>
