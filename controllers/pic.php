<?php
/**
 * @copyright (c) 2011 jooyea.cn
 * @file pic.php
 * @brief 图库处理
 * @author chendeshan
 * @date 2010-12-16
 */
class Pic extends IController
{
	public $layout = '';
	function init()
	{
		if(IReq::get('action') != 'upload_json')
		{
			IInterceptor::reg('CheckRights@onCreateAction');
		}
	}
	//规格图片上传
	function uploadFile()
	{
		//上传状态
		$state = false;

		//规格索引值
		$specIndex = IReq::get('specIndex');
		if($specIndex===null)
		{
			$message = '没有找到规格索引值';
		}
		else
		{
			//本地上传方式
			if(isset($_FILES['attach']) && $_FILES['attach']['name'][0]!='')
			{
				$photoInfo = $this->upload();
				if($photoInfo['flag']==1)
				{
					$fileName = $photoInfo['dir'].$photoInfo['name'];
					$state = true;
				}
			}

			//远程网络方式
			else if($fileName=IReq::get('outerSrc','post'))
			{
				$state = true;
			}

			//图库选择方式
			else if($fileName=IReq::get('selectPhoto','post'))
			{
				$state = true;
			}
		}

		//根据状态值进行
		if($state == true)
			$this->actJs($specIndex,$fileName);

		else
		{
			$message = '添加图片失败';
			$this->redirect('/block/pic',false);
			Util::showMessage($message);
		}
	}

	//本地上传方式
	function upload()
	{
		//图片上传
		$upObj = new IUpload();

		//目录散列
		$dir = IWeb::$app->config['upload'].'/'.date('Y')."/".date('m')."/".date('d');
		$upObj->setDir($dir);
		$upState = $upObj->execute();

		//实例化
		$obj = new IModel('spec_photo');

		//检查上传状态
		foreach($upState['attach'] as $val)
		{
			if($val['flag']==1)
			{
				$insertData = array(
					'address'     => $val['dir'].$val['name'],
					'name'        => $val['ininame'],
					'create_time' => ITime::getDateTime(),
				);
				$obj->setData($insertData);
				$obj->add();
			}
		}
		if(count($upState['attach'])==1)
			return $upState['attach'][0];
		else
			return $upState['attach'];
	}

	//与parent的js交换
	function actJs($specIndex,$fileName)
	{
		echo '
		<script type="text/javascript">
			if(parent.length>=2)
				winObj = parent[parent.length-2];
			else
				winObj = parent;
			if(!winObj.updatePic && parent[parent.length-1].updatePic)
				winObj=parent[parent.length-1];
			winObj.updatePic("'.$specIndex.'","'.$fileName.'");
		</script>';
	}

	//获取图片列表
	function getPhotoList()
	{
		$obj = new IModel('spec_photo');
		$photoRs = $obj->query();
		echo JSON::encode($photoRs);
	}

	//kindeditor图片上传
	public function upload_json()
	{
		$save_path = $this->module->getBasePath().$this->module->config['upload'].'/';
		$save_url = IUrl::creatUrl('').$this->module->config['upload'].'/';
		include($this->module->runtimePath.'systemjs/editor/php/upload_json.php');
	}

	//kindeditor flash多图片上传
	public function file_manager_json()
	{
		$root_path = $this->module->getBasePath().$this->module->config['upload'].'/';
		$root_url = IUrl::creatUrl('').$this->module->config['upload'].'/';
		include($this->module->runtimePath.'systemjs/editor/php/file_manager_json.php');
	}
}