<?php
/**
 * @class Brand
 * @brief 品牌模块
 * @note  后台
 */
class Brand extends IController
{
	public $checkRight  = 'all';
    public $layout='admin';
	private $data = array();

	function init()
	{
		IInterceptor::reg('CheckRights@onCreateAction');
	}

	/**
	 * @brief 品牌分类添加、修改
	 */
	function category_edit()
	{
		$category_id = (int)IReq::get('cid');
		//编辑品牌分类 读取品牌分类信息
		if($category_id)
		{
			$obj_brand_category = new IModel('brand_category');
			$category_info = $obj_brand_category->query('id='.$category_id);
			if(is_array($category_info) && $info=$category_info[0])
			{
				$this->data['category'] = array(
					'id'		=>	$info['id'],
					'name'		=>	$info['name']
				);
			}
			else
			{
				$this->category_list();
				Util::showMessage("没有找到相关品牌分类！");
				return;
			}
		}
		$this->setRenderData($this->data);
		$this->redirect('category_edit',false);
	}

	/**
	 * @brief 保存品牌分类
	 */
	function category_save()
	{
		$category_id = IFilter::act(IReq::get('category_id'),'int');
		$name = IFilter::act(IReq::get('name'));

		$category_info = array();
		$tb_brand_category = new IModel('brand_category');
		$category_info['name'] = $name;
		$tb_brand_category->setData($category_info);
		if($category_id)									//保存修改分类信息
		{
			$where = "id=".$category_id;
			$tb_brand_category->update($where);
		}
		else												//添加新品牌分类
		{
			$tb_cate = new IQuery('brand_category');		//查询数据库，判断该分类是否存在，如存在则不存储
			$tb_cate->fields = 'name';
			$tb_info = $tb_cate->find();
			if(count($tb_info)>0)
			{
				foreach ($tb_info as $value)
				{
					if($category_info['name']==$value['name'])
					{
						$this->redirect('category_edit',false);
						Util::showMessage("添加的品牌分类已存在！");
					}
				}
			}
			$tb_brand_category->add();
		}
		$this->category_list();
	}

	/**
	 * @brief 删除品牌分类
	 */
	function category_del()
	{
		$category_id = (int)IReq::get('cid');
		if($category_id)
		{
			$brand_category = new IModel('brand_category');
			$where = "id=".$category_id;
			if($brand_category->del($where))
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
	 * @brief 品牌分类列表
	 */
	function category_list()
	{
		$this->redirect('category_list');
	}

	/**
	 * @brief 修改品牌
	 */
	function brand_edit()
	{
		$brand_id = (int)IReq::get('bid');
		//编辑品牌 读取品牌信息
		if($brand_id)
		{
			$obj_brand = new IModel('brand');
			$brand_info = $obj_brand->getObj('id='.$brand_id);
			if($brand_info)
			{
				$this->data['brand'] = $brand_info;
			}
			else
			{
				$this->category_list();
				Util::showMessage("没有找到相关品牌分类！");
				return;
			}
		}

		$this->setRenderData($this->data);
		$this->redirect('brand_edit',false);
	}

	/**
	 * @brief 保存品牌
	 */
	function brand_save()
	{
		$brand_id = IFilter::act(IReq::get('brand_id'),'int');
		$name = IFilter::act(IReq::get('name'));
		$sort = IFilter::act(IReq::get('sort'),'int');
		$url = IFilter::act(IReq::get('url'));
		$category = IFilter::act(IReq::get('category'),'int');
		$description = IFilter::act(IReq::get('description'),'text');

		$tb_brand = new IModel('brand');
		$brand = array(
			'name'=>$name,
			'sort'=>$sort,
			'url'=>$url,
			'description' => $description,
		);

		if($category && is_array($category))
		{
			$categorys = join(',',$category);
			$brand['category_ids'] = $categorys;
		}
		else
		{
			$brand['category_ids'] = '';
		}
		if(isset($_FILES['logo']['name']) && $_FILES['logo']['name']!='')
		{
			$uploadObj = new PhotoUpload();
			$uploadObj->setIterance(false);
			$photoInfo = $uploadObj->run();
			if(isset($photoInfo['logo']['img']) && file_exists($photoInfo['logo']['img']))
			{
				$brand['logo'] = $photoInfo['logo']['img'];
			}
		}
		$tb_brand->setData($brand);
		if($brand_id)
		{
			//保存修改分类信息
			$where = "id=".$brand_id;
			$tb_brand->update($where);
		}
		else
		{
			//添加新品牌
			$tb_brand->add();
		}
		$this->brand_list();
	}

	/**
	 * @brief 删除品牌
	 */
	function brand_del()
	{
		$brand_id = (int)IReq::get('bid');
		if($brand_id)
		{
			$tb_brand = new IModel('brand');
			$where = "id=".$brand_id;
			if($tb_brand->del($where))
			{
				$this->brand_list();
			}
			else
			{
				$this->brand_list();
				$msg = "没有找到相关分类记录！";
				Util::showMessage($msg);
			}
		}
		else
		{
			$this->brand_list();
			$msg = "没有找到相关品牌记录！";
			Util::showMessage($msg);
		}
	}

	/**
	 * @brief 品牌列表
	 */
	function brand_list()
	{
		$this->redirect('brand_list');
	}
}