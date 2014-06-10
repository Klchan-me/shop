<?php
/**
 * @brief 商品模块
 * @class Goods
 * @note  后台
 */
class Goods extends IController
{
	public $checkRight  = 'all';
    public $layout = 'admin';
    private $data = array();

	public function init()
	{
		if(IReq::get('action') == 'goods_img_upload')
		{
			$admin_name = IFilter::act(IReq::get('admin_name'));
			$admin_pwd  = IFilter::act(IReq::get('admin_pwd'));

			$adminObj = new IModel('admin');
			$adminRow = $adminObj->getObj("admin_name = '".$admin_name."'",'password');
			if(empty($adminRow) || ($adminRow['password'] != $admin_pwd))
			{
				exit;
			}
		}
		else
		{
			IInterceptor::reg('CheckRights@onCreateAction');
		}
	}
	/**
	 * 选择规格数据
	 */
	function select_spec()
	{
		$this->layout = '';
		$this->redirect('select_spec');
	}
	/**
	 * @brief 商品添加中图片上传的方法
	 */
	public function goods_img_upload()
	{
		//获得配置文件中的数据
		$config = new Config("site_config");

	 	//调用文件上传类
		$photoObj = new PhotoUpload();
		$photo    = current($photoObj->run());

		//判断上传是否成功，如果float=1则成功
		if($photo['flag'] == 1)
		{
			$result = array(
				'flag'=> 1,
				'img' => $photo['img']
			);
		}
		else
		{
			$result = array('flag'=> $photo['flag']);
		}
		echo JSON::encode($result);
	}
    /**
	 * @brief 商品模型添加/修改
	 */
    public function model_update()
    {
    	// 获取POST数据
    	$attribute = IReq::get("attr");
    	$spec = IReq::get("spec");
    	$model_name = IReq::get("model_name");
    	$model_id = IReq::get("model_id");

    	//初始化Model类对象
		$modelObj = new Model();

    	//校验数据
    	if(!IValidate::required($model_name))
    	{
    		//处理post数据，渲染到前台
    		$result = $modelObj->postArrayChange($attribute,$spec);
			$this->data = array(
				'id'=>$model_id,
				'name'=>$model_name,
				'model_attr'=>$result['model_attr'],
				'model_spec'=>$result['model_spec']
			);
    		$this->setRenderData($this->data);
			$this->redirect('model_edit',false);
			Util::showMessage('模型名称不能为空！');
			exit();
    	}

		//更新模型数据
		$result = $modelObj->model_update($model_id,$model_name,$attribute,$spec);
		if($result)
		{
			$this->redirect('model_list');
		}
		else
		{
			//处理post数据，渲染到前台
    		$result = $modelObj->postArrayChange($attribute,$spec);
			$this->data = array(
				'id'=>$model_id,
				'name'=>$model_name,
				'model_attr'=>$result['model_attr'],
				'model_spec'=>$result['model_spec']
			);
    		$this->setRenderData($this->data);
			$this->redirect('model_edit',false);
		}
    }

	/**
	 * @brief 商品模型修改
	 */
    public function model_edit()
    {
    	// 获取POST数据
    	$id = intval(IReq::get("id"));
    	if($id)
    	{
    		//初始化Model类对象
    		$modelObj = new Model();
    		//获取模型详细信息
			$model_info = $modelObj->get_model_info($id);
			//向前台渲染数据
			$this->setRenderData($model_info);
    	}
		$this->redirect('model_edit');
    }

