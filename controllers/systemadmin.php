<?php
/**
 * @class SystemAdmin
 * @brief 后台登陆处理
 */
class SystemAdmin extends IController
{
	public $layout='';

	//后台登陆
	function login_act()
	{
		$admin_name = IFilter::act(IReq::get('admin_name'));
		$password   = IReq::get('password');
		$captcha    = IReq::get('captcha','post');

		$message    = '';

		if($admin_name == '')
		{
			$message = '登录名不能为空';
		}
		else if($password == '')
		{
			$message = '密码不能为空';
		}
		else if($captcha != ISafe::get('captcha'))
		{
            $message = '验证码输入不正确';
        }
        else
		{
			$adminObj = new IModel('admin');
			$adminRow = $adminObj->getObj('admin_name = "'.$admin_name.'"');
			if(!empty($adminRow) && ($adminRow['password'] == md5($password)) && ($adminRow['is_del'] == 0))
			{
				$dataArray = array(
					'last_ip'   => IClient::getIp(),
					'last_time' => ITime::getDateTime(),
				);
				$adminObj->setData($dataArray);
				$where = 'id = '.$adminRow["id"];
				$adminObj->update($where);

				//根据角色分配权限
				if($adminRow['role_id'] == 0)
				{
					ISession::set('admin_right','administrator');
					ISafe::set('admin_role_name','超级管理员');
				}
				else
				{
					$roleObj = new IModel('admin_role');
					$where   = 'id = '.$adminRow["role_id"].' and is_del = 0';
					$roleRow = $roleObj->getObj($where);
					ISession::set('admin_right',$roleRow['rights']);
					ISafe::set('admin_role_name',$roleRow['name']);
				}
				ISafe::set('admin_id',$adminRow['id']);
				ISafe::set('admin_name',$adminRow['admin_name']);
				ISafe::set('admin_pwd',$adminRow['password']);
				$this->redirect('/system/default');
			}
			else
			{
				$message = '用户名与密码不匹配';
			}
		}

		if($message != '')
		{
			$this->admin_name = $admin_name;
			$this->redirect('index',false);
			Util::showMessage($message);
		}
	}

	//后台登出
	function logout()
	{
    	ISafe::clear('admin_id');
    	ISafe::clear('admin_right');
    	ISafe::clear('admin_name');
    	ISafe::clear('admin_pwd');
    	ISafe::clearAll();
    	$this->redirect('index');
	}
}
?>
