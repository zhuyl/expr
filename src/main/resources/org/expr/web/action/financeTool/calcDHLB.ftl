<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/calendar.js" charset="gb2312"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/CheckDataFunction.js" charset="gb2312"></script>

<SCRIPT language=JavaScript 
src="CheckDataFunction.js">
</SCRIPT>

<SCRIPT language=javascript>
function ChkCZDate(edit){
    edit.value=Trim(edit.value);
    if(edit.value=="") return true;
    if(!Cal_datevalid(edit,"1910-1-1","3000-1-1")) {
        alert('日期格式不正确,日期有效范围为1910年到3000年');
        edit.focus();
    }
    dateout();
}

function GetRate(){
	//获得年利率
	var valstartdate=Cal_strtodate($("beginDateID").value);
	var valenddate=Cal_strtodate($("endDateID").value);			
	var dayMi=24*60*60*1000;
	var months=(valenddate-valstartdate)/dayMi/30;
	var month=parseInt(months);
	if (month<0)
        return 0;
	if (month<3)
        return rate[0];
	else  
        return rate[1];
	
}

function changeobject(objectid)
{
    var ss1=$("CSCRJE").innerHTML;
    var ss2=$("DQBX").innerHTML;
    var ss3=$("TQRQ").innerHTML;
    
    if (ss1.indexOf(objectid)>0)
    {
        ls=$("lbCSCRJE").innerHTML;
        $("lbCSCRJE").innerHTML=$("lbDQBX").innerHTML;
	    $("lbDQBX").innerHTML=ls;
	    
	    $("CSCRJE").innerHTML=$("DQBX").innerHTML;
	    $("DQBX").innerHTML=ss1;
    }   
	if (ss3.indexOf(objectid)>0)    
	{
        $("TQRQ").innerHTML=$("DQBX").innerHTML;
	    $("DQBX").innerHTML=ss3;
        
        ls=$("lbTQRQ").innerHTML;
	    $("lbTQRQ").innerHTML=$("lbDQBX").innerHTML;
	    $("lbDQBX").innerHTML=ls;
    }
}
function funcontrol()
{
	if ($("rdselect_0").checked){
	    changeobject("edend");
		$("edend").value="计算得出";
		$("edend").disabled=true;
		$("edtax").value="计算得出";
		$("edtax").disabled=true;
		$("edstart").value="";
		$("edstart").disabled=false;
		$("endDateID").disabled=false;
		$("endDateID").value=datetostring(new Date());
		//this.document.all.edRate.value="0.72";
		dateout();

	}else if ($("rdselect_1").checked){
	    changeobject("edstart");
		$("edstart").value="计算得出";
		$("edstart").disabled=true;
		$("edtax").value="计算得出";				
		$("edtax").disabled=true;
		$("edend").value="";
		$("edend").disabled=false;
		$("endDateID").disabled=false;
		$("endDateID").value=datetostring(new Date());
		//this.document.all.edRate.value="0.72";
		dateout();
	}else if ($("rdselect_2").checked){
	    changeobject("endDateID");
		$("edstart").value="";
		$("edstart").disabled=false;
		$("edtax").value="计算得出";			
		$("edtax").disabled=true;
		$("edend").value="";
		$("edend").disabled=false;
		$("endDateID").value="计算得出";
		$("endDateID").disabled=true;
		dateout();
	}

}
function CheckData1(){
	if (!CheckFN3($("edstart"),"请在[初始存入金额]中输入正数",false))
	    return false;
	if (!CheckFN3($("edRate"),"请在[利率]中输入正数",false))
	    return false;
		if (!CheckFN($("edRateTax"),"请在[利息税率]中输入非负数",false))
	    return false;
	if (!CheckEmpty($("beginDateID"),"请在[初始存入日期]中输入日期格式"))
	    return false;
	if (!CheckEmpty($("endDateID"),"请在[提取日期]中输入日期格式"))
	    return false;
	if(!CheckDiffDate($("beginDateID"),$("endDateID"),"初始存入日期应该小于等于提取日期！"))
		return false;
	
	return true;	
}
function CheckData2(){
	if (!CheckFN($("edend"),"请在[到期本息总额]中输入正数",null,2))
	    return false;
	if (!CheckFN3($("edRate"),"请在[利率]中输入正数",false))
	    return false;
			if (!CheckFN($("edRateTax"),"请在[利息税率]中输入非负数",false))
	    return false;
	if (!CheckEmpty($("beginDateID"),"请在[初始存入日期]中输入日期格式"))
	    return false;
	if (!CheckEmpty($("endDateID"),"请在[提取日期]中输入日期格式"))
	    return false;
	if(!CheckDiffDate($("beginDateID"),$("endDateID"),"初始存入日期应该小于等于提取日期！"))
	    return false;
	
	return true;
}
function CheckData3(){
	if (!CheckFN3($("edstart"),"请在[初始存入金额]中输入正数",false))
	return false;
		if (!CheckFN($("edRateTax"),"请在[利息税率]中输入非负数",false))
	    return false;
	if (!CheckFN3($("edend"),"请在[到期本息总额]中输入正数",false))
	return false;
	if (!CheckFN3($("edRate"),"请在[利率]中输入正数",false))
	return false;
	if (!CheckEmpty($("beginDateID"),"请在[初始存入日期]中输入日期格式"))
	return false;
	if (parseFloat($("edstart").value) > parseFloat($("edend").value))
	{
		DispMessage($("edstart"), "初始存入金额应小于等于到期本息总额");
		return false;
	}
	return true;
}
function checkCalc(){
	if ($("rdselect_0").checked){
		if (!CheckData1()) return false;
		calc1();
	}else if ($("rdselect_1").checked){
		if (!CheckData2()) return false;
		calc2();
	}else if ($("rdselect_2").checked){
	   if (!CheckData3()) return false;	
	   calc3();
	}
	
    return true;
}

