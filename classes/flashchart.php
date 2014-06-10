<?php
/**
 * @copyright (c) 2011 jooyea.cn
 * @file FlashChart.php
 * @brief flashÍ¼±ê
 * @author webning
 * @date 2011-6-15 14:58:39
 * @version 0.6
 */
class FlashChart
{
	private $id;
	private $height;
	private $width;
	private $path;
	function __construct($path="",$width=300,$height=500,$id="myChart")
	{
		global $flash_chart;
		$this->id=$id;
		$this->height=$height;
		$this->width=$width;
		$this->path=$path;
		if(!$flash_chart)
		{
			echo '<script type="text/javascript" src="'.$path.'js/json/json2.js"></script>';
			echo '<script type="text/javascript" src="'.$path.'js/swfobject.js"></script>';
			$flash_chart=true;
		}
	}
	function __destruct()
	{
		unset($this->id,$this->height,$this->width,$this->path);
	}
	function setID($id)
	{
		$this->id=$id;
	}
	function setChart($file,$info)
	{
		$tp=new TemplateData($file);
		echo '<script type="text/javascript">';
		echo "data_{$this->id}=".$tp->changeInfo($info).';';
		echo "function ofc_get_dataOf{$this->id}(){return JSON.stringify(data_{$this->id});}";
		echo "swfobject.embedSWF('".$this->path."/open-flash-chart.swf', '$this->id', '$this->width','$this->height','9.0.0','expressInstall.swf',{'get-data':'ofc_get_dataOf{$this->id}'} )";
		echo '</script>';
	}
}
?>