<?php
/**
 * @brief 消息模块
 * @class Message
 * @note  后台
 */
class Message extends IController
{
	public $checkRight  = 'all';
	public $layout='admin';
	private $data = array();

	function init()
	{
		IInterceptor::reg('CheckRights@onCreateAction');
	}

	/**
	 * @brief 模板列表
	 */
	function tpl_list()
	{
		$tb_msg_template = new IModel('msg_template');
		$tpls = $tb_msg_template->query();
		$this->data['tpl'] = $tpls;
		$this->setRenderData($this->data);
		$this->redirect('tpl_list');
	}

	//删除电子邮箱订阅
	function registry_del()
	{
		$ids = IFilter::act(IReq::get('id'),'int');
		if(empty($ids))
		{
			$this->redirect('registry_list',false);
			Util::showMessage('请选择要删除的邮箱');
			exit;
		}

		if(is_array($ids))
		{
			$ids = join(',',$ids);
		}

		$registryObj = new IModel('email_registry');
		$registryObj->del('id in ('.$ids.')');
		$this->redirect('registry_list');
	}

	/**
	 * @brief 编辑模板
	 */
	function tpl_edit()
	{
		$tid = intval(IReq::get('tid'));
		if($tid)
		{
			$tb_msg_template = new IModel('msg_template');
			$data_tpl = $tb_msg_template->query('id='.$tid);
			if($data_tpl && is_array($data_tpl) && $info=$data_tpl[0])
			{
				$this->data['tpl'] = $info;
				$this->setRenderData($this->data);
				$this->redirect('tpl_edit');
			}
			else
			{
				$this->redirect('tpl_list');
			}

		}
		else
		{
			$this->redirect('tpl_list');
		}
	}

	/**
	 * @brief 保存模板修改
	 */
	function tpl_save()
	{
		$tid = intval(IReq::get('tpl_id','post'));
		if($tid)
		{
			$title = IFilter::act(IReq::get('title'),'string');
			$content = IFilter::act(IReq::get('content'),'text');
			$tb_msg_template = new IModel('msg_template');
			$tb_msg_template->setData(array('title'=>$title,'content'=>$content));
			$tb_msg_template->update('id='.$tid);
		}
		$this->redirect('tpl_list');
	}


	/**
	 * @brief 到货通知
	 */
	function notify_list()
	{
		$search = IReq::get('search');
		$keywords = IReq::get('keywords');

		$search_sql = IFilter::act($search);
		$keywords_sql = IFilter::act($keywords);

		$where = ' 1 ';
		if($search && $keywords)
		{
			$where .= " and $search_sql like '%{$keywords_sql}%' ";
		}
		$this->data['search'] = $search;
		$this->data['keywords'] = $keywords;
		$this->data['where'] = $where;
		$this->setRenderData($this->data);
		$this->redirect('notify_list');
	}

	/**
	 * @brief 删除登记的到货通知邮件
	 */
	function notify_del()
	{
		$notify_ids = IReq::get('check','post');
		if($notify_ids && is_array($notify_ids))
		{
			$notify_ids = IFilter::act($notify_ids,'int');
			$ids = implode(',',$notify_ids);
			if($ids)
			{
				$tb_notify = new IModel('notify_registry');
				$where = "id in (".$ids.")";
				$tb_notify->del($where);
			}
		}
		$this->redirect('notify_list');
	}

