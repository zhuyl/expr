<#include "/template/head.ftl"/>
<SCRIPT language=javascript charset="gb2312">
      <!--
function warnInvalid (theField, s)
	{	alert(s);
	    theField.focus();
		theField.select();
		return false;
	}

function isNumber(s)   //字符串是否由数字构成
	{
		var digits = "0123456789";
		var i = 0;
		var sLength = s.length;

		while ((i < sLength))
		{ 
			var c = s.charAt(i);
			if (digits.indexOf(c) == -1) return 

false; 
			i++;
		}

		return true;
	}

function CheckNumeric(theField,s)  //整数或小数
	{
		var ret = true;
		var i;
		var str=theField.value;
		var Temp = new Number(str);

		if (str.length == 0)
		{
  		    return warnInvalid (theField, s);
  		    ret=false;
		}

		if (ret)
		{
			if (Temp.valueOf() != Temp.valueOf

())
			{
  				return warnInvalid 

(theField, s);
			}
		}

		return ret;
	}
function validateFormInfo(form)
	{
		var str
		var SumTo
  		var srSum
  		var qzSum,InsuSum,TSum,yzSum,fySum

  		s=document.form1.select.selectedIndex+1;
  		srSum=document.form1.textfield.value;
  		if (s<1)
 		{
 		  s=1;
 		}
 		qzSum=document.form1.textfield3.value;
 		InsuSum=document.form1.textfield2.value;
 		yzSum=document.form1.textfield22.value;
 		fySum=document.form1.textfield32.value;
 		TSum=srSum-qzSum-InsuSum;
 		/*alert

("sr="+srSum+"qz="+qzSum+"INsu="+InsuSum+"yz="+yzSum+"fy="+

fySum);*/

		if (form == null) return true; 
		str = "请正确输入收入金额！";
 		if (!CheckNumeric(form.elements

["textfield"],str)) return false;  //收入金额

 		if (document.all.select.selectedIndex==0)
		{
		  str = "请正确输入社会保险费！";
		  if  (!CheckNumeric(form.elements

["textfield2"],str)) return false; //各项社会保险费

   	          str = "请正确输入起征额！";
		  if  (!CheckNumeric(form.elements

["textfield3"],str)) return false; //起征额
		}

		if (document.all.select.selectedIndex==8)
		{
		  str = "请正确输入财产原值！";
		  if  (!CheckNumeric(form.elements

["textfield22"],str)) return false; //各项社会保险费

   		  str = "请正确输入合理交易费用！";
		  if  (!CheckNumeric(form.elements

["textfield32"],str)) return false; //起征额
		}

		switch (s) 
  		{ 
    		case 1: 

document.form1.textfield4.value=Rate1(TSum);
           		break;           		    

    		case 2:

document.form1.textfield4.value=Rate2(srSum);
    			break;

    		case 3:

document.form1.textfield4.value=Rate2(srSum);
    			break;

    		case 4:

document.form1.textfield4.value=Rate3(srSum);
    			break;

    		case 5:

document.form1.textfield4.value=bookfee(srSum);
    			break;

    		case 6:

document.form1.textfield4.value=spe(srSum);
    			break;

    		case 7:

document.form1.textfield4.value=srSum*20/100;
    			break;

    		case 8:

document.form1.textfield4.value=R4568(srSum);
    			break;

    		case 9:
    			if (srSum-yzSum-fySum<0)
    			{
    			  alert("都亏了！不用交税了！");

document.form1.textfield4.value=0;
    			}
    			if (srSum-yzSum-fySum>0)
    			{
    			document.form1.textfield4.value=

(srSum-yzSum-fySum)*20/100;
    			}
    			break;

    		case 10:

document.form1.textfield4.value=srSum*20/100;
    			break;

    		case 11:

document.form1.textfield4.value=spe(srSum);
    			break;

		}

	}
//--------------------------------以下是算法--------------

//---------------------------------------
function Rate1(XSum)//工资薪金
	{
	var Rate;
	var Balan;
	var TSum;
	if (XSum<=500) 
	  {Rate=5;
	  Balan=0;
	  }
	if ((500<XSum) && (XSum<=2000)) 
	  {Rate=10;
	  Balan=25;
	  }
	if ((2000<XSum) && (XSum<=5000))
	  {Rate=15;
	  Balan=125;
	  }
	if ((5000<XSum) && (XSum<=20000))
	  {Rate=20;
	  Balan=375;
	  }
	if ((20000<XSum) && (XSum<=40000))
	  {Rate=25;
	  Balan=1375;
	  }
	if ((40000<XSum) && (XSum<=60000))
	  {Rate=30;
	  Balan=3375;
	  }
	if ((60000<XSum) && (XSum<=80000))
	  {Rate=35;
	  Balan=6375;
	  }
	if ((80000<XSum) && (XSum<=100000))
	  {Rate=40;
	  Balan=10375;
	  }
	if (XSum>100000) 
	  {Rate=45;
	  Balan=15375;
	  }
	  TSum=(XSum*Rate)/100-Balan
	 if (TSum<0) 
	 {
	   TSum=0
	 }
	  return TSum
	}

