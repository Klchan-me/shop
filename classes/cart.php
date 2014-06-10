<?php
/**
 * @copyright (c) 2011 jooyea.cn
 * @file cart.php
 * @brief 购物车类库
 * @author chendeshan
 * @date 2011-04-12
 * @version 0.6
 */

/**
 * @class Cart
 * @brief 购物车类库
 */
class Cart
{
	/*购物车简单cookie存储结构
	* array [goods]=>array(商品主键=>数量) , [product]=>array( 货品主键=>数量 )
	*/
	private $cartStruct = array( 'goods' => array() , 'product' => array() );

	/*购物车复杂存储结构
	* [id]   :array  商品id值;
	* [count]:int    商品数量;
	* [info] :array  商品信息 [goods]=>array( ['id']=>商品ID , ['data'] => array( [商品ID]=>array ( [sell_price]价格, [count]购物车中此商品的数量 ,[type]类型goods,product ,[goods_id]商品ID值 ) ) ) , [product]=>array( 同上 ) , [count]购物车商品和货品数量 , [sum]商品和货品总额 ;
	* [sum]  :int    商品总价格;
	*/
	private $cartExeStruct = array('goods' => array('id' => array(), 'data' => array() ),'product' => array( 'id' => array() , 'data' => array()),'count' => 0,'sum' => 0);

	//购物车名字前缀
	private $cartName    = 'shoppingcart';

	//购物车中最多容纳的数量
	private $maxCount    = 100;

	//错误信息
	private $error       = '';

	//购物车的存储方式
	private $saveType    = 'cookie';

	//构造函数
	function __construct()
	{
		$cartInfo = $this->getMyCartStruct();
		$this->setMyCart($cartInfo);
	}

	/**
	 * 获取新加入购物车的数据
	 * @param $cartInfo cartStruct
	 * @param $gid 商品或者货品ID
	 * @param $num 数量
	 * @param $type goods 或者 product
	 */
	public function getUpdateCartData($cartInfo,$gid,$num,$type)
	{
		$gid = intval($gid);
		$num = intval($num);
		if($type != 'goods')
		{
			$type = 'product';
		}

		//获取基本的商品数据
		$goodsRow = $this->getGoodInfo($gid,$type);
		if($goodsRow)
		{
			//购物车中已经存在此类商品
			if(isset($cartInfo[$type][$gid]))
			{
				if($goodsRow['store_nums'] < $cartInfo[$type][$gid] + $num)
				{
					$this->error = '该商品库存不足';
					return false;
				}
				$cartInfo[$type][$gid] += $num;
			}

			//购物车中不存在此类商品
			else
			{
				if($goodsRow['store_nums'] < $num)
				{
					$this->error = '该商品库存不足';
					return false;
				}
				$cartInfo[$type][$gid] = $num;
			}

			return $cartInfo;
		}
		else
		{
			$this->error = '该商品库存不足';
			return false;
		}
	}

	/**
	 * @brief 将商品或者货品加入购物车
	 * @param $gid  商品或者货品ID值
	 * @param $num  购买数量
	 * @param $type 加入类型 goods商品; product:货品;
	 */
	public function add($gid, $num = 1 ,$type = 'goods')
	{
		//购物车中已经存在此商品
		$cartInfo = $this->getMyCartStruct();

		if($this->getCartSort($cartInfo) >= $this->maxCount)
		{
			$this->error = '加入购物车失败,购物车中最多只能容纳'.$this->maxCount.'种商品';
			return false;
		}
		else
		{
			$cartInfo = $this->getUpdateCartData($cartInfo,$gid,$num,$type);
			if($cartInfo === false)
			{
				return false;
			}
			else
			{
				return $this->setMyCart($cartInfo);
			}
		}
	}

	//计算商品的种类
	private function getCartSort($mycart)
	{
		$sumSort   = 0;
		$sortArray = array('goods','product');

		foreach($sortArray as $sort)
		{
			$sumSort += count($mycart[$sort]);
		}
		return $sumSort;
	}

	//删除商品
	public function del($gid , $type = 'goods')
	{
		$cartInfo = $this->getMyCartStruct();
		if($type != 'goods')
		{
			$type = 'product';
		}

		//删除商品数据
		if(isset($cartInfo[$type][$gid]))
		{
			unset($cartInfo[$type][$gid]);
			$this->setMyCart($cartInfo);
		}
		else
		{
			$this->error = '购物车中没有此商品';
			return false;
		}
	}

	//根据 $gid 获取商品信息
	private function getGoodInfo($gid, $type = 'goods')
	{
		$dataArray = array();

		//商品方式
		if($type == 'goods')
		{
			$goodsObj  = new IModel('goods');
			$dataArray = $goodsObj->getObj('id = '.$gid.' and is_del = 0','id as goods_id,sell_price,store_nums');
			$dataArray['id'] = $dataArray['goods_id'];
		}

		//货品方式
		else
		{
			$productObj = new IQuery('products as pro , goods as go');
			$productObj->fields = ' go.id as goods_id , pro.sell_price , pro.store_nums ,pro.id ';
			$productObj->where  = ' pro.id = '.$gid.' and go.is_del = 0 and pro.goods_id = go.id';
			$productRow = $productObj->find();
			if($productRow)
			{
				$dataArray = $productRow[0];
			}
		}

		return $dataArray;
	}

