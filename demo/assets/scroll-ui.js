(() => {
  'use strict';
  const header = document.querySelector('.header');
  const button = document.createElement('button');
  button.type = 'button';
  button.className = 'back-to-top';
  button.setAttribute('aria-label', 'Nach oben');
  button.setAttribute('title', 'Nach oben');
  button.innerHTML = '<span class="back-to-top-arrow" aria-hidden="true">↑</span><span class="back-to-top-label">Nach oben</span>';
  document.body.append(button);

  const updateHeaderHeight = () => {
    const height = header ? Math.ceil(header.getBoundingClientRect().height) : 0;
    document.documentElement.style.setProperty('--site-header-height', height + 'px');
  };
  const updateScrollState = () => {
    const y = window.scrollY || document.documentElement.scrollTop || 0;
    document.body.classList.toggle('has-scrolled', y > 16);
    button.classList.toggle('is-visible', y > 260);
  };
  const updateLanguage = () => {
    const english = document.documentElement.lang.toLowerCase().startsWith('en');
    const label = english ? 'Back to top' : 'Nach oben';
    button.setAttribute('aria-label', label);
    button.setAttribute('title', label);
    button.querySelector('.back-to-top-label').textContent = english ? 'Top' : 'Nach oben';
  };

  button.addEventListener('click', () => {
    const reduceMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    window.scrollTo({ top: 0, behavior: reduceMotion ? 'instant' : 'smooth' });
  });
  window.addEventListener('scroll', updateScrollState, { passive: true });
  window.addEventListener('resize', () => {
    updateHeaderHeight();
    updateScrollState();
  }, { passive: true });
  if (header && 'ResizeObserver' in window) {
    new ResizeObserver(updateHeaderHeight).observe(header);
  }
  new MutationObserver(updateLanguage).observe(document.documentElement, {
    attributes: true,
    attributeFilter: ['lang']
  });
  updateHeaderHeight();
  updateLanguage();
  updateScrollState();
})();
