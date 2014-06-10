<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>后台管理</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" href="<?php echo IUrl::creatUrl("")."views/".$this->theme."/skin/".$this->skin."/css/admin.css";?>" />
	<link rel="shortcut icon" href="favicon.ico" />
	<script type="text/javascript" charset="UTF-8" src="/php/iwebshop/runtime/yixun/systemjs/jquery/jquery-1.9.0.min.js"></script><script type="text/javascript" charset="UTF-8" src="/php/iwebshop/runtime/yixun/systemjs/jquery/jquery-migrate-1.2.1.min.js"></script>
	<script type="text/javascript" charset="UTF-8" src="/php/iwebshop/runtime/yixun/systemjs/artdialog/artDialog.js"></script><script type="text/javascript" charset="UTF-8" src="/php/iwebshop/runtime/yixun/systemjs/artdialog/plugins/iframeTools.js"></script><link rel="stylesheet" type="text/css" href="/php/iwebshop/runtime/yixun/systemjs/artdialog/skins/default.css" />
	<script type="text/javascript" charset="UTF-8" src="/php/iwebshop/runtime/yixun/systemjs/form/form.js"></script>
	<script type="text/javascript" charset="UTF-8" src="/php/iwebshop/runtime/yixun/systemjs/autovalidate/validate.js"></script><link rel="stylesheet" type="text/css" href="/php/iwebshop/runtime/yixun/systemjs/autovalidate/style.css" />
	<script type="text/javascript" charset="UTF-8" src="/php/iwebshop/runtime/yixun/systemjs/artTemplate/artTemplate.js"></script><script type="text/javascript" charset="UTF-8" src="/php/iwebshop/runtime/yixun/systemjs/artTemplate/artTemplate-plugin.js"></script>
	<script type='text/javascript' src="<?php echo IUrl::creatUrl("")."views/".$this->theme."/javascript/common.js";?>"></script>
	<script type='text/javascript' src="<?php echo IUrl::creatUrl("")."views/".$this->theme."/javascript/admin.js";?>"></script>
	<script type='text/javascript' src="<?php echo IUrl::creatUrl("")."views/".$this->theme."/javascript/menu.js";?>"></script>
