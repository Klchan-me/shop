<?php
/**
 * @copyright (c) 2011 jooyea.cn
 * @file DBBackup.php
 * @brief 数据库备份
 * @author chendeshan
 * @date 2010-12-16
 * @version 0.6
 */

/**
 * @class DBBackup
 * @brief 数据库备份类
 */
class DBBackup
{
	private $maxLimit     = 2000;              //设置最大读取数据条数(条)
	private $partSize     = 5000;              //分卷大小(KB)
	private $ctrlRes      = array();           //要操作的资源
	private $fileName     = null;              //当前备份数据的文件名
	private $part         = 1;                 //分卷号初始值
	private $totalSize    = 0;                 //备份数据共占字节数
	private $showMess     = false;             //展示状态信息
	private $dir          = 'backup/database'; //备份路径
	private $fPrefix      = 'iwebshop';        //备份文件名前缀
	private $fExtend      = '.sql';            //备份文件扩展名

	//构造函数
	function __construct($ctrlRes = null)
	{
		$this->ctrlRes = $ctrlRes;
		if(isset(IWeb::$app->config['dbbackup']) && IWeb::$app->config['dbbackup']!=null)
			$this->dir = IWeb::$app->config['dbbackup'];

		if(!file_exists($this->dir))
		{
			IFile::mkdir($this->dir);
		}
	}

	//备份的文件列表
	function getList()
	{
		$excepArray = array('.','..','.svn');
		$fileArray  = array(
			'system'   => array(),
			'unsystem' => array(),
		);

		$dirRes = opendir($this->dir);
		while( $fileName = readdir($dirRes) )
		{
			if(!in_array($fileName,$excepArray))
			{
				if(stripos($fileName,$this->fPrefix) !== false && stripos($fileName,$this->fExtend) !== false)
					$key = 'system';
				else
					$key = 'unsystem';

				$sortKey = filectime($this->dir.'/'.$fileName);
				$fileArray[$key][$sortKey] = array(
					'name' => $fileName,
					'size' => number_format(filesize($this->dir.'/'.$fileName)/1024,1),
					'time' => date('Y-m-d H:i:s', $sortKey )
				);
				krsort($fileArray[$key]);
			}
		}
		return $fileArray;
	}

	//下载文件
	function download($file)
	{
		header('Content-Description: File Transfer');
		header('Content-Length: '.filesize($this->dir.'/'.$file));
		header('Content-Disposition: attachment; filename='.basename($file));
		readfile($this->dir.'/'.$file);
		return $this->dir.'/'.$file;
	}

	//删除数据备份文件
	function del()
	{
		foreach($this->ctrlRes as $val)
		{
			if(file_exists($this->dir.'/'.$val))
				unlink($this->dir.'/'.$val);
			else
				return false;
		}
	}

	//执行恢复
	function runRes()
	{
		foreach($this->ctrlRes as $val)
		{
			$fileName = $this->dir.'/'.$val;
			$this->parseSQL($fileName);
		}
	}

	//解析备份文件中的SQL
	function parseSQL($fileName)
	{
		$fhandle  = fopen($fileName,'r');
		while(!feof($fhandle))
		{
			$lstr = fgets($fhandle);     //获取指针所在的一行数据

			//判断当前行存在字符
			if(isset($lstr[0]) && $lstr[0]!='#')
			{
				$prefix = substr($lstr,0,2);  //截取前2字符判断SQL类型
				switch($prefix)
				{
					case '--' :
					case '//' :
					{
						continue;
					}

					case '/*':
					{
						if(substr($lstr,-5) == "*/;\r\n" || substr($lstr,-4) == "*/\r\n")
							continue;
						else
						{
							$this->skipComment($fhandle);
							continue;
						}
					}

					default :
					{
						$sqlArray[] = trim($lstr);
						if(substr(trim($lstr),-1) == ";")
						{
							$sqlStr   = join($sqlArray);
							$sqlArray = array();

							$this->query($sqlStr);

							//回调函数
							$this->actionCallBack($fileName);
						}
					}
				}
			}
		}
	}

