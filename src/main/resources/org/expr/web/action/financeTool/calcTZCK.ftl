<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/calendar.js" charset="gb2312"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/CheckDataFunction1.js" charset="gb2312"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/calendar1.js" charset="gb2312"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/calc/CalcTZCK.js" charset="gb2312"></script>

<BODY LEFTMARGIN="0" TOPMARGIN="0">
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCFF" style="border-collapse:collapse;" >
  <tr> 
    <td height="23" background="${base}/static/images/titlebg.gif"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td><img src="${base}/static/images/titlearrow.gif" width="8" height="13"> <span class="title"><strong>通知存款计算器</strong></span> 
          </td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td> <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="25"><span class="explain"><B>通知存款计算器可以帮您计算通知存款的本息额</B> </span></td>
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
            <TD><TABLE width="300" border=0 align="left" cellpadding="0" cellspacing="0" >
                <TR> 
                  <TD height=25 noWrap class="zhengwen">计算项目:</TD>
                  <TD height="25" class="zhengwen"><FONT face=宋体>实得本息总额 </FONT></TD>
                </TR>
                <TR> 
                  <TD height=25 noWrap class="zhengwen">储蓄类型:</TD>
                  <TD height="25"><FONT face=宋体> 
                    <SELECT id=SaveType style="WIDTH: 120px;font-size:12px;" 
                  tabIndex=2 name='SaveType'>
                      <OPTION value=1 
                    selected>一天通知存款</OPTION>
                      <OPTION 
                  value=7>七天通知存款</OPTION>
                    </SELECT>
                    </FONT></TD>
                </TR>
                <TR> 
                  <TD height=25 noWrap class="zhengwen">初始存入日期:</TD>
                  <TD height="25"> <INPUT name=beginDateID class="text"  id=beginDate style="WIDTH: 95px" tabIndex=3 
                  onblur=ChkCZDate(beginDateID); 
                  value=2007-1-1> <IMG src="${base}/static/images/calbtn.gif" width="18" height="18" align="absMiddle" style="CURSOR:pointer;" onclick="MyCalendar.SetDate(this,$('beginDateID'))"></TD>
                </TR>
                <TR> 
                  <TD height=25 noWrap class="zhengwen">存入金额(元):</TD>
                  <TD height="25" id=tddrawsum> <INPUT name=edInitSaveSum class="inputBox" id=edInitSaveSum style="WIDTH: 120px" 
                  tabIndex=4></TD>
                </TR>
                <TR> 
                  <TD height=25 class="zhengwen" id=lbdrawdate>提取日期:</TD>
                  <TD height="25" id=tddrawdate> <INPUT name=drawDate class="text"  id=drawDateID style="WIDTH: 95px" tabIndex=5 
                  onblur=ChkCZDate(drawDateID); 
                  value=2007-1-2> <IMG src="${base}/static/images/calbtn.gif" width="18" height="18" align="absMiddle" id="ddimg" style="CURSOR:pointer;" onclick="MyCalendar.SetDate(this,$('drawDateID'))">
<SCRIPT language=javascript>
//判断用户选择日期是否在合理范围内
function ChkCZDate(edit) 
{
	edit.value=Trim(edit.value);
	if(edit.value=='') return true;
	if(!Cal_datevalid(edit,'1910-1-1','3000-1-1')) 
	{
		alert('日期格式不正确,日期有效范围为1910年到3000年'); 
		edit.focus();
	} 
}
</SCRIPT> </TD>
                </TR>
                <TR> 
                  <TD height=25 noWrap class="zhengwen">年利率(%):</TD>
                  <TD height="25"> <INPUT 
                  name=edFullRate class="inputBox" id=edFullRate style="WIDTH: 120px" tabIndex=6> 
                  </TD>
                </TR>
				                <TR> 
                    <TD height=25 noWrap class="zhengwen">利息税率(%):</TD>
                  <TD height="25"> <INPUT 
                  name=edRateTax class="inputBox" id=edRateTax style="WIDTH: 120px" tabIndex=6> 
                  </TD>
                </TR>
                <TR> 
                  <TD noWrap height=25></TD>
                  <TD height="25"><img id=btnCalc onClick="return calResult()" height=19 
                  src="${base}/static/images/calbt.gif" 
              width=47></TD>
                </TR>
              </TABLE></TD>
          </TR>
          <TR> 
            <TD height="25" align=left class="head">计算结果</TD>
          </TR>
          <TR> 
            <TD height="1" background="${base}/static/images/dline.gif"></TD>
          </TR>
          <TR> 
            <TD ><TABLE class=cBlue id=Table2 cellSpacing=0 cellPadding=0 width=300 
            align=left border=0>
                <TBODY>
                  <TR> 
                    <TD height="25" noWrap class="zhengwen">应得本息总额(元):</TD>
                    <TD height="25" id=tdfullsum> <INPUT name=edFullSum class="inputBox" id=edFullSum style="WIDTH: 120px" 
                  tabIndex=7 disabled value=计算得出> </TD>
                  </TR>
                  <TR> 
                    <TD height=25 noWrap class="zhengwen">扣除利息金额(元):</TD>
                    <TD height="25"> <INPUT name=edTaxSum class="inputBox" id=edTaxSum style="WIDTH: 120px" tabIndex=8 
                  disabled value=计算得出> </TD>
                  </TR>
                  <TR> 
                    <TD height=25 noWrap class="zhengwen">实得本息总额(元):</TD>
                    <TD height="25"> <INPUT name=actualIncome class="inputBox" id=actualIncome style="WIDTH: 120px" tabIndex=8 
                  disabled value=计算得出> </TD>
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
              <TD valign="top" class="zhengwen">&nbsp;</TD>
          </TR>
        </TBODY>
      </TABLE></form>
      </td>
  </tr>
