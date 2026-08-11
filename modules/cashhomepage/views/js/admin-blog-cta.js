(function () {
  'use strict';

  var templates = [
    {
      label: 'Devenir client',
      variant: 'primary',
      html: '<p class="cash-blog-cta"><a class="cash-blog-cta__button cash-blog-cta__button--primary" href="/b2b-customer-create">Devenir client <span aria-hidden="true">→</span></a></p>'
    },
    {
      label: 'Voir les catalogues',
      variant: 'secondary',
      html: '<p class="cash-blog-cta"><a class="cash-blog-cta__button cash-blog-cta__button--secondary" href="/catalogues-professionnels.html">Voir les catalogues <span aria-hidden="true">→</span></a></p>'
    },
    {
      label: 'Nous contacter',
      variant: 'outline',
      html: '<p class="cash-blog-cta"><a class="cash-blog-cta__button cash-blog-cta__button--outline" href="/nous-contacter">Nous contacter <span aria-hidden="true">→</span></a></p>'
    },
    {
      label: 'Nos magasins',
      variant: 'dark',
      html: '<p class="cash-blog-cta"><a class="cash-blog-cta__button cash-blog-cta__button--dark" href="/magasins">Découvrir nos magasins <span aria-hidden="true">→</span></a></p>'
    }
  ];

  var editorStyles = [
    '.cash-blog-cta{margin:28px 0;text-align:center}',
    '.cash-blog-cta__button{display:inline-flex;min-height:50px;gap:12px;align-items:center;justify-content:center;padding:13px 22px;border:2px solid transparent;border-radius:12px;font-weight:800;text-decoration:none}',
    '.cash-blog-cta__button--primary{color:#fff;background:#d01719}',
    '.cash-blog-cta__button--secondary{color:#fff;background:#24483d}',
    '.cash-blog-cta__button--outline{color:#432a19;border-color:#432a19;background:#fff8f1}',
    '.cash-blog-cta__button--dark{color:#fff;background:#432a19}'
  ].join('');

  function getContentTextareas() {
    return Array.prototype.slice.call(document.querySelectorAll('textarea')).filter(function (textarea) {
      var fieldName = textarea.name || textarea.id || '';
      return /^content(?:_|\[)/.test(fieldName);
    });
  }

  function isVisibleLanguage(textarea) {
    var languageField = textarea.closest('.translatable-field');
    if (!languageField) return true;
    return !languageField.classList.contains('d-none') && window.getComputedStyle(languageField).display !== 'none';
  }

  function getTinyMce() {
    return window.tinymce || window.tinyMCE || null;
  }

  function getTargetEditor(textareas) {
    var tiny = getTinyMce();
    if (!tiny) return null;
    if (tiny.activeEditor && textareas.some(function (textarea) { return textarea.id === tiny.activeEditor.id; })) {
      return tiny.activeEditor;
    }
    var target = textareas.find(isVisibleLanguage) || textareas[0];
    return target && target.id ? tiny.get(target.id) : null;
  }

  function installEditorPreview(editor) {
    if (!editor || !editor.getDoc) return;
    var doc = editor.getDoc();
    if (!doc || doc.getElementById('cash-blog-cta-editor-style')) return;
    var style = doc.createElement('style');
    style.id = 'cash-blog-cta-editor-style';
    style.textContent = editorStyles;
    doc.head.appendChild(style);
  }

  function styleEditors(textareas) {
    var tiny = getTinyMce();
    if (!tiny) return;
    textareas.forEach(function (textarea) {
      var editor = textarea.id ? tiny.get(textarea.id) : null;
      if (editor && editor.initialized) installEditorPreview(editor);
    });
  }

  function insertTemplate(template, textareas, status) {
    var editor = getTargetEditor(textareas);
    if (editor) {
      installEditorPreview(editor);
      editor.focus();
      editor.undoManager.transact(function () {
        editor.insertContent(template.html);
      });
      editor.nodeChanged();
      status.textContent = 'CTA « ' + template.label + ' » ajouté dans le contenu.';
      return;
    }

    var textarea = textareas.find(isVisibleLanguage) || textareas[0];
    if (!textarea) {
      status.textContent = 'Le champ Contenu est introuvable.';
      return;
    }
    var start = textarea.selectionStart || textarea.value.length;
    var end = textarea.selectionEnd || start;
    textarea.value = textarea.value.slice(0, start) + template.html + textarea.value.slice(end);
    textarea.dispatchEvent(new Event('input', { bubbles: true }));
    status.textContent = 'CTA « ' + template.label + ' » ajouté dans le contenu.';
  }

  function buildLibrary(textareas) {
    if (!textareas.length || document.querySelector('[data-cash-blog-cta-library]')) return;
    var fieldGroup = textareas[0].closest('.form-group');
    if (!fieldGroup || !fieldGroup.parentNode) return;

    var library = document.createElement('section');
    library.className = 'cash-blog-cta-library';
    library.setAttribute('data-cash-blog-cta-library', '');
    library.innerHTML = '<div class="cash-blog-cta-library__heading"><div><span>Bibliothèque éditoriale Cash</span><h3>Insérer un bouton d’action</h3></div><p>Cliquez sur un modèle pour l’ajouter à l’endroit du curseur dans le champ <strong>Contenu</strong>.</p></div><div class="cash-blog-cta-library__buttons"></div><p class="cash-blog-cta-library__status" aria-live="polite"></p>';

    var buttons = library.querySelector('.cash-blog-cta-library__buttons');
    var status = library.querySelector('.cash-blog-cta-library__status');
    templates.forEach(function (template) {
      var button = document.createElement('button');
      button.type = 'button';
      button.className = 'cash-blog-cta-library__button cash-blog-cta-library__button--' + template.variant;
      button.innerHTML = template.label + '<span aria-hidden="true">→</span>';
      button.addEventListener('click', function () {
        insertTemplate(template, textareas, status);
      });
      buttons.appendChild(button);
    });

    fieldGroup.parentNode.insertBefore(library, fieldGroup);
  }

  function init() {
    var attempts = 0;
    var timer = window.setInterval(function () {
      attempts += 1;
      var textareas = getContentTextareas();
      if (textareas.length) {
        buildLibrary(textareas);
        styleEditors(textareas);
      }
      if (attempts >= 40 || (textareas.length && getTargetEditor(textareas))) {
        window.clearInterval(timer);
        styleEditors(textareas);
      }
    }, 250);
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
}());
