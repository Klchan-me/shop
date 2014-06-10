<?php
include(dirname(__FILE__).'/collect.php');
/**
 * @brief 京东商品列表采集器,适用于普通类，不可再分类的列表
 * @author nswe
 * @date 2013/12/25 13:52:19
 */
class jd_collect extends collect
{
	//属性数据
	private $cacheAttrData = array();

	/**
	 * @brief 构造函数
	 */
	public function __construct()
	{
	}

	/**
	 * @brief 检查列表url
	 */
	public function checkListUrl($url)
	{
		return strpos($url,'http://list.jd.com') === false ? false : true;
	}

	/**
	 * @brief 检查详情url
	 */
	public function checkShowUrl($url)
	{
		return strpos($url,'http://item.jd.com') === false ? false : true;
	}

	/**
	 * @brief 挑选分类
	 * @return array 根据层次返回分类
	 */
	public function pickCatFromList()
	{
		$catExp = '|(?=<div class="breadcrumb">).+?(?<=</div>)|s';
		preg_match($catExp,$this->listPageHtml,$match);
		if(!isset($match[0]))
		{
			throw new Exception('页面缺少商品分类');
		}
		return explode('&nbsp;&gt;&nbsp;',trim(strip_tags($match[0])));
	}

	/**
	 * @brief 挑选属性
	 * @return array 属性数据
	 */
	public function pickAttributeFromList()
	{
		$except  = array('价格：','品牌：');//排除不必要的属性
		$attrExp = "@<div class='attr'><div class='a-key'>(.+?)</div><div class='a-values'><div class='v-fold'><ul class='f-list'>(.+?)</ul></div>@";
		preg_match_all($attrExp,$this->listPageHtml,$match);

		//$match[1]:属性名字;$match[2]:属性值
		if(!isset($match[2]) || count($match[1]) != count($match[2]))
		{
			throw new Exception('页面缺少商品属性');
		}

		$attrData = array();
		foreach($match[1] as $key => $val)
		{
			if(!in_array($val,$except))
			{
				$attrData[trim($val,'：')] = trim(strip_tags(strtr($match[2][$key],array('</li>' => '</li>,'))),',');
			}
		}
		return $attrData;
	}

	/**
	 * @brief 挑选列表页面的商品连接
	 * @return array 商品详情的url
	 */
	public function pickGoodsLinkFromList()
	{
		$linkExp = "@<div class='p-img'><a target='_blank'  href='(.+?)'>@";
		preg_match_all($linkExp,$this->listPageHtml,$match);

		if(!isset($match[1]))
		{
			throw new Exception('页面缺少商品详情连接');
		}
		return $match[1];
	}

	/**
	 * @brief 获取商品名称从详情页面
	 * @return string 商品名字
	 */
	public function pickGoodsNameFromShow()
	{
		$exp = '@<h1>.+?</h1>@';
		preg_match($exp,$this->showPageHtml,$match);

		if(!isset($match[0]))
		{
			throw new Exception('没有找到商品名称');
		}
		return strip_tags($match[0]);
	}

	/**
	 * @brief 获取商品价格从API
	 * @param $idArray string 商品id数组,如：J_970602
	 * @return string 商品价格json
	 */
	public function getGoodsPriceFromAPI($idString)
	{
		$apiUrl = 'http://p.3.cn/prices/mgets?skuIds='.trim($idString,',');
		$result = file_get_contents($apiUrl);
		$result = strtr($result,array('J_' => ''));
		return JSON::decode($result);
	}

	/**
	 * @brief 获取商品属性从详情页面
	 * @return string 商品某属性
	 */
	public function pickGoodsAttributeFromShow()
	{
		$exp = '@<ul class="detail-list">(.+?)</ul>@s';
		preg_match($exp,$this->showPageHtml,$match);

		if(!isset($match[1]))
		{
			throw new Exception('没有找到商品属性');
		}

		$match[1] = trim(strip_tags(strtr($match[1],array('<li>' => '</li>,'))));
		$tempArray = explode(',',$match[1]);

		$attrArray = array();
		$tmp = array();
		foreach($tempArray as $key => $val)
		{
			$tmp = explode('：',$val);
			$attrArray[$tmp[0]] = trim($tmp[1]);
		}
		return $this->cacheAttrData = $attrArray;
	}

