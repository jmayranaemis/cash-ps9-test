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

  document.addEventListener('DOMContentLoaded', function () {
    document.querySelectorAll('[data-cash-carousel]').forEach(initCarousel);
  });
}());
