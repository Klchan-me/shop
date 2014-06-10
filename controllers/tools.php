<?php
/**
 * @brief 工具模块
 * @class Tools
 * @note  后台
 */
class Tools extends IController
{
	public $layout='admin';
	public $checkRight = array('check' => 'all','uncheck' => array('seo_sitemaps'));

	function init()
	{
		IInterceptor::reg('CheckRights@onCreateAction');
	}

	public function seo_sitemaps()
	{
		$siteMaps =  new SiteMaps();
		$url = IUrl::getHost().IUrl::creatUrl("");
		$date = date('Y-m-d');
		$maps = array(
			array('loc'=>$url.'sitemap_goods.xml','lastmod'=>$date),
			array('loc'=>$url.'sitemap_article.xml','lastmod'=>$date)
		);
		$siteMaps->create($maps,$url.'sitemaps.xsl');
		$this->seo_items('goods');
		$this->seo_items('article');
		$this->redirect('seo_sitemaps');
	}
	public function seo_items($item)
	{
		$weburl = IUrl::getHost().IUrl::creatUrl("");
		switch($item)
		{
			case 'goods':
			{
				$query = new IQuery('goods');
				$url = '/site/products/id/';
				$query->fields="concat('$url',id) as loc,DATE_FORMAT(create_time,'%Y-%m-%d') as lastmod";
				$items = $query->find();

				//对url进行处理
				foreach($items as $key => $val)
				{
					$items[$key]['loc'] = IUrl::getHost().IUrl::creatUrl($val['loc']);
				}
				SiteMaps::create_map($items,'sitemap_goods.xml',$weburl.'sitemaps.xsl');
				break;
			}
			case 'article':
			{
				$query = new IQuery('article');
				$url = '/site/article_detail/id/';
				$query->fields="concat('$url',id) as loc,DATE_FORMAT(create_time,'%Y-%m-%d') as lastmod";
				$items = $query->find();

				//对url进行处理
				foreach($items as $key => $val)
				{
					$items[$key]['loc'] = IUrl::getHost().IUrl::creatUrl($val['loc']);
				}
				SiteMaps::create_map($items,'sitemap_article.xml',$weburl.'sitemaps.xsl');
			}
		}
	}

	//上传sql附件进行还原
	function upload_sql()
	{
		$this->layout = '';
		$this->redirect('upload_sql');
	}

	//[备份还原]数据备份动作(ajax操作)
	function db_act_bak()
	{
		//要备份的数据表
		$tableName = IReq::get('name','post');
		$tableName = IFilter::act($tableName,"string");

		//分卷大小限制(KB)
		$partSize = 4000;

		if(is_array($tableName) && isset($tableName[0]) && $tableName[0]!='')
		{
			$backupObj = new DBBackup($tableName);
			$backupObj->setPartSize($partSize);   //设置分卷大小
			$backupObj->runBak();                 //开始执行
			$result = array(
				'isError' => false,
				'redirect'=> IUrl::creatUrl('/tools/db_res'),
			);
		}
		else
		{
			$result = array(
				'isError' => true,
				'message' => '请选择要备份的数据表',
			);
		}
		echo JSON::encode($result);
	}

	//[备份还原]下载数据库
	function download()
	{
		$file = IFilter::act(IReq::get('file'),'filename');
		$backupObj = new DBBackup;
		$backupObj->download($file);
	}

	//[备份还原]删除备份
	function backup_del()
	{
		$name = IReq::get('name');
		$name = IFilter::act($name,'string');
		if(!empty($name) && !is_array($name))
			$name = array($name);

		if(is_array($name) && isset($name[0]) && $name[0]!='')
		{
			$backupObj = new DBBackup($name);
			$backupObj->del();
			$this->redirect('db_res');
		}
		else
		{
			$backupObj = new DBBackup;
			$resList = $backupObj->getList();
			$this->setRenderData($resList);
			$this->redirect('db_res',false);
			Util::showMessage('请选择要删除的备份文件');
		}
	}

