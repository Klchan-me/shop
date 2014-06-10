<?php
/**
 * 与评论相关的
 *
 * @author walu
 * @packge iwebshop
 */

class Comment_Class
{
	/**
	 * 检测用户是否能够评论
	 *
	 * @param int $comment_id 评论id
	 * @param int $user_id 用户id
	 * @return array() array(成功or失败,数据)
	 */
	public static function can_comment($comment_id,$user_id)
	{
		$comment_id = intval($comment_id);
		$user_id = intval($user_id);

		$tb_comment = new IModel("comment");
		$comment = $tb_comment->getObj("id={$comment_id} AND user_id={$user_id}");
		if(!$comment)
		{
			return array(-1,"没有这条数据");
		}

		if($comment['status'] != 0)
		{
			return array(-2,$comment);
		}

		$time=strtotime($comment['time']);
		if($time < 3600*24*30*6 )
		{
			return array(-3,$comment);
		}
		return array(1,$comment);
	}

	/**
	 * 获取某个商品的有关分数的评论数据
	 *
	 * 获取好评、中评、差评数量及平均分
	 * 返回的值里包含以下几个计算出来的索引
	 *	<ul>
	 *		<li>point_total，总分</li>
	 *		<li>comment_total，评论总数</li>
	 *		<li>average_point，平均分</li>
	 *	</ul>
	 *
	 * @param int $id  goods_id
	 * @return array()
	 */
	public static function get_comment_info($id)
	{
		$data  = array();
		$query = new IQuery("comment");
		$query->fields = "COUNT(*) AS num,point";
		$query->where  = "goods_id = {$id} AND status=1 ";
		$query->group  = "point";

		$data['point_grade'] = array('none'=>0,'good'=>0,'middle'=>0,'bad'=>0);
		$config = array(0=>'none','1'=>'bad','2'=>'middle',3=>'middle',4=>'middle',5=>'good');
		$data['point_total'] = 0;

		foreach( $query->find() AS $value )
		{
			if($value['point']>=0 && $value['point']<=5)
			{
				$data['point_total']+=$value['point']*$value['num'];
				$data['point_grade'][$config[$value['point']] ] += $value['num'];
			}
		}
		$data['comment_total']=array_sum($data['point_grade']);
		$data['average_point']=0;
		if($data['point_total']>0)
		{
			$data['average_point'] = round($data['point_total'] / $data['comment_total'],1);
		}
		return $data;
	}
}
?>
