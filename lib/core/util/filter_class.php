<?php
/**
 * @copyright (c) 2011 jooyea.cn
 * @file filter_class.php
 * @brief 过滤库
 * @author chendeshan
 * @date 2010-12-2
 * @version 0.6
 */

/**
 * @class IFilter
 * @brief IFilter 过滤
 */
class IFilter
{
	/**
	 * @brief 过滤字符串的长度
	 * @param string $str 被限制的字符串
	 * @param int $length 限制的字节数
	 * @return string 空:超出限制值; $str:原字符串;
	 */
	public static function limitLen($str,$length)
	{
		if($length !== false)
		{
			$count = IString::getStrLen($str);
			if($count > $length)
			{
				return '';
			}
			else
			{
				return $str;
			}
		}
		return $str;
	}

	/**
	 * @brief 对字符串进行过滤处理
	 * @param  string $str      被过滤的字符串
	 * @param  string $type     过滤数据类型 值: int, float, string, text, bool, url
	 * @param  int    $limitLen 被输入的最大字符个数 , 默认不限制;
	 * @return string 被过滤后的字符串
	 * @note   默认执行的是string类型的过滤
	 */
	public static function act($str,$type = 'string',$limitLen = false)
	{
		if(is_array($str))
		{
			foreach($str as $key => $val)
			{
				$resultStr[$key] = self::act($val, $type, $limitLen);
			}
			return $resultStr;
		}
		else
		{
			switch($type)
			{
				case "int":
					return intval($str);
					break;

				case "float":
					return floatval($str);
					break;

				case "text":
					return self::text($str,$limitLen);
					break;

				case "bool":
					return (bool)$str;
					break;

				case "url":
					return self::clearUrl($str);
					break;

				case "filename":
					return self::fileName($str);
					break;

				default:
					return self::string($str,$limitLen);
					break;
			}
		}
	}

	/**
	 * @brief  对字符串进行严格的过滤处理
	 * @param  string  $str      被过滤的字符串
	 * @param  int     $limitLen 被输入的最大长度
	 * @return string 被过滤后的字符串
	 * @note 过滤所有html标签和php标签以及部分特殊符号
	 */
	public static function string($str,$limitLen = false)
	{
		$str = trim($str);
		$str = self::limitLen($str,$limitLen);
		$str = htmlspecialchars($str,ENT_NOQUOTES);
		return self::addSlash($str);
	}

	/**
	 * @brief 对字符串进行普通的过滤处理
	 * @param string $str      被过滤的字符串
	 * @param int    $limitLen 限定字符串的字节数
	 * @return string 被过滤后的字符串
	 * @note 仅对于部分如:<script,<iframe等标签进行过滤
	 */
	public static function text($str,$limitLen = false)
	{
		$str = self::limitLen($str,$limitLen);
		$str = trim($str);

		require_once(dirname(__FILE__)."/htmlpurifier/HTMLPurifier.standalone.php");
		$cache_dir=IWeb::$app->getRuntimePath()."htmlpurifier/";

		if(!file_exists($cache_dir))
		{
			IFile::mkdir($cache_dir);
		}
		$config = HTMLPurifier_Config::createDefault();

		//配置 允许flash
		$config->set('HTML.SafeEmbed',true);
		$config->set('HTML.SafeObject',true);
		$config->set('Output.FlashCompat',true);

		//配置 缓存目录
		$config->set('Cache.SerializerPath',$cache_dir); //设置cache目录

		//允许<a>的target属性
		$def = $config->getHTMLDefinition(true);
		$def->addAttribute('a', 'target', 'Enum#_blank,_self,_target,_top');

		//过略掉所有<script>，<i?frame>标签的on事件,css的js-expression、import等js行为，a的js-href
		$purifier = new HTMLPurifier($config);
		return self::addSlash($purifier->purify($str));
	}

	/**
	 * @brief 增加转义斜线
	 * @param string $str 要转义的字符串
	 * @return string 转义后的字符串
	 */
	public static function addSlash($str)
	{
		if(is_array($str))
		{
			$resultStr = array();
			foreach($str as $key => $val)
			{
				$resultStr[$key] = self::addSlash($val);
			}
			return $resultStr;
		}
		else
		{
			return addslashes($str);
		}
	}

	/**
	 * @brief 增加转义斜线
	 * @param string $str 要转义的字符串
	 * @return string 转义后的字符串
	 */
	public static function stripSlash($str)
	{
		if(is_array($str))
		{
			$resultStr = array();
			foreach($str as $key => $val)
			{
				$resultStr[$key] = self::stripSlash($val);
			}
			return $resultStr;
		}
		else
		{
			return stripslashes($str);
		}
	}

	/**
	 * @brief 检测文件是否有可执行的代码
	 * @param string  $file 要检查的文件路径
	 * @return boolean 检测结果
	 */
	public static function checkHex($file)
	{
		$resource = fopen($file, 'rb');
		$fileSize = filesize($file);
		fseek($resource, 0);
		// 读取文件的头部和尾部
		if ($fileSize > 512)
		{
			$hexCode = bin2hex(fread($resource, 512));
			fseek($resource, $fileSize - 512);
			$hexCode .= bin2hex(fread($resource, 512));
		}
		// 读取文件的全部内容
		else
		{
			$hexCode = bin2hex(fread($resource, $fileSize));
		}
		fclose($resource);
		/* 匹配16进制中的 <% (  ) %> */
		/* 匹配16进制中的 <? (  ) ?> */
		/* 匹配16进制中的 <script  /script>  */
		if (preg_match("/(3c25.*?28.*?29.*?253e)|(3c3f.*?28.*?29.*?3f3e)|(3C534352495054.*?2F5343524950543E)|(3C736372697074.*?2F7363726970743E)/is", $hexCode))
		{
			return false;
		}
		else
		{
			return true;
		}
	}

	/**
	 * 清理URL地址栏中的危险字符，防止XSS注入攻击
	 * @param string $url
	 * @return string
	 */
	public static function clearUrl($url)
	{
		return str_replace(array('\'','"','&#',"\\"),'',$url);
	}

	/**
	 * @brief 过滤文件名称
	 * @param string $string 参数字符串
	 * @return string
	 */
	public static function fileName($string)
	{
		return str_replace(array('./','../','..'),'',$string);
	}
}