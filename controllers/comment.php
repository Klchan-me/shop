<?php
/**
 * @class Comment
 * @brief 评论模块
 * @note  后台
 */
class Comment extends IController
{
	public $checkRight  = 'all';
    public $layout='admin';
	private $data = array();

	function init()
	{
		IInterceptor::reg('CheckRights@onCreateAction');
	}

	function suggestion_list()
	{
		$where = ' 1 ';
		//筛选
		$username = IFilter::act(IReq::get('username'));
		$beginTime = IFilter::act(IReq::get('beginTime'));
		$endTime = IFilter::act(IReq::get('endTime'));
		$this->data['username'] = $username;
		$this->data['beginTime'] = $beginTime;
		$this->data['endTime'] = $endTime;
		if($username)
		{
			$where .= ' and b.username like "%'.$username.'%"';
		}
		if($beginTime)
		{
			$where .= ' and a.time > "'.$beginTime.'"';
		}
		if($endTime)
		{
			$where .= ' and a.time < "'.$endTime.'"';
		}

		$this->where = $where;
		$this->setRenderData($this->data);

		$this->redirect("suggestion_list",false);
	}

	/**
	 * @brief 显示建议信息
	 */
	function suggestion_edit()
	{
		$id = intval(IReq::get('id'));
		if(!$id)
		{
			$this->comment_list();
			return false;
		}
		$query = new IQuery("suggestion as a");
		$query->join = "left join user AS b ON a.user_id=b.id";
		$query->where = "a.id={$id}";
		$query->fields = "a.*,b.username";
		$items = $query->find();

		if(is_array($items) && $items)
		{
			$this->suggestion = $items[0];
			$this->redirect('suggestion_edit');
		}
		else
		{
			$this->suggestion_list();
		}
	}

	/**
	 * @brief 回复建议
	 */
	function suggestion_edit_act()
	{
		$id = intval(IReq::get('id','post'));
		$re_content = IFilter::act( IReq::get('re_content','post') ,'string');
		$tb = new IModel("suggestion");
		$data = array('admin_id'=>$this->admin['admin_id'],'re_content'=>$re_content,'re_time'=>date('Y-m-d H:i:s'));
		$tb->setData($data);
		$tb->update("id={$id}");
		$this->redirect("/comment/suggestion_list");
	}


	/**
	 * @brief 删除要删除的建议
	 */
	function suggestion_del()
	{
		$suggestion_ids = IReq::get('check');
		$suggestion_ids = is_array($suggestion_ids) ? $suggestion_ids : array($suggestion_ids);
		if($suggestion_ids)
		{
			$suggestion_ids = IFilter::act($suggestion_ids,'int');

			$ids = implode(',',$suggestion_ids);
			if($ids)
			{
				$tb_suggestion = new IModel('suggestion');
				$where = "id in (".$ids.")";
				$tb_suggestion->del($where);
			}
		}
		$this->suggestion_list();
	}

	/**
	 * @brief 评论信息列表
	 */
	function comment_list()
	{
		$search = IFilter::act(IReq::get('search'));
		$keywords = IFilter::act(IReq::get('keywords'));
		$where = ' c.status = 1 ';
		if($search && $keywords)
		{
			$where .= " and $search like '%{$keywords}%' ";
		}
		$this->data['search'] = $search;
		$this->data['keywords'] = $keywords;

		//筛选
		$username = IFilter::act(IReq::get('username'));
		$goodsname = IFilter::act(IReq::get('goodsname'));
		$beginTime = IFilter::act(IReq::get('beginTime'));
		$endTime = IFilter::act(IReq::get('endTime'));
		$this->data['username'] = $username;
		$this->data['goodsname'] = $goodsname;
		$this->data['beginTime'] = $beginTime;
		$this->data['endTime'] = $endTime;
		if($username)
		{
			$where .= ' and u.username like "%'.$username.'%"';
		}
		if($goodsname)
		{
			$where .= ' and goods.name like "%'.$goodsname.'%"';
		}
		if($beginTime)
		{
			$where .= ' and c.time > "'.$beginTime.'"';
		}
		if($endTime)
		{
			$where .= ' and c.time < "'.$endTime.'"';
		}
		$this->data['where'] = $where;
		$this->setRenderData($this->data);
		$this->redirect('comment_list',false);
	}

