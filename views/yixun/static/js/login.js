define(function(require, exports, module) {
	var $ =jQuery= require('jquery');
	var login={
		mouseEnterAndOut:function(parent,subClass){
			parent.hover(function(){
				$(this).addClass(subClass);
			},function(){
				$(this).removeClass(subClass);
			});
		}
	};
	login.mouseEnterAndOut($(".mod_dropmenu"),'mod_dropmenu_on');
	login.mouseEnterAndOut($('.mod_minicart'),'mod_minicart_on');
	exports.login=login;
});