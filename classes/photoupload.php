<?php
/**
 * @copyright (c) 2011 jooyea.cn
 * @file photoupload.php
 * @brief 图片上传防止重复类
 * @author chendeshan
 * @date 2010-12-16
 * @version 0.6
 */

/**
 * @class PhotoUpload
 * @brief 图片上传防止重复类
 */
class PhotoUpload
{
	private $dir         = 'upload'; //图片存储的目录名称
	private $iterance    = true;     //防止图片重复提交开关
	private $thumbWidth  = array();  //缩略图宽度
	private $thumbHeight = array();  //缩略图高度
	private $thumbKey    = array();  //缩略图返回键名

	//构造函数
	function __construct($dir = '')
	{
		//设置默认路径地址
		if($dir == '')
		{
			$dir = self::hashDir();
		}

		$this->setDir($dir);
	}

	/**
	 * @brief 获取图片散列目录
	 * @return string
	 */
	public static function hashDir()
	{
		$dir  = isset(IWeb::$app->config['upload']) ? IWeb::$app->config['upload'] : $this->dir;
		$dir .= '/'.date('Y/m/d');
		return $dir;
	}

	/**
	 * @brief 防止图片重复提交
	 * @param bool $bool true:开启;false:关闭
	 */
	public function setIterance($bool)
	{
		$this->iterance = $bool;
	}

	/**
	 * @brief 设置上传的目录
	 * @param string $dir
	 */
	public function setDir($dir)
	{
		$this->dir = $dir;
	}

	/**
	 * @brief 设置缩略图宽度和高度
	 * @param int    $width  生成缩略图宽度;
	 * @param int    $height 生成缩略图高度;
	 * @param string $key    返回缩略图键名;
	 */
	public function setThumb($width,$height,$key = 'thumb')
	{
		$this->thumbWidth[]  = intval($width);
		$this->thumbHeight[] = intval($height);

		if(in_array($key,$this->thumbKey))
		{
			$thumbCount = count($this->thumbKey) + 1;
			$key = $key.$thumbCount;
		}

		$this->thumbKey[] = $key;
	}

	//防止图片文件重复提交机制
	private function checkIterance($file,$photoObj)
	{
		//如果关闭了图片重复提交机制
		if($this->iterance == false)
			return null;

		$fileMD5  = null;    //上传图片的md5值(默认)
		$photoRow = array(); //图库里照片信息(默认)
		$result   = array(); //结果

		if(is_file($file))
		{
			//生成文件md5码
			$fileMD5 = md5_file($file);
		}

		if($fileMD5 != null)
		{
    		//根据md5值取得图像数据
    		$where = "id = '".$fileMD5."'";
    		$photoRow = $photoObj->getObj($where);
		}

		//设置了缩略图
		if(isset($photoRow['img']))
		{
			if(is_file($photoRow['img']))
			{
				$result['img'] = $photoRow['img'];
				$result['flag']= 1;

				if($this->thumbWidth && $this->thumbHeight && $this->thumbKey)
				{
					foreach($this->thumbWidth as $thumbWidth_Key => $thumbWidth_Val)
					{
						//获取此宽度和高度应有的缩略图名
				        $fileExt       = IFile::getFileSuffix($photoRow['img']);
				        $thumbFileName = str_replace('.'.$fileExt,'_'.$this->thumbWidth[$thumbWidth_Key].'_'.$this->thumbHeight[$thumbWidth_Key].'.'.$fileExt,$photoRow['img']);

						if(is_file($thumbFileName))
						{
							$result['thumb'][$this->thumbKey[$thumbWidth_Key]] = $thumbFileName;
							unset($this->thumbKey[$thumbWidth_Key]);
						}
					}

					//重新生成系统中不存在的此宽高的缩略图
					foreach($this->thumbKey as $thumbKey_key => $thumbKey_val)
					{
						$thumbExtName = '_'.$this->thumbWidth[$thumbKey_key].'_'.$this->thumbHeight[$thumbKey_key];
						$thumbName    = $this->thumb($photoRow['img'],$this->thumbWidth[$thumbKey_key],$this->thumbHeight[$thumbKey_key],$thumbExtName);
						$result['thumb'][$this->thumbKey[$thumbKey_key]] = $thumbName;
					}
				}
				return $result;
			}
			else
			{
				$photoObj->del('id = "'.$photoRow['id'].'"');
				return null;
			}
		}
		else
		{
			return null;
		}
	}

