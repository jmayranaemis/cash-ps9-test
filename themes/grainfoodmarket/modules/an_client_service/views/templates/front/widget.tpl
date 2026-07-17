{*
* 2021 Anvanto
*
* NOTICE OF LICENSE
*
* This file is not open source! Each license that you purchased is only available for 1 wesite only.
* If you want to use this file on more websites (or projects), you need to purchase additional licenses.
* You are not allowed to redistribute, resell, lease, license, sub-license or offer our resources to any third party.
*
*  @author Anvanto <anvantoco@gmail.com>
*  @copyright  2021 Anvanto
*  @license    Valid for 1 website (or project) for each purchase of license
*  International Registered Trademark & Property of Anvanto
*}

<div id="_desktop_clientservice">
    <div class="clientservice_sg-cover"></div>
    <div class="mobile_item_wrapper">
        <span>{$config_title|escape:'htmlall':'UTF-8'}</span>
        <span class="mobile-toggler">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              xmlns:xlink="http://www.w3.org/1999/xlink"
              width="5px" height="9px">
             <path fill-rule="evenodd"  fill="rgb(0, 0, 0)"
              d="M4.913,4.292 L0.910,0.090 C0.853,0.030 0.787,-0.000 0.713,-0.000 C0.639,-0.000 0.572,0.030 0.515,0.090 L0.086,0.541 C0.029,0.601 -0.000,0.670 -0.000,0.749 C-0.000,0.827 0.029,0.896 0.086,0.956 L3.462,4.500 L0.086,8.044 C0.029,8.104 -0.000,8.173 -0.000,8.251 C-0.000,8.330 0.029,8.399 0.086,8.459 L0.515,8.910 C0.572,8.970 0.639,9.000 0.713,9.000 C0.787,9.000 0.853,8.970 0.910,8.910 L4.913,4.707 C4.970,4.647 4.999,4.578 4.999,4.500 C4.999,4.422 4.970,4.353 4.913,4.292 Z"/>
             </svg>
        </span>
    </div>
    <div class="adropdown-mobile clientservice_sg-modal">
        <div class="an_clientservice">
            <i class="material-icons clientservice_sg-btn-close">clear</i>
            <div class="h4 clientservice-title">{$config_title|escape:'htmlall':'UTF-8'}</div>
            {foreach from=$blocks item=block}
                <div class="clientservice-item">
                    <div class="h4"><img src="{$block.file_name nofilter}"> {$block.client_service_title|escape:'htmlall':'UTF-8'}</div>
                    {$block.client_service_text nofilter}
                </div>
            {/foreach}
        </div>
    </div>
    <div class="clientservice_open-modal-btn">
        <svg
         xmlns="http://www.w3.org/2000/svg"
         xmlns:xlink="http://www.w3.org/1999/xlink"
         width="21px" height="21px">
        <path fill-rule="evenodd"  fill="rgb(0, 0, 0)"
         d="M10.500,21.000 C4.710,21.000 -0.000,16.290 -0.000,10.500 C-0.000,4.710 4.710,0.000 10.500,0.000 C16.290,0.000 21.000,4.710 21.000,10.500 C21.000,16.290 16.290,21.000 10.500,21.000 ZM10.500,1.312 C5.434,1.312 1.312,5.434 1.312,10.500 C1.312,15.566 5.434,19.688 10.500,19.688 C15.566,19.688 19.687,15.566 19.687,10.500 C19.687,5.434 15.566,1.312 10.500,1.312 ZM11.595,10.748 C11.332,10.840 11.156,11.089 11.156,11.367 L11.156,12.250 C11.156,12.612 10.862,12.906 10.500,12.906 C10.138,12.906 9.844,12.612 9.844,12.250 L9.844,11.366 C9.844,10.533 10.372,9.787 11.158,9.509 C12.204,9.141 12.906,8.027 12.906,7.219 C12.906,5.891 11.827,4.812 10.500,4.812 C9.173,4.812 8.094,5.891 8.094,7.219 C8.094,7.581 7.800,7.875 7.437,7.875 C7.075,7.875 6.781,7.581 6.781,7.219 C6.781,5.169 8.449,3.500 10.500,3.500 C12.551,3.500 14.219,5.169 14.219,7.219 C14.219,8.678 13.066,10.228 11.595,10.748 ZM10.500,14.875 C10.983,14.875 11.375,15.267 11.375,15.750 C11.375,16.233 10.983,16.625 10.500,16.625 C10.017,16.625 9.625,16.233 9.625,15.750 C9.625,15.267 10.017,14.875 10.500,14.875 Z"/>
        </svg>
        <span class="hiddem-sm-down clientservice_open-modal-btn-text">{$config_title|escape:'htmlall':'UTF-8'}</span>
    </div>
</div>