</head>
<body>
	<div class="container">
		<div id="header">
			<div class="logo">
				<a href="<?php echo IUrl::creatUrl("/system/default");?>"><img src="<?php echo IUrl::creatUrl("")."views/".$this->theme."/skin/".$this->skin."/images/admin/logo.gif";?>" width="303" height="43" /></a>
			</div>
			<div id="menu">
				<ul name="menu">
				</ul>
			</div>
			<p><a href="<?php echo IUrl::creatUrl("/systemadmin/logout");?>">退出管理</a> <a href="<?php echo IUrl::creatUrl("/system/default");?>">后台首页</a> <a href="<?php echo IUrl::creatUrl("");?>" target='_blank'>商城首页</a> <span>您好 <label class='bold'><?php echo isset($this->admin['admin_name'])?$this->admin['admin_name']:"";?></label>，当前身份 <label class='bold'><?php echo isset($this->admin['admin_role_name'])?$this->admin['admin_role_name']:"";?></label></span></p>
		</div>
		<div id="info_bar">
			<label class="navindex"><a href="<?php echo IUrl::creatUrl("/system/navigation");?>">快速导航管理</a></label>
			<span class="nav_sec">
			<?php $adminId = $this->admin['admin_id']?>
			<?php $query = new IQuery("quick_naviga");$query->where = "admin_id = $adminId and is_del = 0";$items = $query->find(); foreach($items as $key => $item){?>
			<a href="<?php echo isset($item['url'])?$item['url']:"";?>" class="selected"><?php echo isset($item['naviga_name'])?$item['naviga_name']:"";?></a>
			<?php }?>
			</span>
		</div>

		<div id="admin_left">
			<ul class="submenu"></ul>
			<div id="copyright"></div>
		</div>

		<div id="admin_right">
			<div class="headbar">
	<div class="position"><span>商品</span><span>></span><span>商品管理</span><span>></span><span>商品列表</span></div>
	<div class="operating">
		<div class="search f_r">
			<form name="searchModForm" action="<?php echo IUrl::creatUrl("/");?>" method="get">
				<input type='hidden' name='controller' value='goods' />
				<input type='hidden' name='action' value='goods_list' />
				<select class="auto" name="search[name]">
					<option value="goodsName">商品名</option>
					<option value="goodsNo">商品货号</option>
				</select>
				<input class="small" name="search[keywords]" type="text" value="" />
				<button class="btn" type="submit"><span class="sch">搜 索</span></button>
			</form>
		</div>
		<a href="javascript:void(0);"><button class="operating_btn" type="button" onclick="window.location.href='<?php echo IUrl::creatUrl("/goods/goods_edit");?>'"><span class="addition">添加商品</span></button></a>
		<a href="javascript:void(0);"><button class="operating_btn" type="button" onclick="selectAll('id[]')"><span class="sel_all">全选</span></button></a>
		<a href="javascript:void(0);"><button class="operating_btn" type="button" onclick="goods_del()"><span class="delete">批量删除</span></button></a>
		<a href="javascript:void(0);"><button class="operating_btn" type="button" onclick="goods_stats('up')"><span class="import">批量上架</span></button></a>
		<a href="javascript:void(0);"><button class="operating_btn" type="button" onclick="goods_stats('down')"><span class="export">批量下架</span></button></a>
		<a href="javascript:void(0);"><button class="operating_btn" type="button" onclick="importCsvPacket();"><span class="combine">CSV商品导入</span></button></a>
		<a href="javascript:void(0);"><button class="operating_btn" type="button" onclick="goodsCollect();"><span class="export">商品采集器</span></button></a>
		<a href="javascript:void(0);"><button class="operating_btn" type="button" onclick="window.location.href='<?php echo IUrl::creatUrl("/goods/goods_recycle_list");?>'"><span class="recycle">回收站</span></button></a>
	</div>

	<div class="searchbar">
		<form action="<?php echo IUrl::creatUrl("/");?>" method="get" name="searchListForm">
			<input type='hidden' name='controller' value='goods' />
			<input type='hidden' name='action' value='goods_list' />
			<select class="auto" name="search[category_id]">
				<option value="">选择分类</option>
				<?php $query = new IQuery("category");$items = $query->find(); foreach($items as $key => $item){?>
				<option value="<?php echo isset($item['id'])?$item['id']:"";?>"><?php echo isset($item['name'])?$item['name']:"";?></option>
				<?php }?>
			</select>
			<select class="auto" name="search[is_del]">
				<option value="">选择上下架</option>
				<option value="0">上架</option>
				<option value="2">下架</option>
			</select>
			<select class="auto" name="search[store_nums]">
				<option value="">选择库存</option>
				<option value="1">无货</option>
				<option value="10">低于10</option>
				<option value="100">10-100</option>
				<option value="101">100以上</option>
			</select>
			<select class="auto" name="search[commend_id]">
				<option value="">选择商品标签</option>
				<option value="1">最新商品</option>
				<option value="2">特价商品</option>
				<option value="3">热卖商品</option>
				<option value="4">推荐商品</option>
			</select>
			<button class="btn" type="submit"><span class="sel">筛 选</span></button>
		</form>
	</div>

	<div class="field">
		<table class="list_table">
			<col width="40px" />
			<col width="400px" />
			<col width="120px" />
			<col width="70px" />
			<col width="70px" />
			<col width="70px" />
			<col width="80px" />
			<col width="70px" />
			<col width="70px" />
			<col />
			<thead>
				<tr>
					<th>选择</th>
					<th>商品名称</th>
					<th>分类</th>
					<th>销售价</th>
					<th>库存</th>
					<th>上架</th>
					<th>品牌</th>
					<th>重量</th>
					<th>排序</th>
					<th>操作</th>
				</tr>
			</thead>
		</table>
	</div>
</div>

