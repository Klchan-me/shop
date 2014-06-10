<?php return array (
  'logs' => 
  array (
    'path' => 'logs/log',
    'type' => 'file',
  ),
  'DB' => 
  array (
    'type' => 'mysql',
    'tablePre' => 'w_',
    'read' => 
    array (
      0 => 
      array (
        'host' => 'localhost:3306',
        'user' => 'root',
        'passwd' => '',
        'name' => 'webshop',
      ),
    ),
    'write' => 
    array (
      'host' => 'localhost:3306',
      'user' => 'root',
      'passwd' => '',
      'name' => 'webshop',
    ),
  ),
  'langPath' => 'language',
  'viewPath' => 'views',
  'skinPath' => 'skin',
  'classes' => 'classes.*',
  'rewriteRule' => 'url',
  'theme' => 'yixun',
  'skin' => 'default',
  'timezone' => 'Etc/GMT-8',
  'upload' => 'upload',
  'dbbackup' => 'backup/database',
  'safe' => 'cookie',
  'safeLevel' => 'none',
  'lang' => 'zh_sc',
  'debug' => false,
  'configExt' => 
  array (
    'site_config' => 'config/site_config.php',
  ),
  'encryptKey' => '82c4c73ed3faf2de920dfa6ab31f9240',
)?>