	/**
	 * @brief 商品模型删除
	 */
    public function model_del()
    {
    	// 获取POST数据
    	$model_id = IReq::get("id");
    	$ids = IReq::get("model_id");

    	if($model_id)
    	{
    		$ids = array($model_id);
    	}
    	if($ids)
    	{
	    	foreach($ids as $id)
	    	{
		    	if($id)
		    	{
		    		//初始化goods_attribute表类对象
		    		$goods_attrObj = new IModel("goods_attribute");
		    		//获取商品属性表中的该模型下的数量
		    		$num = $goods_attrObj->query(" model_id = ".$id);
		    		if($num)
		    		{
		    			$this->redirect('model_list',false);
		    			Util::showMessage("无法删除此模型，请确认该模型下以及回收站内都无商品");
		    			exit;
		    		}
		    		//初始化Model表类对象
		    		$modelObj = new IModel("model");
		    		//删除商品模型
					$result = $modelObj->del(" id = ".$id);
					//初始化Model表类对象
		    		$attributeObj = new IModel("attribute");
		    		//删除商品模型属性
					$attributeObj->del(" model_id = ".$id);
		    	}
	    	}
    	}
		$this->redirect('model_list',false);
    }

	/**
	 * @brief 商品添加和修改视图
	 */
	function goods_edit()
	{
		$goods_id = IFilter::act(IReq::get('id'),'int');

		//初始化数据
		$goods_class = new goods_class();
		$tb_category = new IModel('category');
		$this->category = $goods_class->sortdata($tb_category->query(false,'*','sort','asc'),0,'--');
		$data = array();

		if($goods_id)
		{
			//获取商品
			$obj_goods = new IModel('goods');
			$goods_info = $obj_goods->getObj('id='.$goods_id);

			//读取到记录
			if($goods_info)
			{
				$data = $goods_class->edit($goods_info);

				//获取货品
				$productObj = new IModel('products');
				$product_info = $productObj->query('goods_id = '.$goods_id);
				if($product_info)
				{
					//获取货品会员价格
					$groupPriceDB = new IModel('group_price');
					foreach($product_info as $k => $rs)
					{
						$temp = array();
						$productPrice = $groupPriceDB->query('product_id = '.$rs['id']);
						foreach($productPrice as $key => $val)
						{
							$temp[$val['group_id']] = $val['price'];
						}
						$product_info[$k]['groupPrice'] = $temp ? JSON::encode($temp) : '';
					}
					$data['product'] = $product_info;
				}
			}
			else
			{
				$this->goods_list();
				Util::showMessage("没有找到相关商品！");
				exit;
			}
		}
		$this->setRenderData($data);
		$this->redirect('goods_edit');
	}

