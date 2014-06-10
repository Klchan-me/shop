<?php
/**
 * @brief 会员模块
 * @class Member
 * @note  后台
 */
class Member extends IController
{
	public $checkRight  = 'all';
    public $layout='admin';
	private $data = array();

	function init()
	{
		IInterceptor::reg('CheckRights@onCreateAction');
	}

	/**
	 * @brief 添加会员
	 */
	function member_edit()
	{
		$uid  = IFilter::act(IReq::get('uid'),'int');

		//编辑会员信息读取会员信息
		if($uid)
		{
			$userDB = new IQuery('user as u');
			$userDB->join = 'left join member as m on u.id = m.user_id';
			$userDB->where= 'u.id = '.$uid;
			$userInfo = $userDB->find();

			if($userInfo)
			{
				$this->userInfo = current($userInfo);
			}
			else
			{
				$this->member_list();
				Util::showMessage("没有找到相关记录！");
				exit;
			}
		}
		$this->redirect('member_edit');
	}

	//保存会员信息
	function member_save()
	{
		$user_id    = IFilter::act(IReq::get('user_id'),'int');
		$user_name  = IFilter::act(IReq::get('username'));
		$email      = IFilter::act(IReq::get('email'));
		$password   = IFilter::act(IReq::get('password'));
		$repassword = IFilter::act(IReq::get('repassword'));
		$group_id   = IFilter::act(IReq::get('group_id'),'int');
		$truename   = IFilter::act(IReq::get('true_name'));
		$sex        = IFilter::act(IReq::get('sex'),'int');
		$telephone  = IFilter::act(IReq::get('telephone'));
		$mobile     = IFilter::act(IReq::get('mobile'));
		$province   = IFilter::act(IReq::get('province'),'int');
		$city       = IFilter::act(IReq::get('city'),'int');
		$area       = IFilter::act(IReq::get('area'),'int');
		$contact_addr = IFilter::act(IReq::get('contact_addr'));
		$zip        = IFilter::act(IReq::get('zip'));
		$qq         = IFilter::act(IReq::get('qq'));
		$msn        = IFilter::act(IReq::get('msn'));
		$exp        = IFilter::act(IReq::get('exp'),'int');
		$point      = IFilter::act(IReq::get('point'),'int');
		$_POST['area'] = ','.$province.','.$city.','.$area.',';

		if(!$user_id && $password == '')
		{
			$errorMsg = '请输入密码！';
		}

		if($password != $repassword)
		{
			$errorMsg = '两次输入的密码不一致！';
		}

		//操作失败表单回填
		if(isset($errorMsg))
		{
			$this->userInfo = $_POST;
			$this->redirect('member_edit',false);
			Util::showMessage($errorMsg);
		}

		$member = array(
			'true_name'    => $truename,
			'telephone'    => $telephone,
			'mobile'       => $mobile,
			'area'         => $_POST['area'],
			'contact_addr' => $contact_addr,
			'qq'           => $qq,
			'msn'          => $msn,
			'sex'          => $sex,
			'zip'          => $zip,
			'exp'          => $exp,
			'point'        => $point,
			'group_id'     => $group_id
		);

		//创建会员操作类
		$userDB   = new IModel("user");
		$memberDB = new IModel("member");

		//添加新会员
		if(empty($user_id))
		{
			$user = array(
				'username' => $user_name,
				'password' => md5($password),
				'email'    => $email
			);
			$userDB->setData($user);
			$user_id = $userDB->add();

			$member['user_id'] = $user_id;
			$member['time']    = date('Y-m-d H:i:s');

			$memberDB->setData($member);
			$memberDB->add();
		}
		//编辑会员
		else
		{
			//修改密码
			if($password)
			{
				$userDB->setData(array('password' => md5($password)));
				$userDB->update('id = '.$user_id);
			}

			$member_info = $memberDB->getObj('user_id='.$user_id);

			//修改积分记录日志
			if($point != $member_info['point'])
			{
				$ctrlType = $point > $member_info['point'] ? '增加' : '减少';
				$diffPoint= $point-$member_info['point'];

				$pointObj = new Point();
				$pointConfig = array(
					'user_id' => $user_id,
					'point'   => $diffPoint,
					'log'     => '管理员'.$this->admin['admin_name'].'将积分'.$ctrlType.$diffPoint.'积分',
				);
				$pointObj->update($pointConfig);
			}

			$memberDB->setData($member);
			$memberDB->update("user_id = ".$user_id);
		}
		$this->redirect('member_list');
	}

