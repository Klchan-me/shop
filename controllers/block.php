<?php
/**
 * @brief 公共模块
 * @class Block
 */
class Block extends IController
{
	public $layout='';

	public function init()
	{
		CheckRights::checkUserRights();
	}

 	/**
	 * @brief Ajax获取规格值
	 */
	function spec_value_list()
	{
		// 获取POST数据
		$spec_id = IFilter::act(IReq::get('id'),'int');

		//初始化spec商品模型规格表类对象
		$specObj = new IModel('spec');
		//根据规格编号 获取规格详细信息
		$specData = $specObj->getObj("id = $spec_id");
		if($specData)
		{
			echo JSON::encode($specData);
		}
		else
		{
			//返回失败标志
			echo '';
		}
	}

	//列出筛选商品
	function goods_list()
	{
		//商品检索条件
		$show_num    = IFilter::act( IReq::get('show_num'),'int');
		$keywords    = IFilter::act( IReq::get('keywords') );
		$cat_id      = IFilter::act( IReq::get('category_id'),'int' );
		$min_price   = IFilter::act( IReq::get('min_price'),'float' );
		$max_price   = IFilter::act( IReq::get('max_price'),'float' );
		$goods_no    = IFilter::act( IReq::get('goods_no') );
		$is_products = IFilter::act( IReq::get('is_products'),'int' );

		//查询条件
		$where      = 'go.is_del = 0';
		$table_name = 'goods as go';
		$fields     = 'go.id as goods_id,go.name,go.img,go.store_nums';

		//分类筛选
		if($cat_id)
		{
			$table_name .= ' ,category_extend as ca ';
			$where      .= " and ca.category_id = {$cat_id} and go.id = ca.goods_id ";
		}

		//货品存在
		if($is_products)
		{
			$fields     .= ' ,pro.id as product_id,pro.products_no as goods_no,pro.spec_array,pro.sell_price';
			$table_name .= ' ,products as pro ';
			$where      .= ' and pro.goods_id = go.id and (go.spec_array != "" or go.spec_array is not null) ';

			$where      .= $goods_no  ? ' and pro.products_no  = "'.$goods_no.'"' : '';
			$where      .= $min_price ? ' and pro.sell_price  >= '.$min_price     : '';
			$where      .= $max_price ? ' and pro.sell_price  <= '.$max_price     : '';
		}
		else
		{
			$fields     .= ' ,go.goods_no,go.sell_price';
			$where      .= ' and (go.spec_array = "" or go.spec_array is null) ';
			$where      .= $goods_no  ? ' and go.goods_no     = "'.$goods_no.'"' : '';
			$where      .= $min_price ? ' and go.sell_price  >= '.$min_price     : '';
			$where      .= $max_price ? ' and go.sell_price  <= '.$max_price     : '';
		}
		$where.= $keywords  ? ' and go.name like "%'.$keywords.'%"': '';

		$goodsDB    = new IModel($table_name);
		$this->data = $goodsDB->query($where,$fields,'go.id','desc',$show_num);
		$this->type = IReq::get('type');
		$this->redirect('goods_list');
	}
	/**
	 * @brief 获取地区
	 */
	public function area_child()
	{
		$parent_id = intval(IReq::get("aid"));
		$areaDB    = new IModel('areas');
		$data      = $areaDB->query("parent_id=$parent_id",'*','sort','asc');
		echo JSON::encode($data);
	}

