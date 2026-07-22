# Configuration Cash Alimentaire

Ce thème est préparé pour un site catalogue professionnel. Son installation applique automatiquement le mode catalogue, la palette Cash Alimentaire, les hooks utiles et les contenus de démonstration en français.

## Direction visuelle

La palette validée le 6 juillet 2026 associe l'identité brune historique de Cash Alimentaire à un rouge d'action et à des tons naturels.

| Rôle | Couleur | Usage |
| --- | --- | --- |
| Brun identitaire | `#432A19` | Logo, titres, textes forts, menu |
| Rouge d'action | `#D01719` | Boutons, promotions, liens actifs |
| Ivoire | `#FFF8F1` | Fonds de page, cartes, zones aérées |
| Beige | `#D9C5AD` | Blocs secondaires, séparateurs, pictogrammes |
| Vert olive | `#71735B` | Catégories, icônes, informations secondaires |
| Vert profond | `#24483D` | Footer, menu foncé, encadrés premium, survols |

Sur ordinateur, l'en-tête utilise une grille stable : logo à gauche, recherche au centre et zone utilitaire à droite.

## Parcours cible

1. Comprendre immédiatement l'offre destinée aux professionnels.
2. Entrer par une famille de produits.
3. Filtrer et consulter les fiches du catalogue.
4. Accéder aux catalogues interactifs ou téléchargeables.
5. Découvrir les services et preuves de confiance.
6. Envoyer une demande commerciale depuis une page contact pleine largeur.

Le panier, la wishlist, le compte client, le sélecteur de devise et les mécanismes d'urgence commerciale sont désactivés. Les prix sont masqués par défaut via le mode catalogue PrestaShop.

## Dépendances à fournir avant activation

Le package actuellement versionné contient les surcharges du thème mais pas le code de ses modules Anvanto. Le dossier `themes/grainfoodmarket/dependencies/` ne contient qu'un `index.php` et aucun module `an_*` n'est présent dans `modules/`.

Ajouter les modules distribués avec la licence du thème, notamment :

- `an_theme` et `an_theme_dashboard` ;
- `anmegamenu`, `an_homeslider`, `an_homecategories`, `an_homeproducts` ;
- `an_banners`, `an_advantages`, `an_client_service`, `an_trust_badges` ;
- `an_logo`, `an_brandslider`, `an_copyright`, `anscrolltop` ;
- les autres dépendances listées dans `config/theme.yml`.

Sans ces modules, PrestaShop ne peut pas terminer l'installation ni importer les JSON placés dans `assets/antheme/`.

## Contenus à finaliser dans le back-office

- Remplacer les visuels de démonstration du slider et des familles par les visuels Cash Alimentaire.
- Renseigner les liens réels des sept familles dans **Home Categories**.
- Créer la page **Catalogues** et y intégrer les versions interactives et PDF.
- Vérifier l'URL réécrite de la page contact ; les contenus importés utilisent `/nous-contacter`.
- Renseigner téléphone, horaires, adresse, zones de livraison et réseaux sociaux.
- Configurer le formulaire avec les motifs *Demande commerciale*, *Ouverture de compte*, *Catalogue* et *Autre demande*.
- Remplacer les textes de démonstration restants dans les langues autres que le français si elles sont activées.

## Contrôle après activation

1. Installer toutes les dépendances et activer `grainfoodmarket`.
2. Vider le cache PrestaShop et régénérer les miniatures.
3. Vérifier l'accueil, une catégorie, une fiche produit et le contact en desktop et mobile.
4. Confirmer l'absence de prix, panier et bouton d'ajout au panier pour un visiteur non connecté.
5. Tester la recherche, les filtres, les téléchargements de catalogues et l'envoi du formulaire.