	//[备份还原]导入数据(ajax)
	function res_act()
	{
		$name = IFilter::act(IReq::get('name'));
		if(is_array($name) && isset($name[0]) && $name[0]!='')
		{
			$backupObj = new DBBackup($name);
			$backupObj->runRes();
			$result = array(
				'isError' => false,
				'redirect'=> IUrl::creatUrl('/tools/db_bak'),
			);
		}
		else
		{
			$result = array(
				'isError' => true,
				'message' => '请选择要导入的SQL文件',
			);
		}
		echo JSON::encode($result);
	}

	//本地上传sql文件导入
	public function localUpload()
	{
		if(isset($_FILES['attach']['tmp_name']) && file_exists($_FILES['attach']['tmp_name']))
		{
			$fileName  = $_FILES['attach']['tmp_name'];
			$backupObj = new DBBackup();
			$backupObj->parseSQL($fileName);
			die('<script type="text/javascript">parent.uploadSuccess();</script>');
		}
		else
		{
			die('<script type="text/javascript">parent.uploadFail();</script>');
		}
	}

	//[备份还原]打包下载
	function download_pack()
	{
		$name = IFilter::act(IReq::get('name'));

		if($name)
		{
			$backupObj = new DBBackup($name);
			$fileName  = $backupObj->packDownload();
			if($fileName === false)
			{
				$this->redirect('db_res',false);
				Util::showMessage('环境不支持zip扩展');
				exit;
			}

			$db_fileName = $backupObj->download($fileName);
			@unlink($db_fileName);
		}
		else
		{
			$this->redirect('db_res',false);
			Util::showMessage('请选择要打包的文件');
			exit;
		}
	}

	//[文章]删除
	function article_del()
	{
		$id = IFilter::act( IReq::get('id') ,'int' );
		if(!empty($id))
		{
			$obj = new IModel('article');
			$relationObj = new IModel('relation');


			if(is_array($id) && isset($id[0]) && $id[0]!='')
			{
				$id_str = join(',',$id);
				$where1 = ' id in ('.$id_str.')';
				$where2 = ' article_id in ('.$id_str.')';
			}
			else
			{
				$where1 = 'id = '.$id;
				$where2 = 'article_id = '.$id;
			}
			$obj->del($where1);               //删除商品
			$relationObj->del($where2);       //删除关联商品表
			$this->redirect('article_list');
		}
		else
		{
			$this->redirect('article_list',false);
			Util::showMessage('请选择要删除的文章');
		}
	}

	//[文章]单页
	function article_edit()
	{
		$data = array();
		$id = IFilter::act(IReq::get('id'),'int');
		if($id)
		{
			$id = intval($id);

			//获取文章信息
			$articleObj = new IModel('article');
			$where      = 'id = '.$id;
			$data = $articleObj->getObj($where);
			if($data)
			{
				//获取文章关联商品ID值
				$relationObj   = new IModel('relation');
				$where         = 'article_id = '.$id;
				$relationGoods = $relationObj->query($where);
				$this->relationStr = null;
				foreach($relationGoods as $rs)
				{
					if($this->relationStr != '') $this->relationStr.=',';
					$this->relationStr.=$rs['goods_id'];
				}

				//根据商品ID获取商品信息
				if($this->relationStr != null)
				{
					$goodsObj        = new IModel('goods');
					$where           = 'id in ('.$this->relationStr.')';
					$this->goodsList = $goodsObj->query($where,'img,name');
				}

				$this->articleRow = $data;
				$this->redirect('article_edit',false);
			}
		}
		if(count($data)==0)
		{
			$this->redirect('article_edit');
		}

	}

