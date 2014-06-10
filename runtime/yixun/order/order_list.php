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
	<div class="position">订单<span>></span><span>订单管理</span><span>></span><span>订单列表</span></div>
	<div class="operating">
		<div class="search f_r">
			<form name="serachuser" action="<?php echo IUrl::creatUrl("/");?>" method="get">
				<input type='hidden' name='controller' value='order' />
				<input type='hidden' name='action' value='order_list' />
				用户名：<input class="small" name="name" type="text" value="<?php echo isset($name)?$name:"";?>" />
				订单号：<input class="small" name="order_no" type="text" value="<?php echo isset($order_no)?$order_no:"";?>" />
				<button class="btn" type="submit"><span class="sch">搜 索</span></button>
			</form>
		</div>
		<a href="javascript:void(0);"><button class="operating_btn" type="button" onclick="window.location='<?php echo IUrl::creatUrl("/order/order_edit");?>'"><span class="addition">添加订单</span></button></a>
		<a href="javascript:void(0);" onclick="selectAll('id[]')"><button class="operating_btn" type="button"><span class="sel_all">全选</span></button></a>
		<a href="javascript:void(0);" onclick="delModel({form:'orderForm'})"><button class="operating_btn" type="button"><span class="delete">批量删除</span></button></a>
		<a href="javascript:void(0);" onclick="$('#orderForm').attr('action','<?php echo IUrl::creatUrl("/order/expresswaybill_template");?>');$('#orderForm').submit();"><button class="operating_btn"><span class="export">批量打印快递单</span></button></a>
		<a href="javascript:void(0);"><button class="operating_btn" onclick="location.href='<?php echo IUrl::creatUrl("/order/print_template");?>'"><span class="export">单据模板</span></button></a>
		<a href="javascript:void(0);"><button class="operating_btn" type="button" onclick="location.href='<?php echo IUrl::creatUrl("/order/order_recycle_list");?>'"><span class="recycle">回收站</span></button></a>
	</div>
	<div class="searchbar">
		<form action="<?php echo IUrl::creatUrl("/");?>" method="get" name="order_list">
			<input type='hidden' name='controller' value='order' />
			<input type='hidden' name='action' value='order_list' />

			<select name="pay_status" class="auto">
				<option value="">选择支付状态</option>
				<option value="0">未支付</option>
				<option value="1">已支付</option>
				<option value="2">退款成功</option>
			</select>

			<select name="distribution_status" class="auto">
				<option value="">选择发货状态</option>
				<option value="0">未发货</option>
				<option value="1">已发货</option>
				<option value="2">退货成功</option>
			</select>

			<select name="status" class="auto">
				<option value="">选择订单状态</option>
				<option value="1">新订单</option>
				<option value="2">确认订单</option>
				<option value="3">取消订单</option>
				<option value="4">作废订单</option>
				<option value="5">完成订单</option>
			</select>
			<button class="btn" type="submit"><span class="sel">筛 选</span></button>
		</form>
	</div>
	<div class="field">
		<table class="list_table">
			<col width="30px" />
			<col width="155px" />
			<col width="75px" />
			<col width="75px" />
			<col width="75px" />
			<col width="75px" />
			<col width="105px" />
			<col width="80px" />
			<col />
			<thead>
				<tr>
					<th class="t_c">选择</th>
					<th>订单号</th>
					<th>收货人</th>
					<th>支付状态</th>
					<th>发货状态</th>
					<th>配送方式</th>
					<th>打印</th>
					<th>支付方式</th>
					<th>用户名</th>
					<th>下单时间</th>
					<th>操作</th>
				</tr>
			</thead>
		</table>
	</div>
</div>