</table>

<SCRIPT language="javascript">
	/*************************************判断部分**************************************/
function calResult()
{
	if (!CheckEmpty(CompPartSumCalc.edInitSaveSum,"提取金额不能为空"))
	return false;	
	if (!CheckEmpty(CompPartSumCalc.edFullRate,"年利率不能为空"))
	return false;
	if (!CheckEmpty(CompPartSumCalc.edRateTax,"利息税率不能为空"))
	return false;
	if (!CheckFN3(CompPartSumCalc.edInitSaveSum,"提取金额请输入正数",false))
	return false;				
	if (!CheckFN3(CompPartSumCalc.edFullRate,"年利率请输入正数",false))				 
	return false;			
	if (!CheckFN(CompPartSumCalc.edRateTax,"利息税率请输入非负数",false))				 
	return false;		
	if (!CheckEmpty(CompPartSumCalc.beginDate,"无效的初始存入日期"))
	return false;	
	if (!CheckEmpty(CompPartSumCalc.drawDate,"无效的提取日期"))
	return false;	
	if ( Cal_strtodate(CompPartSumCalc.drawDateID.value)< Cal_strtodate("1999-11-1"))
	{
		DispMessage(CompPartSumCalc.drawDateID,"提取日期不得小于1999年11月1日");
		return false;
	}	
	var SaveDate=new Date();
	SaveDate.setTime(Cal_strtodate(CompPartSumCalc.beginDateID.value));								
	var AdvDrawDate=new Date();
	AdvDrawDate.setTime(Cal_strtodate(CompPartSumCalc.drawDateID.value));									
	var days=CompPartSumCalc.SaveType.selectedIndex==0 ? 1:7;
	addday(SaveDate,days);
	if (AdvDrawDate<SaveDate)
	{ 
		DispMessage(CompPartSumCalc.drawDateID,"提取日期不得小于初始存入日期+"+days+"天");
		return false;
	}		

	if ( Cal_strtodate(CompPartSumCalc.beginDateID.value)< Cal_strtodate("1998-7-1"))
	{
		DispMessage(CompPartSumCalc.beginDateID,"初始存入日期不得小于1998年7月1日");
		return false;
	}
	/*********************计算部分*******************/
	//var interestRates = 0.05;//利息税率
	var interestRates = new Number( document.getElementById("edRateTax").value / 100 );//利息税率
	var savetype = document.getElementById("SaveType").value;//储蓄类型
	var beginDate = document.getElementById("beginDate").value;//存入日期
	var endDate = document.getElementById("drawDateID").value;//支出日期
	var moneynum = new Number( document.getElementById("edInitSaveSum").value );//提取金额
	var rate = new Number( document.getElementById("edFullRate").value / 100 );//年利率
	var days=( Cal_strtodate(endDate)-Cal_strtodate(beginDate) )/86400000;
	var interest = moneynum* (Math.pow( (1+rate/360)  , days) -1);//应得利息
	var realInterest = interest * (1 - interestRates );//实得利息
	var result1 = moneynum + realInterest;//实得本息总额
	var result2 = interest * interestRates;//扣除利息税
	var result3 = moneynum + interest;//应得本息总额
	document.getElementById("edFullSum").value=result3.toFixed(2);
	document.getElementById("edTaxSum").value=result2.toFixed(2);
	document.getElementById("actualIncome").value=result1.toFixed(2);

}

</SCRIPT>
<script language="javascript">
$("beginDateID").value=datetostring(new Date());
$("drawDateID").value=datetostring(new Date());
</script>
<#include "/template/foot.ftl"/>