	/**
	 * @brief 发送到货通知邮件
	 */
	function notify_send()
	{
		$smtp  = new SendMail();
		$error = $smtp->getError();

		if($error)
		{
			$return = array(
				'isError' => true,
				'message' => $error,
			);
			echo JSON::encode($return);
			exit;
		}

		$notify_ids = IReq::get('notifyid');
		$message    = '';
		if($notify_ids && is_array($notify_ids))
		{
			$notify_ids = IFilter::act($notify_ids,'int');

			$ids = implode(',',$notify_ids);
			$query = new IQuery("notify_registry as notify");
			$query->join = "right join goods as goods on notify.goods_id=goods.id left join user as u on notify.user_id = u.id";
			$query->fields = "notify.*,u.username,goods.name as goods_name,goods.store_nums";
			$query->where = "notify.id in(".$ids.")";
			$items = $query->find();

			$tb_msg_template = new IModel('msg_template');
			$tpl = $tb_msg_template->query("id=1");
			$title = $tpl[0]['title'] ? $tpl[0]['title'] :$tpl[0]['name'];
			$content = $tpl[0]['content'];

			//库存大于0，且处于未发送状态的 发送通知
			$succeed = 0;
			$failed = 0;
			$tb_notify_registry = new IModel('notify_registry');

			foreach($items as $value)
			{
				$subject = str_replace(array('{$user_name}','{$goods_name}'),array($value['username'],$value['goods_name']),$title);
				$body    = str_replace(array('{$user_name}','{$goods_name}'),array($value['username'],$value['goods_name']),$content);
				$status  = $smtp->send($value['email'],$subject,$body);

				if($status)
				{
					//发送成功
					$succeed++;
					$data = array('notify_time'=>date('Y-m-d H:i:s'),'notify_status'=>'1');
					$tb_notify_registry->setData($data);
					$tb_notify_registry->update('id='.$value['id']);
				}
				else
				{
					//发送失败
					$failed++;
				}
			}
		}
		$return = array(
			'isError' => false,
			'count'   => count($items),
			'succeed' => $succeed,
			'failed'  => $failed,
		);
		echo JSON::encode($return);
	}
	/**
	 * @brief 到货通知筛选
	 */
	function notify_filter()
	{
		$search = IReq::get('search');
		$keywords = IReq::get('keywords');
		$where = ' 1 ';
		if($search && $keywords)
		{
			$where .= " and $search like '%{$keywords}%' ";
		}
		$this->data['search'] = $search;
		$this->data['keywords'] = $keywords;
		$this->data['where'] = $where;

		$page = IReq::get('page');
		$page = intval($page) ? intval($page) : 1;
		$and = ' and ';
		$where = '';
		$goodsname_k = IFilter::string(IReq::get('goodsname_k'));
		$goodsname_v = IFilter::string(IReq::get('goodsname_v'));
		if($goodsname_k && $goodsname_v)
		{
			if($goodsname_k=='eq')
			{
				$where .= 'goods.name="'.$goodsname_v.'"'.$and;
			}else
			{
				$where .= 'goods.name like "%'.$goodsname_v.'%"'.$and;
			}
		}
		$username_k = IFilter::string(IReq::get('username_k'));
		$username_v = IFilter::string(IReq::get('username_v'));
		if($username_k && $username_v)
		{
			if($username_k=='eq')
			{
				$where .= 'u.username="'.$username_v.'"'.$and;
			}else
			{
				$where .= 'u.username like "%'.$username_v.'%"'.$and;
			}
		}
		$store_nums_k = IFilter::string(IReq::get('store_nums_k'));
		$stror_nums_v = intval(IReq::get('store_nums_v')) ? intval(IReq::get('store_nums_v')) : 0;
		if($store_nums_k)
		{
			if($store_nums_k=='gt')
			{
				$where .= 'goods.store_nums > "'.$stror_nums_v.'"'.$and;
			}elseif($store_nums_k=='eq')
			{
				$where .= 'goods.store_nums = "'.$stror_nums_v.'"'.$and;
			}else
			{
				$where .= 'goods.store_nums < "'.$stror_nums_v.'"'.$and;
			}
		}
		$email_k = IFilter::string(IReq::get('email_k'));
		$email_v = IFilter::string(IReq::get('email_v'));
		if($email_k && $email_v)
		{
			if($email_k=='gt')
			{
				$where .= 'notify.email = "'.$email_v.'"'.$and;
			}else
			{
				$where .= 'notify.email like "%'.$email_v.'%"'.$and;
			}
		}
		$regtimeBegin = IFilter::string(IReq::get('regtimeBegin'));
		if($regtimeBegin)
		{
			$where .= 'notify.register_time > "'.$regtimeBegin.'"'.$and;
		}
		$regtimeEnd = IFilter::string(IReq::get('regtimeEnd'));
		if($regtimeEnd)
		{
			$where .= 'notify.register_time < "'.$regtimeEnd.'"'.$and;
		}
		$status = intval(IReq::get('status'));
		if($status && $status!='-1')
		{
			$where .= 'notify.notify_status = "'.$status.'"'.$and;
		}

		$where .= ' 1 ';
		$query = new IQuery("notify_registry as notify");
		$query->join = "join goods as goods on notify.goods_id = goods.id left join user as u on notify.user_id = u.id";
		$query->fields = "notify.*,u.username,goods.name as goods_name,goods.store_nums";
		$query->page = $page;
		$query->where = $where;
		$this->data['list_items'] = $query->find();

		//debug($this->data['items']);

		$this->data['pageBar'] = $query->getPageBar('/message/notify_filter/');
		$this->setRenderData($this->data);
		$this->redirect('notify_filter');
	}