	//[文章]增加修改
	function article_edit_act()
	{
		$id = intval(IReq::get('id','post'));

		$articleObj = new IModel('article');
		$DataArray  = array(
			'title'       => IFilter::act(IReq::get('title','post')),
			'content'     => IFilter::act(IReq::get('content','post'),'text'),
			'category_id' => IFilter::act(IReq::get('category_id','post'),'int'),
			'create_time' => ITime::getDateTime(),
			'keywords'    => IFilter::act(IReq::get('keywords','post')),
			'description' => IFilter::act(IReq::get('description','post'),'text'),
			'visibility'   => IFilter::act(IReq::get('visibility','post'),'int'),
			'top'         => IFilter::act(IReq::get('top','post'),'int'),
			'sort'        => IFilter::act(IReq::get('sort','post'),'int'),
			'style'       => IFilter::act(IReq::get('style','post')),
			'color'       => IFilter::act(IReq::get('color','post')),
		);

		//检查catid是否为空
		if($DataArray['category_id'] == 0)
		{
			$this->articleRow = $DataArray;
			$this->redirect('article_edit',false);
			Util::showMessage('请选择分类');
		}

		$articleObj->setData($DataArray);

		if($id)
		{
			//开始更新操作
			$where = 'id = '.$id;
			$is_success = $articleObj->update($where);
		}
		else
		{
			$id = $articleObj->add();
			$is_success = $id ? true : false;
		}

		if($is_success)
		{
			/*article关联商品操作*/
			//获取新 article关联goods ID
			$newGoodsIdArray = array();
			$goodsIdStr = IFilter::act(IReq::get('relation_goods','post'));

			if($goodsIdStr != null)
				$newGoodsIdArray = explode(',',$goodsIdStr);

			$ralationObj = new IModel('relation');
			$where = 'article_id = '.$id;
			$ralationObj->del($where);

			if(!empty($newGoodsIdArray))
			{
				foreach($newGoodsIdArray as $rs)
				{
					$reData = array(
						'goods_id'   => $rs,
						'article_id' => $id,
					);
					$ralationObj->setData($reData);
					$ralationObj->add();
				}
			}
		}
		else
		{
			$this->articleRow = $DataArray;
			$this->redirect('article_edit',false);
			Util::showMessage('插入数据时发生错误');
		}

		$this->redirect('article_list');
	}
	//[公告]增加修改
	function notice_edit_act()
	{
		$id = intval(IReq::get('id','post'));

		$noticeObj = new IModel('announcement');
		$dataArray  = array(
			'title'       => IFilter::act(IReq::get('title','post')),
			'content'     => IFilter::act(IReq::get('content','post'),'text')
		);
		$dataArray['time'] = date("Y-m-d H:i:s");
		$noticeObj->setData($dataArray);

		if($id)
		{
			$is_success = $noticeObj->update( "id={$id}" );
		}
		else
		{
			$noticeObj->add();
		}
		$this->redirect('notice_list');
	}

	//[公告]删除
	function notice_del()
	{
		$id = IFilter::act( IReq::get('id') , 'int'  );
		if(!is_array($id))
		{
			$id = array($id);
		}
		$id = implode(",",$id);

		$noticeObj = new IModel('announcement');
		$noticeObj->del( "id IN ({$id})" );
		$this->redirect('notice_list');
	}

