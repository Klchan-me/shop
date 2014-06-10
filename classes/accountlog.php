<?php
/**
 * @copyright (c) 2011 jooyea.cn
 * @file ad.php
 * @brief 关于广告管理
 * @author walu
 * @date 2011-02-14
 * @version 0.6
 */

/**
 * 将对用户余额进行的操作记入account_log表
 *
 * $user_id = 用户id
 *
 * $log = new AccountLog($user_id);
 * $config=array(
 *		'admin_id'=>管理员的id, //如果需要的话
 *		'event'=>操作类别, withdraw:提现,pay:余额支付,recharge:充值,drawback:退款到余额
 *		'note'=>备注信息，//如果不设置的话则根据event类型自动生成，如果设置了则不再对数据完整性进行检测，比如是否设置了管理员id、订单信息等
 *		'num'=> 金额 , //整形或者浮点，正为增加，负为减少
 * 		'order_no' =>订单号 // drawback类型的log需要这个值
 * 	);
 * $re = $log->write($config);
 *
 * 如果$re===true,记录成功，如果$re是数组，里面存着的则是错误信息
 *
 * @author walu
 */
class AccountLog
{
	private $user = array('id'=>0,'username'=>'');
	private $admin = array('id'=>0,'admin_name'=>'');
	private $time = null;
	private $_note = null;
	private $config = null;

	private $event = null;
	private $allow_event = array(
		'recharge'=>1,	//充值到余额
		'withdraw'=>2,	//从余额提现
		'pay'=>3,		//从余额支付
		'drawback'=>4	//退款到余额
	);

	private $error = array();

	/**
	 * 构造函数
	 *
	 * @param int $user_id 用户id
	 */
	public function __construct($user_id=false)
	{
		if($user_id!==false)
		{
			$this->setUser($user_id);
		}
	}

	private function setUser($user_id)
	{
		$user_id = intval($user_id);
		$query = new IQuery("user AS u");
		$query->join = "left join member AS m ON u.id = m.user_id";
		$query->where = "u.id = {$user_id} ";

		$user = $query->find();
		if(!$user)
		{
			$this->error[]="没有id为{$user_id}的用户";
		}
		else
		{
			$user = end($user);
			$this->user = $user;
			$this->time = date('Y-m-d H:i:s');
		}
	}

	/**
	 * log的写方法
	 *
	 * $log=array(
	 * 	'user_id'=>用户id
	 *	'admin_id'=>管理员的id, //如果需要的话
	 *	'event'=>操作类别,
	 *	'note'=>备注信息，//如果不设置的话则根据event类型自动生成
	 *	'num'=> 金额 //整形或者浮点，正为增加，负为减少
	 * );
	 *
	 * @param array $log
	 * @return array|bool
	 */
	public function write($log)
	{
		if(!isset($log['user_id']))
		{
			return array('没有设置用户id');
		}
		$this->setUser($log['user_id']);

		if(!isset($log['num']))
		{
			return array('没有设置金额');
		}

		if(isset($log['admin_id']))
		{
			$this->setAdmin($log['admin_id']);
		}

		if(isset($log['event']))
		{
			$this->setEvent($log['event']);
		}

		if(isset($log['note']))
		{
			$this->note($log['note']);
		}

		$this->config = $log;

		return $this->log($log['num']);
	}

	/**
	 * 设置管理员信息
	 *
	 * @param int $admin_id
	 * @return Object
	 */
	private function setAdmin($admin_id)
	{
		$admin_id = intval($admin_id);
		$tb_admin = new IModel("admin");
		$admin = $tb_admin->getObj(" id = {$admin_id} ");
		if(!$admin)
		{
			$this->error[] = "没有id为{$admin_id}的用户";
		}
		else
		{
			$this->admin = $admin;
		}
		return $this;
	}

	/**
	 * 设置操作类别
	 *
	 * @param string $event_key
	 * @return Object
	 */
	private function setEvent($event_key)
	{
		if(!isset($this->allow_event[$event_key]))
		{
			$this->error[] = "错误的用户余额日志类型";
		}
		else
		{
			$this->event = $event_key;
		}
		return $this;
	}

	/**
	 * 生成note信息
	 */
	private function note($str=false)
	{
		if($str!==false)
		{
			$this->_note = $str;
			return;
		}

		$note = "";
		$num = $this->num;

		if($this->user['id']==0)
		{
			$this->error[] = "未设置用户信息";
		}

		switch($this->event)
		{
			case 'withdraw':
				if($this->admin['id']==0 )
					$this->error[] = "未设值管理员信息";

				$note = "管理员[{$this->admin['id']}]给用户[{$this->user['id']}]{$this->user['username']}提现，金额：{$num}元";

				break;

			case 'pay':
				$note = "用户[{$this->user['id']}]{$this->user['username']}通过余额支付用于购买，金额：{$num}元";
				break;

			case 'recharge':
				if($this->admin['id']==0)
				{
					$this->error[] = "未设置管理员信息";
				}
				$note = "管理员[{$this->admin['id']}]给用户[{$this->user['id']}]{$this->user['username']}充值，金额：{$num}元";
				break;

			case 'drawback':
				if(!isset($this->config['order_no']))
				{
					$this->error[] = "未设置订单id";
				}
				$note = "订单[{$this->config['order_no']}],退款到用户[{$this->user['id']}]{$this->user['username']}余额，金额：{$num}元";
				break;

			default:
				$this->error[] = "未设置的内容";
		}

		return $this->_note=$note;
	}

	/**
	 * 操作数据库
	 *
	 * @param float $num 操作金额
	 * @return bool|array 返回true代表成功，返回array代表着本次操作的错误信息
	 */
	private function log($num)
	{
		if( !is_numeric($num) )
		{
			$this->error[] = "错误的操作金额:{$num}";
			return $this->error;
		}
		$num = sprintf("%.2f",$num);
		$this->num = $num;

		if($this->_note===null)
		{
			$this->note();
		}

		if($this->error)
		{
			return $this->error;
		}

		$tb_account_log = new IModel("account_log");

		$arr = array();
		$arr['admin_id'] = $this->admin['id'];
		$arr['user_id'] = $this->user['id'];
		$arr['event'] = $this->allow_event[$this->event];
		$arr['note'] = IFilter::act($this->_note,'text');
		$arr['amount'] = $num;
		$arr['amount_log'] = $this->user['balance'];
		$arr['type'] = $num>=0 ? 0 : 1 ;
		$arr['time'] = $this->time;

		$tb_account_log->setData($arr);
		$tb_account_log->add();

		//后台管理员操作记录
		if($arr['admin_id'])
		{
			$logObj = new Log();
			$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"对账户金额进行了修改",$arr['note']));
		}

		return true;
	}

}

