<?php
/**
 * @brief 用户中心模块
 * @class Ucenter
 * @note  前台
 */
class Ucenter extends IController
{
	public $layout = 'ucenter';

	public function init()
	{
		CheckRights::checkUserRights();

		if(ISafe::get('user_id') == '')
		{
			$this->redirect('/simple/login');
		}
	}
    public function index()
    {
        $this->initPayment();
        $this->redirect('index');
    }

	//[用户头像]上传
	function user_ico_upload()
	{
		$result = array(
			'isError' => true,
		);

		if(isset($_FILES['attach']['name']) && $_FILES['attach']['name'] != '')
		{
			$photoObj = new PhotoUpload();
			$photoObj->setThumb(100,100,'user_ico');
			$photo    = $photoObj->run();

			if(!empty($photo['attach']['thumb']['user_ico']))
			{
				$user_id   = $this->user['user_id'];
				$user_obj  = new IModel('user');
				$dataArray = array(
					'head_ico' => $photo['attach']['thumb']['user_ico'],
				);
				$user_obj->setData($dataArray);
				$where  = 'id = '.$user_id;
				$isSuss = $user_obj->update($where);

				if($isSuss !== false)
				{
					$result['isError'] = false;
					$result['data'] = IUrl::creatUrl().$photo['attach']['thumb']['user_ico'];
					ISafe::set('head_ico',$dataArray['head_ico']);
				}
				else
				{
					$result['message'] = '上传失败';
				}
			}
			else
			{
				$result['message'] = '上传失败';
			}
		}
		else
		{
			$result['message'] = '请选择图片';
		}
		echo '<script type="text/javascript">parent.callback_user_ico('.JSON::encode($result).');</script>';
	}

    /**
     * @brief 我的订单列表
     */
    public function order()
    {
        $this->initPayment();
        $this->redirect('order');

    }
    /**
     * @brief 初始化支付方式
     */
    private function initPayment()
    {
        $payment = new IQuery('payment');
        $payment->fields = 'id,name,type';
        $payments = $payment->find();
        $items = array();
        foreach($payments as $pay)
        {
            $items[$pay['id']]['name'] = $pay['name'];
            $items[$pay['id']]['type'] = $pay['type'];
        }
        $items[0]['name'] = '货到付款';
        $this->payments = $items;
    }
    /**
     * @brief 订单详情
     * @return String
     */
    public function order_detail()
    {
        $id =  IFilter::act(IReq::get('id'),'int');

        //获取订单信息
        $order = new IModel('order');
        $order_info = $order->getObj('id = '.$id.' and user_id = '.$this->user['user_id']);

        if(!$order_info)
        {
        	IError::show(403,'订单信息不存在');
        }

        //查询地区
        $areaDB = new IModel('areas');
        $areaArray = array($order_info['province'],$order_info['city'],$order_info['area']);
        $areaResult = $areaDB->query("area_id in (".join(',',$areaArray).")");
        $areaNameArray = array();
        foreach($areaResult as $value)
        {
            $areaNameArray[$value['area_id']] = $value['area_name'];
        }

        $this->area       = $areaNameArray;
        $this->order_info = $order_info;

        //取得支付方式
        if(isset($order_info['pay_type']) && $order_info['pay_type'] == 0)
        {
        	$this->pay_name = '货到付款';
        }
        else
        {
	        $paymentDB = new IModel('payment');
	        $payRow = $paymentDB->getObj('id = '.$order_info['pay_type']);
	        if($payRow)
	        {
		        $this->pay_name = $payRow['name'];
		        $this->pay_note = $payRow['note'];
	        }
        }

        //物流单号
    	$tb_delivery_doc = new IQuery('delivery_doc as dd');
    	$tb_delivery_doc->join   = 'left join delivery as d on dd.delivery_type = d.id left join freight_company as fc on d.freight_id = fc.id';
    	$tb_delivery_doc->fields = 'd.name,dd.delivery_code,fc.freight_name';
    	$tb_delivery_doc->where  = 'order_id = '.$id;
    	$delivery_info = $tb_delivery_doc->find();
    	if($delivery_info)
    	{
    		$this->deliveryRow = $delivery_info[0];
    	}
        $this->redirect('order_detail',false);
    }

