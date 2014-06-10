<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>管理后台</title>
<link rel="stylesheet" href="<?php echo IUrl::creatUrl("")."views/".$this->theme."/skin/".$this->skin."/css/admin.css";?>" />
<script type="text/javascript" charset="UTF-8" src="/php/iwebshop/runtime/yixun/systemjs/jquery/jquery-1.9.0.min.js"></script><script type="text/javascript" charset="UTF-8" src="/php/iwebshop/runtime/yixun/systemjs/jquery/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript" charset="UTF-8" src="/php/iwebshop/runtime/yixun/systemjs/artdialog/artDialog.js"></script><script type="text/javascript" charset="UTF-8" src="/php/iwebshop/runtime/yixun/systemjs/artdialog/plugins/iframeTools.js"></script><link rel="stylesheet" type="text/css" href="/php/iwebshop/runtime/yixun/systemjs/artdialog/skins/default.css" />
<script type="text/javascript" charset="UTF-8" src="/php/iwebshop/runtime/yixun/systemjs/form/form.js"></script>
<script type="text/javascript" charset="UTF-8" src="/php/iwebshop/runtime/yixun/systemjs/autovalidate/validate.js"></script><link rel="stylesheet" type="text/css" href="/php/iwebshop/runtime/yixun/systemjs/autovalidate/style.css" />
<script type="text/javascript" charset="UTF-8" src="/php/iwebshop/runtime/yixun/systemjs/artTemplate/artTemplate.js"></script><script type="text/javascript" charset="UTF-8" src="/php/iwebshop/runtime/yixun/systemjs/artTemplate/artTemplate-plugin.js"></script>
<script type='text/javascript' src="<?php echo IUrl::creatUrl("")."views/".$this->theme."/javascript/admin.js";?>"></script>
</head>

<body style="width:500px;">
	<div class="pop_win">
		<ul class="red_box">
			<li>1、要采集的URL必须符合一定的规范，必须为商品最小分类的商品列表页面，比如：<a href="http://list.jd.com/1318-1464-1488-0-0-0-0-0-0-0-1-1-1-1-1-72-4137-0.html" class="blue">点击此处</a></li>
			<li>2、采集内容包括给定URL中的商品分类，商品模型，具体商品详情</li>
			<li>3、在线商品数据采集，由于包括图片的下载，所以对网速要求比较高，需要耐心等待</li>
		</ul>

		<form action='<?php echo IUrl::creatUrl("/goods/collect_goods");?>' method='post'>
			<table class="form_table" width="90%" cellspacing="0" cellpadding="0" border="0">
				<col width="120px" />
				<col />

				<tbody>
					<tr>
						<td>采集器：</td>
						<td>
							<select name='collect_name' class='auto' pattern='required'>
								<option value='jd'>京东商城采集器</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>采集URL地址：</td>
						<td>
							<input type='text' name='url' class='normal' pattern='url' value='' /><br />
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
</body>
</html>