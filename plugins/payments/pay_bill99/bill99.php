<?php
/**
 * @copyright Copyright(c) 2011 jooyea.cn
 * @file pay_99bill.php
 * @brief 快钱在线支付接口
 * @author chendeshan
 * @date 2011-01-27
 * @version 0.6
 * @note
 */

 /**
 * @class pay_99bill
 * @brief 快钱在线(内卡)支付接口
 */
class bill99 extends paymentPlugin
{
	//插件名称
    public $name = '快钱支付';

	/**
	 * @see paymentplugin::getSubmitUrl()
	 */
	public function getSubmitUrl()
	{
		return 'https://www.99bill.com/gateway/recvMerchantInfoAction.htm';
	}

	/**
	 * @see paymentplugin::notifyStop()
	 */
	public function notifyStop()
	{
		echo "<result>1</result><redirecturl>".$this->callbackUrl."</redirecturl>";
	}

	/**
	 * @see paymentplugin::callback()
	 */
	public function callback($callbackData,&$paymentId,&$money,&$message,&$orderNo)
	{
		return $this->serverCallback($callbackData,$paymentId,$money,$message,$orderNo);
	}

	/**
	 * @see paymentplugin::serverCallback()
	 */
	public function serverCallback($callbackData,&$paymentId,&$money,&$message,&$orderNo)
	{
		//获取人民币网关账户号
		$merchantAcctId = trim($_REQUEST['merchantAcctId']);

		//设置人民币网关密钥
		///区分大小写
		$key=Payment::getPaymentById($paymentId,'partner_key');//商户密钥

		//获取网关版本.固定值
		///快钱会根据版本号来调用对应的接口处理程序。
		///本代码版本号固定为v2.0
		$version=trim($_REQUEST['version']);

		//获取语言种类.固定选择值。
		///只能选择1、2、3
		///1代表中文；2代表英文
		///默认值为1
		$language=trim($_REQUEST['language']);

		//签名类型.固定值
		///1代表MD5签名
		///当前版本固定为1
		$signType=trim($_REQUEST['signType']);

		//获取支付方式
		///值为：10、11、12、13、14
		///00：组合支付（网关支付页面显示快钱支持的各种支付方式，推荐使用）10：银行卡支付（网关支付页面只显示银行卡支付）.11：电话银行支付（网关支付页面只显示电话支付）.12：快钱账户支付（网关支付页面只显示快钱账户支付）.13：线下支付（网关支付页面只显示线下支付方式）.14：B2B支付（网关支付页面只显示B2B支付，但需要向快钱申请开通才能使用）
		$payType=trim($_REQUEST['payType']);

		//获取银行代码
		///参见银行代码列表
		$bankId=trim($_REQUEST['bankId']);

		//获取商户订单号
		$orderId=trim($_REQUEST['orderId']);

		//获取订单提交时间
		///获取商户提交订单时的时间.14位数字。年[4位]月[2位]日[2位]时[2位]分[2位]秒[2位]
		///如：20080101010101
		$orderTime=trim($_REQUEST['orderTime']);

		//获取原始订单金额
		///订单提交到快钱时的金额，单位为分。
		///比方2 ，代表0.02元
		$orderAmount=trim($_REQUEST['orderAmount']);

		//获取快钱交易号
		///获取该交易在快钱的交易号
		$dealId=trim($_REQUEST['dealId']);

		//获取银行交易号
		///如果使用银行卡支付时，在银行的交易号。如不是通过银行支付，则为空
		$bankDealId=trim($_REQUEST['bankDealId']);

		//获取在快钱交易时间
		///14位数字。年[4位]月[2位]日[2位]时[2位]分[2位]秒[2位]
		///如；20080101010101
		$dealTime=trim($_REQUEST['dealTime']);

		//获取实际支付金额
		///单位为分
		///比方 2 ，代表0.02元
		$payAmount=trim($_REQUEST['payAmount']);

		//获取交易手续费
		///单位为分
		///比方 2 ，代表0.02元
		$fee=trim($_REQUEST['fee']);

		//获取扩展字段1
		$ext1=trim($_REQUEST['ext1']);

		//获取扩展字段2
		$ext2=trim($_REQUEST['ext2']);

		//获取处理结果
		///10代表 成功; 11代表 失败
		$payResult=trim($_REQUEST['payResult']);

		//获取错误代码
		///详细见文档错误代码列表
		$errCode=trim($_REQUEST['errCode']);

		//获取加密签名串
		$signMsg=trim($_REQUEST['signMsg']);

		//生成加密串。必须保持如下顺序。
		$merchantSignMsgVal='';
		$merchantSignMsgVal=$this->appendParam($merchantSignMsgVal,"merchantAcctId",$merchantAcctId);
		$merchantSignMsgVal=$this->appendParam($merchantSignMsgVal,"version",$version);
		$merchantSignMsgVal=$this->appendParam($merchantSignMsgVal,"language",$language);
		$merchantSignMsgVal=$this->appendParam($merchantSignMsgVal,"signType",$signType);
		$merchantSignMsgVal=$this->appendParam($merchantSignMsgVal,"payType",$payType);
		$merchantSignMsgVal=$this->appendParam($merchantSignMsgVal,"bankId",$bankId);
		$merchantSignMsgVal=$this->appendParam($merchantSignMsgVal,"orderId",$orderId);
		$merchantSignMsgVal=$this->appendParam($merchantSignMsgVal,"orderTime",$orderTime);
		$merchantSignMsgVal=$this->appendParam($merchantSignMsgVal,"orderAmount",$orderAmount);
		$merchantSignMsgVal=$this->appendParam($merchantSignMsgVal,"dealId",$dealId);
		$merchantSignMsgVal=$this->appendParam($merchantSignMsgVal,"bankDealId",$bankDealId);
		$merchantSignMsgVal=$this->appendParam($merchantSignMsgVal,"dealTime",$dealTime);
		$merchantSignMsgVal=$this->appendParam($merchantSignMsgVal,"payAmount",$payAmount);
		$merchantSignMsgVal=$this->appendParam($merchantSignMsgVal,"fee",$fee);
		$merchantSignMsgVal=$this->appendParam($merchantSignMsgVal,"ext1",$ext1);
		$merchantSignMsgVal=$this->appendParam($merchantSignMsgVal,"ext2",$ext2);
		$merchantSignMsgVal=$this->appendParam($merchantSignMsgVal,"payResult",$payResult);
		$merchantSignMsgVal=$this->appendParam($merchantSignMsgVal,"errCode",$errCode);
		$merchantSignMsgVal=$this->appendParam($merchantSignMsgVal,"key",$key);
		$merchantSignMsg= md5($merchantSignMsgVal);

        if(strtoupper($signMsg)==strtoupper($merchantSignMsg))
        {
			$money       = $orderAmount/100;
			$orderNo     = $orderId;
			$message     = $payResult;

            //支付单号
            switch($payResult)
            {
                case '10':
                {
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
        	return false;
        }
	}

	/**
	 * @see paymentplugin::getSendData()
	 */
	public function getSendData($payment)
	{
    	$return = array();

		//人民币网关账户号
		///请登录快钱系统获取用户编号，用户编号后加01即为人民币网关账户号。
		$merchantAcctId=$payment['M_PartnerId'];

		//人民币网关密钥
		///区分大小写.请与快钱联系索取
		$key=$payment['M_PartnerKey'];

		//字符集.固定选择值。可为空。
		///只能选择1、2、3.
		///1代表UTF-8; 2代表GBK; 3代表gb2312
		///默认值为1
		$inputCharset="1";

		//服务器接受支付结果的后台地址.与[pageUrl]不能同时为空。必须是绝对地址。
		///快钱通过服务器连接的方式将交易结果发送到[bgUrl]对应的页面地址，在商户处理完成后输出的<result>如果为1，页面会转向到<redirecturl>对应的地址。
		///如果快钱未接收到<redirecturl>对应的地址，快钱将把支付结果GET到[pageUrl]对应的页面。
		$bgUrl=$this->serverCallbackUrl;

		//网关版本.固定值
		///快钱会根据版本号来调用对应的接口处理程序。
		///本代码版本号固定为v2.0
		$version="v2.0";

		//语言种类.固定选择值。
		///只能选择1、2、3
		///1代表中文；2代表英文
		///默认值为1
		$language="1";

		//签名类型.固定值
		///1代表MD5签名
		///当前版本固定为1
		$signType="1";

		//支付人姓名
		///可为中文或英文字符
		$payerName="";

		//支付人联系方式类型.固定选择值
		///只能选择1
		///1代表Email
		$payerContactType="1";

		//支付人联系方式
		///只能选择Email或手机号
		$payerContact="";

		//商户订单号
		///由字母、数字、或[-][_]组成
		$orderId=$payment['M_OrderNO'];

		//订单金额(单位：分)
		$orderAmount = $payment['M_Amount']*100;

		//订单提交时间
		///14位数字。年[4位]月[2位]日[2位]时[2位]分[2位]秒[2位]
		///如；20080101010101
		$orderTime=date('YmdHis');

		//商品名称
		///可为中文或英文字符
		$productName="";

		//商品数量
		///可为空，非空时必须为数字
		$productNum="";

		//商品代码
		///可为字符或者数字
		$productId="";

		//商品描述
		$productDesc="";

		//扩展字段1
		///在支付结束后原样返回给商户
		$ext1="";

		//扩展字段2
		///在支付结束后原样返回给商户
		$ext2="";

		//支付方式.固定选择值
		///只能选择00、10、11、12、13、14
		///00：组合支付（网关支付页面显示快钱支持的各种支付方式，推荐使用）10：银行卡支付（网关支付页面只显示银行卡支付）.11：电话银行支付（网关支付页面只显示电话支付）.12：快钱账户支付（网关支付页面只显示快钱账户支付）.13：线下支付（网关支付页面只显示线下支付方式）
		$payType="00";

		//银行代码，可以通过快钱接口直连银行,如：ABC,ICBC
		$bankId="";

		//同一订单禁止重复提交标志
		///固定选择值： 1、0
		///1代表同一订单号只允许提交1次；0表示同一订单号在没有支付成功的前提下可重复提交多次。默认为0建议实物购物车结算类商户采用0；虚拟产品类商户采用1
		$redoFlag="0";

		//快钱的合作伙伴的账户号
		///如未和快钱签订代理合作协议，不需要填写本参数
		$pid=""; ///合作伙伴在快钱的用户编号

		//生成加密签名串
		///请务必按照如下顺序和规则组成加密串！
		$signMsgVal='';
		$signMsgVal=$this->appendParam($signMsgVal,"inputCharset",$inputCharset);
		$signMsgVal=$this->appendParam($signMsgVal,"bgUrl",$bgUrl);
		$signMsgVal=$this->appendParam($signMsgVal,"version",$version);
		$signMsgVal=$this->appendParam($signMsgVal,"language",$language);
		$signMsgVal=$this->appendParam($signMsgVal,"signType",$signType);
		$signMsgVal=$this->appendParam($signMsgVal,"merchantAcctId",$merchantAcctId);
		$signMsgVal=$this->appendParam($signMsgVal,"payerName",$payerName);
		$signMsgVal=$this->appendParam($signMsgVal,"payerContactType",$payerContactType);
		$signMsgVal=$this->appendParam($signMsgVal,"payerContact",$payerContact);
		$signMsgVal=$this->appendParam($signMsgVal,"orderId",$orderId);
		$signMsgVal=$this->appendParam($signMsgVal,"orderAmount",$orderAmount);
		$signMsgVal=$this->appendParam($signMsgVal,"orderTime",$orderTime);
		$signMsgVal=$this->appendParam($signMsgVal,"productName",$productName);
		$signMsgVal=$this->appendParam($signMsgVal,"productNum",$productNum);
		$signMsgVal=$this->appendParam($signMsgVal,"productId",$productId);
		$signMsgVal=$this->appendParam($signMsgVal,"productDesc",$productDesc);
		$signMsgVal=$this->appendParam($signMsgVal,"ext1",$ext1);
		$signMsgVal=$this->appendParam($signMsgVal,"ext2",$ext2);
		$signMsgVal=$this->appendParam($signMsgVal,"payType",$payType);
		$signMsgVal=$this->appendParam($signMsgVal,"bankId",$bankId);
		$signMsgVal=$this->appendParam($signMsgVal,"redoFlag",$redoFlag);
		$signMsgVal=$this->appendParam($signMsgVal,"pid",$pid);
		$signMsgVal=$this->appendParam($signMsgVal,"key",$key);
		$signMsg   = strtoupper(md5($signMsgVal));

		$return['inputCharset'] = $inputCharset;
		$return['bgUrl'] = $bgUrl;
		$return['version'] = $version;
		$return['language'] = $language;
		$return['signType'] = $signType;
		$return['signMsg'] = $signMsg;
		$return['merchantAcctId'] = $merchantAcctId;
		$return['payerName'] = $payerName;
		$return['payerContactType'] = $payerContactType;
		$return['payerContact'] = $payerContact;
		$return['orderId'] = $orderId;
		$return['orderAmount'] = $orderAmount;
		$return['orderTime'] = $orderTime;
		$return['productName'] = $productName;
		$return['productNum'] = $productNum;
		$return['productId'] = $productId;
		$return['productDesc'] = $productDesc;
		$return['ext1'] = $ext1;
		$return['ext2'] = $ext2;
		$return['payType'] = $payType;
		$return['bankId'] = $bankId;
		$return['redoFlag'] = $redoFlag;
		$return['pid'] = $pid;

        return $return;
	}

	//功能函数。将变量值不为空的参数组成字符串
	function appendParam($returnStr,$paramId,$paramValue)
	{
		if($returnStr!="")
		{
			if($paramValue!="")
			{
				$returnStr.="&".$paramId."=".$paramValue;
			}
		}
		else
		{
			if($paramValue!="")
			{
				$returnStr=$paramId."=".$paramValue;
			}
		}
		return $returnStr;
	}
}