    /**
     * 修改收件人信息
     * */
    public function order_accept()
    {
    	$id   = IFilter::act(IReq::get('order_id'),'int');
    	$mess = '';

    	if($id)
    	{
    		$order_array = array(
    			'postcode'   => IFilter::act(IReq::get('postcode')),
    			'accept_name'=> IFilter::act(IReq::get('accept_name')),
    			'province'   => IFilter::act(IReq::get('province')),
    			'city'       => IFilter::act(IReq::get('city')),
    			'area'       => IFilter::act(IReq::get('area')),
    			'address'    => IFilter::act(IReq::get('address')),
    			'telphone'   => IFilter::act(IReq::get('telphone')),
    			'mobile'	 => IFilter::act(IReq::get('mobile')),
    		);

    		$tb_order = new IModel('order');
    		$orderRow = $tb_order->getObj('id = '.$id);

    		//比对省份是否改变,从而重新计算运费
    		if($order_array['province'] != $orderRow['province'])
    		{
    			//获取订单物品重量
    			$goods_weight = IFilter::act(IReq::get('goods_weight'),'float');

		    	//调入数据，获得配送方式结果
		    	$deliveryData = Delivery::getDelivery($order_array['province'],$goods_weight);

		    	//所选择的省份不能送达
		    	if($deliveryData[$orderRow['distribution']]['if_delivery'] == 1)
		    	{
		    		$mess = '对不起，该地区不能送达，请您重新选择省份';
		    	}
		    	else if($deliveryData[$orderRow['distribution']]['price'] != $orderRow['payable_freight'])
		    	{
		    		$order_array['payable_freight'] = $deliveryData[$orderRow['distribution']]['price'];

		    		//非免运费
		    		if($orderRow['real_freight'] > 0)
		    		{
		    			$order_array['real_freight'] = $order_array['payable_freight'];

		    			//修正订单最终总金额
		    			$order_array['order_amount'] = $orderRow['order_amount'] + $order_array['payable_freight'] - $orderRow['real_freight'];
		    		}
		    	}
    		}

    		//无错误信息运行正常
    		if($mess == '')
    		{
    			$mess = '更新成功！';
	    		$tb_order->setData($order_array);
	    		if($tb_order->update('id = '.$id.' and user_id = '.$this->user['user_id'])===false)
	    		{
	    			$mess = '收件人更新失败!';
	    		}
    		}
    	}
    	else
    	{
    		$mess = '您的操作失败!';
    	}

    	IReq::set('id',$id);
    	$this->order_detail();
    	Util::showMessage($mess);
    }

    //操作订单状态
	public function order_status()
	{
		$op = IReq::get('op');
		$id = IFilter::act( IReq::get('order_id'),'int' );
		$model = new IModel('order');

		switch($op)
		{
			case "cancel":
			{
				$model->setData(array('status'=>3));
			}
			break;

			case "confirm":
			{
				$model->setData(array('status'=>5,'completion_time'=>date('Y-m-d h:i:s')));
			}
			break;
		}

		//修改订单状态并且判断订单的所有者权限
		if($model->update("id = ".$id." and user_id = ".$this->user['user_id']))
		{
			switch($op)
			{
				//取消订单
				case "cancel":
				{
					//修改红包状态
					$prop_obj = $model->getObj('id='.$id,'prop');
					$prop_id = isset($prop_obj['prop'])?$prop_obj['prop']:'';
					if($prop_id!='')
					{
						$prop = new IModel('prop');
						$prop->setData(array('is_close'=>0));
						$prop->update('id='.$prop_id);
					}
				}
				break;

				case "confirm":
				{
		    		//增加用户评论商品机会
		    		Order_Class::addGoodsCommentChange($id);
				}
				break;
			}
		}
		$this->redirect("order_detail/id/$id");
	}
    /**
     * @brief 我的地址
     */
    public function address()
    {
		//取得自己的地址
		$query = new IQuery('address');
        $query->where = 'user_id = '.$this->user['user_id'];
		$address = $query->find();

		$area_ids = array();
		$areas    = array();

		if(!empty($address))
		{
			foreach($address as $ad)
			{
				$area_ids[$ad['province']] = $ad['province'];
				$area_ids[$ad['city']] = $ad['city'];
				$area_ids[$ad['area']] = $ad['area'];
			}
			$area = implode(',',$area_ids);
			$query = new IQuery('areas');
			$query->where = "area_id in ($area)";
			$res = $query->find();

			foreach($res as $rs)
			{
				$areas[$rs['area_id']] = $rs['area_name'];
			}
		}
		$this->areas = $areas;
		$this->address = $address;
        $this->redirect('address');
    }
    /**
     * @brief 收货地址管理
     */
	public function address_edit()
	{
		$id = intval(IReq::get('id'));
		$accept_name = IFilter::act(IReq::get('accept_name'));
		$province = intval(IReq::get('province'));
		$city = intval(IReq::get('city'));
		$area = intval(IReq::get('area'));
		$address = IFilter::act(IReq::get('address'));
		$zip = IFilter::act(IReq::get('zip'));
		$telphone = IFilter::act(IReq::get('telphone'));
		$mobile = IFilter::act(IReq::get('mobile'));
		$default = IReq::get('default')!= 1 ? 0 : 1;
        $user_id = $this->user['user_id'];

		$model = new IModel('address');
		$data = array('user_id'=>$user_id,'accept_name'=>$accept_name,'province'=>$province,'city'=>$city,'area'=>$area,'address'=>$address,'zip'=>$zip,'telphone'=>$telphone,'mobile'=>$mobile,'default'=>$default);

        //如果设置为首选地址则把其余的都取消首选
        if($default==1)
        {
            $model->setData(array('default'=>0));
            $model->update("user_id = ".$this->user['user_id']);
        }

		$model->setData($data);

		if($id == '')
		{
			$model->add();
		}
		else
		{
			$model->update('id = '.$id);
		}
		$this->redirect('address');
	}

