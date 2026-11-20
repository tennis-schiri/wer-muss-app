/* Source fingerprint MW-JUXILO-2026 | Copyright (c) 2026 Michael Wiedeck. */
(() => {
  'use strict';
  const key = 'juxilo_site_language';
  let language = navigator.language?.toLowerCase().startsWith('de') ? 'de' : 'en';
  try {
    const saved = localStorage.getItem(key);
    if (saved === 'de' || saved === 'en') language = saved;
  } catch (_) {}
  function update(next) {
    language = next;
    document.documentElement.lang = next;
    document.querySelectorAll('[data-de][data-en]').forEach(node => {
      node.textContent = node.dataset[next];
    });
    document.querySelectorAll('[data-language]').forEach(button => {
      const selected = button.dataset.language === next;
      button.setAttribute('aria-pressed', String(selected));
    });
    const title = document.body.dataset[next === 'de' ? 'pageTitleDe' : 'pageTitleEn'];
    if (title) document.title = title;
  }
  document.querySelectorAll('[data-language]').forEach(button => {
    button.addEventListener('click', () => {
      const next = button.dataset.language;
      if (next !== 'de' && next !== 'en') return;
      try { localStorage.setItem(key, next); } catch (_) {}
      update(next);
    });
  });
  const year = document.getElementById('copyright-year');
  if (year) year.textContent = String(new Date().getFullYear());
  update(language);
})();