	/**
	 * @brief 会员列表
	 */
	function member_list()
	{
		$search = IFilter::string(IReq::get('search'));
		$keywords = IFilter::string(IReq::get('keywords'));
		$where = ' 1 ';
		if($search && $keywords)
		{
			$where .= " and $search like '%{$keywords}%' ";
		}
		$this->data['search'] = $search;
		$this->data['keywords'] = $keywords;
		$this->data['where'] = $where;
		$tb_user_group = new IModel('user_group');
		$data_group = $tb_user_group->query();
		$group      = array();
		foreach($data_group as $value)
		{
			$group[$value['id']] = $value['group_name'];
		}
		$this->data['group'] = $group;
		$this->setRenderData($this->data);
		$this->redirect('member_list');
	}

	/**
	 * 用户余额管理页面
	 */
	function member_balance()
	{
		$this->layout = '';
		$this->redirect('member_balance');
	}
	/**
	 * @brief 删除至回收站
	 */
	function member_reclaim()
	{
		$user_ids = IReq::get('check');
		$user_ids = is_array($user_ids) ? $user_ids : array($user_ids);
		$user_ids = IFilter::act($user_ids,'int');
		if($user_ids)
		{
			$ids = implode(',',$user_ids);
			if($ids)
			{
				$tb_member = new IModel('member');
				$tb_member->setData(array('status'=>'2'));
				$where = "user_id in (".$ids.")";
				$tb_member->update($where);
			}
		}
		$this->member_list();
	}
	//批量用户充值
    function member_recharge()
    {
    	$id = IReq::get('check');
    	$balance = IReq::get('balance');
    	$type = IReq::get('type');
    	$order_no = IFilter::act( IReq::get('order_no') );
    	$even = '';

    	if(!$id)
    	{
			echo JSON::encode(array('flag' => 'fail','message' => '请选择要操作的用户'));
			return;
    	}

    	if($type=='3')
    	{
    		$balance = '-'.abs($balance);
    		$even = 'withdraw';
    	}
    	else
    	{
    		$balance = abs($balance);
    		if($type=='1')
    		{
    			$even = 'recharge';
    		}
    		else
    		{
    			$even = 'drawback';
    			if(is_array($id) && count($id)>1)
    			{
    				echo JSON::encode(array('flag' => 'fail','message' => '订单退款功能不能批量处理'));
					return;
    			}
    			if(is_array($id))
    			{
    				$id = end($id);
    			}
    			$id = intval($id);
    			//检测这个订单是不是这个用户的，且是否申请退款了
    			$obj = new IModel("order");
    			$row = $obj->query("user_id={$id} AND order_no = '{$order_no}' and (pay_status = 1 or pay_status = 3)");
    			if(!$row)
    			{
    				echo JSON::encode(array('flag' => 'fail','message' => '不存在这个订单或付款状态不正确'));
					return;
    			}
    		}
    	}

		$obj = new IModel('member');
		if(is_array($id) && isset($id[0]) && $id[0]!='')
		{
			$id_str = join(',',$id);
			//按用户id数组查询出用户余额，然后进行充值
			$member_info = $obj->query('user_id in ('.$id_str.')');
			if(count($member_info)>0)
			{
				foreach ($member_info as $value)
				{
					$balance_bak = $value['balance']+$balance;
					if($balance_bak>=0)
					{
						$obj->setData(array('balance'=>$balance_bak));
						$obj->update('user_id = '.$value['user_id']);

						//用户余额进行的操作记入account_log表
						$log = new AccountLog();
						$config=array
						(
							'user_id'=>$value['user_id'],
							'admin_id'=>$this->admin['admin_id'], //如果需要的话
							'event'=>$even, //withdraw:提现,pay:余额支付,recharge:充值,drawback:退款到余额
							'num'=> $balance, //整形或者浮点，正为增加，负为减少
							'order_no' =>$order_no // drawback类型的log需要这个值
						);
						$re = $log->write($config);
					}
				}
			}
		}
		else
		{
			//按用户id数组查询出用户余额，然后进行充值
			$member_info = $obj->query('user_id = '.$id);
			if(count($member_info)>0)
			{
				$balance_bak = $member_info[0]['balance']+$balance;
				if($balance_bak>=0)
				{
					$obj->setData(array('balance'=>$balance_bak));
					$obj->update('user_id = '.$id);

					//用户余额进行的操作记入account_log表
					$log = new AccountLog();
					$config=array(
						'user_id'=>$id,
					 	'admin_id'=>$this->admin['admin_id'], //如果需要的话
					 	'event'=>$even, //withdraw:提现,pay:余额支付,recharge:充值,drawback:退款到余额
					 	'num'=> $balance, //整形或者浮点，正为增加，负为减少
					 	'order_no' =>$order_no // drawback类型的log需要这个值
					 );
					 $re = $log->write($config);
				}
			}
		}
		echo JSON::encode(array('flag' => 'success'));
		return;
    }
	/**
	 * @brief 用户组添加
	 */
	function group_edit()
	{
		$gid = (int)IReq::get('gid');
		//编辑会员等级信息 读取会员等级信息
		if($gid)
		{
			$tb_user_group = new IModel('user_group');
			$group_info = $tb_user_group->query("id=".$gid);

			if(is_array($group_info) && ($info=$group_info[0]))
			{
				$this->data['group'] = array(
					'group_id'	=>	$info['id'],
					'group_name'=>	$info['group_name'],
					'discount'	=>	$info['discount'],
					'minexp'	=>	$info['minexp'],
					'maxexp'	=>	$info['maxexp']
				);
			}
			else
			{
				$this->redirect('group_list',false);
				Util::showMessage("没有找到相关记录！");
				return;
			}
		}
		$this->setRenderData($this->data);
		$this->redirect('group_edit');
	}