	//添加地址ajax
	function address_add()
	{
		$accept_name = IFilter::act(IReq::get('accept_name'));
		$province    = IFilter::act(IReq::get('province'),'int');
		$city        = IFilter::act(IReq::get('city'),'int');
		$area        = IFilter::act(IReq::get('area'),'int');
		$address     = IFilter::act(IReq::get('address'));
		$zip         = IFilter::act(IReq::get('zip'));
		$telphone    = IFilter::act(IReq::get('telphone'));
		$mobile      = IFilter::act(IReq::get('mobile'));
        $user_id     = $this->user['user_id'];

        $model       = new IModel('address');
		$addressRow  = $model->getObj('user_id = '.$user_id.' and accept_name = "'.$accept_name.'" and area = '.$area.' and address = "'.$address.'"');

		if($addressRow)
		{
			$isError = true;
			$message = '请不要重复添加同一个收货地址';
			$data    = '';
		}
		else
		{
			//获取地区text
			$areaList = array();
			$areaObj  = new IModel('areas');
			$areaRs   = $areaObj->query('area_id in ('.$province.','.$city.','.$area.')','area_id,area_name');
			foreach($areaRs as $val)
			{
				$areaList[$val['area_id']] = $val['area_name'];
			}

			//执行insert
			$data = array('user_id'=>$user_id,'accept_name'=>$accept_name,'province'=>$province,'city'=>$city,'area'=>$area,'address'=>$address,'zip'=>$zip,'telphone'=>$telphone,'mobile'=>$mobile);
			$model->setData($data);
			$model->add();

			$isError = false;
			$message = '添加成功';

			$data['province_val'] = $areaList[$province];
			$data['city_val']     = $areaList[$city];
			$data['area_val']     = $areaList[$area];
		}
		$result = array('isError' => $isError,'message' => $message,'data' => $data);
		echo JSON::encode($result);
	}

