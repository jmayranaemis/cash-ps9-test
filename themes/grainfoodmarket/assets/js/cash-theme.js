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
        var isOpen = item.classList.toggle('is-open');
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

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initCashFaq);
  } else {
    initCashFaq();
  }
}());
