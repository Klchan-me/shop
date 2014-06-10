<?php
/**
 * @copyright (c) 2011 jooyea.cn
 * @file countsum.php
 * @brief 计算购物车中的商品价格
 * @author chendeshan
 * @date 2011-02-24
 * @version 0.6
 */
class CountSum
{
	//用户ID
	public $user_id = '';

	//用户组ID
	public $group_id = '';

	//用户组折扣
	public $group_discount = '';

	/**
	 * 构造函数
	 */
	public function __construct()
	{
		$this->user_id = ISafe::get('user_id');

		//获取用户组ID及组的折扣率
		if($this->user_id != null)
		{
			$groupObj = new IModel('member as m , user_group as g');
			$groupRow = $groupObj->getObj('m.user_id = '.$this->user_id.' and m.group_id = g.id','g.*');
			if($groupRow)
			{
				$this->group_id       = $groupRow['id'];
				$this->group_discount = $groupRow['discount'] * 0.01;
			}
		}
	}

	/**
	 * 获取会员组价格
	 * @param $id   int    商品或货品ID
	 * @param $type string goods:商品; product:货品
	 * @return float 价格
	 */
	public function getGroupPrice($id,$type = 'goods')
	{
		if(!$this->group_id)
		{
			return null;
		}

		//1,查询特定商品的组价格
		$groupPriceDB = new IModel('group_price');
		if($type == 'goods')
		{
			$discountRow = $groupPriceDB->getObj('product_id is NULL and goods_id = '.$id.' and group_id = '.$this->group_id,'price');
		}
		else
		{
			$discountRow = $groupPriceDB->getObj('product_id = '.$id.' and group_id = '.$this->group_id,'price');
		}

		if($discountRow)
		{
			return $discountRow['price'];
		}

		//2,根据会员折扣率计算商品折扣
		if($this->group_discount)
		{
			if($type == 'goods')
			{
				$goodsDB  = new IModel('goods');
				$goodsRow = $goodsDB->getObj('id = '.$id,'sell_price');
				return $goodsRow ? Util::priceFormat($goodsRow['sell_price'] * $this->group_discount) : null;
			}
			else
			{
				$productDB  = new IModel('products');
				$productRow = $productDB->getObj('id = '.$id,'sell_price');
				return $productRow ? Util::priceFormat($productRow['sell_price'] * $this->group_discount) : null;
			}
		}
		return null;
	}