    /**
     * @brief 收货地址删除处理
     */
	public function address_del()
	{
		$id = IFilter::act( IReq::get('id'),'int' );
		$model = new IModel('address');
		$model->del('id = '.$id.' and user_id = '.$this->user['user_id']);
		$this->redirect('address');
	}
    /**
     * @brief 设置默认的收货地址
     */
    public function address_default()
    {
        $id = IFilter::act( IReq::get('id'),'int' );
        $default = IFilter::string(IReq::get('default'));
        $model = new IModel('address');
        if($default == 1)
        {
            $model->setData(array('default'=>0));
            $model->update("user_id = ".$this->user['user_id']);
        }
        $model->setData(array('default'=>$default));
        $model->update("id = ".$id." and user_id = ".$this->user['user_id']);
        $this->redirect('address');
    }
    /**
     * @brief 退款申请页面
     */
    public function refunds_edit()
    {
        $id = IFilter::act(IReq::get('id'),'int');
        $order_no = IFilter::act( IReq::get('order_no') );
        $user_id = $this->user['user_id'];
        $content = IFilter::string( IReq::get('content') );

        $order = new IModel('order');
        $orderObj = $order->getObj("order_no = '".$order_no."' and user_id = ".$this->user['user_id'].' and status=5 and pay_status=1','order_no,id,order_amount');

		//订单信息存在
        if($orderObj)
        {
            if($id == 0)
            {
	            $refundment = new IModel('refundment_doc');
	            $refundmentObj = $refundment->getObj("order_no = '$order_no'");
	            if($refundmentObj)
	            {
	            	switch($refundmentObj['pay_status'])
	            	{
	            		case 0:
	            		{
	            			$this->msg='此订单已申请退款，请等待处理';
	            		}
	            		break;

	            		case 1:
	            		{
	            			$this->msg='此订单不允许退款，如有疑问请联系客服人员';
	            		}
	            		break;

	            		case 2:
	            		{
	            			$this->msg='此订单已退款成功，请查看您的账户余额';
	            		}
	            		break;
	            	}
	            	$this->info = JSON::encode(array('order_no'=>$order_no,'content'=>$content));
	            	$this->redirect('refunds',false);
	            	exit;
	            }
	            else
	            {
		    		$model = new IModel('refundment_doc');
		    		$model->setData(array('user_id'=>$user_id,'order_no'=>$order_no,'order_id'=>$orderObj['id'],'pay_status'=>0,'content'=>$content,'time'=>date('Y-m-d H:i:s'),'amount' => $orderObj['order_amount']));
                	$model->add();
	            }
            }
            else
            {
	    		$model = new IModel('refundment_doc');
	    		$model->setData(array('user_id'=>$user_id,'order_no'=>$order_no,'order_id'=>$orderObj['id'],'pay_status'=>0,'content'=>$content,'time'=>date('Y-m-d H:i:s')));
                $model->update("id = ".$id." and user_id = ".$this->user['user_id']) ;
            }
            $this->redirect('refunds');
        }
        else
        {
            $this->msg='此订单号不存在或者还未完成交易';
            $this->info = JSON::encode(array('order_no'=>$order_no,'content'=>$content));
            $this->redirect('refunds',false);
        }
    }
    /**
     * @brief 退款申请删除
     */
    public function refunds_del()
    {
        $id = IFilter::act( IReq::get('id'),'int' );
        $model = new IModel("refundment_doc");
        $model->del("id = ".$id." and user_id = ".$this->user['user_id']);
        $this->redirect('refunds');
    }
    /**
     * @brief 查看退款申请详情
     */
    public function refund_detail()
    {
        $id = IFilter::act( IReq::get('id'),'int' );
        $model = new IModel("refundment_doc");
        $this->data = $model->getObj("id = ".$id." and user_id = ".$this->user['user_id']);
        $this->redirect('refund_detail');
    }
    /**
     * @brief 建议中心
     */
    public function complain_edit()
    {
        $id = IFilter::act( IReq::get('id'),'int' );
        $title = IFilter::act(IReq::get('title'),'string');
        $content = IFilter::act(IReq::get('content'),'string' );
        $user_id = $this->user['user_id'];
        $model = new IModel('suggestion');
        $model->setData(array('user_id'=>$user_id,'title'=>$title,'content'=>$content,'time'=>date('Y-m-d H:i:s')));
        if($id =='')
        {
            $model->add();
        }
        else
        {
            $model->update('id = '.$id.' and user_id = '.$this->user['user_id']);
        }
        $this->redirect('complain');
    }
    /**
     * @brief 删除消息
     * @param int $id 消息ID
     */
    public function message_del()
    {
        $id = IFilter::act( IReq::get('id') ,'int' );
        $msg = new Mess($this->user['user_id']);
        $msg->delMessage($id);
        $this->redirect('message');
    }
    public function message_read()
    {
        $id = IFilter::act( IReq::get('id'),'int' );
        $msg = new Mess($this->user['user_id']);
        echo $msg->writeMessage($id,1);
    }

