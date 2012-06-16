<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/calendar.js" charset="gb2312"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/CheckDataFunction.js" charset="gb2312"></script>

<SCRIPT language=javascript>
function ChkCZDate(edit){
    edit.value=Trim(edit.value);
    if(edit.value=="") return true;
    if(!Cal_datevalid(edit,"1910-1-1","3000-1-1")) {
        alert('日期格式不正确,日期有效范围为1910年到3000年');
        edit.focus();
    }
 }

function checkCalc(){ 
	if(!CheckEmpty($("beginDateID"),"初始存入日期格式不正确"))
		return false;
	if (!CheckFN3($("edRate"),"请在年利率输入正数",false))
		return false;
	if (!CheckFN3($("edBalance"),"请在月存入金额输入正数", false))
		return false;
	if($("cbType").value=="12")
		if(!CheckFloatRange($("edBalance"),50,1666,"最低起存金额为50元；一年期每月存款不能高于1666元！"))
			return false;
	if($("cbType").value=="36")
		if(!CheckFloatRange($("edBalance"),50,555,"最低起存金额为50元；三年期每月存款不能高于555元！"))
			return false;
	if($("cbType").value=="72")
		if(!CheckFloatRange($("edBalance"),50,277,"最低起存金额为50元；六年期每月存款不能高于277元！"))
			return false;
    EduCalc1();
	return true;
}

function getrate(){
    $("edRate").value=rate[$("cbType").selectedIndex];
}

</SCRIPT>


<BODY LEFTMARGIN="0" TOPMARGIN="0">
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCFF" style="border-collapse:collapse;" >
  <tr> 
    <td height="23" background="${base}/static/images/titlebg.gif"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td><img src="${base}/static/images/titlearrow.gif" width="8" height="13"> <span class="title"><B>教育储蓄计算器</B></span></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td> <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="25" class="explain">教育储蓄计算器可以帮您计算教育储蓄的数额</td>
        </tr>
      </table>
      <TABLE width=95% align="center" cellSpacing=0>
        <TBODY>
          <TR> 
            <TD height="21" align=left class="head">计算公式</TD>
          </TR>
          <TR> 
            <TD height="1" background="${base}/static/images/dline.gif"></TD>
          </TR>
          <TR> 
            <TD><TABLE cellSpacing=0 
            cellPadding=0 width=568 border=0>
                <TBODY>
                  <TR> 
                    <TD width="110" height="25" class="zhengwen" s>初始存入日期:</TD>
                    <TD width="406" height="25" > <input class=text id=beginDateID 
                  onBlur=ChkCZDate(beginDateID); style="WIDTH: 80px" 
                  value=2001-1-1 name=beginDateID> <IMG 
                  src="${base}/static/images/calbtn.gif" width="18" height="18" 
              align=absMiddle style="CURSOR: hand" 
                  onclick=MyCalendar.SetDate(this,$('beginDateID'))></TD>
                  </TR>
                  <TR> 
                    <TD height="25" class="zhengwen" >储蓄存期:</TD>
                    <TD height="25" class="zhengwen"><SELECT id=cbType onchange=getrate(); name=cbType style="font-size:12px;">
                        <OPTION value=12 selected>一年期</OPTION>
                        <OPTION value=36>三年期</OPTION>
                        <OPTION 
  value=72>六年期</OPTION>
                      </SELECT> </TD>
                  </TR>
                  <TR> 
                    <TD height="25" class="zhengwen" >年利率(%):</TD>
                    <TD height="25" class="zhengwen"><INPUT class=inputBox id=edRate  name=edRate style="width:80px"></TD>
                  </TR>
                  <TR> 
                    <TD height="25" id=LabQcMq> <DIV class="zhengwen">月存入金额(元):</DIV></TD>
                    <TD height="25"><INPUT class=inputBox id=edBalance name=edBalance style="width:80px;">
                      <span class="zhengwen">元</span></TD>
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
            <TD ><TABLE width="316" border=0>
                <TBODY>
                  <TR> 
                    <TD width="173" height="25" noWrap class="zhengwen">到期本息金额(元):</TD>
                    <TD width="177" height="25"> <INPUT class=inputBox id=lbSum 
style="WIDTH: 112px; " disabled value=计算得出 name=lbSum></TD>
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
              
            <TD valign="top" class="zhengwen">教育储蓄是国家为了大力发展教育事业而推出的储蓄品种，它采用的是零存整取的存款方法和定期存款的存款利息，而且实行免缴利息税的优惠政策。适用于有需要接受非义务教育的孩子的家庭。</TD>
          </TR>
        </TBODY>
      </TABLE></td>
  </tr>
</table>

<SCRIPT language=javascript>
//var rate = new Array(4.14,5.40,5.85);
$("beginDateID").value=datetostring(new Date());
//getrate();
</SCRIPT>
<script language="JavaScript">
var InterestTax = 0.00;//0.05 ; // 利息税