	/**
	 * @brief 计算商品价格
	 * @param Array $buyInfo ,购物车格式
	 * @return array or bool
	 */
	public function goodsCount($buyInfo)
	{
		$this->sum           = 0;       //原始总额(优惠前)
		$this->final_sum     = 0;       //应付总额(优惠后)
    	$this->weight        = 0;       //总重量
    	$this->reduce        = 0;       //减少总额
    	$this->count         = 0;       //总数量
    	$this->promotion     = array(); //促销活动规则文本
    	$this->proReduce     = 0;       //促销活动规则优惠额
    	$this->point         = 0;       //增加积分
    	$this->exp           = 0;       //增加经验
    	$this->isFreeFreight = false;   //是否免运费

		$user_id      = $this->user_id;
		$group_id     = $this->group_id;
    	$goodsList    = array();
    	$productList  = array();

		/*开始计算goods和product的优惠信息 , 会根据条件分析出执行以下哪一种情况:
		 *(1)查看此商品(货品)是否已经根据不同会员组设定了优惠价格;
		 *(2)当前用户是否属于某个用户组中的成员，并且此用户组享受折扣率;
		 *(3)优惠价等于商品(货品)原价;
		 */

		//获取商品或货品数据
		/*Goods 拼装商品优惠价的数据*/
    	if(isset($buyInfo['goods']['id']) && $buyInfo['goods']['id'])
    	{
    		//购物车中的商品数据
    		$goodsIdStr = join(',',$buyInfo['goods']['id']);
    		$goodsObj   = new IModel('goods as go');
    		$goodsList  = $goodsObj->query('go.id in ('.$goodsIdStr.')','go.name,go.id,go.img,go.sell_price,go.point,go.weight,go.store_nums,go.exp');

    		//开始优惠情况判断
    		foreach($goodsList as $key => $val)
    		{
    			$groupPrice                = $this->getGroupPrice($val['id'],'goods');
    			$goodsList[$key]['reduce'] = $groupPrice === null ? 0 : $val['sell_price'] - $groupPrice;
    			$goodsList[$key]['count']  = $buyInfo['goods']['data'][$val['id']]['count'];
    			$current_sum_all           = $goodsList[$key]['sell_price'] * $goodsList[$key]['count'];
    			$current_reduce_all        = $goodsList[$key]['reduce']     * $goodsList[$key]['count'];
    			$goodsList[$key]['sum']    = $current_sum_all - $current_reduce_all;

    			//全局统计
		    	$this->weight += $val['weight'] * $goodsList[$key]['count'];
		    	$this->point  += $val['point']  * $goodsList[$key]['count'];
		    	$this->exp    += $val['exp']    * $goodsList[$key]['count'];
		    	$this->sum    += $current_sum_all;
		    	$this->reduce += $current_reduce_all;
		    	$this->count  += $goodsList[$key]['count'];
		    }
    	}

		/*Product 拼装商品优惠价的数据*/
    	if(isset($buyInfo['product']['id']) && $buyInfo['product']['id'])
    	{
    		//购物车中的货品数据
    		$productIdStr = join(',',$buyInfo['product']['id']);
    		$productObj   = new IQuery('products as pro,goods as go');
    		$productObj->where  = 'pro.id in ('.$productIdStr.') and go.id = pro.goods_id';
    		$productObj->fields = 'pro.sell_price,pro.weight,pro.id,pro.spec_array,pro.goods_id,pro.store_nums,go.name,go.point,go.exp,go.img';
    		$productList  = $productObj->find();

    		//开始优惠情况判断
    		foreach($productList as $key => $val)
    		{
    			$groupPrice                  = $this->getGroupPrice($val['id'],'product');
				$productList[$key]['reduce'] = $groupPrice === null ? 0 : $val['sell_price'] - $groupPrice;
    			$productList[$key]['count']  = $buyInfo['product']['data'][$val['id']]['count'];
    			$current_sum_all             = $productList[$key]['sell_price']  * $productList[$key]['count'];
    			$current_reduce_all          = $productList[$key]['reduce']      * $productList[$key]['count'];
    			$productList[$key]['sum']    = $current_sum_all - $current_reduce_all;

    			//全局统计
		    	$this->weight += $val['weight'] * $productList[$key]['count'];
		    	$this->point  += $val['point']  * $productList[$key]['count'];
		    	$this->exp    += $val['exp']    * $productList[$key]['count'];
		    	$this->sum    += $current_sum_all;
		    	$this->reduce += $current_reduce_all;
		    	$this->count  += $productList[$key]['count'];
		    }
    	}

    	$final_sum = $this->sum - $this->reduce;

    	//总金额满足的促销规则
    	if($user_id)
    	{
	    	$proObj = new ProRule($final_sum);
	    	$proObj->setUserGroup($group_id);
	    	$this->isFreeFreight = $proObj->isFreeFreight();
	    	$this->promotion = $proObj->getInfo();
	    	$this->proReduce = $final_sum - $proObj->getSum();
    	}
    	else
    	{
	    	$this->promotion = array();
	    	$this->proReduce = 0;
    	}

    	$this->final_sum = $final_sum - $this->proReduce;

    	return array(
    		'final_sum'  => $this->final_sum,
    		'promotion'  => $this->promotion,
    		'proReduce'  => $this->proReduce,
    		'sum'        => $this->sum,
    		'goodsList'  => $goodsList,
    		'productList'=> $productList,
    		'count'      => $this->count,
    		'reduce'     => $this->reduce,
    		'weight'     => $this->weight,
    		'freeFreight'=> $this->isFreeFreight,
    		'point'      => $this->point,
    		'exp'        => $this->exp,
    	);
	}

