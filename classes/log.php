<?php
/**
 * @class log
 * @brief 日志记录类
 */
class Log
{
	private $logType = 'file';//默认日志类型
	private $log     = null;
	private $logInfo = array(
		'error'     => array('table' => 'log_error',    'cols' => array('file','line','content')),
		'sql'       => array('table' => 'log_sql',      'cols' => array('content','runtime')),
		'operation' => array('table' => 'log_operation','cols' => array('author','action','content')),
	);

	//获取日志对象
	public function __construct($logType = '')
	{
    	if($logType === '')
    	{
    		$logType = isset(IWeb::$app->config['logs']['type']) ? IWeb::$app->config['logs']['type'] : $this->logType;
    	}
		$this->log = ILogFactory::getInstance($logType);
	}

	//写入日志
	public function write($type,$logs = array())
	{
		$logInfo = $this->logInfo;
		if(!isset($logInfo[$type]))
		{
			return false;
		}

		$className = get_class($this->log);

		switch($className)
		{
			//文件日志
			case "IFileLog":
			{
				//设置路径
				$path     = isset(IWeb::$app->config['logs']['path']) ? IWeb::$app->config['logs']['path'] : 'backup/log';
				$fileName = rtrim($path,'\\/').'/'.$type.'/'.date('Y/m').'/'.date('d').'.log';
				$this->log->setPath($fileName);

				$logs     = array_merge(array(ITime::getDateTime()),$logs);
				return $this->log->write($logs);
			}
			break;

			//数据库日志
			case "IDBLog":
			{
				$content['datetime'] = ITime::getDateTime();
				$tableName           = $logInfo[$type]['table'];

				foreach($logInfo[$type]['cols'] as $key => $val)
				{
					$content[$val] = isset($logs[$val]) ? $logs[$val] : isset($logs[$key]) ? $logs[$key] : '';
				}
				$this->log->setTableName($tableName);
				return $this->log->write($content);
			}
			break;

			default:
			return false;
			break;
		}
	}
}