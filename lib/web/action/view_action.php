<?php
/**
 * @copyright (c) 2009-2011 jooyea.cn
 * @file view_action.php
 * @brief 视图动作
 * @author Ben
 * @date 2010-12-16
 * @version 0.6
 */

/**
 * @class IViewAction
 * @brief 视图动作
 */
class IViewAction extends IAction
{
	public $defaultView = 'index';
	public $viewPath;
	public $view;
	public $basePath;

	/**
	 * @brief 执行视图渲染
	 * @return 视图
	 */
	public function run()
	{
		IInterceptor::run("onCreateView");
		$controller = $this->getController();
		$this->resolveView($this->getView());
		$data = null;

		if(!file_exists($this->view.$controller->extend))
		{
			$path = $this->view.$controller->extend;
			$path = IException::pathFilter($path);
			$data = array(
				'title'   => 'HTTP 404',
				'heading' => 'not found',
				'message' => "not found this view page($path)",
			);
			throw new IHttpException($data,404);
		}
		else
		{
			$controller->render($this->view,$data);
		}
		IInterceptor::run("onFinishView");
	}

	/**
	 * @brief 获取视图
	 * @return string 获取视图
	 */
	public function getView()
	{
		if($this->viewPath===null)
		{
			$action = $this->getId();
			if(!empty($action))
				$this->viewPath = $action;
			else
				$this->viewPath = $this->defaultView;
		}
		return $this->viewPath;
	}

	/**
	 * @brief 解析视图路径
	 * @param string $viewPath 视图名称
	 * @return bool
	 */
	public function resolveView($viewPath)
	{
		if(preg_match('/^\w[\w\-]*$/',$viewPath))
		{
			//分割模板目录的层次
			$view = strtr($viewPath,'-','/');
			$this->basePath = $this->getController()->getViewFile($view);
			if($this->basePath)
			{
				$this->view = $this->basePath;
				return;
			}
		}
		else
		{
			$viewPath = IException::pathFilter($viewPath);
			throw new IHttpException("the view filename({$viewPath}) is wrong",403);
		}
	}
}