	/*
	 * @breif ajax添加商品扩展属性
	 * */
	function attribute_init()
	{
		$id = IFilter::act(IReq::get('model_id'),'int');
		$tb_attribute = new IModel('attribute');
		$attribute_info = $tb_attribute->query('model_id='.$id);
		echo JSON::encode($attribute_info);
	}
	/*
	 * @breif 后台添加给商品规格
	 * */
	function search_spec()
	{
		$this->layout = '';
		$data = array();

		//获得model_id的值
		$model_id = IFilter::act(IReq::get('model_id'),'int');
		$goods_id = IFilter::act(IReq::get('goods_id'),'int');
		$specId   = '';

		if($goods_id)
		{
			$tb_goods = new IModel('goods');
			$goods_info = $tb_goods->getObj('id = '.$goods_id,'spec_array');
			$data['goodsSpec'] = JSON::decode($goods_info['spec_array']);
			if($data['goodsSpec'])
			{
				foreach($data['goodsSpec'] as $item)
				{
					$specId .= $item['id'].',';
				}
			}
		}
		else if($model_id)
		{
			$modelObj  = new IModel('model');
			$modelInfo = $modelObj->getObj('id = '.$model_id,'spec_ids');
			$specId    = $modelInfo['spec_ids'] ? $modelInfo['spec_ids'] : '';
		}

		if($specId)
		{
			$specObj = new IModel('spec');
			$data['specData'] = $specObj->query('id in ('.trim($specId,',').')');
		}

		$this->setRenderData($data);
		$this->redirect("search_spec");
	}
	/**
	 * @breif 后台添加为每一件商品添加会员价
	 * */
	function member_price()
	{
		$this->layout = '';

		$goods_id   = IFilter::act(IReq::get('goods_id'),'int');
		$product_id = IFilter::act(IReq::get('product_id'),'int');
		$sell_price = IFilter::act(IReq::get('sell_price'),'float');

		$date = array(
			'sell_price' => $sell_price
		);

		if($goods_id)
		{
			$where  = 'goods_id = '.$goods_id;
			$where .= $product_id ? ' and product_id = '.$product_id : '';

			$priceRelationObject = new IModel('group_price');
			$priceData = $priceRelationObject->query($where);
			$date['price_relation'] = $priceData;
		}

		$this->setRenderData($date);
		$this->redirect('member_price');
	}
	/**
	 * @brief 保存修改商品信息
	 */
	function goods_update()
	{
		$id       = IFilter::act(IReq::get('id'),'int');
		$callback = IFilter::act(IReq::get('callback'),'url');
		$callback = strpos($callback,'goods/goods_list') === false ? '' : $callback;
		$postData = array();
		$nowDataTime = date('Y-m-d H:i:s');

		//检查表单提交状态
		if(!$_POST)
		{
			die('请确认表单提交正确');
		}

		//初始化商品数据
		unset($_POST['id']);
		unset($_POST['callback']);
		foreach($_POST as $key => $val)
		{
			$postData[$key] = $val;

			//数据过滤分组
			if(strpos($key,'attr_id_') !== false)
			{
				$goodsAttrData[ltrim($key,'attr_id_')] = IFilter::act($val);
			}
			else if($key[0] != '_')
			{
				$goodsUpdateData[$key] = IFilter::act($val,'text');
			}
		}

		if(isset($goodsUpdateData['is_del']))
		{
			$goodsUpdateData['is_del'] == 2 ? ($goodsUpdateData['down_time'] = $nowDataTime) : ($goodsUpdateData['up_time'] = $nowDataTime);
		}

		//是否存在货品
		$goodsUpdateData['spec_array'] = '';
		if(isset($postData['_spec_array']))
		{
			//生成goods中的spec_array字段数据
			$goods_spec_array = array();
			foreach($postData['_spec_array'] as $key => $val)
			{
				foreach($val as $v)
				{
					$tempSpec = JSON::decode($v);
					if(!isset($goods_spec_array[$tempSpec['id']]))
					{
						$goods_spec_array[$tempSpec['id']] = array('id' => $tempSpec['id'],'name' => $tempSpec['name'],'type' => $tempSpec['type'],'value' => array());
					}
					$goods_spec_array[$tempSpec['id']]['value'][] = $tempSpec['value'];
				}
			}
			foreach($goods_spec_array as $key => $val)
			{
				$val['value'] = array_unique($val['value']);
				$goods_spec_array[$key]['value'] = join(',',$val['value']);
			}
			$goodsUpdateData['spec_array'] = JSON::encode($goods_spec_array);
		}

		$goodsUpdateData['goods_no']     = preg_replace("/(?:\-\d*)$/","",current($postData['_goods_no']));
		$goodsUpdateData['store_nums']   = array_sum($postData['_store_nums']);
		$goodsUpdateData['market_price'] = isset($postData['_market_price']) ? current($postData['_market_price']) : 0;
		$goodsUpdateData['sell_price']   = isset($postData['_sell_price'])   ? current($postData['_sell_price'])   : 0;
		$goodsUpdateData['cost_price']   = isset($postData['_cost_price'])   ? current($postData['_cost_price'])   : 0;
		$goodsUpdateData['weight']       = isset($postData['_weight'])       ? current($postData['_weight'])       : 0;

		//处理商品
		$goodsDB = new IModel('goods');
		if($id)
		{
			$goodsDB->setData($goodsUpdateData);
			$goodsDB->update('id = '.$id);
		}
		else
		{
			$goodsUpdateData['create_time'] = $nowDataTime;
			$goodsDB->setData($goodsUpdateData);
			$id = $goodsDB->add();
		}

		//处理商品属性和规格
		$goodsAttrDB = new IModel('goods_attribute');
		$goodsAttrDB->del('goods_id = '.$id);
		if(isset($goodsAttrData) && $goodsAttrData)
		{
			foreach($goodsAttrData as $key => $val)
			{
				$attrData = array(
					'goods_id' => $id,
					'model_id' => $goodsUpdateData['model_id'],
					'attribute_id' => $key,
					'attribute_value' => is_array($val) ? join(',',$val) : $val
				);
				$goodsAttrDB->setData($attrData);
				$goodsAttrDB->add();
			}
		}
		if(isset($goods_spec_array) && $goods_spec_array)
		{
			foreach($goods_spec_array as $key => $val)
			{
				$temp = explode(',',$val['value']);
				foreach($temp as $v)
				{
					$attrData = array(
						'goods_id' => $id,
						'model_id' => $goodsUpdateData['model_id'],
						'spec_id' => $val['id'],
						'spec_value' => $v
					);
					$goodsAttrDB->setData($attrData);
					$goodsAttrDB->add();
				}
			}
		}

		//是否存在货品
		$productsDB = new IModel('products');
		$productsDB->del('goods_id = '.$id);
		if(isset($postData['_spec_array']))
		{
			$productIdArray = array();

			//创建货品信息
			foreach($postData['_goods_no'] as $key => $rs)
			{
				$productsData = array(
					'goods_id' => $id,
					'products_no' => $postData['_goods_no'][$key],
					'store_nums' => $postData['_store_nums'][$key],
					'market_price' => $postData['_market_price'][$key],
					'sell_price' => $postData['_sell_price'][$key],
					'cost_price' => $postData['_cost_price'][$key],
					'weight' => $postData['_weight'][$key],
					'spec_array' => "[".join(',',$postData['_spec_array'][$key])."]"
				);
				$productsDB->setData($productsData);
				$productIdArray[$key] = $productsDB->add();
			}
		}

		//处理商品分类
		$categoryDB = new IModel('category_extend');
		$categoryDB->del('goods_id = '.$id);
		if(isset($postData['_goods_category']) && $postData['_goods_category'])
		{
			foreach($postData['_goods_category'] as $item)
			{
				$categoryDB->setData(array('goods_id' => $id,'category_id' => $item));
				$categoryDB->add();
			}
		}

		//处理商品促销
		$commendDB = new IModel('commend_goods');
		$commendDB->del('goods_id = '.$id);
		if(isset($postData['_goods_commend']) && $postData['_goods_commend'])
		{
			foreach($postData['_goods_commend'] as $item)
			{
				$commendDB->setData(array('goods_id' => $id,'commend_id' => $item));
				$commendDB->add();
			}
		}

		//处理商品关键词
		keywords::add($goodsUpdateData['search_words']);

		//处理商品图片
		$photoRelationDB = new IModel('goods_photo_relation');
		$photoRelationDB->del('goods_id = '.$id);
		if(isset($postData['_imgList']) && $postData['_imgList'])
		{
			$postData['_imgList'] = str_replace(',','","',trim($postData['_imgList'],','));
			$photoDB = new IModel('goods_photo');
			$photoData = $photoDB->query('img in ("'.$postData['_imgList'].'")','id');
			if($photoData)
			{
				foreach($photoData as $item)
				{
					$photoRelationDB->setData(array('goods_id' => $id,'photo_id' => $item['id']));
					$photoRelationDB->add();
				}
			}
		}

		//处理会员组的价格
		$groupPriceDB = new IModel('group_price');
		$groupPriceDB->del('goods_id = '.$id);
		if(isset($productIdArray) && $productIdArray)
		{
			foreach($productIdArray as $index => $value)
			{
				if(isset($postData['_groupPrice'][$index]) && $postData['_groupPrice'][$index])
				{
					$temp = JSON::decode($postData['_groupPrice'][$index]);
					foreach($temp as $k => $v)
					{
						$groupPriceDB->setData(array(
							'goods_id' => $id,
							'product_id' => $value,
							'group_id' => $k,
							'price' => $v
						));
						$groupPriceDB->add();
					}
				}
			}
		}
		else
		{
			if(isset($postData['_groupPrice'][0]) && $postData['_groupPrice'][0])
			{
				$temp = JSON::decode($postData['_groupPrice'][0]);
				foreach($temp as $k => $v)
				{
					$groupPriceDB->setData(array(
						'goods_id' => $id,
						'group_id' => $k,
						'price' => $v
					));
					$groupPriceDB->add();
				}
			}
		}
		$callback ? $this->redirect($callback) : $this->redirect("goods_list");
	}