	/**
	 * 导出到货通知为CSV格式
	 */
	function notify_export()
	{
		$ids = IReq::get("ids");
		if($ids===null)
		{
			die();
		}
		$ids = explode(",",$ids);
		$ids = IFilter::act($ids,'int');
		if(!$ids)
		{
			die();
		}
		$ids = implode(',',$ids);

		$field = IReq::get("csv_field");
		if($field===null)
		{
			die();
		}
		$field = IFilter::act($field,'string');

		$list=array();
		$tb_notify = new IModel("notify_registry");
		$list = $tb_notify->query("id IN ({$ids})");

		if(!$list)
		{
			die();
		}


		//获取商品名称、库存、用户名
		$user_info = $goods_info = $user_ids = $goods_ids = array();
		foreach($list as $value)
		{
			$user_ids[] = $value['user_id'];
			$goods_ids[] = $value['goods_id'];
		}

		$goods_ids = implode(",",$goods_ids);
		$user_ids = implode(",",$user_ids);

		$tb_user = new IModel("user");
		$tb_goods = new IModel("goods");

		$goods_info = $tb_goods->query("id IN ({$goods_ids})");
		$user_info = $tb_user->query("id IN ({$user_ids})");
		$goods_info = Util::array_rekey($goods_info,'id');
		$user_info = Util::array_rekey($user_info,'id');

		$valid_field = array('id','goods_id','user_id','username','goods_name','email','register_time','content','store_nums');
		$new_list = array();

		$tb_msg_template = new IModel('msg_template');
		$tpl = $tb_msg_template->query("id=1");
		$title_tpl = $tpl[0]['title'] ? $tpl[0]['title'] :$tpl[0]['name'];
		$content_tpl = $tpl[0]['content'];


		foreach($list as $key=>$value)
		{
			$new_value=array();
			$username = isset($user_info[$value['user_id']])?$user_info[$value['user_id']]['username']:"";
			$goods_name = isset($goods_info[$value['goods_id']])?$goods_info[$value['goods_id']]['name']:"";

			foreach($field as $v)
			{
				if(!in_array($v,$valid_field))
				{
					continue;
				}
				switch($v)
				{
					case 'id':
					case 'goods_id':
					case 'user_id':
					case 'email':
					case 'register_time':
						$new_value[$v] = $value[$v];
						break;

					case 'username':
						$new_value[$v] = $username;
						break;

					case 'goods_name':
						$new_value[$v] = $goods_name;
						break;

					case 'store_nums':
						$new_value[$v] = isset($goods_info[$value['goods_id']])?$goods_info[$value['goods_id']]['store_nums']:"";
						break;
					case 'title':
						$new_value[$v] = str_replace(array('{$user_name}','{$goods_name}'),array($username,$goods_name),$title_tpl);
						break;
					case 'content':
						$new_value[$v] = str_replace(array('{$user_name}','{$goods_name}'),array($username,$goods_name),$content_tpl);
						break;
				}
			}
			$new_list[] = $new_value;
		}

		$now = date("Y_m_d_H_i");
		//开始生成csv
		header("Content-type:text/csv");
		header("Content-Disposition: attachment; filename=export_{$now}.csv");
		$string = Util::array2csv($new_list);
		if( IReq::get("csv_encode") =='gbk'  )
		{
			$string = iconv("utf-8" , "gbk" , $string);
		}
		echo $string;
		die();
	}

	function registry_list()
	{
		$tb_user_group = new IModel('user_group');
		$data_group = $tb_user_group->query();
		$data_group = is_array($data_group) ? $data_group : array();
		$group      = array();
		foreach($data_group as $value)
		{
			$group[$value['id']] = $value['group_name'];
		}
		$this->data['group'] = $group;
		$this->setRenderData($this->data);

		//获取模板
		$tb_tpl = new IModel("msg_template");
		$tpl = $tb_tpl->getObj("id=2");
		if(!$tpl)
		{
			$tpl = array('name'=>'','title'=>'','content'=>'');
		}
		$this->tpl = $tpl;

		$this->redirect('registry_list');
	}

	/**
	 * 导出参与订阅的email
	 */
	function registry_export()
	{
		$list=array();
		$tb = new IModel("email_registry");

		$ids = IReq::get('ids');
		$ids_sql = "";
		if($ids)
		{
			$ids = explode(",",$ids);
			$ids = IFilter::act($ids,'int');
			$ids = implode(",",$ids);
			$ids_sql = "where id IN ({$ids})";
		}

		$now = date("Y-m-d_H:i");
		//开始生成csv
		header("Content-type:text/csv");
		header("Content-Disposition: attachment; filename=export_{$now}.csv");

		$start = 0;
		$query = new IQuery("email_registry");
		$query->fields = "email";
		$query->order = "id DESC";

		do
		{
			$query->limit = "{$start},1000";
			$list = $query->find();
			$start += 1000;

			$string = Util::array2csv($list);
			echo $string;
			flush();
		}
		while(count($list)>=1000);
		die();
	}


	/**
	 * @brief 发送信件
	 */
	function registry_message_send()
	{
		$smtp  = new SendMail();
		$error = $smtp->getError();

		$list=array();
		$tb = new IModel("email_registry");

		$ids = IReq::get('ids');
		$ids_sql = "";
		if($ids)
		{
			$ids = explode(",",$ids);
			$ids = IFilter::act($ids,'int');
			$ids = implode(",",$ids);
			$ids_sql = "id IN ({$ids})";
		}

		set_time_limit(0);
		$title = IFilter::act(IReq::get('title'));
		$content = IReq::get("content");

		$start = 0;
		$query = new IQuery("email_registry");
		$query->fields = "email";
		$query->order = "id DESC";
		$query->where = $ids_sql;

		do
		{
			$query->limit = "{$start},50";
			$list = $query->find();
			if(count($list) ==0 )
			{
				break;
			}
			$start += 1000;

			$to = array_pop($list);
			$to = $to['email'];
			$bcc = array();
			foreach($list as $value)
			{
				$bcc[] = $value['email'];
			}
			$bcc = implode(";",$bcc);
			$smtp->send($to,$title,$content,$bcc );
		}
		while(count($list)>=50);
		echo "success";
	}
}

