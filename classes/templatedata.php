<?php
/**
 * @copyright (c) 2011 jooyea.cn
 * @file TemplateData.php
 * @brief flash图标的模板数据处理类
 * @author webning
 * @date 2011-6-15 14:58:39
 * @version 0.6
 */
class TemplateData
{
	public $substitution;
	private $templateFile;
	function __construct($filename)
	{
		$this->templateFile=@file_get_contents($filename) or die("not find templateFile");
	}
	function __destruct() {
		unset ($this->templateFile,$this->substitution);
	}
	function setTemplateFile($tfile)
	{
		$this->templateFile=$tfile;
	}
	function getTemplateFile()
	{
		return $this->templateFile;
	}
	 function replaceReal($matches)
	{
		extract($this->substitution, EXTR_OVERWRITE);
		return isset($$matches[1])?$$matches[1]:$matches[1];
	}
	function changeInfo($subs)
	{
		$this->substitution=$subs;
		return preg_replace_callback("(\((\w+)\))",array(&$this, 'replaceReal'),$this->getTemplateFile());
	}
}
?>