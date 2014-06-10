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
				<span class="toolBarWelcome">你好，欢迎您来到<?php echo $siteConfig->name;?>购物！</span>
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
	<?php 
	$site_config=new Config('site_config');
	$seo_data=array();
	$seo_data['title']=$site_config->name;
	$seo_data['title'].=$site_config->index_seo_title;
	$seo_data['keywords']=$site_config->index_seo_keywords;
	$seo_data['description']=$site_config->index_seo_description;
	seo::set($seo_data);
?>
<!--g_content-->
	<div class="g_content">
		<div class="g_wrap">
			<div class="g_s"></div>
			<div class="g_m" id="main_slider">
				<!--Banner_Slide-->
				<div class="main_silder">
					<div class="flexslider">
					<?php if($this->index_slide){?>
			          <ul class="slides">
			          <?php foreach($this->index_slide as $key => $item){?>
			            <li title="<?php echo isset($item['name'])?$item['name']:"";?>">
			            <a href="<?php echo IUrl::creatUrl("$item[url]");?>" target="_blank">
			           		 <img src="<?php echo IUrl::creatUrl("")."$item[img]";?>" alt="<?php echo isset($item['name'])?$item['name']:"";?>">
			            </a></li>
			           <?php }?>
			          </ul>
			          <?php }?>
	       			</div>
				</div>
				<!--Banner_Push-->
				<div class="main_push">
					<ul class="main_push_goods">
					<?php $query = new IQuery("commend_goods as co");$query->join = "left join goods as go on co.goods_id = go.id";$query->where = "co.commend_id = 3 and go.is_del = 0 AND go.id is not null";$query->fields = "go.img,go.sell_price,go.name,go.id,FORMAT((go.market_price-go.sell_price),0) as diffPrice";$query->limit = "8";$query->order = "sort asc,id desc";$items = $query->find(); foreach($items as $key => $item){?>
					<?php $tmpId=$item['id']?>
						<li>
							<div class="mod_goods mod_goods_w100">
								<div class="mod_goods_img">
									<a href="<?php echo IUrl::creatUrl("/site/products/id/$tmpId");?>">
										<img src="<?php echo IUrl::creatUrl("")."";?><?php echo Thumb::get($item['img'],85,85);?>" alt="<?php echo isset($item['name'])?$item['name']:"";?>">
										<b class="mod_goods_mark_1">已降<br><?php echo isset($item['diffPrice'])?$item['diffPrice']:"";?>元</b>
									</a>
								</div>
								<div class="mod_goods_info">
									<p class="mod_goods_tit">
										<a href=""><?php echo isset($item['name'])?$item['name']:"";?></a>
									</p>
									<p class="mod_goods_price">
										<a href="">
											<span class="mod_price mod_price_now">
												<i>¥</i>
												<span><?php echo isset($item['sell_price'])?$item['sell_price']:"";?></span>
											</span>
										</a>
									</p>
									<p class="main_push_btn_wrap">
										<a href="" class="main_push_btn">立即抢购</a>
									</p>
								</div>

							</div>
						</li>
					<?php }?>	
					</ul>
				</div>
			</div>
			<div class="g_e">
				<!--Notice-->
				<div class="notice">
					<i class="notice_bod"></i>
					<div class="notice_inner">
						<div class="notice_hd">
							<h3 class="mod_more"><a href="">更多</a></h3>
							<div class="main_push_tit">公告</div>
						</div>
						<div class="notice_bd">
							<ul class="notice_list">
							<?php $query = new IQuery("announcement");$query->limit = "5";$query->order = "id desc";$items = $query->find(); foreach($items as $key => $item){?>
								<?php $tmpId=$item['id'];?>
								<li><a href="<?php echo IUrl::creatUrl("/site/notice_detail/id/$tmpId");?>"><?php echo isset($item['title'])?$item['title']:"";?></a></li>
							<?php }?>
							</ul>
						</div>
					</div>
				</div>
				<!--mobileCard-->
				<div class="mobile_icson">
					<div class="mobile_icson_hd">
						<div class="main_push_tit">手机商城</div>
					</div>
					<div class="mobile_icson_bd">
						<p class="mobile_icson_tdcode"></p>
						<p class="mobile_icson_desp">
                            <a target="_blank" href="">应用宝红码</a>
                            <br>
                            <a target="_blank" href="">手机专享特价！</a>
                            <br>
                            <a target="_blank" class="mobile_icson_down" href="">下载客户端</a>
                        </p>
					</div>
				</div>
			</div>
		</div>
	</div>