	/**
	 * @brief 获取商品图片从详情页面
	 * @return array 商品的图片url
	 */
	public function pickGoodsImageFromShow()
	{
		$exp = '@data-url="(.+?)"@';
		preg_match_all($exp,$this->showPageHtml,$match);

		if(!isset($match[1]) || !is_array($match[1]))
		{
			throw new Exception('没有找到商品图片');
		}

		$jdImageServerPre = 'http://img13.360buyimg.com/n0/';
		foreach($match[1] as $key => $val)
		{
			$match[1][$key] = $jdImageServerPre.$val;
		}
		return $match[1];
	}

	/**
	 * @brief 获取商品规格从详情页面
	 * @return array 商品的规格 array(规格名称=>规格值)
	 */
	public function pickGoodsSpecFromShow()
	{
		$exp = '@<li id="choose-(?:version|color)".*?>.*?</li>@s';
		preg_match_all($exp,$this->showPageHtml,$match);

		$result = array();
		if(isset($match[0]) && $match[0])
		{
			foreach($match[0] as $key => $val)
			{
				$val = trim(strip_tags(strtr($val,array('</a>' => '</a>,'))),',');
				$temp = explode('：',$val);

				if(isset($temp[1]))
				{
					$result[$temp[0]] = $temp[1];
				}
			}
		}
		return $result;
	}

	/**
	 * @brief 获取商品详情从详情页面
	 * @return string 商品的详情数据
	 */
	public function pickGoodsContentFromShow()
	{
		$exp = '@<div class="detail-content">.*<!--product-detail end-->@s';
		preg_match($exp,$this->showPageHtml,$match);

		if(!isset($match[0]))
		{
			throw new Exception('没有找到商品详情');
		}
		return strtr($match[0],array('data-lazyload' => 'src'));
	}

	/**
	 * @brief 获取商品重量
	 * @return string 商品重量
	 */
	public function pickGoodsWeightFromShow()
	{
		if(!$this->cacheAttrData)
		{
			$this->pickGoodsAttributeFromShow();
		}
		preg_match('@[\d\.]+@',$this->cacheAttrData['商品毛重'],$matchAttr);
		return isset($matchAttr[0]) ? $matchAttr[0] : 0;
	}

	/**
	 * @brief 获取商品计量单位
	 * @return string 计量单位
	 */
	public function pickGoodsUnitFromShow()
	{
		if(!$this->cacheAttrData)
		{
			$this->pickGoodsAttributeFromShow();
		}
		preg_match('@[\d\.]+(.*)$@',$this->cacheAttrData['商品毛重'],$matchAttr);
		return isset($matchAttr[1]) ? $matchAttr[1] : '千克';
	}

	/**
	 * @brief 开始采集商品
	 * @return array('cat' => '商品分类','attr' => '属性','item' => array(
	 * 'goods_no' => '商品编号','up_time' => '上架时间','weight' => '重量','unit' => '计量单位','name' => '商品名字','price' => '商品价格','img' => array(商品图片),'content' => '商品详情','spec' => '商品规格','attr' => '商品属性'
	 * ))
	 */
	public function collect()
	{
		$result = array(
			'cat' => $this->pickCatFromList(),
			'attr'=> $this->pickAttributeFromList(),
			'item'=> array()
		);

		$goodsUrl = $this->pickGoodsLinkFromList();
		foreach($goodsUrl as $key => $val)
		{
			$this->readShowPage($val);
			preg_match('@\d+@',$val,$match);

			$priceObj = $this->getGoodsPriceFromAPI('J_'.$match[0]);
			$attrData = $this->pickGoodsAttributeFromShow();

			$result['item'][] = array(
				'goods_no' => $attrData['商品编号'],
				'up_time'  => $attrData['上架时间'],
				'weight' => $this->pickGoodsWeightFromShow(),
				'unit'   => $this->pickGoodsUnitFromShow(),
				'name'   => $this->pickGoodsNameFromShow(),
				'price'  => $priceObj[0]['p'],
				'img'    => $this->pickGoodsImageFromShow(),
				'content'=> $this->pickGoodsContentFromShow(),
				'spec'   => $this->pickGoodsSpecFromShow(),
				'attr'   => $attrData
			);
		}
		return $result;
	}
}