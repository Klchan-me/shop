<?php
/**
 * @copyright (c) 2011 jooyea.cn
 * @file error_class.php
 * @brief Error处理
 * @author chendeshan
 * @date 2010-12-17
 * @version 0.6
 */

/**
 * @class IError
 * @brief IError 错误处理类
 */
class IError
{
	/**
	 * @brief 获取控制器
	 * @return object 控制器对象
	 */
	public static function getController()
	{
		return IWeb::$app->controller;
	}

	/**
	 * @brief 报错 [适合在逻辑(非视图)中使用,此方法支持数据渲染]
	 * @param string $httpNum   HTTP错误代码
	 * @param array  $errorData 错误数据
	 */
	public static function show($httpNum,$errorData = array())
	{
		$controller = self::getController();

		//初始化页面数据
		$showData   = array(
			'title'   => null,
			'heading' => null,
			'message' => null,
		);

		if(is_array($errorData))
		{
			$showData['title']   = isset($errorData['title'])   ? $errorData['title']   : null;
			$showData['heading'] = isset($errorData['heading']) ? $errorData['heading'] : null;
			$showData['message'] = isset($errorData['message']) ? $errorData['message'] : null;
		}
		else
		{
			$showData['message'] = $errorData;
		}

		//检查用户是否定义了error处理类
		if(method_exists('Error','error'.$httpNum))
		{
			$errorObj = new Error(IWeb::$app,'error');
			call_user_func(array($errorObj,'error'.$httpNum),$showData);
		}

		//是系统内置的错误机制
		else if(file_exists(IWEB_PATH.'web/view/'.'error'.$httpNum.$controller->extend))
		{
			$controller->render(IWEB_PATH.'web/view/'.'error'.$httpNum,$showData);
		}

		//输出错误信息
		else
		{
			$controller->renderText($showData['message']);
		}
		exit;
	}
}
?>
