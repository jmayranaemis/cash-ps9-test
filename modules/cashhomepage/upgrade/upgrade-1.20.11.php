<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

function upgrade_module_1_20_11($module)
{
    return $module->repairSignatureCmsMarkup();
}