function Rate2(XSum)
	{
	var Rate;
	var Balan;
	var TSum;
	if (XSum<=5000) 
	  {Rate=5;
	  Balan=0;
	  }
	if ((5000<XSum) && (XSum<=10000)) 
	  {Rate=10;
	  Balan=250;
	  }
	if ((10000<XSum) && (XSum<=30000))
	  {Rate=20;
	  Balan=1250;
	  }
	if ((30000<XSum) && (XSum<=50000))
	  {Rate=30;
	  Balan=4250;
	  }
	if (50000<XSum)
	  {Rate=35;
	  Balan=6750;
	  }
	 TSum=(XSum*Rate)/100-Balan;
	 if (TSum<0)
	 {
	   TSum=0
	 }
	 return TSum
	}

function R4568(XSum)
  {
  var TSum
    if (XSum<=4000)
    {
    TSum=(XSum-1600)*20/100;
    }
    if (XSum>4000)
    {
    TSum=(XSum-(XSum*20/100))*20/100
    }
    if (TSum<0)
    {
       TSum=0
    }
    return TSum
  }
  function gong()
  {
  var qznum
  var ff
  qznum=document.form1.textfield3.value;
  ff=document.all.checkbox.checked;
  if (ff)
  {
  document.form1.textfield3.value=4000;
  }
  if (!ff)
  {
  document.form1.textfield3.value=1600;
  }
  }

  function bookfee(income){
	if( income <= 800 )	return 0;
	if( income > 800 && income <=4000 ) return (income-800)*0.2*0.7;
	if( income > 4000 ) return income*0.8*0.2*0.7;
  }
  function spe(income){
	if( income <= 800 )	return 0;
	if( income > 800 && income <=4000 ) return (income-800)*0.2;
	if( income > 4000 ) return income*0.8*0.2;
  }
function Rate3(XSum)/*劳务报酬*/
{
  var TSum
  var Rate
  var Balan
  if (XSum<=20000)
  {
    Rate=20;
    Balan=0;
  }
  if ((XSum>20000) && (XSum<=50000))
  {
    Rate=30;
    Balan=2000;
  }
  if (XSum>50000)
  {
    Rate=40;
    Balan=7000;
  }
  if (XSum<=4000)
  {
   XSum=XSum-800;
  }
  if (XSum>4000)
  {
   XSum=XSum-(XSum*20/100);
  }

  TSum=XSum*Rate/100-Balan;

  if (TSum<0)
  {
   TSum=0
  }
  return TSum
}

function CHan()
{
  if (document.form1.select.selectedIndex==0)
  {
   document.all.gongzi.style.display="block";
   document.all.fei.style.display="block";
  }
  if (document.form1.select.selectedIndex!=0)
  {
   document.all.gongzi.style.display="none";
   document.all.fei.style.display="none";
  }
  if (document.form1.select.selectedIndex+1!=9)
  {
   document.all.fei1.style.display="none";
  }
  if (document.form1.select.selectedIndex+1==9)
  {
   document.all.fei1.style.display="block";
  }

}

//-->
      </SCRIPT>
