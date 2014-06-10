/**
 * 在图片的一旁随着鼠标移动显示图片的放大效果
 *
 * <div class="pic_show" id="pic_show" style="relative">
 *		<img src="small.jpg" zoom_src="big.jpg" />
 * </div>
 * $().ready(function(){ pic_zoom_init("#pic_show img") });
 *
 * @author walu
 */
 
function pic_zoom(e)
{
	/*
	param e,$()里的选择符
	*/
	var _self = this;
	
	this.image=$(e);
	this.image_big=false;
	this.position=false;
	this.tmp_x=0;
	this.tmp_y=0;
	this.handle=false;
	
	//缓存数据，提高性能
	this.image=this.image[0];
	this.image_big_width=0;
	this.image_big_height=0;
	this.half_pic_zoom_big_width=0;
	this.half_pic_zoom_big_height=0;
	this.image_width=0;
	this.image_height=0;
	this.pic_zoom_big_width=0;
	this.pic_zoom_big_height=0;
	
	/*缓存tip层四个边界*/
	this.x_left=0;
	this.x_right=0;
	this.y_top=0;
	this.y_bottom=0;
	
	if( this.image.length==0 || !!$(this.image).attr('zoom_src') === false )
		return;
	
	this.init = function()
	{
		_self.position=$(_self.image).position();
		_self.pic_zoom_div();
		_self.ajust_size();
		$(_self.image).mouseover(_self.image_mouseover);		
		$(_self.image).mousemove(_self.image_mousemove);
		$("#pic_zoom_tip").mousemove(_self.image_mousemove).mouseout(_self.tip_mouseout);
		
		_self.x_left=this.position.left;
		_self.x_right=this.position.left + this.image.width;
		_self.y_top=this.position.top;
		_self.y_bottom=this.position.top + this.image.height;
		
	}//构造函数
	
	
	/**
	 * 检测是否有#pic_zoom_big
	 */
	this.pic_zoom_div=function()
	{
		var pic_zoom_big=$("#pic_zoom_big");
		if(pic_zoom_big.length==0)
		{
			var div=$('<div id="pic_zoom_big" style="z-index:1000;padding:0px;margin:0px;border:5px solid #ddd;background:#fff;position:absolute;height:400px;width:400px;overflow:hidden;display:none;"></div>');
			document.getElementsByTagName("body")[0].appendChild(div[0]);
		
			//将zoom_tip加入pic
			var div=$('<div id="pic_zoom_tip" style="width:1px;height:1px;position:absolute;background:#000;z-index:101;"></div>');
			document.getElementsByTagName("body")[0].appendChild(div[0]);
			$("#pic_zoom_tip").css('opacity',0.3);		
		}
	}
	
	/**
	 * 大图，调整大小
	 */
	this.ajust_size=function()
	{
		_self.image_big=new Image();
		_self.image_big.src=$(_self.image).attr('zoom_src');
		_self.image_big.id="image_big";
		if(_self.image_big.complete)
		{
			_self.image_big_onload();
		}
		else
		{
			_self.image_big.onload=_self.image_big_onload;
		}
	}
	
	/**
	 * 大图加载完成
	 */
	this.image_big_onload=function()
	{
		//判断图片大小，如果太小直接退出
		var w=_self.image_big.width;
		var h=_self.image_big.height;
		if(w<=_self.image.width && h<=_self.image.height)
		{
			return;
		}
		
		$(_self.image_big).width(w).height(h);
		
		//按照image长宽比重新布置image_big的长宽比
		//将长宽比调整为最接近小图5倍大小的位置，但是如果大图长宽都不够小图的三倍，则长度最长的那条边不变。
		var tmp_w=w/_self.image.width;
		var tmp_h=h/_self.image.height;
		
		_self.tmp_w=tmp_w;
		_self.tmp_h=tmp_h;
		
		if(tmp_w>5 || tmp_h>5)
		{
			_self.image_big.width=_self.image.width*5;
			_self.image_big.height=_self.image.height*5;
		}
		else
		{
			if(tmp_w>tmp_h)
			{
				
				$(_self.image_big).height(parseInt(_self.image.height*tmp_w));
			}
			else
			{
				$(_self.image_big).width(parseInt(_self.image.width*tmp_h));
			}
		}
		
		_self.image_big_width=$(_self.image_big).width();
		_self.image_big_height=$(_self.image_big).height();
		
	}//大图加载完成 函数完毕
	
	/**
	 * 模仿小图的mouseover事件
	 */
	this.image_mouseover=function()
	{
		var image_big=_self.image_big;
		var image = _self.image;
		var position = _self.position;
		var tmp_w = _self.tmp_w;
		var tmp_h = _self.tmp_h;
		
		//根据大图尺寸调整div的高和宽
		if($("#pic_zoom_big").width()>image_big.width+10 )
		{
			$("#pic_zoom_big").width(image_big.width+10);
		}
		if($("#pic_zoom_big").height()>image_big.height+10 )
		{
			$("#pic_zoom_big").height(image_big.height+10);
		}
		
		//将大图片放入div中
		$("#pic_zoom_big").html("");
		$("#pic_zoom_big").show();
		
		$("#pic_zoom_big").css("left",( position.left + $(image).width() +20 )+"px");
		$("#pic_zoom_big").css("top",parseInt( position.top + 0.5 *$(image).height() - 0.5 * $("#pic_zoom_big").height()  )+"px") ;
		
		$(_self.image_big).appendTo("#pic_zoom_big");
		$(_self.image_big).css('position','absolute');
		$(_self.image_big).css('top','0px');
		$(_self.image_big).css('left','0px');
		
		//调整左边提示框的大小
		var tip_ratio_w = parseInt($("#pic_zoom_big").innerWidth()/tmp_w);		
		var tip_ratio_h = parseInt($("#pic_zoom_big").innerHeight()/tmp_h);		
		$("#pic_zoom_tip").width(tip_ratio_w);
		$("#pic_zoom_tip").height(tip_ratio_h);
		$("#pic_zoom_tip").show();
		
		_self.pic_zoom_tip_width=$("#pic_zoom_tip").width();
		_self.pic_zoom_tip_height=$("#pic_zoom_tip").height();
		
		_self.half_pic_zoom_tip_width= parseInt(0.5 * $("#pic_zoom_tip").width());
		_self.half_pic_zoom_tip_height=parseInt(0.5 * $("#pic_zoom_tip").height());
		
		_self.tip_left=position.left;
		_self.tip_right=position.left+image.width-_self.pic_zoom_tip_width;
		_self.tip_top=position.top;
		_self.tip_bottom=position.top+image.height-_self.pic_zoom_tip_height;
		
		
		_self.half_pic_zoom_big_width=0.5 * $("#pic_zoom_big").width();
		_self.half_pic_zoom_big_height=0.5 * $("#pic_zoom_big").height();
		_self.pic_zoom_big_width=$("#pic_zoom_big").width();
		_self.pic_zoom_big_height=$("#pic_zoom_big").height();
	};
	
	/*
	 * 
	 * @param HTMLEvent e
	 */
	this.image_mousemove=function(e)
	{ 
	
		var image_big=_self.image_big;
		var image = _self.image;
		var position = _self.position;
		var tmp_w = _self.tmp_w;
		var tmp_h = _self.tmp_h;
	
		//如果已越界，则直接清空返回
		if(e.pageX < _self.x_left || e.pageX>_self.x_right || e.pageY < _self.y_top || e.pageY > _self.y_bottom)
		{
		   	$("#pic_zoom_big").html("");
		   $("#pic_zoom_big").hide();
		   	$("#pic_zoom_tip").hide();
		   	return;
		}

		//开始调整大图和tip层的位置
		//调整tip层top和left的四个边界
		
		
		var x,y,tmp;
		x = e.pageX - _self.half_pic_zoom_tip_width;
		y = e.pageY - _self.half_pic_zoom_tip_width;
		if(x< _self.tip_left)
		{
			x= _self.tip_left;
		}		 
		else if(x> _self.tip_right)
		{
			x= _self.tip_right;
		}
		
		if(y< _self.tip_top)
		{
			y= _self.tip_top;
		}		
		else if(y> _self.tip_bottom)
		{
			y= _self.tip_bottom;
		}
		 
			$("#pic_zoom_tip").css('top',y);
		 
			$("#pic_zoom_tip").css('left',x);
 
		
		//获取比例
		var ratio_left = ( e.pageX - _self.position.left ) / _self.image.width;
		var ratio_top = (e.pageY-_self.position.top)/_self.image.height;
		
		var left= -parseInt( _self.image_big_width * ratio_left - _self.half_pic_zoom_big_width );
		var top=  -parseInt( _self.image_big_height*ratio_top - _self.half_pic_zoom_big_height);
		
		//大图的四个边界
		var big_left,big_right,big_top,big_bottom;
		big_left= -( _self.image_big_width-_self.pic_zoom_big_width);
		big_top= - (_self.image_big_height-_self.pic_zoom_big_height);
		big_right=0;
		big_bottom=0;
		
		if(left<big_left)
		{
			left=big_left;
		}
		if(left>big_right)
		{
			left=big_right;
		}
		if(top>big_bottom)
		{
			top=big_bottom;
		}
		if(top<big_top)
		{
			top=big_top;
		}

		//调整大图位置
		$(_self.image_big).css("top",top+"px");
		$(_self.image_big).css("left",left+"px");
	}
	
	this.addMove=function()
	{
		$(_self.image).mousemove(_self.image_mousemove);
		$("#pic_zoom_tip").mousemove(_self.image_mousemove);
	}
	
	/**
	 * tip层的
 	 */
	this.tip_mouseout=function()
	{
	 	$("#pic_zoom_big").html("");
	   $("#pic_zoom_big").hide();
	   	$("#pic_zoom_tip").hide();
	   	return;
	}	
}

function pic_resize(e,width,height)
{
	$(e).each(function()
	{
		var w,h;
		w=$(this).width();
		h=$(this).height();
		width=parseInt(width);height=parseInt(height);
		
		if(w>=width || h>=height)
		{
			if( (w/width) > (h/height) )
			{
				$(this).width(width);
				$(this).height( parseInt( h*width/w ));
			}
			else
			{
				$(this).height(height);
				$(this).width( parseInt(w*height/h));
			}
			
		}
		
	});
}
