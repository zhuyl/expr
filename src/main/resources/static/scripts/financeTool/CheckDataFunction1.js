/*����У�麯����ͨ������true������Ϊfalse; [huangsong]
  ���еĺ���2��ԭ������һ���� ���磺CheckPN��CheckPN2
  ����У�麯���еĲ���page���򵼵�ҳ�� �������򵼵ģ����ô˲���
*/
			

			var maxpn=99999999;
			var maxfn=99999999.9;
			var numerrormsg0="������0-99999999֮�ڵ�����";
			var numerrormsg1="������1-99999999֮�ڵ�����";
			var overerrormsg="��ֵ�������ֵ99999999";

//���������Ƿ�Ϊ0~9,a~z(A~Z),Del,-,.,/
function CheckKey(KeyCode)
{
Zero=48;
Nine=57;
Delete=46;
Minus=189;
Dot=190;
Divide=191;
Key_a=65;
Key_z=90;
_Zero=96;
_Nine=105;
_Divide=111;
_Minus=109;
_Dot=110;
return ((KeyCode>=Key_a)&&(KeyCode<=Key_z))||((KeyCode>=Zero)&&(KeyCode<=Nine))||((KeyCode>=_Zero)&&(KeyCode<=_Nine))||(KeyCode==Delete)||(KeyCode==Dot)||(KeyCode==Minus)||(KeyCode==Divide)||(KeyCode==0)||(KeyCode==_Minus)||(KeyCode==_Divide)||(KeyCode==_Dot);
}

			//ȡ������
			//eg. Round(132.123456) Ϊ 132.12
			//eg. Round(132.123456,4) Ϊ 132.1234
			//eg. Round(132.123456,0) Ϊ 132
			function Round(i,digit)
			{
				if(digit==0)
					p=1;
				else
				{
					if(digit)
						p=Math.pow(10,digit);
					else
						p=100;
				}
				return Math.round(i*p)/p;
			}
			
