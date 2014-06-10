//操作flex的JS类
function printExpress()
{
	this.flashObj = document.getElementById('printExpress');

	this.setModeByJS    = function(mode){this.flashObj.setModeByJS(mode);};
	this.createTextarea = function(obj){this.flashObj.createItem(obj);};
	this.createText     = function(obj){this.flashObj.createItem(obj,'text');};
	this.delTextarea    = function(){this.flashObj.removeItemByJS();};
	this.backgroundPic  = function(picUrl){this.flashObj.backgroundPicByJS(picUrl);};
	this.saveExpress    = function(actionUrl,postData){this.flashObj.saveComponent(actionUrl,postData);};
	this.printStart     = function(){this.flashObj.printExpressByJS();};
	this.editStyle      = function(obj){this.flashObj.editStyleByJS(obj);};
	this.setAppRange    = function(w,h){this.flashObj.setAppRangeByJS(w,h);};
	this.setPrintObject = function(printObj){this.flashObj.setPrintObjectByJS(printObj);};
}