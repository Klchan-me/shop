<?php
/**
 * @copyright Copyright(c) 2011 jooyea.cn
 * @file alipay.php
 * @brief 支付宝插件类[担保+即时到帐双接口]
 * @author nswe
 * @date 2011-01-27
 * @version 0.6
 * @note
 */

/**
 * @class alipay
 * @brief 支付宝插件类[担保+即时到帐双接口]
 */
class alipay extends paymentPlugin
{
	//支付插件名称
    public $name = '支付宝';

	/**
	 * @see paymentplugin::getSubmitUrl()
	 */
	public function getSubmitUrl()
	{
		return 'https://mapi.alipay.com/gateway.do?_input_charset=utf-8';
	}

	/**
	 * @see paymentplugin::notifyStop()
	 */
	public function notifyStop()
	{
		echo "success";
	}

	/**
	 * @see paymentplugin::callback()
	 */
	public function callback($callbackData,&$paymentId,&$money,&$message,&$orderNo)
	{
		//除去待签名参数数组中的空值和签名参数
		$para_filter = $this->paraFilter($callbackData);

		//对待签名参数数组排序
		$para_sort = $this->argSort($para_filter);

		//生成签名结果
		$mysign = $this->buildMysign($para_sort,Payment::getPaymentById($paymentId,'partner_key'));

		if($callbackData['sign'] == $mysign)
		{
			//回传数据
			$orderNo = $callbackData['out_trade_no'];
			$money   = $callbackData['total_fee'];

			//记录等待发货流水号
			if($callbackData['trade_status'] == 'WAIT_SELLER_SEND_GOODS' && isset($callbackData['trade_no']))
			{
				$this->recordTradeNo($orderNo,$callbackData['trade_no']);
			}

			if($callbackData['trade_status'] == 'TRADE_FINISHED' || $callbackData['trade_status'] == 'WAIT_SELLER_SEND_GOODS')
			{
				return true;
			}
		}
		else
		{
			$message = '签名不正确';
		}
		return false;
	}

	/**
	 * @see paymentplugin::serverCallback()
	 */
	public function serverCallback($callbackData,&$paymentId,&$money,&$message,&$orderNo)
	{
		//除去待签名参数数组中的空值和签名参数
		$para_filter = $this->paraFilter($callbackData);

		//对待签名参数数组排序
		$para_sort = $this->argSort($para_filter);

		//生成签名结果
		$mysign = $this->buildMysign($para_sort,Payment::getPaymentById($paymentId,'partner_key'));

		if($callbackData['sign'] == $mysign)
		{
			//回传数据
			$orderNo = $callbackData['out_trade_no'];
			$money   = $callbackData['total_fee'];

			//记录等待发货流水号
			if($callbackData['trade_status'] == 'WAIT_SELLER_SEND_GOODS' && isset($callbackData['trade_no']))
			{
				$this->recordTradeNo($orderNo,$callbackData['trade_no']);
			}

			if($callbackData['trade_status'] == 'TRADE_FINISHED' || $callbackData['trade_status'] == 'WAIT_SELLER_SEND_GOODS')
			{
				return true;
			}
		}
		return false;
	}

	/**
	 * @see paymentplugin::getSendData()
	 */
	public function getSendData($payment)
	{
		$return = array();

		//基本参数
		$return['service'] = 'trade_create_by_buyer';
		$return['partner'] = $return['seller_id'] = $payment['M_PartnerId'];
		$return['_input_charset'] = 'utf-8';
		$return['payment_type'] = 1;
		$return['return_url'] = $this->callbackUrl;
		$return['notify_url'] = $this->serverCallbackUrl;

		//业务参数
		$return['subject'] = $payment['R_Name'];
		$return['out_trade_no'] = $payment['M_OrderNO'];
		$return['price'] = number_format($payment['M_Amount'], 2, '.', '');
		$return['quantity'] = 1;
		$return['logistics_fee'] = "0.00";
		$return['logistics_type'] = "EXPRESS";
		$return['logistics_payment'] = "SELLER_PAY";

		if(isset($payment['P_Name']))
		{
			$return['receive_name'] = $payment['P_Name'];
			$return['receive_address'] = $payment['P_Address'];
			$return['receive_zip'] = $payment['P_PostCode'];
			$return['receive_phone'] = $payment['P_Telephone'];
			$return['receive_mobile'] = $payment['P_Mobile'];
		}

		//除去待签名参数数组中的空值和签名参数
		$para_filter = $this->paraFilter($return);

		//对待签名参数数组排序
		$para_sort = $this->argSort($para_filter);

		//生成签名结果
		$mysign = $this->buildMysign($para_sort, $payment['M_PartnerKey']);

		//签名结果与签名方式加入请求提交参数组中
		$return['sign'] = $mysign;
		$return['sign_type'] = 'MD5';

		return $return;
	}

	/**
	 * 除去数组中的空值和签名参数
	 * @param $para 签名参数组
	 * return 去掉空值与签名参数后的新签名参数组
	 */
	private function paraFilter($para)
	{
		$para_filter = array();
		foreach($para as $key => $val)
		{
			if($key == "sign" || $key == "sign_type" || $val == "")
			{
				continue;
			}
			else
			{
				$para_filter[$key] = $para[$key];
			}
		}
		return $para_filter;
	}

	/**
	 * 对数组排序
	 * @param $para 排序前的数组
	 * return 排序后的数组
	 */
	private function argSort($para)
	{
		ksort($para);
		reset($para);
		return $para;
	}

	/**
	 * 生成签名结果
	 * @param $sort_para 要签名的数组
	 * @param $key 支付宝交易安全校验码
	 * @param $sign_type 签名类型 默认值：MD5
	 * return 签名结果字符串
	 */
	private function buildMysign($sort_para,$key,$sign_type = "MD5")
	{
		//把数组所有元素，按照“参数=参数值”的模式用“&”字符拼接成字符串
		$prestr = $this->createLinkstring($sort_para);
		//把拼接后的字符串再与安全校验码直接连接起来
		$prestr = $prestr.$key;
		//把最终的字符串签名，获得签名结果
		$mysgin = md5($prestr);
		return $mysgin;
	}

	/**
	 * 把数组所有元素，按照“参数=参数值”的模式用“&”字符拼接成字符串
	 * @param $para 需要拼接的数组
	 * return 拼接完成以后的字符串
	 */
	private function createLinkstring($para)
	{
		$arg  = "";
		foreach($para as $key => $val)
		{
			$arg.=$key."=".$val."&";
		}

		//去掉最后一个&字符
		$arg = trim($arg,'&');

		//如果存在转义字符，那么去掉转义
		if(get_magic_quotes_gpc())
		{
			$arg = stripslashes($arg);
		}

		return $arg;
	}
}