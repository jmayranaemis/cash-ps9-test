# Modifier les textes de la page d’accueil

1. Dans le back-office, ouvrir **Modules > Gestionnaire de modules**.
2. Rechercher **Accueil Cash Alimentaire**.
3. Cliquer sur **Configurer**.
4. Modifier les champs voulus puis cliquer sur **Enregistrer**.
5. Ouvrir la page d’accueil dans un nouvel onglet et l’actualiser.

Les textes principaux du hero, des preuves, des familles, des catalogues, des services, du bloc « Devenir client » et du bloc contact sont administrables ici.

## Ajouter ou changer une image (médiathèque)

Plus besoin de passer par le serveur : les images s’envoient depuis le back-office.

1. Ouvrir **Modules > Gestionnaire de modules > Accueil Cash Alimentaire > Configurer**.
2. Descendre jusqu’au bloc **Médiathèque — images du site**.
3. Choisir une ou plusieurs images (JPG, PNG ou WebP, 8 Mo maximum) puis cliquer sur **Envoyer**. Les photos de plus de 2 000 px de large sont réduites automatiquement.

Ensuite, selon l’usage :

- **Fond de la page d’accueil** : cliquer sur **Fond de l’accueil** en face de l’image. Le changement est immédiat.
- **Image dans une page** (Qui sommes-nous, Nos engagements…) : cliquer sur **Copier l’adresse**, ouvrir la page dans **Design > Pages**, cliquer sur le bouton **Image** de l’éditeur et coller l’adresse.

Une image utilisée en fond d’accueil ne peut pas être supprimée. Pour les autres, vérifier qu’elle n’est plus utilisée dans une page avant de la supprimer : la page afficherait sinon une image cassée.

Les images envoyées sont rangées dans `img/cms/cash/` sur le serveur, à l’abri des déploiements du module.

## Modifier les images des familles

1. Ouvrir **Catalogue > Catégories**.
2. Éditer la catégorie affichée dans « Nos familles de produits ».
3. Charger une **image de catégorie**, puis enregistrer.
4. Si l’image ne change pas immédiatement, aller dans **Paramètres avancés > Performances** et vider le cache.

Le carrousel utilise automatiquement l’image de la catégorie. Si elle est absente, il cherche l’image d’une sous-catégorie, puis affiche un visuel de remplacement pour éviter une carte vide.

## Modifier les catalogues

Le catalogue interactif reste géré dans le module Flipbook. Le bouton **Demander un catalogue** ouvre le formulaire de contact avec le motif **Demande de catalogue** déjà sélectionné.

## Modifier le méga-menu

Ouvrir **Modules > Mega Menu PRO > Configurer**. Le menu principal conserve uniquement les entrées de navigation. Les actions **Devenir client**, **FAQ**, **Contact** et **Magasins** restent dans le header marron pour éviter les doublons.
