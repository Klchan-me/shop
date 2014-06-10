<?php
/**
 * @copyright (c) 2011 [group]
 * @file CheckRight.php
 * @brief 权限校验类
 * @author chendeshan
 * @date 2011-7-8 14:12:32
 * @version 0.6
 */
class CheckRights extends IInterceptorBase
{
	//后台管理员权限校验
	public static function checkAdminRights()
	{
		$object = IWeb::$app->getController();

		$admin                    = array();
		$admin['admin_id']        = ISafe::get('admin_id');
		$admin['admin_name']      = ISafe::get('admin_name');
		$admin['admin_pwd']       = ISafe::get('admin_pwd');
		$admin['admin_role_name'] = ISafe::get('admin_role_name');

		if($admin['admin_name'] == null || $admin['admin_pwd'] == null)
		{
			$object->redirect('/systemadmin/index');
			exit;
		}

		$adminObj = new IModel('admin');
		$adminRow = $adminObj->getObj("admin_name = '{$admin['admin_name']}'");
		if($adminRow && ($adminRow['password'] == $admin['admin_pwd']) && ($adminRow['is_del'] == 0))
		{
			//非超管角色
			if($adminRow['role_id'] != 0)
			{
				$roleObj = new IModel('admin_role');
				$where   = 'id = '.$adminRow["role_id"].' and is_del = 0';
				$roleRow = $roleObj->getObj($where);

				//角色权限校验
				if(self::checkRight($roleRow['rights']) == false)
				{
					IError::show('503','no permission to access');
					exit;
				}
			}
			$object->admin = $admin;
		}
		else
		{
			IError::show('503','no permission to access');
			exit;
		}
	}

	//注册会员身份校验
	public static function checkUserRights()
	{
		$object = IWeb::$app->getController();

		$user             = array();
		$user['user_id']  = intval(ISafe::get('user_id'));
		$user['username'] = ISafe::get('username');
		$user['head_ico'] = ISafe::get('head_ico');
		$user['user_pwd'] = ISafe::get('user_pwd');

		if(self::isValidUser($user['username'],$user['user_pwd']))
		{
			$object->user = $user;
		}
		else
		{
			ISafe::clear('user_id');
			ISafe::clear('user_pwd');
			ISafe::clear('username');
			ISafe::clear('head_ico');
		}
	}

	/**
	 * @brief  校验用户的合法性
	 * @param  string $login_info 用户名或者email
	 * @param  string $password   用户名的md5密码
	 * @return false or array 如果合法则返回用户数据;不合法返回false
	 */
	public static function isValidUser($login_info,$password)
	{
		$login_info = IFilter::act($login_info);
		$password   = IFilter::act($password);

		$userObj = new IModel('user as u,member as m');
		$where   = 'u.username = "'.$login_info.'" and m.status = 1 and u.id = m.user_id';
		$userRow = $userObj->getObj($where);

		if(empty($userRow))
		{
			$where   = 'email = "'.$login_info.'" and m.status = 1 and u.id = m.user_id';
			$userRow = $userObj->getObj($where);
		}

		if(empty($userRow) || ($userRow['password'] != $password))
		{
			return false;
		}
		else
		{
			return $userRow;
		}
	}

	/**
	 * @brief 权限校验拦截
	 * @param string $ownRight 用户的权限码
	 * @return bool true:校验通过; false:校验未通过
	 */
	private static function checkRight($ownRight)
	{
		$controllerInstance = IWeb::$app->getController();
		$actionId           = $controllerInstance->getAction()->getId();

		//是否需要权限校验 true:需要; false:不需要
		$isCheckRight = false;
		if($controllerInstance->checkRight == 'all')
		{
			$isCheckRight = true;
		}
		else if(is_array($controllerInstance->checkRight))
		{
			if(isset($controllerInstance->checkRight['check']) && ( ($controllerInstance->checkRight['check'] == 'all') || ( is_array($controllerInstance->checkRight['check']) && in_array($actionId,$controllerInstance->checkRight['check']) ) ) )
			{
				$isCheckRight = true;
			}

			if(isset($controllerInstance->checkRight['uncheck']) && is_array($controllerInstance->checkRight['uncheck']) && in_array($actionId,$controllerInstance->checkRight['uncheck']))
			{
				$isCheckRight = false;
			}
		}

		//需要校验权限
		if($isCheckRight == true)
		{
			$rightCode = $controllerInstance->getId().'@'.$actionId; //拼接的权限校验码
			$ownRight  = ','.trim($ownRight,',').',';

			if(stripos($ownRight,','.$rightCode.',') === false)
				return false;
			else
				return true;
		}
		else
			return true;
	}

	/**
	 * 创建动作拦截
	 */
	public static function onCreateAction()
	{
		self::checkAdminRights();
	}
}