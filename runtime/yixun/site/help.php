<?php 
	$myCartObj  = new Cart();
	$myCartInfo = $myCartObj->getMyCart();
	$siteConfig = new Config("site_config");
	$callback   = IReq::get('callback') ? urlencode(IFilter::act(IReq::get('callback'),'url')) : '';
?>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title><?php echo $siteConfig->name;?></title>
	<link type="image/x-icon" href="favicon.ico" rel="icon">
	<link rel="stylesheet" href="<?php echo IUrl::creatUrl("")."views/".$this->theme."/static/css/base.css";?>">
	<link rel="stylesheet" href="<?php echo IUrl::creatUrl("")."views/".$this->theme."/static/css/flexslider.css";?>">
</head>
<body>
<!--ToolBar-->
	<div class="g_toolBar">
		<div class="g_wrap">
			<div class="quick_link">
			<?php if($this->user){?>
				<span class="toolBarWelcome">
			<?php echo $this->user['username'];?>您好，欢迎您来到<?php echo $siteConfig->name;?>购物！
			</span>
			<i class="toolBar_gap">|</i>
			<a href="<?php echo IUrl::creatUrl("/simple/logout");?>">安全退出</a>
			<?php }else{?>
				<i class="toolBar_gap">|</i>
				<a href="<?php echo IUrl::creatUrl("/simple/login?callback=$callback");?>" class="toolBar_login">请登录</a>
				<i class="toolBar_gap">|</i>
				<a href="<?php echo IUrl::creatUrl("/simple/reg?callback=$callback");?>" class="toolBar_reg">免费注册</a>
			<?php }?>	
			</div>
			<div class="tool_link">
				<ul class="mod_tool_ul">
					<li class="mod_tool_li mod_dropmenu">
						<div class="mod_dropmenu_hd">
							<a href="<?php echo IUrl::creatUrl("/ucenter/order");?>" class="mod_dropmenu_tit">我的订单&nbsp;</a>
							<i class="mod_dropmenu_arrow"></i>
						</div>
						<div class="mod_dropmenu_pop">
							<div class="mod_iorder_unlogin">
								<a href="<?php echo IUrl::creatUrl("/simple/login?callback=$callback");?>">登录</a> 后查看最近的订单信息
							</div>
						</div>
					</li>
					<li class="toolBar_gap"></li>
					<li class="mod_tool_li mod_dropmenu">
						<div class="mod_dropmenu_hd">
							<a href="" class="mod_dropmenu_tit">用户中心&nbsp;</a>
							<i class="mod_dropmenu_arrow"></i>
						</div>
						<div class="mod_dropmenu_down">
							<ul>
								<li><a href="">我的收藏</a></li>
								<li><a href="">账户管理</a></li>
								<li><a href="">商品评价</a></li>
								<li><a href="">我的留言</a></li>
								<li><a href="">到货提醒</a></li>
								<li><a href="">降价通知</a></li>
							</ul>
						</div>
					</li>
					<li class="toolBar_gap"></li>
					<li class="mod_tool_li">
						<div class="mod_dropmenu_hd">
							<a href="" class="mod_dropmenu_tit">在线客服</a>
						</div>
					</li>
					<li class="toolBar_gap"></li>
					<li class="mod_tool_li mod_dropmenu">
						<div class="mod_dropmenu_hd">
							<a href="" class="mod_dropmenu_tit">服务中心&nbsp;</a>
							<i class="mod_dropmenu_arrow"></i>
						</div>
						<div class="mod_dropmenu_down">
							<ul>
								<li><a href="<?php echo IUrl::creatUrl("/ucenter/refunds");?>">我的退换货</a></li>
								<li><a href="<?php echo IUrl::creatUrl("/ucenter/complain");?>">投诉/建议</a></li>
								<li><a href="<?php echo IUrl::creatUrl("/site/help/id/53");?>">支付帮助</a></li>
							</ul>
						</div>
					</li>
					<li class="toolBar_gap"></li>
					<li class="mod_tool_li">
						<div class="mod_dropmenu_hd">
							<a href="" class="mod_dropmenu_tit">商家入驻</a>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<!--Header-->
	<div class="g_header">
		<div class="g_wrap">
			<div class="mod_logo">
				<h1>
					<a href=""><img src="<?php echo IUrl::creatUrl("")."views/".$this->theme."/static/images/logo.png";?>" alt=""></a>
				</h1>
			</div>
			<div class="search_cart_wrap">
				<div class="mod_search">
					<form action="">
						<input type="text" class="mod_search_con" autocomplete="off" x-webkit-speech x-webkit-grammar="builtin:search">
						<input type="submit" class="mod_search_btn" value="搜索">
					</form>
				</div>
				<div class="mod_minicart">
					<div class="mod_minicart_con">
						<a href="">
							<i class="mod_minicart_ico">&nbsp;</i>
							<span class="mod_minicart_tit">购物车</span>
						</a>
						<i class="mod_minicart_gap">|</i>
						<span class="mod_minicart_num"><?php echo isset($myCartInfo['count'])?$myCartInfo['count']:"";?></span>
						<b class="mod_minicart_arrow"><i></i></b>
					</div>
					<div class="mod_minicart_pop mod_minicart_pop_nil">
						<i class="mod_minicart_pop_bod"></i>
						<div class="mod_minicart_pop_inner">
							<div class="mod_minicart_empty">
								<p>您的购物车是空的<br>如您已添加商品，请<a href="<?php echo IUrl::creatUrl("/simple/login?callback=$callback");?>">登录</a>查看</p>
							</div>
						</div>
					</div>
				</div>
				
			</div>
		</div>
	</div>
	<!--Navigator-->
	<div class="g_navigator">
		<div class="g_wrap">
			<div class="mod_cate mod_cate_on">
				<div class="mod_cate_hd">
					<div class="mod_cate_hd_con">
						<a href="">全部商品分类</a>
					</div>
					<i class="mod_cate_hd_arrow"></i>
				</div>
				<!--Navigator-categorys-->
				<ul class="mod_cate_bd">
					<li class="mod_cate_li">
						<div class="mod_cate_r1">
							<h3>
								<a href="">手机</a>
								<a href="">数码</a>
							</h3>
						</div>
						<div class="mod_cate_r2">
							<a href="">合约机</a>
							<a href="">智能馆</a>
							<a href="">数码相机</a>
						</div>
					</li>
					<li class="mod_cate_li">
						<div class="mod_cate_r1">
							<h3>
								<a href="">手机</a>
								<a href="">数码</a>
							</h3>
						</div>
						<div class="mod_cate_r2">
							<a href="">合约机</a>
							<a href="">智能馆</a>
							<a href="">数码相机</a>
						</div>
					</li>
					<li class="mod_cate_li">
						<div class="mod_cate_r1">
							<h3>
								<a href="">手机</a>
								<a href="">数码</a>
							</h3>
						</div>
						<div class="mod_cate_r2">
							<a href="">合约机</a>
							<a href="">智能馆</a>
							<a href="">数码相机</a>
						</div>
					</li>
				</ul>
			</div>
			<!--nav-list-->
			<div class="mod_nav">
				<ul class="mod_nav_ul">
					<li class="mod_nav_li">
						<a href="<?php echo IUrl::creatUrl("/site/index");?>">首页</a>
					</li>
					<?php $query = new IQuery("guide");$items = $query->find(); foreach($items as $key => $item){?>
					<li class="mod_nav_li">
						<a href="<?php echo IUrl::creatUrl("$item[link]");?>"><?php echo isset($item['name'])?$item['name']:"";?></a>
					</li>
					<?php }?>
				</ul>
			</div>
		</div>
	</div>
	<!--footer-->
	<div class="g_market">
		<div class="g_wrap">
			<a href="" class="market_link">
				<img src="<?php echo IUrl::creatUrl("")."views/".$this->theme."/static/images/market.jpg";?>" alt="">
			</a>
		</div>
	</div>
	<div class="g_footer">
		<div class="footer_inner">
			<div class="mod_help">
			<?php $query = new IQuery("help_category");$query->where = "position_foot = 1";$query->order = "sort ASC,id desc";$query->limit = "6";$items = $query->find(); foreach($items as $key => $helpCat){?>
				<div class="mod_help_item">
					<h5><a href="<?php echo IUrl::creatUrl("/site/help_list/id/$helpCat[id]");?>"><?php echo isset($helpCat['name'])?$helpCat['name']:"";?></a></h5>
					<ul>
					<?php $query = new IQuery("help");$query->where = "cat_id = $helpCat[id]";$query->order = "sort ASC,id desc";$items = $query->find(); foreach($items as $key => $item){?>
						<li><a href="<?php echo IUrl::creatUrl("/site/help/id/$item[id]");?>"><?php echo isset($item['name'])?$item['name']:"";?></a></li>
					<?php }?>
					</ul>
				</div>
				<?php }?>
			</div>
		</div>
	</div>
	<div class="g_subfooter">
		<div class="g_wrap">
			<div class="sf_p1">
				<a href="" target="_blank">易迅简介</a>
				|
				<a href="" target="_blank">易迅简介</a>
				|
				<a href="" target="_blank">易迅简介</a>
				|
				<a href="" target="_blank">易迅简介</a>
				|
				<a href="" target="_blank">易迅简介</a>
				|
				<a href="" target="_blank">易迅简介</a>
				|
				<a href="" target="_blank">易迅简介</a>
				|
				<a href="" target="_blank">易迅简介</a>
			</div>
			<p class="sf_p2">
				Copyright © 2006 - 2014 易迅版权所有   
				<a href="http://www.miibeian.gov.cn/" target="_blank">沪ICP备06024200号</a>
			</p>
		</div>
	</div>
	<script src="<?php echo IUrl::creatUrl("")."views/".$this->theme."/static/js/lib/seajs/2.2.1/sea.js";?>"></script>
	<script>
		seajs.config({
		  base:'<?php echo IUrl::creatUrl("")."views/".$this->theme."/static/js/";?>',
		  alias: {
		    "jquery": "lib/jquery/1.11.1/jquery.js",
		    "flexslider":"lib/flexslider/jquery.flexslider-min.js"
		  }
		});
		seajs.use('main');
	</script>
</body>
</html>