	/**
	 * @brief 删除商品
	 */
	function goods_del()
	{
		//post数据
	    $id = IFilter::act(IReq::get('id'));
	    //生成goods对象
	    $tb_goods = new IModel('goods');
	    $tb_goods->setData(array('is_del'=>1));
	    if(!empty($id))
		{
			$tb_goods->update(Order_Class::getWhere($id));
		}
		else
		{
			Util::showMessage('请选择要删除的数据');
		}
		$this->redirect("goods_list");
	}
	/**
	 * @brief 商品上下架
	 */
	function goods_stats()
	{
		//post数据
	    $id = IFilter::act(IReq::get('id'));
	    $type = IFilter::act(IReq::get('type'));
	    //生成goods对象
	    $tb_goods = new IModel('goods');
	    $arr = array();
	    if($type=='up')
	    {
	    	$arr['is_del'] = '0';
	    }
	    else
	    {
	    	$arr['is_del'] = '2';
	    }
	    $tb_goods->setData($arr);
	    if(!empty($id))
		{
			$tb_goods->update(Order_Class::getWhere($id));
		}
		else
		{
			if($type=='up')
			{
				Util::showMessage('请选择要上架的数据');
			}
			else
			{
				Util::showMessage('请选择要下架的数据');
			}
		}
		$this->redirect("goods_list");
	}
	/**
	 * @brief 商品彻底删除
	 * */
	function goods_recycle_del()
	{
		//post数据
	    $id = IFilter::act(IReq::get('id'));
	    //生成goods对象
	    $goods = new goods_class();
	    if(!empty($id))
		{
			if(is_array($id) && isset($id[0]) && $id[0]!='')
			{
				for ($i=0;$i<count($id);$i++)
				{
					$goods->del($id[$i]);
				}
			}
			else
			{
				$goods->del($id);
			}
		}
		$this->redirect("goods_recycle_list");
	}
	/**
	 * @brief 商品还原
	 * */
	function goods_recycle_restore()
	{
		//post数据
	    $id = IFilter::act(IReq::get('id'));
	    //生成goods对象
	    $tb_goods = new IModel('goods');
	    $tb_goods->setData(array('is_del'=>0));
	    if(!empty($id))
		{
			$tb_goods->update(Order_Class::getWhere($id));
		}
		else
		{
			Util::showMessage('请选择要删除的数据');
		}
		$this->redirect("goods_recycle_list");
	}
	/**
	 * @brief 商品列表
	 */
	function goods_list()
	{
		//搜索条件
		$search = IFilter::act(IReq::get('search'));
		$page   = IReq::get('page') ? IFilter::act(IReq::get('page'),'int') : 1;

		$join  = "left join brand as b on go.brand_id = b.id";
		$where = " 1 ";

		//条件筛选处理
		if(isset($search['name']) && isset($search['keywords']) && $search['keywords'])
		{
			switch($search['name'])
			{
				case "goodsName":
				{
					$where .= " and go.name like '%".$search['keywords']."%' ";
				}
				break;

				case "goodsNo":
				{
					$where .= " and go.goods_no like '%".$search['keywords']."%' ";
				}
				break;
			}
		}

		if(isset($search['category_id']) && $search['category_id'])
		{
			$join  .= " left join category_extend as ce on ce.goods_id = go.id ";
			$where .= " and ce.category_id = ".$search['category_id'];
		}

		if(isset($search['is_del']) && $search['is_del'] !== '')
		{
			$where .= " and go.is_del = ".$search['is_del'];
		}
		else
		{
			$where .= " and go.is_del != 1";
		}

		if(isset($search['store_nums']) && $search['store_nums'])
		{
			switch($search['store_nums'])
			{
				case 1:
				{
					$where .= " and go.store_nums < 1 ";
				}
				break;

				case 10:
				{
					$where .= " and go.store_nums >= 1 and go.store_nums < 10 ";
				}
				break;

				case 100:
				{
					$where .= " and go.store_nums <= 100 and go.store_nums >= 10 ";
				}
				break;

				case 101:
				{
					$where .= " and go.store_nums >= 100 ";
				}
				break;
			}
		}

		if(isset($search['commend_id']) && $search['commend_id'])
		{
			$join  .= " left join commend_goods as cg on go.id = cg.goods_id ";
			$where .= " and cg.commend_id = ".$search['commend_id'];
		}

		//拼接sql
		$goodsHandle = new IQuery('goods as go');
		$goodsHandle->order    = "go.sort asc,go.id desc";
		$goodsHandle->distinct = "go.id";
		$goodsHandle->fields   = "go.*,b.name as brand_name";
		$goodsHandle->page     = $page;
		$goodsHandle->where    = $where;
		$goodsHandle->join     = $join;

		$this->search      = $search;
		$this->goodsHandle = $goodsHandle;
		$this->redirect("goods_list");
	}