    //[公共方法]通过解析products表中的spec_array转化为格式：key:规格名称;value:规格值
    public static function show_spec($specJson)
    {
    	$specArray = JSON::decode($specJson);
    	$spec      = array();

    	foreach($specArray as $val)
    	{
    		if($val['type'] == 1)
    		{
    			$spec[$val['name']] = $val['value'];
    		}
    		else
    		{
    			$spec[$val['name']] = '<img src="'.IUrl::creatUrl().$val['value'].'" class="img_border" style="width:15px;height:15px;" />';
    		}
    	}
    	return $spec;
    }
	/**
	 * @brief 获得配送方式ajax
	 */
	public function order_delivery()
    {
    	$province     = IFilter::act(IReq::get("province"),'int');
    	$weight       = IFilter::act(IReq::get('total_weight'),'float');
    	$goodsSum     = IFilter::act(IReq::get('goodsSum'),'float');
    	$distribution = IFilter::act(IReq::get("distribution"),'int');

    	//调入数据，获得配送方式结果
    	$data = Delivery::getDelivery($province,$weight,$goodsSum);

    	if($distribution)
    	{
    		echo JSON::encode($data[$distribution]);
    	}
    	else
    	{
    		echo JSON::encode($data);
    	}
    }
	/**
    * @brief 【重要】进行支付支付方法
    */
	public function doPay()
	{
		//获得相关参数
		$order_id   = IFilter::act(IReq::get('order_id'),'int');
		$recharge   = IReq::get('recharge');
		$payment_id = IFilter::act(IReq::get('payment_id'),'int');

		if($order_id)
		{
			//获取订单信息
			$orderDB  = new IModel('order');
			$orderRow = $orderDB->getObj('id = '.$order_id);

			if(empty($orderRow))
			{
				IError::show(403,'要支付的订单信息不存在');
			}
			$payment_id = $orderRow['pay_type'];
		}

		//获取支付方式类库
		$paymentInstance = Payment::createPaymentInstance($payment_id);

		//在线充值
		if($recharge !== null)
		{
			$recharge   = IFilter::act($recharge,'float');
			$paymentRow = Payment::getPaymentById($payment_id);

			//account:充值金额; paymentName:支付方式名字
			$reData   = array('account' => $recharge , 'paymentName' => $paymentRow['name']);
			$sendData = $paymentInstance->getSendData(Payment::getPaymentInfo($payment_id,'recharge',$reData));
		}
		//订单支付
		else if($order_id != 0)
		{
			$sendData = $paymentInstance->getSendData(Payment::getPaymentInfo($payment_id,'order',$order_id));
		}
		else
		{
			IError::show(403,'发生支付错误');
		}

		$this->paymentInstance = $paymentInstance;
		$this->sendData        = $sendData;
		$this->redirect('hidden_form',false);
	}

	/**
     * @brief 【重要】支付回调[同步]
	 */
	public function callback()
	{
		//从URL中获取支付方式
		$payment_id      = IFilter::act(IReq::get('_id'),'int');
		$paymentInstance = Payment::createPaymentInstance($payment_id);

		if(!is_object($paymentInstance))
		{
			IError::show(403,'支付方式不存在');
		}

		//初始化参数
		$money   = '';
		$message = '支付失败';
		$orderNo = '';

		//执行接口回调函数
		$callbackData = array_merge($_POST,$_GET);
		unset($callbackData['controller']);
		unset($callbackData['action']);
		unset($callbackData['_id']);
		$return = $paymentInstance->callback($callbackData,$payment_id,$money,$message,$orderNo);

		//支付成功
		if($return == 1)
		{
			//充值方式
			if(stripos($orderNo,'recharge_') !== false)
			{
				$tradenoArray = explode('_',$orderNo);
				$recharge_no  = isset($tradenoArray[1]) ? $tradenoArray[1] : 0;
				if(payment::updateRecharge($recharge_no))
				{
					$this->redirect('/site/success/message/'.urlencode("充值成功").'/?callback=/ucenter/account_log');
					exit;
				}
				IError::show(403,'充值失败');
			}
			else
			{
				$order_id = Order_Class::updateOrderStatus($orderNo);
				if($order_id)
				{
					$url  = '/site/success/message/'.urlencode("支付成功");
					$url .= ISafe::get('user_id') ? '/?callback=/ucenter/order_detail/id/'.$order_id : '';
					$this->redirect($url);
					exit;
				}
				IError::show(403,'订单修改失败');
			}
		}
		//支付失败
		else
		{
			$message = $message ? $message : '支付失败';
			IError::show(403,$message);
		}
	}

	/**
     * @brief 【重要】支付回调[异步]
	 */
	function server_callback()
	{
		//从URL中获取支付方式
		$payment_id      = IFilter::act(IReq::get('_id'),'int');
		$paymentInstance = Payment::createPaymentInstance($payment_id);

		if(!is_object($paymentInstance))
		{
			die('fail');
		}

		//初始化参数
		$money   = '';
		$message = '支付失败';
		$orderNo = '';

		//执行接口回调函数
		$callbackData = array_merge($_POST,$_GET);
		unset($callbackData['controller']);
		unset($callbackData['action']);
		unset($callbackData['_id']);
		$return = $paymentInstance->callback($callbackData,$payment_id,$money,$message,$orderNo);

		//支付成功
		if($return == 1)
		{
			//充值方式
			if(stripos($orderNo,'recharge_') !== false)
			{
				$tradenoArray = explode('_',$orderNo);
				$recharge_no  = isset($tradenoArray[1]) ? $tradenoArray[1] : 0;
				if(payment::updateRecharge($recharge_no))
				{
					$paymentInstance->notifyStop();
					exit;
				}
			}
			else
			{
				$order_id = Order_Class::updateOrderStatus($orderNo);
				if($order_id)
				{
					$paymentInstance->notifyStop();
					exit;
				}
			}
		}
		//支付失败
		else
		{
			$paymentInstance->notifyStop();
			exit;
		}
	}

