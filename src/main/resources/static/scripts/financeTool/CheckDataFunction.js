var maxfn=99999999.9;
var overerrormsg="数值超过最大值99999999";


/*函数：检验字段是否为空
  输入：objArray（数组类型，其中各元素为需要检验的表单内文本对象）
  输出：若为空则弹出警告信息，焦点集中在为空的输入框内，并返回值：false
        全不为空则返回值：true
**/
function checkData(objArray){
	var textnow;
	var rst="true";
	for(i=0;i<objArray.length;i++){
	        textnow=eval(objArray[i])
		if(textnow.value==""){
			rst="false";
			alert("请输入相应数据！");
			textnow.focus()	;
			textnow.select();
			break;
		}	
	}
	return rst	

}
/*函数：检验字段是否为数字
  输入：objArray（数组类型，其中各元素为需要检验的表单内文本对象）
  输出：若不为数字则弹出警告信息，焦点集中在该输入框内，并返回值：false；
        全为数字则返回值：true
**/
function isInteger(objArray){
	var textnow;
	var rst="true";
	for(i=0;i<objArray.length;i++){
	        textnow=eval(objArray[i]);
		if(isNaN(textnow.value)){
			rst="false";
			alert("请输入数字！");
			textnow.focus();
			textnow.select();
			break;
		}	
	}
	return rst	
}

/*功能： 将一个日期对象转化为字符串：	
			date 日期对象
*/
function datetostring(date){
	var s="";
	s=date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
	
	return s;
	
}
/*功能： 校验一个值是否为空
入口参数：	
			CheckCtl: 要校验的输入框
			disptext: 出错显示的信息
*/
function CheckEmpty(CheckCtl,disptext,page){				
	if (Trim(CheckCtl.value)=="" ){
		if (page)
		 showguide(page);
		DispMessage(CheckCtl,disptext);	
		return false;
	}
	else return true;
}

function Trim(strSource) {
    return 	strSource.replace(/^\s*/,'').replace(/\s*$/,'');
}

/*功能： 校验一个合法的大于等于0的浮点数
入口参数：	
			CheckCtl: 要校验的输入框
			disptext: 出错显示的信息	
			floatcount: 小数的最高位数（如果没有该参数，则默认为2位）
			如果没有page参数，有floatcunt参数则：把page 置null
			如:	CheckFN(CheckCtl,"出错显示的信息",null,5)
*/
function CheckFN(CheckCtl,disptext,page,floatcount){					
	var s=new String(Trim(CheckCtl.value));
	temp=parseFloat(s);
	var result=true;
	if( (isNaN(temp)) || (temp< 0)||(temp!=s) ){					
		result=false;
	} else if (temp>maxfn) {
		result=false;
		disptext=overerrormsg;
	} else { 	 					
		limitcount=floatcount?floatcount:2;
		var array=s.split(".");
		if (array[1]==null)	count=-1;
		else{
			var str=new String(array[1]);
			count=str.length;
		}
		if (count>limitcount){
			if (page) showguide(page);
			alert("小数位数超过"+limitcount+"位"); 
			CheckCtl.select();
			CheckCtl.focus();
			return false;
		}
	 }	
	 if (!result){
		if (page) showguide(page);
		DispMessage(CheckCtl,disptext);
		return false;
	 }
    return true;
}
function CheckFN2(CheckCtl,disptext,page,floatcount){  
	return CheckFN(CheckCtl,disptext,page,floatcount);
}
function CheckFN3(CheckCtl,disptext,IsCanZero,page,floatcount){					
	if ( CheckFN(CheckCtl,disptext,page,floatcount) ){
		if ( (parseFloat(CheckCtl.value)==0) &&(!IsCanZero) ){
			if (page) showguide(page);
			DispMessage(CheckCtl,disptext);
			return false;
		}else return true;	
	 } else return false;
}


function DispMessage(CheckCtl,Msg){
	if (Msg!=""){					
		alert(Msg);					
		CheckCtl.select();
		CheckCtl.focus();
	}
}

/*功能： 校验一个合法的且在规定范围内的浮点数
入口参数：	
			CheckCtl: 要校验的输入框
			Min:  下限
			Max:  上限						
			Msg: 出错显示的信息  */
			
