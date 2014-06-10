<?php
/**
 * @copyright (c) 2011 jooyea.cn
 * @file goods.php
 * @brief 商品api方法
 * @author chendeshan
 * @date 2011-9-30 13:49:22
 * @version 0.6
 */
class APIGoods
{
	/**
	 * @brief  根据id获取商品信息
	 * @param  int    $gid    商品id,多个id时以逗号','分割, 如：2,5,6,21
	 * @return array  商品结果集
	 */
	public function getGoodsList($gid)
	{
		$fields    = ' id , name , goods_no , sell_price , market_price, cost_price , store_nums , img , weight ';
		$dbObj     = IDBFactory::getDB();
		$tableName = IWeb::$app->config['DB']['tablePre'].'goods';
		return $dbObj->doSql('SELECT '.$fields.' FROM '.$tableName.' WHERE id in ('.$gid.') AND is_del = 0 ');
	}

}