<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

function upgrade_module_1_20_10($module)
{
    return $module->ensureSignatureCmsPages()
        && $module->migrateSignatureCmsContent();
}
