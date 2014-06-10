jQuery(function(){
	//高度自适应
	initLayout();
	$(window).resize(function()
	{
		initLayout();
	});
	function initLayout()
	{
		var h1 = document.documentElement.clientHeight - $("#header").outerHeight(true) - $("#info_bar").height();
		var h2 = h1 - $(".headbar").height() - $(".pages_bar").height() - 30;
		$('#admin_left').height(h1);
		$('#admin_right .content').height(h2);
	}
	//一级菜单切换
	$("#menu ul li:first-child").addClass("first");
	$("#menu ul li:last-child").addClass("last");
	$("[name='menu']>li").click(function(){
		$(this).siblings().removeClass("selected");
        $(this).addClass("selected");
	});
	//二级菜单展示效果
	$("ul.submenu>li>span").toggle(
		function(){
			$(this).next().css("display","none");
			$(this).addClass("selected");
		},
		function(){
			$(this).next().css("display","");
			$(this).removeClass("selected");
		}
	);
	//文字滚动显示
	$("#tips a:not(:first)").css("display","none");
	var tips_l=$("#tips a:last");
	var tips_f=$("#tips a:first");
	setInterval(function()
	{
		if($("#tips").children().length	!= 1){
			if(tips_l.is(":visible")){
				tips_f.fadeIn(500);
				tips_l.hide()
			}else{
				$("#tips a:visible").addClass("now");
				$("#tips a.now").next().fadeIn(500);
				$("#tips a.now").hide().removeClass("now");
			}
		}
	},3000);
	//搜索
	var sch_val = "输入商铺名称";
	$(".search>input.text").blur(
		function(){
			if($(this).val()==''){
				$(this).val(sch_val);
			}
		}
	).click(
		function(){
			if($(this).val()==sch_val){
				$(this).val('');
			}
		}
	);
	//关闭侧边栏
	$("#separator").click(function(){
		document.body.className = (document.body.className == "folden") ? "":"folden";
	});
});

/**
 * 进行商品筛选
 * @param url string 执行的URL
 * @param callback function 筛选成功后执行的回调函数
 */
function searchGoods(url,callback)
{
	var step = 0;
	art.dialog.open(url,
	{
		"id":"searchGoods",
		"title":"商品筛选",
		"okVal":"执行",
		"button":
		[{
			"name":"后退",
			"callback":function(iframeWin,topWin)
			{
				if(step > 0)
				{
					iframeWin.window.history.go(-1);
					this.size(1,1);
					step--;
				}
				return false;
			}
		}],
		"ok":function(iframeWin,topWin)
		{
			if(step == 0)
			{
				iframeWin.document.forms[0].submit();
				step++;
				return false;
			}
			else if(step == 1)
			{
				var goodsList = $(iframeWin.document).find('input[name="id[]"]:checked');

				//添加选中的商品
				if(goodsList.length == 0)
				{
					alert('请选择要添加的商品');
					return false;
				}
				//执行处理回调
				callback(goodsList);
				return true;
			}
		}
	});
}