	/**
	 * @brief 商品分类添加、修改
	 */
	function category_edit()
	{
		$category_id = IFilter::act(IReq::get('cid'),'int');
		$parent_id = IFilter::act(IReq::get('pid'),'int');
		$this->data['category']['parent_id'] = $parent_id;

		//编辑商品分类 读取商品分类信息
		if($category_id)
		{
			$obj_category = new IModel('category');
			$category_info = $obj_category->getObj('id='.$category_id);
			if($category_info)
			{
				$this->data['category'] = $category_info;
			}
			else
			{
				$this->category_list();
				Util::showMessage("没有找到相关商品分类！");
				return;
			}
		}
		//加载模型
		$tb_model = new IModel('model');
		$this->data['models'] = $tb_model->query();

		//加载分类
		if(!isset($obj_category))
		{
			$obj_category = new IModel('category');
		}

		$goods = new goods_class();
		$this->data['all_category'] = $goods->sortdata($obj_category->query(false,'*','sort','asc'),0,'--');
		$this->setRenderData($this->data);
		$this->redirect('category_edit');
	}

	/**
	 * @brief 保存商品分类
	 */
	function category_save()
	{
		//获得post值
		$category_id = IFilter::act(IReq::get('category_id'),'int');
		$name = IFilter::act(IReq::get('name'));
		$parent_id = IFilter::act(IReq::get('parent_id'),'int');
		$visibility = IFilter::act(IReq::get('visibility'),'int');
		$model = IFilter::act(IReq::get('model'),'int');
		$sort = IFilter::act(IReq::get('sort'),'int');
		$title = IFilter::act(IReq::get('title'));
		$keywords = IFilter::act(IReq::get('keywords'));
		$descript = IFilter::act(IReq::get('descript'));

		if(!$name)
		{
			$this->category_list();
			exit;
		}

		$tb_category = new IModel('category');
		$category_info = array(
			'name'=>$name,
			'parent_id'=>$parent_id,
			'sort'=>$sort,
			'visibility'=>$visibility,
			'model_id'=>$model,
			'keywords'=>$keywords,
			'descript'=>$descript,
			'title'=>$title
		);
		$tb_category->setData($category_info);
		if($category_id)									//保存修改分类信息
		{
			$where = "id=".$category_id;
			$tb_category->update($where);
		}
		else												//添加新商品分类
		{
			$tb_category->add();
		}

		$this->category_list();
	}