function dateout(){
	//$("edRate").value=GetRate();
}
</SCRIPT>


<BODY LEFTMARGIN="0" TOPMARGIN="0">
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCFF" style="border-collapse:collapse;" >
  <tr> 
    <td height="23" background="${base}/static/images/titlebg.gif"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td><img src="${base}/static/images/titlearrow.gif" width="8" height="13"> <span class="title"><B>定活两便计算器</B></span></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td> <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="25" class="explain">定活两便计算器可以帮您计算定活两便的数额</td>
        </tr>
      </table>
      <TABLE width=95% align="center" cellSpacing=0>
        <TBODY>
          <TR> 
            <TD height="25" align=left class="head">计算公式</TD>
          </TR>
          <TR> 
            <TD height="1" background="${base}/static/images/dline.gif"></TD>
          </TR>
          <TR> 
            <TD><TABLE cellSpacing=0 
            cellPadding=0 width=568 border=0>
                  <TBODY>
                    <TR> 
                      <TD width="110" height="25" class="zhengwen" >计算项目:</TD>
                      <TD width="406" height="25" ><LABEL> <span class="zhengwen"> 
                        <INPUT id=rdselect_0 onclick=funcontrol() 
type=radio CHECKED value=1 name=rdselect>
                        到期本息总额</span></LABEL> <span class="zhengwen"> 
                        <LABEL> 
                        <INPUT 
id=rdselect_1 onclick=funcontrol() type=radio value=2 
name=rdselect>
                        初始存入金额</LABEL>
                        <LABEL> 
                        <INPUT id=rdselect_2 onclick=funcontrol() 
type=radio value=3 name=rdselect>
                        提取日期</LABEL>
                        <LABEL></LABEL>
                        </span> <LABEL></LABEL></TD>
                    </TR>
                    <TR> 
                      <TD height="25" class="zhengwen" id="lbCSCRJE">初始存入日期:</TD>
                      <TD height="25" id="CSCRJE"> <input class=text id=beginDateID 
                  onBlur=ChkCZDate(beginDateID); style="WIDTH: 80px" 
                  value=2001-1-1 name=beginDateID> <IMG 
                  src="${base}/static/images/calbtn.gif" width="18" height="18" 
              align=absMiddle style="CURSOR: hand" 
                  onclick=MyCalendar.SetDate(this,$('beginDateID'))></TD>
                    </TR>
                    <TR>
                      <TD height="25" class="zhengwen" id="lbTQRQ">提取日期:</TD>
                      <TD height="25" class="zhengwen" id="TQRQ"><INPUT class=text id=endDateID onblur=ChkCZDate(this) 
style="WIDTH: 80px" value=2001-1-1 name=endDateID>
                        <IMG src="${base}/static/images/calbtn.gif" width="18" height="18" align=absMiddle style="CURSOR: pointer" 
