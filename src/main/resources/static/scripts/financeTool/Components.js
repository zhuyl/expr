
//得到所有外币币种
function ComAllMoneyType(combo, xmlDoc)
{
  var xmlroot = xmlDoc.documentElement;    
  
  var oOption = document.createElement("OPTION");
  
  combo.options.add(oOption);
  oOption.innerText = "人民币";
  oOption.value = 1;

  for (i=0; i<(xmlroot.childNodes.length); i++)//对每一个结点进行处理
  {   
     oOption = document.createElement("OPTION");
     combo.options.add(oOption);
     oOption.innerText = xmlroot.childNodes.item(i).childNodes.item(1).text;
     oOption.value = xmlroot.childNodes.item(i).childNodes.item(0).text;
     
  }

}

//获取存期列表（传入存款的类型）
function ComSaveTime(combo,typeid, xmlDoc)
{
  var xmlroot = xmlDoc.documentElement;    
  for (i=0; i<(xmlroot.childNodes.length); i++)//对每一个结点进行处理
  {   
    if (xmlroot.childNodes.item(i).childNodes.item(4).text == typeid)
    {
     var oOption = document.createElement("OPTION");
     
     combo.options.add(oOption);
     oOption.innerText = GetHowLong(xmlroot.childNodes.item(i).childNodes.item(3).text);
     oOption.value = xmlroot.childNodes.item(i).childNodes.item(3).text;
    

     }
     
       
  }
  
}

//获取外币存款的外币列表
function ComForeSaveMoneyType(combo, xmlDoc)
{
  var j=0;
  var xmlroot = xmlDoc.documentElement;    
  for (i=0; i<(xmlroot.childNodes.length); i++)//对每一个结点进行处理
  {   
    if (xmlroot.childNodes.item(i).childNodes.item(3).text != j)
    {
    
      var oOption = document.createElement("OPTION");
     combo.options.add(oOption);
     oOption.innerText = xmlroot.childNodes.item(i).childNodes.item(3).text;
     oOption.value = xmlroot.childNodes.item(i).childNodes.item(2).text;
    
     j = xmlroot.childNodes.item(i).childNodes.item(3).text;       
     } 
  }
  
}

//获取其他储蓄的存期
function ComEduSaveTime(combo,typeid, xmlDoc)
{
  var xmlroot = xmlDoc.documentElement;    
  for (i=0; i<(xmlroot.childNodes.length); i++)//对每一个结点进行处理
  { 
    if (xmlroot.childNodes.item(i).childNodes.item(1).text == typeid)
    {
     var oOption = document.createElement("OPTION");
     
     combo.options.add(oOption);
     oOption.innerText = xmlroot.childNodes.item(i).childNodes.item(2).text;
     oOption.value = xmlroot.childNodes.item(i).childNodes.item(4).text;
    

     }
     
       
  }
  
}


function GetHowLong(perior)
{
  //
  if (perior ==3 )
    return "三个月";
  else if (perior == 6 )
    return "半年";
  else if (perior >= 12)
    return GetChinaNumber(perior/12)+"年";
  else if (perior>0)
    return GetChinaNumber(perior)+"个月";      
  else
    return "无限期";  
}

function GetChinaNumber(integer)
{
  switch(integer)
  {
  case "0":
  case 0:
     return "零";
  case "1":   
  case 1:
     return "一";
  case "2":   
  case 2:
     return "二";
  case "3":   
  case 3:
     return "三";
  case "4":   
  case 4:
     return "四";
  case "5":   
  case 5:
     return "五";
  case "6":   
  case 6:
     return "六";
  case "7":   
  case 7:
     return "七";
  case "8":   
  case 8:
     return "八";
  case "9":   
  case 9:
     return "九";
 }                            
}
//四舍五入函数，为了兼顾IE5（参数：欲转换数字，小数点后几位）返回NUMBER,liwenjie
function NBround(nb,len)
{
  var strnb=new String(nb);
  if (nb < 0.00000000000001) return new Number(0); // 因为可能出现3.5E-27之类的情况
  pos = strnb.indexOf(".");
  if ((pos == -1) || (strnb.length-pos-1)<len)
    return new Number(strnb);
  else 
  {
    var last = strnb.substring(pos+len+1,pos+len+2);
    var nblast = new Number(last);
    if (nblast<5)
      return new Number(strnb.substring(0,pos+len+1));
    else
       {
           if (strnb.substring(0,1)=="-")
              return new Number(new String(new Number(strnb.substring(0,pos+len+1))-Math.pow(10,-1*len)).substring(0,pos+len+1));
          else
          return new Number(new String(new Number(strnb.substring(0,pos+len+1))+Math.pow(10,-1*len)).substring(0,pos+len+1));
      //return new Number(strnb.substring(0,pos+len+1))+Math.pow(10,-1*len);
       }
  }
}

//计算两个日期的天数差
function GetDayLen(Date1,Date2)
{
	var StartDate=new Date(Date1);
	var StandDate=new Date(Date2);
    
    // 实际天数的算法
    return (StartDate-StandDate)/(24*60*60*1000);
	
	// 以每月30天算一月，一年为360天
    //var DiffDay=(StartDate.getFullYear()-StandDate.getFullYear())*360+(StartDate.getMonth()-StandDate.getMonth())*30+(StartDate.getDate()-StandDate.getDate());
	
	//return DiffDay;
}