	/**
	 * @brief 保存用户组修改
	 */
	function group_save()
	{
		$group_id = IFilter::act(IReq::get('group_id'),'int');
		$maxexp   = IFilter::act(IReq::get('maxexp'),'int');
		$minexp   = IFilter::act(IReq::get('minexp'),'int');
		$discount = IFilter::act(IReq::get('discount'),'float');
		$group_name = IFilter::act(IReq::get('group_name'));

		$group = array(
			'maxexp' => $maxexp,
			'minexp' => $minexp,
			'discount' => $discount,
			'group_name' => $group_name
		);

		if($discount > 100)
		{
			$errorMsg = '折扣率不能大于100';
		}

		if($maxexp <= $minexp)
		{
			$errorMsg = '最大经验值必须大于最小经验值';
		}

		if(isset($errorMsg) && $errorMsg)
		{
			$group['group_id'] = $group_id;
			$data = array($group);

			$this->setRenderData($data);
			$this->redirect('group_edit',false);
			Util::showMessage($errorMsg);
			exit;
		}
		$tb_user_group = new IModel("user_group");
		$tb_user_group->setData($group);

		if($group_id)
		{
			$affected_rows = $tb_user_group->update("id=".$group_id);
			if($affected_rows)
			{
				$this->redirect('group_list',false);
				Util::showMessage('更新用户组成功！');
				return;
			}
			$this->redirect('group_list',false);
		}
		else
		{
			$gid = $tb_user_group->add();
			$this->redirect('group_list',false);
			if($gid)
			{
				Util::showMessage('添加用户组成功！');
			}
			else
			{
				Util::showMessage('添加用户组失败！');
			}
		}
	}

	/**
	 * @brief 删除会员组
	 */
	function group_del()
	{
		$group_ids = IReq::get('check');
		$group_ids = is_array($group_ids) ? $group_ids : array($group_ids);
		$group_ids = IFilter::act($group_ids,'int');
		if($group_ids)
		{
			$ids = implode(',',$group_ids);
			if($ids)
			{
				$tb_user_group = new IModel('user_group');
				$where = "id in (".$ids.")";
				$tb_user_group->del($where);
			}
		}
		$this->redirect('group_list');
	}

	/**
	 * @brief 回收站
	 */
	function recycling()
	{
		$search = IReq::get('search');
		$keywords = IReq::get('keywords');
		$search_sql = IFilter::act($search,'string');
		$keywords = IFilter::act($keywords,'string');

		$where = ' 1 ';
		if($search && $keywords)
		{
			$where .= " and $search_sql like '%{$keywords_sql}%' ";
		}
		$this->data['search'] = $search;
		$this->data['keywords'] = $keywords;
		$this->data['where'] = $where;
		$tb_user_group = new IModel('user_group');
		$data_group = $tb_user_group->query();
		$data_group = is_array($data_group) ? $data_group : array();
		$group = array();
		foreach($data_group as $value)
		{
			$group[$value['id']] = $value['group_name'];
		}
		$this->data['group'] = $group;
		$this->setRenderData($this->data);
		$this->redirect('recycling');
	}

