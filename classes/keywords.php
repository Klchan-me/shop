<?php
/**
 * @copyright (c) 2011 jooyea.cn
 * @file keywords.php
 * @brief 词库管理类
 * @author chendeshan
 * @date 2013/5/9 13:17:33
 * @version 0.6
 */
class keywords
{
	/**
	 * 向词库中添加词
	 * @param $word  string 多个词以','分隔
	 * @param $hot   int    0:否;1:是
	 * @param $order int    排序
	 */
	public static function add($word, $hot = 0, $order = 99)
	{
		$word  = IFilter::act($word);
		$hot   = intval($hot);
		$order = intval($order);

		if($word != '')
		{
			$keywordObj  = new IModel('keyword');
			$wordArray   = explode(',',$word);

			//获取各个关键词的管理商品数量
			$resultCount = self::count($wordArray);

			foreach($wordArray as $word)
			{
				if(IString::getStrLen($word) >= 15)
				{
					continue;
				}
				$is_exists = $keywordObj->getObj('word = "'.$word.'"','hot');
				if(empty($is_exists))
				{
					$dataArray = array(
						'hot'        => $hot,
						'word'       => $word,
						'goods_nums' => $resultCount[$word],
						'order'      => $order,
					);
					$keywordObj->setData($dataArray);
					$keywordObj->add();
				}
			}
			return array('flag'=>true);
		}
		return array('flag'=>false,'data'=>'请填写关键词');
	}

	/*计算关键词所关联的商品数量
	$result = array( 关键词 => 管理商品的数量 );
	*/
	public static function count($word)
	{
		if(empty($word))
		{
			return false;
		}
		else
		{
			if(is_array($word))
			{
				$wordArray  = $word;
			}
			else
			{
				$wordArray  = explode(',',$word);
			}

			$keywordObj = new IModel('keyword');
			$goodsObj   = new IModel('goods');
			$result     = array();

			foreach($wordArray as $val)
			{
				$val_sql = IFilter::act($val);

				$countNum = $goodsObj->getObj('name like "%'.$val_sql.'%" AND is_del=0 ','count(*) as num');
				$result[$val] = $countNum['num'];
			}
			return $result;
		}
	}
}
