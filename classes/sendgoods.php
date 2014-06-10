<?php
/**
 * @copyright Copyright(c) 2014 aircheng.com
 * @file sendgoods.php
 * @brief 发货接口
 * @author chendeshan
 * @date 2014/4/18 16:22:33
 * @version 1.0.0
 */

/**
 * @class sendgoods
 * @brief 发货接口类
 */
class sendgoods
{
	/**
	 * @brief 开始发货
	 * @param $orderId int 订单ID号
	 */
	public static function run($orderId)
	{
		$orderRow = self::getOrderInfo($orderId);
		if($orderRow['trade_no'] && $sendObj = self::createObject($orderRow['class_name']))
		{
			$sendObj->send($orderRow);
		}
	}

	/**
	 * @brief 获取订单信息
	 * @param $orderId int 订单ID
	 * @return array 订单信息
	 */
	private static function getOrderInfo($orderId)
	{
		$orderDB         = new IQuery('order as o');
		$orderDB->fields = 'p.class_name,o.trade_no,p.partner_id,p.partner_key,dd.delivery_code,fc.freight_type';
		$orderDB->join   = 'left join payment as p on o.pay_type = p.id left join delivery_doc as dd on o.id = dd.order_id left join delivery as d on d.id = o.distribution left join freight_company as fc on fc.id = d.freight_id';
		$orderDB->where  = 'o.id = '.$orderId;
		$result          = $orderDB->find();
		return current($result);
	}

	/**
	 * @brief 获取类文件路径
	 * @param $className string 支付类名称
	 * @return object 发货类实力
	 */
	private static function createObject($className)
	{
		$basePath = IWeb::$app->getBasePath().'plugins/sendGoods/';
		switch($className)
		{
			case "trade_alipay":
			case "alipay":
			{
				include($basePath.'alipay/sendgoods_alipay.php');
				return new sendgoods_alipay();
			}
			break;
		}
		return '';
	}
}