    //[修改密码]修改动作
    function password_edit()
    {
    	$user_id    = $this->user['user_id'];

    	$fpassword  = IReq::get('fpassword');
    	$password   = IReq::get('password');
    	$repassword = IReq::get('repassword');

    	$userObj    = new IModel('user');
    	$where      = 'id = '.$user_id;
    	$userRow    = $userObj->getObj($where);

		if(!preg_match('|\w{6,32}|',$password))
		{
			$message = '密码格式不正确，请重新输入';
		}
    	else if($password != $repassword)
    	{
    		$message  = '二次密码输入的不一致，请重新输入';
    	}
    	else if(md5($fpassword) != $userRow['password'])
    	{
    		$message  = '原始密码输入错误';
    	}
    	else
    	{
    		$passwordMd5 = md5($password);
	    	$dataArray = array(
	    		'password' => $passwordMd5,
	    	);

	    	$userObj->setData($dataArray);
	    	$result  = $userObj->update($where);
	    	if($result)
	    	{
	    		ISafe::set('user_pwd',$passwordMd5);
	    		$message = '密码修改成功';
	    	}
	    	else
	    	{
	    		$message = '密码修改失败';
	    	}
		}

    	$this->redirect('password',false);
    	Util::showMessage($message);
    }

    //[个人资料]展示 单页
    function info()
    {
    	$user_id = $this->user['user_id'];

    	$userObj       = new IModel('user');
    	$where         = 'id = '.$user_id;
    	$this->userRow = $userObj->getObj($where);

    	$memberObj       = new IModel('member');
    	$where           = 'user_id = '.$user_id;
    	$this->memberRow = $memberObj->getObj($where);

		$this->userGroupRow = array();
		if(isset($this->memberRow['group_id']) && $this->memberRow['group_id'])
		{
	    	$userGroupObj       = new IModel('user_group');
	    	$where              = 'id = '.$this->memberRow['group_id'];
	    	$this->userGroupRow = $userGroupObj->getObj($where);
		}
    	$this->redirect('info');
    }

    //[个人资料] 修改 [动作]
    function info_edit_act()
    {
    	$user_id   = $this->user['user_id'];

    	$memberObj = new IModel('member');
    	$where     = 'user_id = '.$user_id;

		//出生年月
    	$year  = IFilter::act( IReq::get('year','post'),'int' );
    	$month = IFilter::act( IReq::get('month','post'),'int' );
    	$day   = IFilter::act( IReq::get('day','post'),'int' );
    	$birthday = $year.'-'.$month.'-'.$day;

    	//地区
    	$province = IFilter::act( IReq::get('province','post') ,'string');
    	$city     = IFilter::act( IReq::get('city','post') ,'string' );
    	$area     = IFilter::act( IReq::get('area','post') ,'string' );
    	$areaStr  = ','.$province.','.$city.','.$area.',';

    	$dataArray       = array(
    		'true_name'    => IFilter::act( IReq::get('true_name') ,'string'),
    		'sex'          => IFilter::act( IReq::get('sex'),'int' ),
    		'birthday'     => $birthday,
    		'zip'          => IFilter::act( IReq::get('zip') ,'string' ),
    		'msn'          => IFilter::act( IReq::get('msn') ,'string' ),
    		'qq'           => IFilter::act( IReq::get('qq') , 'string' ),
    		'contact_addr' => IFilter::act( IReq::get('contact_addr'), 'string'),
    		'mobile'       => IFilter::act( IReq::get('mobile'), 'string'),
    		'telephone'    => IFilter::act( IReq::get('telephone'),'string'),
    		'area'         => $areaStr,
    	);

    	$memberObj->setData($dataArray);
    	$memberObj->update($where);
    	$this->info();
    }

    //[账户余额] 展示[单页]
    function withdraw()
    {
    	$user_id   = $this->user['user_id'];

    	$memberObj = new IModel('member','balance');
    	$where     = 'user_id = '.$user_id;
    	$this->memberRow = $memberObj->getObj($where);
    	$this->redirect('withdraw');
    }

