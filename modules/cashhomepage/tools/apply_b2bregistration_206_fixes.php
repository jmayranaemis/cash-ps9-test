<?php
/**
 * Compatibility fixes for FMM B2B Registration 2.0.6 on PrestaShop 9.
 *
 * The vendor module is not committed to this repository. This idempotent
 * patcher adjusts the installed copy and deliberately fails if the expected
 * vendor code has changed, so a module update cannot silently undo the fixes.
 */

if ('cli' !== PHP_SAPI) {
    exit(1);
}

$checkOnly = in_array('--check', $argv, true);
$modulesRoot = dirname(__DIR__, 2);
$prestashopRoot = dirname($modulesRoot);
$patches = [
    $prestashopRoot . '/classes/Mail.php' => [
        [
            'from' => "                'PS_MAIL_SERVER',\n"
                . "                'PS_MAIL_USER',",
            'to' => "                'PS_MAIL_SERVER',\n"
                . "                'PS_MAIL_DOMAIN',\n"
                . "                'PS_MAIL_USER',",
        ],
        [
            'from' => "                if (!isset(\$configuration['PS_MAIL_SMTP_ENCRYPTION']) || Tools::strtolower(\$configuration['PS_MAIL_SMTP_ENCRYPTION']) === 'off') {\n"
                . "                    \$isTls = false;\n"
                . "                } else {\n"
                . "                    \$isTls = true;\n"
                . "                }",
            'to' => "                \$smtpEncryption = isset(\$configuration['PS_MAIL_SMTP_ENCRYPTION'])\n"
                . "                    ? Tools::strtolower(\$configuration['PS_MAIL_SMTP_ENCRYPTION'])\n"
                . "                    : 'off';\n"
                . "                if ('off' === \$smtpEncryption) {\n"
                . "                    \$isTls = false;\n"
                . "                } elseif ('starttls' === \$smtpEncryption) {\n"
                . "                    // Let Symfony connect in plain SMTP, then negotiate STARTTLS after EHLO.\n"
                . "                    \$isTls = null;\n"
                . "                } else {\n"
                . "                    // Preserve PrestaShop's existing implicit TLS behaviour for other values.\n"
                . "                    \$isTls = true;\n"
                . "                }",
        ],
        [
            'from' => "                ))\n"
                . "                    ->setUsername(\$configuration['PS_MAIL_USER'])",
            'to' => "                ))\n"
                . "                    ->setLocalDomain(!empty(\$configuration['PS_MAIL_DOMAIN'])\n"
                . "                        ? \$configuration['PS_MAIL_DOMAIN']\n"
                . "                        : \$shop->domain)\n"
                . "                    ->setUsername(\$configuration['PS_MAIL_USER'])",
        ],
    ],
    $modulesRoot . '/anblog/libs/Helper.php' => [
        [
            'from' => "        \$params = array_merge(\$params, \$params1);\n"
                . "        return \$this->getModuleLink('module-anblog-blog', 'blog', \$params, null, \$id_lang);",
            'legacy' => "        \$params = array_merge(\$params, \$params1);\n"
                . "        if (Configuration::get('PS_REWRITING_SETTINGS') && !empty(\$params['rewrite'])) {\n"
                . "            /*\n"
                . "             * PrestaShop 9 evaluates its generic product route before this\n"
                . "             * module route. Use the unambiguous native module endpoint.\n"
                . "             */\n"
                . "            return \$this->getLinkObject()->getBaseLink()\n"
                . "                . 'module/anblog/blog?rewrite=' . rawurlencode(\$params['rewrite']);\n"
                . "        }\n"
                . "\n"
                . "        return \$this->getModuleLink('module-anblog-blog', 'blog', \$params, null, \$id_lang);",
            'to' => "        \$params = array_merge(\$params, \$params1);\n"
                . "        if (Configuration::get('PS_REWRITING_SETTINGS') && !empty(\$params['rewrite'])) {\n"
                . "            /*\n"
                . "             * PrestaShop 9 evaluates its generic product route before this\n"
                . "             * module route. Use the unambiguous native module endpoint.\n"
                . "             */\n"
                . "            \$rewrite = \$params['rewrite'];\n"
                . "            if (is_array(\$rewrite)) {\n"
                . "                \$languageId = \$id_lang ?: (int) Context::getContext()->language->id;\n"
                . "                \$rewrite = \$rewrite[\$languageId] ?? reset(\$rewrite);\n"
                . "            }\n"
                . "\n"
                . "            return \$this->getLinkObject()->getBaseLink()\n"
                . "                . 'module/anblog/blog?rewrite=' . rawurlencode((string) \$rewrite);\n"
                . "        }\n"
                . "\n"
                . "        return \$this->getModuleLink('module-anblog-blog', 'blog', \$params, null, \$id_lang);",
        ],
    ],
    $modulesRoot . '/b2bregistration/controllers/admin/AdminB2BCustomers.php' => [
        [
            'from' => '            } elseif (empty($website)) {' . "\n"
                . '                $this->context->controller->errors[] = $this->trans(' . "\n"
                . "                    'Please enter website link'" . "\n"
                . '                );',
            'to' => "            } elseif (Configuration::get('B2BREGISTRATION_WEBSITE_ENABLE_DISABLE') && empty(\$website)) {\n"
                . '                $this->context->controller->errors[] = $this->trans(' . "\n"
                . "                    'Please enter website link'" . "\n"
                . '                );',
        ],
        [
            'from' => '                $this->module->validateB2bFields($customFields);',
            'to' => '                $this->module->validateB2bFields($customFields, $id_customer);',
        ],
    ],
    $modulesRoot . '/b2bregistration/b2bregistration.php' => [
        [
            'from' => '    public function validateB2bFields($fields)' . "\n"
                . '    {' . "\n"
                . '        if (isset($fields) && $fields) {' . "\n"
                . '            $objModel = new BToBCustomFields();' . "\n"
                . '            $result = $objModel->fieldValidate($fields);',
            'to' => '    public function validateB2bFields($fields, $id_customer = null)' . "\n"
                . '    {' . "\n"
                . '        if (isset($fields) && $fields) {' . "\n"
                . '            $objModel = new BToBCustomFields();' . "\n"
                . '            $result = $objModel->fieldValidate($fields, $id_customer);',
        ],
    ],
    $modulesRoot . '/b2bregistration/models/b2bCustomFields.php' => [
        [
            'from' => '            if (!empty($this->getAllFields($id_customer))) {' . "\n"
                . '                $this->deleteCustomerData($id_customer);' . "\n"
                . '            }',
            'to' => '            if (!empty($this->getAllFields($id_customer))) {' . "\n"
                . "                \$fileFieldIds = array_merge(\n"
                . "                    self::getFieldIdByType('image'),\n"
                . "                    self::getFieldIdByType('attachment')\n"
                . "                );\n"
                . "                \$where = 'id_customer = ' . (int) \$id_customer;\n"
                . "                if (\$fileFieldIds) {\n"
                . "                    \$where .= ' AND id_bb_registration_fields NOT IN ('\n"
                . "                        . implode(',', array_map('intval', \$fileFieldIds)) . ')';\n"
                . "                }\n"
                . "                Db::getInstance()->delete('bb_registration_userdata', \$where);\n"
                . '            }',
        ],
    ],
];

foreach ($patches as $path => $filePatches) {
    if (!is_file($path) || !is_readable($path) || !is_writable($path)) {
        throw new RuntimeException('B2B patch target is unavailable: ' . $path);
    }

    $contents = file_get_contents($path);
    $changed = false;

    foreach ($filePatches as $patch) {
        $occurrences = substr_count($contents, $patch['from']);
        if (1 === $occurrences) {
            $contents = str_replace($patch['from'], $patch['to'], $contents);
            $changed = true;
        } elseif (false === strpos($contents, $patch['to'])) {
            $legacyOccurrences = isset($patch['legacy']) ? substr_count($contents, $patch['legacy']) : 0;
            if (1 === $legacyOccurrences) {
                $contents = str_replace($patch['legacy'], $patch['to'], $contents);
                $changed = true;
            } else {
                throw new RuntimeException('Vendor code changed; patch aborted for ' . $path);
            }
        }
    }

    if ($changed && !$checkOnly && false === file_put_contents($path, $contents, LOCK_EX)) {
        throw new RuntimeException('Unable to write B2B patch target: ' . $path);
    }

    echo basename($path)
        . ($changed ? ($checkOnly ? ': patch ready' : ': patched') : ': already patched')
        . PHP_EOL;
}
