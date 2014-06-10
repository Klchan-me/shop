<?php
/**
 * @brief 升级更新控制器
 */
class Update extends IController
{
	/**
	 * @brief iwebshop14043000版本升级更新
	 */
	public function iwebshop14043000()
	{
		$sql = array(
			"ALTER TABLE `{TABLE_PRE}order` ADD `trade_no` VARCHAR(255) NULL COMMENT '支付平台交易号'"
		);

		foreach($sql as $key => $val)
		{
			$val = str_replace('{TABLE_PRE}',IWeb::$app->config['DB']['tablePre'],$val);
			IDBFactory::getDB()->query($val);
		}

		die('升级成功！');
	}
}