	/**
	 * @brief 显示评论信息
	 */
	function comment_edit()
	{
		$cid = intval(IReq::get('cid'));
		if(!$cid)
		{
			$this->comment_list();
			return false;
		}
		$query = new IQuery("comment as c");
		$query->join = "right join goods as goods on c.goods_id = goods.id left join user as u on c.user_id = u.id";
		$query->fields = "c.id,c.time,c.contents,u.id as userid,u.username,goods.id as goods_id,goods.name as goods_name";
		$query->where = "c.id=".$cid;
		$items = $query->find();

		if($items)
		{
			$this->comment = $items[0];
			$this->redirect('comment_edit');
		}
		else
		{
			$this->comment_list();
			$msg = '没有找到相关记录！';
			Util::showMessage($msg);
		}
	}

	/**
	 * @brief 删除要删除的评论
	 */
	function comment_del()
	{
		$comment_ids = IReq::get('check');
		$comment_ids = is_array($comment_ids) ? $comment_ids : array($comment_ids);
		if($comment_ids)
		{
			$comment_ids =  IFilter::act($comment_ids,'int');

			$ids = implode(',',$comment_ids);
			if($ids)
			{
				$tb_comment = new IModel('comment');
				$where = "id in (".$ids.")";
				$tb_comment->del($where);
			}
		}
		$this->comment_list();
	}

