function $(element) {
  if (typeof(element) == "string")
    element = document.getElementById(element);
  return element;
}
function L_calendar(){}
L_calendar.prototype={
	_VersionInfo:"Version:1.0",
	Moveable:true,
	NewName:"",
	insertId:"",
	ClickObject:null,
	InputObject:null,
	InputDate:null,
	IsOpen:false,
	MouseX:0,
	MouseY:0,
	GetDateLayer:function(){
		if(window.parent) return window.parent.L_DateLayer;
		else{ return window.L_DateLayer;}
	},
	L_TheYear:new Date().getFullYear(), //������ı����ĳ�ʼֵ
	L_TheMonth:new Date().getMonth()+1, //�����µı����ĳ�ʼֵ
	L_WDay:new Array(39), //����д���ڵ�����
	MonHead:new Array(31,28,31,30,31,30,31,31,30,31,30,31), //����������ÿ���µ��������
	GetY:function(){
		var obj;
		if (arguments.length > 0){
			obj==arguments[0];
		}else{
			obj=this.ClickObject;
		}
		if(obj!=null){
			var y = obj.offsetTop;
			while (obj = obj.offsetParent) y += obj.offsetTop;
			return y;
		} else{return 0;}
	},
	GetX:function(){
		var obj;
		if (arguments.length > 0){
			obj==arguments[0];
		}else{
			obj=this.ClickObject;
		}
		if(obj!=null){
		    var y = "";
		    var tempInputObj;
		    if(this.InputObject != null){
		        y = this.InputObject.offsetLeft;
		    }else{
			    y = obj.offsetLeft;
			}
			while (obj = obj.offsetParent) y += obj.offsetLeft;
			return y;
		}else{return 0;}
	},
	CreateHTML:function(){
		var htmlstr="";
		htmlstr+="<div id=\"L_calendar\">\r\n";
		htmlstr+="<span id=\"SelectYearLayer\" style=\"display: none;\"></span>\r\n";
		htmlstr+="<span id=\"SelectMonthLayer\" style=\"display: none;\"></span>\r\n";
		htmlstr+="<div id=\"L_calendar-year-month\"><div id=\"L_calendar-PrevM\" onclick=\"parent."+this.NewName+".PrevM()\" title=\"ǰһ��\"><b>&lt;&lt;</b></div><div id=\"L_calendar-year\" onmouseover=\"style.backgroundColor='#666'\" onmouseout=\"style.backgroundColor='#999'\" onclick=\"parent."+this.NewName+".SelectYearInnerHTML('"+this.L_TheYear+"')\"></div><div id=\"L_calendar-month\"  onmouseover=\"style.backgroundColor='#666'\" onmouseout=\"style.backgroundColor='#999'\" onclick=\"parent."+this.NewName+".SelectMonthInnerHTML('"+this.L_TheMonth+"')\"></div><div id=\"L_calendar-NextM\" onclick=\"parent."+this.NewName+".NextM()\" title=\"��һ��\"><b>&gt;&gt;</b></div></div>\r\n";
		htmlstr+="<div id=\"L_calendar-week\"><ul onmouseup=\"StopMove()\"><li>��</li><li>һ</li><li>��</li><li>��</li><li>��</li><li>��</li><li>��</li></ul></div>\r\n";
		htmlstr+="<div id=\"L_calendar-day\">\r\n";
		htmlstr+="<ul>\r\n";
		for(var i=0;i<this.L_WDay.length;i++){
			htmlstr+="<li id=\"L_calendar-day_"+i+"\" onmouseover=\"this.style.background='#FFD700'\"  onmouseout=\"this.style.background='#EFEFEF'\"></li>\r\n";
		}
		htmlstr+="</ul>\r\n";
		htmlstr+="<span id=\"L_calendar-today\" onclick=\"parent."+this.NewName+".Today()\"><b>TODAY</b></span>\r\n";
		htmlstr+="</div>\r\n";
		//htmlstr+="<div id=\"L_calendar-control\"></div>\r\n";
		htmlstr+="</div>\r\n";
		htmlstr+="<scr" + "ipt type=\"text/javas" + "cript\">\r\n";
		htmlstr+="var MouseX,MouseY;";
		htmlstr+="var Moveable="+this.Moveable+";\r\n";
		htmlstr+="var MoveaStart=false;\r\n";
		htmlstr+="document.onmousemove=function(e)\r\n";
		htmlstr+="{\r\n";
		htmlstr+="var DateLayer=parent.document.getElementById(\"L_DateLayer\");\r\n";
		htmlstr+="	e = window.event || e;\r\n";
		htmlstr+="var DateLayerLeft=DateLayer.style.posLeft || parseInt(DateLayer.style.left.replace(\"px\",\"\"));\r\n";
		htmlstr+="var DateLayerTop=DateLayer.style.posTop || parseInt(DateLayer.style.top.replace(\"px\",\"\"));\r\n";
		htmlstr+="if(MoveaStart){DateLayer.style.left=(DateLayerLeft+e.clientX-MouseX)+\"px\";DateLayer.style.top=(DateLayerTop+e.clientY-MouseY)+\"px\"}\r\n";
		htmlstr+=";\r\n";
		htmlstr+="}\r\n";
		
		htmlstr+="document.getElementById(\"L_calendar-week\").onmousedown=function(e){\r\n";
		htmlstr+="if(Moveable){MoveaStart=true;}\r\n";
		htmlstr+="	e = window.event || e;\r\n";
		htmlstr+="  MouseX = e.clientX;\r\n";
		htmlstr+="  MouseY = e.clientY;\r\n";
		htmlstr+="	}\r\n";
		
		htmlstr+="function StopMove(){\r\n";
		htmlstr+="MoveaStart=false;\r\n";
		htmlstr+="	}\r\n";
		htmlstr+="</scr"+"ipt>\r\n";
		var stylestr="";
		stylestr+="<style type=\"text/css\">";
		stylestr+="body{background:#fff;font-size:12px;margin:0px;padding:0px;text-align:left; font-family:\"����\";}\r\n";
		stylestr+="#L_calendar{border:1px solid #666;width:158px;padding:1px;height:170px;z-index:9998;text-align:center}\r\n";
		stylestr+="#L_calendar-year-month{height:23px;line-height:23px;z-index:9998;background:#999; color:#FFF;}\r\n";
		
		stylestr+="#SelectYearLayer{z-index: 9999;position: absolute;top: 3px; left: 25px;}";
		stylestr+="#SelectMonthLayer{z-index: 9999;position: absolute;top: 3px; left: 85px;}";
		stylestr+="#L_calendar-year{line-height:23px;width:60px;float:left;z-index:9998;position: absolute;top: 2px; left: 25px;font-weight:bold;cursor:default;font-family:Verdana, Arial, Helvetica, sans-serif;}\r\n";
		stylestr+="#L_calendar-month{line-height:23px;width:48px;float:left;z-index:9998;position: absolute;top: 2px; left: 85px;font-weight:bold;cursor:default;font-family:Verdana, Arial, Helvetica, sans-serif;}\r\n";
		stylestr+="#L_calendar-PrevM{position: absolute;top: 2px; left: 5px;cursor:pointer;}"
		stylestr+="#L_calendar-NextM{position: absolute;top: 2px; left: 138px;cursor:pointer}"
		stylestr+="#L_calendar-week{height:23px;line-height:23px;z-index:9998;}\r\n";
		stylestr+="#L_calendar-day{height:126px;z-index:9998;}\r\n";
		stylestr+="#L_calendar-week ul{cursor:move;list-style:none;margin:0px;padding:0px;}\r\n";
		stylestr+="#L_calendar-week li{width:20px;height:20px;float:left;;margin:1px;padding:0px;text-align:center;}\r\n";
		stylestr+="#L_calendar-day ul{list-style:none;margin:0px;padding:0px;}\r\n";
		stylestr+="#L_calendar-day li{cursor:pointer;width:20px;height:20px; line-height:20px;float:left;;margin:1px;padding:0px;background:#EFEFEF;font-family:Verdana, Arial, Helvetica, sans-serif; font-size:10px;}\r\n";
		stylestr+="#L_calendar-control{height:25px;z-index:9998;}\r\n";
		stylestr+="#L_calendar-today{cursor:pointer;float:left;width:64px;height:20px;line-height:20px;margin:1px;text-align:center;background:#999; color:#FFF; font-family:Verdana, Arial, Helvetica, sans-serif; font-size:10px;}";
		stylestr+="</style>";
		
		var TempLateContent="<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n";
		TempLateContent="<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n";
		TempLateContent="<head>\r\n";
		TempLateContent="<meta http-equiv=\"Content-Type\" content=\"text/html; charset=gb2312\" />\r\n";
		TempLateContent+="<title></title>\r\n";
		TempLateContent+=stylestr;
		TempLateContent+="</head>\r\n";
		TempLateContent+="<body>\r\n";
		TempLateContent+=htmlstr;
		TempLateContent+="</body>\r\n";
		TempLateContent+="</html>\r\n";
		this.GetDateLayer().document.writeln(TempLateContent);
		this.GetDateLayer().document.close();
	},
	InsertHTML:function(id,htmlstr){
		var L_DateLayer=this.GetDateLayer();
		if(L_DateLayer){L_DateLayer.document.getElementById(id).innerHTML=htmlstr;}
	},
	WriteHead:function (yy,mm){  //�� head ��д�뵱ǰ��������
		this.InsertHTML("L_calendar-year",yy + " ��");
		this.InsertHTML("L_calendar-month",mm + " ��");
  	},
	IsPinYear:function(year){            //�ж��Ƿ���ƽ��
    	if (0==year%4&&((year%100!=0)||(year%400==0))) return true;
    	else return false;
  	},
	GetMonthCount:function(year,month){  //�������Ϊ29��
    	var c=this.MonHead[month-1];
    	if((month==2)&&this.IsPinYear(year)) c++;
    	return c;
  	},
	GetDOW:function(day,month,year){     //��ĳ������ڼ�
    	var dt=new Date(year,month-1,day).getDay()/7;
    	return dt;
  	},
	GetText:function(obj){
		if(obj.innerText){return obj.innerText}
		else{return obj.textContent}
	},
	PrevM:function(){  //��ǰ���·�
    	if(this.L_TheMonth>1){this.L_TheMonth--}else{this.L_TheYear--;this.L_TheMonth=12;}
    	this.SetDay(this.L_TheYear,this.L_TheMonth);
  	},
	NextM:function(){  //�����·�
    	if(this.L_TheMonth==12){this.L_TheYear++;this.L_TheMonth=1}else{this.L_TheMonth++}
    	this.SetDay(this.L_TheYear,this.L_TheMonth);
  	},
	Today:function(){  //Today Button
		var today;
    	this.L_TheYear = new Date().getFullYear();
    	this.L_TheMonth = new Date().getMonth()+1;
    	today=new Date().getDate();
    	if(this.InputObject){
		    this.InputObject.value=this.L_TheYear + "-" + this.L_TheMonth + "-" + today;
		    this.InputObject.focus();
    	}
    	this.CloseLayer();
  	},
	SetDay:function (yy,mm){   //��Ҫ��д����**********
  		this.WriteHead(yy,mm);
	  	//���õ�ǰ���µĹ�������Ϊ����ֵ
  		this.L_TheYear=yy;
  		this.L_TheMonth=mm;
  		for (var i = 0; i < 39; i++){this.L_WDay[i]="";};  //����ʾ�������ȫ�����
  		var day1 = 1,day2=1,firstday = new Date(yy,mm-1,1).getDay();  //ĳ�µ�һ������ڼ�
  		for (i=0;i<firstday;i++)this.L_WDay[i]=this.GetMonthCount(mm==1?yy-1:yy,mm==1?12:mm-1)-firstday+i+1	//�ϸ��µ������
  		for (i = firstday; day1 < this.GetMonthCount(yy,mm)+1; i++){this.L_WDay[i]=day1;day1++;}
  		for (i=firstday+this.GetMonthCount(yy,mm);i<39;i++){this.L_WDay[i] = day2;day2++}
  		for (i = 0; i < 39; i++){
			var da=this.GetDateLayer().document.getElementById("L_calendar-day_"+i+"");
			var month,day;
    		if (this.L_WDay[i]!=""){
				if(i < firstday){
					da.innerHTML="<b style=\"color:#999\">" + this.L_WDay[i] + "</b>";
					month = (mm == 1 ? 12 : mm - 1);
					day = this.L_WDay[i];
					if(document.all) da.onclick=null;
					else da.setAttribute("onclick","");
				} else if(i >= firstday + this.GetMonthCount(yy,mm)){
					da.innerHTML="<b style=\"color:#999\">" + this.L_WDay[i] + "</b>";
					month = ( mm == 12 ? 1 : mm + 1);
					day=this.L_WDay[i];
					if(document.all) da.onclick=null;
					else da.setAttribute("onclick","");
				} else{
					da.innerHTML="<b style=\"color:#000\">" + this.L_WDay[i] + "</b>";
					month = mm;//(mm == 1 ? 12 : mm);
					day=this.L_WDay[i];
					if(document.all) da.onclick=Function("parent."+this.NewName+".DayClick("+month+","+day+")");
					else da.setAttribute("onclick","parent."+this.NewName+".DayClick("+month+","+day+")");
				}
				da.title=month+" ��"+day+" ��";
				var tempbg = (yy == new Date().getFullYear()&&month==new Date().getMonth()+1&&day==new Date().getDate())? "#FFD700":"#EFEFEF";
	            //if(tempbg == "#FFD700") da.onmouseout = function(){ this.style.background="#FFD700"; }
				da.style.background = tempbg;
				if(this.InputDate!=null){
					if(yy==this.InputDate.getFullYear() && month == this.InputDate.getMonth() + 1 && day==this.InputDate.getDate()){
						da.style.background="#99CCFF";
						da.onmouseout = function(){this.style.background="#99CCFF";}
					}else if(tempbg == "#FFD700"){
					    da.onmouseout = function(){this.style.background="#FFD700";}
					}else if(i < firstday || i >= this.GetMonthCount(yy,mm)){
					    da.onmouseover = null;
					}else{
					    da.onmouseout = function(){this.style.background="#EFEFEF";}
					}
				}
      		}
  		}
	},
	SelectYearInnerHTML:function (strYear){ //��ݵ�������
 	 	if (strYear.match(/\D/)!=null){alert("�����������������֣�");return;}
 	 	var m = (strYear) ? strYear : new Date().getFullYear();
		if (m < 1000 || m > 9999) {alert("���ֵ���� 1000 �� 9999 ֮�䣡");return;}
  		var n = m - 10;
  		if (n < 1000) n = 1000;
  		if (n + 26 > 9999) n = 9974;
  		var s = "<select name=\"L_SelectYear\" id=\"L_SelectYear\" style='font-size: 12px' "
     		s += "onblur='document.getElementById(\"SelectYearLayer\").style.display=\"none\"' "
     		s += "onchange='document.getElementById(\"SelectYearLayer\").style.display=\"none\";"
     		s += "parent."+this.NewName+".L_TheYear = this.value; parent."+this.NewName+".SetDay(parent."+this.NewName+".L_TheYear,parent."+this.NewName+".L_TheMonth)'>\r\n";
  		var selectInnerHTML = s;
  		for (var i = n; i < n + 26; i++){
    		if (i == m)
       		{selectInnerHTML += "<option value='" + i + "' selected>" + i + "��" + "</option>\r\n";}
    		else {selectInnerHTML += "<option value='" + i + "'>" + i + "��" + "</option>\r\n";}
 		}
  		selectInnerHTML += "</select>";
		var DateLayer=this.GetDateLayer();
  		DateLayer.document.getElementById("SelectYearLayer").style.display="";
  		DateLayer.document.getElementById("SelectYearLayer").innerHTML = selectInnerHTML;
  		DateLayer.document.getElementById("L_SelectYear").focus();
	},
	SelectMonthInnerHTML:function (strMonth){ //�·ݵ�������
  		if (strMonth.match(/\D/)!=null){alert("�·���������������֣�");return;}
  		var m = (strMonth) ? strMonth : new Date().getMonth() + 1;
 		var s = "<select name=\"L_SelectYear\" id=\"L_SelectMonth\" style='font-size: 12px' "
     		s += "onblur='document.getElementById(\"SelectMonthLayer\").style.display=\"none\"' "
     		s += "onchange='document.getElementById(\"SelectMonthLayer\").style.display=\"none\";"
     		s += "parent."+this.NewName+".L_TheMonth = this.value; parent."+this.NewName+".SetDay(parent."+this.NewName+".L_TheYear,parent."+this.NewName+".L_TheMonth)'>\r\n";
  		var selectInnerHTML = s;
  		for (var i = 1; i < 13; i++){
    		if (i == m)
       		{selectInnerHTML += "<option value='"+i+"' selected>"+i+"��"+"</option>\r\n";}
    		else {selectInnerHTML += "<option value='"+i+"'>"+i+"��"+"</option>\r\n";}
  		}
  		selectInnerHTML += "</select>";
		var DateLayer=this.GetDateLayer();
  		DateLayer.document.getElementById("SelectMonthLayer").style.display="";
  		DateLayer.document.getElementById("SelectMonthLayer").innerHTML = selectInnerHTML;
  		DateLayer.document.getElementById("L_SelectMonth").focus();
	},
	DayClick:function(mm,dd){  //�����ʾ��ѡȡ���ڣ������뺯��*************
		var yy=this.L_TheYear;
		//�ж��·ݣ������ж�Ӧ�Ĵ���
		if(mm<1){yy--;mm=12+mm;}
		else if(mm>12){yy++;mm=mm-12;}
  		//if (mm < 10){mm = "0" + mm;}
  		if (this.ClickObject)
  		{
  		    if (!dd) {return;}
    	    //if ( dd < 10){dd = "0" + dd;}
    	    this.InputObject.value= yy + "-" + mm + "-" + dd ; //ע�����������������ĳ�����Ҫ�ĸ�ʽ
    	    this.InputObject.focus();
    	    this.CloseLayer();
 		}
  		else {this.CloseLayer(); alert("����Ҫ����Ŀؼ����󲢲����ڣ�");}
	},
	SetDate:function(){
		if (arguments.length <  1){ alert("�Բ��𣡴������̫�٣�"); return; }
		else if (arguments.length >  2){alert("�Բ��𣡴������̫�࣡"); return;}
		this.InputObject=(arguments.length==1) ? arguments[0] : arguments[1];
		this.ClickObject=arguments[0];
		var reg = /^(\d+)-(\d{1,2})-(\d{1,2})$/;
		var r = this.InputObject.value.match(reg); 
		if(r!=null){
			r[2]=r[2]-1; 
			var d= new Date(r[1], r[2], r[3]); 
			if(d.getFullYear()==r[1] && d.getMonth()==r[2] && d.getDate()==r[3]){
				this.InputDate=d; //�����ⲿ���������
		    }
		    else this.InputDate="";
			this.L_TheYear=r[1];
			this.L_TheMonth=r[2]+1;
		} else{
			this.L_TheYear=new Date().getFullYear();
			this.L_TheMonth=new Date().getMonth() + 1
		}
		this.CreateHTML();
		var top=this.GetY();
		var left=this.GetX();
		var DateLayer=document.getElementById("L_DateLayer");
		DateLayer.style.top=top+this.ClickObject.clientHeight+0+"px";
		DateLayer.style.left=left+"px";
		DateLayer.style.display="block";
		if(document.all){
			this.GetDateLayer().document.getElementById("L_calendar").style.width="159px";
			this.GetDateLayer().document.getElementById("L_calendar").style.height="170px"
		} else{
			this.GetDateLayer().document.getElementById("L_calendar").style.width="154px";
			this.GetDateLayer().document.getElementById("L_calendar").style.height="178px"
			DateLayer.style.width="159px";
			DateLayer.style.height="250px";
		}
		//alert(DateLayer.style.display)
		this.SetDay(this.L_TheYear,this.L_TheMonth);
	},
	CloseLayer:function(){
		try{
			var DateLayer=document.getElementById("L_DateLayer");
			if((DateLayer.style.display=="" || DateLayer.style.display=="block") && arguments[0]!=this.ClickObject && arguments[0]!=this.InputObject){
				DateLayer.style.display="none";
			}
		}
		catch(e){}
		}
	}
	
document.writeln('<iframe id="L_DateLayer" name="L_DateLayer" frameborder="0" style="position:absolute;width:160px; height:188px;z-index:9998;display:none;"></iframe>');
var MyCalendar=new L_calendar();
MyCalendar.NewName="MyCalendar";

document.onclick=function(e){
	e = window.event || e;
  	var srcElement = e.srcElement || e.target;
	MyCalendar.CloseLayer(srcElement);
}