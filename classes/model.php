<?php
/**
 * @copyright Copyright(c) 2011 jooyea.cn
 * @file model.php
 * @brief 模型表业务处理
 * @author kane
 * @date 2011-01-12
 * @version 0.6
 * @note
 */
/**
 * @brief Model
 * @class Model
 * @note
 */
class Model
{
	/**
	 * @brief 商品模型添加/修改
	 * @param string $model_id 		模型编号
	 * @param string $model_name 	模型名字
	 * @param array $attribute 		表字段 数组格式,如Array ([name] 	=> Array ( [0] => '' )
	 *														[show_type] => Array ( [0] => '' )
	 *														[value] 	=> Array ( [0] => '' )
	 *														[is_seach] 	=> Array ( [0] => 1 ))
	 * @param array $spec 			表字段 数组格式,如Array ([id] 	=> Array ( [0] => '' ))
	 * @return bool bool:true成功；false失败
	 */
    public function model_update($model_id,$model_name,$attribute,$spec)
    {
    	//初始化model商品模型表类对象
		$modelObj = new IModel('model');
		//设置更新字段数据
		$model_name = IFilter::act($model_name);
		$modelObj->setData(array('name' => $model_name));

		if($model_id)
		{
			$model_id = intval($model_id);
			//更新商品模型数据
			$modelObj->update("id = ".$model_id);
		}
		else
		{
			//添加新商品模型
			$model_id = $modelObj->add();
		}
		if($model_id)
		{
			//新增、更新模型扩展属性
			$this->_attribute_update($attribute,$model_id);
			//新增、更新模型规格
			$model_spec = array();
			$spec_len = count($spec['id']);
			for($i = 0;$i < $spec_len;$i++)
			{
				$model_spec[] = $spec['id'][$i];
			}
			//序列化商品模型规格数据
			$modelObj->setData(array('spec_ids'=>join(',',$model_spec)));
			//更新商品模型规格
			$modelObj->update("id=$model_id");
			return true;
		}
		else
		{
			return false;
		}
    }

	/**
	 * @brief 商品属性添加/修改
	 * @param array $attribute 表字段 数组格式,如Array ([name] 		=> Array ( [0] => '' )
	 *													[show_type] => Array ( [0] => '' )
	 *													[value] 	=> Array ( [0] => '' )
	 *													[is_seach] 	=> Array ( [0] => 1 ))
	 * @param int $model_id 模型编号
	 */
    public function _attribute_update($attribute,$model_id)
    {
    	//初始化attribute商品模型属性表类对象
		$attributeObj = new IModel('attribute');
		$len = count($attribute['name']);
		$ids = "";
	    for( $i = 0;$i< $len;$i++)
		{
			if(IValidate::required($attribute['name'][$i]) && IValidate::required($attribute['value'][$i]))
			{
				$options = str_replace('，',',',$attribute['value'][$i]);
				$type = isset($attribute['is_search'][$i])? $attribute['is_search'][$i] : 0;
				//设置商品模型扩展属性 字段赋值

				$filedData = array(
							"model_id" 	=> intval($model_id),
							"type" 		=> IFilter::act($attribute['show_type'][$i]),
							"name" 		=> IFilter::act($attribute['name'][$i]),
							"value" 	=> rtrim(IFilter::act($options),','),
							"search" 	=> IFilter::act($type)
				);
				$attributeObj->setData($filedData);
				$id = intval($attribute['id'][$i]);
				if($id)
				{
					//更新商品模型扩展属性
					$attributeObj->update("id = ".$id);
				}
				else
				{
					//新增商品模型扩展属性
					$id = $attributeObj->add();
				}
				$ids .= $id.',';
			}
		}

		if($ids)
		{
			$ids = trim($ids,',');

			//删除商品模型扩展属性
			$where = "model_id = $model_id  and id not in (".$ids.") ";
			$attributeObj->del($where);
		}
    }

/**
	 * @brief 将$attribute、$spec的POST数组转换成正常数组
	 * @param array $attribute 表字段 数组格式,如Array ([name] 		=> Array ( [0] => '' )
	 *													[show_type] => Array ( [0] => '' )
	 *													[value] 	=> Array ( [0] => '' )
	 *													[is_seach] 	=> Array ( [0] => 1 ))
	 * @param array $spec 		表字段 数组格式,如Array ([id] 	=> Array ( [0] => '' ))
	 * @return array
	 */
    public function postArrayChange($attribute,$spec)
    {
    	$len = count($attribute['name']);
    	$model_attr = array();
		for( $i = 0;$i< $len;$i++)
		{
			$model_attr[$i]['id'] = $attribute['id'][$i];
			$model_attr[$i]['name'] = $attribute['name'][$i];
			$model_attr[$i]['type'] = $attribute['show_type'][$i];
			$model_attr[$i]['value'] = $attribute['value'][$i];
			$model_attr[$i]['search'] = $attribute['is_search'][$i];
		}
		$spec_len = count($spec['name']);
		$model_spec = array();
    	for( $i = 0;$i< $len;$i++)
		{
			$model_spec[$i]['id'] = $spec['id'][$i];
		}
		return array('model_attr'=>$model_attr,'model_spec'=>$model_spec);
    }

	/**
	 * @brief 根据模型编号  获取模型详细信息
	 *
	 * @param int $model_id 模型编号
	 *
	 * @return array 数组格式 	Array ( [id] => '',[name] => '', [model_attr] => Array ( ),[model_spec] => Array ( ))
	 */
    public function get_model_info($model_id)
    {
    	$model_id = intval($model_id);
    	//初始化model商品模型表类对象
		$modelObj = new IModel('model');
		//根据模型编号  获取商品模型详细信息
		$model_info = $modelObj->getObj('id = '.$model_id);
		if($model_info)
		{
			//反序列化 商品模型规格数据
			$model_info['model_spec'] = array();
			if($model_info['spec_ids'])
			{
				$specDB = new IModel('spec');
				$model_info['model_spec'] = $specDB->query("id in (".$model_info['spec_ids'].")");
			}

			//初始化attribute商品模型属性表类对象
			$attributeObj = new IModel('attribute');
			//根据商品模型编号 获取商品模型扩展属性
			$model_attr = $attributeObj->query("model_id = ".$model_id);
			$model_info['model_attr'] = $model_attr;
		}
		return $model_info;
    }
}
?>
