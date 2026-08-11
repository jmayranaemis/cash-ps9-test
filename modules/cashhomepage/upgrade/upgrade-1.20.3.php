<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

function upgrade_module_1_20_3($module)
{
    return $module->upgradeTo1203();
}