	/**
	 * @brief 删除商品分类
	 */
	function category_del()
	{
		$category_id = IFilter::act(IReq::get('cid'),'int');
		if($category_id)
		{
			$tb_category = new IModel('category');
			$catRow      = $tb_category->getObj('parent_id = '.$category_id);

			//要删除的分类下还有子节点
			if(!empty($catRow))
			{
				$this->category_list();
				Util::showMessage('无法删除此分类，此分类下还有子分类，或者回收站内还留有子分类');
				exit;
			}

			$tb_category_extend  = new IModel('category_extend');
			$cate_ext = $tb_category_extend->getObj('category_id = '.$category_id);

			//要删除的分类下还有商品
			if(!empty($cate_ext))
			{
				$this->category_list();
				Util::showMessage('此分类下还有商品,请先删除商品！');
				exit;
			}

			if($tb_category->del('id = '.$category_id))
			{
				$this->category_list();
			}
			else
			{
				$this->category_list();
				$msg = "没有找到相关分类记录！";
				Util::showMessage($msg);
			}
		}
		else
		{
			$this->category_list();
			$msg = "没有找到相关分类记录！";
			Util::showMessage($msg);
		}
	}

	/**
	 * @brief 商品分类列表
	 */
	function category_list()
	{
		//加载模型
		$tb_model = new IModel('model');
		$models = $tb_model->query();
		$model_info =array();
		foreach($models as $value)
		{
			$model_info[$value['id']] = $value['name'];
		}
		$this->data['models'] = $model_info;
		//加载分类
		$tb_category = new IModel('category');
		$goods = new goods_class();
		$this->data['category'] = $goods->sortdata($tb_category->query(false,'*','sort','asc'));
		$this->setRenderData($this->data);
		$this->redirect('category_list',false);
	}

