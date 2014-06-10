<?php
/**
 * @copyright (c) 2011 jooyea.cn
 * @file controller_class.php
 * @brief 控制器类,控制action动作,渲染页面
 * @author chendeshan
 * @date 2010-12-16
 * @version 0.6
 */

/**
 * @class IController
 * @brief 控制器
 */
class IController extends IControllerBase
{
	public $theme                = 'default';          //主题方案
	public $skin                 = 'default';          //风格方案
	public $layout               = 'main';             //布局文件
	public $extend               = '.html';            //模板扩展名

	protected $lang              = '';                 //语言包方案
	protected $module            = null;               //隶属于模块的对象
	protected $ctrlId            = null;               //控制器ID标识符

	protected $defaultViewPath   = 'views';            //默认视图目录
	protected $defaultLayoutPath = 'layouts';          //默认布局目录
	protected $defaultLangPath   = 'language';         //默认语言目录
	protected $defaultSkinPath   = 'skin';             //默认皮肤目录
	protected $defaultExecuteExt = '.php';             //默认编译后文件扩展名

	private $action;                                   //当前action对象
	private $defaultAction = 'index';                  //默认执行的action动作
	private $renderData    = array();                  //渲染的数据

	/**
	 * @brief 构造函数
	 * @param string $ctrlId 控制器ID标识符
	 * @param string $module 控制器所包含的模块
	 */
	public function __construct($module,$controllerId)
	{
		$this->module = $module;
		$this->ctrlId = $controllerId;

		//初始化theme方案
		if(isset($this->module->config['theme']))
		{
			//根据不同的客户端进行智能选择
			if(is_array($this->module->config['theme']))
			{
				$client = IClient::getDevice();
				$this->theme = isset($this->module->config['theme'][$client]) ? $this->module->config['theme'][$client] : current($this->module->config['theme']);
			}
			else
			{
				$this->theme = $this->module->config['theme'];
			}
		}

		//初始化skin方案
		if(isset($this->module->config['skin']))
		{
			//根据不同的客户端进行智能选择
			if(is_array($this->module->config['skin']))
			{
				$client = IClient::getDevice();
				$this->skin = isset($this->module->config['skin'][$client]) ? $this->module->config['skin'][$client] : current($this->module->config['skin']);
			}
			else
			{
				$this->skin = $this->module->config['skin'];
			}
		}

		//初始化lang方案
		$this->lang = $this->module->language;

		//修正runtime配置
		$this->module->runtimePath = $this->module->getRuntimePath().$this->theme.'/';
		$this->module->webRunPath  = $this->module->getWebRunPath().$this->theme.'/';
	}

	/**
	 * @brief 生成验证码
	 * @return image图像
	 */
	public function getCaptcha()
	{
		//清空布局
		$this->layout = '';

		//配置参数
		$width      = intval(IReq::get('w')) == 0 ? 130 : IReq::get('w');
		$height     = intval(IReq::get('h')) == 0 ? 45  : IReq::get('h');
		$wordLength = intval(IReq::get('l')) == 0 ? 5   : IReq::get('l');
		$fontSize   = intval(IReq::get('s')) == 0 ? 25  : IReq::get('s');

		//创建验证码
		$ValidateObj = new Captcha();
		$ValidateObj->width  = $width;
		$ValidateObj->height = $height;
		$ValidateObj->maxWordLength = $wordLength;
		$ValidateObj->minWordLength = $wordLength;
		$ValidateObj->fontSize      = $fontSize;
		$ValidateObj->CreateImage($text);

		//设置验证码
		ISafe::set('captcha',$text);
	}
	/**
	 * @brief 获取当前控制器的id标识符
	 * @return 控制器的id标识符
	 */
	public function getId()
	{
		return $this->ctrlId;
	}

	/**
	 * @brief 初始化controller对象
	 */
	public function init()
	{
	}

	/**
	 * @brief 过滤函数
	 * @return array 初始化
	 */
	public function filters()
	{
		return array();
	}