	/**
	 * @brief 图片信息入库
	 * @param array $insertData 要插入数据
	 		  object $photoObj  图库对象
	 */
	private function insert($insertData,$photoObj)
	{
		if($this->iterance == true && !$photoObj->getObj('id = "'.$insertData['id'].'"'))
		{
			$photoObj->setData($insertData);
			$photoObj->add();
		}
	}

	/**
	 * @brief 生成$fileName文件的缩略图,位置与$fileName相同
	 * @param string  $fileName 要生成缩略图的目标文件
	 * @param int     $width    缩略图宽度
	 * @param int     $height   缩略图高度
	 * @param string  $extName  缩略图文件名附加值
	 * @param string  $saveDir  缩略图存储目录
	 */
	public static function thumb($fileName,$width,$height,$extName = '_thumb',$saveDir = '')
	{
		return IImage::thumb($fileName,$width,$height,$extName,$saveDir);
	}

	/**
	 * @brief 执行图片上传
	 * @param boolean $isForge 是否伪造数据提交
	 * @return array key:控件名; val:图片路径名;
	 */
	public function run($isForge = false)
	{
		//创建图片模型对象
		$photoObj = new IModel('goods_photo');

		//已经存在的图片文件数据
		$photoArray = array();

		//过滤图库中已经存在的图片
		foreach($_FILES as $key => $val)
		{
			//上传的所有临时文件
			$tmpFile = isset($_FILES[$key]['tmp_name']) ? $_FILES[$key]['tmp_name'] : null;

			//没有找到匹配的控件
			if($tmpFile == null)
				continue;

			if(is_array($tmpFile))
			{
				foreach($tmpFile as $tmpKey => $tmpVal)
				{
					$result = $this->checkIterance($tmpVal,$photoObj);
					if($result != null)
					{
						$photoArray[$key][$tmpKey] = $result;
						unset($_FILES[$key]['name'][$tmpKey]);
						unset($_FILES[$key]['tmp_name'][$tmpKey]);
					}
				}
			}
			else
			{
				$result = $this->checkIterance($tmpFile,$photoObj);
				if($result!=null)
				{
					$photoArray[$key] = $result;
					unset($_FILES[$key]);
				}
			}
		}

		//图片上传
		$upObj = new IUpload();
		$upObj->isForge = $isForge;
		$upObj->setDir($this->dir);
		$upState = $upObj->execute();

		//检查上传状态
		foreach($upState as $key => $rs)
		{
			if(count($_FILES[$key]['name']) > 1)
				$isArray = true;
			else
				$isArray = false;

			foreach($rs as $innerKey => $val)
			{
				if($val['flag']==1)
				{
					//上传成功后图片信息
					$fileName = $val['dir'].$val['name'];
					$fileMD5  = md5_file($fileName);

					$rs[$innerKey]['img'] = $fileName;

					$insertData = array(
						'id'  => $fileMD5,
						'img' => $fileName
					);

					//将图片信息入库
					$this->insert($insertData,$photoObj);

					if($this->thumbWidth && $this->thumbHeight && $this->thumbKey)
					{
						//重新生成系统中不存在的此宽高的缩略图
						foreach($this->thumbKey as $thumbKey_key => $thumbKey_val)
						{
							$thumbExtName = '_'.$this->thumbWidth[$thumbKey_key].'_'.$this->thumbHeight[$thumbKey_key];
							$thumbName    = $this->thumb($fileName,$this->thumbWidth[$thumbKey_key],$this->thumbHeight[$thumbKey_key],$thumbExtName);
							$rs[$innerKey]['thumb'][$this->thumbKey[$thumbKey_key]] = $thumbName;
						}
					}
				}

				if($isArray == true)
				{
					$photoArray[$key] = $rs;
				}
				else
				{
					$photoArray[$key] = $rs[0];
				}
			}
		}
		return $photoArray;
	}
}