	//[公告]单页
	function notice_edit()
	{
		$id = IReq::get('id');
		if($id)
		{
			$id = intval($id);

			//获取文章信息
			$noticeObj = new IModel('announcement ');
			$where      = 'id = '.$id;
			$this->noticeRow = $noticeObj->getObj($where);
		}

		$this->redirect('notice_edit',false);
	}
	//[文章分类] 增加和修改动作
	function cat_edit_act()
	{
		$id        = IFilter::act( IReq::get('id','post') );
		$parent_id = IFilter::act( IReq::get('parent_id','post') ) ;

		$catObj    = new IModel('article_category');
		$DataArray = array(
			'parent_id' => $parent_id,
			'name'      => IFilter::act( IReq::get('name','post'),'string'),
			'issys'     => IFilter::act( IReq::get('issys','post') ),
			'sort'      => IFilter::act( IReq::get('sort','post') ),
		);

		/*开始--获取path信息*/
		//1,修改操作
		if($id)
		{
			$where  = 'id = '.$id;
			$catRow = $catObj->getObj($where);
			if($catRow['parent_id']==$parent_id)
			{
				$isMoveNode = false;
				$DataArray['path'] = $catRow['path'];
			}
			else
				$isMoveNode = true;

			$localId = $id;
		}
		//2,新增操作
		else
		{
			$max_id  = $catObj->getObj('','max(id) as max_id');
			$localId = $max_id['max_id'] ? $max_id['max_id']+1 : 1;
		}

		//如果不存在path数据时,计算path数据
		if(!isset($DataArray['path']))
		{
			//获取父节点的path路径
			if($parent_id==0)
				$DataArray['path'] = ','.$localId.',';
			else
			{
				$where     = 'id = '.$parent_id;
				$parentRow = $catObj->getObj($where);
				$DataArray['path'] = $parentRow['path'].$localId.',';
			}
		}
		/*结束--获取path信息*/
		//设置数据值
		$catObj->setData($DataArray);

		//1,修改操作
		if($id)
		{
			//节点移动
			if($isMoveNode == true)
			{
				if($parentRow['path']!=null && strpos($parentRow['path'],','.$id.',')!==false)
				{
					$this->catRow = array(
						'parent_id' => $DataArray['parent_id'],
						'name'      => $DataArray['name'],
						'issys'     => $DataArray['issys'],
						'sort'      => $DataArray['sort'],
						'id'        => $id,
					);
					$this->redirect('article_cat_edit',false);
					Util::showMessage('不能该节点移动到其子节点的位置上');
				}
				else
				{
					//其子节点批量移动
					$childObj = new IModel('article_category');
					$oldPath  = $catRow['path'];
					$newPath  = $DataArray['path'];

					$where = 'path like "'.$oldPath.'%"';
					$updateData = array(
						'path' => "replace(path,'".$oldPath."','".$newPath."')",
					);
					$childObj->setData($updateData);
					$childObj->update($where,array('path'));
				}
			}
			$where = 'id = '.$id;
			$catObj->update($where);
		}
		//2,新增操作
		else
			$catObj->add();

		$this->redirect('article_cat_list');
	}

	//[文章分类] 增加修改单页
	function cat_edit()
	{
		$data = array();
		$id = IFilter::act( IReq::get('id'),'int' );

		if($id)
		{
			$catObj = new IModel('article_category');
			$where  = 'id = '.$id;
			$data = $catObj->getObj($where);
			if(count($data)>0)
			{
				$this->catRow = $data;
				$this->redirect('article_cat_edit',false);
			}
		}
		if(count($data)==0)
		{
			$this->redirect('article_cat_list');
		}
	}

	//[文章分类] 删除
	function cat_del()
	{
		$id = IFilter::act( IReq::get('id'),'int' );
		$catObj = new IModel('article_category');

		//是否执行删除检测值
		$isCheck=true;

		//检测是否有parent_id 为 $id
		$where   = 'parent_id = '.$id;
		$catData = $catObj->getObj($where);
		if(!empty($catData))
		{
			$isCheck=false;
			$message='此分类下还有子分类';
		}

		//检测是否有article的category_id 为 $id
		else
		{
			$articleObj = new IModel('article');
			$where = 'category_id = '.$id;
			$catData = $articleObj->getObj($where);

			if(!empty($catData))
			{
				$isCheck=false;
				$message='此分类下还有文章';
			}
		}

		if($isCheck == false)
		{
			$message = isset($message) ? $message : '删除失败';
			$this->redirect('article_cat_list',false);
			Util::showMessage($message);
		}
		else
		{
			$where  = 'id = '.$id;
			$result = $catObj->del($where);
			$this->redirect('article_cat_list');
		}
	}

	//[广告位] 删除
	function ad_position_del()
	{
		$id = IFilter::act( IReq::get('id') , 'act' );
		if(!empty($id))
		{
			$obj = new IModel('ad_position');
			if(is_array($id) && isset($id[0]) && $id[0]!='')
			{
				$id_str = join(',',$id);
				$where = ' id in ('.$id_str.')';
			}
			else
			{
				$where = 'id = '.$id;
			}
			$obj->del($where);
			$this->redirect('ad_position_list');
		}
		else
		{
			$this->redirect('ad_position_list',false);
			Util::showMessage('请选择要删除的广告位');
		}
	}

