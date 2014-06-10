<?php
/**
 * @copyright Copyright(c) 2010 jooyea.cn
 * @file log_inte.php
 * @brief 日志接口文件
 * @author webning
 * @date 2010-12-09
 * @version 0.6
 */
/**
 * @brief ILog接口文件
 * @class ILog interface
 */
interface ILog
{
    /**
     * @brief 实现日志的写操作接口
     * @param array  $logs 日志的内容
     */
    public function write($logs = array());
}
?>