var rateDemand = 0.72;//��������(%)

//������ȡ==========
var rate3  = 1.71;//3����
var rate6  = 2.07;//6����
var rate12 = 2.25;//һ������
var rate24 = 2.70;//2������
var rate36 = 3.24;//3������
var rate60 = 3.60;//5������

//�����ȡ===========
var rateLZ12 = 1.71;//1������
var rateLZ36 = 2.07;//3������
var rateLZ60 = 2.25;//5������

//�汾ȡϢ===========
var rateQX12 = 1.71;//1������
var rateQX36 = 2.07;//3������
var rateQX60 = 2.25;//5������

//������ȡ============
var rateZL12 = 1.71;//1������
var rateZL36 = 2.07;//3������
var rateZL60 = 2.25;//5������

//��������===========
var rateLB3  = 1.026;//3����
var rateLB6  = 1.242;//6����
var rateLB12 = 1.35//һ������
var rateLB24 = 1.62;//2������
var rateLB36 = 1.944;//3������
var rateLB60 = 2.16;//5������

//֪ͨ���==============
var rateTZ1 = 1.08;//1��
var rateTZ7 = 1.62;//1��

var iTax = 0.2;//��Ϣ˰

//��Ҵ�����Ϣ  = ���� ����֪ͨ һ���� ������ ������ һ�� ���� 
var AUD = new Array(0.5000, 1.2500, 2.0625, 2.3750, 2.6875, 3.3125, 3.3750);//�Ĵ�����Ԫ
var HKD = new Array(0.0750, 0.2500, 0.5000, 0.7500, 0.8750, 1.0000, 1.2500);//�۱�
var CAD = new Array(0.1500, 0.3750, 0.6250, 0.8750, 1.0625, 1.5625, 1.6250);//���ô�Ԫ
var USD = new Array(0.0750, 0.2500, 0.6250, 0.8750, 1.0000, 1.1250, 1.3125);//��Ԫ
var EUR = new Array(0.1000, 0.3750, 0.7500, 1.0000, 1.1250, 1.2500, 1.3125);//ŷԪ
var JPY = new Array(0.0001, 0.0005, 0.0100, 0.0100, 0.0100, 0.0100, 0.0100);//��Ԫ
var CHF = new Array(0.0500, 0.0625, 0.1000, 0.1250, 0.2500, 0.5000, 0.5625);//��ʿ����
var SGD = new Array(0.0750, 0.1250, 0.1875, 0.3125, 0.3750, 0.5625, 0.5938);//�¼���Ԫ
var GBP = new Array(0.3000, 1.0000, 1.7500, 2.3125, 2.6875, 3.0625, 3.1250);//Ӣ��

/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

function CheckElem(curObj, msg){
	if(msg==null) msg="";
	if(curObj.value==''){
		alert(msg + "����Ϊ��!");
		curObj.focus();
		curObj.select();
		return false;
	}else if(isNaN(curObj.value)){
		alert(msg + "����Ϊ����!");
		curObj.focus();
		curObj.select();
		return false;
	}else{
		return true;
	}
}
function Format(myFloat){
	if(isNaN(myFloat)||myFloat.toString().toLowerCase().indexOf("infinity")>-1) {
		return("���Ϸ��������Ǳ�����Ϊ�㡣");
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