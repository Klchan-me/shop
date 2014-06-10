<?php
/**
 * @copyright (c) 2011 jooyea
 * @file share.php
 * @brief 百度分享插件
 * @author chendeshan
 * @date 2013/7/15 7:33:25
 * @version 1.0.0
 */
class Share
{
	/**
	 * 构造函数
	 */
	function __construct()
	{

	}

	/**
	 * 展示插件
	 */
	function show()
	{
echo <<< OEF
<script type="text/javascript" id="bdshare_js" data="type=slide&amp;img=0&amp;pos=right&amp;uid=0" ></script>
<script type="text/javascript" id="bdshell_js"></script>
<script type="text/javascript">
document.getElementById("bdshell_js").src = "http://bdimg.share.baidu.com/static/js/shell_v2.js?cdnversion=" + Math.ceil(new Date()/3600000);
</script>
OEF;
	}
}