	//[账户余额] 提现动作
    function withdraw_act()
    {
    	$user_id = $this->user['user_id'];
    	$amount  = IFilter::act( IReq::get('amount','post') ,'string' );
    	$message = '';

    	$dataArray = array(
    		'name'   => IFilter::act( IReq::get('name','post') ,'string'),
    		'note'   => IFilter::act( IReq::get('note','post'), 'string'),
			'amount' => $amount,
			'user_id'=> $user_id,
			'time'   => ITime::getDateTime(),
    	);

		$mixAmount = 0;
		$memberObj = new IModel('member');
		$where     = 'user_id = '.$user_id;
		$memberRow = $memberObj->getObj($where,'balance');

		//提现金额范围
		if($amount <= $mixAmount)
		{
			$message = '提现的金额必须大于'.$mixAmount.'元';
		}
		else if($amount > $memberRow['balance'])
		{
			$message = '提现的金额不能大于您的帐户余额';
		}
		else
		{
	    	$obj = new IModel('withdraw');
	    	$obj->setData($dataArray);
	    	$obj->add();
	    	$this->redirect('withdraw');
	    	die();
		}

		if($message != '')
		{
			$this->memberRow = array('balance' => $memberRow['balance']);
			$this->withdrawRow = $dataArray;
			$this->redirect('withdraw',false);
			Util::showMessage($message);
		}
    }

    //[账户余额] 提现状态判定
    static function getWithdrawStatus($status)
    {
    	$message = '';

    	switch($status)
    	{
    		case "0":
    		$message = '未处理';
    		break;

    		case "-1":
    		$message = '失败';
    		break;

    		case "1":
    		$message = '处理中';
    		break;

    		case "2":
    		$message = '成功';
    		break;
    	}
    	return $message;
    }

    //[账户余额] 提现详情
    function withdraw_detail()
    {
    	$user_id = $this->user['user_id'];

    	$id  = IFilter::act( IReq::get('id'),'int' );
    	$obj = new IModel('withdraw');
    	$where = 'id = '.$id.' and user_id = '.$user_id;
    	$this->withdrawRow = $obj->getObj($where);
    	$this->redirect('withdraw_detail');
    }

    //[提现申请] 取消
    function withdraw_del()
    {
    	$id = IFilter::act( IReq::get('id'),'int' );
    	if($id)
    	{
    		$dataArray   = array('is_del' => 1);
    		$withdrawObj = new IModel('withdraw');
    		$where = 'id = '.$id;
    		$withdrawObj->setData($dataArray);
    		$withdrawObj->update($where);
    	}
    	$this->redirect('withdraw');
    }

    //[余额交易记录]
    function account_log()
    {
    	$user_id   = $this->user['user_id'];

    	$memberObj = new IModel('member','balance');
    	$where     = 'user_id = '.$user_id;
    	$this->memberRow = $memberObj->getObj($where);
    	$this->redirect('account_log');
    }

    //[收藏夹]备注信息
    function edit_summary()
    {
    	$user_id = $this->user['user_id'];

    	$id      = IFilter::act( IReq::get('id'),'int' );
    	$summary = IFilter::act( IReq::get('summary'),'string' );

    	//ajax返回结果
    	$result  = array(
    		'isError' => true,
    	);

    	if(!$id)
    	{
    		$result['message'] = '收藏夹ID值丢失';
    	}
    	else if(!$summary)
    	{
    		$result['message'] = '请填写正确的备注信息';
    	}
    	else
    	{
	    	$favoriteObj = new IModel('favorite');
	    	$where       = 'id = '.$id.' and user_id = '.$user_id;

	    	$dataArray   = array(
	    		'summary' => $summary,
	    	);

	    	$favoriteObj->setData($dataArray);
	    	$is_success = $favoriteObj->update($where);

	    	if($is_success === false)
	    	{
	    		$result['message'] = '更新信息错误';
	    	}
	    	else
	    	{
	    		$result['isError'] = false;
	    	}
    	}
    	echo JSON::encode($result);
    }