//教育储蓄计算器
function EduCalc1(){  
    var InitSaveInDate = new Date(StrToDate($("beginDateID").value));
    SaveYears = ($("cbType").value)/12;
    InitSaveSum = $("edBalance").value;
    YearRate = $("edRate").value/100;
    CalcOption = 1;//计算选项：1,计算到期本息总额、2,计算初期存入金额
    DepositWay = 2;//存款方式：1,整存整取、2,零存整取
    ShresholdDate=new Date(1999,11,1); //1999年11月1日

    var dtime=new Date();
    var months;

    dtime.setMonth(InitSaveInDate.getMonth() + SaveYears*12);

    /*	 零存整取本息和＝月存额×12×存期（年）+月存额×累计月数×存款月利率
		    其中累计月数＝（12×存期+1）÷2×（12×存期）
    */
    months=(12*SaveYears+1)/2*(12*SaveYears);
	if (dtime<ShresholdDate) {
		if (DepositWay==2)// 零存整取计算方法
		{
			/*（1）初始存入日期+储蓄存期在1999年11月1日之前：
				 已知A，求B：B＝12×A×n+[A×（12×n+1）÷2×12×n×（r％÷12）]
				 已知B，求A：A＝B÷[12×n+（12×n+1)÷2×12×n×（r％÷12）]
				 扣除利息税金额＝0
			*/
			if (CalcOption==1)
			{ //零存整取本息和＝月存额×12×存期（年）+月存额×累计月数×存款月利率
				TermEndSum=InitSaveSum*(12*SaveYears+months*(YearRate/12.0));
			}
			
			InterestTaxSum=0;
		}

	}else if (InitSaveInDate<ShresholdDate){
		var tDays;
		tDays=LoanCalc.GetDayLen(dtime,ShresholdDate);
		/*
		 * （3）初始存入日期在1999年11月1日之前，初始存入日期+储蓄存期在1999年11月1日之后（含）：
			   已知A，求B：B＝A+ A×n×r％－InterestTax×A×（初始存入日期+储蓄存期－1999年11月1日）/360×r％
			   其中：（初始存入日期+储蓄存期－1999年11月1日）为天数
			   已知B，求A：A＝B÷[1+n×r％－InterestTax×（初始存入日期+储蓄存期－1999年11月1日）/360×r％]
			   扣除利息税金额＝InterestTax×A×（初始存入日期+储蓄存期－1999年11月1日）/360×r％
		 * */
		if (DepositWay==1){
			if (CalcOption==1) TermEndSum=InitSaveSum*(1+YearRate*SaveYears-InterestTax*tDays/360*YearRate);
			else{
				if(CalcOption==2) InitSaveSum=TermEndSum*1.0/(1+YearRate*SaveYears-InterestTax*tDays/360*YearRate); 
				InterestTaxSum=InterestTax*InitSaveSum*tDays/360*YearRate;
			}
		}
		/*（3）初始存入日期在1999年11月1日之前，初始存入日期+储蓄存期都在1999年11月1日之后（含）：
			 已知A，求B：B＝12×A×n+ A×（12×n+1）÷2×12×n×（r％÷12）－InterestTax×[A×（12×n+1）÷2×12×n×（r％÷12）]×（初始存入日期+储蓄存期－1999年11月1日）÷（储蓄存期×360）
			 其中：（初始存入日期+储蓄存期－1999年11月1日）、（储蓄存期×360）都为天数。
			 已知B，求A：A＝B÷[12×n+（12×n+1）÷2×12×n×（r％÷12）－InterestTax×（12×n+1）÷2×12×n×（r％÷12）×（初始存入日期+储蓄存期－1999年11月1日）÷（储蓄存期×360）]
			 扣除利息税金额＝InterestTax×[A×（12×n+1）÷2×12×n×（r％÷12）]×（初始存入日期+储蓄存期－1999年11月1日）÷（储蓄存期×360）
		 */
		else{
			if (CalcOption==1) TermEndSum=InitSaveSum*(12*SaveYears+months*(YearRate/12.0)*(1-InterestTax*tDays/(360*SaveYears)));
			else if(CalcOption==2) InitSaveSum=TermEndSum*1.0/(12*SaveYears+months*(YearRate/12.0)*(1-InterestTax*tDays/(360*SaveYears)));
			InterestTaxSum=InterestTax*InitSaveSum*months*(YearRate/12.0)*tDays/(360*SaveYears);
		}
	}else{
		/*
		 *（2）初始存入日期、初始存入日期+储蓄存期都在1999年11月1日之后（含）：
				已知A，求B：B＝A+A×n×r％×(1-InterestTax)
				已知B，求A：A＝B÷[r％×n×(1-InterestTax)+1]
				扣除利息税金额＝A×n×r％×InterestTax
		  * */
		if (DepositWay==1){
			if (CalcOption==1) TermEndSum=InitSaveSum*(1+YearRate*SaveYears*(1-InterestTax));
			else if(CalcOption==2) InitSaveSum=TermEndSum*1.0/(1+YearRate*SaveYears*(1-InterestTax)); 
			InterestTaxSum=InitSaveSum*YearRate*SaveYears*InterestTax;
		}
		/*（2）初始存入日期、初始存入日期+储蓄存期都在1999年11月1日之后（含）：
			 已知A，求B：B＝12×A×n+[(1-InterestTax)×A×（12×n+1）÷2×12×n×（r％÷12）]
			 已知B，求A：A＝B÷[12×n+(1-InterestTax)×（12×n+1）÷2×12×n×（r％÷12）]
			 扣除利息税金额＝InterestTax×A×（12×n+1）÷2×12×n×（r％÷12）
		*/
		else{
			if (CalcOption==1) TermEndSum=InitSaveSum*(12*SaveYears+(1-InterestTax)*months*(YearRate/12.0));
			else if(CalcOption==2) InitSaveSum=TermEndSum*1.0/(12*SaveYears+(1-InterestTax)*months*(YearRate/12.0)); 
			InterestTaxSum=InterestTax*InitSaveSum*months*(YearRate/12.0);
		}
	}
	//教育储蓄不交纳利息税。故，教育储蓄本息总额=正常储蓄的本息总额+正常储蓄被扣除的利息税
    $("lbSum").value=NBround(InterestTaxSum+TermEndSum,2);
}

function GetDayLen(StartDate,StandDate){
	//以每月30天算一月，一年为360天
	return (StartDate.getYear()-StandDate.getYear())*360+(StartDate.getMonth()-StandDate.getMonth())*30+(StartDate.getDate()-StandDate.getDate());
}
</script>
</body>
<#include "/template/foot.ftl"/>