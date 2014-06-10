<?php
/**
 * @copyright (c) 2011 jooyea.cn
 * @file dbmodel_class.php
 * @brief 数据处理
 * @author chendeshan
 * @date 2010-12-14
 * @version 0.6
 */

/**
 * @class IModel
 * @brief 数据处理对象
 */
class IModel
{
	//数据库操作对象
	private $db = NULL;

	//数据表名称
	private $tableName = '';

	//要更新的表数据,key:对应表字段; value:数据;
	private $tableData = array();

	/**
	 * @brief 构造函数,创建数据库对象
	 * @param string $tableName 表名称(当多表操作时以逗号分隔,如：user,goods);
	 */
	public function __construct($tableName)
	{
		$this->db = IDBFactory::getDB();
		$tablePre = isset(IWeb::$app->config['DB']['tablePre']) ? IWeb::$app->config['DB']['tablePre'] : '';

		//多表处理
		if(stripos($tableName,','))
		{
			$tables = explode(',',$tableName);
			foreach($tables as $val)
			{
				if($this->tableName != '')
					$this->tableName .= ',';

				$this->tableName .= $tablePre.trim($val);
			}
		}

		//单表处理
		else
		{
			$this->tableName = $tablePre.$tableName;
		}
	}

	/**
	 * @brief 设置要更新的表数据
	 * @param array $data key:字段名; value:字段值;
	 */
	public function setData($data)
	{
		if(is_array($data))
			$this->tableData = $data;
		else
			return false;
	}

	/**
	 * @brief 更新
	 * @param  string $where 更新条件
	 * @param  array  $except 非普通数据形式(key值)
	 * @return int or bool int:影响的条数; bool:false错误
	 */
	public function update($where,$except=array())
	{
		$except = is_array($except) ? $except : array($except);

		//获取更新数据
		$tableObj  = $this->tableData;
		$updateStr = '';
		$where     = (strtolower($where) == 'all') ? '' : ' WHERE '.$where;

		foreach($tableObj as $key => $val)
		{
			if($updateStr != '') $updateStr.=' , ';
			if(!in_array($key,$except))
				$updateStr.= '`'.$key.'` = \''.$val.'\'';
			else
				$updateStr.= '`'.$key.'` = '.$val;
		}
		$sql = 'UPDATE '.$this->tableName.' SET '.$updateStr.$where;
		return $this->db->query($sql);
	}

	/**
	 * @brief 添加
	 * @return int or bool int:插入的自动增长值 bool:false错误
	 */
	public function add()
	{
		//获取插入的数据
		$tableObj = $this->tableData;

		$insertCol = array();
		$insertVal = array();
		foreach($tableObj as $key => $val)
		{
			$insertCol[] = '`'.$key.'`';
			$insertVal[] = '\''.$val.'\'';
		}
		$sql = 'INSERT INTO '.$this->tableName.' ( '.join(',',$insertCol).' ) VALUES ( '.join(',',$insertVal).' ) ';
		return $this->db->query($sql);
	}

	/**
	 * @brief 删除
	 * @param string $where 删除条件
	 * @return int or bool int:删除的记录数量 bool:false错误
	 */
	public function del($where)
	{
		$where = (strtolower($where) == 'all') ? '' : ' WHERE '.$where;
		$sql   = 'DELETE FROM '.$this->tableName.$where;
		return $this->db->query($sql);
	}

	/**
	 * @brief 获取单条数据
	 * @param string $where 查询条件
	 * @param array or string $cols 查询字段,支持数组格式,如array('cols1','cols2')
	 * @return array 查询结果
	 */
	public function getObj($where = false,$cols = '*')
	{
		$result = $this->query($where,$cols,'','',1);
		if(empty($result))
		{
			return array();
		}
		else
		{
			return $result[0];
		}
	}

	/**
	 * @brief 获取多条数据
	 * @param string $where 查询条件
	 * @param array or string $cols 查询字段,支持数组格式,如array('cols1','cols2')
	 * @param array or string $orderBy 排序字段
	 * @param array or string $desc 排列顺序 值: DESC:倒序; ASC:正序;
	 * @param array or int $limit 显示数据条数 默认(500)
	 * @return array 查询结果
	 */
	public function query($where=false,$cols='*',$orderBy=false,$desc='DESC',$limit=50000)
	{
		//字段拼接
		if(is_array($cols))
		{
			$colStr = join(',',$cols);
		}
		else
		{
			$colStr = ($cols=='*' || !$cols) ? '*' : $cols;
		}

		$sql = 'SELECT '.$colStr.' FROM '.$this->tableName;

		//条件拼接
		if($where != false) $sql.=' WHERE '.$where;

		//排序拼接
		if($orderBy != false)
		{
			$sql.= ' ORDER BY '.$orderBy;
			$sql.= (strtoupper($desc) == 'DESC') ? ' DESC ':' ASC ';
		}

		//条数拼接
		if($limit != 'all')
		{
			$limit = intval($limit);
			$limit = $limit ? $limit : 500;
			$sql.=' limit ' . $limit;
		}

		return $this->db->query($sql);
	}
}
?>