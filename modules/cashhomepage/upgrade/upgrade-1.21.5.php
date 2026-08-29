<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

function upgrade_module_1_21_5($module)
{
    return $module->upgradeTo1215();
}
