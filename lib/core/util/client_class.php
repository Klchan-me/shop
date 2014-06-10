<?php
/**
 * @copyright (c) 2011 jooyea.cn
 * @file client_class.php
 * @brief 获取客户端数据信息
 * @author chendeshan
 * @date 2010-12-2
 * @version 0.6
 */

/**
 * @class IClient
 * @brief IClient 获取客户端信息
 */
class IClient
{
	/**
	 * @brief 获取客户端ip地址
	 * @return string 客户端的ip地址
	 */
	public static function getIp()
	{
	    $realip = NULL;
	    if(isset($_SERVER['HTTP_X_FORWARDED_FOR']))
	    {
	    	$ipArray = explode(',', $_SERVER['HTTP_X_FORWARDED_FOR']);
	    	foreach($ipArray as $rs)
	    	{
	    		$rs = trim($rs);
	    		if($rs != 'unknown')
	    		{
	    			$realip = $rs;
	    			break;
	    		}
	    	}
	    }
	    else if(isset($_SERVER['HTTP_CLIENT_IP']))
	    {
	    	$realip = $_SERVER['HTTP_CLIENT_IP'];
	    }
	    else
	    {
	    	$realip = $_SERVER['REMOTE_ADDR'];
	    }

	    preg_match("/[\d\.]{7,15}/", $realip, $match);
	    $realip = !empty($match[0]) ? $match[0] : '0.0.0.0';
	    return $realip;
	}

	/**
	 * @brief 获取客户端浏览的上一个页面的url地址
	 * @return string 客户端上一个访问的url地址
	 */
	public static function getPreUrl()
	{
		return $_SERVER['HTTP_REFERER'];
	}

	/**
	 * @brief 获取客户端当前访问的时间戳
	 * @return int 时间戳
	 */
	public static function getTime()
	{
		if(IServer::isGeVersion('5.1.0'))
			return $_SERVER['REQUEST_TIME'];
		else
			return time();
	}

	/**
	 * @brief 获取客户设备类型
	 * @return string pc,mobile
	 */
	public static function getDevice()
	{
		$agent = $_SERVER['HTTP_USER_AGENT'];
		$mobileList = array('Android','iPhone');

		foreach($mobileList as $val)
		{
			if(stripos($agent,$val) !== false)
			{
				return 'mobile';
			}
		}
		return 'pc';
	}
}
?>