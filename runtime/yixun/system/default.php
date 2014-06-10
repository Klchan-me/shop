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
			<div class="content_box" style="border:none">
	<div class="content">
		<?php $safeInstance = new safeStrategy();$checkResult = $safeInstance->check();?>
		<?php if($checkResult){?>
		<ul class="red_box">
		<?php foreach($checkResult as $key => $item){?>
		<li><img src="<?php echo IUrl::creatUrl("")."views/".$this->theme."/skin/".$this->skin."/images/admin/error.gif";?>" /><?php echo isset($item['content'])?$item['content']:"";?></li>
		<?php }?>
		</ul>
		<?php }?>
		<table width="31%" cellspacing="0" cellpadding="5" class="border_table_org" style="float:left">
			<thead>
				<tr><th>系统信息</th></tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<table class="list_table2" width="100%">
							<colgroup>
								<col width="80px" />
								<col />
							</colgroup>
							<tbody>
								<tr><th>购买及服务</th><td><a href='http://wpa.qq.com/msgrd?V=1&Uin=846327344&Menu=yes' target='_blank'><b class='red3'>联系我们</b></a></td></tr>
								<tr><th>当前版本号</th><td><?php echo Proxy::getLocalVersion();?></td></tr>
								<tr><th>最新版本号</th><td><?php echo Proxy::getRemoteVersion();?></td></tr>
								<tr><th>官网地址</th><td><a href='http://www.jooyea.cn' target='_blank'><b class='red3'>www.jooyea.cn</b></a></td></tr>
								<tr><th>服务器软件</th><td><?php echo isset($_SERVER['SERVER_SOFTWARE'])?$_SERVER['SERVER_SOFTWARE']:"";?></td></tr>
								<tr><th>附件上传容量</th><td><?php echo IUpload::getMaxSize();?></td></tr>
								<tr><th>授权信息</th><td><?php if(Proxy::getAuthorize()){?><b class="green">授权商业版本</b><?php }else{?><b class="red2">非授权版本</b><?php }?></td></tr>
							</tbody>
						</table>
					</td>
				</tr>
			</tbody>
		</table>

		<table width="32%" cellspacing="0" cellpadding="5" class="border_table_org" style="float:left">
			<thead>
				<tr><th>网站概况</th></tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<table class="list_table2" width="100%">
							<colgroup>
								<col width="80px" />
								<col />
							</colgroup>
							<tbody>
								<tr><th>销售总额</th><td><?php $query = new IQuery("order");$query->fields = "sum(order_amount) as amount";$query->where = "`status` = 5";$items = $query->find(); foreach($items as $key => $item){?><b class="f14 red3"><?php if(empty($item['amount'])){?>0<?php }else{?><?php echo isset($item['amount'])?$item['amount']:"";?><?php }?></b> 元<?php }?></td></tr>
								<tr><th>今年销售总额</th><td><?php $query = new IQuery("order");$query->fields = "sum(order_amount) as amount";$query->where = "`status` = 5 and YEAR(create_time) = YEAR(now())";$items = $query->find(); foreach($items as $key => $item){?><b class="f14 red3"><?php if(empty($item['amount'])){?>0<?php }else{?><?php echo isset($item['amount'])?$item['amount']:"";?><?php }?></b> 元<?php }?></td></tr>
								<tr><th>客户</th><td><?php $query = new IQuery("user");$query->fields = "count(id) as countNums";$items = $query->find(); foreach($items as $key => $item){?><b class="f14 red3"><?php echo isset($item['countNums'])?$item['countNums']:"";?></b>个<?php }?></td></tr>
								<tr><th>产品</th><td><?php $query = new IQuery("goods");$query->fields = "count(id) as countNums";$query->where = "is_del = 0";$items = $query->find(); foreach($items as $key => $item){?><b class="f14 red3"><?php echo isset($item['countNums'])?$item['countNums']:"";?></b>个<?php }?></td></tr>
								<tr><th>评论</th><td><?php $query = new IQuery("comment");$query->fields = "count(id) as countNums";$items = $query->find(); foreach($items as $key => $item){?><a href="<?php echo IUrl::creatUrl("/comment/comment_list");?>"><b class="red3 f14"><?php echo isset($item['countNums'])?$item['countNums']:"";?></b></a>个<?php }?></td></tr>
								<tr><th>建议</th><td>总共：<?php $query = new IQuery("suggestion");$query->fields = "count(*) as countNums";$items = $query->find(); foreach($items as $key => $item){?><b class='red3 f14'><?php echo isset($item['countNums'])?$item['countNums']:"";?></b>个<?php }?> &nbsp;&nbsp; 未回复：<?php $query = new IQuery("suggestion");$query->where = "re_time is null";$query->fields = "count(*) as countNums";$items = $query->find(); foreach($items as $key => $item){?><a href='<?php echo IUrl::creatUrl("/comment/suggestion_list");?>'><b class="red3 f14"><?php echo isset($item['countNums'])?$item['countNums']:"";?></b></a><?php }?>个</td></tr>
								<tr><th>咨询</th><td>总共：<?php $query = new IQuery("refer");$query->fields = "count(id) as countNums";$items = $query->find(); foreach($items as $key => $item){?><b class="f14 red3"><?php echo isset($item['countNums'])?$item['countNums']:"";?></b>个<?php }?> &nbsp;&nbsp; 未处理：<?php $query = new IQuery("refer");$query->fields = "count(id) as countNums";$query->where = "`status` = 0";$items = $query->find(); foreach($items as $key => $item){?><a href="<?php echo IUrl::creatUrl("/comment/refer_list/status/0");?>"><b class="red3 f14"><?php echo isset($item['countNums'])?$item['countNums']:"";?></b></a><?php }?>个</td></tr>
							</tbody>
						</table>
					</td>
				</tr>
			</tbody>
		</table>

		<table width="33%" cellspacing="0" cellpadding="5" class="border_table_org" style="float:left">
			<thead>
				<tr><th>订单信息</th></tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<table class="list_table2" width="100%">
							<colgroup>
								<col width="80px" />
								<col />
							</colgroup>

							<tbody>
								<tr><th>总订单</th><td colspan="2"><?php $query = new IQuery("order");$query->fields = "count(id) as countNums";$query->where = "if_del = 0";$items = $query->find(); foreach($items as $key => $item){?><b class="f14 red3"><?php echo isset($item['countNums'])?$item['countNums']:"";?></b>个<?php }?></td></tr>
								<tr><th>新订单</th><td><?php $query = new IQuery("order");$query->fields = "count(id) as countNums";$query->where = "status = 1 and if_del = 0";$items = $query->find(); foreach($items as $key => $item){?><b class="f14 red3"><?php echo isset($item['countNums'])?$item['countNums']:"";?></b>个<?php }?></td></tr>
								<tr><th>未付款订单</th><td><?php $query = new IQuery("order");$query->fields = "count(id) as countNums";$query->where = "pay_status = 0 and if_del = 0";$items = $query->find(); foreach($items as $key => $item){?><a href="<?php echo IUrl::creatUrl("/order/order_list/pay_status/0");?>"><b class="f14 red3"><?php echo isset($item['countNums'])?$item['countNums']:"";?></b></a>个<?php }?></td></tr>
								<tr><th>未发货订单</th><td><?php $query = new IQuery("order");$query->fields = "count(id) as countNums";$query->where = "distribution_status = 0 and if_del = 0";$items = $query->find(); foreach($items as $key => $item){?><a href="<?php echo IUrl::creatUrl("/order/order_list/distribution_status/0");?>"><b class="f14 red3"><?php echo isset($item['countNums'])?$item['countNums']:"";?></b></a>个<?php }?></td></tr>
								<tr><th>七天未确认订单</th><td><?php $query = new IQuery("order");$query->fields = "count(id) as countNums";$query->where = "distribution_status = 1 and pay_status = 1 and status = 2 and to_days(now())-to_days(send_time)>7 and if_del = 0";$items = $query->find(); foreach($items as $key => $item){?><b class="f14 red3"><?php echo isset($item['countNums'])?$item['countNums']:"";?></b>个<?php }?></td></tr>
								<tr><th>退款申请</th><td colspan="2"><?php $query = new IQuery("refundment_doc");$query->where = "pay_status = 0";$query->fields = "count(*) as countNums";$items = $query->find(); foreach($items as $key => $item){?><a href="<?php echo IUrl::creatUrl("/order/refundment_list");?>"><b class="red3 f14"><?php echo isset($item['countNums'])?$item['countNums']:"";?></b></a>个<?php }?></td></tr>
								<tr><th>完成订单</th><td><?php $query = new IQuery("order");$query->fields = "count(id) as countNums";$query->where = "`status` = 5 and if_del = 0";$items = $query->find(); foreach($items as $key => $item){?><a href="<?php echo IUrl::creatUrl("/order/order_list/status/5");?>"><b class="f14 red3"><?php echo isset($item['countNums'])?$item['countNums']:"";?></b></a>个<?php }?></td></tr>
							</tbody>
						</table>
					</td>
				</tr>
			</tbody>
		</table>

		<table width="98%" cellspacing="0" cellpadding="0" class="border_table_org" style="float:left">
			<thead>
				<tr><th>最新10条订单</th></tr>
			</thead>
			<tbody>
				<tr>
					<td style="padding:5px 0">
						<table class="list_table3" width="100%">
							<thead>
								<th>订单号</th>
								<th>收货人</th>
								<th>支付状态</th>
								<th>金额</th>
								<th>下单时间</th>
								<th>操作</th>
							</thead>
							<tbody>
							<?php $query = new IQuery("order as o");$query->join = "left join delivery as d on o.distribution = d.id left join payment as p on o.pay_type = p.id left join user as u on u.id = o.user_id";$query->fields = "o.id as oid,d.name as dname,p.name as pname,o.order_no,o.accept_name,o.pay_status,o.distribution_status,u.username,o.create_time,o.status,o.if_print,o.order_amount";$query->where = "o.status < 3 and if_del = 0";$query->order = "o.id desc";$query->limit = "10";$items = $query->find(); foreach($items as $key => $item){?>
							<tr>
								<td><?php echo isset($item['order_no'])?$item['order_no']:"";?></td>
								<td><b><?php echo isset($item['accept_name'])?$item['accept_name']:"";?></b></td>
								<td><?php if($item['pay_status']==0){?>未付款<?php }elseif($item['pay_status']==1){?><b>已付款</b><?php }elseif($item['pay_status']==2){?>退款完成<?php }else{?><span class="red"><b>申请退款</b></span><?php }?></td>
								<td><b class="red3">￥<?php echo isset($item['order_amount'])?$item['order_amount']:"";?></b></td>
								<td><?php echo isset($item['create_time'])?$item['create_time']:"";?></td>
								<td>
									<a href="<?php echo IUrl::creatUrl("/order/order_show/id/$item[oid]");?>"><img class="operator" src="<?php echo IUrl::creatUrl("")."views/".$this->theme."/skin/".$this->skin."/images/admin/icon_check.gif";?>" title="查看" /></a>
									<?php if($item['status']<3){?>
									<a href="<?php echo IUrl::creatUrl("/order/order_edit/id/$item[oid]");?>"><img class="operator" src="<?php echo IUrl::creatUrl("")."views/".$this->theme."/skin/".$this->skin."/images/admin/icon_edit.gif";?>" title="编辑"/></a>
									<?php }?>
									<a href="javascript:void(0)" onclick="delModel({link:'<?php echo IUrl::creatUrl("/order/order_del/id/$item[oid]");?>'})" ><img class="operator" src="<?php echo IUrl::creatUrl("")."views/".$this->theme."/skin/".$this->skin."/images/admin/icon_del.gif";?>" title="删除"/></a>
								</td>
							</tr>
							<?php }?>
							</tbody>
						</table>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
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
