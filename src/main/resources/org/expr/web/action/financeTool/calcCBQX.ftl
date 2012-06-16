<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/calendar.js" charset="gb2312"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/CheckDataFunction.js" charset="gb2312"></script>

<SCRIPT language=javascript>
function ChkCZDate(edit){
    edit.value=Trim(edit.value);
    if(edit.value=='') return true;
    if(!Cal_datevalid(edit,'1910-1-1','3000-1-1')) {
        alert('日期格式不正确,日期有效范围为1910年到3000年');
        edit.focus();
    }
}

function checkCalc(){
    if (!CheckEmpty($("beginDateID"),"无效的初始存入日期"))
	    return false;
    if ( Cal_strtodate($("beginDateID").value)< Cal_strtodate("1999-11-1")){
	    DispMessage($("beginDateID"),"初始存入日期不得小于1999年11月1日");
	    return false;
    }											
    if ($("CalcType_0").checked==true)
	    if (!CheckFN3($("edInitSaveSum"),"初始存入金额请输入正数",false))
		    return false;	
    if (!CheckFN3($("edFullRate"),"年利率请输入正数",false))				 
		    return false;
	  if (!CheckFN($("edRateTax"),"利息税率请输入非负数",false))				 
		    return false;					
    if ($("CalcType_1").checked==true)
	    if (!CheckFN3($("edCapitalSum"),"每次支取利息金额请输入正数",false))
		    return false;		
    if ($("CalcType_0").checked==true) compute(0);
    else compute(1);
}

function changeobject(objectid)
{
    var ss1=$("CSCR").innerHTML;
    var ss2=$("MCZQ").innerHTML;

    if (ss1.indexOf(objectid)>0)
    {
        ls=$("lbCSCR").innerHTML;
        $("lbCSCR").innerHTML=$("lbMCZQ").innerHTML;
	    $("lbMCZQ").innerHTML=ls;
    	
	    $("CSCR").innerHTML=$("MCZQ").innerHTML;
	    $("MCZQ").innerHTML=ss1;
    }   
}

function calctypechange()
{
    $("edCapitalSum").value="";
    $("edCapitalSum").disabled=false;
    $("edInitSaveSum").value="";
    $("edInitSaveSum").disabled=false;
    Cleartxt();
    if ($("CalcType_0").checked==true)
    {
        changeobject("edCapitalSum");
	    $("edInitSaveSum").value = "";
	    $("edCapitalSum").value="计算得出";
	    $("edCapitalSum").disabled=true;
    }
    else if ($("CalcType_1").checked==true)
    {
        changeobject("edInitSaveSum");
	    $("edCapitalSum").value = "";
	    $("edInitSaveSum").value="计算得出";
	    $("edInitSaveSum").disabled=true;
    }

}

function loadinit()
{
    calctypechange();		
    //getrate();
    $("edFullSum").disabled=true;
    $("edTaxSum").disabled=true;
} 

function compute(type)
{
    var initsavesum,term,capitalsum,taxsum;
    term=parseInt($("SaveTerm").value)/12; //年为单位

    if (type==0) //计算每次支取利息金额
    {
        initsavesum=$("edInitSaveSum").value;
        capitalsum=CalcGetAcc();
        $("edCapitalSum").value=Round(capitalsum);
    }
    else if (type==1) //计算初始存入金额
    {
        initsavesum=CalcSaveCap();
        capitalsum=$("edCapitalSum").value;
        $("edInitSaveSum").value=Round(initsavesum);
    }
    taxsum=CalcTaxofRate(initsavesum,term);
    $("edTaxSum").value=Round(taxsum);
    $("edFullSum").value=Round(parseFloat(initsavesum)+parseFloat(capitalsum*term)-taxsum);
    
}
function Cleartxt()
{
    $("edFullSum").value = "计算得出";
    $("edTaxSum").value = "计算得出";
}
//获得利率
function getrate()
{
    $("edFullRate").value=rate[$("SaveTerm").selectedIndex];
}


</SCRIPT>



