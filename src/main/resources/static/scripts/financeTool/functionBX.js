Browser = {
	IE:     !!(window.attachEvent && !window.opera),
	Opera:  !!window.opera,
	WebKit: navigator.userAgent.indexOf('AppleWebKit/') > -1,
	Gecko:  navigator.userAgent.indexOf('Gecko') > -1 && navigator.userAgent.indexOf('KHTML') == -1,
	MobileSafari: !!navigator.userAgent.match(/Apple.*Mobile.*Safari/)
}
function $(element) {
  if (typeof(element) == "string")
    element = document.getElementById(element);
  return element;
}

function loading(objName){
	var loadBorder = 4;
	var loadHeight = 26;
	var loadWidth = 100;
	var Loadlayer = document.createElement("span");
	Loadlayer.innerHTML = "数据载入中...";
	Loadlayer.style.position = "absolute";
	Loadlayer.style.border = loadBorder + "px solid #CCC";
	Loadlayer.style.background = "#FFFFFF";
	Loadlayer.style.padding = "12px";
	Loadlayer.style.width = loadWidth+"px";	
	if(Browser.IE){
		Loadlayer.style.filter = "alpha(opacity=80)";
	}else{
		Loadlayer.style.opacity = "0.8";
	}
	Loadlayer.align = "center";
	
	this.parentNodeObj = $(objName);
	
	var oleft = this.parentNodeObj.offsetLeft;
	var otop = this.parentNodeObj.offsetTop;
	
	this.Paddingtop = 0;
	this.PaddingLeft = 0;
	
	if(Browser.IE){
		while(this.parentNodeObj.nodeName != "BODY"){
			this.parentNodeObj = this.parentNodeObj.parentNode;
			oleft += this.parentNodeObj.offsetLeft;
			otop += this.parentNodeObj.offsetTop;
		}
	}
	
	this.show = function(){
		this.PaddingLeft += ($(objName).offsetWidth - loadWidth)/2 + oleft;
		Loadlayer.style.left = this.PaddingLeft + "px";
		//alert($(objName).offsetHeight);
		if(Browser.IE){
			this.Paddingtop += ($(objName).clientHeight - loadHeight)/2 + otop;
		}else{
			this.Paddingtop += ($(objName).clientHeight - loadHeight - (loadBorder * 2))/2 + otop;
		}
		//alert(this.Paddingtop)
		Loadlayer.style.top = this.Paddingtop + "px";
		$(objName).appendChild(Loadlayer);
	}
	
	this.hidden = function(){
	    try{
		    $(objName).removeChild(Loadlayer);
	    }catch(e){
	        alert(e);
	    }
	}

}

// 打印页面
function doPrint(){
	var str="<html>";
	var article;
	var css;
	var strAdBegin="<!--pic_cnt_start-->";
	var strAdEnd="<!--pic_cnt_end-->";
	var strTmp;
	
		css="<style>"
		+"body{font-family:宋体}"
		+"td {font-size:14px;line-height:1.8em;}"
		+".title {font-size:24px;font-weight:bold;line-height:1.6em}"
	    +"</style>";
	
		str +=	css;
		str +=	'<meta http-equiv="content-type" content="text/html; charset=gb2312">';
		str +=	'<title>'+document.title+'</title>';
		str +=	"<body bgcolor=#ffffff topmargin=5 leftmargin=5 marginheight=5 marginwidth=5 onload='window.print()'>";
		str +=	"<center><table width=600 border=0 cellspacing=0 cellpadding=0><tr><td height=34 width=150><td align=right valign=bottom><a href='javascript:history.back()'>返回</a>　<a href='javascript:window.print()'>打印</a></td></tr></table>";
		str +=	"<table width=600 border=0 cellpadding=0 cellspacing=0><tr><td>";
		//str +=  "<div align=center class=title>" + document.title + "</div><br>"
		article=document.getElementById('newText').innerHTML;
		if(article.indexOf(strAdBegin)!=-1){
			str +=article.substr(0,article.indexOf(strAdBegin));
			strTmp=article.substr(article.indexOf(strAdEnd)+strAdEnd.length, article.length);
		}else{
			strTmp=article
		}
		str +=strTmp
		str +=	"</td></tr></table>";
		str += window.location.href;
		str +=	"</center></body></html>";
		document.write(str);
		document.close();
}

