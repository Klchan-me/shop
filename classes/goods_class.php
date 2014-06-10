<?php
/**
 * @copyright (c) 2011 jooyea.cn
 * @file article.php
 * @brief 商品删除
 * @author relay
 * @date 2011-04-27
 * @version 0.6
 */
class goods_class
{
	/**
	 * 生成商品货号
	 * @return string 货号
	 */
	public static function createGoodsNo()
	{
		$config = new Config('site_config');
		return $config->goods_no_pre.time().rand(10,99);
	}

	/**
	* @brief 删除与商品相关表中的数据
	*/
	public function del($goods_id)
	{
		//删除推荐类商品
		$tb_commend_goods = new IModel('commend_goods');
		$tb_commend_goods->del('goods_id = '.$goods_id);

		//删除商品公用属性
		$tb_goods_attribute = new IModel('goods_attribute');
		$tb_goods_attribute->del('goods_id = '.$goods_id);

		//删除相册商品关系表
		$tb_goods_relation = new IModel('goods_photo_relation');
		$tb_goods_relation->del('goods_id = '.$goods_id);

		//删除货品表
		$tb_products = new IModel('products');
		$tb_products->del('goods_id = '.$goods_id);

		//删除会员价格表
		$tb_group_price = new IModel('group_price');
		$tb_group_price->del('goods_id = '.$goods_id);

		//删除扩展商品分类表
		$tb_cate_extend = new IModel('category_extend');
		$tb_cate_extend->del('goods_id='.$goods_id);

		//删除商品表
		$tb_goods = new IModel('goods');
		$tb_goods ->del('id='.$goods_id);
	}
	/**
	 * 修改商品
	 */
	public function edit($goods_info)
	{
		//获取商品的会员价格
		$groupPriceDB = new IModel('group_price');
		$goodsPrice   = $groupPriceDB->query("goods_id = ".$goods_info['id']." and product_id is NULL ");
		$temp = array();
		foreach($goodsPrice as $key => $val)
		{
			$temp[$val['group_id']] = $val['price'];
		}
		$goods_info['groupPrice'] = $temp ? JSON::encode($temp) : '';

		//赋值到FORM用于渲染
		$data = array('form' => $goods_info);

		//加载推荐类型
		$tb_commend_goods = new IModel('commend_goods');
		$commend_goods = $tb_commend_goods->query('goods_id='.$goods_info['id'],'commend_id');
		if($commend_goods)
		{
			foreach($commend_goods as $value)
			{
				$data['goods_commend'][] = $value['commend_id'];
			}
		}

		//相册
		$tb_goods_photo = new IQuery('goods_photo_relation as ghr');
		$tb_goods_photo->join = 'left join goods_photo as gh on ghr.photo_id=gh.id';
		$tb_goods_photo->fields = 'gh.img';
		$tb_goods_photo->where = 'ghr.goods_id='.$goods_info['id'];
		$tb_goods_photo->order = 'ghr.id asc';
		$data['goods_photo'] = $tb_goods_photo->find();

		//扩展基本属性
		$tb_spec_attr = new IQuery('goods_attribute');
		$tb_spec_attr->where = "goods_id=".$goods_info['id']." and attribute_id != '' ";
		$spec_attr_info = $tb_spec_attr->find();
		if($spec_attr_info)
		{
			foreach($spec_attr_info as $item)
			{
				//key：属性名；val：属性值
				$data['goods_attr'][$item['attribute_id']] = $item['attribute_value'];
			}
		}

		//商品分类
		$categoryExtend = new IQuery('category_extend');
		$categoryExtend->where = 'goods_id = '.$goods_info['id'];
		$tb_goods_photo->fields = 'category_id';
		$cateData = $categoryExtend->find();
		if($cateData)
		{
			foreach($cateData as $item)
			{
				$data['goods_category'][] = $item['category_id'];
			}
		}
		return $data;
	}
	/**
	 * @param
	 * @return array
	 * @brief 无限极分类递归函数
	 */
	public static function sortdata($catArray, $id = 0 , $prefix = '')
	{
		static $formatCat = array();
		static $floor     = 0;

		foreach($catArray as $key => $val)
		{
			if($val['parent_id'] == $id)
			{
				$str         = self::nstr($prefix,$floor);
				$val['name'] = $str.$val['name'];

				$val['floor'] = $floor;
				$formatCat[]  = $val;

				unset($catArray[$key]);

				$floor++;
				self::sortdata($catArray, $val['id'] ,$prefix);
				$floor--;
			}
		}
		return $formatCat;
	}