	//略过注释
	function skipComment($fhandle)
	{
		$lstr = fgets($fhandle,4096);
		if(substr($lstr,-5) == "*/;\r\n" || substr($lstr,-4) == "*/\r\n")
			return true;
		else
			$this->skipComment($fhandle);
	}

	//执行SQL
	function query($sql)
	{
		//创建数据库对象
		$dbObj = IDBFactory::getDB();
		$dbObj->query($sql);
	}

	//打包下载
	function packDownload()
	{
		if(class_exists('ZipArchive'))
		{
			$fileName = $this->fPrefix.'_'.date('Ymd_His').'.zip';
			$zip = new ZipArchive();
			$zip->open($this->dir.'/'.$fileName,ZIPARCHIVE::CREATE);
			foreach($this->ctrlRes as $file)
			{
				$attachfile = $this->dir.'/'.$file;
				$zip->addFile($attachfile,basename($attachfile));
			}
			$zip->close();

			return $fileName;
		}
		else
		{
			return false;
		}
	}

	//动作执行回调函数
	function actionCallBack($mess)
	{
		//防止超时
		set_time_limit(60);
	}

	//设置展示状态开关
	function setShowMess($isOpen = false)
	{
		$this->showMess = $isOpen;
	}

	//设置备份的路径
	function setDir($dir)
	{
		$this->dir = $dir;
	}

	//设置分卷大小(KB)
	function setPartSize($size)
	{
		$this->partSize = $size;
	}

	//设置最大读取数据条数(条)
	function setMaxLimit($maxLimit)
	{
		$this->maxLimit = $maxLimit;
	}

	//执行备份
	function runBak()
	{
		//循环表
		foreach($this->ctrlRes as $name)
		{
			$tableStruct = $this->createStructure($name);//生成表结构
			$sumTime     = $this->countTime($name);      //计算写入文件的总次数

			//生成表数据
			$tableData   = '';
			for($time = 0;$time < $sumTime;$time++)
			{
				$offset = $time * $this->maxLimit;        //计算读取开始偏移值
				$data   = $this->getData($name,$offset);  //根据偏移值获取数据
				foreach($data as $rs)
				{
					$tableData.= $this->createInsert($name,$rs);
				}

				//表结构和$time次的表数据 总和
				$content = $tableStruct.$tableData;

				//判断文件是否溢出,如果溢出则分卷
				if($this->checkOverflow(strlen($content)))
				{
					$this->part+=1;
				}

				$this->writeFile($this->getFilename(),$content); //写入文件

				//清空数据
				$tableStruct = '';
				$tableData   = '';
			}
			//回调函数
			$this->actionCallBack($name);
		}
	}

	//写入文件
	function writeFile($fileName,$content)
	{
		$fileObj = new IFile($fileName,'a+');
		$fileObj->write($content);
	}

	//检测文件是否存放的数据是否溢出
	function checkOverflow($cSize)
	{
		$this->totalSize+=$cSize;
		if($this->totalSize >= ($this->partSize<<10)*$this->part)
			return true;
		else
			return false;
	}

	//生成文件名
	function getFilename()
	{
		if($this->fileName === null)
		{
			//获取当前时间:年月日_时分秒
			$nowTime = date('Ymd_His');
			$this->fileName = $this->dir.'/'.$this->fPrefix.'_'.$nowTime.'_'.rand(1000000,9999999);
			return $this->fileName.'_'.$this->part.$this->fExtend;
		}
		else
			return $this->fileName.'_'.$this->part.$this->fExtend;
	}

	//获取分段数据(数据库)
	function getData($name,$offset=0)
	{
		//创建数据库对象
		$dbObj = IDBFactory::getDB();

		//获取从$start至$limitNum这段数据
		$sql   = 'SELECT * FROM '.$name.' LIMIT '.$offset.','.$this->maxLimit;
		$data  = $dbObj->query($sql);
		return $data;
	}

