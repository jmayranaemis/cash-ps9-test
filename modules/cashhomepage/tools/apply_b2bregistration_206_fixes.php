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
        [
            'already' => "\$viewLink = \$baseLink . '&viewAttachment=1';",
            'from' => "                        if (\$field['field_type'] == 'attachment') {\n"
                . "                            \$input['display_image'] = true;\n"
                . "                            \$input['image'] = \$name ? '<img src=\"' . __PS_BASE_URI__ .\n"
                . "                            Tools::str_replace_once(_PS_ROOT_DIR_ . '/', '', \$name) .\n"
                . "                            '?time=' . time() . '\" alt=\"\" class=\"imgm img-thumbnail\" width=\"50%\"/>' : false;\n"
                . "                        } else {\n"
                . "                            if (\$name && file_exists(\$name) && \$field['id_bb_registration_fields']) {\n"
                . "                                \$link = \$this->context->link->getAdminLink('AdminB2BCustomers') .\n"
                . "                                '&downloadAttachment&id_bb_registration_fields=' .\n"
                . "                                \$field['id_bb_registration_fields'] . '&' .\n"
                . "                                \$this->identifier . '=' . Tools::getValue(\$this->identifier);\n"
                . "                                if (Configuration::get('PS_REWRITING_SETTINGS')) {\n"
                . "                                    \$link = Tools::strReplaceFirst('&', '?', \$link);\n"
                . "                                }\n"
                . "                                \$input['file'] = \$link ? \$link : null;\n"
                . "                            }\n"
                . "                        }\n"
                . "                        \$input['type'] = 'file';",
            'to' => "                        if (\$name && file_exists(\$name) && \$field['id_bb_registration_fields']) {\n"
                . "                            \$baseLink = \$this->context->link->getAdminLink('AdminB2BCustomers') .\n"
                . "                                '&id_bb_registration_fields=' . (int) \$field['id_bb_registration_fields'] . '&' .\n"
                . "                                \$this->identifier . '=' . (int) Tools::getValue(\$this->identifier);\n"
                . "\n"
                . "                            if (\$field['field_type'] == 'attachment') {\n"
                . "                                \$viewLink = \$baseLink . '&viewAttachment=1';\n"
                . "                                \$downloadLink = \$baseLink . '&downloadAttachment=1';\n"
                . "                                \$input['type'] = 'html';\n"
                . "                                \$input['html_content'] = '<a class=\"btn btn-default\" href=\"' .\n"
                . "                                    \$viewLink . '\" target=\"_blank\" rel=\"noopener\"><i class=\"icon-eye\"></i> ' .\n"
                . "                                    \$this->trans('View document') . '</a> ' .\n"
                . "                                    '<a class=\"btn btn-default\" href=\"' . \$downloadLink . '\"><i class=\"icon-download\"></i> ' .\n"
                . "                                    \$this->trans('Download document') . '</a><br><br>' .\n"
                . "                                    '<input type=\"file\" name=\"' . \$input['name'] . '\" id=\"file_' .\n"
                . "                                    (int) \$field['id_bb_registration_fields'] . '\">';\n"
                . "                            } else {\n"
                . "                                \$input['file'] = '<a class=\"btn btn-default\" href=\"' .\n"
                . "                                    \$baseLink . '&downloadAttachment=1\"><i class=\"icon-download\"></i> ' .\n"
                . "                                    \$this->trans('Download file') . '</a>';\n"
                . "                                \$input['type'] = 'file';\n"
                . "                            }\n"
                . "                        } else {\n"
                . "                            \$input['file'] = '<input type=\"file\" name=\"' . \$input['name'] . '\" id=\"file_' .\n"
                . "                                (int) \$field['id_bb_registration_fields'] . '\">';\n"
                . "                            \$input['type'] = 'file';\n"
                . "                        }\n"
                . "                        if (\$field['field_type'] != 'attachment') {\n"
                . "                            \$input['type'] = 'file';\n"
                . "                        }",
        ],
        [
            'already' => "if (Tools::isSubmit('viewAttachment') || Tools::isSubmit('downloadAttachment'))",
            'from' => "        if (Tools::isSubmit('downloadAttachment')) {\n"
                . "            \$b2bregistration = new BusinessAccountModel(Tools::getValue('id_b2bregistration'));\n"
                . "            \$id_bb_registration_fields = (int) Tools::getValue('id_bb_registration_fields');\n"
                . "            BToBCustomFields::downloadAttachment(\$id_bb_registration_fields, \$b2bregistration->id_customer);\n"
                . "        }",
            'to' => "        if (Tools::isSubmit('viewAttachment') || Tools::isSubmit('downloadAttachment')) {\n"
                . "            \$b2bregistration = new BusinessAccountModel(Tools::getValue('id_b2bregistration'));\n"
                . "            \$id_bb_registration_fields = (int) Tools::getValue('id_bb_registration_fields');\n"
                . "            BToBCustomFields::downloadAttachment(\n"
                . "                \$id_bb_registration_fields,\n"
                . "                \$b2bregistration->id_customer,\n"
                . "                Tools::isSubmit('viewAttachment')\n"
                . "            );\n"
                . "        }",
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
            'from' => "    public static function downloadAttachment(\$id_file, \$id_customer = null)\n"
                . "    {\n"
                . "        \$full_path = self::getFieldValue(\$id_file, \$id_customer);\n"
                . "        self::actionDownload(\$full_path);\n"
                . "    }\n"
                . "\n"
                . "    public static function actionDownload(\$full_path)",
            'to' => "    public static function downloadAttachment(\$id_file, \$id_customer = null, \$inline = false)\n"
                . "    {\n"
                . "        \$full_path = self::getFieldValue(\$id_file, \$id_customer);\n"
                . "        self::actionDownload(\$full_path, \$inline);\n"
                . "    }\n"
                . "\n"
                . "    public static function actionDownload(\$full_path, \$inline = false)",
        ],
        [
            'from' => "            header('Content-Disposition: attachment; filename=\"' .\n"
                . "                basename(\$full_path) . '\";');",
            'to' => "            header('Content-Disposition: ' . (\$inline ? 'inline' : 'attachment') . '; filename=\"' .\n"
                . "                basename(\$full_path) . '\";');",
        ],
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
        } elseif (false === strpos($contents, $patch['to'])
            && (!isset($patch['already']) || false === strpos($contents, $patch['already']))) {
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
