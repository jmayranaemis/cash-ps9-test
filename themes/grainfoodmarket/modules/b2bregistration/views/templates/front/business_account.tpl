{extends file='page.tpl'}

{block name='page_title'}Devenir client professionnel{/block}

{block name='page_content'}
  <section class="cash-b2b">
    <header class="cash-b2b__intro">
      <p class="cash-b2b__eyebrow">Demande d’ouverture de compte</p>
      <h1>Devenez client Cash Alimentaire</h1>
      <p>Transmettez vos informations professionnelles. Votre compte ne sera ouvert qu’après vérification de votre SIRET et de votre extrait Kbis.</p>
      <div class="cash-b2b__steps" aria-label="Étapes de la demande">
        <span class="is-active"><b>1</b> Votre demande</span>
        <span><b>2</b> Validation par notre équipe</span>
        <span><b>3</b> Ouverture du compte</span>
      </div>
    </header>

    <form id="customer-form" class="cash-b2b__form" method="post" enctype="multipart/form-data" action="{$url_link|escape:'htmlall':'UTF-8'}">
      <input type="hidden" name="id_profile" value="{$id_profile|intval}">
      <input type="hidden" name="password" id="cash-pending-password" value="">
      <input type="hidden" name="confirm_password" id="cash-pending-confirm-password" value="">
      <input type="hidden" name="address_alias" value="Établissement principal">
      <input type="hidden" name="id_country" value="{$selected_country_id|default:8|intval}">
      <input type="hidden" name="terms" value="1">

      <div id="b2b_registation_required" class="alert alert-danger error" style="display:none;"></div>

      <fieldset>
        <legend><span>1</span> Votre établissement</legend>
        <div class="cash-b2b__grid">
          <div class="form-group cash-b2b__wide">
            <label for="company-name">Entreprise <sup>*</sup></label>
            <input required type="text" name="company_name" id="company-name" class="form-control" autocomplete="organization" value="{if !empty($smarty.post.company_name)}{$smarty.post.company_name|escape:'htmlall':'UTF-8'}{/if}">
          </div>
          <div class="form-group">
            <label for="identification-number">SIRET (14 chiffres) <sup>*</sup></label>
            <input required type="text" inputmode="numeric" minlength="14" maxlength="14" pattern="[0-9]+" name="identification_number" id="identification-number" class="form-control" autocomplete="off" value="{if !empty($smarty.post.identification_number)}{$smarty.post.identification_number|escape:'htmlall':'UTF-8'}{/if}">
            <small id="cash-siret-help">Un contrôle de cohérence est effectué avant l’envoi.</small>
          </div>
          <div class="form-group">
            <label for="postcode">Code postal <sup>*</sup></label>
            <input required type="text" inputmode="numeric" name="postcode" id="postcode" class="form-control" autocomplete="postal-code" value="{if !empty($smarty.post.postcode)}{$smarty.post.postcode|escape:'htmlall':'UTF-8'}{/if}">
          </div>
          <div class="form-group">
            <label for="city">Ville <sup>*</sup></label>
            <input required type="text" name="city" id="city" class="form-control" autocomplete="address-level2" value="{if !empty($smarty.post.city)}{$smarty.post.city|escape:'htmlall':'UTF-8'}{/if}">
          </div>
          <div class="form-group cash-b2b__wide">
            <label for="address">Adresse professionnelle <sup>*</sup></label>
            <input required type="text" name="address" id="address" class="form-control" autocomplete="street-address" value="{if !empty($smarty.post.address)}{$smarty.post.address|escape:'htmlall':'UTF-8'}{/if}">
          </div>
        </div>
      </fieldset>

      <fieldset>
        <legend><span>2</span> Votre contact</legend>
        <div class="cash-b2b__grid">
          <div class="form-group">
            <label for="first-name">Prénom <sup>*</sup></label>
            <input required type="text" name="first_name" id="first-name" class="form-control" autocomplete="given-name" value="{if !empty($smarty.post.first_name)}{$smarty.post.first_name|escape:'htmlall':'UTF-8'}{/if}">
          </div>
          <div class="form-group">
            <label for="last-name">Nom <sup>*</sup></label>
            <input required type="text" name="last_name" id="last-name" class="form-control" autocomplete="family-name" value="{if !empty($smarty.post.last_name)}{$smarty.post.last_name|escape:'htmlall':'UTF-8'}{/if}">
          </div>
          <div class="form-group">
            <label for="phone">Téléphone <sup>*</sup></label>
            <input required type="tel" name="phone" id="phone" class="form-control" autocomplete="tel" value="{if !empty($smarty.post.phone)}{$smarty.post.phone|escape:'htmlall':'UTF-8'}{/if}">
          </div>
          <div class="form-group">
            <label for="email">E-mail professionnel <sup>*</sup></label>
            <input required type="email" name="email" id="email" class="form-control" autocomplete="email" value="{if !empty($smarty.post.email)}{$smarty.post.email|escape:'htmlall':'UTF-8'}{/if}">
          </div>
        </div>
      </fieldset>

      {if $custom_fields AND $enable_custom}
        <fieldset>
          <legend><span>3</span> Votre activité et votre justificatif</legend>
          <div class="cash-b2b__custom">
            {$hook_create_account_form nofilter}
          </div>
        </fieldset>
      {/if}

      <div class="cash-b2b__consent">
        <label>
          <input required id="terms" name="cash_privacy" type="checkbox" value="1">
          <span>J’accepte que mes informations soient utilisées pour traiter ma demande d’ouverture de compte professionnel. <sup>*</sup></span>
        </label>
        {hook h='displayGDPRConsent' mod='psgdpr' id_module=$id_module}
      </div>

      <footer class="cash-b2b__footer">
        <p><strong>Et ensuite ?</strong><br>Votre demande sera contrôlée par notre équipe avant toute ouverture de compte.</p>
        <button class="btn btn-primary cash-b2b__submit" type="submit" id="b2b_add_data" name="b2b_add_data">Envoyer ma demande</button>
      </footer>
    </form>
  </section>

  <script>
    (function () {
      var form = document.getElementById('customer-form');
      var siret = document.getElementById('identification-number');
      var password = document.getElementById('cash-pending-password');
      var confirmation = document.getElementById('cash-pending-confirm-password');
      if (!form || !siret) return;

      form.addEventListener('submit', function () {
        var cleanSiret = siret.value.replace(/\s/g, '');
        siret.value = cleanSiret;
        var generated = 'Pending-' + Date.now() + '-' + Math.random().toString(36).slice(2) + '!A7';
        password.value = generated;
        confirmation.value = generated;
      });
      siret.addEventListener('input', function () {
        var digits = siret.value.replace(/\D/g, '').slice(0, 14);
        if (siret.value !== digits) siret.value = digits;
        siret.setCustomValidity('');
      });
    }());
  </script>
{/block}