	//购物车计算
	public function cart_count()
	{
		//获取购物车中的商品和货品信息
    	$cartObj    = new Cart();
    	$myCartInfo = $cartObj->getMyCart();

    	return $this->goodsCount($myCartInfo);
    }

    //计算非购物车中的商品
    public function direct_count($id,$type,$buy_num = 1,$promo='',$active_id='')
    {
    	/*正常购买流程*/
    	if($promo == '' || $active_id == '')
    	{
    		$buyInfo = array(
    			$type => array('id' => array($id) , 'data' => array($id => array('count' => $buy_num)),'count' => $buy_num)
    		);
    		return $this->goodsCount($buyInfo);
    	}

		/*活动购买流程*/
    	$user_id = ISafe::get('user_id') ? ISafe::get('user_id') : 0;

		//获取货品数据
		if($type == 'product')
		{
			$model      = new IModel('goods as go,products as pro');
			$productRow = $model->getObj('pro.id = '.$id.' and pro.goods_id = go.id and go.is_del = 0','pro.sell_price,pro.weight,pro.id,pro.spec_array,pro.goods_id,pro.store_nums,go.name,go.point,go.exp,go.img');

			if(empty($productRow))
			{
				IError::show(403,'参数错误,无法找到商品信息');
			}
			$typeRow    = $productRow;
			$goods_id   = $typeRow['goods_id'];
		}

		//获取商品数据
		else
		{
			$model      = new IModel('goods as go');
			$goodsRow   = $model->getObj('id = '.$id.' and is_del = 0','go.name,go.id,go.img,go.sell_price,go.point,go.weight,go.store_nums,go.exp');

			if(empty($goodsRow))
			{
				IError::show(403,'参数错误,无法找到商品信息');
			}
			$typeRow    = $goodsRow;
			$goods_id   = $id;
		}

		//库存判断
		if($buy_num <= 0 || $buy_num > $typeRow['store_nums'])
		{
			IError::show(403,'购买的数量不正确或大于商品的库存量');
			exit;
		}

		//限时抢购
		if($promo == 'time')
		{
			$promotionObj = new IModel('promotion');
			$promotionRow = $promotionObj->getObj('type = 1 and `condition` = '.$goods_id.' and NOW() between start_time and end_time and is_close = 0');
			if(!empty($promotionRow))
			{
				$memberObj    = new IModel('member');
				$memberRow    = $memberObj->getObj('user_id = '.$user_id,'group_id');
				if($promotionRow['user_group'] == 'all' || (isset($memberRow['group_id']) && stripos(','.$promotionRow['user_group'].',',$memberRow['group_id'])!==false))
				{
					$disPrice = $promotionRow['award_value'];
				}
				else
				{
					IError::show(403,'此活动仅限指定的用户组');
				}
			}
			else
			{
				IError::show(403,'不存在此限时抢购活动');
			}
		}

		//团购
		else if($promo == 'groupon')
		{
			$regimentObj = new IModel('regiment');
			$regimentRow = $regimentObj->getObj('id = '.$active_id.' and goods_id = '.$goods_id.' and NOW() between start_time and end_time and is_close = 0');
			if(!empty($regimentRow))
			{
				$disPrice = $regimentRow['regiment_price'];
			}
			else
			{
				IError::show(403,'不存在此团购活动');
			}
		}

		//没有优惠价格时为商品原价
		if(!isset($disPrice))
		{
			$disPrice = $typeRow['sell_price'];
		}

		//设置优惠价格，如果不存在则优惠价等于商品原价
		$typeRow['reduce'] = $typeRow['sell_price'] - $disPrice;
		$typeRow['count']  = $buy_num;
		$typeRow['sum']    = $disPrice * $buy_num;

		//拼接返回数据
		$result = array(
			'final_sum'   => $typeRow['sum'],
			'promotion'   => array(),
			'proReduce'   => 0,
			'sum'         => $typeRow['sell_price'] * $buy_num,
			'goodsList'   => ($type == 'goods') ? array($typeRow) : array(),
			'productList' => ($type == 'product') ? array($typeRow) : array(),
			'count'       => $buy_num,
			'reduce'      => $typeRow['reduce'] * $buy_num,
			'weight'      => $typeRow['weight'] * $buy_num,
			'point'       => $typeRow['point']  * $buy_num,
			'exp'         => $typeRow['exp']    * $buy_num,
			'freeFreight' => false,
		);

		return $result;
    }