	//计算$name数据表写入次数(数据库)
	function countTime($name)
	{
		$dbObj = IDBFactory::getDB();

		//获取数据表总的数据条数
		$sql      = 'SELECT COUNT(*) as num FROM '.$name;
		$numArray = $dbObj->query($sql);
		$dataNum  = $numArray[0]['num'];

		//计算读取的分页数
		if($dataNum > 0)
			return ceil($dataNum/$this->maxLimit);
		else
			return 1;
	}

	//创建$name数据表中的$data数据的INSERT SQL语句
	function createInsert($name,$data)
	{
		$insertSql = 'INSERT INTO `'.$name.'` VALUES( ';
		foreach($data as $key => $val)
		{
			if(is_int($key)) continue;
			$insertSql.= '\''.mysql_real_escape_string($val).'\',';
		}
		$insertSql = rtrim($insertSql,',');
		$insertSql.= " ); \r\n";
		return $insertSql;
	}

	//创建$name数据表结构的SQL语句(数据库)
	function createStructure($name)
	{
		//创建数据库对象
		$dbObj = IDBFactory::getDB();

		//获取$name表信息
		$tableInfoArray = $dbObj->query('SHOW TABLE STATUS WHERE Name = \''.$name.'\'');
		$tableInfo  = $tableInfoArray[0];

		//获取$name表的字段信息
		$columnInfo = $dbObj->query('SHOW FULL COLUMNS FROM `'.$name.'`');
		$columnNum  = count($columnInfo);

		//SQL初始化拼接字符串
		$bakContent = "DROP TABLE IF EXISTS `".$name."`;\r\n CREATE TABLE `".$name."` (\r\n";

		//SQL拼接$name表的字段信息
		foreach($columnInfo as $key => $value)
		{
			//SQL字段和类型
			$bakContent.='`'.$value['Field'].'` '.$value['Type'];

			//SQL是否为空
			$bakContent.=($value['Null']==='NO') ? ' NOT NULL ':' NULL ';

			//SQL索引
			if($value['Key'])
			{
				switch($value['Key'])
				{
					case "PRI":
					$bakContent.=' PRIMARY KEY ';
					break;

					case "MUL":
					$bakContent.='';
					break;

					case "UNI":
					$bakContent.=' UNIQUE KEY ';
					break;
				}
			}

			//SQL默认值
			if($value['Default']!='')
				$bakContent.=' DEFAULT '.$value['Default'];
			else if($value['Null']==='YES' && $value['Default']==NULL)
				$bakContent.=' DEFAULT NULL ';

			//SQL额外
			$bakContent.=($value['Extra']==null)   ? '' : $value['Extra'];

			//SQL注释
			$bakContent.=($value['Comment']==null) ? '' : ' COMMENT \''.addslashes($value['Comment']).'\'';
			$bakContent.=(($key+1) == $columnNum)  ? '': ",\r\n";
		}
		//SQL字段结构结束
		$bakContent.="\r\n )";

		//SQL拼接$name表信息
		$bakContent.=($tableInfo['Engine']!==null) ? ' ENGINE='.$tableInfo['Engine'] : '';
		if($tableInfo['Collation']!=null)
		{
			$collation = explode('_',$tableInfo['Collation']);
			$charset   = $collation[0];
		}
		else
			$charset   = '';

		$bakContent.=$charset ? ' CHARSET='.$charset : '';
		$bakContent.=($tableInfo['Comment']!==null)        ? ' COMMENT=\''.$tableInfo['Comment'].'\'' : '';
		$bakContent.=($tableInfo['Auto_increment']!==null) ? ' AUTO_INCREMENT='.$tableInfo['Auto_increment'] : '';
		$bakContent.=";\r\n\r\n";
		return $bakContent;
	}
}