	/**
	 * @brief 计算商品的价格区间
	 * @param $catId        商品分类id
	 * @param $showPriceNum 展示分组最大数量
	 * @return array        价格区间分组
	 */
	public static function getGoodsPrice($catId,$showPriceNum = 4)
	{
		$goodsObj     = new IModel('category_extend as ca,goods as go');
		$goodsPrice   = $goodsObj->getObj('ca.category_id in ('.$catId.') and ca.goods_id = go.id','MIN(sell_price) as min,MAX(sell_price) as max');
		if($goodsPrice['min'] <= 0)
		{
			return array();
		}

		$minBit = strlen(intval($goodsPrice['min']));
		if($minBit <= 2)
		{
			$minPrice = 99;
		}
		else
		{
			$minPrice = substr(intval($goodsPrice['min']),0,1).str_repeat('9',($minBit - 1));
		}

		//商品价格计算
		$result   = array('1-'.$minPrice);
		$perPrice = floor(($goodsPrice['max'] - $minPrice)/($showPriceNum - 1));

		if($perPrice > 0)
		{
			for($addPrice = $minPrice+1; $addPrice < $goodsPrice['max'];)
			{
				$stepPrice = $addPrice + $perPrice;
				$stepPrice = substr(intval($stepPrice),0,1).str_repeat('9',(strlen(intval($stepPrice)) - 1));
				$result[]  = $addPrice.'-'.$stepPrice;
				$addPrice  = $stepPrice + 1;
			}
		}

		return $result;
	}

	//处理商品列表显示缩进
	public static function nstr($str,$num=0)
	{
		$return = '';
		for($i=0;$i<$num;$i++)
		{
			$return .= $str;
		}
		return $return;
	}

	/**
	 * @brief  获取分类数据
	 * @param  int   $catId  分类ID
	 * @return array $result array(id => name)
	 */
	public static function catRecursion($catId)
	{
		$result = array();
		$catDB  = new IModel('category');
		$catRow = $catDB->getObj('id = '.$catId);
		while(true)
		{
			if($catRow)
			{
				array_unshift($result,array('id' => $catRow['id'],'name' => $catRow['name']));
				$catRow = $catDB->getObj('id = '.$catRow['parent_id']);
			}
			else
			{
				break;
			}
		}
		return $result;
	}

	/**
	 * @brief 获取树形分类
	 * @param int $catId 分类ID
	 * @return array
	 */
	public static function catTree($catId)
	{
		$result    = array();
		$catDB     = new IModel('category');
		$childList = $catDB->query('parent_id = '.$catId);
		if(!$childList)
		{
			$catRow = $catDB->getObj('id = '.$catId);
			$childList = $catDB->query('parent_id = '.$catRow['parent_id']);
		}
		return $childList;
	}

	/**
	 * @brief 获取子分类可以无限递归获取子分类
	 * @param int $catId 分类ID
	 * @param int $level 层级数
	 * @return array
	 */
	public static function catChild($catId,$level = 1)
	{
		if($level == 0)
		{
			return $catId;
		}

		$temp   = array();
		$result = array($catId);
		$catDB  = new IModel('category');

		while(true)
		{
			$id = current($result);
			if(!$id)
			{
				break;
			}
			$temp = $catDB->query('parent_id = '.$id);
			foreach($temp as $key => $val)
			{
				$result[] = $val['id'];
			}
			next($result);
		}
		return join(',',$result);
	}
}