<?php
/**
 * @copyright Copyright(c) 2011 jooyea.cn
 * @file session_class.php
 * @brief session机制处理类
 * @author webning
 * @date 2011-02-24
 * @version 0.6
 */

 //开户session
if(!isset($_SESSION))
{
	session_start();
}

/**
 * @brief ISession 处理类
 * @class ISession
 * @note
 */
class ISession
{
	//session前缀
	private static $pre='iweb_';

	//安全级别
	private static $level = 'normal';

	//获取配置的前缀
	private static function getPre()
	{
		if(isset(IWeb::$app->config['safePre']))
		{
			return IWeb::$app->config['safePre'];
		}
		else
		{
			return self::$pre;
		}
	}

	//获取当前的安全级别
	private static function getLevel()
	{
		if(isset(IWeb::$app->config['safeLevel']))
		{
			return IWeb::$app->config['safeLevel'];
		}
		else
		{
			return self::$level;
		}
	}

	/**
	 * @brief 设置session数据
	 * @param string $name 字段名
	 * @param mixed $value 对应字段值
	 */
	public static function set($name,$value='')
	{
		self::$pre = self::getPre();
		if(self::checkSafe()==-1) $_SESSION[self::$pre.'safecode']=self::sessionId();
		$_SESSION[self::$pre.$name]=$value;
	}
    /**
     * @brief 获取session数据
     * @param string $name 字段名
     * @return mixed 对应字段值
     */
	public static function get($name)
	{
		self::$pre  = self::getPre();
		$is_checked = self::checkSafe();

		if($is_checked == 1)
		{
			return isset($_SESSION[self::$pre.$name])?$_SESSION[self::$pre.$name]:null;
		}
		else if($is_checked == 0)
		{
			self::clear(self::$pre.'safecode');
		}
		return null;
	}
    /**
     * @brief 清空某一个Session
     * @param mixed $name 字段名
     */
	public static function clear($name)
	{
		self::$pre = self::getPre();
		unset($_SESSION[self::$pre.$name]);
	}
    /**
     * @brief 清空所有Session
     */
	public static function clearAll()
	{
		return session_destroy();
	}

    /**
     * @brief Session的安全验证
     * @return int 1:通过验证,0:未通过验证
     */
	private static function checkSafe()
	{
		self::$pre = self::getPre();
		if(isset($_SESSION[self::$pre.'safecode']))
		{
			if($_SESSION[self::$pre.'safecode']==self::sessionId())
			{
				return 1;
			}
			else
			{
				return 0;
			}
		}
		else
		{
			return -1;
		}
	}
    /**
     * @brief 得到session安全码
     * @return String  session安全码
     */
	private static function sessionId()
	{
		$level = self::getLevel();
		if($level == 'none')
		{
			return '';
		}
		else if($level == 'normal')
		{
			return md5(IClient::getIP());
		}
		return md5(IClient::getIP().$_SERVER["HTTP_USER_AGENT"]);
	}
}
?>
