<?php
/**
 * @copyright (c) 2011 jooyea.cn
 * @file article.php
 * @brief 订单中配送方式的计算
 * @author relay
 * @date 2011-02-24
 * @version 0.6
 */
class Delivery
{
	//首重重量
	private static $firstWeight  = 0;

	//次重重量
	private static $secondWeight = 0;

	/**
	 * 根据重量计算给定价格
	 * @param $weight float 总重量
	 * @param $firstFee float 首重费用
	 * @param $second float 次重费用
	 */
	private static function getFeeByWeight($weight,$firstFee,$secondFee)
	{
		//当商品重量小于或等于首重的时候
		if($weight <= self::$firstWeight)
		{
			return $firstFee;
		}

		//当商品重量大于首重时，根据次重进行累加计算
		$num = ceil(($weight - self::$firstWeight)/self::$secondWeight);
		return $firstFee + $secondFee * $num;
	}

	/**
	 * @param $province string 省份的id
	 * @param $weight int 货物的重量
	 * @param $goodsSum float 商品总价格
	 * @return array()
	 * @brief 配送方式计算管理模块
	 */
	public static function getDelivery($province,$weight = 0,$goodsSum = 0)
	{
		$data = array();

		//获得配送方式表的对象
     	$delivery = new IModel('delivery');

     	//获取配送方式列表
     	$where = 'is_delete = 0 and status = 1';
     	$list = $delivery->query($where,'*','sort','asc');

		//循环各个配送方式
     	foreach($list as $value)
     	{
     		//设置首重和次重
     		self::$firstWeight  = $value['first_weight'];
     		self::$secondWeight = $value['second_weight'];

			$data[$value['id']]['id']          = $value['id'];
			$data[$value['id']]['name']        = $value['name'];
			$data[$value['id']]['type']        = $value['type'];
			$data[$value['id']]['description'] = $value['description'];
			$data[$value['id']]['if_delivery'] = '0';

     		//当配送方式是统一配置的时候，不进行区分地区价格
     		if($value['price_type'] == 0)
     		{
     			$data[$value['id']]['price'] = self::getFeeByWeight($weight,$value['first_price'],$value['second_price']);
     		}
     		//当配送方式为指定区域和价格的时候
     		else
     		{
 				$matchKey = '';
 				$flag     = false;

 				//每项都是以';'隔开的省份ID
 				$area_groupid = unserialize($value['area_groupid']);
 				foreach($area_groupid as $key => $result)
 				{
 					//匹配到了特殊的省份运费价格
 					if(strpos($result,';'.$province.';') !== false)
 					{
 						$matchKey = $key;
 						$flag     = true;
 						break;
 					}
 				}

				//匹配到了特殊的省份运费价格
 				if($flag)
 				{
					//获取当前省份特殊的运费价格
					$firstprice  = unserialize($value['firstprice']);
					$secondprice = unserialize($value['secondprice']);

					$data[$value['id']]['price'] = self::getFeeByWeight($weight,$firstprice[$matchKey],$secondprice[$matchKey]);
 				}
 				else
 				{
	     			//判断是否设置默认费用了
	     			if($value['open_default'] == 1)
	     			{
	     				$data[$value['id']]['price'] = self::getFeeByWeight($weight,$value['first_price'],$value['second_price']);
	     			}
	     			else
	     			{
	     				$data[$value['id']]['price']       = '0';
	     				$data[$value['id']]['if_delivery'] = '1';
	     			}
 				}
     		}

     		//计算保价
     		if($value['is_save_price'] == 1)
     		{
     			$tempProtectPrice = $goodsSum * ($value['save_rate'] * 0.01);
     			$data[$value['id']]['protect_price'] = ($tempProtectPrice <= $value['low_price']) ? $value['low_price'] : $tempProtectPrice;
     		}
     		else
     		{
     			$data[$value['id']]['protect_price'] = 0;
     		}
     	}
     	return $data;
	}
}