	//[广告位] 添加修改 (单页)
	function ad_position_edit()
	{
		$id = IFilter::act( IReq::get('id') );
		if($id)
		{
			$obj = new IModel('ad_position');
			$where = 'id = '.$id;
			$this->positionRow = $obj->getObj($where);
		}
		$this->redirect('ad_position_edit',false);
	}

	//[广告位] 添加和修改动作
	function ad_position_edit_act()
	{
		$id = IFilter::act( IReq::get('id') );

		$obj = new IModel('ad_position');

		$dataArray = array(
			'name'    => IFilter::act( IReq::get('name','post') ,'string' ),
			'width'   => intval( IReq::get('width','post') ),
			'height'  => intval( IReq::get('height','post') ),
			'type'    => intval( IReq::get('type','post') ),
			'fashion' => intval( IReq::get('fashion','post') ),
			'status'  => intval( IReq::get('status','post') ),
			'ad_nums' => intval( IReq::get('ad_nums','post') ),
		);
		$obj->setData($dataArray);

		if($id)
		{
			$where = 'id = '.$id;
			$result = $obj->update($where);
		}
		else
			$result = $obj->add();

		$this->redirect('ad_position_list');
	}

	//[广告] 删除
	function ad_del()
	{
		$id = IFilter::act( IReq::get('id') , 'int' );
		if(!empty($id))
		{
			$obj = new IModel('ad_manage');
			if(is_array($id) && isset($id[0]) && $id[0]!='')
			{
				$id_str = join(',',$id);
				$where = ' id in ('.$id_str.')';
			}
			else
			{
				$where = 'id = '.$id;
			}
			$obj->del($where);
			$this->redirect('ad_list');
		}
		else
		{
			$this->redirect('ad_list',false);
			Util::showMessage('请选择要删除的广告');
		}
	}

	//[广告] 添加修改 (单页)
	function ad_edit()
	{
		$id = IFilter::act( IReq::get('id'),'int' );
		if($id)
		{
			$obj = new IModel('ad_manage');
			$where = 'id = '.$id;
			$this->adRow = $obj->getObj($where);
		}
		$this->redirect('ad_edit',false);
	}

	//[广告] 添加和修改动作
	function ad_edit_act()
	{
		$id    = IFilter::act( IReq::get('id'),'int' );
		$adObj = new IModel('ad_manage');
		$error_message = null;

		//获取content数据
		$type    = IReq::get('ad_type','post');
		$content = IReq::get('content','post');
		$upObj   = null;

		switch($type)
		{
			case "1":
			//图片上传
			$upObj  = new IUpload();
			$attach = 'img';
			break;
			case "2":
			//flash上传
			$upObj  = new IUpload('4048',array('flv','swf'));
			$attach = 'flash';
			break;
			case "3":
			//文字
			$content = IReq::get('text','post');
			break;

			case "4":
			//代码
			$content = IReq::get('code','post');
			break;
		}
		if($upObj != null)
		{
			//目录散列
			$dir = IWeb::$app->config['upload'].'/'.date('Y')."/".date('m')."/".date('d');
			$upObj->setDir($dir);
			$upState = $upObj->execute();
			if(!isset($upState[$attach]))
			{
				if($content == '')
				{
					$error_message = '没有上传文件';
				}
			}
			else
			{
				if($upState[$attach][0]['flag']==-1)
				{
					$error_message = '上传的文件类型不符合';
				}
				else if($upState[$attach][0]['flag']==-2)
				{
					$error_message = '大小超过限度';
				}
				else if($upState[$attach][0]['flag']==1)
					$content = $dir.'/'.$upState[$attach][0]['name'];
			}
		}
		else
		{
			if($content == '')
			{
				$error_message = '请填写广告展示类型的内容';
			}
		}

		$dataArray = array(
			'content'     => IFilter::addSlash($content),
			'name'        => IFilter::act(IReq::get('name')),
			'position_id' => IFilter::act(IReq::get('position_id')),
			'width'       => IFilter::act(IReq::get('width')),
			'height'      => IFilter::act(IReq::get('height')),
			'type'        => IFilter::act(IReq::get('ad_type')),
			'link'        => IFilter::addSlash(IReq::get('link')),
			'start_time'  => IFilter::act(IReq::get('start_time')),
			'end_time'    => IFilter::act(IReq::get('end_time')),
			'description' => IFilter::act(IReq::get('description'),'text'),
			'order'       => IFilter::act(IReq::get('order'),'int'),
		);

		if($dataArray['link'] == "" || $dataArray['link']=='#')
		{
			$dataArray['link'] = 'javascript:void(0);';
		}

		//上传错误
		if($error_message != null)
		{
			if($id)
			{
				$dataArray['id'] = $id;
			}
			$this->adRow = $dataArray;
			$this->redirect('ad_edit',false);
			Util::showMessage($error_message);
		}

		$adObj->setData($dataArray);

		if($id)
		{
			$where = 'id = '.$id;
			$adObj->update($where);
		}
		else
		{
			$adObj->add();
		}

		$this->redirect("ad_list",true);
	}

