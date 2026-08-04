<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

function upgrade_module_1_18_0($module)
{
    return $module->upgradeTo180();
}