	/**
	 * @brief 彻底删除会员
	 */
	function member_del()
	{
		$user_ids = IReq::get('check');
		$user_ids = is_array($user_ids) ? $user_ids : array($user_ids);
		$user_ids = IFilter::act($user_ids,'int');
		if($user_ids)
		{
			$ids = implode(',',$user_ids);

			if($ids)
			{
				$tb_member = new IModel('member');
				$where = "user_id in (".$ids.")";
				$tb_member->del($where);

				$tb_user = new IModel('user');
				$where = "id in (".$ids.")";
				$tb_user->del($where);

				$logObj = new log('db');
				$logObj->write('operation',array("管理员:".$this->admin['admin_name'],"删除了用户","被删除的用户ID为：".$ids));
			}
		}
		$this->redirect('member_list');
	}

	/**
	 * @brief 从回收站还原会员
	 */
	function member_restore()
	{
		$user_ids = IReq::get('check');
		$user_ids = is_array($user_ids) ? $user_ids : array($user_ids);
		if($user_ids)
		{
			$user_ids = IFilter::act($user_ids,'int');
			$ids = implode(',',$user_ids);
			if($ids)
			{
				$tb_member = new IModel('member');
				$tb_member->setData(array('status'=>'1'));
				$where = "user_id in (".$ids.")";
				$tb_member->update($where);
			}
		}
		$this->redirect('recycling');
	}

	//[提现管理] 删除
	function withdraw_del()
	{
		$id   = IReq::get('id');

		if(!empty($id))
		{
			$id = IFilter::act($id,'int');
			$withdrawObj = new IModel('withdraw');

			if(is_array($id))
			{
				$idStr = join(',',$id);
				$where = ' id in ('.$idStr.')';
			}
			else
			{
				$where = 'id = '.$id;
			}

			$withdrawObj->del($where);
			$this->redirect('withdraw_recycle');
		}
		else
		{
			$this->redirect('withdraw_recycle',false);
			Util::showMessage('请选择要删除的数据');
		}
	}

	//[提现管理] 回收站 删除,恢复
	function withdraw_update()
	{
		$id   = IFilter::act( IReq::get('id') , 'int' );
		$type = IReq::get('type') ;

		if(!empty($id))
		{
			$withdrawObj = new IModel('withdraw');

			$is_del = ($type == 'res') ? '0' : '1';
			$dataArray = array(
				'is_del' => $is_del
			);

			if(is_array($id))
			{
				$idStr = join(',',$id);
				$where = ' id in ('.$idStr.')';
			}
			else
			{
				$where = 'id = '.$id;
			}

			$dataArray = array(
				'is_del' => $is_del,
			);

			$withdrawObj->setData($dataArray);
			$withdrawObj->update($where);
			$this->redirect('withdraw_list');
		}
		else
		{
			if($type == 'del')
			{
				$this->redirect('withdraw_list',false);
			}
			else
			{
				$this->redirect('withdraw_recycle',false);
			}
			Util::showMessage('请选择要删除的数据');
		}
	}

	//[提现管理] 详情展示
	function withdraw_detail()
	{
		$id = IFilter::act( IReq::get('id'),'int' );

		if($id)
		{
			$withdrawObj = new IModel('withdraw');
			$where       = 'id = '.$id;
			$this->withdrawRow = $withdrawObj->getObj($where);
			$this->redirect('withdraw_detail',false);
		}
		else
		{
			$this->redirect('withdraw_list');
		}
	}

	//[提现管理] 修改提现申请的状态
	function withdraw_status()
	{
		$id      = IFilter::act( IReq::get('id'),'int' );
		$re_note = IFilter::act( IReq::get('re_note'),'string' );

		if($id)
		{
			$withdrawObj = new IModel('withdraw');
			$dataArray = array(
				're_note'=> $re_note,
			);
			if(IReq::get('status') !== NULL)
			{
				$dataArray['status'] = IFilter::act(IReq::get('status') , 'int');
			}

			$withdrawObj->setData($dataArray);
			$where = "`id`= {$id} AND `status` = 0";
			$re = $withdrawObj->update($where);
			$this->withdraw_detail(true);

			if($re != 0)
			{
				$logObj = new log('db');
				$logObj->write('operation',array("管理员:".$this->admin['admin_name'],"修改了提现申请","ID值为：".$id));
			}

			Util::showMessage("更新成功");
		}
		else
		{
			$this->redirect('withdraw_list');
		}
	}

}
