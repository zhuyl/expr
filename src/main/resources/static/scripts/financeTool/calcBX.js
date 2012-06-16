function CheckElem(curObj, msg){
	if(msg==null) msg="";
	if(curObj.value==''){
		alert(msg + "不可为空!");
		curObj.focus();
		return false;
	}else if(isNaN(curObj.value)){
		alert(msg + "必须为数字!");
		curObj.focus();
		return false;
	}else{
		return true;
	}
}
var pingJunGongZi = 0;
var zhiGongGongZi = 0;
function GetTongYong(){
	pingJunGongZi = parseFloat($("pingJunGongZi").value);
	zhiGongGongZi = parseFloat($("zhiGongGongZi").value);
	if (pingJunGongZi < zhiGongGongZi*0.6) pingJunGongZi = zhiGongGongZi*0.6;
	if (pingJunGongZi > zhiGongGongZi*3) pingJunGongZi = zhiGongGongZi*3;
}

function Format(myFloat){
	return Math.round(myFloat * 100)/100;
}
/*基本养老保险*/
function JiBenYangLao(){
	var myObj = document.forms["jiBenYangLao"];

	if(!CheckElem($("pingJunGongZi"), "您上年度月平均工资")) return false;
	if(!CheckElem($("zhiGongGongZi"), "本市职工上年月平均工资")) return false;
	if(!CheckElem($("danWeiBiLi"), "单位缴存比例")) return false;
	if(!CheckElem($("geRenBiLi"), "个人缴存比例")) return false;

	GetTongYong();
	$("jiaoCun").value = Format(pingJunGongZi * (parseFloat($("danWeiBiLi").value) + parseFloat($("geRenBiLi").value)) / 100);
	$("danWeiJiaoCun").value = Format(pingJunGongZi * parseFloat($("danWeiBiLi").value) / 100);
	$("geRenJiaoCun").value = Format(pingJunGongZi * parseFloat($("geRenBiLi").value) / 100);
}
/*基本医疗保险*/
function YiLiao(){
	if(!CheckElem($("pingJunGongZi"), "您上年度月平均工资")) return false;
	if(!CheckElem($("zhiGongGongZi"), "本市职工上年月平均工资")) return false;
	if(!CheckElem($("jiBenDanWei"), "单位缴存比例")) return false;
	if(!CheckElem($("jiBenGeRen"), "个人缴存比例")) return false;
	if(!CheckElem($("daEDanWei"), "单位缴存比例")) return false;
	if(!CheckElem($("daEGeRen"), "个人缴存金额")) return false;

	GetTongYong();
	$("jiaoCun").value = Format(pingJunGongZi * (parseFloat($("jiBenDanWei").value) + parseFloat($("jiBenGeRen").value) + parseFloat($("daEDanWei").value)) / 100 + parseFloat($("daEGeRen").value));
	$("jiBenJiaoCun").value = Format(pingJunGongZi * parseFloat(parseFloat($("jiBenDanWei").value) + parseFloat($("jiBenGeRen").value)) / 100);
	$("daEJiaoCun").value = Format(pingJunGongZi * parseFloat($("daEDanWei").value) / 100 + parseFloat($("daEGeRen").value));
}
/*退休养老保险*/
function LingQuYangLao(){
	if(!CheckElem($("pingJunGongZi"), "您上年度月平均工资")) return false;
	if(!CheckElem($("zhiGongGongZi"), "本市职工上年月平均工资")) return false;
	if(!CheckElem($("nianLing"), "现在年龄")) return false;
	if(!CheckElem($("tuiXiu"), "您打算退休时年龄")) return false;
	if(!CheckElem($("jiLei"), "现在您帐户累积的养老金额")) return false;
	if(!CheckElem($("geRenZenZhang"), "默认个人工资增长率")) return false;
	if(!CheckElem($("zhiGongZenZhang"), "默认职工工资增长率")) return false;
	if(!CheckElem($("qiWang"), "您期望退休后每月的生活水平")) return false;

	GetTongYong();
	$("nianLing2").value = $("nianLing").value;
	$("tuiXiu2").value = $("tuiXiu").value;

	var jiChu = zhiGongGongZi * (1 + (parseFloat($("tuiXiu").value) - parseFloat($("nianLing").value)) * parseFloat($("zhiGongZenZhang").value)/100) * 0.2;
	
	var zhangHuZongE = parseFloat($("jiLei").value) + pingJunGongZi * 0.08 * 12 * (Math.pow(1+(parseFloat($("geRenZenZhang").value)/100), parseFloat($("tuiXiu").value) - parseFloat($("nianLing").value)) - 1) / (parseFloat($("geRenZenZhang").value)/100);

	$("yangLaoJin").value = Format(jiChu + zhangHuZongE / 120);

	var yangLaoJin = parseFloat($("yangLaoJin").value);
	var qiWang = parseFloat($("qiWang").value);
	var tempText = "";
	if(yangLaoJin < qiWang){
		tempText += "按您目前的工资，不能満足您期望的退休后生活水平您需要逐步提高你的工资待遇或者每月额外增加养老金<b style='color:#f00;'>" + Format((qiWang - yangLaoJin) * 10 / (parseFloat($("tuiXiu").value) - parseFloat($("nianLing").value))) + "</b>元。";
	}else{
		tempText += "您目前的工资水平一直保持下去的话，完全可以満足您期望的退休后生活水平。";
		if(yangLaoJin > qiWang) tempText += "您可以把每月赢余的<b style='color:#f00;'>" + Format(yangLaoJin - qiWang) + "</b>元进行其他投资，以获取更高的回报。";
	}
	$("result").innerHTML = tempText;
}
/*工伤保险*/
function GongShang(){
	if(!CheckElem($("pingJunGongZi"), "您上年度月平均工资")) return false;
	if(!CheckElem($("zhiGongGongZi"), "本市职工上年月平均工资")) return false;
	if(!CheckElem($("danWeiBiLi"), "单位缴存比例")) return false;

	GetTongYong();
	$("jiaoCun").value = Format(pingJunGongZi * parseFloat($("danWeiBiLi").value) / 100);
}
/*失业保险*/
function ShiYe(){
	if(!CheckElem($("pingJunGongZi"), "您上年度月平均工资")) return false;
	if(!CheckElem($("zhiGongGongZi"), "本市职工上年月平均工资")) return false;
	if(!CheckElem($("danWeiBiLi"), "单位缴存比例")) return false;
	if(!CheckElem($("geRenBiLi"), "个人缴存比例")) return false;

	GetTongYong();
	$("jiaoCun").value = Format(pingJunGongZi * (parseFloat($("danWeiBiLi").value) + parseFloat($("geRenBiLi").value)) / 100);
	$("danWeiJiaoCun").value = Format(pingJunGongZi * parseFloat($("danWeiBiLi").value) / 100);
	$("geRenJiaoCun").value = Format(pingJunGongZi * parseFloat($("geRenBiLi").value) / 100);
}
/*住房公积金*/
function GongJiJin(){
	if(!CheckElem($("pingJunGongZi"), "您上年度月平均工资")) return false;
	if(!CheckElem($("zhiGongGongZi"), "本市职工上年月平均工资")) return false;
	if(!CheckElem($("danWeiBiLi"), "单位缴存比例")) return false;
	if(!CheckElem($("geRenBiLi"), "个人缴存比例")) return false;

	GetTongYong();
	$("jiaoCun").value = Format(pingJunGongZi * (parseFloat($("danWeiBiLi").value) + parseFloat($("geRenBiLi").value)) / 100);
	$("danWeiJiaoCun").value = Format(pingJunGongZi * parseFloat($("danWeiBiLi").value) / 100);
	$("geRenJiaoCun").value = Format(pingJunGongZi * parseFloat($("geRenBiLi").value) / 100);
}