<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/base.js" charset="gb2312"></script>
<BODY LEFTMARGIN="0" TOPMARGIN="0">
    <FORM name=forDep onsubmit="ForDep(this);return false;">
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCFF" style="border-collapse:collapse;" >
  <tr> 
    <td height="23" background="${base}/static/images/titlebg.gif"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
            
            
            <td><img src="${base}/static/images/titlearrow.gif" width="8" height="13"> <span class="title"><B>外汇储蓄计算器</B></span></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td> <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
            
            
            <td height="25" class="explain"><B>外汇储蓄计算器可以帮助您计算外汇存款的利息</B></td>
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
              
              <TD><TABLE class=cBlue style="MARGIN-LEFT: 48px" cellSpacing=0 
width=476>
                  <TBODY>
                    <TR> 
                      <TD height="179" class="zhengwen"><B>外汇储蓄计算器(仅供参考)</B><BR>
                        币　　种：
                        <SELECT onchange=ChgCat(this) 
                  name=cat style="font-size:12px;">
                          <OPTION value=USD selected>美元</OPTION>
                          <OPTION 
                    value=AUD>澳大利亚元</OPTION>
                          <OPTION value=HKD>港币</OPTION>
                          <OPTION value=CAD>加拿大元</OPTION>
                          <OPTION 
                    value=EUR>欧元</OPTION>
                          <OPTION value=JPY>日元</OPTION>
                          <OPTION 
                    value=CHF>瑞士法郎</OPTION>
                          <OPTION value=SGD>新加坡元</OPTION>
                          <OPTION value=GBP>英镑</OPTION>
                        </SELECT>
                        <BR>
                        期限种类：
                        <SELECT 
                  onchange=ChgType(this) name=type style="font-size:12px;">
                          <OPTION value=0 
                    selected>活期</OPTION>
                          <OPTION value=1>七天通知</OPTION>
                          <OPTION 
                    value=2>一个月</OPTION>
                          <OPTION value=3>三个月</OPTION>
                          <OPTION 
                    value=4>六个月</OPTION>
                          <OPTION value=5>一年</OPTION>
                          <OPTION 
                    value=6>二年</OPTION>
                        </SELECT>
                        <BR>
                        存款金额：
                        <INPUT name=a class="inputBox" size=12> <SPAN id=unit>USD</SPAN><BR> <DIV id=depTerm>存款期限
                          <INPUT name=y class="inputBox" size=4>
                          年
                          <INPUT 
                  name=m class="inputBox" size=4>
                          月
                          <INPUT name=d class="inputBox" size=4>
                          日
                        </DIV>
                        存款利率(年利率) 
                        <INPUT name=i class="inputBox" 
                  size=12>
                        % <BR>
						  利息税率
                        <INPUT name= "rateTax" class="inputBox"   size=12>
                        % <BR>
                        <BR>
                        <div>
                          <div align="center">
                            <INPUT name="submit" type=submit style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BACKGROUND-IMAGE: url(${base}/static/images/calbt.gif); BORDER-LEFT: 0px; WIDTH: 47px; CURSOR: hand; BORDER-BOTTOM: 0px; HEIGHT: 19px" value=" ">
                          </div>
                        </div>
					    <BR></TD>
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
              <TD class=zhengwen vAlign=top height=25><TABLE class=cBlue style="MARGIN-LEFT: 48px" cellSpacing=0 
width=476>
                  <TBODY>
                    <TR> 
                      <TD class="zhengwen">存款利息： 
                        <INPUT name=r1 class="inputBox" size=12 readOnly> <SPAN 
                  id=unit2>USD</SPAN> <BR>
                        利息税额：
                        <INPUT name=r2 class="inputBox" size=12 readOnly> <SPAN id=unit3>USD</SPAN> 
                        <BR>
                        实得利息：
                        <INPUT 
                  name=r3 class="inputBox" size=12 readOnly> <SPAN id=unit4>USD</SPAN> <BR>
                        本息合计：
                        <INPUT name=r4 class="inputBox" 
                  size=12 readOnly> <SPAN id=unit5>USD</SPAN> <BR></TD>
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
<SCRIPT language=javascript type=text/javascript>
<!--
var yTax,mTax,dTax;