<form action="" method="post" name="orderForm">
	<div class="content">
		<table class="list_table">
			<col width="40px" />
			<col width="400px" />
			<col width="120px" />
			<col width="70px" />
			<col width="70px" />
			<col width="70px" />
			<col width="80px" />
			<col width="70px" />
			<col width="70px" />
			<col />
			<tbody>
				<?php foreach($this->goodsHandle->find() as $key => $item){?>
				<tr>
					<td><input name="id[]" type="checkbox" value="<?php echo isset($item['id'])?$item['id']:"";?>" /></td>
					<td><img src='<?php echo IUrl::creatUrl("")."$item[img]";?>' style='width:20px;' /><a href="<?php echo IUrl::creatUrl("/site/products/id/$item[id]");?>" target="_blank" title="<?php echo isset($item['name'])?$item['name']:"";?>"><?php echo isset($item['name'])?$item['name']:"";?></a></td>
					<td>
					<?php $catName = array()?>
					<?php $query = new IQuery("category_extend as ce");$query->join = "left join category as cd on cd.id = ce.category_id";$query->fields = "cd.name";$query->where = "goods_id = $item[id]";$items = $query->find(); foreach($items as $key => $catData){?>
						<?php $catName[] = $catData['name']?>
					<?php }?>
					<?php echo join(',',$catName);?>
					</td>
					<td><?php echo isset($item['sell_price'])?$item['sell_price']:"";?></td>
					<td><?php echo isset($item['store_nums'])?$item['store_nums']:"";?></td>
					<td><?php echo $item['is_del']==0?'是':'否';?></td>
					<td><?php echo isset($item['brand_name'])?$item['brand_name']:"";?></td>
					<td><?php echo isset($item['weight'])?$item['weight']:"";?></td>
					<td><?php echo isset($item['sort'])?$item['sort']:"";?></td>
					<td>
						<a href="<?php echo IUrl::creatUrl("/goods/goods_edit/id/$item[id]");?>"><img class="operator" src="<?php echo IUrl::creatUrl("")."views/".$this->theme."/skin/".$this->skin."/images/admin/icon_edit.gif";?>" alt="编辑" /></a>
						<a href="javascript:void(0)" onclick="delModel({link:'<?php echo IUrl::creatUrl("/goods/goods_del/id/$item[id]");?>'})" ><img class="operator" src="<?php echo IUrl::creatUrl("")."views/".$this->theme."/skin/".$this->skin."/images/admin/icon_del.gif";?>" alt="删除" /></a>
					</td>
				</tr>
				<?php }?>
			</tbody>
		</table>
	</div>
</form>

<?php echo $this->goodsHandle->getPageBar();?>

<script type="text/javascript">
//DOM加载
$(function(){
	<?php if($this->search){?>
	var searchData = <?php echo JSON::encode($this->search);?>;
	for(var index in searchData)
	{
		$('[name="search['+index+']"]').val(searchData[index]);
	}
	<?php }?>
});

//csv导入ui框
function importCsvPacket()
{
	art.dialog.open('<?php echo IUrl::creatUrl("/goods/csvImport");?>',{
		id:'csvImport',
	    title:'导入csv商品数据包',
	    okVal:'开始导入',
	    ok:function(iframeWin, topWin){
	    	var formObject = iframeWin.document.forms[0];
	    	formObject.onsubmit();
	    	loadding();
	    	return false;
	    }
	});
}

//upload csv file callback
function artDialogCallback(message)
{
	if(message)
	{
		alert(message);
		return;
	}
	window.location.reload();
}

//删除
function goods_del()
{
	var flag = 0;
	$('input:checkbox[name="id[]"]:checked').each(function(i){flag = 1;});
	if(flag == 0)
	{
		alert('请选择要删除的数据');
		return false;
	}
	$("form[name='orderForm']").attr('action','<?php echo IUrl::creatUrl("/goods/goods_del");?>');
	confirm('确定要删除所选中的信息吗？','formSubmit(\'orderForm\')');
}

//上下架操作
function goods_stats(type)
{
	if($('input:checkbox[name="id[]"]:checked').length > 0)
	{
		$("form[name='orderForm']").attr('action','<?php echo IUrl::creatUrl("/goods/goods_stats/type/");?>'+type);
		confirm('确定将选中的商品进行操作吗？',"formSubmit('orderForm')");
	}
	else
	{
		alert('请选择要操作的商品!');
		return false;
	}
}

//商品采集器界面
function goodsCollect()
{
	art.dialog.open('<?php echo IUrl::creatUrl("/goods/collect_import");?>',{
		id:'collect_import',
	    title:'商品采集器',
	    okVal:'开始采集',
	    ok:function(iframeWin, topWin){
	    	var formObject = iframeWin.document.forms[0];
	    	formObject.submit();
	    	loadding();
	    	return false;
	    }
	});
}
</script>

		</div>
		<div id="separator"></div>
	</div>

	<script type='text/javascript'>
		//DOM加载完毕执行
		$(function(){
			//隔行换色
			$(".list_table tr:nth-child(even)").addClass('even');
			$(".list_table tr").hover(
				function () {
					$(this).addClass("sel");
				},
				function () {
					$(this).removeClass("sel");
				}
			);

			//后台菜单创建
			<?php $menu = new Menu();?>
			var data = <?php echo $menu->submenu();?>;
			var current = '<?php echo $menu->current;?>';
			var url='<?php echo IUrl::creatUrl("/");?>';
			initMenu(data,current,url);
		});
	</script>
</body>
</html>
