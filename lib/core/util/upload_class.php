<?php
/**
 * @copyright (c) 2011 jooyea.cn
 * @file upload_class.php
 * @brief 文件上传处理
 * @author nswe
 * @date 2010-12-06
 * @version 0.6
 */

/**
 * @class IUpload
 * @brief 文件上传类
 */
class IUpload
{
	//允许上传附件类型
	private $allowType = array('jpg','gif','png','zip','rar','docx','doc');

	//需要检测木马的文件类型
	private $checkType = array('jpg','gif','png');

	//附件存放物理目录
	private $dir = 'upload';

	//最大允许文件大小，单位为B(字节)
    private $maxsize;

    //伪造upload提交
    public $isForge = false;

    /**
     * @brief 构造函数
     * @param Int   $size 允许最大上传KB数
     * @param Array $type 允许上传的类型
     */
    function __construct($size = 10000,$type = array())
    {
    	//设置附件上传类型
    	if($type)
    	{
    		$this->allowType = $type;
    	}

    	//设置附件上传最大值
    	$iniMaxSize    = $this->getIniPostMaxSize();
    	$uploadMaxSize = $size << 10;
    	$this->maxsize = ($uploadMaxSize <= $iniMaxSize) ? $uploadMaxSize : $iniMaxSize;
    }
    /**
     * @brief 设置上传文件存放目录
     * @param String $dir 文件存放目录
     * @return object $this	 返回当前对象，以支持连贯操作
     */
    public function setDir($dir)
    {
    	if($dir != '' && !is_dir($dir))
    	{
    		IFile::mkdir($dir);
    	}
    	$dir       = strtr($dir,'\\','/');
    	$this->dir = substr($dir,0,-1)=='/' ? $dir : $dir.'/';
    	return $this;
    }
    /**
     * @brief get php.ini minimum post_max_size and upload_max_filesize
     */
    public static function getMaxSize()
    {
    	return min(ini_get('upload_max_filesize'),ini_get('post_max_size'));
    }
    /**
     * @brief 获取环境POST数据的最大上传值
     * @return int 最大上传的字节数
     */
    private function getIniPostMaxSize()
    {
    	$maxSize = trim(self::getMaxSize());
	    $unit    = strtolower($maxSize{strlen($maxSize)-1});
	    $maxSize = intval($maxSize);
	    $step    = 0;
	    switch($unit)
	    {
	    	//GB单位
	        case 'g':
	        {
	        	$step = 9;
	        }
	        break;

			//MB单位
	        case 'm':
	        {
	        	$step = 6;
	        }
	        break;

			//KB单位
	        case 'k':
	        default:
	        {
	        	$step = 3;
	        }
	        break;
	    }
	    return str_pad($maxSize,strlen($maxSize)+$step,"0");
    }