	function help_list()
	{
		$query = new IQuery("help AS help");
		$query->join = "LEFT JOIN help_category AS cat ON help.cat_id=cat.id";
		if(IReq::get('cat_id')!==null)
		{
			$query->where = "help.cat_id = ".intval(IReq::get('cat_id'));
		}
		$query->fields = "help.*,cat.name AS cat_name";
		$query->order = "help.`sort` ASC,help.id DESC";
		$query->page = isset($_GET['page'])?$_GET['page']:1;
		$this->query = $query;
		$this->list = $query->find();
		$this->redirect("help_list");
	}

	function help_edit()
	{
		$id = intval(IReq::get("id"));
		$this->help_row=array('id'=>$id,'name'=>'','cat_id'=>0,'content'=>"",'sort'=>0);
		if($id)
		{
			$this->help_row=SiteHelp::get_help_by_id($id);
			if(!isset($this->help_row[$id]))
			{
				$this->redirect("help_list",true);
				Util::showMessage( "没有这条记录" );
			}
			$this->help_row=$this->help_row[$id];
		}
		$this->redirect("help_edit");
	}

	function help_edit_act()
	{
		//数据在Sitemap里过滤了
		$data['id'] = IReq::get("id");
		$data['cat_id'] = IReq::get('cat_id') ;
		$data['name'] = IReq::get('name');
		$data['sort'] = IReq::get("sort");
		$data['content'] = IReq::get("content");

		$re = SiteHelp::help_edit($data);
		if($re['flag']===true)
		{
			$this->redirect("help_list");
		}
		else
		{
			$this->redirect("help_edit",false);
			Util::showMessage($re['data']);
		}
	}

	function help_del()
	{
		$id = IReq::get("id");
		if($id===null)
		{
			$this->redirect('/tools/help_list');
		}
		$re = SiteHelp::help_del($id);

		if($re['flag']===true)
		{
			$this->redirect('/tools/help_list');
		}
		else
		{
			$this->redirect('/tools/help_list');
		}
	}
	function help_cat_edit()
	{
		$id=IReq::get("id");
		$this->cat_row=array('name'=>'','position_left'=>0,'position_foot'=>0,'sort'=>'');
		if($id!==null)
		{
			$this->cat_row=SiteHelp::get_cat_by_id($id);
			if(!isset($this->cat_row[$id]))
				Util::showMessage( "没有这条记录" );
			$this->cat_row=$this->cat_row[$id];
		}
		$this->redirect("help_cat_edit");
	}

	function help_cat_edit_act()
	{
		$data["id"] = IReq::get("id","post");
		$data["name"] = IReq::get("name","post");
		$data["position_left"] = IReq::get("position_left","post");
		$data["position_foot"] = IReq::get("position_foot","post");
		$data["sort"] = IReq::get("sort");

		$re=SiteHelp::cat_edit($data);
		if($re['flag']!==true)
		{
			Util::showMessage($re['data']);
			die();
		}
		$this->redirect('help_cat_list');
	}

	function help_cat_position()
	{
		$id = IReq::get("id");
		$position = IReq::get("position");
		$value = IReq::get("value");
		if($id===null || $position===null || $value===null)
			die("错误的参数");

		$re=SiteHelp::mod_cat_position($id,$position,$value);
		if($re['flag']===false)
			die($re['data']);
		die("设置成功");
	}