<!-- <link rel="stylesheet" type="text/css" href="<?php echo IUrl::creatUrl("")."views/".$this->theme."/javascript/jquery.bxSlider/jquery.bxslider.css";?>" />
<script type="text/javascript" src="<?php echo IUrl::creatUrl("")."views/".$this->theme."/javascript/jquery.bxSlider/jquery.bxSlider.min.js";?>"></script>

<div class="wrapper clearfix">
	<div class="sidebar f_r">

		cms新闻展示
		<div class="box m_10">
			<div class="title"><h2>Shop资讯</h2><a class="more" href="<?php echo IUrl::creatUrl("/site/article");?>">更多...</a></div>
			<div class="cont">
				<ul class="list">
					<?php $query = new IQuery("article");$query->where = "visibility = 1 and top = 1";$query->order = "sort ASC,id DESC";$query->fields = "title,id,style,color";$query->limit = "5";$items = $query->find(); foreach($items as $key => $item){?>
					<?php $tmpId=$item['id'];?>
					<li><a href="<?php echo IUrl::creatUrl("/site/article_detail/id/$tmpId");?>"><?php echo Article::showTitle($item['title'],$item['color'],$item['style']);?></a></li>
					<?php }?>
				</ul>
			</div>
		</div>
		cms新闻展示

		<div class="box">
			<div id="adHere_7"></div>
			<script language="javascript">
			(new adLoader()).load(7,'adHere_7');
			</script>
		</div>
	</div>

	幻灯片 开始
	<div class="main f_l">
		<?php if($this->index_slide){?>
		<ul class="bxslider">
			<?php foreach($this->index_slide as $key => $item){?>
			<li title="<?php echo isset($item['name'])?$item['name']:"";?>"><a href="<?php echo IUrl::creatUrl("$item[url]");?>" target="_blank"><img src="<?php echo IUrl::creatUrl("")."$item[img]";?>" width="750px" title="<?php echo isset($item['name'])?$item['name']:"";?>" /></a></li>
			<?php }?>
		</ul>
		<?php }?>
	</div>
	幻灯片 结束
</div>

<div class="m_10">
	<div id="adHere_6"></div>
	<script language="javascript">
	(new adLoader()).load(6,'adHere_6');
	</script>
</div>

