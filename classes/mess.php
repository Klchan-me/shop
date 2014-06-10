<?php
/**
 * @copyright (c) 2011 jooyea.cn
 * @file mess.php
 * @brief 站内消息的管理
 * @author chendeshan
 * @date 2013/11/13 11:44:08
 * @version 0.6
 */
 /**
  * example:
  * $message = new Mess($data['user_id']);
  * $message->writeMessage('0',1);
 */
class Mess
{
	//用户信息数据库实例
	private $memberDB = null;

	//用户id
	private $user_id = '';

	//用户消息ID
	private $messageIds = '';

	/**
	 * @brief 构造函数 用户id
	 * @param string $user_id 用户id
	 */
	function __construct($user_id)
	{
		$this->user_id  = $user_id;
		$this->memberDB = new IModel('member');
		$memberRow      = $this->memberDB->getObj('user_id = '.$user_id);
		$this->messageIds = $memberRow['message_ids'];
	}

	/**
	 * @brief 存储消息串
	 * @return boolean
	 */
	private function save()
	{
		$this->memberDB->setData(array('message_ids' => $this->messageIds));
		return $this->memberDB->update('user_id='.$this->user_id);
	}

	/**
	 * @brief 将messageid写入member表中
	 * @param $message_id int 消息的id
	 * @param $read int 0:未读(追加到用户id串后面)，1:已读(把用户id串增加‘-’负号)
	 * @return int or boolean
	 */
	public function writeMessage($message_id,$read = 0)
	{
		if($read == 1)
		{
			$tempIds = ','.trim($this->messageIds,',').',';
			if(strpos($tempIds,','.$message_id.',') === false)
			{
				return false;
			}
			$tempIds = str_replace(','.$message_id.',',',-'.$message_id.',',$tempIds);
			$this->messageIds = trim($tempIds,',').',';
		}
		else
		{
			$this->messageIds .= $message_id.',';
		}

		return $this->save();
	}
	/**
	 * @brief 获得member表中的messageid,去掉 '-' 且没有最后的 ',' 的message的id
	 * @return $message String 返回站内所有消息id的字符串
	 */
	public function getAllMsgIds()
	{
		return str_replace('-','',trim($this->messageIds,','));
	}
	/**
	 * @brief 判断messageid是否已经读过
	 * @param $mess_id int message的id
	 * @return $is_blog boolean 返回true为已读，false为未读
	 */
	public function is_read($messageId)
	{
		if(strpos(','.trim($this->messageIds,',').',',',-'.$messageId.',') === false)
		{
			return false;
		}
		return true;
	}

	/**
	 * @brief 删除member表中的message_ids的数据
	 * @param $message_id string 要删除的消息ID值
	 * @return string message_ids结果字符串
	 */
	public function delMessage($message_id)
	{
		$tempIds = str_replace(','.$message_id.',','',','.trim($this->messageIds,',').',');
		$tempIds = str_replace(',-'.$message_id.',','',','.trim($this->messageIds,',').',');
		$tempIds = trim($tempIds,',').',';
		$this->messageIds = $tempIds;
		$this->save();
	}

	/**
	 * 直接发站内信到用户
	 * 这个地方直接调用了Mysql的操作类
	 * @param $userIds string 用户Id的串
	 * @param $content 信件内容 array('title' => '标题','content' => '内容')
	 */
	public static function sendToUser($userIds,$content)
	{
		set_time_limit(0);

		//插入$content
		$data = array(
			'title'   => IFilter::act($content['title']),
			'content' => IFilter::act($content['content'],'text'),
			'time'    => date('Y-m-d H:i:s')
		);

		$msgDB = new IModel("message");
		$msgDB->setData($data);
		$id = $msgDB->add();

		if($id === false)
		{
			return false;
		}
		else
		{
			$db = IDBFactory::getDB();
			$tableName = IWeb::$app->config['DB']['tablePre']."member";
			if($userIds)
			{
				$sql = "UPDATE `{$tableName}` SET message_ids = CONCAT( IFNULL(message_ids,'') ,'{$id},') WHERE user_id in ({$userIds})";
			}
			else
			{
				$sql = "UPDATE `{$tableName}` SET message_ids = CONCAT( IFNULL(message_ids,'') ,'{$id},')";
			}
			return $db->query($sql);
		}
	}

	/**
	 * @brief 获取未读的短消息
	 * @return int 消息数量
	 */
	public function needReadNum()
	{
		$tempIds = ','.trim($this->messageIds,',').',';
		preg_match_all('|,\d+|',$tempIds,$result);
		return count(current($result));
	}
}