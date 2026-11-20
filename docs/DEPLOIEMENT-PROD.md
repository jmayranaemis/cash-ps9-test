# Déployer en production depuis VS Code

Le test se déploie tout seul à chaque envoi sur `develop`. La production, elle, ne part **jamais** toute seule : on la lance à la main, un module (ou le thème) à la fois.

## Mise en place — une seule fois

1. **Secrets GitHub.** Rien à faire : le workflow prod lit `SSH_HOST`, `SSH_USER` et `SSH_KEY` dans l'environnement GitHub `test` (même VPS, même clé). C'est pourquoi les déploiements prod apparaissent sous « test » dans l'historique GitHub. Le chemin et le conteneur de la prod sont écrits en clair dans le workflow.
2. **Sentinelle sur le VPS**, sans laquelle le workflow refuse de toucher à la prod :
   ```bash
   ssh root@137.74.47.113 touch /srv/www/cash-ps9-prod/.allow-ci-sync
   ```
   Pour bloquer tout déploiement prod plus tard : supprimer ce fichier.

## À chaque mise en production

1. Vérifier la modification sur https://test.cash-alimentaire.com.
2. Dans VS Code, panneau **GitHub Actions** (icône GitHub de la barre de gauche), ouvrir **Deploy to PROD** puis **Run workflow** :
   - branche : `develop` ;
   - **cible** : le nom du module (`cashhomepage`, `cashredirects`, `cashga4events`…) ou `theme` ;
   - **simulation** : cochée.
3. Ouvrir l'exécution terminée. Le résumé donne, sans rien avoir écrit :
   - la **version du module en prod** et celle du dépôt ;
   - les **scripts de mise à jour** que PrestaShop exécuterait pour passer de l'une à l'autre. Ils peuvent modifier la base : certains réécrivent le contenu de pages (Qui sommes-nous, Recrutement, Nos engagements, Équipe commerciale, Services) ou reconfigurent le menu. S'il y en a, le vrai déploiement s'arrête sans rien copier, sauf si la case **scripts_de_mise_a_jour** est cochée en connaissance de cause ;
   - la liste des **fichiers qui seraient remplacés**.
4. Si la liste correspond à ce qui est attendu, relancer en **décochant simulation** et en tapant `PROD` dans **confirmation**.

Le workflow copie alors les fichiers, met le module à jour, vide le cache et vérifie que le site répond.

## Ce que le workflow touche, et ce qu'il ne touche pas

Il remplace uniquement, dans le dossier choisi (`modules/<cible>/` ou `themes/grainfoodmarket/`), les fichiers qui diffèrent du dépôt. Il ne touche ni à la base (sauf scripts de mise à jour acceptés), ni aux produits, commandes, clients, images, ni aux autres modules.

## Ce que le workflow ne fait jamais

- déployer `override/` ou tout `modules/` d'un coup : des correctifs ont été posés directement sur la prod (override `Link.php` le 07/10, `lpsflipbook` le 18/11), un envoi global les écraserait ;
- supprimer un fichier présent en prod ;
- partir sans la sentinelle, sans la saisie `PROD`, ou depuis une autre branche que `develop` ou `main`.

**Lire la simulation avant chaque vrai déploiement.** Un fichier inattendu dans la liste signale une modification faite directement sur la prod : la reporter dans le dépôt avant de déployer.
