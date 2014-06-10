<?php
/**
 * @copyright (c) 2011 jooyea
 * @file seo.php
 * @brief seo处理
 * @author wula
 * @date 2011-6-15 14:58:39
 * @version 0.6
 */
class seo
{
	/**
	 * 在view里为iwebshop页面调整title、keywords、description
	 * @param array $config array('title'=>'','keywords'=>'','description'=>'')
	 */
	public static function set($config)
	{
		$html = ob_get_clean();
		preg_match("!<head>(.*?)</head>!ius",$html,$m);

		//如果页面本来就没有head头，则直接返回
		if(!isset($m[0]) || $m[0]=="")
			return;

		$head = $m[1];
		if(isset($config['title']))
		{
			$title = "<title>{$config['title']}</title>";
			if(preg_match('!<title>.*?</title>!',$head))
			{
				$head = preg_replace("!<title>.*?</title>!ui",$title,$head,1);
			}
			else
			{
				$head .= "\n".$title;
			}
		}

		if(isset($config['keywords']))
		{
			$keywords = "<meta name='keywords' content='{$config['keywords']}'>";
			if(preg_match("!<meta\s.*?name=['\"]keywords!ui",$head))
			{
				$head = preg_replace("!<meta\s.*?name=['\"]keywords.*?/?>!ui",$keywords,$head,1);
			}
			else
			{
				$head .= "\n".$keywords;
			}
		}

		if(isset($config['description']))
		{
			$description = "<meta name='description' content='{$config['description']}'>";
			if(preg_match("!<meta\s.*?name=['\"]description!ui",$head))
			{
				$head = preg_replace("!<meta\s.*?name=['\"]description.*?/?>!ui",$description,$head,1);
			}
			else
			{
				$head .= "\n".$description;
			}
		}

		$head = "<head>{$head}</head>";
		$html = preg_replace("!<head>(.*?)</head>!ius",$head,$html);
		ob_start();
		echo $html;
	}
}
?>
