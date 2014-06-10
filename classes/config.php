<?php
/**
 * @copyright Copyright(c) 2011 jooyea.cn
 * @file config.php
 * @brief
 * @author webning
 * @date 2011-03-24
 * @version 0.6
 * @note
 */
/**
 * @brief Config 产品中所有Config文件取值统一入口文件
 * @class Config
 */
class Config
{
	//不需要过滤的键名
	private static $safeKey = array('index_slide','service_online');
	private $configFile;
    private $config;
    /**
     * @brief 初始化对应的config文件
     * @param String $config config文件名
     */
    public function __construct($config)
    {
        $this->initConfig($config);
    }

    /**
     * @brief 设定Config文件
     * @param String $config config文件名
     */
    public function setConfig($config)
    {
        $this->initConfig($config);
    }

    /**
     * @brief 获取全部的config信息
     */
    public function getInfo()
    {
    	return $this->config;
    }

    /**
     * @brief  初始化对应的config文件
     * @param String $config config文件名
     * @return Array 或者为null
     */
    private function initConfig($config)
    {
        if(isset(IWeb::$app->config['configExt'][$config]))
        {
        	$this->configFile = IWeb::$app->getBasePath().IWeb::$app->config['configExt'][$config];
        	$this->config     = include($this->configFile);
        }
        else
        	$this->config = null;
    }

    /**
     * @brief 取得当前Config文件下的对应变量
     * @param String $name 变量名
     * @return mixed
     * @note 此函数可自由扩展自己对应的默认值
     */
    public function __get($name)
    {
        if(isset($this->config[$name]))
        {
            return $this->config[$name];
        }
        return '';
    }

    /**
     * @brief 取得当前Config文件下的对应变量
     * @param String $name 变量名
     * @return mixed
     * @note 此函数可自由扩展自己对应的默认值
     */
    public function write($inputArray)
    {
    	self::edit($this->configFile , $inputArray);
    }

	/**
	 * @brief 修改配置文件信息
	 * @param string 配置文件名
	 * @param array  写入的配置内容 key:配置信息里面key值; value:配置信息里面的value值
	 */
	public static function edit($configFile,$inputArray)
	{
		//安全过滤要写入文件的内容
		foreach($inputArray as $key => $val)
		{
			if(!in_array($key,self::$safeKey))
			{
				$inputArray[$key] = IFilter::act($val,'text');
			}
		}

		$configStr = "";

		//读取配置信息内容
		if(file_exists($configFile))
		{
			$configStr   = file_get_contents($configFile);
			$configArray = include($configFile);
		}

		if(trim($configStr)=="")
		{
			$configStr   = "<?php return array( \r\n);?>";
			$configArray = array();
		}

		//表单中存在但是不进行录用的键值
		$except = array('form_index');

		foreach($except as $value)
		{
			unset($inputArray[$value]);
		}

		$inputArray = array_merge($configArray,$inputArray);
		$configData = var_export($inputArray,true);
		$configStr = "<?php return {$configData}?>";

		//写入配置文件
		$fileObj   = new IFile($configFile,'w+');
		$fileObj->write($configStr);
	}
}
?>
