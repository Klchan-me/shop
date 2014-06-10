<?php
/**
 * @copyright Copyright(c) 2011 jooyea.cn
 * @file paging_class.php
 * @brief 分页处理类
 * @author webning
 * @date 2011-04-09
 * @version 0.6
 * @note
 */
/**
 * @brief IPaging 分页处理类
 * @class IPaging
 * @note
 */
class IPaging
{
	private $fields;
	private $dbo;
	private $sql;
	private $rows;
	public $index;//当前页数
	public $totalpage;//总页数
	public $pagesize;//每页的条数
	public $firstpage;//第一页
	public $lastpage;//最后一页
	public $pagelength;//要展示的页面数
    /**
     * @brief 构造函数
     * @param string $sql 要分页的SQL语句
     * @param int $pagesize 每页的记录
     * @param int $pagelength 展示pageBar的页数
     */
	public function __construct($sql="",$pagesize=20,$pagelength=10)
	{
		$this->pagesize=$pagesize;
		$this->pagelength=$pagelength;
		$this->dbo=IDBFactory::getDB();
		if($sql!="")
		{
			$this->setSql($sql);
		}
	}
    /**
     * @brief 分析要分页的SQl语句
     * @param string $sql SQL语句
     */
	public function setSql($sql)
	{
		$this->sql=$sql;
        if(strpos($sql,'GROUP BY') === false)
        {
	        $endstr = strstr($this->sql,'from');
	        $endstr = preg_replace('/^(.*)order\s+by.+$/i','$1',$endstr);
        	$count=$this->dbo->query("select count(*) as total ".$endstr);
        }
        else
        {
        	$count=$this->dbo->query("select count(*) as total from (".$sql.") as IPaging");
        }

		$this->rows=isset($count[0]['total']) ? $count[0]['total'] : 0;
		$this->firstpage=1;
		$this->totalpage=floor(($this->rows-1)/$this->pagesize)+1;
		$this->lastpage=$this->firstpage+$this->totalpage-1;
		if($this->lastpage>$this->totalpage)$this->lastpage=$this->totalpage;
	}
    /**
     * @brief 得到对应要查询分页的数据内容
     * @param int  $page要查询的页数
     * @return Array 数据
     */
	public function getPage($page)
	{
		$page=intval($page);
		$this->index=$page;
		if($page<=0)$this->index=1;
		if($this->totalpage>0)
		{
			if($page>$this->totalpage)$this->index=$this->totalpage;
			$this->firstpage=$this->index-floor($this->pagelength/2);
			if($this->firstpage<=0)$this->firstpage=1;
			$this->lastpage=$this->firstpage+$this->pagelength-1;
			if($this->lastpage>$this->totalpage)
			{
				$this->lastpage=$this->totalpage;
				$this->firstpage=($this->totalpage-$this->pagelength+1)>1?$this->totalpage-$this->pagelength+1:1;
			}
			return $this->dbo->query($this->sql." limit ".($this->index-1)*$this->pagesize.",".($this->pagesize));
		}
		else return array();
	}
    /**
     * @brief 获取当前分页数
	 * @return int 分页数
	 */
	public function getIndex()
	{
		return $this->index;
	}
    /**
     * @brief 获取分页总数
	 * @return int 分页总数
	 */
	public function getTotalPage()
	{
		return $this->totalpage;
	}
    /**
     * @brief 设置展示的分页数量
	 * @return int 分页数量
	 */
	public function setPageLength($legth)
	{
		$this->pagelength=$legth;
	}
    /**
     * @brief 获取展示的分页数量
	 * @return int 分页长度
	 */
	public function getPageLength()
	{
		return $this->pagelength;
	}
    /**
     * @brief 设置每页的数据条数
     * @return int 数据条数
	 */
	public function setPageSize($size)
	{
		$this->pagesize  = $size;
		$this->totalpage = floor(($this->rows-1)/$this->pagesize)+1;
	}
    /**
     * @brief 得到单页要展示的数据条数
     * @return int 数据条数
     */
	public function getPageSize()
	{
		return $this->pagesize;
	}
    /**
     * @brief 当前pageBar的第一页
     * @return int 当前pageBar的第一页
     */
	public function getFirstPage()
	{
		return $this->firstpage;
	}
    /**
     * @brief 当前pageBar最得最后一页的页数
     * @return int 当前pageBar最后一页的页数
     */
	public function getLastPage()
	{
		return $this->lastpage;
	}
    /**
     * @brief 取得pageBar
     * @param string $url URL地址，一般为空！
     * @param string $attrs URL后接参数
     * @return string pageBar的对应HTML代码
     */
	public function getPageBar($url='', $attrs='')
	{
        $attr = '';
        if($attrs != '')
        {
            $ajax_attr = " {$attrs} ";
        }
        $flag = false;
        if($url=='')
        {
            $flag = true;
            $url = IUrl::getUri();
            $url = preg_replace('/page=\d?&/','',$url);
            $url = preg_replace('/(\?|&|\/)page(\/|=).*/i','',$url);
            $mark = '=';
            if(strpos($url,'?') !== false)
                $index = '&page';
            else
                $index = '?page';
        }
        else
        {
            $flag = false;
            $index='';
            $mark='';
        }

        $baseUrl = "{$url}{$index}{$mark}";
        $baseUrl = IFilter::act($baseUrl,'text');

        $attr = str_replace('[page]',1,$attrs);
        $href = $baseUrl.($flag?1:'');
		$tem="<div class='pages_bar'><a href='{$href}' {$attr}>首页</a>";

        $attr = str_replace('[page]',$this->getIndex()-1,$attrs);
        $href = $baseUrl.($flag?$this->getIndex()-1:'');
		if($this->firstpage>1)$tem.="<a href='{$href}' {$attr}>上一页</a>";

		for($i=$this->firstpage;$i<=$this->lastpage;$i++)
		{
            $attr = str_replace('[page]',$i,$attrs);
            $href = $baseUrl.($flag?$i:'');
			if($i==$this->index)
			{
				$tem.="<a class='current_page' href='{$href}' {$attr}>{$i}</a>";
			}
			else
			{
				$tem.="<a href='{$href}' {$attr}>{$i}</a>";
			}
		}

        $attr = str_replace('[page]',$this->getIndex()+1,$attrs);
        $href = $baseUrl.($flag?$this->getIndex()+1:'');
		if($this->lastpage<$this->totalpage)$tem.="<a href='{$href}' {$attr}>下一页</a>";

		if($this->totalpage==0)$this->index=1;
		$attr = str_replace('[page]',$this->totalpage,$attrs);
		$href = $baseUrl.($flag?$this->totalpage:'');
		return $tem."<a href='{$href}' {$attr}>尾页</a><span>当前第{$this->index}页/共{$this->totalpage}页</span></div>";
	}
}
?>
