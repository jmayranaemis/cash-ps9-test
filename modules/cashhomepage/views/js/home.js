(function () {
  'use strict';

  function initCarousel(root) {
    var track = root.querySelector('[data-cash-carousel-track]');
    var previous = root.querySelector('[data-cash-carousel-prev]');
    var next = root.querySelector('[data-cash-carousel-next]');
    if (!track || !previous || !next) {
      return;
    }

    function distance() {
      var card = track.querySelector(':scope > *');
      if (!card) {
        return track.clientWidth;
      }
      var styles = window.getComputedStyle(track);
      return card.getBoundingClientRect().width + parseFloat(styles.columnGap || styles.gap || 0);
    }

    previous.addEventListener('click', function () {
      track.scrollBy({left: -distance(), behavior: 'smooth'});
    });
    next.addEventListener('click', function () {
      track.scrollBy({left: distance(), behavior: 'smooth'});
    });
  }

  function renderPdfCover(canvas) {
    if (!window.pdfjsLib || !canvas.dataset.cashPdfCover) {
      return;
    }

    window.pdfjsLib.GlobalWorkerOptions.workerSrc =
      '/modules/lpsflipbook/lib/dflip/js/libs/pdf.worker.min.js';
    window.pdfjsLib.getDocument(canvas.dataset.cashPdfCover).promise
      .then(function (pdf) { return pdf.getPage(1); })
      .then(function (page) {
        var initialViewport = page.getViewport({scale: 1});
        var viewport = page.getViewport({scale: 360 / initialViewport.height});
        var context = canvas.getContext('2d');
        canvas.width = Math.round(viewport.width);
        canvas.height = Math.round(viewport.height);
        return page.render({canvasContext: context, viewport: viewport}).promise;
      })
      .catch(function () {
        canvas.classList.add('cash-flipbook-card__pdf-cover--error');
      });
  }

  function createHomepageSlot(className) {
    var section = document.createElement('section');
    section.className = 'cash-section ' + className;
    return section;
  }

  function reorderHomepageBlocks() {
    var homepage = document.querySelector('.cash-home');
    if (!homepage) {
      return;
    }

    var catalogues = homepage.querySelector('.cash-catalogues');
    var hero = homepage.querySelector('.cash-hero');
    var productSelection = homepage.querySelector('.cash-product-selection');
    var services = homepage.querySelector('.cash-services');
    var client = homepage.querySelector('.cash-client');
    var brands = homepage.querySelector('.cash-brands');
    var proof = homepage.querySelector('.cash-proof');
    var blog = document.querySelector('#content > .anblog-widget');
    var newsletter = document.querySelector('#footer > .block_newsletter');

    if (!hero || !productSelection || !catalogues || !services || !client || !proof) {
      return;
    }

    hero.insertAdjacentElement('afterend', productSelection);

    var orderedBlocks = [services];

    if (blog) {
      var blogSlot = createHomepageSlot('cash-home-blog');
      blogSlot.appendChild(blog);
      orderedBlocks.push(blogSlot);
    }

    orderedBlocks.push(client);

    if (brands) {
      orderedBlocks.push(brands);
    }

    orderedBlocks.push(proof);

    if (newsletter) {
      var newsletterSlot = createHomepageSlot('cash-home-newsletter');
      newsletterSlot.appendChild(newsletter);
      orderedBlocks.push(newsletterSlot);
    }

    var anchor = catalogues;
    orderedBlocks.forEach(function (block) {
      anchor.insertAdjacentElement('afterend', block);
      anchor = block;
    });
  }

  function initCashHomepage() {
    reorderHomepageBlocks();
    document.querySelectorAll('[data-cash-carousel]').forEach(initCarousel);
    document.querySelectorAll('[data-cash-pdf-cover]').forEach(renderPdfCover);

    document.addEventListener('click', function (event) {
      var opener = event.target.closest('[data-cash-open-catalogue]');
      if (!opener) {
        return;
      }

      var catalogue = document.getElementById(opener.getAttribute('data-cash-open-catalogue'));
      if (catalogue) {
        catalogue.click();
      }
    });
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initCashHomepage);
  } else {
    initCashHomepage();
  }
}());
