/*以下校验函数，通过返回true，否则为false; [huangsong]
  所有的函数2和原函数是一样的 ，如：CheckPN和CheckPN2
  以下校验函数中的参数page是向导的页码 ，不是向导的，不用此参数
*/
			

			var maxpn=99999999;
			var maxfn=99999999.9;
			var numerrormsg0="请输入0-99999999之内的数字";
			var numerrormsg1="请输入1-99999999之内的数字";
			var overerrormsg="数值超过最大值99999999";

//检查输入键是否为0~9,a~z(A~Z),Del,-,.,/
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

			//取整函数
			//eg. Round(132.123456) 为 132.12
			//eg. Round(132.123456,4) 为 132.1234
			//eg. Round(132.123456,0) 为 132
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
			
/*			功能： 得到两个日期相差的天数（每一个月按30天，一年360天计算）
			入口参数：	
						date1: 日期对象1
						date2: 日期对象2
						返回 date1 - date2相差的天数 */
			function getDiffDay(date1,date2)
			{
				var year=date1.getFullYear() - date2.getFullYear();
				var month=date1.getMonth() - date2.getMonth();
				var day=date1.getDate() - date2.getDate();				
				return year*12*30+month*30+day;
			}
			
			/*  功能： 把一个日期加上n天（每一个月按30天，一年360天计算）
				入口参数：	
						thedate: 要计算的日期对象
						days: 增加的天数 
				如果计算出的日期不合法： 年大于9999等，则返回false，否则true */
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
			
			
			/*	功能： 校验一个正整数
			入口参数：	
						CheckCtl: 要校验的输入框
						disptext: 出错显示的信息
						IsCanZero : 是否可以为零*/
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
			
			
			/*功能： 校验一个合法的增长率 ，精度为7位，整数3位,小数4位
			入口参数：	
						CheckCtl: 要校验的输入框
						disptext: 出错显示的信息	
						floatcount: 小数的最高位数（如果没有该参数，则默认为4位）						
						如果没有page参数，有floatcunt参数则：把page 置null
						如:	CheckIncRate(CheckCtl,"出错显示的信息",null,5)		
						IsNegative:是否可以为负数,如果没有该参数，则默认为不能）		*/
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
					disptext="输入值必须小于1000%";
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
						disptext="小数位数不能超过"+limitcount+"位";
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
			
			/*功能： 校验一个合法的大于等于0的浮点数
			入口参数：	
						CheckCtl: 要校验的输入框
						disptext: 出错显示的信息	
						floatcount: 小数的最高位数（如果没有该参数，则默认为4位）
						如果没有page参数，有floatcunt参数则：把page 置null
						如:	CheckFN(CheckCtl,"出错显示的信息",null,5)				*/
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
					 b=confirm("小数位数超过"+limitcount+"位,是否继续?"); 
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
			
				/*判断是否是数字的函数
			   输入：
			      txtctl   输入的文本控件
			      message  显示的错误信息
			      返回值   是数字返回true，不是返回false
					floatcount: 小数的最高位数（如果没有该参数，则默认为4位）
						如果没有page参数，有floatcunt参数则：把page 置null
						如:	IsNum(txtctl,"出错显示的信息",null,5)  */
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
					 b=confirm("小数位数超过"+limitcount+"位,是否继续?"); 
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
			
			/*功能： 校验一个值是否为空
			入口参数：	
						CheckCtl: 要校验的输入框
						disptext: 出错显示的信息						*/
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
			
			/*功能： 校验一个合法的且在规定范围内的整数
			入口参数：	
						CheckCtl: 要校验的输入框
						Min:  下限
						Max:  上限						
						Msg: 出错显示的信息  */
						
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
			/*功能： 校验一个合法的且在规定范围内的浮点数
			入口参数：	
						CheckCtl: 要校验的输入框
						Min:  下限
						Max:  上限						
						Msg: 出错显示的信息  */
						
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
			
			/*功能： 校验一个合法的身份证号码(15,18位)
			入口参数：	
						CheckCtl: 要校验的输入框												
						disptext: 出错显示的信息  */
						
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
					
			/*功能： 校验频率控件输入是否合法
			入口参数：	
						FCvalue：
						频率控件的radiolist的radiobutton2（和文本框对齐的哪个）
						FIvalue：
						频率控件的文本框
						disptext:
						出错显示的信息*/
						
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
								DispMessage(FIvalue,"频率(年)超过最大值999"); 
								result=false;
							 }
							
						}		
						return result;
			
					}					
					
				/*功能： 校验人生大事控件，
				入口参数：	
						RbInput：
						人生大事控件的radiolist的radiobutton2（和大事控件对齐的哪个）						
						TxtDate:人生大事控件包含的日期控件
						MsgDate:
						出错显示的信息
						page: 跳转的页，可无.
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
			/*功能： 比较两个日期的大小，如果开始日期大于结束日期，返回false;
			入口参数：	
						BDate:开始日期
						EDate:结束日期
						Msg:	出错显示的信息  */
			function CheckDiffDate(BDate,EDate,Msg)
			{
			    return CheckDiffDateNumber(BDate,EDate,0,Msg);
			}

				/*功能： 比较两个日期的大小，如果开始日期大于结束日期，返回false;
			入口参数：	
						BDate:开始日期
						EDate:结束日期
						Msg:	出错显示的信息  */
			function CheckDiffDateNumber(BDate,EDate,Days,Msg)
			{
				if ( (!CheckEmpty(BDate,"请输入日期！")) || (!CheckEmpty(EDate,"请输入日期！")) )
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
					DispMessage(BDate,"日期不能小于1900年！");
					return false;
				}
				if(EYear<1900)
				{
					DispMessage(EDate,"日期不能小于1900年！");
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
			/*功能： 将一个字符串转化为日期对象：	
						Str  字符串
			*/
			function StrToDate(str)
			{
				var arrayx=str.split("-");
				var datex=new Date(arrayx[0],arrayx[1]-1,arrayx[2]);
				return datex;
			}
			
			/*功能： 将一个日期对象转化为字符串：	
						
						date 日期对象
			*/
			function datetostring(date)
			{
				var s="";
				s=date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
				
				return s;
				
			}
			
			/*功能： 比较两个人生大事控件的日期
				入口参数：	
						datectl1：人生大事控件1(开始)
						datectl2：人生大事控件2(结束)
						(如果datectl1的日期大于datectl2则返回false)
						msgdate:
						出错显示的信息
						page: 跳转的页，可无.
			*/
				
			function CheckDiffLiftDateCtl(datectl1,datectl2,msgdate,page)
			{
				date1=getliftCtlDate(datectl1);
				date2=getliftCtlDate(datectl2);
				if (date2==0) return true; //结束日期为空，则不校验
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
			
			/*功能： 得到人生大事控件的日期
			 (返回日期型)
				入口参数：	
						datectl：人生大事控件
			*/
			function getliftCtlDate(datectl)
			{
				var date1;
				var datectltable=datectl.firstChild; //人生大事控件table,
				var pa=datectltable.rows[0].cells[0].firstChild;//rb的table
				pa=pa.rows[1].cells[0].firstChild; //下拉框对应的rb
				if (pa.checked)
				 {
				  var tarctl=datectltable.rows[0].cells[1].firstChild.firstChild;//包含下拉框的表格				 
				  tarctl=tarctl.rows[1].cells[0].firstChild.nextSibling; //下拉框(下拉框被替换了，所以变成了第二个child，而不是第一个 )
				  var valuestr=tarctl.value.split(",");
				  date1=Cal_strtodate(valuestr[1]);
				 }
				else
				 {
					var tarctl=datectltable.rows[0].cells[1].firstChild.firstChild;//包含datepicker的表格
					tarctl=tarctl.rows[0].cells[0].firstChild; //datepicker的spin
					tarctl=tarctl.children[0]; //输入日期的input
					date1=Cal_strtodate(tarctl.value);
				 } 
				 
				 return date1;
			}

