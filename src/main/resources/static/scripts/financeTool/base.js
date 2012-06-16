var rateDemand = 0.72;//活期利率(%)

//整存整取==========
var rate3  = 1.71;//3个月
var rate6  = 2.07;//6个月
var rate12 = 2.25;//一年利率
var rate24 = 2.70;//2年利率
var rate36 = 3.24;//3年利率
var rate60 = 3.60;//5年利率

//零存整取===========
var rateLZ12 = 1.71;//1年利率
var rateLZ36 = 2.07;//3年利率
var rateLZ60 = 2.25;//5年利率

//存本取息===========
var rateQX12 = 1.71;//1年利率
var rateQX36 = 2.07;//3年利率
var rateQX60 = 2.25;//5年利率

//整存零取============
var rateZL12 = 1.71;//1年利率
var rateZL36 = 2.07;//3年利率
var rateZL60 = 2.25;//5年利率

//定活两便===========
var rateLB3  = 1.026;//3个月
var rateLB6  = 1.242;//6个月
var rateLB12 = 1.35//一年利率
var rateLB24 = 1.62;//2年利率
var rateLB36 = 1.944;//3年利率
var rateLB60 = 2.16;//5年利率

//通知存款==============
var rateTZ1 = 1.08;//1天
var rateTZ7 = 1.62;//1天

var iTax = 0.2;//利息税

//外币储蓄利息  = 活期 七天通知 一个月 三个月 六个月 一年 二年 
var AUD = new Array(0.5000, 1.2500, 2.0625, 2.3750, 2.6875, 3.3125, 3.3750);//澳大利亚元
var HKD = new Array(0.0750, 0.2500, 0.5000, 0.7500, 0.8750, 1.0000, 1.2500);//港币
var CAD = new Array(0.1500, 0.3750, 0.6250, 0.8750, 1.0625, 1.5625, 1.6250);//加拿大元
var USD = new Array(0.0750, 0.2500, 0.6250, 0.8750, 1.0000, 1.1250, 1.3125);//美元
var EUR = new Array(0.1000, 0.3750, 0.7500, 1.0000, 1.1250, 1.2500, 1.3125);//欧元
var JPY = new Array(0.0001, 0.0005, 0.0100, 0.0100, 0.0100, 0.0100, 0.0100);//日元
var CHF = new Array(0.0500, 0.0625, 0.1000, 0.1250, 0.2500, 0.5000, 0.5625);//瑞士法郎
var SGD = new Array(0.0750, 0.1250, 0.1875, 0.3125, 0.3750, 0.5625, 0.5938);//新加坡元
var GBP = new Array(0.3000, 1.0000, 1.7500, 2.3125, 2.6875, 3.0625, 3.1250);//英镑

/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

function CheckElem(curObj, msg){
	if(msg==null) msg="";
	if(curObj.value==''){
		alert(msg + "不可为空!");
		curObj.focus();
		curObj.select();
		return false;
	}else if(isNaN(curObj.value)){
		alert(msg + "必须为数字!");
		curObj.focus();
		curObj.select();
		return false;
	}else{
		return true;
	}
}
function Format(myFloat){
	if(isNaN(myFloat)||myFloat.toString().toLowerCase().indexOf("infinity")>-1) {
		return("不合法，可能是被除数为零。");
	}else{
		return Math.round(myFloat * 100)/100;
	}
}
function CheckTextBox(formObj){
	for(var i=0;i<formObj.elements.length;i++){
		if(formObj.elements[i].readOnly==true){
			formObj.elements[i].style.color = "#0000ff";
		}
		if(formObj.elements[i].type.toLowerCase()=="text" && !isNaN(formObj.elements[i].value)){
			if(parseFloat(formObj.elements[i].value)<0) formObj.elements[i].style.color = "#ff0000";
		}
	}
}
function GetObj(objName){
	if(document.getElementById){
		return eval('document.getElementById("' + objName + '")');
	}else{
		return eval('document.all.' + objName);
	}
}