	//帮助分类删除
	function help_cat_del()
	{
		$id = IReq::get('id');
		if($id===null)
			die("错误的参数");
		$re = SiteHelp::del_cat($id);
		if($re['flag']===false)
			die($re['data']);
		die("success");
	}

	//[关键词管理]添加
	function keyword_add()
	{
		$word  = IFilter::act(IReq::get('word'));
		$hot   = intval(IReq::get('hot'));
		$order = IReq::get('order') ? intval(IReq::get('order')) : 99;

		$re = keywords::add($word ,$hot,$order);

		if($re['flag']==true)
		{
			$this->redirect('keyword_list');
		}
		else
		{
			$this->redirect('keyword_edit');
			Util::showMessage($re['data']);
		}
	}

	//[关键词管理]删除
	function keyword_del()
	{
		$id = IFilter::act(IReq::get('id'));
		if(!empty($id))
		{
			$keywordObj = new IModel('keyword');
			if(is_array($id))
			{
				$ids = '"'.join('","',$id).'"';
				$keywordObj->del('word in ('.$ids.')');
			}
			else
			{
				$keywordObj->del('word = "'.$id.'"');
			}
		}
		else
		{
			$message = '请选择要删除的关键词';
		}

		if(isset($message))
		{
			$this->redirect('keyword_list',false);
			Util::showMessage($message);
		}
		else
		{
			$this->redirect('keyword_list');
		}
	}

	//[关键词管理]设置hot
	function keyword_hot()
	{
		$id  = IFilter::act(IReq::get('id'));

		$keywordObj = new IModel('keyword');
		$dataArray  = array('hot' => 'abs(hot - 1)');
		$keywordObj->setData($dataArray);
		$is_result  = $keywordObj->update('word = "'.$id.'"','hot');

		$keywordRow = $keywordObj->getObj('word = "'.$id.'"');
		if($is_result!==false)
		{
			echo JSON::encode(array('isError' => false,'hot' => $keywordRow['hot']));
		}
		else
		{
			echo JSON::encode(array('isError'=>true,'message'=>'设置失败'));
		}
	}

	//[关键词管理]统计商品数量
	function keyword_account()
	{
		$word   = IFilter::act(IReq::get('id'));
		$result = keywords::count($word);
		if($result === false)
		{
			$this->redirect('keyword_list',false);
			Util::showMessage('请选择要同步的关键词');
		}
		else
		{
			$keywordObj = new IModel('keyword');
			foreach($result as $word => $num)
			{
				$dataArray = array(
					'goods_nums' => $num,
				);
				$keywordObj->setData($dataArray);
				$keywordObj->update('word = "'.$word.'"');
			}
			$this->redirect('keyword_list');
		}
	}
	//关键词排序
	function keyword_order()
	{
		$word  = IFilter::act(IReq::get('id'));
		$order = IReq::get('order') ? intval(IReq::get('order')) : 99;

		$keywordObj = new IModel('keyword');
		$dataArray = array('order' => $order);
		$keywordObj->setData($dataArray);
		$is_success = $keywordObj->update('word = "'.$word.'"');

		if($is_success === false)
		{
			$result = array(
				'isError' => true,
				'message' => '更新排序失败',
			);
		}
		else
		{
			$result = array(
				'isError' => false,
			);
		}
		echo JSON::encode($result);
	}

	/**
	 * 查询删除
	 */
	function search_del()
	{
		$id = IFilter::act(IReq::get('id'),'int');

		//生成search对象
	    $tb_search = new IModel('search');
	    if(!empty($id))
		{
			if(is_array($id) && isset($id[0]) && $id[0]!='')
			{
				$id_str = join(',',$id);
				$where = ' id in ('.$id_str.')';
			}
			else
			{
				$where = 'id = '.$id;
			}
			$tb_search->del($where);
		}
		else
		{
			Util::showMessage('请选择要删除的数据');
		}
		$this->redirect("search_list");
	}
}
