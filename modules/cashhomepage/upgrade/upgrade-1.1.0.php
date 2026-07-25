<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

function upgrade_module_1_1_0($module)
{
    return $module->registerHook('displayNav1')
        && $module->registerHook('displayNav2')
        && $module->registerHook('displayNav3')
        && $module->upgradeTo110();
}
