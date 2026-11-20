# Déployer en production depuis VS Code

Le test se déploie tout seul à chaque envoi sur `develop`. La production, elle, ne part **jamais** toute seule : on la lance à la main, un module (ou le thème) à la fois.

## Mise en place — une seule fois

1. **Secrets GitHub.** Le workflow prod n'utilise que `SSH_HOST`, `SSH_USER` et `SSH_KEY` — les mêmes que pour test, puisque test et prod sont sur le même VPS. S'ils sont rangés dans l'environnement `test` (GitHub > Settings > Environments > test), les recopier dans un environnement `prod`. S'ils sont au niveau du dépôt (Settings > Secrets and variables > Actions), il n'y a rien à faire.
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
3. Ouvrir l'exécution terminée : le résumé liste les fichiers qui **seraient** modifiés en prod. Rien n'a été écrit.
4. Si la liste correspond à ce qui est attendu, relancer en **décochant simulation** et en tapant `PROD` dans **confirmation**.

Le workflow copie alors les fichiers, met le module à jour, vide le cache et vérifie que le site répond.

## Ce que le workflow ne fait jamais

- déployer `override/` ou tout `modules/` d'un coup : des correctifs ont été posés directement sur la prod (override `Link.php` le 07/10, `lpsflipbook` le 18/11), un envoi global les écraserait ;
- supprimer un fichier présent en prod ;
- partir sans la sentinelle, sans la saisie `PROD`, ou depuis une autre branche que `develop` ou `main`.

**Lire la simulation avant chaque vrai déploiement.** Un fichier inattendu dans la liste signale une modification faite directement sur la prod : la reporter dans le dépôt avant de déployer.
