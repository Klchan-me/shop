<?php
/**
 * 与团购相关的操作
 *
 * @author walu
 * @package iwebshop
 */

class Regiment
{
	/**
	 * 检测某个团购是否满员
	 */
	public static function isFull($id)
	{
		$regiment = self::getRegimentById($id);
		if($regiment === false)
		{
			return false;
		}
		else
		{
			$re = $regiment['store_nums']!=0 && $regiment['user_num'] >= $regiment['store_nums'];
			return $re;
		}

	}

	/**
	 * 检测某个会员有没有报过名
	 * @param int $rid
	 * @param int|string int为user_id,string为hash string
	 */
	public static function hasJoined($rid,$user_id)
	{
		if(!$user_id)
		{
			return false;
		}
		$tb = new IModel("regiment_user_relation");
		$user_id = htmlspecialchars($user_id,ENT_QUOTES);
		$rid = intval($rid);

		if(is_numeric($user_id))
		{
			$user_id = intval($user_id);
			$re = $tb->query("user_id={$user_id} AND regiment_id = {$rid} ");
		}
		else
		{
			$re = $tb->query("`hash`='{$user_id}' AND regiment_id = {$rid}");
		}

		if($re)
		{
			$re = end($re);
			$time_limit = self::time_limit();
			$join_time = time() - $time_limit*60;
			$re = $re['is_over'] == 0 && strtotime($re['join_time']) > $join_time;
		}
		else
		{
			$re = false;
		}
		return $re;
	}

	/**
	 * 检测某个用户是否买过了
	 */
	public static function hasBought($rid,$user_id)
	{
		$tb = new IModel("regiment_user_relation");
		$user_id = intval($user_id);
		$rid = intval($rid);

		$re =(bool)$tb->query("user_id={$user_id} AND regiment_id = {$rid} AND is_over =1");
		return $re;
	}

	/**
	 * 获取往期的团购
	 *
	 * 与LiMenglei确定后：此操作返回的结果为：前三十天内结束的团购，按照购买人数倒序排列
	 *
	 * @static
	 */
	public static function getEverList()
	{
		$now = ITime::getNow();
		$start_time = date("Y-m-d H:i:s", ITime::getNow() - 60*3600*24*30  );
		$now = date("Y-m-d H:i:s",$now);
		$tb = new IModel("regiment");
		$list = $tb->query(" end_time < '{$now}' AND start_time > '{$start_time}' ORDER BY id DESC   ");
		return self::ps($list);
	}

	/**
	 * 获取往期的团购,已结束的，按照结束时间倒序排列
	 *
	 * @param int $page 获取列表中的第几页
	 * @return array 其中的query索引是本次查询用的query对象，传到view中用来生成分页
	 * @static
	 */
	public static function getEverListByPage($page=1)
	{
		$page = intval($page);
		$now = ITime::getNow();
		$start_time = date("Y-m-d H:i:s", ITime::getNow() - 60*3600*24*30  );
		$now = date("Y-m-d H:i:s",$now);
		$query = new IQuery("regiment");
		$query->where = " end_time < '{$now}'";
		$query->order = " end_time DESC ";
		$query->page = $page;
		$list = $query->find();
		$list =  self::ps($list);
		if(!$list)
		{
			$query = false;
		}
		return array('flag'=>true,'list'=>$list,'query'=>$query);
	}


	/**
	 * 获取当前时间内生效的团购列表
	 *
	 * @static
	 */
	public static function getList($id=null)
	{
		$now = ITime::getDateTime();
		$tb = new IModel("regiment");

		if($id===null)
		{
			$list = $tb->query(" start_time<='{$now}' AND end_time>='{$now}' AND is_close=0 ORDER BY id DESC ");
		}
		else
		{
			$id = intval($id);
			$list = $tb->query(" id = {$id} ");
		}
		$re = self::ps($list);
		//剔除满员的
		foreach($re as $key=>$value)
		{
			/*
			if( $value['store_nums'] !=0 && $value['user_num']>=$value['store_nums'])
			{
				unset($re[$key]);
			}
			*/
		}
		return array("flag"=>true,'list'=>$re);
	}

	public static function getRegimentById($id)
	{
		$id = intval($id);
		$tb = new IModel("regiment");
		$re = $tb->query(" id={$id} ");
		if($re)
		{
			$re = self::ps($re);
			$re = end($re);
			return $re;
		}
		else
			return false;
	}

