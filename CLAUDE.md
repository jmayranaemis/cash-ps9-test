# Contexte projet — Cash Alimentaire, refonte PrestaShop 9 (test)

## Objet
Code versionné de la refonte Cash Alimentaire sur PrestaShop 9.

## Environnements
- Test : https://test.cash-alimentaire.com
- VPS : `prod-vps`
- Racine PrestaShop sur le VPS : `/srv/www/cash-ps9-test`
- Stack Docker sur le VPS : `/srv/docker/cash-ps9-test`
- Conteneur PHP : `cash_ps9_test_php`

## Contenu du dépôt
- `themes/` : thèmes récupérés depuis le VPS
- `modules/` : modules récupérés depuis le VPS
- `override/` : overrides PrestaShop
- `docker/` : config Docker/Nginx/PHP du test, SANS `.env` (voir `.env.example`)
- Fichiers runtime, caches, médias, vendors racine et secrets : non versionnés

## Flux Git
- `develop` : branche de travail et déploiement test
- `main` : branche stable

## Déploiement CI (.github/workflows/deploy-test.yml)
Principe identique au repo SPOC : rsync des dossiers utiles vers le VPS,
contrôle de sentinelle, puis cache clear/warmup et healthcheck.

Secrets GitHub attendus pour l'environnement `test` :
`SSH_HOST`, `SSH_USER`, `SSH_KEY`, `SSH_PATH_ROOT`, `DOCKER_PHP_CONTAINER`, `HEALTHCHECK_URL`

**IMPORTANT — sentinelle de sécurité** : le déploiement CI ne doit être activé
qu'après vérification que le fichier sentinelle existe sur le VPS :
```bash
touch /srv/www/cash-ps9-test/.allow-ci-sync
```
Sans ce fichier, le déploiement ne doit pas se déclencher. Ne jamais créer
cette sentinelle sans validation explicite de Jérôme.

## Documentation existante (docs/)
- atelier-ux-gestionnaires-cash-alimentaire.docx (atelier UX)
- benchmark-distribution-alimentaire-b2b.md
- TUTORIEL-MODIFIER-ACCUEIL.md

## Config .env
`.env.example` liste les variables attendues (PS_DEV_MODE, PS_DOMAIN,
DB_SERVER, DB_NAME, DB_USER, DB_PASS). Le vrai `.env` n'est jamais versionné —
ne jamais committer de valeurs réelles de secrets/mots de passe.

## Consignes pour Claude Code
- Toujours demander confirmation avant un `git push`
- Ne jamais toucher à la sentinelle `.allow-ci-sync` sans validation explicite
- Ne jamais committer `.env`, secrets, ou fichiers runtime
- Ne jamais modifier `.github/workflows/deploy-test.yml` sans validation explicite
- Un sujet = un commit, message clair

<!-- test migration Claude Code OK -->