	//修改规格页面
	function spec_edit()
	{
		$this->layout = '';
		$dataRow = null;
		if($id = IReq::get('id'))
		{
			$where = 'id = '.$id;
			$obj = new IModel('spec');
			$dataRow = $obj->getObj($where);
		}

		if(!$dataRow)
		{
			$dataRow = array(
				'id'   => null,
				'name' => null,
				'type' => null,
				'value'=> null,
				'note' => null,
			);
		}

		$this->setRenderData($dataRow);
		$this->redirect('spec_edit');
	}

	//增加或者修改规格
    function spec_update()
    {
    	//显示方式
    	$specType = IReq::get('type');

    	//规格数据
    	$valueArray = IReq::get('value');

		//要插入的数据
    	if(is_array($valueArray) && isset($valueArray[0]) && $valueArray[0]!='')
    	{
    		$valueArray = array_unique($valueArray);
    		foreach($valueArray as $key => $rs)
    		{
    			if($rs=='')
    			{
    				unset($valueArray[$key]);
    			}
    		}

			if(!$valueArray)
			{
				$isPass = false;
				$errorMessage = "请上传规格图片";
			}
			else
			{
				$value = JSON::encode($valueArray);
			}
		}
    	else
    		$value = '';

    	$editData = array(
    		'id'    => IReq::get('id'),
    		'name'  => IReq::get('name'),
    		'value' => $value,
    		'type'  => IReq::get('type'),
    		'note'  => IReq::get('note'),
    	);

    	//校验
    	$isPass = true;
    	if($value=='')
    	{
    		$isPass = false;
    		$errorMessage = '规格值不能为空,请填写规格值或上传规格图片';
    	}

    	if($editData['name']=='')
    	{
    		$isPass = false;
    		$errorMessage = '规格名称不能为空';
    	}

    	if($isPass==false)
    	{
    		echo JSON::encode(array('flag' => 'fail','message' => $errorMessage));
    		exit;
    	}
    	else
    	{
    		$obj = new IModel('spec');

			//执行操作
	    	$obj->setData($editData);
	    	if($id = IReq::get('id'))
	    	{
	    		$where = 'id = '.$id;
	    		$result = $obj->update($where);
	    	}
	    	else
	    		$result = $obj->add();

			//执行状态
	    	if($result===false)
	    	{
    			echo JSON::encode(array('flag' => 'fail','message' => '数据库更新失败'));
	    	}
	    	else
	    	{
	    		//获取自动增加ID
	    		$editData['id'] = $id ? $id : $result;
	    		echo JSON::encode(array('flag' => 'success','data' => $editData));
	    	}
    	}
    }

