<?php
/**
 * @copyright (c) 2011 jooyea.cn
 * @file taobao.php
 * @brief taobao的oauth协议登录接口
 * @author chendeshan
 * @date 2011-7-18 9:34:18
 * @version 0.6
 */

/**
 * @class Taobao
 * @brief taobao的oauth协议接口
 */
class Taobao extends OauthBase
{
	private $apiKey    = '';
	private $apiSecret = '';

	public function __construct($config)
	{
		$this->apiKey    = $config['apiKey'];
		$this->apiSecret = $config['apiSecret'];
	}

	public function getFields()
	{
		return array(
			'apiKey' => array(
				'label' => 'apiKey',
				'type'  => 'string',
			),
			'apiSecret'=>array(
				'label' => 'apiSecret',
				'type'  => 'string',
			),
		);
	}

	//获取登录url地址
	public function getLoginUrl()
	{
		$url  = 'https://oauth.taobao.com/authorize?response_type=code';
		$url .= '&client_id='.$this->apiKey;
		$url .= '&redirect_uri='.urlencode(parent::getReturnUrl());
		return $url;
	}

	//获取进入令牌
	public function getAccessToken($parms)
	{
		$url           = 'https://oauth.taobao.com/token';
		$urlParmsArray = array(
			'grant_type'   => 'authorization_code',
			'code'         => $parms['code'],
			'redirect_uri' => urlencode(parent::getReturnUrl()),
			'client_id'    => $this->apiKey,
			'client_secret'=> $this->apiSecret,
		);

		//模拟post提交
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_POST, 1);
		curl_setopt($ch, CURLOPT_HEADER, 0);
		curl_setopt($ch, CURLOPT_URL,$url);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);
		curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($urlParmsArray));
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
		$tokenInfo = JSON::decode(curl_exec($ch));

		if(!isset($tokenInfo['access_token']))
		{
			die(var_export($tokenInfo));
		}
		ISession::set('access_token',$tokenInfo['access_token']);
	}

	//获取用户数据
	public function getUserInfo()
	{
		$url = 'http://gw.api.taobao.com/router/rest?';

		$paramArr = array(
			/* API系统级输入参数 Start */
			'method' => 'taobao.user.buyer.get',        //API名称
			'session' => ISession::get('access_token'), //session
			'timestamp' => date('Y-m-d H:i:s'),
			'format' => 'json',                         //返回格式
			'app_key' => $this->apiKey,                 //Appkey
			'v' => '2.0',                               //API版本号
			'sign_method'=> 'md5',                      //签名方式

			/* API应用级输入参数 Start*/
			'fields' => 'user_id,nick,sex',             //返回字段
		);

		$sign = $this->createSign($paramArr,$this->apiSecret);

		//组织参数
		$strParam = $this->createStrParam($paramArr);
		$strParam .= 'sign='.$sign;

		//构造Url
		$urls = $url.$strParam;

		$userInfo     = array();
		$results      = file_get_contents($urls);
		$resultsArray = JSON::decode($results);

		if(isset($resultsArray['user_buyer_get_response']['user']))
		{
			$userArray = $resultsArray['user_buyer_get_response']['user'];
			$userInfo['id']   = isset($userArray['user_id']) ? $userArray['user_id'] : '';
			$userInfo['name'] = isset($userArray['nick'])    ? $userArray['nick']    : '';
			$userInfo['sex']  = isset($userArray['sex'])     ? ($userArray['sex'] == 'm' ? 1 : 2) : '';
		}

		return $userInfo;
	}

	public function checkStatus($parms)
	{
		if(isset($parms['error']))
		{
			return false;
		}
		else
		{
			return true;
		}
	}

	//生成签名代码
	private function createSign($paramArr,$appSecret)
	{
	    $sign = $appSecret;
	    ksort($paramArr);
	    foreach ($paramArr as $key => $val)
	    {
	       if ($key !='' && $val !='')
	       {
	           $sign .= $key.$val;
	       }
	    }
	    $sign = strtoupper(md5($sign.$appSecret));
	    return $sign;
	}

	//组参函数
	private function createStrParam ($paramArr)
	{
	    $strParam = '';
	    foreach ($paramArr as $key => $val)
	    {
	       if ($key != '' && $val !='')
	       {
	           $strParam .= $key.'='.urlencode($val).'&';
	       }
	    }
	    return $strParam;
	}


}