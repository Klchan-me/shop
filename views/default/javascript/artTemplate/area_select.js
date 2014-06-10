//artTemplate模板 {name:组件名字,area_id:选中的地区ID,data:地区的对象}
var areaTemplate = '<option value="">请选择</option>'+'<%for(var index in data){%>'+'<%var item = data[index]%>'+'<option value="<%=item.area_id%>" <%if(item.area_id == select_id){%>selected="selected"<%}%>><%=item.area_name%></option>'+'<%}%>';

/**
 * 切换城市地区
 * @param _self 地域对象
 */
function areaChangeCallback(_self)
{
	var parent_id = _self.value;
	var childName = $(_self).attr('child');

	if(!childName)
	{
		return;
	}

	//拆分子对象
	var childArray = childName.split(',');
	for(var index in childArray)
	{
		$('[name="'+childArray[index]+'"]').empty();
	}

	//生成js联动菜单
	createAreaSelect(childArray[0],parent_id);
}