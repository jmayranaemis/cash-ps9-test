# Cash Alimentaire - PrestaShop 9 test

Code versionne pour la refonte Cash Alimentaire sur PrestaShop 9.

## Environnements

- Test: https://test.cash-alimentaire.com
- VPS: `prod-vps`
- Racine PrestaShop: `/srv/www/cash-ps9-test`
- Stack Docker: `/srv/docker/cash-ps9-test`
- Conteneur PHP: `cash_ps9_test_php`

## Contenu du depot

- `themes/`: themes PrestaShop recuperes depuis le VPS
- `modules/`: modules PrestaShop recuperes depuis le VPS
- `override/`: overrides PrestaShop
- `docker/`: configuration Docker/Nginx/PHP du test, sans `.env`

Les fichiers runtime, caches, medias, vendors racine et secrets ne sont pas versionnes.

## Flux propose

- `develop`: branche de travail et deploiement test
- `main`: branche stable

Le workflow `.github/workflows/deploy-test.yml` reprend le principe du depot SPOC: rsync des dossiers utiles vers le VPS, controle de sentinelle, puis cache clear/warmup et healthcheck.

Secrets GitHub attendus pour l'environnement `test`:

- `SSH_HOST`
- `SSH_USER`
- `SSH_KEY`
- `SSH_PATH_ROOT`
- `DOCKER_PHP_CONTAINER`
- `HEALTHCHECK_URL`

Avant d'activer le deploiement CI, verifier que la sentinelle existe sur le VPS:

```bash
touch /srv/www/cash-ps9-test/.allow-ci-sync
```
