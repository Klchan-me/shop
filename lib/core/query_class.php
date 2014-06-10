<?php
/**
 * @copyright Copyright(c) 2010 jooyea.cn
 * @file query_class.php
 * @brief 系统统一查询类文件，处理复杂的查询问题
 * @author webning
 * @date 2010-12-17
 * @version 0.6
 * @note
 */
/**
 * @brief IQuery 系统统一查询类
 * @class IQuery
 * @note
 */
class IQuery
{
	private $dbo;
	private $sql=array('table'=>'','fields'=>'*','where'=>'','join'=>'','group'=>'','having'=>'','order'=>'','limit'=>'limit 500','distinct'=>'');
    private $paging;
	private $tablePre='';
    /**
     * @brief 构造函数
     * @param string $name 表名
     */
	public function __construct($name)
	{
		$this->tablePre = isset(IWeb::$app->config['DB']['tablePre'])?IWeb::$app->config['DB']['tablePre']:'';
		$this->table = $name;
		$this->dbo=IDBFactory::getDB();
	}
    /**
     * @brief 给表添加表前缀
     * @param string $name 可以是多个表名用逗号(,)分开
     */
	public function setTable($name)
	{
		if(strpos($name,',') === false)
		{
			$this->sql['table']= $this->tablePre.$name;
		}
		else
		{
			$tables = explode(',',$name);
			foreach($tables as $key=>$value)
			{
				$tables[$key] = $this->tablePre.trim($value);
			}
			$this->sql['table'] = implode(',',$tables);
		}
	}
    /**
     * @brief 取得表前缀
     * @return String 表前缀
     */
    public function getTablePre()
    {
        return $this->tablePre;
    }
    public function setWhere($str)
    {
        $this->sql['where']= 'where '.preg_replace('/from\s+(\S+)/i',"from {$this->tablePre}$1 ",$str);
    }
    /**
     * @brief 实现属性的直接存
     * @param string $name
     * @param string $value
     */
    private function setJoin($str)
    {
		$this->sql['join'] = preg_replace('/(\w+)(?=\s+as\s+\w+(,|\)|\s))/i',"{$this->tablePre}$1 ",$str);
    }
	public function __set($name,$value)
	{
		switch($name)
		{
			case 'table':$this->setTable($value);break;
			case 'fields':$this->sql['fields'] = $value;break;
			case 'where':$this->setWhere($value);break;
			case 'join':$this->setJoin($value);break;
			case 'group':$this->sql['group'] = 'GROUP BY '.$value;break;
			case 'having':$this->sql['having'] = 'having '.$value;break;
			case 'order':$this->sql['order'] = 'order by '.$value;break;
			case 'limit':$value == 'all' ? '' : ($this->sql['limit'] = 'limit '.$value);break;
            case 'page':$this->sql['page'] =intval($value); break;
            case 'pagesize':$this->sql['pagesize'] =intval($value); break;
            case 'pagelength':$this->sql['pagelength'] =intval($value); break;
			case 'distinct':
			{
				if($value)$this->sql['distinct'] = 'distinct';
				else $this->sql['distinct'] = '';
				break;
			}
		}
	}
    /**
     * @brief 实现属性的直接取
     * @param mixed $name
     * @return String
     */
	public function __get($name)
	{
		if(isset($this->sql[$name]))return $this->sql[$name];
	}

    public function __isset($name)
    {
        if(isset($this->sql[$name]))return true;
    }
    /**
     * @brief 取得查询结果
     * @return array
     */
	public function find()
	{
        if( is_int($this->page) )
        {
            $sql="select $this->distinct $this->fields from $this->table $this->join $this->where $this->group $this->having $this->order";
			$pagesize = isset($this->pagesize)?intval($this->pagesize):20;
            $pagelength = isset($this->pagelength)?intval($this->pagelength):10;
            $this->paging = new IPaging($sql,$pagesize,$pagelength);
            return $this->paging->getPage($this->page);
		}
		else
        {
            $sql="select $this->distinct $this->fields from $this->table $this->join $this->where $this->group $this->having $this->order $this->limit";
            return $this->dbo->query($sql);
        }
	}
	/**
	 * @brief 分页展示
	 * @param string $url   URL地址
	 * @param string $attrs URL后接参数
	 * @return string pageBar的对应HTML代码
	 */
    public function getPageBar($url='',$attrs='')
    {
        return $this->paging->getPageBar($url,$attrs);
    }
}
?>