function CheckFloatRange(CheckCtl,Min, Max,Msg,page){			
	if (!IsNum(CheckCtl,Msg,page,null,1)) return false;
	v=parseFloat(Trim(CheckCtl.value));
	if  ( (v<Min) || (v>Max) ){
		if (page) showguide(page);
		DispMessage(CheckCtl,Msg);
		return false;
	}
	return true;		
}

/*判断是否是数字的函数
   输入：
      txtctl   输入的文本控件
      message  显示的错误信息
      返回值   是数字返回true，不是返回false
		floatcount: 小数的最高位数（如果没有该参数，则默认为4位）
			如果没有page参数，有floatcunt参数则：把page 置null
			如:	IsNum(txtctl,"出错显示的信息",null,5)  */
function IsNum(txtctl,message,page,floatcount,norange){
	var s=new String(Trim(txtctl.value));
	var result=true;
	var num=Number(s);
	if ( (isNaN(num)) || (s=="") ){
		result=false;
	}else if (num>maxfn){
		if (!norange){
			message=overerrormsg;
			result=false;
		}
	}else{
		limitcount=floatcount?floatcount:4;
		var array=s.split(".");
		if (array[1]==null)	count=-1;
		else{
		    var str=new String(array[1]);
		    count=str.length;
		}
		if (count>limitcount){
            if (page)  showguide(page);
            b=confirm("小数位数超过"+limitcount+"位,是否继续?"); 
            if (b) return true;
            else{
                txtctl.select();
                txtctl.focus();
                return false;
            }
		}
	}
	if (!result){
		if (page) showguide(page);
		DispMessage(txtctl,message);
		return false;
	}
	return true;
}

// 字符串转换为日期
function Cal_strtodate(str)
{
    var date = Date.parse(str);
    if (isNaN(date)) {
        date = Date.parse(str.replace(/-/g,"/")); // 识别日期格式：YYYY-MM-DD
        if (isNaN(date)) date = 0;
    }
    return(date);
}

// 检查edit中值是否为大于等于min，小于等于max的有效日期格式字符串。
function Cal_datevalid(edit,min,max){
    var date = Cal_strtodate(edit.value);
    if (date == 0) return false;
    if (max) {
        var max = Cal_strtodate(max);
        if ((max!=0)&&(date>max)) return false;
    }
    if (min) {
        var min = Cal_strtodate(min);
        if ((min!=0)&&(date<min)) return false;
    }
    date = new Date(date);
    edit.value = date.getFullYear() + "-" + (date.getMonth()+1) + "-" + date.getDate();
    return true;
}

/*功能： 得到两个日期相差的天数（每一个月按30天，一年360天计算）
入口参数：	
			date1: 日期对象1
			date2: 日期对象2
			返回 date1 - date2相差的天数
*/
function getDiffDay(date1,date2){
	var year=date1.getFullYear() - date2.getFullYear();
	var month=date1.getMonth() - date2.getMonth();
	var day=date1.getDate() - date2.getDate();				
	return year*12*30+month*30+day;
}
/*功能： 把一个日期加上n天（每一个月按30天，一年360天计算）
入口参数：	
		thedate: 要计算的日期对象
		days: 增加的天数 
如果计算出的日期不合法： 年大于9999等，则返回false，否则true
*/
function addday(thedate,days){
    day=thedate.getDate();
    month=thedate.getMonth()+1;
    year=thedate.getFullYear();
    mod_y=days % 360;
    y=Math.floor(days/360);
    year+=y;				
    if (mod_y!=0){
	    mod_m=mod_y % 30;
	    m=Math.floor(mod_y / 30);
	    month+=m;
    	
	    if (mod_m!=0){
		    day+=mod_m;						
		    if (day>30){
                month++;
                day-=30;
            }
	    }				
     }
    thedate.setTime(new Date(year,month-1,day)); 
    return (year<=9999);
}
/*  功能： 把一个日期加上n天（按照精确日期计算）
	入口参数：	
			thedate: 要计算的日期对象
			days: 增加的天数 
	如果计算出的日期不合法： 年大于9999等，则返回false，否则true  add by aiai*/
