<?php
/**
 * @brief 订单模块
 * @class Order
 * @note  后台
 */
class Order extends IController
{
	public $checkRight  = 'all';
	public $layout='admin';
	function init()
	{
		IInterceptor::reg('CheckRights@onCreateAction');
	}
	/**
	 * @brief查看订单
	 */
	public function order_show()
	{
		//获得post传来的值
		$order_id = IFilter::act(IReq::get('id'),'int');
		$data = array();
		if($order_id)
		{
			$order_show = new Order_Class();
			$data = $order_show->getOrderShow($order_id);
			if($data)
			{
				//获得折扣前的价格
			 	$rule = new ProRule($data['real_amount']);
			 	$this->result = $rule->getInfo();

		 		//获取地区
		 		$areas_id = $data['province'].','.$data['city'].','.$data['area'];
		 		$tb_area = new IModel('areas');
		 		$area_info = $tb_area->query('area_id in ('.$areas_id.')');
		 		$data['area_addr'] = $area_info[0]['area_name'].'&nbsp;'.$area_info[1]['area_name'].'&nbsp;'.$area_info[2]['area_name'];

			 	$this->setRenderData($data);
				$this->redirect('order_show',false);
			}
		}
		if(!$data)
		{
			$this->redirect('order_list');
		}
	}
	/**
	 * @brief查看收款单
	 */
	public function collection_show()
	{
		//获得post传来的收款单id值
		$collection_id = IFilter::act(IReq::get('id'),'int');
		$data = array();
		if($collection_id)
		{
			$tb_collection = new IQuery('collection_doc as c ');
			$tb_collection->join=' left join order as o on c.order_id=o.id left join payment as p on c.payment_id = p.id left join user as u on u.id = c.user_id';
			$tb_collection->fields = 'o.order_no,p.name as pname,o.create_time,p.type,u.username,c.amount,o.pay_time,c.admin_id,c.note';
			$tb_collection->where = 'c.id='.$collection_id;
			$collection_info = $tb_collection->find();
			if($collection_info)
			{
				$data = $collection_info[0];

				$this->setRenderData($data);
				$this->redirect('collection_show',false);
			}
		}
		if(count($data)==0)
		{
			$this->redirect('order_collection_list');
		}
	}
	/**
	 * @brief查看退款单
	 */
	public function refundment_show()
	{
	 	//获得post传来的退款单id值
	 	$refundment_id = IFilter::act(IReq::get('id'),'int');
	 	$data = array();
	 	if($refundment_id)
	 	{
	 		$tb_refundment = new IQuery('refundment_doc as c');
	 		$tb_refundment->join=' left join order as o on c.order_id=o.id left join user as u on u.id = c.user_id';
	 		$tb_refundment->fields = 'o.order_no,o.create_time,u.username,c.*';
	 		$tb_refundment->where = 'c.id='.$refundment_id;
	 		$refundment_info = $tb_refundment->find();
	 		if(count($refundment_info)>0)
	 		{
	 			$data = $refundment_info[0];
	 			$this->setRenderData($data);
	 			$this->redirect('refundment_show',false);
	 		}
	 	}
	 	if(!$data)
		{
			$this->redirect('order_refundment_list');
		}
	}
	/**
	 * @brief查看申请退款单
	 */
	public function refundment_doc_show()
	{
	 	//获得post传来的申请退款单id值
	 	$refundment_id = IFilter::act(IReq::get('id'),'int');
	 	$data = array();
	 	if($refundment_id)
	 	{
	 		$tb_refundment = new IQuery('refundment_doc');
	 		$tb_refundment->fields = '*';
	 		$tb_refundment->where = 'id='.$refundment_id;
	 		$refundment_info = $tb_refundment->find();
	 		if($refundment_info)
	 		{
	 			$data = $refundment_info[0];
	 			$this->setRenderData($data);
	 			$this->redirect('refundment_doc_show',false);
	 		}
	 	}
	 	if(!$data)
		{
			$this->redirect('refundment_list');
		}
	}
	//删除申请退款单
	public function refundment_doc_del()
	{
		//获得post传来的申请退款单id值
		$refundment_id = IFilter::act(IReq::get('id'),'int');
		if(is_array($refundment_id))
		{
			$refundment_id = implode(",",$refundment_id);
		}
		if($refundment_id)
		{
			$tb_refundment_doc = new IModel('refundment_doc');
			$tb_refundment_doc->setData(array('if_del' => 1));
			$tb_refundment_doc->update("id IN ($refundment_id)");
		}

		$logObj = new log('db');
		$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"退款单移除到回收站",'移除的ID：'.$refundment_id));

		$this->redirect('refundment_list');
	}

	/**
	 * @brief更新申请退款单
	 */
	public function refundment_doc_show_save()
	{
		//获得post传来的退款单id值
		$refundment_id = IFilter::act(IReq::get('rid'),'int');
		$pay_status = IFilter::act(IReq::get('pay_status'),'int');
		$dispose_idea = IFilter::act(IReq::get('dispose_idea'));

		//获得refundment_doc对象
		$tb_refundment_doc = new IModel('refundment_doc');
		$tb_refundment_doc->setData(array(
			'pay_status'=>$pay_status,
			'dispose_idea'=>$dispose_idea,
			'dispose_time'=>date('Y-m-d H:i:s')
		));
		if($refundment_id)
		{
			$tb_refundment_doc->update('id='.$refundment_id);

			$logObj = new log('db');
			$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"修改了退款单",'修改的ID：'.$refundment_id));
		}
		$this->redirect('refundment_list');
	}
	/**
	 * @brief查看发货单
	 */
	public function delivery_show()
	{
	 	//获得post传来的发货单id值
	 	$delivery_id = IFilter::act(IReq::get('id'),'int');
	 	$data = array();
	 	if($delivery_id)
	 	{
	 		$tb_delivery = new IQuery('delivery_doc as c ');
	 		$tb_delivery->join=' left join order as o on c.order_id=o.id left join delivery as p on c.delivery_type = p.id left join user as u on u.id = c.user_id';
	 		$tb_delivery->fields = 'o.order_no,c.order_id,p.name as pname,o.create_time,u.username,c.name,c.province,c.city,c.area,c.address,c.mobile,c.telphone,c.postcode,c.freight,c.delivery_code,c.time,c.note ';
	 		$tb_delivery->where = 'c.id='.$delivery_id;
	 		$delivery_info = $tb_delivery->find();
	 		if(count($delivery_info)>0)
	 		{
	 			$data = $delivery_info[0];

	 			$data['country'] = '';
	 			$tb_area = new IModel('areas');
	 			$area_info = $tb_area->query('area_id in ('.$data['province'].','.$data['city'].','.$data['area'].')');
	 			if(count($area_info)>0)
	 			{
	 				$data['country'] .= $area_info[0]['area_name'].'-';
	 				$data['country'] .= $area_info[1]['area_name'].'-';
	 				$data['country'] .= $area_info[2]['area_name'];
	 			}
	 			$this->setRenderData($data);
	 			$this->redirect('delivery_show',false);
	 		}
	 	}
	 	if(count($data)==0)
		{
			$this->redirect('order_delivery_list');
		}
	}
	/**
	 * @brief 支付订单页面collection_doc
	 */
	public function order_collection()
	{
	 	//去掉左侧菜单和上部导航
	 	$this->layout='';
	 	$order_id = IFilter::act(IReq::get('id'),'int');
	 	$data = array();
	 	if($order_id)
	 	{
	 		$order_show = new Order_Class();
	 		$data = $order_show->getOrderShow($order_id);
	 	}
	 	$this->setRenderData($data);
	 	$this->redirect('order_collection');
	}
	/**
	 * @brief 保存支付订单页面collection_doc
	 */
	public function order_collection_doc()
	{
	 	//获得订单号
	 	$order_no = IFilter::act(IReq::get('order_no'));
	 	$note     = IFilter::act(IReq::get('note'));

	 	if(Order_Class::updateOrderStatus($order_no,$this->admin['admin_id'],$note))
	 	{
		 	//生成订单日志
	    	$tb_order_log = new IModel('order_log');
	    	$tb_order_log->setData(array(
	    		'order_id' =>IFilter::act(IReq::get('id'),'int'),
	    		'user' =>$this->admin['admin_name'],
	    		'action' =>'付款',
	    		'result' =>'成功',
	    		'note' =>'订单【'.$order_no.'】付款'.IFilter::act(IReq::get('amount'),'float'),
	    		'addtime'=>date('Y-m-d H:i:s')
	    	));
	    	$tb_order_log->add();

			$logObj = new log('db');
			$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"订单更新为已付款","订单号：".$order_no.'，已经确定付款'));
	 		echo '<script type="text/javascript">parent.actionCallback();</script>';
	 	}
	 	else
	 	{
	 		echo '<script type="text/javascript">parent.actionFailCallback();</script>';
	 	}
	}
	/**
	 * @brief 退款单页面
	 */
	public function order_refundment()
	{
		//去掉左侧菜单和上部导航
		$this->layout='';
		$order_id = IFilter::act(IReq::get('id'),'int');
		$data = array();
		if($order_id)
		{
		$order_show = new Order_Class();
		$data = $order_show->getOrderShow($order_id);
		}
		$this->setRenderData($data);
		$this->redirect('order_refundment');
	}
	/**
	 * @brief 保存退款单页面
	 */
	public function order_refundment_doc()
	{
		//获得post变量参数
		$order_id = IFilter::act(IReq::get('id'),'int');
		$order_no = IFilter::act(IReq::get('order_no'));
		$user_id  = IFilter::act(IReq::get('user_id'),'int');
		$amount   = IFilter::act(IReq::get('amount'),'float');

		if(!$user_id)
		{
			echo '<script text="text/javascript">parent.actionFailCallback("游客无法退款");</script>';
			exit;
		}

		$tb_refundment_doc = new IModel('refundment_doc');
		$arr = array(
			'order_id' => $order_id,
			'order_no' => $order_no,
			'user_id'  => $user_id,
			'amount'   => $amount,
			'if_del'   => 0,
			'admin_id' =>$this->admin['admin_id']
		);
		$refundmentObj = $tb_refundment_doc->getObj('order_id = '.$order_id);

		if($refundmentObj)
		{
			$tb_refundment_doc->setData($arr);
			$tb_refundment_doc->update('order_id='.$order_id);
		}
		else
		{
			$arr['time'] = date('Y-m-d H:i:s');
			$arr['pay_status'] = '2';
			$arr['dispose_time'] = date('Y-m-d H:i:s');
			$arr['dispose_idea'] = '退款成功';
			$tb_refundment_doc->setData($arr);
			$tb_refundment_doc->add();
		}

		//更新发货状态
		$tb_order = new IModel('order');
		$tb_order -> setData(array(
			'pay_status' => 2
		));
		$tb_order->update('id='.$order_id);
		//生成订单日志
		$tb_order_log = new IModel('order_log');
		$tb_order_log->setData(array(
			'order_id' =>$order_id,
			'user' =>$this->admin['admin_name'],
			'action' =>'退款',
			'result' =>'成功',
			'note' =>'订单【'.$order_no.'】退款',
			'addtime'=>date('Y-m-d H:i:s')
		));
		$tb_order_log->add();

		//作废订单-还原红包
		$prop = 'id = '.$order_id.' and pay_status =0 and prop is not null';
		$order_info = $tb_order->query($prop);
		if(count($order_info)>0)
		{
			$tb_prop = new IModel('prop');
			foreach ($order_info as $value)
			{
				$tb_prop->setData(array('is_close'=>0));
				if($value['prop'])
				{
					$tb_prop->update('id='.$value['prop']);
				}
			}
		}

		$logObj = new log('db');
		$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"订单更新为退款",'订单号：'.$arr['order_no']));

		//进行用户的余额增加操作
		$obj = new IModel('member');
		$memberObj = $obj->getObj('user_id = '.$user_id,'balance');
		$updateAmount = $memberObj['balance'] + $amount;
		$obj->setData(array('balance' => $updateAmount));
		$isSuccess = $obj->update('user_id = '.$user_id);

		if($isSuccess)
		{
			//用户余额进行的操作记入account_log表
			$log = new AccountLog();
			$config = array
			(
				'user_id'  => $user_id,
				'admin_id' => $this->admin['admin_id'], //如果需要的话
				'event'    => 'drawback', //withdraw:提现,pay:余额支付,recharge:充值,drawback:退款到余额
				'num'      => $amount, //整形或者浮点，正为增加，负为减少
				'order_no' => $order_no // drawback类型的log需要这个值
			);
			$re = $log->write($config);
			echo '<script text="text/javascript">parent.actionCallback();</script>';
		}
		else
		{
			echo '<script text="text/javascript">parent.actionFailCallback();</script>';
		}
	}
	/**
	 * @brief 保存订单备注
	 */
	public function order_note()
	{
	 	//获得post数据
	 	$order_id = IFilter::act(IReq::get('order_id'),'int');
	 	$note = IFilter::act(IReq::get('note'),'text');

	 	//获得order的表对象
	 	$tb_order =  new IModel('order');
	 	$tb_order->setData(array(
	 		'note'=>$note
	 	));
	 	$tb_order->update('id='.$order_id);
	 	IReq::set('id',$order_id);
	 	$this->order_show();

	}
	/**
	 * @brief 保存顾客留言
	 */
	public function order_message()
	{
		//获得post数据
		$order_id = IFilter::act(IReq::get('order_id'),'int');
		$user_id = IFilter::act(IReq::get('user_id'),'int');
		$title = IFilter::act(IReq::get('title'));
		$content = IFilter::act(IReq::get('content'),'text');

		//获得message的表对象
		$tb_message =  new IModel('message');
		$tb_message->setData(array(
			'title'=>$title,
			'content' =>$content,
			'time'=>date('Y-m-d H:i:s')
		));
		$message_id = $tb_message->add();
		//获的mess类
		$message = new Mess($user_id);
		$message->writeMessage($message_id);
		IReq::set('id',$order_id);
		$this->order_show();
	}
	/**
	 * @brief 完成或作废订单页面
	 **/
	public function order_complete()
	{
		//去掉左侧菜单和上部导航
		$this->layout='';
		$order_id = IFilter::act(IReq::get('id'),'int');
		$type     = IFilter::act(IReq::get('type'),'int');
		$order_no = IFilter::act(IReq::get('order_no'));

		//oerder表的对象
		$tb_order = new IModel('order');
		$tb_order->setData(
		array(
			'status'          => $type,
			'completion_time' => date('Y-m-d H:i:s')
		));
		$tb_order->update('id='.$order_id);

		//生成订单日志
		$tb_order_log = new IModel('order_log');
		$action = '作废';
		$note   = '订单【'.$order_no.'】作废成功';

		if($type=='5')
		{
			$action = '完成';
			$note   = '订单【'.$order_no.'】完成成功';

			//增加用户评论商品机会
			Order_Class::addGoodsCommentChange($order_id);

			$logObj = new log('db');
			$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"订单更新为完成",'订单号：'.$order_no));
		}
		else
		{
			//作废订单-还原红包
			$prop = 'id = '.$order_id.' and pay_status =0 and prop is not null';
			$order_info = $tb_order->query($prop);
			if($order_info)
			{
				$tb_prop = new IModel('prop');
				foreach ($order_info as $value)
				{
					$tb_prop->setData(array('is_close'=>0));
					if($value['prop'])
					{
						$tb_prop->update('id='.$value['prop']);
					}
				}
			}

			$logObj = new log('db');
			$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"订单更新为作废",'订单号：'.$order_no));
		}

		$tb_order_log->setData(array(
			'order_id' =>$order_id,
			'user' =>$this->admin['admin_name'],
			'action' =>$action,
			'result' =>'成功',
			'note' =>$note,
			'addtime'=>date('Y-m-d H:i:s')
		));
		$tb_order_log->add();
		echo 'success';
	}
	/**
	 * @brief 发货订单页面
	 */
	public function order_deliver()
	{
		//去掉左侧菜单和上部导航
		$this->layout='';
		$order_id = IFilter::act(IReq::get('id'),'int');
		$data = array();
		if($order_id)
		{
			$order_show = new Order_Class();
			$data = $order_show->getOrderShow($order_id);
		}
		$this->setRenderData($data);
		$this->redirect('order_deliver');
	}
	/**
	 * @brief 发货操作
	 */
	public function order_delivery_doc()
	{
	 	//获得post变量参数
	 	$order_id = IFilter::act(IReq::get('id'),'int');

	 	//获得delivery_doc表的对象
	 	$tb_delivery_doc = new IModel('delivery_doc');
	 	$tb_delivery_doc->setData(array
	 	(
	 		'order_id' => $order_id,
	 		'user_id'  => IFilter::act(IReq::get('user_id'),'int'),
	 		'admin_id' => $this->admin['admin_id'],
	 		'name'     => IFilter::string(IReq::get('name')),
	 		'postcode' => IFilter::act(IReq::get('postcode'),'int'),
	 		'telphone' => IFilter::act(IReq::get('telphone')),
	 		'province' => IFilter::act(IReq::get('province'),'int'),
	 		'city'     => IFilter::act(IReq::get('city'),'int'),
	 		'area'     => IFilter::act(IReq::get('area'),'int'),
	 		'address'  => IFilter::act(IReq::get('address')),
	 		'mobile'   => IFilter::string(IReq::get('mobile')),
	 		'time'     => date('Y-m-d H:i:s'),
	 		'freight'  => IFilter::act(IReq::get('freight'),'float'),
	 		'delivery_code' => IFilter::act(IReq::get('delivery_code')),
	 		'delivery_type' => IFilter::act(IReq::get('delivery_type')),
	 		'note' => IFilter::string(IReq::get('note'),'text'),
	 		'if_del'=>0
	 	));
	 	$tb_delivery_doc->add();

	 	//更新发货状态
	 	$tb_order = new IModel('order');
	 	$tb_order->setData(array
	 	(
	 		'distribution_status' => 1,
	 		'status'              => 2,
	 		'send_time'           => date('Y-m-d H:i:s')
	 	));
	 	$tb_order->update('id='.$order_id);

	 	//生成订单日志
    	$tb_order_log = new IModel('order_log');
    	$tb_order_log->setData(array(
    		'order_id' => $order_id,
    		'user'     => $this->admin['admin_name'],
    		'action'   => '发货',
    		'result'   => '成功',
    		'note'     => '订单【'.IFilter::act(IReq::get('order_no')).'】发货成功',
    		'addtime'  => date('Y-m-d H:i:s')
    	));
    	$sendResult = $tb_order_log->add();

    	//同步发货接口，如支付宝担保交易等
    	if($sendResult)
    	{
    		sendgoods::run($order_id);
    	}

    	echo '<script type="text/javascript">parent.actionCallback();</script>';
	 	exit;
	}
	/**
	 * @brief 保存修改订单
	 */
    public function order_update()
    {
    	//获取必要数据
    	$order_id = IReq::get('id');

    	//生成order数据
    	$dataArray['invoice_title'] = IFilter::act(IReq::get('invoice_title'));
    	$dataArray['invoice']       = IFilter::act(IReq::get('invoice'),'int');
    	$dataArray['insured']       = IFilter::act(IReq::get('insured'),'float');
    	$dataArray['if_insured']    = IFilter::act(IReq::get('if_insured'),'int');
    	$dataArray['pay_type']      = IFilter::act(IReq::get('pay_type'),'int');
    	$dataArray['accept_name']   = IFilter::act(IReq::get('accept_name'));
    	$dataArray['postcode']      = IFilter::act(IReq::get('postcode'));
    	$dataArray['telphone']      = IFilter::act(IReq::get('telphone'));
    	$dataArray['province']      = IFilter::act(IReq::get('province'),'int');
    	$dataArray['city']          = IFilter::act(IReq::get('city'),'int');
    	$dataArray['area']          = IFilter::act(IReq::get('area'),'int');
    	$dataArray['address']       = IFilter::act(IReq::get('address'));
    	$dataArray['mobile']        = IFilter::act(IReq::get('mobile'));
    	$dataArray['discount']      = IFilter::act(IReq::get('discount'),'float');
    	$dataArray['postscript']    = IFilter::act(IReq::get('postscript'));
    	$dataArray['distribution']  = IFilter::act(IReq::get('distribution'),'int');
    	$dataArray['accept_time']   = IFilter::act(IReq::get('accept_time'));

		$goods_id   = IReq::get('goods_id');
		$product_id = IReq::get('product_id');
		$goods_nuns = IReq::get('goods_nums');

		//设置订单持有者
		$username = IFilter::act(IReq::get('username'));
		$userDB   = new IModel('user');
		$userRow  = $userDB->getObj('username = "'.$username.'"');
		$dataArray['user_id'] = isset($userRow['id']) ? $userRow['id'] : 0;

		//拼接要购买的商品或货品数据,组装成固有的数据结构便于计算价格
		$length = count($product_id);
		$buyInfo = array(
			'goods' => array('id' => array() , 'data' => array()),
			'product' => array('id' => array() , 'data' => array())
		);
		for($i = 0;$i < $length;$i++)
		{
			//货品数据
			if(intval($product_id[$i]) > 0)
			{
				$buyInfo['product']['id'][] = $product_id[$i];
				$buyInfo['product']['data'][$product_id[$i]] = array('count' => $goods_nuns[$i]);
			}
			//商品数据
			else
			{
				$buyInfo['goods']['id'][] = $goods_id[$i];
				$buyInfo['goods']['data'][$goods_id[$i]] = array('count' => $goods_nuns[$i]);
			}
		}

		//开始算账
		$countSumObj = new CountSum();
		$goodsResult = $countSumObj->goodsCount($buyInfo);
		$orderFee    = $countSumObj->countOrderFee($goodsResult['sum'],$goodsResult['final_sum'],$goodsResult['weight'],$dataArray['province'],$dataArray['distribution'],$dataArray['pay_type'],$goodsResult['freeFreight'],$dataArray['if_insured'],$dataArray['invoice'],$dataArray['discount']);

		//获取原价的运费
		$dataArray['payable_freight']= $orderFee['deliveryOrigPrice'];
		$dataArray['payable_amount'] = $goodsResult['sum'];
		$dataArray['real_amount']    = $goodsResult['final_sum'];
		$dataArray['real_freight']   = $orderFee['deliveryPrice'];
		$dataArray['insured']        = $orderFee['insuredPrice'];
		$dataArray['pay_fee']        = $orderFee['paymentPrice'];
		$dataArray['taxes']          = $orderFee['taxPrice'];
		$dataArray['promotions']     = $goodsResult['proReduce']+$goodsResult['reduce'];
		$dataArray['order_amount']   = $orderFee['orderAmountPrice'];
		$dataArray['exp']            = $goodsResult['exp'];
		$dataArray['point']          = $goodsResult['point'];

    	//生成订单
    	$orderDB = new IModel('order');

    	//修改操作
    	if($order_id)
    	{
    		$orderDB->setData($dataArray);
    		$orderDB->update('id = '.$order_id);

    		//获取订单信息
    		$orderRow = $orderDB->getObj('id = '.$order_id);

			//记录日志信息
			$logObj = new log('db');
			$logObj->write('operation',array("管理员:".$this->admin['admin_name'],"修改了订单信息",'订单号：'.$orderRow['order_no']));
    	}
    	//添加操作
    	else
    	{
    		$dataArray['create_time'] = date('Y-m-d H:i:s');
    		$dataArray['order_no']    = Order_Class::createOrderNum();

    		$orderDB->setData($dataArray);
    		$order_id = $orderDB->add();

			//记录日志信息
			$logObj = new log('db');
			$logObj->write('operation',array("管理员:".$this->admin['admin_name'],"添加了订单信息",'订单号：'.$dataArray['order_no']));
    	}

    	//同步order_goods表
    	$orderInstance = new Order_Class();
    	$orderInstance->insertOrderGoods($order_id,$goodsResult);

    	$this->redirect('order_list');
    }
	/**
	 * @brief 修改订单
	 */
	public function order_edit()
    {
    	$data = array();

    	//获得order_id的值
		$order_id = IFilter::act(IReq::get('id'),'int');
		if($order_id)
		{
			$orderDB = new IModel('order');
			$data    = $orderDB->getObj('id = '.$order_id);
			$this->orderRow = $data;

			//获取订单中的商品信息
			$orderGoodsDB         = new IQuery('order_goods as og');
			$orderGoodsDB->join   = "left join goods as go on og.goods_id = go.id left join products as p on p.id = og.product_id";
			$orderGoodsDB->fields = "go.id,go.name,p.spec_array,p.id as product_id,og.real_price,og.goods_nums";
			$orderGoodsDB->where  = "og.order_id = ".$order_id;
			$this->orderGoods     = $orderGoodsDB->find();

			//获取用户名
			if($data['user_id'])
			{
				$userDB  = new IModel('user');
				$userRow = $userDB->getObj("id = ".$data['user_id']);
				$this->username = isset($userRow['username']) ? $userRow['username'] : '';
			}
		}
		$this->redirect('order_edit');
    }
    /**
     * @brief 订单列表
     */
    public function order_list()
    {
    	$data = array();

    	$name = IFilter::act(IReq::get('name'));
    	$order_no = IFilter::act(IReq::get('order_no'));
    	$where = '';
    	if($name)
    	{
    		$where .= " and u.username like '%{$name}%'";
    	}
    	if($order_no)
    	{
    		$where .= " and o.order_no like '%{$order_no}%'";
    	}
    	$data['name'] = $name;
    	$data['order_no'] = $order_no;

    	//获得筛选post
    	$pay_status          = IFilter::act(IReq::get('pay_status'));
    	$distribution_status = IFilter::act(IReq::get('distribution_status'));
    	$status              = IFilter::act(IReq::get('status'));
    	if($pay_status!='')
    	{
    		$where .= ' and o.pay_status = '.$pay_status;
    	}
    	if($distribution_status!='')
    	{
    		$where .= ' and o.distribution_status = '.$distribution_status;
    	}
    	if($status)
    	{
    		$where .= ' and o.status = '.$status;
    	}
    	$data['pay_status'] = $pay_status;
    	$data['distribution_status'] = $distribution_status;
    	$data['status'] = $status;
    	$data['where'] = $where;

    	//向前台渲染
    	$this->setRenderData($data);
		$this->redirect("order_list");
    }
    /**
     * @brief 订单删除功能_删除到回收站
     */
    public function order_del()
    {
    	//post数据
    	$id = IFilter::act(IReq::get('id'),'int');

    	//生成order对象
    	$tb_order = new IModel('order');
    	$tb_order->setData(array('if_del'=>1));
    	if(!empty($id))
		{
			$id = $tb_order->update(Order_Class::getWhere($id));

			//获取订单编号
			$orderRs   = $tb_order->query('id in ('.$id.')','order_no');
			$orderData = array();
			foreach($orderRs as $val)
			{
				$orderData[] = $val['order_no'];
			}

			$logObj = new log('db');
			$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"订单移除到回收站内",'订单号：'.join(',',$orderData)));

			$this->redirect('order_list');
		}
		else
		{
			$this->redirect('order_list',false);
			Util::showMessage('请选择要删除的数据');
		}
    }
	/**
     * @brief 收款单删除功能_删除到回收站
     */
    public function collection_del()
    {
    	//post数据
    	$id = IFilter::act(IReq::get('id'),'int');
    	//生成order对象
    	$tb_order = new IModel('collection_doc');
    	$tb_order->setData(array('if_del'=>1));
    	if($id)
		{
			$tb_order->update(Order_Class::getWhere($id));

			$logObj = new log('db');
			$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"收款单移除到回收站内",'收款单ID：'.join(',',$id)));

			$this->redirect('order_collection_list');
		}
		else
		{
			$this->redirect('order_collection_list',false);
			Util::showMessage('请选择要删除的数据');
		}
    }
	/**
     * @brief 收款单删除功能_删除回收站中的数据，彻底删除
     */
    public function collection_recycle_del()
    {
    	//post数据
    	$id = IFilter::act(IReq::get('id'),'int');
    	//生成order对象
    	$tb_order = new IModel('collection_doc');
    	if($id)
		{
			$tb_order->del(Order_Class::getWhere($id));

			$logObj = new log('db');
			$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"删除回收站内的收款单",'收款单ID：'.join(',',$id)));

			$this->redirect('collection_recycle_list');
		}
		else
		{
			$this->redirect('collection_recycle_list',false);
			Util::showMessage('请选择要删除的数据');
		}
    }
	/**
	 * @brief 还原还款单列表
	 */
    public function collection_recycle_restore()
    {
    	//post数据
    	$id = IFilter::act(IReq::get('id'),'int');
    	//生成order对象
    	$tb_order = new IModel('collection_doc');
    	$tb_order->setData(array('if_del'=>0));
    	if($id)
		{
			$tb_order->update(Order_Class::getWhere($id));

			$logObj = new log('db');
			$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"恢复了回收站内的收款单",'收款单ID：'.join(',',$id)));

			$this->redirect('collection_recycle_list');
		}
		else
		{
			$this->redirect('collection_recycle_list',false);
			Util::showMessage('请选择要还原的数据');
		}
    }
	/**
	 * @brief 退款单删除功能_删除到回收站
	 */
    public function refundment_del()
    {
    	//post数据
    	$id = IFilter::act(IReq::get('id'),'int');
    	//生成order对象
    	$tb_order = new IModel('refundment_doc');
    	$tb_order->setData(array('if_del'=>1));
    	if(!empty($id))
		{
			$tb_order->update(Order_Class::getWhere($id));

			$logObj = new log('db');
			$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"退款单移除到回收站内",'退款单ID：'.join(',',$id)));

			$this->redirect('order_refundment_list');
		}
		else
		{
			$this->redirect('order_refundment_list',false);
			Util::showMessage('请选择要删除的数据');
		}
    }
	/**
	 * @brief 退款单删除功能_删除回收站中的数据，彻底删除
	 */
    public function refundment_recycle_del()
    {
    	//post数据
    	$id = IFilter::act(IReq::get('id'),'int');
    	//生成order对象
    	$tb_order = new IModel('refundment_doc');
    	if(!empty($id))
		{
			$tb_order->del(Order_Class::getWhere($id));

			$logObj = new log('db');
			$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"删除了回收站内的退款单",'退款单ID：'.join(',',$id)));

			$this->redirect('refundment_recycle_list');
		}
		else
		{
			$this->redirect('refundment_recycle_list',false);
			Util::showMessage('请选择要删除的数据');
		}
    }
	/**
	 * @brief 还原还款单列表
	 */
    public function refundment_recycle_restore()
    {
    	//post数据
    	$id = IFilter::act(IReq::get('id'),'int');
    	//生成order对象
    	$tb_order = new IModel('refundment_doc');
    	$tb_order->setData(array('if_del'=>0));
    	if(!empty($id))
		{
			$tb_order->update(Order_Class::getWhere($id));

			$logObj = new log('db');
			$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"还原了回收站内的还款单",'还款单ID：'.join(',',$id)));

			$this->redirect('refundment_recycle_list');
		}
		else
		{
			$this->redirect('refundment_recycle_list',false);
			Util::showMessage('请选择要还原的数据');
		}
    }
    /**
     * @brief 发货单删除功能_删除到回收站
     */
    public function delivery_del()
    {
    	//post数据
    	$id = IFilter::act(IReq::get('id'),'int');
    	//生成order对象
    	$tb_order = new IModel('delivery_doc');
    	$tb_order->setData(array('if_del'=>1));
    	if(!empty($id))
		{
			$tb_order->update(Order_Class::getWhere($id));

			$logObj = new log('db');
			$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"发货单移除到回收站内",'发货单ID：'.join(',',$id)));

			$this->redirect('order_delivery_list');
		}
		else
		{
			$this->redirect('order_delivery_list',false);
			Util::showMessage('请选择要删除的数据');
		}
    }
	/**
     * @brief 发货单删除功能_删除回收站中的数据，彻底删除
     */
    public function delivery_recycle_del()
    {
    	//post数据
    	$id = IFilter::act(IReq::get('id'),'int');
    	//生成order对象
    	$tb_order = new IModel('delivery_doc');
    	if(!empty($id))
		{
			$tb_order->del(Order_Class::getWhere($id));

			$logObj = new log('db');
			$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"删除了回收站中的发货单",'发货单ID：'.join(',',$id)));

			$this->redirect('delivery_recycle_list');
		}
		else
		{
			$this->redirect('delivery_recycle_list',false);
			Util::showMessage('请选择要删除的数据');
		}
    }
	/**
	 * @brief 还原发货单列表
	 */
    public function delivery_recycle_restore()
    {
    	//post数据
    	$id = IFilter::act(IReq::get('id'),'int');
    	//生成order对象
    	$tb_order = new IModel('delivery_doc');
    	$tb_order->setData(array('if_del'=>0));
    	if(!empty($id))
		{
			$tb_order->update(Order_Class::getWhere($id));

			$logObj = new log('db');
			$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"还原了回收站中的发货单",'发货单ID：'.join(',',$id)));

			$this->redirect('delivery_recycle_list');
		}
		else
		{
			$this->redirect('delivery_recycle_list',false);
			Util::showMessage('请选择要还原的数据');
		}
    }
    /**
     * @brief 订单删除功能_删除回收站中的数据，彻底删除
     */
    public function order_recycle_del()
    {
    	//post数据
    	$id = IFilter::act(IReq::get('id'),'int');
    	$id_str = $id;
    	//生成order对象
    	$tb_order = new IModel('order');
    	if(!empty($id))
		{
			$where = '';
			$prop = '';
			$order_id = '';
			if(is_array($id) && isset($id[0]) && $id[0]!='')
			{
				$id_str = join(',',$id);
				$where = ' id in ('.$id_str.')';
				$prop = ' id in ('.$id_str.') and pay_status =0 and prop is not null';
				$order_id = ' order_id in ('.$id_str.')';
			}
			else
			{
				$where = 'id = '.$id;
				$prop = 'id = '.$id.' and pay_status =0 and prop is not null';
				$order_id = 'id = '.$id;
			}
			//先修改红包
			$order_info = $tb_order->query($prop);
			if(count($order_info)>0)
			{
				$tb_prop = new IModel('prop');
				foreach ($order_info as $value)
				{
					$tb_prop->setData(array('is_close'=>0));
					if($value['prop'])
					{
						$tb_prop->update('id='.$value['prop']);
					}
				}
			}
			//删除订单商品
			$tb_order_goods = new IQuery('order_goods');
			$tb_order_goods->fields = 'id';
			$tb_order_goods->where = $order_id;
			$order_info = $tb_order_goods->find();

			if(count($order_info)>0)
			{
				$tb_order_go = new IModel('order_goods');
				foreach ($order_info as $value)
				{
					if($value['id'])
					{
						$tb_order_go->del('id='.$value['id']);
					}
				}
			}
			//删除订单
			$tb_order->del($where);

			$logObj = new log('db');
			$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"删除回收站中退货单",'退货单ID：'.$id_str));

			$this->redirect('order_recycle_list');
		}
		else
		{
			$this->redirect('order_recycle_list',false);
			Util::showMessage('请选择要删除的数据');
		}
    }
    /**
	 * @brief 还原订单列表
	 */
    public function order_recycle_restore()
    {
    	//post数据
    	$id = IFilter::act(IReq::get('id'),'int');
    	//生成order对象
    	$tb_order = new IModel('order');
    	$tb_order->setData(array('if_del'=>0));
    	if(!empty($id))
		{
			$tb_order->update(Order_Class::getWhere($id));
			$this->redirect('order_recycle_list');
		}
		else
		{
			$this->redirect('order_recycle_list',false);
			Util::showMessage('请选择要还原的数据');
		}
    }
	/**
	 * @brief 订单打印模板修改
	 */
    public function print_template()
    {
		//获取根目录路径
		$path = IWeb::$app->getBasePath().'views/'.$this->theme.'/order';
    	//获取 购物清单模板
		$ifile_shop = new IFile($path.'/shop_template.html');
		$arr['ifile_shop']=$ifile_shop->read();
		//获取 配货单模板
		$ifile_pick = new IFile($path."/pick_template.html");
		$arr['ifile_pick']=$ifile_pick->read();

		$this->setRenderData($arr);
		$this->redirect('print_template');
    }
	/**
	 * @brief 订单打印模板展示
	 */
    public function template()
    {
    	$this->layout='';
    	$this->redirect('template');
    }
	/**
	 * @brief 订单打印模板修改保存
	 */
    public function print_template_update()
    {
		// 获取POST数据
    	$con_shop = IReq::get("con_shop");
		$con_pick = IReq::get("con_pick");

    	//获取根目录路径
		$path = IWeb::$app->getBasePath().'views/'.$this->theme.'/order';
    	//保存 购物清单模板
		$ifile_shop = new IFile($path.'/shop_template.html','w');
		if(!($ifile_shop->write($con_shop)))
		{
			$this->redirect('print_template',false);
			Util::showMessage('保存购物清单模板失败！');
		}
		//保存 配货单模板
		$ifile_pick = new IFile($path."/pick_template.html",'w');
		if(!($ifile_pick->write($con_pick)))
		{
			$this->redirect('print_template',false);
			Util::showMessage('保存配货单模板失败！');
		}
		//保存 合并单模板
    	$ifile_merge = new IFile($path."/merge_template.html",'w');
		if(!($ifile_merge->write($con_shop.$con_pick)))
		{
			$this->redirect('print_template',false);
			Util::showMessage('购物清单和配货单模板合并失败！');
		}

		$this->setRenderData(array('where'=>''));
		$this->redirect('order_list');
	}

	//购物单
	public function shop_template()
	{
		$this->layout='print';
		$order_id = IFilter::string( IReq::get('id') );
		$tb_order = new IModel('order');
		$order_info = $tb_order->query('id='.$order_id);
		$this->setRenderData($order_info[0]);
		//获得配置文件内容
		$data = array();

		$config = new Config("site_config");
		$config_info = $config->getInfo();
     	$data['set']['name'] = isset($config_info['name'])  ? $config_info['name']  : '';
     	$data['set']['mobile'] = isset($config_info['mobile'])  ? $config_info['mobile']  : '';
     	$data['set']['email'] = isset($config_info['email'])  ? $config_info['email']  : '';
     	$data['set']['url'] = isset($config_info['url'])  ? $config_info['url']  : '';
		$this->setRenderData($data);
		$this->redirect("shop_template");
	}
	//发货单
	public function pick_template()
	{
		$data = array();
		$this->layout='print';
		$order_id = IFilter::string( IReq::get('id') );
		$tb_order = new IModel('order');
		$order_info = $tb_order->query('id='.$order_id);
		$data = $order_info[0];
		$tb_deliver_doc = new IQuery('delivery_doc as dd');
		$tb_deliver_doc->join = 'left join delivery_goods as dg on dd.id = dg.delivery_id';
		$tb_deliver_doc->fields = 'dd.name,dd.mobile,dd.telphone,dd.address,dd.postcode,dd.delivery_type';
		$tb_deliver_doc->where = 'dd.order_id='.$order_id;
		$deliver_doc_info = $tb_deliver_doc->find();
		if(count($deliver_doc_info)>0)
		{
			$data['deliver'] = $deliver_doc_info[0];
		}
		$this->setRenderData($data);
		$this->redirect('pick_template');
	}
	//合并购物单和发货单
	public function merge_template()
	{
		$this->layout='print';
		$order_id = IFilter::string(IReq::get('id'));
		$tb_order = new IModel('order');
		$order_info = $tb_order->query('id='.$order_id);
		$this->setRenderData($order_info[0]);
		//获得配置文件内容
		$data = array();
		$config = new Config("site_config");
		$config_info = $config->getInfo();
     	$data['set']['name'] = isset($config_info['name'])  ? $config_info['name']  : '';
     	$data['set']['mobile'] = isset($config_info['mobile'])  ? $config_info['mobile']  : '';
     	$data['set']['email'] = isset($config_info['email'])  ? $config_info['email']  : '';
     	$data['set']['url'] = isset($config_info['url'])  ? $config_info['url']  : '';
		$tb_deliver_doc = new IQuery('delivery_doc as dd');
		$tb_deliver_doc->join = 'left join delivery_goods as dg on dd.id = dg.delivery_id';
		$tb_deliver_doc->fields = 'dd.name,dd.mobile,dd.telphone,dd.address,dd.postcode,dd.delivery_type';
		$tb_deliver_doc->where = 'dd.order_id='.$order_id;
		$deliver_doc_info = $tb_deliver_doc->find();
		if(count($deliver_doc_info)>0)
		{
			$data['deliver'] = $deliver_doc_info[0];
		}
		$this->setRenderData($data);

		$this->redirect("merge_template");
	}
	/**
	 * @brief 发货信息管理
	 */
	public function ship_info_list()
	{
		$this->redirect('ship_info_list');
	}
	/**
	 * @brief 添加/修改发货信息
	 */
	public function ship_info_edit()
	{
		// 获取POST数据
    	$id = IFilter::act(IReq::get("sid"),'int');
    	if($id)
    	{
    		$tb_ship   = new IModel("merch_ship_info");
    		$ship_info = $tb_ship->getObj("id=".$id);
    		if($ship_info)
    		{
    			$this->data = $ship_info;
    		}
    		else
    		{
    			$this->ship_info_list();
				return;
    		}
    	}
    	$this->setRenderData($this->data);
		$this->redirect('ship_info_edit');
	}
	/**
	 * @brief 设置发货信息的默认值
	 */
	public function ship_info_default()
	{
		$id = IFilter::act( IReq::get('id'),'int' );
        $default = IFilter::string(IReq::get('default'));
        $tb_merch_ship_info = new IModel('merch_ship_info');
        if($default == 1)
        {
            $tb_merch_ship_info->setData(array('is_default'=>0));
            $tb_merch_ship_info->update("all");
        }
        $tb_merch_ship_info->setData(array('is_default'=>$default));
        $tb_merch_ship_info->update("id = ".$id);
        $this->redirect('ship_info_list');
	}
	/**
	 * @brief 保存添加/修改发货信息
	 */
	public function ship_info_update()
	{
		// 获取POST数据
    	$id = IFilter::act(IReq::get('sid'),'int');
    	$ship_name = IFilter::act(IReq::get('ship_name'));
    	$ship_user_name = IFilter::act(IReq::get('ship_user_name'));
    	$sex = IFilter::act(IReq::get('sex'),'int');
    	$province =IFilter::act(IReq::get('province'),'int');
    	$city = IFilter::act(IReq::get('city'),'int');
    	$area = IFilter::act(IReq::get('area'),'int');
    	$address = IFilter::act(IReq::get('address'));
    	$postcode = IFilter::act(IReq::get('postcode'),'int');
    	$mobile = IFilter::act(IReq::get('mobile'));
    	$telphone = IFilter::act(IReq::get('telphone'));
    	$is_default = IFilter::act(IReq::get('is_default'),'int');
    	//过滤string
    	$ship_name = IFilter::string($ship_name,true);
    	$ship_user_name = IFilter::string($ship_user_name,true);
    	$address = IFilter::string($address,true);
    	if($telphone)
    	{
    		$telphone = IFilter::string($telphone,true);
    	}
    	$tb_merch_ship_info = new IModel('merch_ship_info');
    	//判断是否已经有了一个默认地址
    	if(isset($is_default) && $is_default==1)
    	{
    		$tb_ship_info = new IQuery('merch_ship_info');
    		$tb_ship_info->fields = 'id,is_default';
    		$tb_ship_info->where = 'is_default=1';
    		$merch_ship_info = $tb_ship_info->find();
    		if(count($merch_ship_info)>0)
    		{
    			foreach ($merch_ship_info as $value)
    			{
    				$sid = $value['id'];
    				$tb_merch_ship_info->setData(array('is_default'=>0));
    				$tb_merch_ship_info->update('id='.$sid);
    			}
    		}
    	}
    	//设置存储数据
    	$arr['ship_name'] = $ship_name;
	    $arr['ship_user_name'] = $ship_user_name;
	    $arr['sex'] = $sex;
    	$arr['province'] = $province;
    	$arr['city'] =$city;
    	$arr['area'] =$area;
    	$arr['address'] = $address;
    	$arr['postcode'] = $postcode;
    	$arr['mobile'] = $mobile;
    	$arr['telphone'] =$telphone;
    	$arr['is_default'] = $is_default;
    	$arr['is_del'] =1;

    	$tb_merch_ship_info->setData($arr);
    	//判断是添加还是修改
    	if($id)
    	{
    		$tb_merch_ship_info->update('id='.$id);
    	}
    	else
    	{
    		$tb_merch_ship_info->add();
    	}
		$this->redirect('ship_info_list');
	}
	/**
	 * @brief 删除发货信息到回收站中
	 */
	public function ship_info_del()
	{
		// 获取POST数据
    	$id = IFilter::act(IReq::get('id'),'int');
		//加载 商家发货点信息
    	$tb_merch_ship_info = new IModel('merch_ship_info');
    	$tb_merch_ship_info->setData(array('is_del' => 0));
		if(!empty($id))
		{
			$tb_merch_ship_info->update(Order_Class::getWhere($id));
			$this->redirect('ship_info_list');
		}
		else
		{
			$this->redirect('ship_info_list',false);
			Util::showMessage('请选择要删除的数据');
		}
	}
	/**
	 * @brief 还原回收站的信息到列表
	 */
	public function recycle_restore()
	{
		// 获取POST数据
    	$id = IFilter::act(IReq::get('id'),'int');
		//加载 商家发货点信息
    	$tb_merch_ship_info = new IModel('merch_ship_info');
    	$tb_merch_ship_info->setData(array('is_del' => 1));
		if(!empty($id))
		{
			$tb_merch_ship_info->update(Order_Class::getWhere($id));
			$this->redirect('recycle_list');
		}
		else
		{
			$this->redirect('recycle_list',false);
		}
	}
	/**
	 * @brief 发货信息回收站列表
	 */
	public function recycle_list()
	{
		$this->redirect('recycle_list',false);
	}
	/**
	 * @brief 删除回收站中的信息
	 */
	public function recycle_del()
	{
		// 获取POST数据
    	$id = IFilter::act(IReq::get('id'),'int');
		//加载 商家发货点信息
    	$tb_merch_ship_info = new IModel('merch_ship_info');
		if(!empty($id))
		{
			$tb_merch_ship_info->del(Order_Class::getWhere($id));
			$this->redirect('recycle_list');
		}
		else
		{
			$this->redirect('recycle_list',false);
			Util::showMessage('请选择要删除的数据');
		}
	}

	//快递单背景图片上传
	public function expresswaybill_upload()
	{
		$result = array(
			'isError' => true,
		);

		if(isset($_FILES['attach']['name']) && $_FILES['attach']['name'] != '')
		{
			$photoObj = new PhotoUpload();
			$photo    = $photoObj->run();

			$result['isError'] = false;
			$result['data']    = $photo['attach']['img'];
		}
		else
		{
			$result['message'] = '请选择图片';
		}

		echo '<script type="text/javascript">parent.photoUpload_callback('.JSON::encode($result).');</script>';
	}

	//快递单添加修改
	public function expresswaybill_edit()
	{
		$id = intval(IReq::get('id'));

		$this->expressRow = array();

		//修改模式
		if($id)
		{
			$expressObj       = new IModel('expresswaybill');
			$this->expressRow = $expressObj->getObj('id = '.$id);
		}

		$this->redirect('expresswaybill_edit');
	}

	//快递单添加修改动作
	public function expresswaybill_edit_act()
	{
		$id           = intval(IReq::get('id'));
		$printExpress = IReq::get('printExpress');
		$name         = IFilter::act(IReq::get('express_name'));
		$width        = intval(IReq::get('width'));
		$height       = intval(IReq::get('height'));
		$background   = IFilter::act(IReq::get('printBackground'));
		$background   = ltrim($background,IUrl::creatUrl(''));

		if(!$printExpress)
		{
			$printExpress = array();
		}

		if(!$name)
		{
			die('快递单的名称不能为空');
		}

		$expressObj     = new IModel('expresswaybill');

		$data = array(
			'config'     => serialize($printExpress),
			'name'       => $name,
			'width'      => $width,
			'height'     => $height,
			'background' => $background,
		);

		$expressObj->setData($data);

		//修改模式
		if($id)
		{
			$is_result = $expressObj->update('id = '.$id);
		}
		else
		{
			$is_result = $expressObj->add();
		}
		echo $is_result === false ? '操作失败' : 'success';
	}

	//快递单删除
	public function expresswaybill_del()
	{
		$id = intval(IReq::get('id'));
		$expressObj = new IModel('expresswaybill');
		$expressObj->del('id = '.$id);
		$this->redirect('print_template/tab_index/3');
	}

	//选择快递单打印类型
	public function expresswaybill_template()
	{
		$this->layout = 'print';
    	$data = array();

    	//获得order_id的值
		$order_id = IFilter::act(IReq::get('id'));
		$order_id = is_array($order_id) ? join(',',$order_id) : $order_id;

		if(!$order_id)
		{
			$this->redirect('order_list');
			exit;
		}

		$ord_class       = new Order_Class();
 		$this->orderInfo = $ord_class->getOrderInfo($order_id);

		$this->redirect('expresswaybill_template');
	}

	//打印快递单
	public function expresswaybill_print()
	{
		$config_conver = array();
		$this->layout  = 'print';

		$order_id     = IFilter::act(IReq::get('order_id'));
		$express_id   = intval(IReq::get('express_id'));
		$expressObj   = new IModel('expresswaybill');
		$expressRow   = $expressObj->getObj('id = '.$express_id);

		if(empty($expressRow))
		{
			die('不存在此快递单信息');
		}

		$expressConfig     = unserialize($expressRow['config']);
		$expresswaybillObj = new Expresswaybill();

		$config_conver       = $expresswaybillObj->conver($expressConfig,$order_id);
		$this->config_conver = str_replace('trackingLeft','letterSpacing',$config_conver);

		$this->order_id      = $order_id;
		$this->expressRow    = $expressRow;
		$this->redirect('expresswaybill_print');
	}

	//更新打印状态
	public function update_print_status()
	{
		$order_id   = IFilter::act(IReq::get('order_id'),'int');
		$order_id   = is_array($order_id) ? join(',',$order_id) : $order_id;
		$print_type = IFilter::act(IReq::get('print_type'));

		$orderObj   = new IModel('order');
		$orderList  = $orderObj->query('id in ('.$order_id.')','if_print');

		foreach($orderList as $orderRow)
		{
			if(isset($orderRow['if_print']) && strpos($orderRow['if_print'],$print_type) === false)
			{
				if($orderRow['if_print'] == '')
				{
					$if_print = $print_type;
				}
				else
				{
					$if_print = $orderRow['if_print'].','.$print_type;
				}
				$orderObj->setData(array('if_print' => $if_print));
				$orderObj->update("id = ".$orderRow['id']);
			}
		}
	}
}