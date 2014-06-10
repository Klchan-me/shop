<?php
/**
 * 关于系统帮助
 * @author walu
 * @package iwebshop
 */

class SiteHelp
{
	public static function get_help_by_id($id)
	{
		if(!is_array($id))
		{
			$id=array($id);
		}

		if(!$id)
			return array();

		foreach($id as $key => $value)
		{
			$id[$key]=intval($value);
		}
		$id=implode( "," , array_unique($id)   );
		$tb_help=new IModel('help');
		$list=$tb_help->query("id IN ({$id})");
		return Util::array_rekey($list,'id');
	}

	public static function help_edit($data)
	{
		if(!isset($data['name']) || $data['name']===null || !preg_match('!^.{1,50}$!u',$data['name']) )
		{
			return array('flag'=>false,'data'=>'标题不能为空，且不能超过50个文字');
		}
		$data['name'] = htmlspecialchars($data['name'],ENT_QUOTES);

		if(!isset($data['cat_id']) || $data['cat_id']===null)
		{
			return array('flag'=>false,'data'=>'分类不能为空');
		}

		$data['cat_id']  = intval($data['cat_id']);
		$data['content'] = IFilter::act($data['content'],'text');
		$data['sort']    = abs(intval($data['sort']));

		$id = $data['id'];
		unset($data['id']);

		$tb_help = new IModel("help");
		$tb_help->setData($data);

		if($id===null)
		{
			$data['dateline'] = ITime::getNow();
			$tb_help->setData( $data  );
			$tb_help->add();
		}
		else
		{
			$tb_help->update("id={$id}");
		}
		return array('flag'=>true,'data'=>'success');

	}

	public static function help_del($id)
	{
		if(!is_array($id))
		{
			$id = array($id);
		}
		$id = IFilter::act($id,'int');
		$id = implode(",",$id);
		$tb_help = new IModel("help");
		$tb_help->del("id IN ({$id})");
		return array('flag'=>true,'data'=>'success');
	}

	public static function get_cat_by_id($id)
	{
		if(!is_array($id))
		{
			$id=array($id);
		}

		if(!$id)
			return array();

		foreach($id as $key => $value)
		{
			$id[$key]=intval($value);
		}
		$id=implode( "," , array_unique($id)   );
		$tb_help_cat=new IModel('help_category');
		$list=$tb_help_cat->query("id IN ({$id})");
		return Util::array_rekey($list,'id');
	}

	public static function cat_edit($arr)
	{
		if(!isset($arr['id']) || $arr['id']===null || !preg_match("![0-9]+!",$arr['id']) )
		{
			unset($arr['id']);
		}

		if($arr['name']===null || !preg_match('!^.{1,10}$!u',$arr['name']))
		{
			return array('flag'=>false,'data'=>'分类名称不能超过十个文字');
		}

		$arr['name'] = htmlspecialchars($arr['name'],ENT_QUOTES);
		$arr['sort'] = intval($arr['sort']);
		$arr['position_left'] = intval($arr['position_left'])==1?1:0;
		$arr['position_foot'] = intval($arr['position_foot'])==1?1:0;

		$tb_help_category = new IModel("help_category");
		$tb_help_category->setData($arr);
		if(isset($arr['id']))
		{
			$id=intval($arr['id']);
			unset($arr['id']);
			$tb_help_category->update("id={$id}");
		}
		else
		{
			$tb_help_category->add($arr);
		}
		return array('flag'=>true,'data'=>"编辑成功");
	}

	public static function mod_cat_position($id,$position,$value)
	{
		$id = intval($id);
		$value = intval($value)==1?1:0;

		if($position!='left' && $position!='foot')
			return array('flag'=>false,'data'=>'错误的位置');

		$tb_help_category = new IModel("help_category");
		$tb_help_category->setData( array("position_{$position}"=>$value) );
		$tb_help_category->update("id={$id}");
		return array('flag'=>true);
	}

	public static function del_cat($id)
	{
		$id = intval($id);
		$tb_help_category = new IModel("help_category");
		$result = $tb_help_category->del("id={$id}");
		return array('flag'=>$result);
	}
}
?>
