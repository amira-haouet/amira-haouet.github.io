// portfolio.js

// 1) EmailJS
const EMAILJS_CONFIG = {
  PUBLIC_KEY: "3ItaHUzbe8Yeyv-BL",
  SERVICE_ID: "service_ayasaoud",
  TEMPLATE_ID: "template_m3dqvup"
};

// 2) Splash screen
window.addEventListener('load', () => {
  const loading = document.getElementById('loadingScreen');
  setTimeout(() => {
    loading.classList.add('fade-out');
    setTimeout(() => loading.style.display = 'none', 500);
  }, 1000);
});

// 3) Particles
function createParticles() {
  const container = document.getElementById('particles');
  for (let i = 0; i < 50; i++) {
    const p = document.createElement('div');
    p.className = 'particle';
    p.style.left = `${Math.random() * 100}%`;
    p.style.animationDelay = `${Math.random() * 15}s`;
    p.style.animationDuration = `${Math.random() * 10 + 10}s`;
    container.appendChild(p);
  }
}
createParticles();

// 4) Scroll effects (reveal, navbar shadow, scroll-to-top)
window.addEventListener('scroll', () => {
  document.querySelectorAll('.reveal, .reveal-left, .reveal-right')
    .forEach(el => {
      if (el.getBoundingClientRect().top < window.innerHeight - 150) {
        el.classList.add('active');
      }
    });

  document.getElementById('scrollToTop')
    .classList.toggle('visible', window.pageYOffset > 300);

  document.querySelector('.navbar')
    .classList.toggle('scrolled', window.scrollY > 50);
});

// 5) Hamburger menu
document.querySelector('.hamburger').addEventListener('click', () => {
  document.querySelector('.nav-menu').classList.toggle('active');
});
document.querySelectorAll('.nav-link').forEach(link => {
  link.addEventListener('click', () => {
    document.querySelector('.nav-menu').classList.remove('active');
  });
});

// 6) Smooth anchors
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
  anchor.addEventListener('click', e => {
    e.preventDefault();
    const target = document.querySelector(anchor.getAttribute('href'));
    if (target) {
      target.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }
  });
});

// 7) Contact form (EmailJS)
emailjs.init(EMAILJS_CONFIG.PUBLIC_KEY);
const form = document.getElementById('contact-form');
if (form) form.addEventListener('submit', async e => {
  e.preventDefault();
  const btn       = form.querySelector('.btn-submit');
  const btnText   = btn.querySelector('.btn-text');
  const btnLoad   = btn.querySelector('.btn-loading');

  btn.disabled = true;
  btnText.style.display = 'none';
  btnLoad.style.display = 'flex';

  const data    = new FormData(form);
  const name    = data.get('name')?.trim();
  const email   = data.get('email')?.trim();
  const message = data.get('message')?.trim();
  const emailRx = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

  if (!name || !email || !message || !emailRx.test(email)) {
    showMsg('Veuillez remplir correctement tous les champs.', 'error');
    return resetBtn();
  }

  try {
    await emailjs.send(
      EMAILJS_CONFIG.SERVICE_ID,
      EMAILJS_CONFIG.TEMPLATE_ID,
      { from_name: name, from_email: email, message,
        to_name: 'Amira Haouet', to_email: 'haouetamira@gmail.com' }
    );
    showMsg('Message envoyé !', 'success');
    form.reset();
  } catch {
    showMsg('Erreur d’envoi, réessayez.', 'error');
  }
  resetBtn();

  function resetBtn() {
    btn.disabled = false;
    btnText.style.display = 'flex';
    btnLoad.style.display = 'none';
  }
  function showMsg(text, type) {
    let msg = form.querySelector('.form-message');
    if (msg) msg.remove();
    msg = document.createElement('div');
    msg.className = `form-message form-message-${type}`;
    msg.textContent = text;
    form.appendChild(msg);
    setTimeout(() => msg.remove(), 5000);
  }
});

// 8) AOS
AOS.init({ duration: 800, easing: 'ease-out-quart', once: true, offset: 50, delay: 100 });

// 9) Typewriter
const typewriterTexts = ['AI Engineer', 'Full-Stack Dev', 'Étudiante Ingénieure', 'Recherche IA'];
let textIndex = 0, charIndex = 0, deleting = false;

function typeWriter() {
  const el  = document.querySelector('.typewriter-text');
  const cur = typewriterTexts[textIndex];
  el.textContent = deleting
    ? cur.substring(0, charIndex--)
    : cur.substring(0, ++charIndex);

  let speed = deleting ? 75 : 150;
  if (!deleting && charIndex === cur.length) {
    speed   = 200;
    deleting = true;
  } else if (deleting && charIndex === 0) {
    deleting  = false;
    textIndex = (textIndex + 1) % typewriterTexts.length;
  }

  setTimeout(typeWriter, speed);
}
document.addEventListener('DOMContentLoaded', typeWriter);
