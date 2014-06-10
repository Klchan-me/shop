<?php
/**
 * @copyright Copyright(c) 2011 jooyea.cn
 * @file paypal.php
 * @brief 贝宝(外卡)接口
 * @author chendeshan
 * @date 2011-01-27
 * @version 0.6
 * @note
 */

 /**
 * @class paypal
 * @brief 贝宝(外卡)接口
 */
class paypal extends paymentPlugin
{
	//支付插件名称
    public $name = '贝宝支付';

	/**
	 * @see paymentplugin::getSubmitUrl()
	 */
	public function getSubmitUrl()
	{
		return 'https://www.paypal.com/cgi-bin/webscr';
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
		$UserName = Payment::getPaymentById($paymentId,'partner_id');
		$IDcode   = Payment::getPaymentById($paymentId,'partner_key');

		$return                = array();
		$return['business']    = urldecode($UserName);
		$return['item_number'] = urldecode($callbackData['item_number']);
		$return['amount']      = urldecode($callbackData['amt']);
		$return['return']      = urldecode($this->callbackUrl);
		$return['notify_url']  = urldecode($this->serverCallbackUrl);
		$md5Code               = $this->createMD5($return,$IDcode);

		//校验md5码 防止篡改数据
		if(urldecode($callbackData['cm']) == $md5Code)
		{
            switch($callbackData['st'])
            {
                case 'Completed':
                {
					$orderNo  = $callbackData['item_number'];
					$money    = $callbackData['amt'];
                	return true;
                    break;
                }
                default:
                {
                	return false;
                	break;
                }
            }
		}
		else
		{
			$message = '校验码不正确';
		}
		return false;
	}

	/**
	 * @see paymentplugin::serverCallback()
	 */
	public function serverCallback($callbackData,&$paymentId,&$money,&$message,&$orderNo)
	{
    	//通过soket检查回值是否合法
    	$req = 'cmd=_notify-validate';
		foreach ($_POST as $key => $value)
		{
			$value = urlencode(stripslashes($value));
			$req  .= "&$key=$value";
		}

		$header .= "POST /cgi-bin/webscr HTTP/1.0\r\n";
		$header .= "Content-Type:application/x-www-form-urlencoded\r\n";
		$header .= "Content-Length:" . strlen($req) ."\r\n\r\n";
		$fp      = fsockopen ('www.paypal.com', 80, $errno, $errstr, 30);
		if(!$fp)
		{
			return false;
		}
		else
		{
			fputs ($fp, $header .$req);
			while (!feof($fp))
			{
				$res = fgets ($fp, 1024);
				if (strcmp ($res, "VERIFIED") == 0)
				{
					return $this->callback($callbackData,$paymentId,$money,$message,$orderNo);
				}
				else if (strcmp ($res, "INVALID") == 0)
				{
					return false;
				}
			}
			fclose ($fp);
		}
	}

	/**
	 * @see paymentplugin::getSendData()
	 */
	public function getSendData($payment)
	{
    	$return = array();

		$UserName = $payment['M_PartnerId'];
		$IDcode   = $payment['M_PartnerKey'];

		$return['business']    = $UserName;
		$return['item_number'] = $payment['M_OrderNO'];
		$return['amount']      = $payment['M_Amount'];
		$return['return']      = $this->callbackUrl;
		$return['notify_url']  = $this->serverCallbackUrl;
		$return['custom']      = $this->createMD5($return,$IDcode);
		$return['item_name']   = $payment['R_Name'];
		$return['cmd']         = '_xclick';
		$return['charset']     = 'utf-8';

        return $return;
	}

    /**
    * @brief 生成md5防篡改码
	* @param array  要加密的原数据
	* @param string id密钥
	× @return string md5码
    */
    private function createMD5($rdata,$idCode)
    {
    	$rdataMD5   = '';
    	$rdataArray = array();

    	//让数组以键值进行排序
        ksort($rdata);
        reset($rdata);

    	foreach($rdata as $key => $val)
    	{
    		$rdataArray[] = $val;
    	}

    	$rdataMD5 = join('&',$rdataArray);
    	return md5($rdataMD5.$idCode);
    }
}