    /**
     * @brier 设置需要做HEX检查的文件类型
     * @param string|array|boolean $type 需要做HEX检查的文件类型
     * @return object $this 返回当前对象，以支持连贯操作
     */
    public function setCheckFileType($type)
    {
    	if($type === false)
    	{
    		$this->checkType = array();
    	}
    	elseif(is_string($type))
    	{
    		$this->checkType = array($type);
    	}
    	elseif(is_array($type))
    	{
    		$this->checkType = $type;
    	}
    	return $this;
    }
    /**
     * @brief show code message
     * @param sring $code code
     * @return string
     */
    public static function errorMessage($code)
    {
    	$codeMessage = array(
			'-1'=>'上传的文件超出服务器限制',
			'-2'=>'上传的文件超出浏览器限制',
			'-3'=>'上传的文件被部分上传',
			'-4'=>'没有找到上传的文件',
			'-5'=>'上传的文件丢失',
			'-6'=>'上传的临时文件没有正确写入',
			'-7'=>'扩展名不允许上传',
			'-8'=>'上传的文件超出了程序的限制',
			'-9'=>'上传的文件中有木马病毒',
			'1' =>'上传成功'
		);
		return isset($codeMessage[$code]) ? $codeMessage[$code] : '';
    }
    /**
     * @brief  开始执行上传
     * @return array 包含上传成功信息的数组
     *		$file = array(
	 *			 name    如果上传成功，则返回上传后的文件名称，如果失败，则返回客户端名称
	 *			 size    上传附件大小
	 *           fileSrc 上传文件完整路径
	 *			 dir     上传目录
	 *			 ininame 上传图片名
	 *			 flag    -1:上传的文件超出服务器限制; -2:上传的文件超出浏览器限制; -3:上传的文件被部分上传; -4:没有找到上传的文件; -5:上传的文件丢失;
	 *                   -6:上传的临时文件没有正确写入; -7:扩展名不允许上传; -8:上传的文件超出了程序的限制; -9:上传的文件中有木马病毒 ; 1:上传成功;
	 *			 ext     上传附件扩展名
     *		);
     */
    public function execute()
    {
    	//总的文件上传信息
    	$info = array();

        foreach($_FILES as $field => $file)
        {
            $fileInfo = array();

			//不存在上传的文件名
            if(!isset($_FILES[$field]['name']) || $_FILES[$field]['name'] == '')
            {
            	continue;
            }

			//上传控件为数组格式 file[]格式
            if(is_array($_FILES[$field]['name']))
            {
                $keys = array_keys($_FILES[$field]['name']);

                foreach($keys as $key)
                {
                	$fileInfo[$key]['name'] = $_FILES[$field]['name'][$key];

                	//上传出现错误
                	if(isset($_FILES[$field]['error'][$key]) && $_FILES[$field]['error'][$key] != 0)
                	{
                		$fileInfo[$key]['flag'] = 0 - $_FILES[$field]['error'][$key];
                	}
                	else
                	{
	                    //获取扩展名
	                    $fileext = IFile::getFileType($_FILES[$field]['tmp_name'][$key]);
	                    if(is_array($fileext) || $fileext == null)
	                    {
	                        $fileext = IFile::getFileSuffix($_FILES[$field]['name'][$key]);
	                    }

		                //图片木马检测
		                if(in_array($fileext,$this->checkType) && !IFilter::checkHex($_FILES[$field]['tmp_name'][$key]))
		                {
		                	$fileInfo[$key]['flag'] = -9;
		                }
		                else
		                {
							/*开始上传文件*/
		                    //(1)上传类型不符合
		                    if(!in_array($fileext,$this->allowType))
		                    {
		                        $fileInfo[$key]['flag'] = -7;
		                    }

		                    //(2)上传大小不符合
		                    else if($_FILES[$field]['size'][$key] > $this->maxsize)
		                    {
		                        $fileInfo[$key]['flag'] = -8;
		                    }

							//(3)成功情况
		                    else
		                    {
			                    //修改图片状态值
			                    $fileInfo[$key]['name']    = ITime::getDateTime('Ymdhis').mt_rand(100,999).'.'.$fileext;
			                    $fileInfo[$key]['dir']     = $this->dir;
			                    $fileInfo[$key]['size']    = $_FILES[$field]['size'][$key];
			                    $fileInfo[$key]['ininame'] = $_FILES[$field]['name'][$key];
			                    $fileInfo[$key]['ext']     = $fileext;
			                    $fileInfo[$key]['fileSrc'] = $fileInfo[$key]['dir'].$fileInfo[$key]['name'];
			                    $fileInfo[$key]['flag']    = 1;

			                    if($this->isForge == false)
			                    {
				                    if(is_uploaded_file($_FILES[$field]['tmp_name'][$key]))
				                    {
				                    	IFile::mkdir($this->dir);
				                    	move_uploaded_file($_FILES[$field]['tmp_name'][$key],$this->dir.$fileInfo[$key]['name']);
				                    }
			                    }
			                    else
			                    {
			                    	IFile::xcopy($_FILES[$field]['tmp_name'][$key],$this->dir.$fileInfo[$key]['name']);
			                    }
		                    }
		                }
                	}
                }
            }
            else
            {
            	$fileInfo[0]['name'] = $_FILES[$field]['name'];

            	//上传出现错误
            	if(isset($_FILES[$field]['error']) && $_FILES[$field]['error'] != 0)
            	{
            		$fileInfo[0]['flag'] = 0 - $_FILES[$field]['error'];
            	}
            	else
            	{
	                //获取扩展名
	                $fileext = IFile::getFileType($_FILES[$field]['tmp_name']);
	                if(is_array($fileext) || $fileext == null)
	                {
	                    $fileext = IFile::getFileSuffix($_FILES[$field]['name']);
	                }

                	//图片木马检测
                	if(in_array($fileext,$this->checkType) && !IFilter::checkHex($_FILES[$field]['tmp_name']))
                	{
                  	  	$fileInfo[0]['flag'] = -9;
                	}
                	else
                	{
		                /*开始上传文件*/
		                //(1)上传类型不符合
		                if(!in_array($fileext,$this->allowType))
		                {
		                    $fileInfo[0]['flag'] = -7;
		                }

		                //(2)上传大小不符合
		                else if($_FILES[$field]['size'] > $this->maxsize)
		                {
		                    $fileInfo[0]['flag'] = -8;
		                }

						//(3)成功情况
		                else
		                {
			                //修改图片状态值
			                $fileInfo[0]['name']    = ITime::getDateTime('Ymdhis').mt_rand(100,999).'.'.$fileext;
			                $fileInfo[0]['dir']     = $this->dir;
			                $fileInfo[0]['size']    = $_FILES[$field]['size'];
			                $fileInfo[0]['ininame'] = $_FILES[$field]['name'];
			                $fileInfo[0]['ext']     = $fileext;
			                $fileInfo[0]['fileSrc'] = $fileInfo[0]['dir'].$fileInfo[0]['name'];
			                $fileInfo[0]['flag']    = 1;

							if($this->isForge == false)
							{
			                    if(is_uploaded_file($_FILES[$field]['tmp_name']))
			                    {
			                    	IFile::mkdir($this->dir);
			                    	move_uploaded_file($_FILES[$field]['tmp_name'],$this->dir.$fileInfo[0]['name']);
			                    }
							}
							else
							{
								IFile::xcopy($_FILES[$field]['tmp_name'],$this->dir.$fileInfo[0]['name']);
							}
		                }
                	}
            	}
            }
            $info[$field] = $fileInfo;
        }
        return $info;
    }
}