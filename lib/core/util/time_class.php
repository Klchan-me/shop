<?php
/**
 * @copyright (c) 2011 jooyea.cn
 * @file time_class.php
 * @brief 时间处理
 * @author RogueWolf
 * @date 2010-12-02
 * @version 0.6
 */

/**
 * @class ITime
 * @brief ITime 时间处理类
 * @note
 */
class ITime
{
	/**
	 * @brief 获取当前时间
	 * @param String  $format  返回的时间格式，默认返回当前时间的时间戳
	 * @return String $time    时间
	 */
	public static function getNow($format='')
	{
		if($format)
		{
			return self::getDateTime($format);
		}
		return self::getTime();
	}

	/**
	 * @brief  根据指定的格式输出时间
	 * @param  String  $format 格式为年-月-日 时:分：秒,如‘Y-m-d H:i:s’
	 * @param  String  $time   输入的时间
	 * @return String  $time   时间
	 */
	public static function getDateTime($format='',$time='')
	{
		$time   = $time   ? $time   : time();
		$format = $format ? $format : 'Y-m-d H:i:s';
		return date($format,$time);
	}

	/**
	 * @brief  根据输入的时间返回时间戳
	 * @param  $time String 输入的时间，格式为年-月-日 时:分：秒,如2010-01-01 00:00:00
	 * @return $time Int 指定时间的时间戳
	 */
	public static function getTime($time='')
	{
		if($time)
		{
			return strtotime($time);
		}
		return time();
	}

	/**
	 * @brief 获取第一个时间与第二个时间之间相差的秒数
	 * @param $first_time  String 第一个时间 格式为英文时间格式，如2010-01-01 00:00:00
	 * @param $second_time String 第二个时间 格式为英文时间格式，如2010-01-01 00:00:00
	 * @return $difference Int 时间差，单位是秒
	 * @note  如果第一个时间早于第二个时间，则会返回负数
	 */
	public static function getDiffSec($first_time,$second_time='')
	{
		$second_time = $second_time ? $second_time : self::getDateTime();
		$difference  = strtotime($first_time) - strtotime($second_time);
		return $difference;
	}
}
?>
