<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

function upgrade_module_1_20_0($module)
{
    return $module->ensureSignatureCmsPages();
}