    /**
     * 计算订单信息,其中部分计算都是以商品原总价格计算的$goodsSum
     * @param $goodsSum float 商品原总金额
     * @param $goodsFinalSum 商品应付总金额
     * @param $goodsWeight float 商品总重量
     * @param $province_id int 省份ID
     * @param $delievery_id int 配送方式ID
     * @param $payment_id int 支付ID
     * @param $is_freeDelievery boolean 是否免运费
     * @param $is_insured boolean 是否有保价
     * @param $is_invoice boolean 是否要发票
     * @param $discount float 订单的加价或者减价
     * @return $result 最终的返回数组
     */
    public function countOrderFee($goodsSum,$goodsFinalSum,$goodsWeight,$province_id,$delivery_id,$payment_id,$is_freeDelievery,$is_insured,$is_invoice,$discount = 0)
    {
    	//最终的返回数组
    	$result = array(
    		//原本运费
    		'deliveryOrigPrice' => 0,

    		//实际运费
    		'deliveryPrice' => 0,

    		//保价
    		'insuredPrice' => 0,

    		//税金
    		'taxPrice' => 0,

    		//支付手续费
    		'paymentPrice' => 0,

    		//最终订单金额
    		'orderAmountPrice' => 0
    	);

		//计算运费和保价
    	$deliveryList = Delivery::getDelivery($province_id,$goodsWeight,$goodsSum);

    	//运费设置
    	$result['deliveryOrigPrice'] = $deliveryList[$delivery_id]['price'];
    	$result['deliveryPrice']     = $deliveryList[$delivery_id]['price'];

    	//免运费
    	if($is_freeDelievery == true)
    	{
	    	$result['deliveryPrice'] = 0;
    	}

    	//需要保价
    	if($is_insured == true)
    	{
    		$result['insuredPrice'] = $deliveryList[$delivery_id]['protect_price'];
    	}

    	//获取税率$tax
    	if($is_invoice == true)
    	{
    		$result['taxPrice'] = self::getGoodsTax($goodsSum);
    	}

		//非货到付款的线上支付方式手续费
		if($payment_id != 0)
		{
			$result['paymentPrice'] = self::getGoodsPaymentPrice($payment_id,$goodsSum);
		}

		//最终订单金额计算
		$order_amount = $goodsFinalSum + $result['deliveryPrice'] + $result['insuredPrice'] + $result['taxPrice'] + $result['paymentPrice'] + $discount;
		$result['orderAmountPrice'] = $order_amount <= 0 ? 0 : round($order_amount,2);

		return $result;
    }

    /**
     * 获取商品的税金
     * @param $goodsSum float 商品总价格
     * @return $goodsTaxPrice float 商品的税金
     */
    public static function getGoodsTax($goodsSum)
    {
    	$goodsTaxPrice = 0;
		$siteConfigObj = new Config("site_config");
		$site_config   = $siteConfigObj->getInfo();
		$tax_per       = isset($site_config['tax']) ? $site_config['tax'] : 0;
		$goodsTaxPrice = $goodsSum * ($tax_per * 0.01);
		return $goodsTaxPrice;
    }

    /**
     * 获取商品金额的支付费用
     * @param $payment_id int 支付方式ID
     * @param $goodsSum float 商品总价格
     * @return $goodsPayPrice
     */
    public static function getGoodsPaymentPrice($payment_id,$goodsSum)
    {
		$paymentObj = new IModel('payment');
		$paymentRow = $paymentObj->getObj('id = '.$payment_id,'poundage,poundage_type');

		if($paymentRow)
		{
			if($paymentRow['poundage_type'] == 1)
			{
				//按照百分比
				return $goodsSum * ($paymentRow['poundage'] * 0.01);
			}
			//按照固定金额
			return $paymentRow['poundage'];
		}
		return 0;
    }
}