(function () {
  'use strict';

  function initCashFaq() {
    document.querySelectorAll('.cash-faq__item').forEach(function (item, index) {
      var question = item.querySelector('.cash-faq__question');
      var answer = item.querySelector('.cash-faq__answer');

      if (!question || !answer || question.dataset.cashFaqReady) {
        return;
      }

      var answerId = 'cash-faq-answer-' + index;
      question.dataset.cashFaqReady = '1';
      question.setAttribute('role', 'button');
      question.setAttribute('tabindex', '0');
      question.setAttribute('aria-expanded', 'false');
      question.setAttribute('aria-controls', answerId);
      answer.id = answerId;
      answer.setAttribute('aria-hidden', 'true');

      function toggleAnswer() {
        var isOpen = !item.classList.contains('is-open');

        if (isOpen) {
          document.querySelectorAll('.cash-faq__item.is-open').forEach(function (openItem) {
            if (openItem === item) {
              return;
            }

            openItem.classList.remove('is-open');
            var openQuestion = openItem.querySelector('.cash-faq__question');
            var openAnswer = openItem.querySelector('.cash-faq__answer');

            if (openQuestion) {
              openQuestion.setAttribute('aria-expanded', 'false');
            }
            if (openAnswer) {
              openAnswer.setAttribute('aria-hidden', 'true');
            }
          });
        }

        item.classList.toggle('is-open', isOpen);
        question.setAttribute('aria-expanded', isOpen ? 'true' : 'false');
        answer.setAttribute('aria-hidden', isOpen ? 'false' : 'true');
      }

      question.addEventListener('click', toggleAnswer);
      question.addEventListener('keydown', function (event) {
        if (event.key === 'Enter' || event.key === ' ') {
          event.preventDefault();
          toggleAnswer();
        }
      });
    });
  }

  function initCashServiceAnchors() {
    if (window.location.pathname.indexOf('/content/services-cash-alimentaire') === -1) {
      return;
    }

    var serviceAnchors = {
      'conseil': 'conseil',
      'disponibilite': 'disponibilite',
      'livraison': 'livraison',
      'accompagnement': 'accompagnement'
    };

    document.querySelectorAll('#content h3').forEach(function (heading) {
      if (heading.closest('.cash-signature__grid')) {
        return;
      }

      var normalizedTitle = heading.textContent.trim().toLocaleLowerCase('fr')
        .normalize('NFD')
        .replace(/[\u0300-\u036f]/g, '');
      var anchor = serviceAnchors[normalizedTitle];

      if (anchor) {
        heading.id = anchor;
        heading.classList.add('cash-service-anchor');
      }
    });

    var requestedAnchor = window.location.hash.replace(/^#/, '');
    var target = requestedAnchor ? document.getElementById(requestedAnchor) : null;
    if (target) {
      window.requestAnimationFrame(function () {
        target.scrollIntoView({block: 'start'});
      });
    }
  }

  function initCashStickyHeader() {
    var header = document.querySelector('#header');
    var headerNav = header ? header.querySelector('.header-nav') : null;
    var headerTop = header ? header.querySelector('.header-top') : null;
    var megaMenu = header ? header.querySelector('.ets_mm_megamenu') : null;

    if (!header || !headerNav || !headerTop || !megaMenu || header.querySelector('[data-cash-sticky-header]')) {
      return;
    }

    var shell = document.createElement('div');
    var spacer = document.createElement('div');
    shell.className = 'cash-header-sticky-shell';
    shell.setAttribute('data-cash-sticky-header', '');
    spacer.className = 'cash-header-sticky-spacer';
    spacer.setAttribute('aria-hidden', 'true');

    header.insertBefore(shell, headerNav);
    shell.appendChild(headerNav);
    shell.appendChild(headerTop);
    shell.appendChild(megaMenu);
    header.insertBefore(spacer, shell.nextSibling);

    var stickyOffset = shell.getBoundingClientRect().top + window.pageYOffset;
    var normalHeight = shell.getBoundingClientRect().height;
    var scheduled = false;

    function resetSticky() {
      shell.classList.remove('is-sticky');
      document.body.classList.remove('cash-header-is-sticky');
      spacer.style.height = '0px';
    }

    function updateSticky() {
      scheduled = false;

      if (window.innerWidth < 992) {
        resetSticky();
        return;
      }

      var shouldStick = window.pageYOffset > stickyOffset + 1;
      shell.classList.toggle('is-sticky', shouldStick);
      document.body.classList.toggle('cash-header-is-sticky', shouldStick);
      spacer.style.height = shouldStick ? normalHeight + 'px' : '0px';
    }

    function scheduleUpdate() {
      if (scheduled) return;
      scheduled = true;
      window.requestAnimationFrame(updateSticky);
    }

    window.addEventListener('scroll', scheduleUpdate, {passive: true});
    window.addEventListener('resize', function () {
      resetSticky();
      stickyOffset = shell.getBoundingClientRect().top + window.pageYOffset;
      normalHeight = shell.getBoundingClientRect().height;
      scheduleUpdate();
    });
    updateSticky();
  }

  function initCashBlogLinks() {
    document.querySelectorAll('#categories_blog_menu a[href], .an-blog-tags a[href]').forEach(function (link) {
      var href = link.getAttribute('href') || '';
      var cleanedHref = href.replace(/HTTP(?:\s.*)?$/i, '');
      if (cleanedHref !== href) {
        link.setAttribute('href', cleanedHref);
      }
    });

    var title = document.querySelector('body#index .anblog-widget > .anblog-widget-title');
    if (title && !title.querySelector('.cash-blog-all')) {
      var source = title.querySelector('a');
      var allPosts = document.createElement('a');
      allPosts.className = 'cash-blog-all';
      allPosts.href = source ? source.href : '/blog.html';
      allPosts.textContent = 'Voir tous les articles →';
      title.appendChild(allPosts);
    }
  }

  function initCashActiveMenu() {
    var currentPath = window.location.pathname.replace(/\/$/, '');
    document.querySelectorAll('#header .ets_mm_megamenu .mm_menus_li > a.ets_mm_url').forEach(function (link) {
      var item = link.closest('.mm_menus_li');
      var targetPath;
      try {
        targetPath = new URL(link.href, window.location.origin).pathname.replace(/\/$/, '');
      } catch (error) {
        return;
      }
      var active = targetPath && targetPath !== '/' && (currentPath === targetPath || currentPath.indexOf(targetPath + '/') === 0);
      item.classList.toggle('active', active);
    });
    if (document.body.id === 'category' || currentPath.indexOf('/produits') === 0) {
      var products = document.querySelector('#header .ets_mm_megamenu .cash-mega-products');
      if (products) products.classList.add('active');
    }
  }

  function initCashTheme() {
    initCashFaq();
    initCashServiceAnchors();
    initCashStickyHeader();
    initCashBlogLinks();
    initCashActiveMenu();
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initCashTheme);
  } else {
    initCashTheme();
  }
}());
