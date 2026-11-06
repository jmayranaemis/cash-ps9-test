<?php
/**
 * Correspondances explicites pour les anciennes URL qui n'ont plus d'équivalent par ID.
 * 'paths'      : ancien chemin exact => nouveau chemin (relatif à la racine) ou URL absolue.
 * 'categories' : ancien libellé de catégorie présent dans les URL produit => rewrite de la catégorie actuelle.
 */
if (!defined('_PS_VERSION_')) {
    exit;
}

return [
    'paths' => [
        '/content/6-qui-sommes-nous' => '/content/a-propos',
        '/content/22-notre-offre' => '/content/services-cash-alimentaire',
        '/content/23-chronofresh' => '/content/services-cash-alimentaire',
        '/content/category/5-nos-catalogues' => '/produits.html',
    ],
    'categories' => [
        'frais' => 'produits-frais',
        'surgele' => 'produits-surgeles',
        'epicerie' => 'produits-epicerie-salee',
        'epicerie-sucree' => 'produits-epicerie-sucree',
        'fruits-legumes' => 'produits-fruits-legumes',
        'boissons-alcools' => 'produits-boissons-alcools',
        'hygiene' => 'produits-hygiene-emballage',
        'glaces-artisanales' => 'produits-surgeles',
    ],
];
