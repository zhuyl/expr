/*�����������ֶ��Ƿ�Ϊ��
  ���룺objArray���������ͣ����и�Ԫ��Ϊ��Ҫ����ı����ı�����
  �������Ϊ���򵯳�������Ϣ�����㼯����Ϊ�յ�������ڣ�������ֵ��false
        ȫ��Ϊ���򷵻�ֵ��true
**/
function checkData(objArray){
	var textnow;
	var rst="true";
	for(i=0;i<objArray.length;i++){
	        textnow=eval(objArray[i])
		if(textnow.value==""){
			rst="false";
			alert("������������");
			textnow.focus()	;
			textnow.select();
			break;
		}	
	}
	return rst	

}
function checkData1(objArray){
	var textnow;
	var rst="true";
	for(i=0;i<objArray.length;i++){
	        textnow=eval(objArray[i])
		if(textnow.value==""){
			rst="false";
			
			textnow.focus()	;
			textnow.select();
			break;
		}	
	}
	return rst	

}
/*�����������ֶ��Ƿ�Ϊ����
  ���룺objArray���������ͣ����и�Ԫ��Ϊ��Ҫ����ı����ı�����
  ���������Ϊ�����򵯳�������Ϣ�����㼯���ڸ�������ڣ�������ֵ��false��
        ȫΪ�����򷵻�ֵ��true
**/
function isInteger(objArray){
	var textnow;
	var rst="true";
	for(i=0;i<objArray.length;i++){
	        textnow=eval(objArray[i]);
		if(isNaN(textnow.value)){
			rst="false";
			alert("���������֣�");
			textnow.focus();
			textnow.select();
			break;
		}	
	}
	return rst	
}
/*��������������ֶ��Ƿ�Ϸ���
  ���룺objYear����Ҫ����ı����ı�����
  ����������Ϸ��򵯳�������Ϣ�����㼯���ڸ�������ڣ�������ֵ��false��
        �Ϸ��򷵻�ֵ��true
**/
function isTrueYear(objYear){
	var textnow=eval(objYear);
	var rst="true";
	var nowDate=new Date();
	var nowYear=nowDate.getYear();
	if(textnow.value<1900){
		rst="false";
		alert("��������ȷ��ݣ�");
		textnow.focus();
		textnow.select();
	}
	return rst;
}
/*�����������·��ֶ��Ƿ�Ϸ���
  ���룺objMonth����Ҫ����ı����ı�����
  ����������Ϸ��򵯳�������Ϣ�����㼯���ڸ�������ڣ�������ֵ��false��
        �Ϸ��򷵻�ֵ��true
**/
function isTrueMonth(objMonth){
	var textnow=eval(objMonth);
	var rst="true";
	if(textnow.value>12||textnow.value<1){
		rst="false";
		alert("��������ȷ�·ݣ�");
		textnow.focus();
		textnow.select();
	}
	return rst;
}
/*���������������ֶ��Ƿ�Ϸ���
  ���룺objDate����Ҫ����ı����ı�����
  ����������Ϸ��򵯳�������Ϣ�����㼯���ڸ�������ڣ�������ֵ��false��
        �Ϸ��򷵻�ֵ��true
**/
function isTrueDate(objDate){
	var textnow=eval(objDate);
	var rst="true";
	if(textnow.value>31){
		rst="false";
		alert("��������ȷ���ڣ�");
		textnow.focus();
		textnow.select();
	}
	return rst;
}
/*������������ʼ���ڣ���������ڵ��·�
  ���룺yearBegin,monthBegin,dayBegin
  ������·ݣ����ͣ�FLOAT��ʱ��Σ�
**/
function getMonths(yearBegin,monthBegin,dayBegin){
	var timeBegin=parseInt(yearBegin*12)+parseInt(monthBegin)+parseFloat(dayBegin/30);
	var dateNow=new Date();
	var timeNow=parseInt(dateNow.getYear()*12)+parseInt(dateNow.getMonth()+1)+parseFloat(dateNow.getDate()/30);
	var timeSpan=timeNow-timeBegin
	//alert(timeSpan);
	return timeSpan;
}


