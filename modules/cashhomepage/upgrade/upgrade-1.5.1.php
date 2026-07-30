<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

function upgrade_module_1_5_1($module)
{
    return $module->upgradeTo151();
}
