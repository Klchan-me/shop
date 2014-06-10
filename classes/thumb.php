<?php
/**
 * @brief 动态生成缩略图类
 */
class Thumb
{
	/**
	 * @brief 生成缩略图
	 * @param string $image_url 图片路径
	 * @param int $width 图片宽度
	 * @param int $height 图片高度
	 */
    public static function get($image_url,$width=100,$height=100)
    {
    	if($image_url == '')
    	{
    		return '';
    	}

        $fileExt       = IFile::getFileSuffix($image_url);
        $extName       = "_{$width}_{$height}";
        $thumbFileName = str_replace('.'.$fileExt,$extName.'.'.$fileExt,$image_url);

        if(is_file(IWeb::$app->getRuntimePath().$thumbFileName) == false)
        {
        	PhotoUpload::thumb($image_url,$width,$height,"_{$width}_{$height}",IWeb::$app->getRuntimePath().dirname($image_url));
        }
        return 'runtime/'.IWeb::$app->controller->theme.'/'.$thumbFileName;
    }
}