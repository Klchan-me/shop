/**模拟事件*/
function FireEvent(elem, eventName)
{
	if (document.all)
	{
		elem.fireEvent(eventName);
	}
	else
	{
		 var evt = document.createEvent('HTMLEvents');
		 eventName = eventName.substring(2);
		 evt.initEvent(eventName,true,true);
		 elem.dispatchEvent(evt);
	}
}