// 复制网址
function copyToClipBoard(){
	var clipBoardContent=''; 
	clipBoardContent+=document.title;
	clipBoardContent+='\r\n';
	clipBoardContent+=window.location.href;
	try{
		window.clipboardData.setData("Text",clipBoardContent);
		alert("您已复制链接及标题，请粘贴到QQ/MSN等发给好友!");
	}catch(e){
		alert("对不起!您的浏览器不支持剪切板功能!")
	}
}

// 加入收藏
function AddFavor() {  
    try {
        window.external.addFavorite(window.location.href, window.document.title);  
    }catch (e){  
        try{  
            window.sidebar.addPanel(window.document.title, window.location, "");  
        }catch (e) {
			alert("加入收藏失败，请使用Ctrl+D进行添加");  
        }  
    }  
}  

/*产品比较*/
function AttachListener(){
    var elements = document.getElementsByName("CompareId");
    for(var i=0; i< elements.length; i++) {       
        if( IsCheckBox(elements[i]) ) {
            addEvent(elements[i],"click",CheckComp,elements[i]); 
        }
    }
}

function CheckComp(e){
    var elements = document.getElementsByName("CompareId");
    var CheckNum = 0;
    for(i=0; i< elements.length; i++) {       
        if( elements[i].checked ) {
            CheckNum ++;
        }
    }
    if(CheckNum>3){
        this.checked = false;
        alert("最多不能超过3个产品进行比较");
    }
}

function IsCheckBox(chk) {
    if(chk.type == "checkbox") return true; 
    else return false;
}

function addEvent(elm, evType, fn, owner) {
    var eventHandler = fn;
    if(owner){
        eventHandler = function(e){
           fn.call(owner, e);
        }
    }
	if (elm.addEventListener) {
		elm.addEventListener(evType, eventHandler, false);
		return true;
	}else if (elm.attachEvent) {
		var r = elm.attachEvent('on' + evType, eventHandler);
		return r;
	}else {
		elm['on' + evType] = eventHandler;
	}
}

function CompPro(pageName){
    var elements = document.getElementsByName("CompareId");
    var CheckNum = 0;
    var Value = "";
    for(i=0; i< elements.length; i++) {       
        if( elements[i].checked ) {
            CheckNum ++;
            Value += elements[i].value+",";
        }
    }

    if(CheckNum<=1) alert("请选择您要比较的产品");
    else{
        Value = Value.substring(0,Value.length-1);
        window.open(pageName+Value+".html");
    }
}
/*END*/


function JionURLParm(url,parm){
    if(url.indexOf("?")>0)url += "&" + parm;
    else url += "?" + parm;
    return url;
}

function showSelObj(Obj){
    var ClickObj = $(Obj);
    var ParentObj = ClickObj.parentNode;
    
    var allLInodes = ParentObj.getElementsByTagName("li");
    for(var i=0;i<allLInodes.length;i++){
        allLInodes[i].className = "";
        var ShowObj = $("SelObj_"+(i+1));
        ShowObj.style.display = "none";
        if(allLInodes[i]==ClickObj) {
            allLInodes[i].className = "at";
            ShowObj.style.display = "block";
        }
    }
}

function SearchInsurePro(ICoObj, ITypeObj, PaymentObj, DeadlineObj){
    var ICoObjValue = parseFloat($(ICoObj).value);
    var ITypeObjValue = parseFloat($(ITypeObj).value);
    var PaymentObjValue = parseFloat($(PaymentObj).value);
    var DeadlineObjValue = parseFloat($(DeadlineObj).value);
    
    var url = "/IProList";
    if (ICoObjValue>0 || ITypeObjValue>0 || PaymentObjValue>0 || DeadlineObjValue>0)
        url += ","+ICoObjValue+"A"+ITypeObjValue+"E"+PaymentObjValue+"D"+DeadlineObjValue;
    url += ".html";
    window.open(url)
}