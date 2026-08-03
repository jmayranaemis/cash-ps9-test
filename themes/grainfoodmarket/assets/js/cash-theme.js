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
      var normalizedTitle = heading.textContent.trim().toLocaleLowerCase('fr')
        .normalize('NFD')
        .replace(/[\u0300-\u036f]/g, '');
      var anchor = serviceAnchors[normalizedTitle];

      if (anchor) {
        heading.id = anchor;
        heading.classList.add('cash-service-anchor');
      }
    });

    var requestedAnchor = decodeURIComponent(window.location.hash.replace(/^#/, ''));
    var target = requestedAnchor ? document.getElementById(requestedAnchor) : null;
    if (target) {
      window.requestAnimationFrame(function () {
        target.scrollIntoView({block: 'start'});
      });
    }
  }

  function initCashTheme() {
    initCashFaq();
    initCashServiceAnchors();
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initCashTheme);
  } else {
    initCashTheme();
  }
}());
