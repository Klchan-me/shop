<?php
/**
 * @copyright Copyright(c) 2010 jooyea.cn
 * @file
 * @brief 系统统验证类文件
 * @author webning
 * @date 2010-12-02
 * @version 0.6
 * @note
 */
/**
 * @brief 系统统验证类文件
 * @class IValidate
 */
class IValidate
{		
    /**
     * @brief Email格式验证
     * @param string $str 需要验证的字符串
     * @return bool 验证通过返回 true 不通过返回 false
     */
    public static function email($str='')
    {
        return (bool)preg_match('/^\w+([-+.]\w+)*@\w+([-.]\w+)+$/i',$str);
    }
    /**
     * @brief QQ号码验证
     * @param string $str 需要验证的字符串
     * @return bool 验证通过返回 true 不通过返回 false
     */
    public static function qq($str='')
    {
        return (bool)preg_match('/^[1-9][0-9]{4,}$/i',$str);
    }
    /**
     * @brief 身份证验证包括一二代身份证
     * @param string $str 需要验证的字符串
     * @return bool 验证通过返回 true 不通过返回 false
     */
    public static function id($str='')
    {
        return (bool)preg_match('/^\d{15}(\d{2}[0-9x])?$/i',$str);
    }
    /**
     * @brief 此IP验证只是对IPV4进行验证。
     * @param string $str 需要验证的字符串
     * @return bool 验证通过返回 true 不通过返回 false
     * @note IPV6暂时不支持。
     */
    public static function ip($str='')
    {
        return (bool)preg_match('/^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$/i',$str);
    }
    /**
     * @brief 邮政编码验证
     * @param string $str 需要验证的字符串
     * @return bool 验证通过返回 true 不通过返回 false
     * @note 此邮编验证只适合中国
     */
    public static function zip($str='')
    {
        return (bool)preg_match('/^\d{6}$/i',$str);
    }
    /**
     * @brief 验证字符串的长度，和数值的大小。$str 为字符串时，判定长度是否在给定的$min到$max之间的长度，为数值时，判定数值是否在给定的区间内。
     * @param mixed $str 要验证的内容
     * @param int $min 最小值或最小长度
     * @param int $max 最大值或最大长度
     * @return bool 验证通过返回 true 不通过返回 false
     */
    public static function len($str, $min, $max)
    {
        if(is_int($str)) return $str >= $min && $str <= $max;
        if(is_string($str))return IString::getStrLen($str) >= $min && IString::getStrLen($str) <= $max;
        return false;
    }
    /**
     * @brief 电话号码验证
     * @param string $str 需要验证的字符串
     * @return  bool 验证通过返回 true 不通过返回 false
     */
    public static function phone($str='')
    {
        return (bool)preg_match('/^((\d{3,4})|\d{3,4}-)?\d{7,8}(-\d+)*$/i',$str);
    }
    /**
     * @brief 手机号码验证
     * @param string $str
     * @return  bool 验证通过返回 true 不通过返回 false
     */
    public static function mobi($str='')
    {
		return (bool)preg_match("!^[0-9]{1,20}$!",$str);
    }
    /**
     * @brief 匹配帐号是否合法(字母开头，默认允许4-16字节【有效位数可自由定制】，允许字母数字下划线)
     * @param string $str 帐号字符串
     * @param int $minlen 最小长度，默认是4。
     * @param int $maxlen 最大长度，默认是16。
     * @return bool 验证通过返回 true 不通过返回 false
     */
    public static function account($str, $minlen=4, $maxlen=16)
    {
        return (bool)preg_match('/^[a-zA-Z][a-zA-Z0-9_]{'.$minlen.','.$maxlen.'}$/i',$str);
    }
    /**
     * @brief Url地址验证
     * @param string $str 要检测的Url地址字符串
     * @return bool 验证通过返回 true 不通过返回 false
     */
    public static function url($str='')
    {
        return (bool)preg_match('/^[a-zA-z]+:\/\/(\w+(-\w+)*)(\.(\w+(-\w+)*))+(\/?\S*)?$/i',$str);
    }
    /**
     * @brief 正则验证接口
     * @param mixed $reg 正则表达式
     * @param string $str 需要验证的字符串
     * @return bool 验证通过返回 true 不通过返回 false
     */
    public static function check($reg, $str='')
    {
        return (bool)preg_match('/^'.$reg.'$/i',$str);
    }
	/**
     * @brief 判断字符串是否为空
     * @param string $str 需要验证的字符串
     * @return bool 验证通过返回 true 不通过返回 false
     */
    public static function required($str)
    {
         return (bool)preg_match('/\S+/i',$str);
    }
}
?>