	/**
	 * @brief 获取当前action对象
	 * @return object 返回当前action对象
	 */
	public function getAction()
	{
		return $this->action;
	}

	/**
	 * @brief 设置当前action对象
	 * @param object $actionObj 对象
	 */
	public function setAction($actionObj)
	{
		$this->action = $actionObj;
	}

	/**
	 * @brief 执行action方法
	 */
	public function run()
	{
		//开启缓冲区
		ob_start();
		ob_implicit_flush(false);

		header("content-type:text/html;charset=".$this->module->charset);

		//初始化控制器
		$this->init();

		//创建action对象
		$actionObj = $this->createAction();
		IInterceptor::run("onCreateAction");
		$actionObj->run();
		IInterceptor::run("onFinishAction");
		flush();
		IWeb::$app->end(0);
	}

	/**
	 * @brief 创建action动作
	 * @return object 返回action动作对象
	 */
	public function createAction()
	{
		//获取action的标识符
		$actionId = IUrl::getInfo('action');

		//设置默认的action动作
		if($actionId == '')
		{
			$actionId = $this->defaultAction;
		}

		/*创建action对象流程
		 *1,控制器内部动作
		 *2,配置动作
		 *3,视图动作*/

		//1,控制器内部动作
		if(method_exists($this,$actionId))
		{
			$this->action = new IInlineAction($this,$actionId);
		}
		//2,配置动作
		else if(($actions = $this->actions()) && isset($actions[$actionId]))
		{
			//自定义类名
			$className = $actions[$actionId]['class'];
			$this->action = new $className($this,$actionId);
		}
		//3,视图动作
		else
			$this->action = new IViewAction($this,$actionId);

		return $this->action;
	}

	/**
	 * @brief 预定义的action动作
	 * @return array 动作信息
	 */
	public function actions()
	{
		return array();
	}

	/**
	 * @brief 渲染
	 * @param string $view 要渲染的视图文件
	 * @param string or array 要渲染的数据
	 * @param bool $return 渲染类型
	 * @return 渲染出来的数据
	 */
	public function render($view,$data=null,$return=false)
	{
		$output = $this->renderView($view,$data);
		if($return)
			return $output;
		else
			echo $output;
	}

	/**
	 * @brief 渲染出静态文字
	 * @param string $text 要渲染的静态数据
	 * @param bool $return 输出方式 值: true:返回; false:直接输出;
	 * @return string 静态数据
	 */
	public function renderText($text,$return=false)
	{
		$text = $this->tagResolve($text);
		if($return)
			return $text;
		else
			echo $text;
	}

	/**
	 * @brief 获取当前主题下的视图路径
	 * @return string 视图路径
	 */
	public function themeDir()
	{
		return isset($this->module->config['viewPath']) ? $this->module->config['viewPath'] : $this->defaultViewPath;
	}

	/**
	 * @brief 获取当前主题下的视图路径
	 * @return string 视图路径
	 */
	public function skinDir()
	{
		return isset($this->module->config['skinPath']) ? $this->module->config['skinPath'] : $this->defaultSkinPath;
	}

	/**
	 * @brief 获取当前主题下的视图路径
	 * @return string 视图路径
	 */
	public function langDir()
	{
		return isset($this->module->config['langPath']) ? $this->module->config['langPath'] : $this->defaultLangPath;
	}

	/**
	 * @brief 获取当前主题下的视图路径
	 * @return string 视图路径
	 */
	public function getViewPath()
	{
		if(!isset($this->_viewPath))
		{
			$viewPath        = $this->themeDir();
			$this->_viewPath = $this->module->getBasePath().$viewPath.DIRECTORY_SEPARATOR.$this->theme.DIRECTORY_SEPARATOR;
		}
		return $this->_viewPath;
	}