<BODY LEFTMARGIN="0" TOPMARGIN="0">
<FORM name=form1>
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCFF" style="border-collapse:collapse;" >
  <tr> 
    <td height="23" background="${base}/static/images/titlebg.gif"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
            
            
          <td><img src="${base}/static/images/titlearrow.gif" width="8" height="13"> <span class="title"><B>个人所得税计算器</B></span></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td> <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
            
            
          <td height="25" class="explain">个人所得税计算器可以帮您计算您所得应缴的税额</td>
        </tr>
      </table>
        
        <TABLE width=95% border="0" align="center" cellpadding="0" cellSpacing=0>
          <TBODY>
            <TR> 
              <TD height="21" align=left class="head">计算公式</TD>
            </TR>
            <TR> 
              <TD height="1" background="${base}/static/images/dline.gif"></TD>
            </TR>
            <TR> 
              
              <TD><TABLE width="440" 
              cellSpacing=0 >
                  <TBODY>
                    <TR class="zhengwen"> 
                      <TD height="25" style="padding-: 2px">收入类型：</TD>
                      <TD width="333" height="25"> 
                        <SELECT id=select onchange=CHan() name=select>
                          <OPTION 
                    value=1 selected>工资、薪金所得
                          <OPTION value=2>个体工商户生产、经营所得
                          <OPTION 
                    value=3>对企事业单位的承包经营、承 租经营所得
                          <OPTION value=4>劳务报酬所得
                          <OPTION 
                    value=5>稿酬所得
                          <OPTION value=6>特许权使用所得
                          <OPTION 
                    value=7>利息、股息、红利所得
                          <OPTION value=8>财产租赁所得
                          <OPTION 
                    value=9>财产转让所得
                          <OPTION value=10>偶然所得（如：中奖、中彩）
                          <OPTION 
                    value=11>个人拍卖所得</OPTION>
                        </SELECT></TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD height="25"></TD>
                      <TD height="25"> 
                        <TABLE id=gongzi style="DISPLAY: block" cellSpacing=0 
                  width="100%">
                          <TBODY>
                            <TR> 
                              <TD>
                                <!--<INPUT name=checkbox 

onclick=gong() type=checkbox value=checkbox>外籍人员及境外

工作的中国公民-->
                              </TD>
                            </TR>
                          </TBODY>
                        </TABLE></TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD width=101 height="25" style="PADDING-TOP: 2px">收入金额：</TD>
                      <TD height="25"> 
                        <INPUT name=textfield class="inputBox" id=textfield>
                        元 </TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD height="25" colSpan=2> 
                        <TABLE class=cblue id=fei style="DISPLAY: block" cellSpacing=0 
                  cellPadding=0 width="100%" border=0>
                          <TBODY>
                            <TR> 
                              <TD width="23%" height="25" class="zhengwen">各项社会保险费： 
                              </TD>
                              <TD width="77%" class="zhengwen"><input 
                        name=textfield2 class="inputBox" id=textfield2></TD>
                            </TR>
                            <TR> 
                              <TD height="25" class="zhengwen">起征额： </TD>
                              <TD height="25" class="zhengwen"><input name=textfield3 class="inputBox" id=textfield3></TD>
                            </TR>
                          </TBODY>
                        </TABLE></TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD height="25" colSpan=2><TABLE id=fei1 
                  style="DISPLAY: none;" cellSpacing=0 
                  cellPadding=0 width="100%" border=0>
                          <TBODY>
                            <TR> 
                              <TD  width=100 height="25" class="zhengwen">财产原值：</TD>
                              <TD height="25">
<INPUT 
name=textfield22 class="inputBox" id=textfield22 value=0></TD>
                            </TR>
                            <TR> 
                              <TD width=100 height="25" align=right>
<div align="left"><span class="zhengwen">合理交易费用：</span></div></TD>
                              <TD height="25">
<INPUT 
                    name=textfield32 class="inputBox" id=textfield32 value=0></TD>
                            </TR>
                          </TBODY>
                        </TABLE> </TD>
                    </TR>

                    <TR class="zhengwen"> 
                      <TD height="25"></TD>
                      <TD height="25"> <input style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BACKGROUND-IMAGE: url(${base}/static/images/calbt.gif); BORDER-LEFT: 0px; WIDTH: 47px; CURSOR: hand; BORDER-BOTTOM: 0px; HEIGHT: 19px" onClick=validateFormInfo(this.form,1) type=button name=button></TD>
                    </TR>
                  </TBODY>
                </TABLE></TD>
            </TR>
            <TR> 
              
            <TD height="25" align=left class="head">计算结果</TD>
            </TR>
			            <TR> 
              <TD height="1" background="${base}/static/images/dline.gif"></TD>
            </TR>
            <TR> 
              <TD class=zhengwen vAlign=top height=25><TABLE 
              cellSpacing=0>
                  <TBODY>
                    <TR> 
                      <TD width=170 class="zhengwen">您应交纳的个人所得税为：</TD>
                      <TD class="zhengwen">
<INPUT name=textfield4 class="inputBox" id=textfield4 readonly>
                        元 。</TD>
                    </TR>
                  </TBODY>
                </TABLE></TD>
            </TR>
            <TR> 
          
            <TR> 
              <TD height="25" align=left class="head">说明</TD>
            </TR>
            <TR> 
              <TD height="1" background="${base}/static/images/dline.gif"></TD>
            </TR>
            <TR> 
              <TD valign="top" class="zhengwen"><P>&nbsp;</P>
                <P>&nbsp; </P>
                </TD>
            </TR>
          </TBODY>
        </TABLE>
	</td>
  </tr>
</table>
</form>
</body>
<#include "/template/foot.ftl"/>