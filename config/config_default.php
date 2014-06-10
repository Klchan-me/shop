<?php
return array(
	'logs'=>array(
		'path'=>'logs/log',
		'type'=>'file'
	),
	'DB'=>array(
		'type'=>'mysql',
        'tablePre'=>'{TABLE_PREFIX}',
		'read'=>array(
			array('host'=>'{DB_R_ADDRESS}','user'=>'{DB_R_USER}','passwd'=>'{DB_R_PWD}','name'=>'{DB_R_NAME}'),
		),

		'write'=>array(
			'host'=>'{DB_W_ADDRESS}','user'=>'{DB_W_USER}','passwd'=>'{DB_W_PWD}','name'=>'{DB_W_NAME}',
		),
	),
	'langPath' => 'language',
	'viewPath' => 'views',
	'skinPath' => 'skin',
    'classes' => 'classes.*',
    'rewriteRule' =>'url',
	'theme' => array('pc' => 'default'),
	'skin' => array('pc' => 'default'),
	'timezone'	=> 'Etc/GMT-8',
	'upload' => 'upload',
	'dbbackup' => 'backup/database',
	'safe' => 'cookie',
	'safeLevel' => 'none',
	'lang' => 'zh_sc',
	'debug'=> false,
	'configExt'=> array('site_config'=>'config/site_config.php'),
	'encryptKey'=>'{ENCRYPTKEY}',
);
?>