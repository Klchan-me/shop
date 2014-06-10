
define(function(require, exports, module) {
	var $ =jQuery= require('jquery');
	var flexslider=require('flexslider');
	var login=require('login');
	 $(window).load(function(){
      $('.main_silder .flexslider').flexslider({
        	animation: "slide"
      });
    });
});