<BODY LEFTMARGIN="0" TOPMARGIN="0">
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCFF" style="border-collapse:collapse;" >
  <tr> 
    <td height="23" background="${base}/static/images/titlebg.gif"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td><img src="${base}/static/images/titlearrow.gif" width="8" height="13"> <span class="title"><B>存本取息计算器</B></span></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td> <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="25" class="explain">存本取息计算器可以帮您计算存本取息的数额</td>
        </tr>
      </table>
    <FORM style="MARGIN-TOP: 0px" name=DepositCalculator>
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
                        <INPUT id=CalcType_0 onclick=calctypechange(); type=radio CHECKED name=CalcType>
                        每次支取利息金额</span></LABEL> <span class="zhengwen"> 
                        <LABEL> 
                        <INPUT id=CalcType_1 onclick=calctypechange(); type=radio name=CalcType>
                        初始存入金额 </LABEL>
                        </span> <LABEL></LABEL></TD>
                    </TR>
                    <TR> 
                      <TD height="25" vAlign=center class="zhengwen">储蓄存期:</TD>
                      <TD height="25" ><SELECT id=SaveTerm onchange=getrate() name=SaveTerm stype="font-size:12px;">
                          <OPTION value=12 selected>一年</OPTION>
                          <OPTION value=36>三年</OPTION>
                          <OPTION value=60>五年</OPTION>
                        </SELECT></TD>
                    </TR>
                    <TR> 
                      <TD height="25" class="zhengwen">初始存入日期:</TD>
                      <TD height="25" > <input class=text id=beginDateID 
                  onBlur=ChkCZDate(beginDateID); style="WIDTH: 80px" 
                  value=2001-1-1 name=beginDateID> <IMG 
                  src="${base}/static/images/calbtn.gif" width="18" height="18" 
              align=absMiddle style="CURSOR: hand" 
                  onclick=MyCalendar.SetDate(this,$('beginDateID'))></TD>
                    </TR>
                    <TR> 
                      <TD height="25" class="zhengwen" >年利率(%):</TD>
                      <TD height="25" class="zhengwen"><INPUT class=inputBox id=edFullRate style="WIDTH: 80px" 
name=edFullRate></TD>
                    </TR>
                    <TR> 
                      <TD height="25" class="zhengwen" >利息税率(%):</TD>
                      <TD height="25"><INPUT class=inputBox id=edRateTax style="WIDTH: 80px" 
                  name=edRateTax></TD>
                    </TR>
                    <TR> 
                      <TD height="25" id="lbCSCR"> <DIV class="zhengwen">初期存入金额:</DIV></TD>
                      <TD height="25" id="CSCR"> <INPUT class=inputBox id=edInitSaveSum 
style="WIDTH: 80px; " name=edInitSaveSum> <span class="zhengwen">&nbsp;元</span></TD>
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
                      <TD width="173" height=25 class="zhengwen" id="lbMCZQ">每次支取利息金额(元):</TD>
                      <TD width="177" height="25" id="MCZQ"> <INPUT class=inputBox id=edCapitalSum 
style="WIDTH: 100px;" value=计算得出  disabled
name=edCapitalSum></TD>
                    </TR>
                    <TR> 
                      <TD height=25 noWrap class="zhengwen">到期支取本息金额(元):</TD>
                      <TD height="25">
<INPUT class=inputBox id=edFullSum 
style="WIDTH: 100px;" value=计算得出 disabled name=edFullSum>  </TD>
                    </TR>
					  <TR> 
                      <TD height="25" noWrap class="zhengwen">扣除利息税金额(元): </TD>
                      <TD height="25">
<INPUT class=inputBox id=edTaxSum 
style="WIDTH: 100px;" value=计算得出 disabled name=edTaxSum> </TD>
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
              <TD valign="top" class="zhengwen">通过本计算器可以对每次支取利息金额和初始存入金额进行计算。其中到期本息金额为本金与最后一次支取利息金额之和（已扣除利息税）。</TD>
          </TR>
        </TBODY>
      </TABLE></form></td>
  </tr>
</table>

<script language="javascript">
$("beginDateID").value=datetostring(new Date());


//计算每次支取利息金额
function CalcGetAcc(){
	var initsavesum=parseInt($("edInitSaveSum").value);
	var capitalsum=initsavesum*($("edFullRate").value/100)/12;
	return capitalsum;
}

//计算初始存入金额
function CalcSaveCap(){
	var capitalsum=parseFloat($("edCapitalSum").value);
	var initsavesum=(capitalsum*12)/($("edFullRate").value/100);
	return initsavesum;
}

//计算利息税
function CalcTaxofRate(fInitsavesum,fTerm){
    var InterestTax =new Number($("edRateTax").value / 100 );
	var taxsum=fInitsavesum*fTerm*($("edFullRate").value/100)*InterestTax;
	return taxsum;
}

</script>
</body>
<#include "/template/foot.ftl"/>