function addday1(thedate,days){
	day=thedate.getDate();
	month=thedate.getMonth()+1;
	year=thedate.getFullYear();
	thedate.setTime(new Date(year,month-1,day+days)); 
	return (thedate.getFullYear()<=9999);
}


//取整函数
//eg. Round(132.123456) 为 132.12
//eg. Round(132.123456,4) 为 132.1234
//eg. Round(132.123456,0) 为 132
function Round(i,digit){
	if(digit==0) p=1;
	else{
		if(digit) p=Math.pow(10,digit);
		else p=100;
	}
	return Math.round(i*p)/p;
}

//四舍五入函数，为了兼顾IE5（参数：欲转换数字，小数点后几位）返回NUMBER,liwenjie
function NBround(nb,len) {
    var strnb=new String(nb);
    if (nb < 0.0000001) return new Number(0); // 小于0.1E-7的按0处理
    pos = strnb.indexOf(".");
    if ((pos == -1) || (strnb.length-pos-1)<len) return new Number(strnb);
    else{
        var last = strnb.substring(pos+len+1,pos+len+2);
        var nblast = new Number(last);
        if (nblast<5) return new Number(strnb.substring(0,pos+len+1));
        else{
            if (strnb.substring(0,1)=="-")
                return new Number(new String(new Number(strnb.substring(0,pos+len+1))-Math.pow(10,-1*len)).substring(0,pos+len+1));
            else
                return new Number(new String(new Number(strnb.substring(0,pos+len+1))+Math.pow(10,-1*len)).substring(0,pos+len+1));
            //return new Number(strnb.substring(0,pos+len+1))+Math.pow(10,-1*len);
        }
    }
}

JSON = function () {
    return {
		indexOf : function (JSONStr, filed, text) {
			if (JSONStr && typeof(JSONStr) == "object") {
				for (i in JSONStr){
					if (eval("JSONStr[i]." + filed) == text)
					return eval("JSONStr[i]");
				}
				return null;
			}
			return null;
		}
    };
}();

function getRadioValue(radioName){  
    var obj = document.getElementsByName(radioName);
    for(i = 0; i < obj.length; i++) {
        if(obj[i].checked) { 
            return obj[i].value; 
        } 
    }         
    return "";       
}   

/*功能： 比较两个日期的大小，如果开始日期大于结束日期，返回false;
入口参数：	
			BDate:开始日期
			EDate:结束日期
			Msg:	出错显示的信息
*/
function CheckDiffDate(BDate,EDate,Msg){
    return CheckDiffDateNumber(BDate,EDate,0,Msg);
}

/*功能： 比较两个日期的大小，如果开始日期大于结束日期，返回false;
入口参数：	
			BDate:开始日期
			EDate:结束日期
			Msg:	出错显示的信息  */
function CheckDiffDateNumber(BDate,EDate,Days,Msg){
	if ( (!CheckEmpty(BDate,"请输入日期！")) || (!CheckEmpty(EDate,"请输入日期！")) ) return false;
	str = BDate.value;
	aa = str.split("-");
	BYear = parseInt(aa[0]);
	BMonth = parseInt(aa[1]);
	BDay = parseInt(aa[2]);
	str = EDate.value;
	bb = str.split("-");
	EYear = parseInt(bb[0]);
	EMonth = parseInt(bb[1]);
	EDay = parseInt(bb[2]);
	if(BYear<1900){
		DispMessage(BDate,"日期不能小于1900年！");
		return false;
	}
	if(EYear<1900){
		DispMessage(EDate,"日期不能小于1900年！");
		return false;
	}

	b=(BYear*10000)+(BMonth*100)+BDay+Days;
	e=(EYear*10000)+(EMonth*100)+EDay;
	if(e==b) return true;
	else 
		if(e>b)
			return true;
		else{
			DispMessage(BDate,Msg);
			return false;
		}
}

/*功能： 将一个字符串转化为日期对象：	
			Str  字符串
*/
function StrToDate(str){
	var arrayx=str.split("-");
	var datex=new Date(arrayx[0],arrayx[1]-1,arrayx[2]);
	return datex;
}