<div class="wrapper clearfix">
	<div class="sidebar f_r">

		团购
		<div class="group_on box m_10">
			<div class="title"><h2>团购商品</h2><a class="more" href="<?php echo IUrl::creatUrl("/site/groupon");?>">更多...</a></div>
			<div class="cont">
				<ul class="ranklist">
					<?php $query = new IQuery("regiment");$query->where = "is_close = 0 and NOW() between start_time and end_time";$query->limit = "5";$query->fields = "id,title,regiment_price,img";$query->order = "id desc";$items = $query->find(); foreach($items as $key => $item){?>
					<li class="current">
						<?php $tmpId=$item['id'];?>
						<a href="<?php echo IUrl::creatUrl("/site/groupon/id/$tmpId");?>"><img width="60px" height="60px" alt="<?php echo isset($item['title'])?$item['title']:"";?>" src="<?php echo IUrl::creatUrl("")."$item[img]";?>"></a>
						<a class="p_name" title="<?php echo isset($item['title'])?$item['title']:"";?>" href="<?php echo IUrl::creatUrl("/site/groupon/id/$tmpId");?>"><?php echo isset($item['title'])?$item['title']:"";?></a><p class="light_gray">团购价：<em>￥<?php echo isset($item['regiment_price'])?$item['regiment_price']:"";?></em></p>
					</li>
					<?php }?>
				</ul>
			</div>
		</div>
		团购

		限时抢购
		<div class="buying box m_10">
			<div class="title"><h2>限时抢购</h2></div>
			<div class="cont clearfix">
				<ul class="prolist">
					<?php $countNumsItem = array();?>
					<?php $query = new IQuery("promotion as p");$query->join = "left join goods as go on go.id = p.condition";$query->fields = "p.end_time,go.img as img,p.name as name,p.award_value as award_value,go.id as goods_id,p.id as p_id,end_time";$query->where = "p.type = 1 and p.is_close = 0 and go.is_del = 0 and NOW() between start_time and end_time AND go.id is not null";$query->limit = "2";$items = $query->find(); foreach($items as $key => $item){?>
					<?php $free_time = ITime::getDiffSec($item['end_time'])?>
					<?php $countNumsItem[] = $item['p_id'];?>
					<li>
						<p class="countdown">倒计时:<br /><b id='cd_hour_<?php echo isset($item['p_id'])?$item['p_id']:"";?>'><?php echo floor($free_time/3600);?></b>时<b id='cd_minute_<?php echo isset($item['p_id'])?$item['p_id']:"";?>'><?php echo floor(($free_time%3600)/60);?></b>分<b id='cd_second_<?php echo isset($item['p_id'])?$item['p_id']:"";?>'><?php echo $free_time%60;?></b>秒</p>
						<?php $tmpGoodsId=$item['goods_id'];$tmpPId=$item['p_id'];?>
						<a href="<?php echo IUrl::creatUrl("/site/products/id/$tmpGoodsId/promo/time/active_id/$tmpPId");?>"><img src="<?php echo IUrl::creatUrl("")."";?><?php echo Thumb::get($item['img'],175,175);?>" width="175" height="175" alt="<?php echo isset($item['name'])?$item['name']:"";?>" title="<?php echo isset($item['name'])?$item['name']:"";?>" /></a>
						<p class="pro_title"><a href="<?php echo IUrl::creatUrl("/site/products/id/$tmpGoodsId/promo/time/active_id/$tmpPId");?>"><?php echo isset($item['name'])?$item['name']:"";?></a></p>
						<p class="light_gray">抢购价：<b>￥<?php echo isset($item['award_value'])?$item['award_value']:"";?></b></p>
						<div></div>
					</li>
					<?php }?>
				</ul>
			</div>
		</div>
		限时抢购

		热卖商品
		<div class="hot box m_10">
			<div class="title"><h2>热卖商品</h2></div>
			<div class="cont clearfix">
				<ul class="prolist">
					<?php $query = new IQuery("commend_goods as co");$query->join = "left join goods as go on co.goods_id = go.id";$query->where = "co.commend_id = 3 and go.is_del = 0 AND go.id is not null";$query->fields = "go.img,go.sell_price,go.name,go.id";$query->limit = "8";$query->order = "sort asc,id desc";$items = $query->find(); foreach($items as $key => $item){?>
					<?php $tmpId=$item['id']?>
					<li>
						<a href="<?php echo IUrl::creatUrl("/site/products/id/$tmpId");?>"><img src="<?php echo IUrl::creatUrl("")."";?><?php echo Thumb::get($item['img'],85,85);?>" width="85" height="85" alt="<?php echo isset($item['name'])?$item['name']:"";?>" /></a>
						<p class="pro_title"><a href="<?php echo IUrl::creatUrl("/site/products/id/$tmpId");?>"><?php echo isset($item['name'])?$item['name']:"";?></a></p>
						<p class="brown"><b>￥<?php echo isset($item['sell_price'])?$item['sell_price']:"";?></b></p>
					</li>
					<?php }?>
				</ul>
			</div>
		</div>
		热卖商品

		公告通知
		<div class="box m_10">
			<div class="title"><h2>公告通知</h2><a class="more" href="<?php echo IUrl::creatUrl("/site/notice");?>">更多...</a></div>
			<div class="cont">
				<ul class="list">
					<?php $query = new IQuery("announcement");$query->limit = "5";$query->order = "id desc";$items = $query->find(); foreach($items as $key => $item){?>
					<?php $tmpId=$item['id'];?>
					<li><a href="<?php echo IUrl::creatUrl("/site/notice_detail/id/$tmpId");?>"><?php echo isset($item['title'])?$item['title']:"";?></a></li>
					<?php }?>
				</ul>
			</div>
		</div>
		公告通知

		关键词
		<div class="box m_10">
			<div class="title"><h2>关键词</h2><a class="more" href="<?php echo IUrl::creatUrl("/site/tags");?>">更多...</a></div>
			<div class="tag cont t_l">
				<?php $query = new IQuery("keyword");$query->where = "hot = 1";$query->limit = "8";$query->order = "`order` asc";$items = $query->find(); foreach($items as $key => $item){?>
				<?php $searchWord =urlencode($item['word']);?>
				<a href="<?php echo IUrl::creatUrl("/site/search_list/word/$searchWord");?>" class="orange"><?php echo isset($item['word'])?$item['word']:"";?></a>
				<?php }?>
			</div>
		</div>
		关键词

		电子订阅
		<div class="book box m_10">
			<div class="title"><h2>电子订阅</h2></div>
			<div class="cont">
				<p>我们会将最新的资讯发到您的Email</p>
				<input type="text" class="gray_m light_gray f_l" name='orderinfo' value="输入您的电子邮箱地址" />
				<label class="btn_orange"><input type="button" onclick="orderinfo();" value="订阅" /></label>
			</div>
		</div>
		电子订阅
	</div>

	<div class="main f_l">
		商品分类展示
		<div class="category box">
			<div class="title2">
				<h2><img src="<?php echo IUrl::creatUrl("")."views/".$this->theme."/skin/".$this->skin."/images/front/category.gif";?>" alt="商品分类" width="155" height="36" /></h2>
				<a class="more" href="<?php echo IUrl::creatUrl("/site/sitemap");?>">全部商品分类</a>
			</div>
		</div>

		<table id="index_category" class="sort_table m_10" width="100%">
			<col width="100px" />
			<col />
			<?php $query = new IQuery("category");$query->where = "parent_id = 0 and visibility = 1";$query->order = "sort asc";$firsts = $query->find(); foreach($firsts as $key => $first){?>
			<tr>
				<th><a href="<?php echo IUrl::creatUrl("/site/pro_list/cat/$first[id]");?>"><?php echo isset($first['name'])?$first['name']:"";?></a></th>
				<td>
					<?php $query = new IQuery("category");$query->where = "parent_id = $first[id] and visibility = 1";$query->order = "sort asc";$seconds = $query->find(); foreach($seconds as $key => $second){?>
					<a href="<?php echo IUrl::creatUrl("/site/pro_list/cat/$second[id]");?>"><?php echo isset($second['name'])?$second['name']:"";?></a> |
					<?php }?>
				</td>
			</tr>
			<?php }?>
		</table>
		商品分类展示

		最新商品
		<div class="box yellow m_10">
			<div class="title2">
				<h2><img src="<?php echo IUrl::creatUrl("")."views/".$this->theme."/skin/".$this->skin."/images/front/new_product.gif";?>" alt="最新商品" width="160" height="36" /></h2>
			</div>
			<div class="cont clearfix">
				<ul class="prolist">
					<?php $query = new IQuery("commend_goods as co");$query->join = "left join goods as go on co.goods_id = go.id";$query->where = "co.commend_id = 1 and go.is_del = 0 AND go.id is not null";$query->fields = "go.img,go.sell_price,go.name,go.market_price,go.id";$query->limit = "8";$query->order = "id desc";$query->group = "id";$items = $query->find(); foreach($items as $key => $item){?>
					<?php $tmpId=$item['id'];?>
					<li style="overflow:hidden">
						<a href="<?php echo IUrl::creatUrl("/site/products/id/$tmpId");?>"><img src="<?php echo IUrl::creatUrl("")."";?><?php echo Thumb::get($item['img'],175,175);?>" width="175" height="175" alt="<?php echo isset($item['name'])?$item['name']:"";?>" /></a>
						<p class="pro_title"><a title="<?php echo isset($item['name'])?$item['name']:"";?>" href="<?php echo IUrl::creatUrl("/site/products/id/$tmpId");?>"><?php echo isset($item['name'])?$item['name']:"";?></a></p>
						<p class="brown">惊喜价：<b>￥<?php echo isset($item['sell_price'])?$item['sell_price']:"";?></b></p>
						<p class="light_gray">市场价：<s>￥<?php echo isset($item['market_price'])?$item['market_price']:"";?></s></p>
					</li>
					<?php }?>
				</ul>
			</div>
		</div>
		最新商品

		首页推荐商品
		<?php foreach($firsts as $key => $first){?>
		<div class="box m_10" name="showGoods">
			<div class="title title3">
				<h2><a href="<?php echo IUrl::creatUrl("/site/pro_list/cat/$first[id]");?>"><strong><?php echo isset($first['name'])?$first['name']:"";?></strong></a></h2>
				<a class="more" href="<?php echo IUrl::creatUrl("/site/pro_list/cat/$first[id]");?>">更多商品...</a>
				<ul class="category">
					<?php $query = new IQuery("category");$query->where = "parent_id = $first[id] and visibility = 1";$query->order = "sort asc";$seconds = $query->find(); foreach($seconds as $key => $second){?>
					<li><a href="<?php echo IUrl::creatUrl("/site/pro_list/cat/$second[id]");?>"><?php echo isset($second['name'])?$second['name']:"";?></a><span></span></li>
					<?php }?>
				</ul>
			</div>

			<div class="cont clearfix">
				<ul class="prolist">
					<?php $query = new IQuery("category_extend as ca");$query->join = "left join goods as go on go.id = ca.goods_id";$query->where = "ca.category_id = $first[id] and go.is_del = 0";$query->limit = "8";$query->order = "go.sort asc,go.id desc";$query->fields = "go.img,go.id,go.name,go.sell_price,go.market_price";$items = $query->find(); foreach($items as $key => $item){?>
					<li style="overflow:hidden">
						<a href="<?php echo IUrl::creatUrl("/site/products/id/$item[id]");?>"><img src="<?php echo IUrl::creatUrl("")."";?><?php echo Thumb::get($item['img'],175,175);?>" width="175" height="175" alt="<?php echo isset($item['name'])?$item['name']:"";?>" title="<?php echo isset($item['name'])?$item['name']:"";?>" /></a>
						<p class="pro_title"><a title="<?php echo isset($item['name'])?$item['name']:"";?>" href="<?php echo IUrl::creatUrl("/site/products/id/$item[id]");?>"><?php echo isset($item['name'])?$item['name']:"";?></a></p>
						<p class="brown">惊喜价：<b>￥<?php echo isset($item['sell_price'])?$item['sell_price']:"";?></b></p>
						<p class="light_gray">市场价：<s>￥<?php echo isset($item['market_price'])?$item['market_price']:"";?></s></p>
					</li>
					<?php }?>
				</ul>
			</div>
		</div>
		<?php }?>

		品牌列表
		<div class="brand box m_10">
			<div class="title2"><h2><img src="<?php echo IUrl::creatUrl("")."views/".$this->theme."/skin/".$this->skin."/images/front/brand.gif";?>" alt="品牌列表" width="155" height="36" /></h2><a class="more" href="<?php echo IUrl::creatUrl("/site/brand");?>">&lt;<span>全部品牌</span>&gt;</a></div>
			<div class="cont clearfix">
				<ul>
					<?php $query = new IQuery("brand");$query->fields = "id,name,logo";$query->order = "sort asc";$query->limit = "6";$items = $query->find(); foreach($items as $key => $item){?>
					<?php $tmpId=$item['id'];?>
					<li><a href="<?php echo IUrl::creatUrl("/site/brand_zone/id/$tmpId");?>"><img src="<?php echo IUrl::creatUrl("")."$item[logo]";?>"  width="110" height="50"/><?php echo isset($item['name'])?$item['name']:"";?></a></li>
					<?php }?>
				</ul>
			</div>
		</div>
		品牌列表

		最新评论
		<div class="comment box m_10">
			<div class="title2"><h2><img src="<?php echo IUrl::creatUrl("")."views/".$this->theme."/skin/".$this->skin."/images/front/comment.gif";?>" alt="最新评论" width="155" height="36" /></h2></div>
			<div class="cont clearfix">
				<?php $query = new IQuery("comment as co");$query->join = "left join goods as go on co.goods_id = go.id";$query->order = "co.id desc";$query->limit = "6";$query->where = "co.status = 1 AND go.is_del = 0 AND go.id is not null";$query->fields = "go.img as img,go.name as name,co.point,co.contents,co.goods_id";$items = $query->find(); foreach($items as $key => $item){?>
				<dl class="no_bg">
					<?php $tmpGoodsId=$item['goods_id'];?>
					<dt><a href="<?php echo IUrl::creatUrl("/site/products/id/$tmpGoodsId");?>"><img src="<?php echo IUrl::creatUrl("")."";?><?php echo Thumb::get($item['img'],66,66);?>" width="66" height="66" /></a></dt>
					<dd><a href="<?php echo IUrl::creatUrl("/site/products/id/$tmpGoodsId");?>"><?php echo isset($item['name'])?$item['name']:"";?></a></dd>
					<dd><span class="grade"><i style="width:<?php echo $item['point']*14;?>px"></i></span></dd>
					<dd class="com_c"><?php echo isset($item['contents'])?$item['contents']:"";?></dd>
				</dl>
				<?php }?>
			</div>
		</div>
		最新评论
	</div>
