<?php
/**
 * @copyright (c) 2011 jooyea.cn
 * @file ad.php
 * @brief 关于广告管理
 * @author chendeshan
 * @date 2011-02-14
 * @version 0.6
 */

 /**
 * @class article
 * @brief 广告管理模块
 */
class Ad
{
	public static function showType($type)
	{
		switch($type)
		{
			case "1":
			$str = '图片';
			break;

			case "2":
			$str = 'flash';
			break;

			case "3":
			$str = '文字';
			break;

			case "4":
			$str = '代码';
			break;

			case "5":
			$str = '幻灯片';
			break;
		}
		return $str;
	}
}
?>
