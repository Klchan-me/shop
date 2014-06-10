<?php
/**
 * @copyright (c) 2011 jooyea.cn
 * @file api.php
 * @brief api
 * @author chendeshan
 * @date 2011-9-29
 * @version 0.6
 */
define('API_PATH',dirname(__FILE__).'/api/');
/**
 * @class Api
 * @brief api处理类
 */
class Api
{
	//已经存在的api对象集[单例]
	private static $apiInstance = array();

	//api资源配置信息[单例]
	private static $apiResource = array();

    /**
     * @brief api调用接口
     * @param string $apiName API名称
     * @return mixed
     */
	public static function run($apiName)
	{
		//载入api资源配置信息
		if(empty(self::$apiResource))
		{
			self::$apiResource = include(API_PATH.'api_resource.php');
		}

		//资源配置信息中不存在当前调用的API
		if(!isset(self::$apiResource[$apiName]))
		{
			self::error($apiName,'api is undefined');
		}

		//匿名参数处理
		$agumentsArray = func_get_args();
		array_shift($agumentsArray);

		$apiConf = self::$apiResource[$apiName];

		//1,单纯的数据库读取方式
		if(isset($apiConf['query']) && !empty($apiConf['query']))
		{
			return self::query($apiConf['query'],$agumentsArray);
		}
		//2,自定义处理方式
		else
		{
			$fileName   = isset($apiConf['file'])  ? $apiConf['file']  : '';
			$className  = isset($apiConf['class']) ? $apiConf['class'] : '';
			$methodName = $apiName;

			if(!$fileName || !$className)
			{
				self::error($apiName,'param is lack');
			}

			//如果当前API中的自定义处理对象已经存在,则直接调用
			if(isset(self::$apiInstance[$className]) && (self::$apiInstance[$className] instanceof $className))
			{
				return call_user_func_array(array(self::$apiInstance[$className],$methodName),$agumentsArray);
			}
			//自定义对象不存在则需要创建
			else
			{
				if(file_exists(API_PATH.$fileName))
				{
					include(API_PATH.$fileName);
					if(!class_exists($className))
					{
						self::error($apiName,'class is not exists');
					}

					$apiObj = new $className;
					self::$apiInstance[$className] = $apiObj;
					return call_user_func_array(array($apiObj,$methodName),$agumentsArray);
				}
				else
				{
					self::error($apiName,'file is not exists');
				}
			}
		}
	}

    /**
     * @brief 单纯数据库查询api统一处理方法
     * @param array $queryInfo 数据查询配置信息
     * @param array $aguments  排序和限制条数(order,limit)
     * @return array
     */
	private static function query($queryInfo,$aguments)
	{
		//参数重置order,limit参数
		if(!empty($aguments))
		{
			foreach($aguments as $param)
			{
				if(is_numeric($param))
				{
					$queryInfo['limit'] = $param;
				}
				else
				{
					$queryInfo['order'] = str_replace(array('+','-'),array(' asc',' desc'),$param);
				}
			}
		}

		$tableObj = new IQuery($queryInfo['name']);
		unset($queryInfo['name']);

		foreach($queryInfo as $key => $val)
		{
			$tableObj->$key = $val;
		}

		return $tableObj->find();
	}

    /**
     * @brief api错误处理
     * @param string $apiName api名称
     * @param string $message 错误信息
     * @return Error
     */
	private static function error($apiName,$message)
	{
		throw new IHttpException("API of ".$apiName." is called error , ".$message,403);
		exit;
	}
}