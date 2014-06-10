<?php
/**
 * @copyright (c) 2011 jooyea.cn
 * @file db_class.php
 * @brief 数据库抽象父类
 * @author chendeshan
 * @date 2010-12-3
 * @version 0.6
 */

/**
* @class IDB
* @brief 数据库底层抽象类
*/
abstract class IDB
{
	//数据库写操作连接资源
	private static $wTarget = NULL;

	//数据库读操作连接资源
	private static $rTarget = NULL;

	//SQL类型
	protected static $sqlType = NULL;

	/**
	* @brief 获取SQL语句的类型,类型：select,update,insert,delete
	* @param string $sql 执行的SQL语句
	* @return string SQL类型
	*/
	private function getSqlType($sql)
	{
		$strArray = explode(' ',trim($sql),2);
		return strtolower($strArray[0]);
	}

	/**
	 * @brief 设置数据库读写分离并且执行SQL语句
	 * @param string $sql 要执行的SQL语句
	 * @return int or bool SQL语句执行的结果
	 */
    public function query($sql)
    {
		//取得SQL类型
        self::$sqlType = $this->getSqlType($sql);

		//读方式
        if(self::$sqlType=='select' || self::$sqlType=='show')
        {
            if(self::$rTarget == NULL || !is_resource(self::$rTarget))
            {
				//多数据库支持并且读写分离
                if(isset(IWeb::$app->config['DB']['read']))
                {
					//获取ip地址
					$ip = IClient::getIP();

                    $this->connect(IHash::hash(IWeb::$app->config['DB']['read'],$ip));
                }
                else
                {
                	$this->connect(IWeb::$app->config['DB']);
                }
                self::$rTarget = $this->linkRes;
            }
        }
        //写方式
        else
        {
            if(self::$wTarget == NULL || !is_resource(self::$wTarget))
            {
				//多数据库支持并且读写分离
                if(isset(IWeb::$app->config['DB']['write']))
                {
                	$this->connect(IWeb::$app->config['DB']['write']);
                }
                else
                {
                	$this->connect(IWeb::$app->config['DB']);
                }
                self::$wTarget = $this->linkRes;
            }
        }

        if(is_resource($this->linkRes))
        {
        	return $this->doSql($sql);
        }
        else
        {
        	return false;
        }

    }

	//数据库连接
    abstract public function connect($dbinfo);

	//执行sql通用接口
    abstract public function doSql($sql);
}
?>