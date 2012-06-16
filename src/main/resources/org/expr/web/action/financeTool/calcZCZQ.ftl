<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/calendar.js" charset="gb2312"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/CheckDataFunction1.js" charset="gb2312"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/calendar1.js" charset="gb2312"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/Components.js" charset="gb2312"></script>

<SCRIPT language=javascript>
/// <summary>
///运行存款计算器，根据属性DepositWay和CalcOption的值
///把运行的不同结果存入
///属性 InitSaveSum，TermEndSum和InterestTaxSum中。
/// </summary>
function CalcDeposit()
{
	var DepositWay = 1;	//存款方式
	var YearRate = parseFloat(DepositCalculator.tbYearRate.value)/100;		//存款利率
	var InitSaveInDate = new Date();
	InitSaveInDate.setTime(StrToDate(DepositCalculator.beginDateID.value));	//初始存入日期
	var SaveYears = parseFloat(DepositCalculator.tbSaveTime.value/12);	 //存期
	var ShresholdDate=new Date("1999/11/1");
	var InitSaveSum = 0;	//初始存入金额
	var TermEndSum = 0;		//实得本息总额
	var InterestTaxSum=0;	//扣除利息税
	var	 CalcOption; 		//计算选项
	var InterestRates = new Number( document.getElementById("edRateTax").value / 100 ); //利息税率
	var dtime=new Date(InitSaveInDate.getFullYear(),InitSaveInDate.getMonth(),InitSaveInDate.getDate());
	var months;

	dtime.setMonth(dtime.getMonth()+SaveYears*12);
	/*	 零存整取本息和＝月存额×12×存期（年）+月存额×累计月数×存款月利率
			 其中累计月数＝（12×存期+1）÷2×（12×存期）
	*/
	months=((12*SaveYears+1)/2*(12*SaveYears));
	if (DepositCalculator.rbDepositWay_0.checked==true) DepositWay = 1;
	if (DepositCalculator.rbDepositWay_1.checked==true) DepositWay = 2;
	if (DepositCalculator.rbCalcOption_0.checked==true)
	{
		CalcOption = 1;
		InitSaveSum = parseFloat(DepositCalculator.tbInitSaveSum.value);
	}
	else
	{
		CalcOption = 2;
		TermEndSum = parseFloat(DepositCalculator.tbInitSaveSum.value);
		//Calc(initdate,term,ratio,sum,savetype,2);   
	 }

	/*
	 * 计算条件：
	   年利率：r％（客户经理输入值优于参数表对应值）
	   储蓄存期：n年（3个月为InterestRates5年，半年为0.5年）
	   计算实得本息总额，则还需知道：初期存入金额：A元
	   计算初期存入金额，则还需知道：实得本息总额：B元

	   1. 整存整取计算方法：
	 * */

	if (dtime<ShresholdDate)
	{
		if (DepositWay==1)//整存整取
		{
			/*
			 *（1）初始存入日期+储蓄存期在1999年11月1日之前：
				   已知A，求B：B＝A× r％ ×n +A
				   已知B，求A：A＝B÷[r％×n+1]
				   扣除利息税金额＝0
			 * */					
			if (CalcOption==1)
			{
				TermEndSum=InitSaveSum*(1+YearRate*SaveYears);
			}
			else if(CalcOption==2)
			{
				InitSaveSum=TermEndSum*1.0/(1+YearRate*SaveYears); 
			}
			InterestTaxSum=0;
		}
		else if (DepositWay==2)// 零存整取计算方法
		{
			/*（1）初始存入日期+储蓄存期在1999年11月1日之前：
				 已知A，求B：B＝12×A×n+[A×（12×n+1）÷2×12×n×（r％÷12）]
				 已知B，求A：A＝B÷[12×n+（12×n+1)÷2×12×n×（r％÷12）]
				 扣除利息税金额＝0
			*/
			if (CalcOption==1)
			{   //零存整取本息和＝月存额×12×存期（年）+月存额×累计月数×存款月利率
				TermEndSum=InitSaveSum*(12*SaveYears+months*(YearRate/12.0));
			}
			else if(CalcOption==2)
			{
				InitSaveSum=TermEndSum*1.0/(12*SaveYears+months*(YearRate/12.0)); 
			}
			InterestTaxSum=0;
		}

	}
	else 
	if (InitSaveInDate<ShresholdDate)
	{
		var tDays;
		//ts=dtime-ShresholdDate;
		tDays=GetDayLen(dtime,ShresholdDate);
		if (DepositWay==1)//
			/*
			 * （3）初始存入日期在1999年11月1日之前，初始存入日期+储蓄存期在1999年11月1日之后（含）：
				   已知A，求B：B＝A+ A×n×r％－InterestRates×A×（初始存入日期+储蓄存期－1999年11月1日）/360×r％
				   其中：（初始存入日期+储蓄存期－1999年11月1日）为天数
				   已知B，求A：A＝B÷[1+n×r％－InterestRates×（初始存入日期+储蓄存期－1999年11月1日）/360×r％]
				   扣除利息税金额＝InterestRates×A×（初始存入日期+储蓄存期－1999年11月1日）/360×r％
			 * */
		{
			if (CalcOption==1)
			{
				TermEndSum=InitSaveSum*(1+YearRate*SaveYears-InterestRates*tDays/360*YearRate);
			}
			else if(this.CalcOption==2)
			{
				InitSaveSum=TermEndSum*1.0/(1+YearRate*SaveYears-InterestRates*tDays/360*YearRate); 
			}
			InterestTaxSum=InterestRates*InitSaveSum*tDays/360*YearRate;
		}
		else //
			/*（3）初始存入日期在1999年11月1日之前，初始存入日期+储蓄存期都在1999年11月1日之后（含）：
				 已知A，求B：B＝12×A×n+ A×（12×n+1）÷2×12×n×（r％÷12）－InterestRates×[A×（12×n+1）÷2×12×n×（r％÷12）]×（初始存入日期+储蓄存期－1999年11月1日）÷（储蓄存期×360）
				 其中：（初始存入日期+储蓄存期－1999年11月1日）、（储蓄存期×360）都为天数。
				 已知B，求A：A＝B÷[12×n+（12×n+1）÷2×12×n×（r％÷12）－InterestRates×（12×n+1）÷2×12×n×（r％÷12）×（初始存入日期+储蓄存期－1999年11月1日）÷（储蓄存期×360）]
				 扣除利息税金额＝InterestRates×[A×（12×n+1）÷2×12×n×（r％÷12）]×（初始存入日期+储蓄存期－1999年11月1日）÷（储蓄存期×360）
			 */
		{
			if (CalcOption==1)
			{
				TermEndSum=InitSaveSum*(12*SaveYears+months*(YearRate/12.0)*(1-InterestRates*tDays/(360*SaveYears)));
			}
			else if(CalcOption==2)
			{
				InitSaveSum=TermEndSum*1.0/(12*SaveYears+months*(YearRate/12.0)*(1-InterestRates*tDays/(360*SaveYears)));
			}  
			InterestTaxSum=InterestRates*InitSaveSum*months*(YearRate/12.0)*tDays/(360*SaveYears);
		}
	}
	else
	{
		if (DepositWay==1)
			/*
			 *（2）初始存入日期、初始存入日期+储蓄存期都在1999年11月1日之后（含）：
					已知A，求B：B＝A+A×n×r％×(1 - InterestRates)
					已知B，求A：A＝B÷[r％×n×(1 - InterestRates)+1]
					扣除利息税金额＝A×n×r％×InterestRates
			  * */
		{
			if (CalcOption==1)
			{
				TermEndSum=InitSaveSum*(1+YearRate*SaveYears*(1 - InterestRates));
			}
			else if(CalcOption==2)
			{
				InitSaveSum=TermEndSum*1.0/(1+YearRate*SaveYears*(1 - InterestRates)); 
			}
			InterestTaxSum=InitSaveSum*YearRate*SaveYears*InterestRates;
		}
		else
		{
			/*（2）初始存入日期、初始存入日期+储蓄存期都在1999年11月1日之后（含）：
				 已知A，求B：B＝12×A×n+[(1 - InterestRates)×A×（12×n+1）÷2×12×n×（r％÷12）]
				 已知B，求A：A＝B÷[12×n+(1 - InterestRates)×（12×n+1）÷2×12×n×（r％÷12）]
				 扣除利息税金额＝InterestRates×A×（12×n+1）÷2×12×n×（r％÷12）
			*/
			if (CalcOption==1)
			{
				TermEndSum=InitSaveSum*(12*SaveYears+(1 - InterestRates)*months*(YearRate/12.0));
			}
			else if(CalcOption==2)
			{
				InitSaveSum=TermEndSum*1.0/(12*SaveYears+(1 - InterestRates)*months*(YearRate/12.0)); 
			}
			InterestTaxSum=InterestRates*InitSaveSum*months*(YearRate/12.0);
		}
	}

	if (CalcOption==1)
	{
		DepositCalculator.tbTermEndSum.value = NBround(TermEndSum,2);
		DepositCalculator.deserved.value = NBround(InterestTaxSum + TermEndSum,2);
	}
	else if(CalcOption==2)
	{
	  	DepositCalculator.tbTermEndSum.value = NBround(InitSaveSum,2);
	}
	DepositCalculator.tbInterestTaxSum.value = NBround(InterestTaxSum,2);
}