    //[收藏夹]获取收藏夹数据
	function get_favorite(&$favoriteObj)
    {
		//获取收藏夹信息
	    $page = (isset($_GET['page'])&&(intval($_GET['page'])>0))?intval($_GET['page']):1;

		$favoriteObj = new IQuery("favorite");
		$cat_id = intval(IReq::get('cat_id'));
		$where = '';
		if($cat_id != 0)
		{
			$where = ' and cat_id = '.$cat_id;
		}
		$favoriteObj->where = "user_id = ".$this->user['user_id'].$where;
		$favoriteObj->page  = $page;
		$items = $favoriteObj->find();

		$goodsIdArray   = array();
		foreach($items as $val)
		{
			$goodsIdArray[] = $val['rid'];
		}

		//商品数据
		if(!empty($goodsIdArray))
		{
			$goodsIdStr = join(',',$goodsIdArray);
			$goodsObj   = new IModel('goods');
			$goodsList  = $goodsObj->query('id in ('.$goodsIdStr.')');
		}

		foreach($items as $key => $val)
		{
			foreach($goodsList as $gkey => $goods)
			{
				if($goods['id'] == $val['rid'])
				{
					$items[$key]['data'] = $goods;

					//效率考虑,让goodsList循环次数减少
					unset($goodsList[$gkey]);
				}
			}

			//如果相应的商品或者货品已经被删除了，
			if(!isset($items[$key]['data']))
			{
				$favoriteModel = new IModel('favorite');
				$favoriteModel->del("id={$val['id']}");
				unset($items[$key]);
			}
		}
		return $items;
    }

    //[收藏夹]删除
    function favorite_del()
    {
    	$user_id = $this->user['user_id'];
    	$id      = IReq::get('id');

		if(!empty($id))
		{
			$id = IFilter::act($id,'int');

			$favoriteObj = new IModel('favorite');

			if(is_array($id))
			{
				$idStr = join(',',$id);
				$where = 'user_id = '.$user_id.' and id in ('.$idStr.')';
			}
			else
			{
				$where = 'user_id = '.$user_id.' and id = '.$id;
			}

			$favoriteObj->del($where);
			$this->redirect('favorite');
		}
		else
		{
			$this->redirect('favorite',false);
			Util::showMessage('请选择要删除的数据');
		}
    }

    //[我的积分] 单页展示
    function integral()
    {
    	/*获取积分增减的记录日期时间段*/
    	$this->historyTime = IFilter::string( IReq::get('history_time','post') );
    	$defaultMonth = 3;//默认查找最近3个月内的记录

		$lastStamp    = ITime::getTime(ITime::getNow('Y-m-d')) - (3600*24*30*$defaultMonth);
		$lastTime     = ITime::getDateTime('Y-m-d',$lastStamp);

		if($this->historyTime != null && $this->historyTime != 'default')
		{
			$historyStamp = ITime::getDateTime('Y-m-d',($lastStamp - (3600*24*30*$this->historyTime)));
			$this->c_datetime = 'datetime >= "'.$historyStamp.'" and datetime < "'.$lastTime.'"';
		}
		else
		{
			$this->c_datetime = 'datetime >= "'.$lastTime.'"';
		}

    	$memberObj         = new IModel('member');
    	$where             = 'user_id = '.$this->user['user_id'];
    	$this->memberRow   = $memberObj->getObj($where,'point');
    	$this->redirect('integral',false);
    }

    //[我的积分]积分兑换代金券 动作
    function trade_ticket()
    {
    	$ticketId = IFilter::act( IReq::get('ticket_id','post'),'int' );
    	$message  = '';
    	if(intval($ticketId) == 0)
    	{
    		$message = '请选择要兑换的代金券';
    	}
    	else
    	{
    		$nowTime   = ITime::getDateTime();
    		$ticketObj = new IModel('ticket');
    		$ticketRow = $ticketObj->getObj('id = '.$ticketId.' and point > 0 and start_time <= "'.$nowTime.'" and end_time > "'.$nowTime.'"');
    		if(empty($ticketRow))
    		{
    			$message = '对不起，此代金券不能兑换';
    		}
    		else
    		{
	    		$memberObj = new IModel('member');
	    		$where     = 'user_id = '.$this->user['user_id'];
	    		$memberRow = $memberObj->getObj($where,'point');

	    		if($ticketRow['point'] > $memberRow['point'])
	    		{
	    			$message = '对不起，您的积分不足，不能兑换此类代金券';
	    		}
	    		else
	    		{
	    			//生成红包
					$dataArray = array(
						'condition' => $ticketRow['id'],
						'name'      => $ticketRow['name'],
						'card_name' => 'T'.IHash::random(8),
						'card_pwd'  => IHash::random(8),
						'value'     => $ticketRow['value'],
						'start_time'=> $ticketRow['start_time'],
						'end_time'  => $ticketRow['end_time'],
						'is_send'   => 1,
					);
					$propObj = new IModel('prop');
					$propObj->setData($dataArray);
					$insert_id = $propObj->add();

					//用户prop字段值null时
					$memberArray = array('prop' => ','.$insert_id.',');
					$memberObj->setData($memberArray);
					$result      = $memberObj->update('user_id = '.$this->user["user_id"].' and ( prop is NULL or prop = "" )');

					//用户prop字段值非null时
					if(!$result)
					{
						$memberArray = array(
							'prop' => 'concat(prop,"'.$insert_id.',")',
						);
						$memberObj->setData($memberArray);
						$result = $memberObj->update('user_id = '.$this->user["user_id"],'prop');
					}

					//代金券成功
					if($result)
					{
						$pointConfig = array(
							'user_id' => $this->user['user_id'],
							'point'   => '-'.$ticketRow['point'],
							'log'     => '积分兑换代金券，扣除了 -'.$ticketRow['point'].'积分',
						);
						$pointObj = new Point;
						$pointObj->update($pointConfig);
					}
	    		}
    		}
    	}

    	//展示
    	if($message != '')
    	{
    		$this->integral();
    		Util::showMessage($message);
    	}
    	else
    	{
    		$this->redirect('redpacket');
    	}
    }