/*			���ܣ� �õ�������������������ÿһ���°�30�죬һ��360����㣩
			��ڲ�����	
						date1: ���ڶ���1
						date2: ���ڶ���2
						���� date1 - date2�������� */
			function getDiffDay(date1,date2)
			{
				var year=date1.getFullYear() - date2.getFullYear();
				var month=date1.getMonth() - date2.getMonth();
				var day=date1.getDate() - date2.getDate();				
				return year*12*30+month*30+day;
			}
			
			/*  ���ܣ� ��һ�����ڼ���n�죨ÿһ���°�30�죬һ��360����㣩
				��ڲ�����	
						thedate: Ҫ��������ڶ���
						days: ���ӵ����� 
				�������������ڲ��Ϸ��� �����9999�ȣ��򷵻�false������true */
			function addday(thedate,days)
			{
				day=thedate.getDate();
				month=thedate.getMonth()+1;
				year=thedate.getFullYear();
				mod_y=days % 360;
				y=Math.floor(days/360);
				year+=y;				
				if (mod_y!=0)
				{
					mod_m=mod_y % 30;
					m=Math.floor(mod_y / 30);
					month+=m;
					
					if (mod_m!=0)
					{
						
						day+=mod_m;						
						if (day>30)
						 {
						  month++;
						  day-=30;
						 }
					}				
				 }
				thedate.setTime(new Date(year,month-1,day)); 
				return (year<=9999);
			}
			
			
			/*	���ܣ� У��һ��������
			��ڲ�����	
						CheckCtl: ҪУ��������
						disptext: ������ʾ����Ϣ
						IsCanZero : �Ƿ����Ϊ��*/
			function CheckPN(CheckCtl,disptext,IsCanZero,page) 
			{
				var s=new String(Trim(CheckCtl.value));
				var temp=parseInt(s);
				var result=true;
				if (  (isNaN(temp)) || (temp<0) || ( s.indexOf(".")>=0 )||(temp!=s))
				{
					result=false;
				}				
				else if ( (!IsCanZero)&&(temp==0) )
				 {
				 	result=false;
				 }
				if  (temp>maxpn) 
				{
					result=false;
					disptext=overerrormsg;
				}
				 if (!result)
				 {
					if (page)
					 showguide(page);
					DispMessage(CheckCtl, disptext);
					return false;
				}					
				 return true;
				 
			}
			
			
			
			function CheckPN2(CheckCtl,disptext,IsCanZero,page)
			{  
				return CheckPN(CheckCtl,disptext,IsCanZero,page);		
			}			
			
			
			/*���ܣ� У��һ���Ϸ��������� ������Ϊ7λ������3λ,С��4λ
			��ڲ�����	
						CheckCtl: ҪУ��������
						disptext: ������ʾ����Ϣ	
						floatcount: С�������λ�������û�иò�������Ĭ��Ϊ4λ��						
						���û��page��������floatcunt�����򣺰�page ��null
						��:	CheckIncRate(CheckCtl,"������ʾ����Ϣ",null,5)		
						IsNegative:�Ƿ����Ϊ����,���û�иò�������Ĭ��Ϊ���ܣ�		*/
			function CheckIncRate(CheckCtl,disptext,page,floatcount,IsNegative)
			{					
				var s=new String(Trim(CheckCtl.value));
				temp=parseFloat(s);
				var result=true;
				if( (isNaN(temp)) || ((temp< 0)&&(!IsNegative))||(temp!=s) )
				{					
					result=false;
				}	
				else if (temp>=1000) 
				{					
					result=false;
					disptext="����ֵ����С��1000%";
				}
				else
				{ 	 					
					limitcount=floatcount?floatcount:4;
					var array=s.split(".");
					if (array[1]==null)
					count=-1;
					else
					{
					var str=new String(array[1]);
					count=str.length;
					}
					if (count>limitcount)
					{
						result=false;					
						disptext="С��λ�����ܳ���"+limitcount+"λ";
					}
				 }	
				 if (!result)
				 {
					if (page)
					 showguide(page);
					DispMessage(CheckCtl,disptext);
					return false;
				 }			
				    return true;
				
			}
			
			/*���ܣ� У��һ���Ϸ��Ĵ��ڵ���0�ĸ�����
			��ڲ�����	
						CheckCtl: ҪУ��������
						disptext: ������ʾ����Ϣ	
						floatcount: С�������λ�������û�иò�������Ĭ��Ϊ4λ��
						���û��page��������floatcunt�����򣺰�page ��null
						��:	CheckFN(CheckCtl,"������ʾ����Ϣ",null,5)				*/
			function CheckFN(CheckCtl,disptext,page,floatcount)
			{					
				var s=new String(Trim(CheckCtl.value));
				temp=parseFloat(s);
				var result=true;
				if( (isNaN(temp)) || (temp< 0)||(temp!=s) )
				{					
					result=false;
				}	
				else if (temp>maxfn) 
				{
					result=false;
					disptext=overerrormsg;
				}
				else
				{ 	 					
					limitcount=floatcount?floatcount:4;
					var array=s.split(".");
					if (array[1]==null)
					count=-1;
					else
					{
					var str=new String(array[1]);
					count=str.length;
					}
					if (count>limitcount)
					{
					if (page)
						showguide(page);
					 b=confirm("С��λ������"+limitcount+"λ,�Ƿ����?"); 
					 if (b)
					  {
					   return true;
					  }
					  else
					  {
					    CheckCtl.select();
						CheckCtl.focus();
						return false;
					  }
					}
				 }	
				 if (!result)
				 {
					if (page)
					 showguide(page);
					DispMessage(CheckCtl,disptext);
					return false;
				 }			
				    return true;
				
			}
						
			
			function CheckFN2(CheckCtl,disptext,page,floatcount)
			{  
				return CheckFN(CheckCtl,disptext,page,floatcount);
			}
			
			function CheckFN3(CheckCtl,disptext,IsCanZero,page,floatcount)
			{					
				
				if ( CheckFN(CheckCtl,disptext,page,floatcount) )
				 {
					if ( (parseFloat(CheckCtl.value)==0) &&(!IsCanZero) )
						{
							if (page)
								showguide(page);
							DispMessage(CheckCtl,disptext);
							return false;
						}
					else return true;	
				 }		
				else
				 return false;
			}
			
				/*�ж��Ƿ������ֵĺ���
			   ���룺
			      txtctl   ������ı��ؼ�
			      message  ��ʾ�Ĵ�����Ϣ
			      ����ֵ   �����ַ���true�����Ƿ���false
					floatcount: С�������λ�������û�иò�������Ĭ��Ϊ4λ��
						���û��page��������floatcunt�����򣺰�page ��null
						��:	IsNum(txtctl,"������ʾ����Ϣ",null,5)  */
			function IsNum(txtctl,message,page,floatcount,norange)
			{
				var s=new String(Trim(txtctl.value));
				var result=true;
				var num=Number(s);
				if ( (isNaN(num)) || (s=="") )
				{
					result=false;
				}						
				else if (num>maxfn)
				{
					if (!norange)
					{
						message=overerrormsg;
						result=false;
					}
				}
				else
				{
					limitcount=floatcount?floatcount:4;
					var array=s.split(".");
					if (array[1]==null)
					count=-1;
					else
					{
					var str=new String(array[1]);
					count=str.length;
					}
					if (count>limitcount)
					{
					 if (page)
						showguide(page);
					 b=confirm("С��λ������"+limitcount+"λ,�Ƿ����?"); 
					 if (b)
					  {
					   return true;
					  }
					  else
					  {
					    txtctl.select();
						txtctl.focus();
						return false;
					  }
					}
				}
				if (!result)
				{
					if (page)
						showguide(page);
					DispMessage(txtctl,message);
					return false;
				}	
					return true;	
			}
		
			function IsNum2(txtctl,message,page,floatcount)
			{
				return IsNum(txtctl,message,page,floatcount);
			} 


			function CheckEmpty2(CheckCtl,disptext,page)
			{  
				return CheckEmpty(CheckCtl,disptext,page);
			}
			
			/*���ܣ� У��һ��ֵ�Ƿ�Ϊ��
			��ڲ�����	
						CheckCtl: ҪУ��������
						disptext: ������ʾ����Ϣ						*/
			function CheckEmpty(CheckCtl,disptext,page)
			{				
				if (Trim(CheckCtl.value)=="" )
				{
					if (page)
					 showguide(page);
					DispMessage(CheckCtl,disptext);	
					return false;
				}
				else
				  return true;
			}
			
		
			function CheckIntRange2(CheckCtl,Min, Max,Msg,page)
			{
				return CheckIntRange(CheckCtl,Min, Max,Msg,page);
			}
			
			/*���ܣ� У��һ���Ϸ������ڹ涨��Χ�ڵ�����
			��ڲ�����	
						CheckCtl: ҪУ��������
						Min:  ����
						Max:  ����						
						Msg: ������ʾ����Ϣ  */
						
			function CheckIntRange(CheckCtl,Min, Max,Msg,page)
			{			
				if (!IsNum(CheckCtl,Msg,page,null,1))
				return false;
				var s=new String(Trim(CheckCtl.value));
				v=parseInt(s);			    	
				if  ( (v<Min) || (v>Max) || (s.indexOf(".")>=0))
				{
					if (page)
					 showguide(page);
					DispMessage(CheckCtl,Msg);
					return false;
				}
				return true;		
			}
			/*���ܣ� У��һ���Ϸ������ڹ涨��Χ�ڵĸ�����
			��ڲ�����	
						CheckCtl: ҪУ��������
						Min:  ����
						Max:  ����						
						Msg: ������ʾ����Ϣ  */
						
			function CheckFloatRange(CheckCtl,Min, Max,Msg,page)
			{			
				if (!IsNum(CheckCtl,Msg,page,null,1))
					return false;
				v=parseFloat(Trim(CheckCtl.value));		    	
				if  ( (v<Min) || (v>Max) )
				{
					if (page)
					 showguide(page);
					DispMessage(CheckCtl,Msg);
					return false;
				}
				return true;		
			}
			
			/*���ܣ� У��һ���Ϸ������֤����(15,18λ)
			��ڲ�����	
						CheckCtl: ҪУ��������												
						disptext: ������ʾ����Ϣ  */
						
			function CheckCardNo(CheckCtl,disptext,page)
			{
				var result=true;
				var strvalue=new String(Trim(CheckCtl.value));
				if ( strvalue!="" )
					{
						if ((strvalue.length<15) || (strvalue.length>20))
							result=false;								
					}	 				
				if (!result)
				 {
					if (page)
						showguide(page);
					DispMessage(CheckCtl,disptext); 
				 }
				return result;
			}
			
			function DispMessage(CheckCtl,Msg)
			{
				if (Msg!="")
				{					
					alert(Msg);					
					CheckCtl.select();
					CheckCtl.focus();
				}
			}
			

			
			function Trim(strSource) 
			{
				return 	strSource.replace(/^\s*/,'').replace(/\s*$/,'');
			}
					
			/*���ܣ� У��Ƶ�ʿؼ������Ƿ�Ϸ�
			��ڲ�����	
						FCvalue��
						Ƶ�ʿؼ���radiolist��radiobutton2�����ı��������ĸ���
						FIvalue��
						Ƶ�ʿؼ����ı���
						disptext:
						������ʾ����Ϣ*/
						
			function CheckFreq2(FCvalue,FIvalue,disptext,page) 
			{  
				return CheckFreq(FCvalue,FIvalue,disptext,page);
			}

				function CheckFreq(FCvalue,FIvalue,disptext,page) 
					{
						var result=true;
						if (FCvalue.checked)
						{
							var s=new String(Trim(FIvalue.value));
							var temp=parseInt(s);
							if (  (isNaN(temp)) || (temp<0) || ( s.indexOf(".")>=0 )||(temp!=s))
							{
								if (page)
									showguide(page);
								DispMessage(FIvalue,disptext); 
								result=false;
							}
							else
								result=true;
							if (result)
							 if (parseInt(FIvalue.value)>999)
							 {
								if (page)
									showguide(page);
								DispMessage(FIvalue,"Ƶ��(��)�������ֵ999"); 
								result=false;
							 }
							
						}		
						return result;
			
					}					
					
				/*���ܣ� У���������¿ؼ���
				��ڲ�����	
						RbInput��
						�������¿ؼ���radiolist��radiobutton2���ʹ��¿ؼ�������ĸ���						
						TxtDate:�������¿ؼ����������ڿؼ�
						MsgDate:
						������ʾ����Ϣ
						page: ��ת��ҳ������.
				*/
				
			function CheckLiftDateCtl(RbInput,TxtDate,MsgDate,page)
			{
				if (!RbInput.checked)				
					return CheckEmpty(TxtDate,MsgDate,page);					 								
				return true;
				
			}
					
					
			function CheckDiffDate2(BDate,EDate,Msg,page,Order)
			{
				if (!CheckDiffDate(BDate,EDate,""))
				{
					showguide(page);
					if(Order)
						DispMessage(BDate,Msg);
					else
						DispMessage(EDate,Msg);
					return false;
				}	
				else
					return true;
			}
			/*���ܣ� �Ƚ��������ڵĴ�С�������ʼ���ڴ��ڽ������ڣ�����false;
			��ڲ�����	
						BDate:��ʼ����
						EDate:��������
						Msg:	������ʾ����Ϣ  */
			function CheckDiffDate(BDate,EDate,Msg)
			{
			    return CheckDiffDateNumber(BDate,EDate,0,Msg);
			}

				/*���ܣ� �Ƚ��������ڵĴ�С�������ʼ���ڴ��ڽ������ڣ�����false;
			��ڲ�����	
						BDate:��ʼ����
						EDate:��������
						Msg:	������ʾ����Ϣ  */
			function CheckDiffDateNumber(BDate,EDate,Days,Msg)
			{
				if ( (!CheckEmpty(BDate,"���������ڣ�")) || (!CheckEmpty(EDate,"���������ڣ�")) )
					return false;
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
				if(BYear<1900)
				{
					DispMessage(BDate,"���ڲ���С��1900�꣡");
					return false;
				}
				if(EYear<1900)
				{
					DispMessage(EDate,"���ڲ���С��1900�꣡");
					return false;
				}

				b=(BYear*10000)+(BMonth*100)+BDay+Days;
				e=(EYear*10000)+(EMonth*100)+EDay;
				if(e==b)
					return true;
				else 
					if(e>b)
						return true;
					else 
					{
						DispMessage(BDate,Msg);
						return false;
					}
			}
			/*���ܣ� ��һ���ַ���ת��Ϊ���ڶ���	
						Str  �ַ���
			*/
			function StrToDate(str)
			{
				var arrayx=str.split("-");
				var datex=new Date(arrayx[0],arrayx[1]-1,arrayx[2]);
				return datex;
			}
			
			/*���ܣ� ��һ�����ڶ���ת��Ϊ�ַ�����	
						
						date ���ڶ���
			*/
			function datetostring(date)
			{
				var s="";
				s=date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
				
				return s;
				
			}
			
			/*���ܣ� �Ƚ������������¿ؼ�������
				��ڲ�����	
						datectl1���������¿ؼ�1(��ʼ)
						datectl2���������¿ؼ�2(����)
						(���datectl1�����ڴ���datectl2�򷵻�false)
						msgdate:
						������ʾ����Ϣ
						page: ��ת��ҳ������.
			*/
				
			function CheckDiffLiftDateCtl(datectl1,datectl2,msgdate,page)
			{
				date1=getliftCtlDate(datectl1);
				date2=getliftCtlDate(datectl2);
				if (date2==0) return true; //��������Ϊ�գ���У��
				if ( date1>date2 )
				 {
				 	if (page)
						showguide(page);
					DispMessage(datectl1.firstChild.rows[0].cells[1].firstChild.firstChild.rows[0].cells[0].firstChild.children[0],msgdate);
					return false;
				 }
				else
				    return true; 
				
			}
			
			/*���ܣ� �õ��������¿ؼ�������
			 (����������)
				��ڲ�����	
						datectl���������¿ؼ�
			*/
			function getliftCtlDate(datectl)
			{
				var date1;
				var datectltable=datectl.firstChild; //�������¿ؼ�table,
				var pa=datectltable.rows[0].cells[0].firstChild;//rb��table
				pa=pa.rows[1].cells[0].firstChild; //�������Ӧ��rb
				if (pa.checked)
				 {
				  var tarctl=datectltable.rows[0].cells[1].firstChild.firstChild;//����������ı��				 
				  tarctl=tarctl.rows[1].cells[0].firstChild.nextSibling; //������(�������滻�ˣ����Ա���˵ڶ���child�������ǵ�һ�� )
				  var valuestr=tarctl.value.split(",");
				  date1=Cal_strtodate(valuestr[1]);
				 }
				else
				 {
					var tarctl=datectltable.rows[0].cells[1].firstChild.firstChild;//����datepicker�ı��
					tarctl=tarctl.rows[0].cells[0].firstChild; //datepicker��spin
					tarctl=tarctl.children[0]; //�������ڵ�input
					date1=Cal_strtodate(tarctl.value);
				 } 
				 
				 return date1;
			}

