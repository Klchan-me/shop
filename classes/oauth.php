<?php
/**
 * @copyright (c) 2011 jooyea.cn
 * @file oauth.php
 * @brief oauth协议登录接口
 * @author chendeshan
 * @date 2011-7-18 9:34:18
 * @version 0.6
 */

/**
 * @class Oauth
 * @brief oauth协议接口
 */
class Oauth
{
	private $oauthObj = null;

	//构造函数
	public function __construct($id)
	{
		$oauthRow = $this->getOauthRow($id);

		if($this->requireFile($oauthRow['file']))
		{
			$config   = unserialize($oauthRow['config']);
			$fileName = ucfirst($oauthRow['file']);
			$this->oauthObj = new $fileName($config);
		}
		else
		{
			return false;
		}
	}

	//获取字段数据
	public function getFields()
	{
		return $this->oauthObj->getFields();
	}

	//回调函数
	public function checkStatus($parms)
	{
		return $this->oauthObj->checkStatus($parms);
	}

	//获取平台的用户信息
	public function getUserInfo()
	{
		return $this->oauthObj->getUserInfo();
	}

	//获取登录url地址
	public function getLoginUrl()
	{
		return $this->oauthObj->getLoginUrl();
	}

	//获取令牌数据
	public function getAccessToken($parms)
	{
		return $this->oauthObj->getAccessToken($parms);
	}

	//根据id值获取数据库中的数据
	private function getOauthRow($id)
	{
		$oauthObj = new IModel('oauth');
		$oauthRow = $oauthObj->getObj('id = '.$id);
		return $oauthRow;
	}

	//引入平台接口文件
	private function requireFile($fileName)
	{
		$classFile = 'plugins/oauth/'.$fileName.'/'.$fileName.'.php';
		if(file_exists($classFile))
		{
			include_once($classFile);
			return true;
		}
		else
		{
			return false;
		}
	}
}
?>