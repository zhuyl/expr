<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/calendar.js" charset="gb2312"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/CheckDataFunction1.js" charset="gb2312"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/calendar1.js" charset="gb2312"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/Components.js" charset="gb2312"></script>


<BODY LEFTMARGIN="0" TOPMARGIN="0">
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCFF" style="border-collapse:collapse;" >
  <tr> 
    <td height="23" background="${base}/static/images/titlebg.gif"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td><img src="${base}/static/images/titlearrow.gif" width="8" height="13"> <span class="title"><B>活期储蓄计算器</B></span></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td> <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="25"><span class="explain"><B>活期储蓄计算器可以帮您计算活期储蓄的本息额</B> </span></td>
        </tr>
      </table>
	    <FORM id=CompPartSumCalc name=CompPartSumCalc>
      <TABLE width=95% align="center" cellSpacing=0>
        <TBODY>
          <TR> 
            <TD height="25" align=left class="head">计算公式</TD>
          </TR>
          <TR> 
            <TD height="1" background="${base}/static/images/dline.gif"></TD>
          </TR>
          <TR> 
            <TD><TABLE border=0>
                  <TBODY>
                    <TR> 
                      <TD width="90" height=30 noWrap class="zhengwen">计算项目:</TD>
                      <TD width="145" height=24 colSpan=2><span class="zhengwen">实得本息总额</span></FONT> </TD>
                    </TR>
                    <TR> 
                      <TD height=25 align=left class="zhengwen">存入日期:</FONT></TD>
                      <TD height=25> <INPUT class="tex"t id=beginDateID 
                  onblur=ChkCZDate(beginDateID) style="WIDTH: 85px" 
                  name=beginDate>
                        <IMG src="${base}/static/images/calbtn.gif" width="18" height="18" align="absMiddle" style="CURSOR:pointer;" onclick="MyCalendar.SetDate(this,$('beginDateID'))"> 
                        <FONT face=宋体>&nbsp; </FONT></TD>
                    </TR>
                    <TR> 
                      <TD height=24 align=left class="zhengwen">存入金额(元):</TD>
                      <TD height=24 align=left><font face=宋体> 
                        <input class=inputBox 
                  id=edSaveSum style="WIDTH: 80px" name=edSaveSum>
                        </font></TD>
                    </TR>
                    <TR>
                      <TD class=zhengwen id=lbTQRQ align=left width=57 
                  height=25>提取日期:</FONT></TD>
                <TD id=TQRQ width=160 height=25><INPUT class="text" id=endDateID 
                  onblur=ChkCZDate(endDateID) style="WIDTH: 85px" 
                  name=endDateID>
                        <IMG src="${base}/static/images/calbtn.gif" width="18" height="18" align="absMiddle" style="CURSOR:pointer;" onclick="MyCalendar.SetDate(this,$('endDateID'))"></TD>
                    </TR>
                    <TR> 
                      <TD height=24 align=left class="zhengwen">年利率(%):</FONT></TD>
                      <TD height=24 align=left> <INPUT class=inputBox id=edFullRate 
                  style="WIDTH: 80px" name=edFullRate></TD>
                    </TR>
                    <TR> 
                      <TD height=24 align=left class="zhengwen">利息税率(%):</TD>
                      <TD height=24 align=left><INPUT class=inputBox id=edRateTax 
                  style="WIDTH: 80px" name=edRateTax></TD>
                    </TR>
                    <TR> 
                      <TD height=24 align=left class="zhengwen">&nbsp;</TD>
                      <TD height=24 align=left>
                      <img id=btnCalc  height=19 src="${base}/static/images/calbt.gif"  width=47></TD>
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
            <TD ><TABLE id=Table2 cellSpacing=0 cellPadding=0 width=376 
            align=left border=0>
                  <TBODY>
				       <TR> 
                    <TD height="25" noWrap class="zhengwen">应得本息总额(元):</TD>
                    <TD height="25" id=tdfullsum> <INPUT name=edSum class="inputBox" id=edSum style="WIDTH: 100px" 
                  tabIndex=7 disabled value=计算得出> </TD>
                  </TR>
                    <TR> 
                      <TD height=25 class="zhengwen">扣除利息税金额(元):</TD>
                      <TD><FONT face=宋体>
                        <INPUT class=inputBox id=edTaxSum 
                  style="WIDTH: 100px" disabled value=计算得出 name=edTaxSum>
                        </FONT></TD>
                    </TR>
					 <TR> 
                      <TD width=176 height=25 class="zhengwen" id=lbSDBX>实得本息总额(元):</TD>
                      <TD id=SDBX width=343><INPUT class=inputBox id=edFullSum 
                  style="WIDTH: 100px" disabled value=计算得出 name=edFullSum></TD>
                    </TR>
                  </TBODY>
                </TABLE></TD>
          </TR>
          <TR> 
            <TD height="25" align=left class="head">说明</TD>
          </TR>
          <TR> 
            <TD height="1" background="${base}/static/images/dline.gif"></TD>
          </TR>
          <TR> 
              <TD valign="top" class="zhengwen">活期储蓄是客户家庭持有现金的一种常用方式。通过本计算器，可以计算出活期储蓄的实得本息总额（已扣除利息税）和提取日期。</TD>
          </TR>
        </TBODY>
      </TABLE></form></td>
  </tr>
