<?php
/**
 * @copyright (c) 2011 jooyea
 * @file Proxy.php
 * @brief 代理处理
 * @author nswe
 * @date 2013/8/3 16:46:20
 * @version 1.0.0
 */
class Proxy
{
	//升级URL
	const UPDATE_URL = 'http://product.aircheng.com/index.php?';

	/**
	 * 与远程服务器发送数据
	 * @param string $query 查询字符串
	 * @return array
	 */
	private static function send($query = '')
	{
		$url = self::UPDATE_URL . $query;
		if(($return = file_get_contents($url)) && ($return = JSON::decode($return)))
		{
			return $return;
		}
	}

	/**
	 * 获取本地版本信息
	 * @return String
	 */
	public static function getLocalVersion()
	{
		return include(IWeb::$app->getBasePath().'docs/version.php');
	}

	/**
	 * 获取远程版本信息
	 * @return String
	 */
	public static function getRemoteVersion()
	{
		$return = self::send('_c=system&_a=version');
		return isset($return['version']) ? $return['version'] : null;
	}

	/**
	 * 获取版权信息,存储到缓存中进行比对
	 * @return boolean
	 */
	public static function getAuthorize()
	{
		$iwebshopAuthorize = ISafe::get('iwebshopAuthorize');
		if($iwebshopAuthorize === null)
		{
			$return = self::send('_c=system&_a=authorize&host='.IUrl::getHost());
			$iwebshopAuthorize = isset($return['success']) && $return['success'] == 1 ? true : false;
			ISafe::set('iwebshopAuthorize',$iwebshopAuthorize);
		}
		return $iwebshopAuthorize;
	}
}