<?php
/**
 * @copyright (c) 2011 jooyea.cn
 * @file mysql_class.php
 * @brief MYSQL数据库应用
 * @author chendeshan
 * @date 2010-12-3
 * @version 0.6
 */

/**
 * @class IMysql
 * @brief MYSQL数据库应用
 */
class IMysql extends IDB
{
	//数据库连接资源
	public $linkRes = false;

	/**
	 * @brief 数据库连接
	 * @param array $dbinfo 数据库的连接配制信息 [0]ip地址 [1]用户名 [2]密码 [3]数据库
	 * @return bool or resource 值: false:链接失败; resource类型:链接的资源句柄;
	 */
	public function connect($dbinfo)
	{
	  	$this->linkRes = mysql_connect($dbinfo['host'],$dbinfo['user'],$dbinfo['passwd']);
	  	if(is_resource($this->linkRes))
	  	{
		  	mysql_select_db($dbinfo['name'],$this->linkRes);
		  	$DBCharset = isset(IWeb::$app->config['DB']['charset'])?IWeb::$app->config['DB']['charset'] : 'utf8';
		  	mysql_query("SET NAMES '".$DBCharset."'");
		  	if(isset(IWeb::$app->config['db_mode']) && IWeb::$app->config['db_mode'] != '')
		  	{
		  		mysql_query("SET SESSION sql_mode = '".IWeb::$app->config['db_mode']."' ");
		  	}
		  	else
		  	{
		  		mysql_query("SET SESSION sql_mode = '' ");
		  	}
	  	}
	  	else
	  	{
	  		return false;
	  	}
	}

	/**
	* @brief MYSQL的SQL执行的系统入口
	* @param string $sql 要执行的SQL语句
	* @return mixed
	*/
	public function doSql($sql)
	{
		//读操作
		$readyConf = array('select','show','describe');
		if(in_array(self::$sqlType,$readyConf))
		{
			return $this->read($sql,MYSQL_ASSOC);
		}

		//写操作
		else
		{
			return $this->write($sql);
		}
	}

	/**
	* @brief 获取数据库内容
	* @param $sql SQL语句
	* @param $type 返回数据的键类型
	* @return array 查询结果集
	*/
	private function read($sql,$type=MYSQL_BOTH)
	{
		$result = array();
		$resource = mysql_query($sql,$this->linkRes);
		if($resource)
		{
			while($data = mysql_fetch_array($resource,$type))
			{
				$result[] = $data;
			}
			return $result;
		}
		else
		{
			throw new IException("{$sql}\n -- ".mysql_error($this->linkRes));
			return $result;
		}
	}

	/**
	* @brief 写入操作
	* @param string $sql SQL语句
	* @return int or bool 失败:false; 成功:影响的结果数量;
	*/
	private function write($sql)
	{
		$result = mysql_query($sql,$this->linkRes);

		if($result==true)
		{
			switch(self::$sqlType)
			{
				case "insert":
				return mysql_insert_id();
				break;

				default:
				return mysql_affected_rows();
				break;
			}
		}
		else
		{
			throw new IException($sql."\n -- ".mysql_error($this->linkRes));
			return false;
		}
	}
}
?>