	/**
    * @brief 根据省份名称查询相应的privice
    */
	public function searchPrivice()
	{
		$province = IFilter::act(IReq::get('province'));

		$tb_areas = new IModel('areas');
		$areas_info = $tb_areas->getObj('parent_id = 0 and area_name like "%'.$province.'%"','area_id');
		$result = array('flag' => 'fail','area_id' => 0);
		if($areas_info)
		{
			$result = array('flag' => 'success','area_id' => $areas_info['area_id']);
		}
		echo JSON::encode($result);
	}
    //添加实体代金券
    function add_download_ticket()
    {
    	$isError = true;

    	$ticket_num = IFilter::act(IReq::get('ticket_num'));
    	$ticket_pwd = IFilter::act(IReq::get('ticket_pwd'));

    	$propObj = new IModel('prop');
    	$propRow = $propObj->getObj('card_name = "'.$ticket_num.'" and card_pwd = "'.$ticket_pwd.'" and type = 0 and is_userd = 0 and is_send = 1 and is_close = 0 and NOW() between start_time and end_time');

    	if(empty($propRow))
    	{
    		$message = '代金券不可用，请确认代金券的卡号密码并且此代金券从未被使用过';
    	}
    	else
    	{
    		//登录用户
    		if($this->user['user_id'])
    		{
	    		$memberObj = new IModel('member');
	    		$memberRow = $memberObj->getObj('user_id = '.$this->user['user_id'],'prop');
	    		if(stripos($memberRow['prop'],','.$propRow['id'].',') !== false)
	    		{
	    			$message = '代金券已经存在，不能重复添加';
	    		}
	    		else
	    		{
		    		$isError = false;
		    		$message = '添加成功';

		    		if($memberRow['prop'] == '')
		    		{
		    			$propUpdate = ','.$propRow['id'].',';
		    		}
		    		else
		    		{
		    			$propUpdate = $memberRow['prop'].$propRow['id'].',';
		    		}

		    		$dataArray = array('prop' => $propUpdate);
		    		$memberObj->setData($dataArray);
		    		$memberObj->update('user_id = '.$this->user['user_id']);
	    		}
    		}
    		//游客方式
    		else
    		{
				$isError = false;
				$message = '添加成功';
    			ISafe::set("ticket_".$propRow['id'],$propRow['id']);
    		}
    	}

    	$result = array(
    		'isError' => $isError,
    		'data'    => $propRow,
    		'message' => $message,
    	);

    	echo JSON::encode($result);
    }

	private function alert($msg)
	{
		header('Content-type: text/html; charset=UTF-8');
		echo JSON::encode(array('error' => 1, 'message' => $msg));
		exit;
	}
    /**
     * 筛选用户
     */
    public function filter_user()
    {
    	$email     = IFilter::act(IReq::get('email'));
    	$username  = IFilter::act(IReq::get('username'));
    	$true_name = IFilter::act(IReq::get('true_name'));
    	$group_id  = IFilter::act(IReq::get('group_id'));

		$where   = '1';
		$userIds = '';

    	if($email)
    	{
    		$where .= ' and u.email = "'.$email.'"';
    	}

    	if($username)
    	{
    		$where .= ' and u.username = "'.$username.'"';
    	}

    	if($true_name)
    	{
    		$where .= ' and m.true_name = "'.$true_name.'"';
    	}

    	if($group_id)
    	{
    		$where .= ' and m.group_id = "'.$group_id.'"';
    	}

    	//有筛选条件
    	if($where != '1')
    	{
	    	$userDB = new IQuery('user as u');
	    	$userDB->join  = 'left join member as m on u.id = m.user_id';
	    	$userDB->fields= 'u.id';
	    	$userDB->where = $where;
	    	$userData      = $userDB->find();
	    	$tempArray     = array();
	    	foreach($userData as $key => $item)
	    	{
	    		$tempArray[] = $item['id'];
	    	}
	    	$userIds = join(',',$tempArray);
    	}

    	die('<script type="text/javascript">parent.searchUserCallback("'.$userIds.'");</script>');
    }
}