function check()
{
	if (!CheckEmpty(this.document.all.tbYearRate,"年利率不能为空"))
	return false;
	if (!CheckFN3(this.document.all.tbYearRate,"请在年利率输入正数",false))
	return false;
		if (!CheckFN(this.document.all.edRateTax,"请在利息税率输入非负数",false))
	return false;				
	if (this.document.all.rbCalcOption_0.checked){
	  if (!CheckFN3(this.document.all.tbInitSaveSum,"请在" + document.all.Layer1.innerText
	  + "输入正数",false))  // 初期存入金额
	  return false;			
	}
	else{
	  if (!CheckFN3(this.document.all.tbInitSaveSum,"请在实得本息总额输入正数",false))
	  return false;				   		
	}	
	if(document.all.tbSaveTime.value == "" ||isNaN(document.all.tbSaveTime.value) || parseInt(document.all.tbSaveTime.value) <=0){
		alert("储蓄荐期必须是正数");
		document.all.tbSaveTime.focus();
		return false;
	}
	return true;
}

function calcu()
{
	if (check()==false) return false;
	CalcDeposit();
	return false;
}
</SCRIPT>



<BODY LEFTMARGIN="0" TOPMARGIN="0">
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCFF" style="border-collapse:collapse;" >
  <tr> 
    <td height="23" background="${base}/static/images/titlebg.gif"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td><img src="${base}/static/images/titlearrow.gif" width="8" height="13"> <span class="title"><B>整(零)存整取计算器</B></span></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td> <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="25" class="explain"><B>整(零)存整取计算器可以帮助您计算整(零)存整取的数额</B></td>
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
                      <TD width="110" height="25" class="zhengwen" >存款方式:</TD>
                      <TD width="406" height="25" > <TABLE width="192" border=0 id=rbDepositWay>
                          <TBODY>
                            <TR class="zhengwen"> 
                              <TD width="74"> <INPUT language=javascript id=rbDepositWay_0 
                        onclick=changeall() type=radio CHECKED value=1 
                        name=rbDepositWay> <LABEL class=zhengwen 
                        for=rbDepositWay_0>整存整取</LABEL></TD>
                              <TD width="92"> <INPUT language=javascript id=rbDepositWay_1 
                        onclick=changeall() type=radio value=2 
                        name=rbDepositWay> <LABEL class=cBlue 
                        for=rbDepositWay_1>零存整取</LABEL></TD>
                            </TR>
                          </TBODY>
                        </TABLE></TD>
                    </TR>
                    <TR> 
                      <TD height="25" vAlign=center class="zhengwen">计算选项:</TD>
                      <TD height="25" > <TABLE width="65%" border=0>
                          <TBODY>
                            <TR class="zhengwen"> 
                              <TD> <INPUT id=rbCalcOption_0 onclick=changeall() 
                        type=radio CHECKED value=1 name=rbCalcOption> <LABEL 
                        class=cBlue for=rbCalcOption_0>计算实得本息总额</LABEL></TD>
                              <TD> <INPUT id=rbCalcOption_1 onclick=changeall() 
                        type=radio value=2 name=rbCalcOption> <LABEL class=cBlue 
                        for=rbCalcOption_1>计算初期存入金额</LABEL></TD>
                            </TR>
                          </TBODY>
                        </TABLE></TD>
                    </TR>
                    <TR> 
                      <TD height="25" class="zhengwen" s>初始存入日期:</TD>
                      <TD height="25" > <input class=txt id=beginDateID 
                  onBlur=ChkCZDate(beginDateID); style="WIDTH: 80px" 
                  value=2001-1-1 name=beginDateID>
                        <IMG 
                  src="${base}/static/images/calbtn.gif" width="18" height="18" 
              align=absMiddle style="CURSOR: hand" 
                  onclick=MyCalendar.SetDate(this,$('beginDateID'))></TD>
                    </TR>
                    <TR> 
                      <TD height="25" class="zhengwen">储蓄存期:</TD>
                      <TD height="25" id=saveTermTd ></TD>
                    </TR>
                    <TR> 
                      <TD height="25" class="zhengwen" >年利率(%):</TD>
                      <TD height="25" class="zhengwen"> <INPUT class=inputBox id=tbYearRate style="WIDTH: 80px" 
                  name=tbYearRate>
                        &nbsp;</TD>
                    </TR>
                    <TR>
                      <TD height="25" class="zhengwen" id=LabQcMq>利息税率(%):</TD>
                      <TD height="25"><INPUT class=inputBox id=edRateTax style="WIDTH: 80px" 
                  name=edRateTax></TD>
                    </TR>
                    <TR> 
                      <TD height="25" id=LabQcMq> <DIV class="zhengwen" id=Layer1 style="Z-INDEX: 102">初期存入金额:</DIV></TD>
                      <TD height="25"> <INPUT class=inputBox id=tbInitSaveSum style="WIDTH: 80px" 
                  name=tbInitSaveSum> <span class="zhengwen">&nbsp;元</span></TD>
                    </TR>
                    <TR> 
                      <TD height=25>&nbsp; </TD>
                      <TD height=25><img id=btnExecute2 
                  style="CURSOR: hand" onClick="return calcu()" tabindex=7 
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
            <TD ><TABLE width="273" border=0>
                  <TBODY>
				     <TR> 
                      <TD height=25 class="zhengwen" id=deserved1>应得本息总额:</TD>
                      <TD height="25" id=deserved2>