	/**
	 * @brief 讨论信息列表
	 */
	function discussion_list()
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
		//筛选
		$username = IFilter::act(IReq::get('username'));
		$goodsname = IFilter::act(IReq::get('goodsname'));
		$beginTime = IFilter::act(IReq::get('beginTime'));
		$endTime = IFilter::act(IReq::get('endTime'));
		$this->data['username'] = $username;
		$this->data['goodsname'] = $goodsname;
		$this->data['beginTime'] = $beginTime;
		$this->data['endTime'] = $endTime;
		if($username)
		{
			$where .= ' and u.username like "%'.$username.'%"';
		}
		if($goodsname)
		{
			$where .= ' and goods.name like "%'.$goodsname.'%"';
		}
		if($beginTime)
		{
			$where .= ' and d.time > "'.$beginTime.'"';
		}
		if($endTime)
		{
			$where .= ' and d.time < "'.$endTime.'"';
		}
		$this->data['where'] = $where;
		$this->setRenderData($this->data);
		$this->redirect('discussion_list',false);
	}

	/**
	 * @brief 显示讨论信息
	 */
	function discussion_edit()
	{
		$did = intval(IReq::get('did'));
		if(!$did)
		{
			$this->discussion_list();
			return false;
		}
		$query = new IQuery("discussion as d");
		$query->join = "right join goods as goods on d.goods_id = goods.id left join user as u on d.user_id = u.id";
		$query->fields = "d.id,d.time,d.contents,u.id as userid,u.username,goods.id as goods_id,goods.name as goods_name";
		$query->where = "d.id=".$did;
		$items = $query->find();

		if($items)
		{
			$this->discussion = $items[0];
			$this->redirect('discussion_edit');
		}
		else
		{
			$this->discussion_list();
			$msg = '没有找到相关记录！';
			Util::showMessage($msg);
		}
	}

	/**
	 * @brief 删除讨论信息
	 */
	function discussion_del()
	{
		$discussion_ids = IReq::get('check');
		$discussion_ids = is_array($discussion_ids) ? $discussion_ids : array($discussion_ids);
		if($discussion_ids)
		{
			$ids = implode(',',$discussion_ids);
			if($ids)
			{
				$tb_discussion = new IModel('discussion');
				$where = "id in (".$ids.")";
				$tb_discussion->del($where);
			}
		}
		$this->discussion_list();
	}

	/**
	 * @brief 咨询信息列表
	 */
	function refer_list()
	{
		$search = IReq::get('search');
		$keywords = IReq::get('keywords');
		$status = IReq::get('status');
		$where = ' 1 ';
		if($search && $keywords)
		{
			$where .= " and $search like '%{$keywords}%' ";
		}
		$this->data['search'] = $search;
		$this->data['keywords'] = $keywords;
		//筛选
		$username = IFilter::act(IReq::get('username'));
		$goodsname = IFilter::act(IReq::get('goodsname'));
		$beginTime = IFilter::act(IReq::get('beginTime'));
		$endTime = IFilter::act(IReq::get('endTime'));
		$this->data['username'] = $username;
		$this->data['goodsname'] = $goodsname;
		$this->data['beginTime'] = $beginTime;
		$this->data['endTime'] = $endTime;
		if($username)
		{
			$where .= ' and u.username like "%'.$username.'%"';
		}
		if($goodsname)
		{
			$where .= ' and goods.name like "%'.$goodsname.'%"';
		}
		if($beginTime)
		{
			$where .= ' and r.time > "'.$beginTime.'"';
		}
		if($endTime)
		{
			$where .= ' and r.time < "'.$endTime.'"';
		}
		if($status=='0')
		{
			$where .= ' and r.status = 0';
		}
		$this->data['where'] = $where;
		$this->setRenderData($this->data);
		$this->redirect('refer_list',false);
	}

	/**
	 * @brief 删除咨询信息
	 */
	function refer_del()
	{
		$refer_ids = IReq::get('check');
		$refer_ids = is_array($refer_ids) ? $refer_ids : array($refer_ids);
		if($refer_ids)
		{
			$refer_ids = IFilter::act($refer_ids,'int');
			$ids = implode(',',$refer_ids);
			if($ids)
			{
				$tb_refer = new IModel('refer');
				$where = "id in (".$ids.")";
				$tb_refer->del($where);
			}
		}
		$this->refer_list();
	}

	/**
	 * @brief 显示咨询信息
	 */
	function refer_edit()
	{
		$rid = intval(IReq::get('rid'));
		if(!$rid)
		{
			$this->refer_list();
			$msg = '没有找到相关记录！';
			Util::showMessage($msg);
			return false;
		}
		$tb_refer = new IModel('refer');
		$items = $tb_refer->query("id=".$rid);
		if(is_array($items) && $item=$items[0])
		{
			if($item['goods_id'])
			{
				$tb_goods = new IModel('goods');
				$data_goods = $tb_goods->query("id=".$item['goods_id']);
				if($data_goods && is_array($data_goods) && $info=$data_goods[0])
				{
					$item['goods_name'] = $info['name'];
				}
			}
			if($item['user_id'])
			{
				$tb_user = new IModel('user');
				$data_user = $tb_user->query("id=".$item['user_id']);
				if($data_user && is_array($data_user) && $info=$data_user[0])
				{
					$item['user_name'] = $info['username'];
				}
			}
			if($item['admin_id'])
			{
				$tb_admin = new IModel('admin');
				$data_admin = $tb_admin->query("id=".$item['admin_id']);
				if($data_admin && is_array($data_admin) && $info=$data_admin[0])
				{
					$item['admin_name'] = $info['admin_name'];
				}
			}
			$this->refer = $item;
			$this->redirect('refer_edit');
		}
		else
		{
			$this->refer_list();
			$msg = '没有找到相关记录！';
			Util::showMessage($msg);
			return false;
		}
	}

	/**
	 * @brief 回复咨询信息
	 */
	function refer_reply()
	{
		$rid = intval(IReq::get('refer_id','post'));
		$content = IReq::get('content');
		if($rid && $content)
		{
			$content = IFilter::string($content, true);
			$tb_refer = new IModel('refer');
			$admin_id = $this->admin['admin_id'];//管理员id
			$data = array('answer'=>$content, 'reply_time'=>date('Y-m-d H:i:s'), 'admin_id'=>$admin_id,'status'=>1);
			$tb_refer->setData($data);
			$tb_refer->update("id=".$rid);
		}
		$this->refer_list();
	}

	/**
	 * @brief 站内消息列表
	 */
	function message_list()
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
		$this->redirect('message_list');
	}

	/**
	 * @brief 删除咨询信息
	 */
	function message_del()
	{
		$refer_ids = IReq::get('check');
		$refer_ids = is_array($refer_ids) ? $refer_ids : array($refer_ids);
		if($refer_ids)
		{
			$ids = implode(',',$refer_ids);
			if($ids)
			{
				$tb_refer = new IModel('message');
				$where = "id in (".$ids.")";
				$tb_refer->del($where);
			}
		}
		$this->message_list();
	}

	/**
	 * 发送消息
	 */
	function message_send()
	{
		$this->layout = '';
		$this->redirect('message_send');
	}

	/**
	 * @brief 发送信件
	 */
	function start_message()
	{
		$toUser  = IFilter::act(IReq::get('toUser'));
		$title   = IFilter::act(IReq::get('title'));
		$content = IFilter::act(IReq::get('content'));

		if(!$title || !$content)
		{
			die('<script type="text/javascript">parent.startMessageCallback(0);</script>');
		}

		Mess::sendToUser($toUser,array('title' => $title,'content' => $content));
		die('<script type="text/javascript">parent.startMessageCallback(1);</script>');
	}
}