onclick="MyCalendar.SetDate(this,$('endDateID'))"></TD>
                    </TR>
                    <TR> 
                      <TD height="25" class="zhengwen" >年利率(%):</TD>
                      <TD height="25" class="zhengwen"><INPUT class=inputBox id=edRate  name=edRate style="width:80px"></TD>
                    </TR>
                    <TR> 
                      <TD height="25" class="zhengwen" id=LabQcMq>利息税率(%):</TD>
                      <TD height="25"><INPUT class=inputBox id=edRateTax style="WIDTH: 80px" 
                  name=edRateTax></TD>
                    </TR>
                    <TR> 
                      <TD height="25" id=LabQcMq> <DIV class="zhengwen">初期存入金额:</DIV></TD>
                      <TD height="25"><INPUT class=inputBox id=edstart name=edstart style="WIDTH: 80px" > <span class="zhengwen">&nbsp;元</span></TD>
                    </TR>
                    <TR> 
                      <TD height=25>&nbsp; </TD>
                      <TD height=25><img id=btnExecute
                  style="CURSOR: hand" onClick="checkCalc();" tabindex=7 
                  height=19 src="${base}/static/images/calbt.gif" 
                  width=47 name=btnExecute type="submit"></TD>
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
            <TD ><TABLE width="360" border=0>
                  <TBODY>
                    <TR> 
                      <TD width="173" height="25" noWrap class="zhengwen">扣除利息税金额(元): 
                      </TD>
                      <TD width="177" height="25"> <INPUT class=inputBox id=edtax 
style="WIDTH: 100px; " disabled value=计算得出 name=edtax></TD>
                    </TR>
                    <TR> 
                      <TD height="25" noWrap class="zhengwen" id="lbDQBX">到期本息总额(元):</TD>
                      <TD height="25" id="DQBX"><INPUT class=inputBox id=edend 
style="WIDTH: 100px; " disabled value=计算得出 
name=edend></TD>
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
              <TD valign="top" class="zhengwen">定活两便存款的优点在于兼顾了资金运用的收益性和灵活性。本计算器可方便的计算出定活两便存款的到期本息总额（已扣除利息税）、初始存入金额和储蓄存期。</TD>
          </TR>
        </TBODY>
      </TABLE></td>
  </tr>
</table>

<SCRIPT language=javascript>
//var rate = new Array(1.998,2.268);
$("beginDateID").value=datetostring(new Date());
$("endDateID").value=datetostring(new Date());
funcontrol();
</SCRIPT>
<script language="javascript">

function calc1(){
    var valstart;
	var valrate;
	var valstartdate;
	var valenddate;
	var valresult;
	var valtax;
	var dayMi=24*60*60*1000;
	var months;
var InterestTax = new Number( $("edRateTax").value / 100 );//利息税
	valstart=parseFloat($("edstart").value);

	valstartdate=StrToDate($("beginDateID").value);
	valenddate=StrToDate($("endDateID").value);				
	valrate=parseFloat($("edRate").value)/100;
	//到期本息总额＝初始存入金额×（年利率/360）×（提取日期－初始存入日期）×InterestTax + 初始存入金额
	
	valmonths=getDiffDay(valenddate,valstartdate);
	valresult= valstart * (valrate/360) * valmonths * (1-InterestTax) + valstart;
	valtax= valstart * (valrate/360) * valmonths * InterestTax;

    $("edend").value=Round(valresult);
    $("edtax").value=Round(valtax);
}
function calc2(){
	var valstart;
	var valrate;
	var valstartdate;
	var valenddate;
	var valresult;
	var valtax;
	var dayMi=24*60*60*1000;
	var valmonths;
	var InterestTax = new Number( $("edRateTax").value / 100 );//利息税
	valstartdate=StrToDate($("beginDateID").value);
	valenddate=StrToDate($("endDateID").value);				
	valrate=parseFloat($("edRate").value)/100;
	valresult=parseFloat($("edend").value);		
			
	//初始存入金额=到期本息总额/ (1+（年利率/360）×（提取日期－初始存入日期）×InterestTax)
	valmonths=getDiffDay(valenddate,valstartdate);
	valstart=valresult /( valrate/360*valmonths*(1-InterestTax)+1);
	valtax=(valresult-valstart)/4;
    $("edstart").value=Round(valstart);
    $("edtax").value=Round(valtax);
}
function calc3(){
	var valstart;
	var valrate;
	var valstartdate;
	var valenddate;
	var valresult;
	var valtax;
	var dayMi=24*60*60*1000;
	var valday;
var InterestTax = new Number( $("edRateTax").value / 100 );//利息税
	valstart=parseFloat($("edstart").value);
	valstartdate=StrToDate($("beginDateID").value);
			
	valrate=parseFloat($("edRate").value)/100;
	valresult=parseFloat($("edend").value);		
	
	//提取日期=开始日期+(到期本息总额-初始存入金额)/初始存入金额*360/InterestTax/年利率
	valday=(valresult-valstart)*360/valstart/(1-InterestTax)/valrate;

    valday=Math.ceil(valday);
	addday(valstartdate,valday);
	valtax=(valresult-valstart)/4;
	$("endDateID").value=datetostring(valstartdate) ;
	
	$("edtax").value=Round(valtax);
}
</script>
</body>
<#include "/template/foot.ftl"/>