<INPUT class=inputBox id=deserved 
                  style="WIDTH: 100px" disabled  value=计算得出 
                  name=deserved> </TD>
                    </TR>
                    <TR> 
                      <TD noWrap height=25><SPAN class="zhengwen" id=Label9>扣除利息税金额</SPAN><span class="zhengwen">:</span></TD>
                      <TD height="25">
<INPUT class=inputBox id=tbInterestTaxSum
                  style="WIDTH: 100px" disabled  value=计算得出 
                  name=tbInterestTaxSum> </TD>
                    </TR>
					  <TR> 
                      <TD height="25" noWrap><SPAN class="zhengwen" id=layerresult>实得本息总额</SPAN><span class="zhengwen">: 
                        </span></TD>
                      <TD height="25">
<INPUT class=inputBox id=tbTermEndSum style="WIDTH: 100px" 
                  disabled  value=计算得出 name=tbTermEndSum> </TD>
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
              <TD valign="top" class="zhengwen">银行存款是使用较多的投资方式，通过本计算器，可以对整存整取的初始存入金额或到期本息总额进行计算。其中，到期本息总额为扣除利息税后的净值。</TD>
          </TR>
        </TBODY>
      </TABLE></form></td>
  </tr>
</table>
<SCRIPT language=javascript>
setTermSelect();
//设置储蓄存期下拉框
function setTermSelect(){
	var saveTerm = document.getElementById("saveTermTd");
	saveTerm.innerHTML = "";
	var termSelect = document.createElement("select");
	termSelect.name = "tbSaveTime";
	termSelect.id = "tbSaveTime";
	var termList = {"3":"三个月","6":"半年","12":"一年","24":"二年","36":"三年",'60':"五年"};
	termSelect.options.length = 0;
	for(key in termList){
		termSelect.options.add(new Option(termList[key] , key));
	}
	saveTerm.appendChild(termSelect);
}
function changeall()
{
	//如果选择整存整取，储蓄存期变为下拉选择框
	setTermSelect();
	if (document.DepositCalculator.rbDepositWay_0.checked==true){
		if (this.document.all.rbCalcOption_0.checked){
			this.document.all.Layer1.innerText="初期存入金额";
			this.document.all.layerresult.innerText="实得本息总额";
			document.getElementById("deserved1").style.display='';
			document.getElementById("deserved2").style.display='';
		}  
		else{
			this.document.all.Layer1.innerText="实得期本息总额";
			this.document.all.layerresult.innerText="初期存入金额";
			document.getElementById("deserved1").style.display='none';
			document.getElementById("deserved2").style.display='none';
		}
	}
	if (document.DepositCalculator.rbDepositWay_1.checked==true){
		//如果选择零存整取，储蓄存期变为文本输入框
		var saveTerm = document.getElementById("saveTermTd");
		saveTerm.innerHTML = "<input type='text' class=''inputBox' name='tbSaveTime' id='tbSaveTime' size='4' /><span class='zhengwen'>月</span>";
		if (this.document.all.rbCalcOption_0.checked){
			this.document.all.Layer1.innerText="每期存入金额";
			this.document.all.layerresult.innerText="实得期本息总额";
			document.getElementById("deserved1").style.display='';
			document.getElementById("deserved2").style.display='';
		}  
		else{
			this.document.all.Layer1.innerText="实得期本息总额";
			this.document.all.layerresult.innerText="每期存入金额";
			document.getElementById("deserved1").style.display='none';
			document.getElementById("deserved2").style.display='none';
		}
	}
}
		</SCRIPT>
		<script>
function ChkCZDate(edit) { edit.value=Trim(edit.value);if(edit.value=='') return 
true; if(!Cal_datevalid(edit,'1910-1-1','3000-1-1')) { 
alert('日期格式不正确,日期有效范围为1910年到3000年'); edit.focus(); } } 
document.DepositCalculator.beginDateID.value=datetostring(new Date()); 
this.document.all.rbDepositWay_0.checked = true; </SCRIPT>
<script language="javascript">
$("beginDateID").value=datetostring(new Date());
</script>
<#include "/template/foot.ftl"/>