    /**
     * 余额付款
     * T:支付失败;
     * F:支付成功;
     */
    function payment_balance()
    {
    	$urlStr  = '';
    	$user_id = intval($this->user['user_id']);

    	$return['attach']     = IReq::get('attach');
    	$return['total_fee']  = IReq::get('total_fee');
    	$return['order_no']   = IReq::get('order_no');
    	$return['return_url'] = IReq::get('return_url');
    	$sign                 = IReq::get('sign');
    	if(stripos($return['order_no'],'recharge_') !== false)
    	{
    		IError::show(403,'余额支付方式不能用于在线充值');
    		exit;
    	}

    	if(floatval($return['total_fee']) <= 0 || $return['order_no'] == '' || $return['return_url'] == '')
    	{
    		IError::show(403,'支付参数不正确');
    	}
    	else
    	{
    		$paymentDB  = new IModel('payment');
    		$paymentRow = $paymentDB->getObj('class_name = "balance" ');
    		$pkey       = $paymentRow['partner_key'];

	    	//md5校验
	    	ksort($return);
			foreach($return as $key => $val)
			{
				$urlStr .= $key.'='.urlencode($val).'&';
			}

			$urlStr .= $user_id.$pkey;
			if($sign != md5($urlStr))
			{
				IError::show(403,'数据校验不正确');
			}
			else
			{
		    	$memberObj = new IModel('member');
		    	$memberRow = $memberObj->getObj('user_id = '.$user_id);

		    	if(empty($memberRow))
		    	{
		    		IError::show(403,'用户信息不存在');
		    		exit;
		    	}
		    	else if($memberRow['balance'] < $return['total_fee'])
		    	{
		    		IError::show(403,'账户余额不足');
		    		exit;
		    	}
		    	else
		    	{
		    		$orderObj = new IModel('order');
		    		$orderRow = $orderObj->getObj('order_no  = "'.IFilter::act($return['order_no']).'" and pay_status = 0');
		    		if(empty($orderRow))
		    		{
		    			IError::show(403,'订单已经被处理过，请查看订单状态');
		    			exit;
		    		}

					$dataArray  = array('balance' => 'balance - '.IFilter::act($return['total_fee']));
					$memberObj->setData($dataArray);
			    	$is_success = $memberObj->update('user_id = '.$user_id,'balance');
			    	if($is_success)
			    	{
			    		$return['is_success'] = 'T';
			    	}
			    	else
			    	{
			    		$return['is_success'] = 'F';
			    	}

			    	ksort($return);

			    	//返还的URL地址
					$responseUrl = '';
					foreach($return as $key => $val)
					{
						$responseUrl .= $key.'='.urlencode($val).'&';
					}
					$nextUrl = urldecode($return['return_url']);
					if(stripos($nextUrl,'?') === false)
					{
						$return_url = $nextUrl.'?'.$responseUrl;
					}
					else
					{
						$return_url = $nextUrl.'&'.$responseUrl;
					}

					//计算要发送的md5校验
					$urlStrMD5  = md5($responseUrl.$user_id.$pkey);

					//拼接进返还的URL中
					$return_url.= 'sign='.$urlStrMD5;
			    	header('location:'.$return_url);
		    	}
			}
    	}
    }
}