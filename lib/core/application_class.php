<?php
/**
 * @copyright Copyright(c) 2010 jooyea.cn
 * @file application.php
 * @brief 应用的基本类文件
 * @author webning
 * @date 2010-12-10
 * @version 0.6
 */

/**
 * @brief IApplication 创建应用的基本类
 * @class IApplication
 */
abstract class IApplication
{
	//应用的名称
    public $name = 'iWebShop';

    //用户的编码
    public $charset = 'UTF-8';

    //用户的语言
    public $language = 'zh_sc';

    //运行时的路径
	public $runtimePath;

	//运行时的web目录
	public $webRunPath;

    //应用的config信息
    public $config;

    //应用的要目录
    private $basePath;

    //渲染时的数据
    private $renderData = array();

    /**
     * @brief 构造函数
     * @param array or string $config 配置数组或者配置文件名称
     */
    public function __construct($config)
    {
    	IWeb::setApplication($this);

        if(is_file($config))
        {
        	$config = require($config);
        }

        $this->config = is_array($config) ? $config : array();

		//设为if true为了标注以后要再解决cli模式下的basePath;产品实际根路径
		if(isset($_SERVER['SCRIPT_FILENAME']))
		{
			$basePath = dirname($_SERVER['SCRIPT_FILENAME']).DIRECTORY_SEPARATOR;
		}
		else
		{
			//document_root 不存在
			if(!isset($_SERVER['DOCUMENT_ROOT']))
			{
				if(isset($_SERVER['PATH_TRANSLATED']))
				{
					$_SERVER['DOCUMENT_ROOT'] = dirname($_SERVER['PATH_TRANSLATED']);
				}
			}
			$basePath = rtrim(rtrim($_SERVER['DOCUMENT_ROOT'],'\\/').dirname($_SERVER['SCRIPT_NAME']),'\\/').DIRECTORY_SEPARATOR;
		}
		//echo $basePath;

		$this->setBasePath($basePath);
		ini_set('upload_tmp_dir',$basePath.'runtime'.DIRECTORY_SEPARATOR);
		//echo $basePath.'runtime'.DIRECTORY_SEPARATOR;
		ini_set('session.save_path',$basePath.'backup'.DIRECTORY_SEPARATOR);
		date_default_timezone_set(isset($config['timezone']) ? $config['timezone'] : 'Asia/Shanghai');
		IWeb::setClasses(isset($config['classes']) ? $config['classes'] : 'classes.*');
		$this->charset  = isset($config['charset']) ? $config['charset'] : $this->charset;
		$this->language = isset($config['lang']) ? $config['lang'] : $this->language;
		$this->setDebugMode((isset($config['debug']) && $config['debug'] === true) ? true : false);
		//删除魔法转义
		$this->disableMagicQuotes();

		//开始向拦截器里注册类
		//print_r($config);
		if(isset($config['interceptor']) && is_array($config['interceptor']) )
		{
			IInterceptor::reg($config['interceptor']);
			register_shutdown_function(array('IInterceptor',"shutDown"));
		}
    }

    //执行请求
    abstract public function execRequest();
    /**
     * @brief 应用运行的方法
     * @return Void
     */
    public function run()
    {
		IInterceptor::run("onCreateApp");
        $this->execRequest();
		IInterceptor::run("onFinishApp");
    }
    /**
     * @brief 实现应用的结束方法
     * @param int $status 应该结束的状态码
     */
    public function end($status=0)
    {
        exit($status);
    }

    /**
     * @brief 取消魔法转义
     */
    public function disableMagicQuotes()
    {
		if(get_magic_quotes_gpc())
		{
			if(isset($_POST))
			{
				$_POST = $this->stripslashes($_POST);
			}

			if(isset($_GET))
			{
				$_GET = $this->stripslashes($_GET);
			}

			if(isset($_COOKIE))
			{
				$_COOKIE = $this->stripslashes($_COOKIE);
			}

			if(isset($_REQUEST))
			{
				$_REQUEST = $this->stripslashes($_REQUEST);
			}
		}
    }

    /**
     * @brief 辅助disableMagicQuotes();
     */
    private function stripslashes($arr)
    {
    	if(is_array($arr))
		{
			foreach($arr as $key => $value)
			{
				$arr[$key] = $this->stripslashes($value);
			}
			return $arr;
		}
		else
		{
			return stripslashes($arr);
		}
    }

    /**
     * @brief 设置调试模式
     * @param $flag true开启，false关闭
     */
    private function setDebugMode($flag)
    {
    	$basePath = $this->getBasePath();

    	if(function_exists("ini_set"))
		{
			ini_set("display_errors",$flag ? "on" : "off");
		}

    	if($flag === true)
        {
			error_reporting(E_ALL | E_STRICT);
			IException::setDebugMode(true);
        }
		else
		{
			error_reporting(0);
			IException::setDebugMode(false);
		}
		set_error_handler("IException::phpError" , E_ALL|E_STRICT );
		set_exception_handler("IException::phpException");
		IException::setLogPath($basePath."backup/errorLog/".date("y-m-d").".log");
    }

    /**
     * @brief 设置应用的基本路径
     * @param string  $basePath 路径地址
     */
    public function setBasePath($basePath)
    {
    	$this->basePath = $basePath;
    }
    /**
     * @brief 取得应用的路径
     * @return String 路径地址
     */
    public function getBasePath()
    {
        return $this->basePath;
    }
    /**
     * @brief 设置运行时的路径
     * @param mixed $runtimePath 路径地址
     */
    public function setRuntimePath($runtimePath)
    {
        $this->runtimePath = $runtimePath;
    }
    /**
     * @brief 得到当前的运行路径
     * @return String 路径地址
     */
    public function getRuntimePath()
    {
        if($this->runtimePath === null)
        {
            $this->runtimePath = $this->getBasePath().'runtime/';
        }
        return $this->runtimePath;
	}
    /**
     * @brief 得到当前的运行URL路径
     * @return String 路径地址
     */
	public function getWebRunPath()
	{
		if($this->webRunPath === null)
		{
			$this->webRunPath = IUrl::creatUrl('').'runtime/';
		}
		return $this->webRunPath;
	}

    /**
     * @brief 设置渲染数据
     * @param array $data 数组的形式存储，渲染后键值将作为变量名。
     */
    public function setRenderData($data)
    {
        if(is_array($data))
        {
            $this->renderData = array_merge($this->renderData,$data);
        }
    }
    /**
     * @brief 取得应用级的渲染数据
     * @return array
     */
    public function getRenderData()
    {
        return $this->renderData;
    }
}