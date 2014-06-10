<?php
/**
 * @copyright (c) 2011 jooyea.cn
 * @file filelog_class.php
 * @brief 文本格式日志
 * @author RogueWolf
 * @date 2010-12-09
 * @version 0.6
 * @note
 */

/**
 * @class IFileLog
 * @brief 文本格式日志处理类
 */
class IFileLog implements ILog
{
	//默认文件日志存放目录
	private $path = '';

	/**
	 * @brief 文件日志类的构造函数
	 */
	function __construct($path = '')
	{
		$this->path = $path;
	}

	/**
	 * @brief  写日志
	 * @param  array  $content loginfo数组
	 * @return bool   操作结果
	 */
	public function write($logs = array())
	{
		if(!is_array($logs) || empty($logs))
		{
			throw new IException('the $logs parms must be array');
		}

		if($this->path == '')
		{
			throw new IException('the file path is undefined');
		}

		$content = join("\t",$logs)."\t\r\n";

		//生成路径
		$fileName = $this->path;

		if(!file_exists($dirname = dirname($fileName)))
		{
			IFile::mkdir($dirname);
		}

		$result = error_log($content, 3 ,$fileName);

		if($result)
		{
			return true;
		}
		else
		{
			return false;
		}
	}

	/**
	 * @brief  设置路径
	 * @param  String $path 设置日志文件路径
	 */
	public function setPath($path)
	{
		$this->path = $path;
	}
}