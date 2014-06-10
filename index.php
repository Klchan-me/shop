<?php
$iweb = dirname(__FILE__)."/lib/iweb.php";
$config = dirname(__FILE__)."/config/config.php";
require($iweb);
IWeb::createWebApp($config)->run();
?>