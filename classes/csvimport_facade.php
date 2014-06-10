<?php
/**
 * @brief csv商品导入外观模式
 * @author chendeshan
 * @date 2014/1/2 8:32:57
 */
class csvimport_facade
{
	/**
	 * @brief 开始运行
	 */
	public static function run()
	{
		$csvType  = IReq::get('csvType');
		$category = IFilter::act(IReq::get('category'),'int');

		$pluginDir = IWeb::$app->getBasePath().'plugins/csvPacketHelper/';
		if(!file_exists($pluginDir))
		{
			$message = '此功能仅供授权版本使用，请您购买商业授权';
			die('<script type="text/javascript">parent.artDialogCallback("'.$message.'");</script>');
		}

		if(!class_exists('ZipArchive'))
		{
			$message = '服务器环境中没有安装zip扩展，无法使用此功能';
			die('<script type="text/javascript">parent.artDialogCallback("'.$message.'");</script>');
		}

		//处理上传
		$uploadInstance = new IUpload(50000,array('zip'));
		$uploadCsvDir   = IWeb::$app->config['upload'].'/cvs/'.date('Ymd');
		$uploadInstance->setDir($uploadCsvDir);
		$result = $uploadInstance->execute();

		if(!isset($result['csvPacket']))
		{
			$message = '请上传指定大小的csv数据包';
			die('<script type="text/javascript">parent.artDialogCallback("'.$message.'");</script>');
		}

		if(($packetData = current($result['csvPacket'])) && $packetData['flag'] != 1)
		{
			$message = $uploadInstance->errorMessage($packetData['flag']);
			die('<script type="text/javascript">parent.artDialogCallback("'.$message.'");</script>');
		}

		$zipPath = $packetData['fileSrc'];
		$zipDir  = dirname($zipPath);
		$imageDir= IWeb::$app->config['upload'].'/'.date('Y/m/d');
		file_exists($imageDir) ? '' : IFile::mkdir($imageDir);

		//解压缩包
		$zipObject = new ZipArchive();
		$zipObject->open($zipPath);
		$isExtract = $zipObject->extractTo($zipDir);
		$zipObject->close();

		if($isExtract == false)
		{
			$message = '解压缩到目录'.$zipDir.'失败！';
			die('<script type="text/javascript">parent.artDialogCallback("'.$message.'");</script>');
		}

		//实例化商品
		$goodsObject     = new IModel('goods');
		$photoRelationDB = new IModel('goods_photo_relation');
		$photoDB         = new IModel('goods_photo');
		$cateExtendDB    = new IModel('category_extend');

		//获得配置文件中的数据
		$config = new Config("site_config");

		$dirHandle = opendir($zipDir);
		while($fileName = readdir($dirHandle))
		{
			if(strpos($fileName,'.csv') !== false)
			{
				//创建解析对象
				switch($csvType)
				{
					case "taobao":
					{
						include_once($pluginDir.'taoBaoPacketHelper.php');
						$helperInstance = new taoBaoPacketHelper($zipDir.'/'.$fileName,$imageDir);
						$titleToCols    = taoBaoTitleToColsMapping::$mapping;
					}
					break;

					default:
					{
						$message = "请选择csv数据包的格式";
						die('<script type="text/javascript">parent.artDialogCallback("'.$message.'");</script>');
					}
				}
				//从csv中解析数据
				$collectData = $helperInstance->collect();

				//插入商品表
				foreach($collectData as $key => $val)
				{
					set_time_limit(1000);

					$collectImage = isset($val[$titleToCols['img']]) ? $val[$titleToCols['img']] : '';

					//有图片处理
					if($collectImage)
					{
						//图片拷贝
						$_FILES = array();
						foreach($collectImage as $image)
						{
							foreach($image as $from => $to)
							{
								IFile::xcopy($from,$to);

								//构造$_FILES全局数组
								$_FILES[] = array(
									'size'     => 100,
									'tmp_name' => $to,
									'name'     => basename($to),
									'error'    => 0
								);
							}
						}
						//调用文件上传类
						$photoObj = new PhotoUpload();
						$uploadImg = $photoObj->run(true);
						$showImg   = current($uploadImg);
					}

					$insertData = array(
						'name'         => IFilter::act(trim($val[$titleToCols['name']],'"\'')),
						'goods_no'     => goods_class::createGoodsNo(),
						'sell_price'   => IFilter::act($val[$titleToCols['sell_price']],'float'),
						'market_price' => IFilter::act($val[$titleToCols['sell_price']],'float'),
						'up_time'      => ITime::getDateTime(),
						'create_time'  => ITime::getDateTime(),
						'store_nums'   => IFilter::act($val[$titleToCols['store_nums']],'int'),
						'content'      => IFilter::act(trim($val[$titleToCols['content']],'"\''),'text'),
						'img'          => isset($showImg['img'])           ? $showImg['img']           : ''
					);
					$goodsObject->setData($insertData);
					$goods_id = $goodsObject->add();

					//处理商品分类
					if($category)
					{
						foreach($category as $catId)
						{
							$cateExtendDB->setData(array('goods_id' => $goods_id,'category_id' => $catId));
							$cateExtendDB->add();
						}
					}

					//处理商品图片
					if($uploadImg)
					{
						$imgArray = array();
						foreach($uploadImg as $temp)
						{
							$imgArray[] = $temp['img'];
						}
						$photoData = $photoDB->query('img in ("'.join('","',$imgArray).'")','id');
						if($photoData)
						{
							foreach($photoData as $item)
							{
								$photoRelationDB->setData(array('goods_id' => $goods_id,'photo_id' => $item['id']));
								$photoRelationDB->add();
							}
						}
					}
				}
			}
		}
		//清理csv文件数据
		IFile::rmdir($uploadCsvDir,true);
		die('<script type="text/javascript">parent.artDialogCallback();</script>');
	}
}