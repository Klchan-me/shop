<?php
/**
 * @brief 采集器抽象类
 * @date 2014/1/1 20:21:11
 * @author chendeshan
 */
abstract class collect
{
	//已经采集到的列表页面html代码
	protected $listPageHtml = '';

	//已经采集到的详情页面html代码
	protected $showPageHtml = '';

	/**
	 * @brief 获取列表页面的html代码
	 * @param $url string 列表页面url地址
	 */
	public function readListPage($url)
	{
		if($this->checkListUrl($url) == false)
		{
			throw new Exception('URL不符合规范');
			exit;
		}

		if(!$content = file_get_contents($url))
		{
			throw new Exception('没有采集到列表页面的html代码');
		}

		//转码GBK转换UTF-8
		$this->listPageHtml = iconv('GBK','UTF-8//IGNORE',$content);
	}

	/**
	 * @brief 获取商品详情页面数据
	 * @param $url string 详情页面url
	 */
	public function readShowPage($url)
	{
		if($this->checkShowUrl($url) == false)
		{
			throw new Exception('URL不符合规范');
			exit;
		}

		$content = file_get_contents($url);

		//转码GBK转换UTF-8
		$this->showPageHtml = iconv('GBK','UTF-8//IGNORE',$content);
	}

	/**
	 * @brief 检查商品列表url的合法性
	 * @param $url string
	 * @return boolean
	 */
	abstract public function checkListUrl($url);

	/**
	 * @brief 检查商品详情url的合法性
	 * @param $url string
	 * @return boolean
	 */
	abstract public function checkShowUrl($url);

	/**
	 * @brief 采集商品信息
	 * @return array
	 */
	abstract public function collect();
}