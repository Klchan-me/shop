<?php
/**
 * @copyright (c) 2011 jooyea.cn
 * @file image_class.php
 * @brief 图片处理类库
 * @author chendeshan
 * @date 2011-03-18
 * @version 0.6
 */

/**
 * @class IImage
 * @brief IImage 图片处理类
 */
class IImage
{
	/**
	 * @brief 构造函数
	 * @param string $fileName 要处理的图片文件名称
	 */
	function __construct($fileName)
	{

	}

	/**
	 * @brief 创建图片资源句柄
	 * @param string $fileName 图片文件名称
	 * @return resource 图片资源句柄; null:无匹配类型
	 */
	public static function createImageResource($fileName)
	{
		$imageRes = null;

		//获取文件扩展名
		$fileExt  = IFile::getFileSuffix($fileName);

	    switch($fileExt)
	    {
	        case 'jpg' :
	        case 'jpeg':
	        {
	        	$imageRes = imagecreatefromjpeg($fileName);
	        }
	        break;

	        case 'gif' :
	        {
	        	$imageRes = imagecreatefromgif($fileName);
	        }
	        break;

	        case 'png' :
	        {
	        	$imageRes = imagecreatefrompng($fileName);
	        }
	        break;

	        case 'bmp' :
	        {
				$imageRes = imagecreatefromwbmp($fileName);
	        }
	        break;
	    }
	    return $imageRes;
	}

	/**
	 * @brief 生成图片文件
	 * @param resource $imageRes      图片资源名称
	 * @param string   $thumbFileName 缩略图名称
	 * @param bool     $imageResult   生成缩略图状态 true:成功; false:失败;
	 */
	public static function createImageFile($imageRes,$thumbFileName)
	{
		//如果目录不可写直接返回，防止错误抛出
		if(!is_writeable(dirname($thumbFileName)))
		{
			return false;
		}

		$imageResult = false;
		//获取文件扩展名
		$fileExt  = IFile::getFileSuffix($thumbFileName);

	    switch($fileExt)
	    {
	        case 'jpg' :
	        case 'jpeg':
	        {
	        	$imageResult = imagejpeg($imageRes,$thumbFileName,100);
	        }
	        break;

	        case 'gif' :
	        {
	        	$imageResult = imagegif($imageRes,$thumbFileName);
	        }
	        break;

	        case 'png' :
	        {
	        	$imageResult = imagepng($imageRes,$thumbFileName);
	        }
	        break;

	        case 'bmp' :
	        {
				$imageResult = imagewbmp($imageRes,$thumbFileName);
	        }
	        break;
	    }
	    return $imageResult;
	}

	/**
	 * @brief 生成缩略图
	 * @param string  $fileName 生成缩略图的目标文件名
	 * @param int     $width    缩略图的宽度
	 * @param int     $height   缩略图的高度
	 * @param string  $extName  缩略图文件名附加值
	 * @param string  $saveDir  缩略图存储目录
	 * @return string 缩略图文件名
	 */
	public static function thumb($fileName, $width = 200, $height = 200 ,$extName = '_thumb' ,$saveDir = '')
	{
		if(is_file($fileName))
		{
			//获取原图信息
			list($imgWidth,$imgHeight) = getImageSize($fileName);

			//计算宽高比例,获取缩略图的宽度和高度
		    if($imgWidth >= $imgHeight)
		    {
		    	$thumbWidth  = $width;
		    	$thumbHeight = ($width / $imgWidth) * $imgHeight;
		    }
		    else
		    {
		    	$thumbWidth  = ($height / $imgHeight) * $imgWidth;
		        $thumbHeight = $height;
		    }

			//生成$fileName文件图片资源
		    $thumbRes = self::createImageResource($fileName);
	        $thumbBox = imageCreateTrueColor($width,$height);

	        //填充补白
			$padColor = imagecolorallocate($thumbBox,255,255,255);
        	imagefilledrectangle($thumbBox,0,0,$width,$height,$padColor);

			//拷贝图像
	        imagecopyresampled($thumbBox, $thumbRes, ($width-$thumbWidth)/2, ($height-$thumbHeight)/2, 0, 0, $thumbWidth, $thumbHeight, $imgWidth, $imgHeight);

	        //生成缩略图文件名
	        $fileExt       = IFile::getFileSuffix($fileName);
	        $thumbFileName = str_replace('.'.$fileExt,$extName.'.'.$fileExt,$fileName);

			//切换目录
	        if($saveDir && IFile::mkdir($saveDir))
	        {
	        	$thumbFileName = $saveDir.'/'.basename($thumbFileName);
	        }

			//生成图片文件
	        $result = self::createImageFile($thumbBox,$thumbFileName);
	        if($result == true)
	        {
	        	return $thumbFileName;
	        }
	        else
	        {
	        	return null;
	        }
		}
		else
		{
			return null;
		}
	}
}