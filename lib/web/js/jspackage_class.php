<?php
/**
 * @copyright Copyright(c) 2010 jooyea.cn
 * @file jspackage_class.php
 * @brief 系统JS包加载类文件
 * @author webning
 * @date 2010-12-22
 * @version 0.6
 */

 /**
  * @class IJSPackage
  * @brief IJSPackage 系统JS加载类
  */
class IJSPackage
{
	//系统JS注册表
	private static $JSPackages = array(
		'jquery' => array(
			'js' => array(
				'jquery/jquery-1.9.0.min.js',
				'jquery/jquery-migrate-1.2.1.min.js'
			)
		),

		'form' => array('js' => 'form/form.js'),

		'dialog' => array(
			'js' => array(
				'artdialog/artDialog.js',
				'artdialog/plugins/iframeTools.js'
			),
			'css' => 'artdialog/skins/default.css'
		),

		'kindeditor' => array(
			'js' => array(
				'editor/kindeditor-min.js',
				'editor/lang/zh_CN.js'
			),
			'callback' => 'initKindEditior'
		),

		'validate' => array(
			'js'=>'autovalidate/validate.js',
			'css'=>'autovalidate/style.css'
		),

		'my97date' => array('js' => 'my97date/wdatepicker.js'),

		'artTemplate' => array(
			'js' => array(
				'artTemplate/artTemplate.js',
				'artTemplate/artTemplate-plugin.js'
			)
		),
		'cookie' => array('js' => 'cookie/jquery.cookie.js'),
	);

	/**
	 * @brief 加载系统的JS方法
	 * @param $name    string
	 * @param $charset string
	 * @return String
	 */
	public static function load($name,$charset='UTF-8')
	{
		if(!isset(self::$JSPackages[$name]))
		{
			return '';
		}

		$dir = self::getFileOrDir(self::$JSPackages[$name]);

		//如果没有创建就开始拷贝文件
		if(!file_exists(IWeb::$app->getRuntimePath().'systemjs/'.$dir))
		{
			IFile::xcopy(IWEB_PATH.'web/js/source/'.$dir,IWeb::$app->getRuntimePath().'systemjs/'.$dir);
		}

		$webjspath    = IWeb::$app->getWebRunPath().'systemjs/';
		$resultString = '';

		foreach(self::$JSPackages[$name] as $key => $val)
		{
			switch($key)
			{
				case "js":
				{
					if(is_array($val))
					{
						foreach($val as $file)
						{
							$resultString .= self::getJsHtml($webjspath.$file,$charset);
						}
					}
					else
					{
						$resultString .= self::getJsHtml($webjspath.$val,$charset);
					}
				}
				break;

				case "css":
				{
					if(is_array($val))
					{
						foreach($val as $file)
						{
							$resultString .= self::getCssHtml($webjspath.$file,$charset);
						}
					}
					else
					{
						$resultString .= self::getCssHtml($webjspath.$val,$charset);
					}
				}
				break;

				case "callback":
				{
					$resultString .= call_user_func(array('IJSPackage',$val));
				}
				break;
			}
		}

		return $resultString;
	}

	/**
	 * 获取文件或者目录
	 */
	private static function getFileOrDir($pathInfo)
	{
		if(is_array($pathInfo))
		{
			return self::getFileOrDir(current($pathInfo));
		}
		else
		{
			return dirname($pathInfo);
		}
	}

	/**
	 * @brief 获取JS的html
	 */
	private static function getJsHtml($fileName,$charset)
	{
		return '<script type="text/javascript" charset="'.$charset.'" src="'.$fileName.'"></script>';
	}

	/**
	 * @brief 获取CSS的html
	 */
	private static function getCssHtml($fileName,$charset)
	{
		return '<link rel="stylesheet" type="text/css" href="'.$fileName.'" />';
	}

	/**
	 * @brief 输出脚本
	 */
	private static function getCallback($functionName)
	{
		return '<script type="text/javascript" charset="'.$charset.'">'.$code.'</script>';
	}

	/**
	 * @brief kindeditor的参数设置
	 */
	private static function initKindEditior()
	{
		$result = '<script type="text/javascript">';
		$result.= 'window.KindEditor.options.uploadJson = "'.IUrl::creatUrl('/pic/upload_json').'";';
		$result.= 'window.KindEditor.options.fileManagerJson = "'.IUrl::creatUrl('/pic/file_manager_json').'";';
		$result.= '</script>';
		return $result;
	}
}