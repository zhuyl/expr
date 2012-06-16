
//�õ�������ұ���
function ComAllMoneyType(combo, xmlDoc)
{
  var xmlroot = xmlDoc.documentElement;    
  
  var oOption = document.createElement("OPTION");
  
  combo.options.add(oOption);
  oOption.innerText = "�����";
  oOption.value = 1;

  for (i=0; i<(xmlroot.childNodes.length); i++)//��ÿһ�������д���
  {   
     oOption = document.createElement("OPTION");
     combo.options.add(oOption);
     oOption.innerText = xmlroot.childNodes.item(i).childNodes.item(1).text;
     oOption.value = xmlroot.childNodes.item(i).childNodes.item(0).text;
     
  }

}

//��ȡ�����б�����������ͣ�
function ComSaveTime(combo,typeid, xmlDoc)
{
  var xmlroot = xmlDoc.documentElement;    
  for (i=0; i<(xmlroot.childNodes.length); i++)//��ÿһ�������д���
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

//��ȡ��Ҵ�������б�
function ComForeSaveMoneyType(combo, xmlDoc)
{
  var j=0;
  var xmlroot = xmlDoc.documentElement;    
  for (i=0; i<(xmlroot.childNodes.length); i++)//��ÿһ�������д���
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

//��ȡ��������Ĵ���
function ComEduSaveTime(combo,typeid, xmlDoc)
{
  var xmlroot = xmlDoc.documentElement;    
  for (i=0; i<(xmlroot.childNodes.length); i++)//��ÿһ�������д���
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
    return "������";
  else if (perior == 6 )
    return "����";
  else if (perior >= 12)
    return GetChinaNumber(perior/12)+"��";
  else if (perior>0)
    return GetChinaNumber(perior)+"����";      
  else
    return "������";  
}

function GetChinaNumber(integer)
{
  switch(integer)
  {
  case "0":
  case 0:
     return "��";
  case "1":   
  case 1:
     return "һ";
  case "2":   
  case 2:
     return "��";
  case "3":   
  case 3:
     return "��";
  case "4":   
  case 4:
     return "��";
  case "5":   
  case 5:
     return "��";
  case "6":   
  case 6:
     return "��";
  case "7":   
  case 7:
     return "��";
  case "8":   
  case 8:
     return "��";
  case "9":   
  case 9:
     return "��";
 }                            
}
//�������뺯����Ϊ�˼��IE5����������ת�����֣�С�����λ������NUMBER,liwenjie
function NBround(nb,len)
{
  var strnb=new String(nb);
  if (nb < 0.00000000000001) return new Number(0); // ��Ϊ���ܳ���3.5E-27֮������
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

//�����������ڵ�������
function GetDayLen(Date1,Date2)
{
	var StartDate=new Date(Date1);
	var StandDate=new Date(Date2);
    
    // ʵ���������㷨
    return (StartDate-StandDate)/(24*60*60*1000);
	
	// ��ÿ��30����һ�£�һ��Ϊ360��
    //var DiffDay=(StartDate.getFullYear()-StandDate.getFullYear())*360+(StartDate.getMonth()-StandDate.getMonth())*30+(StartDate.getDate()-StandDate.getDate());
	
	//return DiffDay;
}