<form name="orderForm" id="orderForm" action="<?php echo IUrl::creatUrl("/order/order_del");?>" method="post">
	<div class="content">
		<table class="list_table">
			<col width="30px" />
			<col width="155px" />
			<col width="75px" />
			<col width="75px" />
			<col width="75px" />
			<col width="75px" />
			<col width="105px" />
			<col width="80px" />
			<col />
			<tbody>
				<?php $page= (isset($_GET['page'])&&(intval($_GET['page'])>0))?intval($_GET['page']):1;?>
				<?php $query = new IQuery("order as o");$query->join = "left join delivery as d on o.distribution = d.id left join payment as p on o.pay_type = p.id left join user as u on u.id = o.user_id";$query->fields = "o.id as oid,d.name as dname,o.pay_type,p.name as pname,o.order_no,o.accept_name,o.pay_status,o.distribution_status,u.username,o.create_time,o.status,o.if_print";$query->where = "if_del = 0 $where";$query->order = "o.id desc";$query->page = "$page";$items = $query->find(); foreach($items as $key => $item){?>
				<tr>
					<td class="t_c"><input name="id[]" type="checkbox" value="<?php echo isset($item['oid'])?$item['oid']:"";?>" /></td>
					<td title="<?php echo isset($item['order_no'])?$item['order_no']:"";?>"><?php echo isset($item['order_no'])?$item['order_no']:"";?></td>
					<td title="<?php echo isset($item['accept_name'])?$item['accept_name']:"";?>"><?php echo isset($item['accept_name'])?$item['accept_name']:"";?></td>
					<td><?php if($item['pay_status']==0){?>未付款<?php }elseif($item['pay_status']==1){?><b class='green'>已付款</b><?php }elseif($item['pay_status']==2){?>退款完成<?php }else{?><span class="red"><b>申请退款</b></span><?php }?></td>
					<td><?php if($item['status'] == 5){?><b class='green'>已收货</b><?php }elseif($item['distribution_status']==1){?><b class='green'>已发货</b><?php }else{?>未发货<?php }?></td>
					<td title="<?php echo isset($item['dname'])?$item['dname']:"";?>"><?php echo isset($item['dname'])?$item['dname']:"";?></td>
					<td>
						<span class="<?php echo strpos($item['if_print'],'shop') === false ? 'prt':'prted';?>" title="购物清单打印" onclick="window.open('<?php echo IUrl::creatUrl("/order/shop_template/id/$item[oid]");?>');">购</span>
						<span class="<?php echo strpos($item['if_print'],'pick') === false ? 'prt':'prted';?>" title="配货单打印" onclick="window.open('<?php echo IUrl::creatUrl("/order/pick_template/id/$item[oid]");?>');">配</span>
						<span class="<?php echo strpos($item['if_print'],'merge') === false ? 'prt':'prted';?>" title="联合打印" onclick="window.open('<?php echo IUrl::creatUrl("/order/merge_template/id/$item[oid]");?>');">合</span>
						<span class="<?php echo strpos($item['if_print'],'express') === false ? 'prt':'prted';?>" title="快递单打印" onclick="window.open('<?php echo IUrl::creatUrl("/order/expresswaybill_template/id/$item[oid]");?>');">递</span>
					</td>
					<td title="<?php if($item['pay_type']==0){?>货到付款<?php }else{?><?php echo isset($item['pname'])?$item['pname']:"";?><?php }?>"><?php if($item['pay_type']==0){?>货到付款<?php }else{?><?php echo isset($item['pname'])?$item['pname']:"";?><?php }?></td>
					<td title="<?php echo $item['username']=='' ? '游客' : $item['username'];?>"><?php echo $item['username']=='' ? '游客' : $item['username'];?></td>
					<td title="<?php echo isset($item['create_time'])?$item['create_time']:"";?>"><?php echo isset($item['create_time'])?$item['create_time']:"";?></td>
					<td><a href="<?php echo IUrl::creatUrl("/order/order_show/id/$item[oid]");?>"><img class="operator" src="<?php echo IUrl::creatUrl("")."views/".$this->theme."/skin/".$this->skin."/images/admin/icon_check.gif";?>" title="查看" /></a><?php if($item['status']<3){?><a href="<?php echo IUrl::creatUrl("/order/order_edit/id/$item[oid]");?>"><img class="operator" src="<?php echo IUrl::creatUrl("")."views/".$this->theme."/skin/".$this->skin."/images/admin/icon_edit.gif";?>" title="编辑"/></a><?php }else{?>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php }?><a href="javascript:void(0)" onclick="delModel({link:'<?php echo IUrl::creatUrl("/order/order_del/id/$item[oid]");?>'})" ><img class="operator" src="<?php echo IUrl::creatUrl("")."views/".$this->theme."/skin/".$this->skin."/images/admin/icon_del.gif";?>" title="删除"/></a></td>
				</tr>
				<?php }?>
			</tbody>
		</table>
	</div>
	<?php echo $query->getPageBar();?>
</form>

<script type='text/javascript'>
//DOM加载结束
$(function(){
	var formInstance = new Form('order_list');
	formInstance.init({
		"pay_status":"<?php echo isset($pay_status)?$pay_status:"";?>",
		"distribution_status":"<?php echo isset($distribution_status)?$distribution_status:"";?>",
		"status":"<?php echo isset($status)?$status:"";?>"
	});
});
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