	/**
	 * 获取当前购物车信息
	 * @return 获取cartStruct数据结构
	 */
	public function getMyCartStruct()
	{
		$cartName  = $this->getCartName();
		if($this->saveType == 'session')
		{
			$cartValue = ISession::get($cartName);
		}
		else
		{
			$cartValue = ICookie::get($cartName);
		}

		if($cartValue == null)
		{
			return $this->cartStruct;
		}
		else
		{
			$cartValue = JSON::decode(str_replace(array('&','$'),array('"',','),$cartValue));
			return $cartValue;
		}
	}

	/**
	 * 获取当前购物车信息
	 * @return 获取cartExeStruct数据结构
	 */
	public function getMyCart()
	{
		$cartName  = $this->getCartName();
		if($this->saveType == 'session')
		{
			$cartValue = ISession::get($cartName);
		}
		else
		{
			$cartValue = ICookie::get($cartName);
		}

		if($cartValue == null)
		{
			return $this->cartExeStruct;
		}
		else
		{
			$cartValue = JSON::decode(str_replace(array('&','$'),array('"',','),$cartValue));
			if(is_array($cartValue))
			{
				return $this->cartFormat($cartValue);
			}
			else
			{
				return $this->cartExeStruct;
			}
		}
	}

	//清空购物车
	public function clear()
	{
		$cartName = $this->getCartName();
		if($this->saveType == 'session')
		{
			ISession::clear($cartName);
		}
		else
		{
			ICookie::clear($cartName);
		}
	}

	//写入购物车
	public function setMyCart($goodsInfo)
	{
		$goodsInfo = str_replace(array('"',','),array('&','$'),JSON::encode($goodsInfo));
		$cartName = $this->getCartName();
		if($this->saveType == 'session')
		{
			ISession::set($cartName,$goodsInfo);
		}
		else
		{
			ICookie::set($cartName,$goodsInfo,'7200');
		}
		return true;
	}

	/**
	 * @brief  把cookie的结构转化成为程序所用的数据结构
	 * @param  $cartValue 购物车cookie存储结构
	 * @return array : [goods]=>array( ['id']=>商品ID , ['data'] => array( [商品ID]=>array ([name]商品名称 , [img]图片地址 , [sell_price]价格, [count]购物车中此商品的数量 ,[type]类型goods,product , [goods_id]商品ID值 ) ) ) , [product]=>array( 同上 ) , [count]购物车商品和货品数量 , [sum]商品和货品总额 ;
	 */
	private function cartFormat($cartValue)
	{
		//初始化结果
		$result = $this->cartExeStruct;

		$goodsIdArray = array();

		if(isset($cartValue['goods']) && $cartValue['goods'])
		{
			$goodsIdArray = array_keys($cartValue['goods']);
			$result['goods']['id'] = $goodsIdArray;
			foreach($goodsIdArray as $gid)
			{
				$result['goods']['data'][$gid] = array(
					'id'       => $gid,
					'type'     => 'goods',
					'goods_id' => $gid,
					'count'    => $cartValue['goods'][$gid],
				);

				//购物车中的种类数量累加
				$result['count'] += $cartValue['goods'][$gid];
			}
		}

		if(isset($cartValue['product']) && $cartValue['product'])
		{
			$productIdArray          = array_keys($cartValue['product']);
			$result['product']['id'] = $productIdArray;

			$productObj     = new IModel('products');
			$productData    = $productObj->query('id in ('.join(",",$productIdArray).')','id,goods_id,sell_price');
			foreach($productData as $proVal)
			{
				$result['product']['data'][$proVal['id']] = array(
					'id'         => $proVal['id'],
					'type'       => 'product',
					'goods_id'   => $proVal['goods_id'],
					'count'      => $cartValue['product'][$proVal['id']],
					'sell_price' => $proVal['sell_price'],
				);

				if(!in_array($proVal['goods_id'],$goodsIdArray))
				{
					$goodsIdArray[] = $proVal['goods_id'];
				}

				//购物车中的种类数量累加
				$result['count'] += $cartValue['product'][$proVal['id']];
			}
		}

		if($goodsIdArray)
		{
			$goodsArray = array();

			$goodsObj   = new IModel('goods');
			$goodsData  = $goodsObj->query('id in ('.join(",",$goodsIdArray).')','id,name,img,sell_price');
			foreach($goodsData as $goodsVal)
			{
				$goodsArray[$goodsVal['id']] = $goodsVal;
			}

			foreach($result['goods']['data'] as $key => $val)
			{
				$result['goods']['data'][$key]['img']        = Thumb::get($goodsArray[$val['goods_id']]['img'],120,120);
				$result['goods']['data'][$key]['name']       = $goodsArray[$val['goods_id']]['name'];
				$result['goods']['data'][$key]['sell_price'] = $goodsArray[$val['goods_id']]['sell_price'];

				//购物车中的金额累加
				$result['sum']   += $goodsArray[$val['goods_id']]['sell_price'] * $val['count'];
			}

			foreach($result['product']['data'] as $key => $val)
			{
				$result['product']['data'][$key]['img']  = Thumb::get($goodsArray[$val['goods_id']]['img'],120,120);
				$result['product']['data'][$key]['name'] = $goodsArray[$val['goods_id']]['name'];

				//购物车中的金额累加
				$result['sum']   += $result['product']['data'][$key]['sell_price'] * $val['count'];
			}
		}
		return $result;
	}

	//[私有]获取购物车名字
	private function getCartName()
	{
		return $this->cartName;
	}

	//获取错误信息
	public function getError()
	{
		return $this->error;
	}
}
?>