	/**
	 * 用户报名参加团购
	 *
	 * 用户可以参加本次团购的条件：
	 * 1.本次团购还没有满员
	 * 2.一小时二十五分钟内，用户在本次团购中没有未完成的交易
	 *
	 * regiment_user_relation表中的is_over：0代表着还没有完成，1代表着已经完成交易了
	 * 如果用户没有登录便参加团购，会生成一个hash存在cookie里，名字为regiment_100,其中100是相应团购的id
	 * 并将此hash保存在regiment_user_relation表的hash字段里。在用户付账需要登录的时候应该查询这个hash并更新相应的user_id
	 *
	 * @static
	 */
	public static function join($id,$user_id=null)
	{
		$id = intval($id);
		$now = time();
		$regiment = self::getRegimentById($id);
		$time_limit=self::time_limit();
		if($regiment===false || ( 0 !=$regiment['store_nums'] &&  $regiment['user_num'] >= $regiment['store_nums']) || strtotime($regiment['end_time'])<$now || strtotime($regiment['start_time'])>$now  )
			return array('flag'=>'msg','data'=>'本次团购已过期或者人满');

		$tb = new IModel("regiment_user_relation");
		$data = array('user_id'=>"",'hash'=>"",'regiment_id'=>$id,'join_time'=>date("Y-m-d H:i:s",$now),'is_over'=>0);
		if($user_id!==null)
		{
			$user_id = intval($user_id);
			$re = $tb->query("regiment_id={$id} AND user_id={$user_id} AND is_over=0");
			$data['user_id'] = $user_id;
		}
		else
		{
			$hash = ICookie::get("regiment_{$id}");
			if($hash===null)
			{
				$hash = IHash::md5(serialize($_SERVER).microtime(1));
				ICookie::set("regiment_{$id}",$hash,$time=$time_limit*60);
			}
			$re = $tb->query("regiment_id={$id} AND hash='{$hash}' AND is_over=0");
			$data['hash'] = $hash;
		}

		if($re)
			$re=end($re);

		if(count($re)==0 || strtotime( $re['join_time'] ) < ( $now-$time_limit*60 )  )
		{
			$tb->setData($data);
			//$relation_id是关系表的主键
			if($re)
			{
				$tb->update("id={$re['id']}");
				$relation_id = $re['id'];
			}
			else
			{
				$relation_id = $tb->add();
			}

			return array('flag'=>true,'data'=>'参与成功','relation_id'=>$relation_id);
		}
		else
		{
			return array('flag'=>false,'data'=>'本次团购您存在未完成交易');
		}
	}

	/**
	 * 整理从regiment表里提出的数据
	 *
	 * 将会对每一行记录加上或整理以下索引的数据
	 *	<ul>
	 *		<li>user_num，已报名人数</li>
	 *		<li>valid，本次团购是否还接受报名</li>
	 *		<li>sell_price，原价，整理成100.21的形式</li>
	 *		<li>regiment_price，团购价，整理成100.21的形式</li>
	 *		<li>discount，折扣</li>
	 *	</ul>
	 *
	 * @param array $list
	 * @return array $list
	 * @static
	 */
	public static function ps($list)
	{
		$list = Util::array_rekey($list,'id');
		if($list)
		{
			//获取各个团购的已参与人数
			$ids = array_keys($list);
			$ids = implode(",",$ids);
			$tb = new IModel("regiment_user_relation");

			$time_limit=self::time_limit();
			$join_time = ITime::getNow()-60*$time_limit;
			$join_time = date("Y-m-d H:i:s",$join_time);
			$user_relation = $tb->query("regiment_id IN ({$ids}) AND join_time>'{$join_time}' GROUP BY regiment_id "," COUNT(*) AS num,regiment_id");
			$user_relation = Util::array_rekey($user_relation,"regiment_id");

			$now = time();

			foreach($list as $key=>$value)
			{
				$list[$key]['valid'] = true;
				$list[$key]['user_num'] = isset($user_relation[$value['id']])?$user_relation[$value['id']]['num']:0;
				if( 0!=$value['store_nums'] && $list[$key]['user_num'] >= $value['store_nums'] )
				{
					$list[$key]['valid'] = false;
				}

				$tmp_time=strtotime($list[$key]['end_time']);
				if($tmp_time<$now)
				{
					$list[$key]['valid']=false;
				}

				$list[$key]['sell_price'] = round($value['sell_price'],2);//原价
				$list[$key]['regiment_price'] = round($value['regiment_price'],2);//团购价
				if($value['regiment_price']===round(0,2))
				{
					$list[$key]['discount'] = 0;
				}
				else
				{
					if($list[$key]['sell_price']== round(0,2) )
					{
						$list[$key]['discount'] = 0;
					}
					else
					{
						$list[$key]['discount'] = $list[$key]['regiment_price'] / $list[$key]['sell_price'] *10 ;
						$list[$key]['discount'] = round( $list[$key]['discount'],1 );
					}
				}
			}
		}
		return $list;
	}

	public static function time_limit()
	{
		$site_config=new Config("site_config");
		$site_config=$site_config->getInfo();
		$re=60;
		if(isset($site_config['regiment_time_limit']) && $site_config['regiment_time_limit']>0 )
		{
			$re=intval($site_config['regiment_time_limit']);
		}
		return $re;
	}
}
?>
