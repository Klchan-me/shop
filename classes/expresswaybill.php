<?php
/**
 * @copyright (c) 2011 [group]
 * @file expresswaybill.php
 * @brief 快递单处理类
 * @author chendeshan
 * @date 2011-6-15 14:58:39
 * @version 0.6
 */
class Expresswaybill
{
	public static $itemData = array(
		'ship_name'=>'收货人-姓名',
		'ship_area_0'=>'收货人-地区1级',
		'ship_area_1'=>'收货人-地区2级',
		'ship_area_2'=>'收货人-地区3级',
		'ship_addr'=>'收货人-地址',
		'ship_tel'=>'收货人-电话',
		'ship_mobile'=>'收货人-手机',
		'ship_zip'=>'收货人-邮编',
		'ship_detail_addr'=>'收货人-地区+详细地址',
		'dly_name'=>'发货人-姓名',
		'dly_area_0'=>'发货人-地区1级',
		'dly_area_1'=>'发货人-地区2级',
		'dly_area_2'=>'发货人-地区3级',
		'dly_address'=>'发货人-地址',
		'dly_tel'=>'发货人-电话',
		'dly_mobile'=>'发货人-手机',
		'dly_zip'=>'发货人-邮编',
		'date_y'=>'当前日期-年',
		'date_m'=>'当前日期-月',
		'date_d'=>'当前日期-日',
		'order_id'=>'订单-订单号',
		'order_price'=>'订单总金额',
		'order_weight'=>'订单物品总重量',
		'order_count'=>'订单-物品数量',
		'order_memo'=>'订单-备注',
		'ship_time'=>'订单-送货时间',
		'shop_name'=>'网店名称',
		'tick'=>'√ - 对号',
	);

	//数据转换
	public function conver($expressConfig,$order_id)
	{
		$resultArray = array(); //函数返回数据
		$wholeData   = array(); //实际的数据
		$areaArray   = array(); //区域id集合,便于一次性查询

		//获取订单信息
		$id       = intval($order_id);
		$orderObj = new IModel('order');
		$orderRow = $orderObj->getObj('id = '.$id);

		if(empty($orderRow))
		{
			return null;
		}

		$areaArray[] = $orderRow['province'];
		$areaArray[] = $orderRow['city'];
		$areaArray[] = $orderRow['area'];

		//获取发货地址信息
		$shipInfoObj = new IModel('merch_ship_info');
		$shipList    = $shipInfoObj->query('is_del = 1','*','is_default','desc','1');
		if(empty($shipList))
		{
			$shipRow = array('ship_user_name'=>'','address'=>'','telphone'=>'','mobile'=>'','postcode'=>'','province' => '','city'=>'','area'=>'');
		}
		else
		{
			$shipRow = $shipList[0];
			$areaArray[] = $shipRow['province'];
			$areaArray[] = $shipRow['city'];
			$areaArray[] = $shipRow['area'];
		}

		//获取订单总重量和总数量
		$orderGoodsObj = new IModel('order_goods');
		$orderTotal    = $orderGoodsObj->getObj('order_id = '.$id,'SUM(goods_nums) as num_total,SUM(goods_weight * goods_nums) as weight_total');


		/*拼接实际数据 $wholeData*/

		//查询area地域数据
		$areasObj  = new IModel('areas');
		$areaList  = $areasObj->query('area_id in ('.join(",",$areaArray).')','area_name,area_id');

		$areaData  = array();
		foreach($areaList as $val)
		{
			$areaData[$val['area_id']] = $val['area_name'];
		}

		//获取site_config配置信息
		$site_config = new Config('site_config');
		$site_config = $site_config->getInfo();

		$wholeData['ship_name']   = $orderRow['accept_name'];
		$wholeData['ship_area_0'] = isset($areaData[$orderRow['province']]) ? $areaData[$orderRow['province']] : '';
		$wholeData['ship_area_1'] = isset($areaData[$orderRow['city']])     ? $areaData[$orderRow['city']]     : '';
		$wholeData['ship_area_2'] = isset($areaData[$orderRow['area']])     ? $areaData[$orderRow['area']]     : '';
		$wholeData['ship_addr']   = $orderRow['address'];
		$wholeData['ship_tel']    = $orderRow['telphone'];
		$wholeData['ship_mobile'] = $orderRow['mobile'];
		$wholeData['ship_zip']    = $orderRow['postcode'];
		$wholeData['ship_detail_addr'] = $wholeData['ship_area_0'].$wholeData['ship_area_1'].$wholeData['ship_area_2'].$orderRow['address'];

		$wholeData['dly_name']    = $shipRow['ship_user_name'];
		$wholeData['dly_area_0']  = isset($areaData[$shipRow['province']]) ? $areaData[$shipRow['province']] : '';
		$wholeData['dly_area_1']  = isset($areaData[$shipRow['city']])     ? $areaData[$shipRow['city']] : '';
		$wholeData['dly_area_2']  = isset($areaData[$shipRow['area']])     ? $areaData[$shipRow['area']] : '';
		$wholeData['dly_address'] = $shipRow['address'];
		$wholeData['dly_tel']     = $shipRow['telphone'];
		$wholeData['dly_mobile']  = $shipRow['mobile'];
		$wholeData['dly_zip']     = $shipRow['postcode'];

		$wholeData['date_y']      = date('Y');
		$wholeData['date_m']      = date('m');
		$wholeData['date_d']      = date('d');

		$wholeData['order_id']    = $orderRow['order_no'];
		$wholeData['order_price'] = $orderRow['order_amount'];
		$wholeData['order_weight'] = isset($orderTotal['weight_total']) ? $orderTotal['weight_total'] : '';
		$wholeData['order_count']  = isset($orderTotal['num_total'])    ? $orderTotal['num_total'] : '';
		$wholeData['order_memo']   = $orderRow['note'];
		$wholeData['ship_time']    = $orderRow['accept_time'];
		$wholeData['shop_name']    = isset($site_config['name']) ? $site_config['name'] : '';
		$wholeData['tick']         = '√';

		//进行数据替换
		foreach($expressConfig as $key => $val)
		{
			$item_tmp             = JSON::decode($val);
			$item_tmp['typeText'] = isset($wholeData[$item_tmp['typeId']]) ? $wholeData[$item_tmp['typeId']] : '';
			$resultArray[]        = JSON::encode($item_tmp);
		}

		return $resultArray;
	}
}
?>