</table>
<SCRIPT language=javascript>
$("beginDateID").value=datetostring(new Date());
$("endDateID").value=datetostring(new Date());
</SCRIPT>
<SCRIPT language=javascript>

function ChkCZDate(edit)
{
	edit.value=Trim(edit.value);
	if(edit.value=='') return true;
	if(!Cal_datevalid(edit,'1910-1-1','3000-1-1')) 
	{
		alert('日期格式不正确,日期有效范围为1910年到3000年');
		return false;
		edit.focus();
	}
	return true;
}
//活期储蓄计算器
function computefullsum(oDocument) //计算出实得本息总额和存入总额
{
	var tmparray=new Array();
	tmparray.push(oDocument.all.edSaveSum.value);
	tmparray.push(oDocument.all.beginDateID.value);
	tmparray.push(oDocument.all.endDateID.value);
	tmparray.push(oDocument.all.edFullRate.value);
	var obj=computeoncefullsum(tmparray);
	oDocument.all.edFullSum.value=Round(obj.oncefullsum);
	oDocument.all.edTaxSum.value=Round(obj.oncesavesum);
	oDocument.all.edSum.value=Round(obj.oncesum);
}
function computeoncefullsum(s) //计算出一次实得本息和存入金额
{
		SaveInSum=parseInt(s[0]);
		var SaveDate=new Date();
		SaveDate.setTime(Cal_strtodate(s[1]));	
		var AdvDrawDate=new Date();
		AdvDrawDate.setTime(Cal_strtodate(s[2]));
		YearRate=parseFloat(s[3])/100;
		var diffday=getDiffDay(AdvDrawDate,SaveDate);
		var obj=new Object();

		//var interestRate = 0;//利息税率
		   var interestRate = new Number( document.getElementById("edRateTax").value / 100 );//利息税率
		obj.oncefullsum=SaveInSum *(  YearRate/360 * diffday) *(1-interestRate) + SaveInSum;
		obj.oncesavesum=SaveInSum *(  YearRate/360 * diffday) * interestRate;
		obj.oncesum=SaveInSum *(  YearRate/360 * diffday) *(1) + SaveInSum;
		return obj;
}

</SCRIPT>

<SCRIPT language=javascript event=onclick for=btnCalc>

	if (!CheckEmpty(beginDateID,"无效的初始存入日期")) return false;	
	if ( Cal_strtodate(beginDateID.value)< Cal_strtodate("1999-11-1") )  
	{
		DispMessage(beginDateID,"初始存入日期不得小于1999年11月1日");
		return false;
	}									
	if (!CheckFN3(edSaveSum,"存人金额请输入正数",false))				 
	return false;			
	if ( Cal_strtodate(endDateID.value)<=Cal_strtodate(beginDateID.value))
	{
		DispMessage(endDateID,"你存入的初始存入日期大于或等于提取日期,请修改");
		return false;
	}	
	if (!CheckEmpty(endDateID,"无效的提取日期"))
	return false;	
	if (!CheckFN3(edFullRate,"年利率请输入正数",false))				 
	return false;			
	if (!CheckFN(edRateTax,"利息税率请输入非负数",false))				 
	return false;	
	//beginDateID.select();
	//beginDateID.focus();
	computefullsum(document);										
</SCRIPT>
</body>
<#include "/template/foot.ftl"/>