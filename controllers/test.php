<?php
class Test extends IController{
	
	public $layout='site';
	
	public function hello(){
		$shopTest=new shopTest();
		echo $shopTest->show();
	}
}