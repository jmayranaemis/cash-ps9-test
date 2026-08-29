<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

function upgrade_module_1_21_0($module)
{
    return $module->upgradeTo1210();
}