	//批量删除规格
    function spec_del()
    {
    	$id = IReq::get('id');
		if(!empty($id))
		{
			$obj = new IModel('spec');
			$obj->setData(array('is_del'=>1));
			$obj->update(Order_Class::getWhere($id));
			$this->redirect('spec_list');
		}
		else
		{
			$this->redirect('spec_list',false);
			Util::showMessage('请选择要删除的规格');
		}
    }
	//彻底批量删除规格
    function spec_recycle_del()
    {
    	$id = IReq::get('id');
		if(!empty($id))
		{
			$obj = new IModel('spec');
			$obj->del(Order_Class::getWhere($id));
			$this->redirect('spec_recycle_list');
		}
		else
		{
			$this->redirect('spec_recycle_list',false);
			Util::showMessage('请选择要删除的广告位');
		}
    }
	//批量还原规格
    function spec_recycle_restore()
    {
    	$id = IReq::get('id');
		if(!empty($id))
		{
			$obj = new IModel('spec');
			$obj->setData(array('is_del'=>0));
			$obj->update(Order_Class::getWhere($id));
			$this->redirect('spec_recycle_list');
		}
		else
		{
			$this->redirect('spec_recycle_list',false);
			Util::showMessage('请选择要还原的广告位');
		}
    }
    //规格图片删除
    function spec_photo_del()
    {
    	$id = IReq::get('id','post');
    	if(isset($id[0]) && $id[0]!='')
    	{
    		$obj = new IModel('spec_photo');
    		$id_str = '';
    		foreach($id as $rs)
    		{
    			if($id_str!='')
    			{
    				$id_str.=',';
    			}
    				$id_str.=$rs;

    			$photoRow = $obj->getObj('id = '.$rs,'address');
    			if(file_exists($photoRow['address']))
    			{
    				unlink($photoRow['address']);
    			}
    		}

	    	$where = ' id in ('.$id_str.')';
	    	$obj->del($where);
	    	$this->redirect('spec_photo');
    	}
    	else
    	{
    		$this->redirect('spec_photo',false);
    		Util::showMessage('请选择要删除的id值');
    	}
    }

	/**
	 * @brief 分类排序
	 */
	function category_sort()
	{
		$category_id = IFilter::act(IReq::get('id'));
		$sort = IFilter::act(IReq::get('sort'));

		$flag = 0;
		if($category_id)
		{
			$tb_category = new IModel('category');
			$category_info = $tb_category->getObj('id='.$category_id);
			if(count($category_info)>0)
			{
				if($category_info['sort']!=$sort)
				{
					$tb_category->setData(array('sort'=>$sort));
					if($tb_category->update('id='.$category_id))
					{
						$flag = 1;
					}
				}
			}
		}
		echo $flag;
	}
	/**
	 * @brief 品牌分类排序
	 */
	public function brand_sort()
	{
		$brand_id = IFilter::act(IReq::get('id'));
		$sort = IFilter::act(IReq::get('sort'));
		$flag = 0;
		if($brand_id)
		{
			$tb_brand = new IModel('brand');
			$brand_info = $tb_brand->getObj('id='.$brand_id);
			if(count($brand_info)>0)
			{
				if($brand_info['sort']!=$sort)
				{
					$tb_brand->setData(array('sort'=>$sort));
					if($tb_brand->update('id='.$brand_id))
					{
						$flag = 1;
					}
				}
			}
		}
		echo $flag;
	}
	/**
	 * @brief import csv file
	 */
	public function csvImport()
	{
		$this->layout = '';
		$this->redirect('csvImport');
	}
	/**
	 * @brief csv file import
	 */
	public function importCsvFile()
	{
		csvimport_facade::run();
	}

	/**
	 * @brief web goods collect
	 */
	public function collect_import()
	{
		$this->layout = '';
		$this->redirect('collect_import');
	}

	/**
	 * @brief 开始采集商品信息
	 */
	public function collect_goods()
	{
		collect_facade::run();
	}
}