//document.forDep.i.value = USD[0];
function ChgCat(formObj){
	GetObj('unit').innerText=formObj.value;
	GetObj('unit2').innerText=formObj.value;
	GetObj('unit3').innerText=formObj.value;
	GetObj('unit4').innerText=formObj.value;
	GetObj('unit5').innerText=formObj.value;
	ChgTax();
}
function ChgType(formObj){
	ChgTax();
	GetObj("depTerm").style.display = (formObj.value=="0")?"block":"none";
}
function ChgTax(){
	yTax = eval(GetObj('unit').innerText+'['+document.forDep.type.value+']');
	//document.forDep.i.value = yTax;
	yTax = yTax / 100;
	mTax = yTax / 12;
	dTax = yTax / 360;
}
function ForDep(formObj){
	if(!CheckElem(formObj.elements["a"], "存款金额")) return false;
	if(!CheckElem(formObj.elements["i"], "存款利率(年利率)")) return false;
	if(!CheckElem(formObj.elements["rateTax"], "利息税率")) return false;
	var a = parseFloat(formObj.elements["a"].value);
	var i = parseFloat(formObj.elements["i"].value) / 100;
	var ratetax= parseFloat(formObj.elements["rateTax"].value) / 100;
	yTax = i;
	mTax = i / 12;
	dTax = i / 360;

	if(GetObj("depTerm").style.display!="none"){

	//alert("year: " + formObj.elements["y"].value + "\nmonth: " + formObj.elements["m"].value + "\nday: " + formObj.elements["d"].value)
		if(formObj.elements["y"].value=="" && formObj.elements["m"].value=="" && formObj.elements["d"].value==""){
			alert("年、月、日至少要填写一项!");
			formObj.elements["y"].focus();
			formObj.elements["y"].select();
			return false;
		}
		if(isNaN(formObj.elements["y"].value) && formObj.elements["y"].value!=""){
			alert("年必须为数字!");
			formObj.elements["y"].focus();
			formObj.elements["y"].select();
			return false;
		}
		if(isNaN(formObj.elements["m"].value) && formObj.elements["m"].value!=""){
			alert("月必须为数字!");
			formObj.elements["m"].focus();
			formObj.elements["m"].select();
			return false;
		}
		if(isNaN(formObj.elements["d"].value) && formObj.elements["d"].value!=""){
			alert("日必须为数字!");
			formObj.elements["d"].focus();
			formObj.elements["d"].select();
			return false;
		}
		//alert(formObj.elements["y"].value+":"+isNaN(form????????????Obj.elements["y"].value))
		if(isNaN(formObj.elements["y"].value) || formObj.elements["y"].value=="") formObj.elements["y"].value = 0;
		if(isNaN(formObj.elements["m"].value) || formObj.elements["m"].value=="") formObj.elements["m"].value = 0;
		if(isNaN(formObj.elements["d"].value) || formObj.elements["d"].value=="") formObj.elements["d"].value = 0;

	var y = parseInt(formObj.elements["y"].value);
	var m = parseInt(formObj.elements["m"].value);
	var d = parseInt(formObj.elements["d"].value);
	//var tDay = y*360 + m*30 + d;
	}else{
		switch(formObj.elements["type"].value){
			case "1":
				var y = 0;
				var m = 0;
				var d = 7;
				break;
			case "2":
				var y = 0;
				var m = 1;
				var d = 0;
				break;
			case "3":
				var y = 0;
				var m = 3;
				var d = 0;
				break;
			case "4":
				var y = 0;
				var m = 6;
				var d = 0;
				break;
			case "5":
				var y = 1;
				var m = 0;
				var d = 0;
				break;
			case "6":
				var y = 2;
				var m = 0;
				var d = 0;
				break;
			default:
				var y = 0;
				var m = 0;
				var d = 0;
		}
	}
/*
<option value="0">活期</option>
<option value="1">七天通知</option>
<option value="2">一个月</option>
<option value="3">三个月</option>
<option value="4">六个月</option>
<option value="5">一年</option>
<option value="6">二年</option>
*/
var r1 = a*(y*yTax + m*mTax + d*dTax);
//var r2 = r1 * 0.2;//利息税率为0.2

var r2 = r1 * ratetax;
var r3 = r1 - r2;
var r4 = a + r3;

formObj.elements["r1"].value = Format(r1);
formObj.elements["r2"].value = Format(r2);
formObj.elements["r3"].value = Format(r3);
formObj.elements["r4"].value = Format(r4);
}

//-->
</SCRIPT>
</body>
<#include "/template/foot.ftl"/>