	/**
	 * @brief 获取当前主题下的皮肤路径
	 * @return string 皮肤路径
	 */
	public function getSkinPath()
	{
		if(!isset($this->_skinPath))
		{
			$skinPath        = $this->skinDir();
			$this->_skinPath = $this->getViewPath().$skinPath.DIRECTORY_SEPARATOR.$this->skin.DIRECTORY_SEPARATOR;
		}
		return $this->_skinPath;
	}

	/**
	 * @brief 获取当前语言包方案的路径
	 * @return string 语言包路径
	 */
	public function getLangPath()
	{
		if(!isset($this->_langPath))
		{
			$langPath        = $this->langDir();
			$this->_langPath = $this->module->getBasePath().$langPath.DIRECTORY_SEPARATOR.$this->lang.DIRECTORY_SEPARATOR;
		}
		return $this->_langPath;
	}

	/**
	 * @brief 获取layout文件路径(无扩展名)
	 * @return string layout路径
	 */
	public function getLayoutFile()
	{
		if($this->layout == null)
			return false;

		return $this->getViewPath().$this->defaultLayoutPath.DIRECTORY_SEPARATOR.$this->layout;
	}

	/**
	 * @brief 取得视图文件路径(无扩展名)
	 * @param string $viewName 视图文件名
	 * @return string 视图文件路径
	 */
	public function getViewFile($viewName)
	{
		return $this->getViewPath().strtolower($this->ctrlId).DIRECTORY_SEPARATOR.$viewName;
	}

	/**
	 * @brief 获取要渲染的数据
	 * @return array 渲染的数据
	 */
	public function getRenderData()
	{
		return $this->renderData;
	}

	/**
	 * @brief 设置要渲染的数据
	 * @param array $data 渲染的数据数组
	 */
	public function setRenderData($data)
	{
		if(is_array($data))
			$this->renderData = array_merge($this->renderData,$data);
	}

	/**
	 * @brief 视图重定位
	 * @param string $next     下一步要执行的动作或者路径名,注:当首字符为'/'时，则支持跨控制器操作
	 * @param bool   $location 是否重定位 true:是 false:否
	 */
	public function redirect($nextUrl, $location = true, $data = null)
	{
		if(strpos($nextUrl,'http') === 0)
		{
			header('location: '.$nextUrl);
			IWeb::$app->end(0);
		}

		//获取当前的action动作
		$actionId = IReq::get('action');
		if($actionId === null)
		{
			$actionId = $this->defaultAction;
		}

		//分析$nextAction 支持跨控制器跳转
		$nextUrl = strtr($nextUrl,'\\','/');

		if($nextUrl[0] != '/')
		{
			//重定跳转定向
			if($actionId!=$nextUrl && $location == true)
			{
				$locationUrl = IUrl::creatUrl('/'.$this->ctrlId.'/'.$nextUrl);
				header('location: '.$locationUrl);
				IWeb::$app->end(0);
			}
			//非重定向
			else
			{
				$this->action = new IViewAction($this,$nextUrl);
				$this->action->run();
			}
		}
		else
		{
			$urlArray   = explode('/',$nextUrl,4);
			$ctrlId     = isset($urlArray[1]) ? $urlArray[1] : '';
			$nextAction = isset($urlArray[2]) ? $urlArray[2] : '';

			//重定跳转定向
			if($location == true)
			{
				//url参数
				if(isset($urlArray[3]))
				{
					$nextAction .= '/'.$urlArray[3];
				}
				$locationUrl = IUrl::creatUrl('/'.$ctrlId.'/'.$nextAction);
				header('location: '.$locationUrl);
				IWeb::$app->end(0);
			}
			//非重定向
			else
			{
				$nextCtrlObj = new $ctrlId($this->module,$ctrlId);

				//跨控制器渲染数据
				if($data != null)
				{
					$nextCtrlObj->setRenderData($data);
				}
				$nextCtrlObj->init();
				$nextViewObj = new IViewAction($nextCtrlObj,$nextAction);
				$nextViewObj->run();
			}
		}
	}
}