</div>

<script type='text/javascript'>
//dom载入完毕执行
jQuery(function()
{
	//幻灯片开启
	$('.bxslider').bxSlider({'mode':'fade','captions':true,'pager':false,'auto':true});

	//index 分类展示
	$('#index_category tr').hover(
		function(){
			$(this).addClass('current');
		},
		function(){
			$(this).removeClass('current');
		}
	);

	//email订阅 事件绑定
	var tmpObj = $('input:text[name="orderinfo"]');
	var defaultText = tmpObj.val();
	tmpObj.bind({
		focus:function(){checkInput($(this),defaultText);},
		blur :function(){checkInput($(this),defaultText);}
	});

	//显示抢购倒计时
	var cd_timer = new countdown();
	<?php foreach($countNumsItem as $key => $item){?>
		cd_timer.add(<?php echo isset($item)?$item:"";?>);
	<?php }?>

	//首页商品变色
	var colorArray = ['green','yellow','purple'];
	$('div[name="showGoods"]').each(function(i)
	{
		$(this).addClass(colorArray[i%colorArray.length]);
	});
});

//电子邮件订阅
function orderinfo()
{
	var email = $('[name="orderinfo"]').val();
	if(email == '')
	{
		alert('请填写正确的email地址');
	}
	else
	{
		$.getJSON('<?php echo IUrl::creatUrl("/site/email_registry");?>',{email:email},function(content){
			if(content.isError == false)
			{
				alert('订阅成功');
				$('[name="orderinfo"]').val('');
			}
			else
				alert(content.message);
		});
	}
}
</script> -->
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
		seajs.use('home');
	</script>
</body>
</html>
