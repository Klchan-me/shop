(function autoValidate()
{
	addEvent(window,'load',init);
	function addEvent(obj, type, fn)
	{
		if (obj.attachEvent)
		{
			obj['e'+type+fn] = fn;
			obj[type+fn] = function(){obj['e'+type+fn]( window.event );}
			obj.attachEvent('on'+type, obj[type+fn]);
		}
		else
			obj.addEventListener(type, fn, false);
	}
	function FireEvent(elem, eventName)
	{
		if (document.all)
		{
			elem.fireEvent(eventName);
		}
		else
		{
			 var evt = document.createEvent('HTMLEvents');
			 evt.initEvent('change',true,true);
			 elem.dispatchEvent(evt);
		}
	}
	function removeEvent(obj, type, fn)
	{
		if (obj.detachEvent)
		{
			obj.detachEvent('on'+type, obj[type+fn]);
			obj[type+fn] = null;
		}
		else
		{
			obj.removeEventListener(type, fn, false);
		}
	}
    function init()
    {
        for(var i = 0; i < document.forms.length; i++)
        {
            var f = document.forms[i];
            var needsValidation = false;
            for(j = 0; j < f.elements.length; j++)
            {
                var e = f.elements[j];
                if(e.type != "text" && e.type!="password" && e.type!='select-one' && e.type!='textarea') continue;
                var pattern = e.getAttribute("pattern");
                var required = e.getAttribute("required") != null;
                if(required && !pattern)
                {
                    pattern = "\\S";
                    e.setAttribute("pattern", pattern);
                }
                if(pattern)
                {
					addEvent(e,'change',validateOnChange);
                    needsValidation = true;
                }
            }
            if(needsValidation)
            {
            	f.onsubmit = validateOnSubmit;f.setAttribute('novalidate','true');
            }
        }
    }
    function validateOnChange()
    {
        var textfield = this;
        var pattern = textfield.getAttribute("pattern");
		switch(pattern)
		{
			case 'required': pattern = /\S+/i;break;
			case 'email': pattern = /^\w+([-+.]\w+)*@\w+([-.]\w+)+$/i;break;
			case 'qq':  pattern = /^[1-9][0-9]{4,}$/i;break;
			case 'id': pattern = /^\d{15}(\d{2}[0-9x])?$/i;break;
			case 'ip': pattern = /^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$/i;break;
			case 'zip': pattern = /^\d{6}$/i;break;
			case 'mobi': pattern = /^[0-9]{8,20}$/;break;
			case 'phone': pattern = /^((\d{3,4})|\d{3,4}-)?\d{7,8}(-\d+)*$/i;break;
			case 'url': pattern = /^[a-zA-z]+:\/\/(\w+(-\w+)*)(\.(\w+(-\w+)*))+(\/?\S*)?$/i;break;
			case 'date': pattern = /^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)$/i;break;
			case 'datetime': pattern = /^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29) (?:(?:[0-1][0-9])|(?:2[0-3])):(?:[0-5][0-9]):(?:[0-5][0-9])$/i;break;
			case 'int':	pattern = /^\d+$/i;break;
			case 'float': pattern = /^\d+\.?\d*$/i;break;
		}
        var value = this.value;
        var alt = textfield.getAttribute("alt");
		var empty = textfield.getAttribute("empty");

        if((empty==null && value=='') || (value!='' && value.search(pattern) == -1))
        {
        	textfield.className=textfield.className.replace("invalid-text","");
			textfield.className=textfield.className.replace("valid-text","");
        	 if(textfield.className.indexOf("invalid-text")==-1)textfield.className += " invalid-text";
        	 msg=textfield.nextSibling;
			 while(msg && msg.nodeType==3)msg=msg.nextSibling;
        	 if(msg && (msg.tagName=='LABEL' || msg.tagName=='SPAN'))
        	 {
        	 	msg.className = "invalid-msg";
				if(textfield.getAttribute('initmsg')==null) textfield.setAttribute('initmsg', msg.innerHTML);
        	 	msg.innerHTML=alt;
        	 }
        	 else if(alt!=null)
        	 {
        	 	 var new_msg=document.createElement("LABEL");
        	 	 new_msg.className = "invalid-msg";
				 if(textfield.getAttribute('initmsg')==null) textfield.setAttribute('initmsg', '');
        	 	 new_msg.innerHTML=alt;
				 textfield.parentNode.insertBefore(new_msg,msg);
        	 }
        }
        else
        {
        	textfield.className=textfield.className.replace("invalid-text","");
			textfield.className=textfield.className.replace("valid-text","");
			if(empty!=null && value=='');
			else
        	if(textfield.className.indexOf("valid-text")==-1)textfield.className +=" valid-text";
			msg=textfield.nextSibling;
			while(msg && msg.nodeType==3)msg=msg.nextSibling;
        	if(msg && (msg.tagName=='LABEL' || msg.tagName=='SPAN' ))
        	{
				if(empty!=null && value=='')
					msg.className = "";
				else
					msg.className = "valid-msg";
				if(textfield.getAttribute('initmsg')==null) textfield.setAttribute('initmsg', msg.innerHTML);
				msg.innerHTML=textfield.getAttribute('initmsg');
        	}
        	else if(alt!=null)
        	{
				var new_msg=document.createElement("LABEL");
				if(empty!=null && value=='')
				{
					new_msg.className = "";
				}
				else
				{
					new_msg.className = "valid-msg";
				}
				if(textfield.getAttribute('initmsg')==null)
				{
					textfield.setAttribute('initmsg', '');
				}
				new_msg.innerHTML=textfield.getAttribute('initmsg');
				textfield.parentNode.insertBefore(new_msg,msg);
				msg = new_msg;
        	}
			if(this.type == 'password')
	        {
	        	var bind = textfield.getAttribute("bind");
		        var bind_flag = true;
		        var bind_arr = document.getElementsByName(bind);
		        var bind_arr_len = bind_arr.length;
		        for(var i=0; i<bind_arr_len; i++)
			    {
			    	if(bind_arr[i].name == bind && bind_arr[i].value != this.value && bind_arr[i].value != '')
			    	{
			    		bind_flag = false;
			    	}
			    }
			    if(!bind_flag)
			    {
			    	msg.className = "invalid-msg";
			    	textfield.className=textfield.className.replace("valid-text","");
			    	if(textfield.className.indexOf("invalid-text")==-1)this.className += ' invalid-text';
			    	msg.innerHTML = '两次输入密码不一致';
			    }
			    else
			    {
			    	for(var i=0; i<bind_arr_len; i++)
				    {
			    		if(bind_arr[i].name == bind && bind_arr[i].value == this.value && bind_arr[i].value != '')
			    		{
			    			bind_arr[i].nextSibling.className = "valid-msg";
			    			bind_arr[i].className=textfield.className.replace("invalid-text","");
			    			if(bind_arr[i].className.indexOf("valid-text")==-1)this.className += ' valid-text';
			    			bind_arr[i].nextSibling.innerHTML = '验证通过';
			    		}
				    }
			    	msg.className = "valid-msg";
			    	textfield.className=textfield.className.replace("invalid-text","");
			    	if(textfield.className.indexOf("valid-text")==-1)this.className += ' valid-text';
			    	msg.innerHTML = '验证通过';
			    }
			}
        }
    }
    function validateOnSubmit()
    {
        var invalid = false;
        for(var i = 0; i < this.elements.length; i++)
        {
            var e = this.elements[i];

            if((e.type == "text" || e.type == "password" || e.type == "select-one" || e.type == "textarea") && e.getAttribute("pattern") && e.style.display!='none' && e.offsetWidth > 0)
            {
				addEvent(e,'change',validateOnChange);

				if (e.className.indexOf(" invalid-text")!=-1)
				{
					invalid = true;
					if(e.offsetHeight > 0 || e.client > 0)
					{
						e.focus();
					}
					break;
				}
				else
				{
					FireEvent(e,'onchange');
					if (e.className.indexOf(" invalid-text")!=-1)
					{
						invalid = true;
						if(e.offsetHeight > 0 || e.client > 0)
						{
							e.focus();
						}
						break;
					}
				}
            }
        }
        var callback = this.getAttribute('callback');
        var result = true;
        if(callback !=null) {result = eval(callback);}
        result = !(result==undefined?true:result);
        if (invalid || result)
        {
            return false;
        }
    }
})();
