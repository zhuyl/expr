<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/calendar.js" charset="gb2312"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/CheckDataFunction1.js" charset="gb2312"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/calendar1.js" charset="gb2312"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/Components.js" charset="gb2312"></script>

<SCRIPT language=javascript>
		<!--
			function getRate(month)
			{
				for(var i=0;i<rate.length;i++)
				{
					if(month==parseInt(minterm[i]))
						return rate[i];
				}
				return 0;
			}
			function getTerm(month)
			{
				for(var i=0;i<rate.length;i++)
				{
					if(Math.abs(month-parseInt(minterm[i]))<1)
						return i;
				}
				return -1;
			}
			function setRate()
			{
				this.document.all.tbRate.value = Round(100*getRate(parseInt(this.document.all.cbMonth.value)),4);
			}
		//-->
			</SCRIPT>

<SCRIPT language=javascript event=onclick for=rblItem>

			if(this.document.all.rblItem_0.checked)
			{
				/*tbEverySum.className="txtd";
				tbFirstSum.className="txtnum";
				tbEverySum.value="计算得出";
				if(tbFirstSum.value=="计算得出")
					tbFirstSum.value="";
				if(cbMonth.value=="计算得出")
					cbMonth.value=cbMonth.options[0].value;
				tbFirstSum.disabled=false;
				tbEverySum.disabled=true;
				cbMonth.disabled=false;*/
				tbEverySum.disabled=true;
				tbEverySum.className="txtd";

				tbEverySum.value="计算得出";
				lblFirstSum.innerText= "初始存入金额(元):";
				lblEverySum.innerText="每次支取金额(元):";
				//hr1.style.top=179;
			}
			else
			{
				if(this.document.all.rblItem_1.checked)
				{
					/*tbEverySum.className="txtnum";
					tbFirstSum.className="txtd";
					tbFirstSum.value="计算得出";
					if(tbEverySum.value=="计算得出")
						tbEverySum.value="";
					if(cbMonth.value=="计算得出")
						cbMonth.value=cbMonth.options[0].text;
					tbFirstSum.disabled=true;
					tbEverySum.disabled=false;
					cbMonth.disabled=false;*/
					tbEverySum.disabled=true;
					tbEverySum.value="计算得出";
					tbEverySum.className="txtd";
					lblFirstSum.innerText= "每次支取金额(元):";
				    lblEverySum.innerText="初始存入金额(元):";
				    //hr1.style.top=179;
				}
				else
				{
					/*tbEverySum.className="txtnum";
					tbFirstSum.className="txtnum";
					cbMonth.text="计算得出";
					if(tbEverySum.value=="计算得出")
						tbEverySum.value="";
					if(tbFirstSum.value=="计算得出")
						tbFirstSum.value="";
					tbFirstSum.disabled=false;
					tbEverySum.disabled=false;
					cbMonth.disabled=true;*/
					tbEverySum.disabled=false;
					tbEverySum.value="";
					tbEverySum.className="txtnum";
					lblFirstSum.innerText= "初始存入金额(元):";
				    lblEverySum.innerText="每次支取金额(元):";
				    //hr1.style.top=218;
				}
			}
		//-->
			</SCRIPT>

<SCRIPT language=javascript>
	<!--
	function btnCalc_onclick(){
		if(this.document.all.rblItem_0.checked)
		if(!CheckFN3(this.document.all.tbFirstSum,"请在[初始存入金额]中输入正数金额！",false))
		return false;
		if(this.document.all.rblItem_1.checked)
		if(!CheckFN3(this.document.all.tbFirstSum,"请在[每次存入金额]中输入正数金额！",false))
		return false;
		if(this.document.all.rblItem_2.checked)
		{
			if(!CheckFN3(this.document.all.tbFirstSum,"请在[初始存入金额]中输入正数金额！",false))
			return false;	
			if(!CheckFN3(this.document.all.tbEverySum,"请在[每次支取金额]中输入正数金额！",false))
			return false;			
		}

		if(!CheckEmpty(this.document.all.beginDateID,"请输入初始存入日期！"))
		return false;
		if(Cal_strtodate("1999-11-1")>Cal_strtodate(this.document.all.beginDateID.value))
		{
			DispMessage(this.document.all.beginDateID, "初始存入日期不得小于1999年11月1日！");
			return false;
		}
		if(!CheckFN3(this.document.all.tbRate,"请在[年利率]中输入正数！",false))
		return false;

		Calc(document);
		return false;
	}
	//-->
</SCRIPT>



<BODY LEFTMARGIN="0" TOPMARGIN="0">
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCFF" style="border-collapse:collapse;" >
  <tr> 
    <td height="23" background="${base}/static/images/titlebg.gif"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td><img src="${base}/static/images/titlearrow.gif" width="8" height="13"> <span class="title"><B>整存零取计算器</B></span></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td> <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="25"><span class="explain"><B>整存零取计算器可以帮您计算整存零取的数额</B> </span></td>
        </tr>
      </table>
    <FORM id=EduCalc name=EduCalc onsubmit="return false;">
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
width=521>
                  <TBODY>
                    <TR> 
                      <TD height=25 noWrap class="zhengwen">计算项目:</TD>
                      <TD height="25" class="zhengwen"> <INPUT id=rblItem_0 tabIndex=1 type=radio CHECKED value=1 
                  name=rblItem> <LABEL for=rblItem_0><SPAN 
                  class=style2>每次支取金额</SPAN></LABEL> <INPUT id=rblItem_1 
                  tabIndex=1 type=radio value=2 name=rblItem> <LABEL 
                  for=rblItem_1><SPAN class=style2>初始存入金额</SPAN></LABEL> <INPUT 
                  id=rblItem_2 tabIndex=1 type=radio value=3 name=rblItem> <LABEL for=rblItem_2><SPAN class=style2>储蓄存期</SPAN></LABEL> 
                      </TD>
                    </TR>
                    <TR> 
                      <TD height=25 noWrap class="zhengwen" id=lblFirstSum>初始存入金额(元):</TD>
                      <TD height="25"> <INPUT 
                  name=tbFirstSum class="inputBox" id=tbFirstSum style="WIDTH: 80px" tabIndex=2> 
                      </TD>
                    </TR>
                    <TR> 
                      <TD height=25 noWrap class="zhengwen">初始存入日期:</TD>
                      <TD height="25"> <INPUT 
                  name=beginDateID class="text" id=beginDateID 
                  style="WIDTH: 80px" tabIndex=3 onblur=ChkCZDate(beginDateID); value=2007-1-1 size=13> 
                        <IMG 
                  src="${base}/static/images/calbtn.gif" width="18" height=18 align=absMiddle style="CURSOR: hand" 
                  onclick="MyCalendar.SetDate(this,$('endDateID'))"> <SCRIPT language=javascript>
function ChkCZDate(edit)
{edit.value=Trim(edit.value);if(edit.value=='') return true;if(!Cal_datevalid(edit,'1910-1-1','3000-1-1')) 
{alert('日期格式不正确,日期有效范围为1910年到3000年');
edit.focus();}
 }</SCRIPT> </TD>
                    </TR>
                    <TR> 
                      <TD height=25 noWrap class="zhengwen">储蓄存期:</TD>
                      <TD height="25" id=tddrawsum> <SELECT id=cbMonth style="WIDTH: 80px;font-size:12px;" 
                  tabIndex=4 onchange=setRate() name=cbMonth>
                          <OPTION value=12 
                    selected>一年</OPTION>
                          <OPTION value=36>三年</OPTION>
                          <OPTION 
                    value=60>五年</OPTION>
                        </SELECT> </TD>
                    </TR>
                    <TR> 
                      <TD height=25 class="zhengwen" id=lbdrawdate>年利率(%)<SPAN 
                  id=Label4>:</SPAN></TD>
                      <TD height="25"> <INPUT 
                  name=tbRate class="inputBox" id=tbRate style="WIDTH: 80px;" tabIndex=5></TD>
                    </TR>
                    <TR>
                      <TD height=25 noWrap class="zhengwen">利息税率(%):</TD>
                      <TD height="25" class="zhengwen"><INPUT 
                  name=edRateTax class="inputBox" id=edRateTax style="WIDTH: 80px;" tabIndex=5></TD>
                    </TR>
                    <TR> 
                      <TD height=25 noWrap class="zhengwen">支取频度:</TD>
                      <TD height="25" class="zhengwen"> <INPUT id=rblFreq_0 tabIndex=6 type=radio CHECKED value=1 
                  name=rblFreq> <LABEL for=rblFreq_0><SPAN 
                  class=style2>每月</SPAN></LABEL> <INPUT id=rblFreq_1 tabIndex=6 
                  type=radio value=3 name=rblFreq> <LABEL for=rblFreq_1><SPAN 
                  class=style2>每季</SPAN></LABEL> <INPUT id=rblFreq_2 tabIndex=6 
                  type=radio value=6 name=rblFreq> <LABEL for=rblFreq_2><SPAN 
                  class=style2>每半年</SPAN></LABEL> </TD>
                    </TR>
                    <TR> 
                      <TD height=25>&nbsp;</TD>
                      <TD height=25><img id=btnCalc 
                  onClick="return btnCalc_onclick()" tabindex=10 height=19 
                  src="${base}/static/images/calbt.gif" width=47 
                  name=btnCalc value=" 计算 " type="submit"></TD>
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
            <TD ><TABLE cellSpacing=0 
width=298>
                  <TBODY>
                    <TR> 
                      <TD height="25" noWrap class="zhengwen" id=lblEverySum>每次支取金额(元):</TD>
                      <TD height="25" id=tdfullsum>
<INPUT name=tbEverySum 
                  disabled class="inputBox" id=tbEverySum style="WIDTH: 126px" tabIndex=7 value=计算得出> </TD>
                    </TR>
                    <TR> 
                      <TD height=25 noWrap class="zhengwen">利息金额(元):</TD>
                      <TD height="25">
<INPUT name=interest disabled class="inputBox" id=interest style="WIDTH: 126px" 
                  tabIndex=8 value=计算得出> </TD>
                    </TR>
                    <TR> 
                      <TD height=25 noWrap class="zhengwen">扣除利息税金额(元):</TD>
                      <TD height="25">
<INPUT name=interstTax disabled class="inputBox" id=interstTax style="WIDTH: 126px" 
                  tabIndex=9 value=计算得出></TD>
                    </TR>
                    <TR> 
                      <TD height=25 noWrap class="zhengwen">实得利息总额(元):</TD>
                      <TD height="25">
<INPUT name=actualInterest disabled class="inputBox" id=actualInterest style="WIDTH: 126px" 
                  tabIndex=9 value=计算得出> </TD>
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
              <TD valign="top" class="zhengwen">整存零取存款指客户须一次存入，然后按期定额支取的储蓄品种。本计算器可依据一定要求计算出整存零取存款的每次支取金额和所得利息金额（已扣除利息税），并可反向计算整存零取的初始存入金额和储蓄存期。</TD>
          </TR>
        </TBODY>
      </TABLE></form></td>
  </tr>
</table>
<SCRIPT language=javascript>
	document.EduCalc.beginDateID.value = datetostring(new Date());
	function Calc1(a1,a2,a3)
	{
		return Round(a1/(a2*a3));
	}
	function Calc2(a1,a2,a3)
	{
		return Round(a1*a2*a3,0);
	}
	function Calc3(a1,a2,a3)
	{
		return Round(a1/(a2*a3));
	}
	function CalcTax(a1,a2,a3,a4)
	{
		return a1*(a2*a3+1)/2*(a2*a3)*(a4/a2);
	}
	function getFreq(oDocument)
	{
		if(oDocument.all.rblFreq_0.checked)
		return 1;
		else
		if(oDocument.all.rblFreq_1.checked)
		return 3;
		else
		return 6;
	}
	function Calc(oDocument)
	{
		//利息税率
		//var interstTaxRate = 0.05;
		 var interstTaxRate = new Number( document.getElementById("edRateTax").value / 100 );//利息税率
		var nc = 12/getFreq(oDocument);//年次数
		if(oDocument.all.rblItem_0.checked)
		{
			oDocument.all.tbEverySum.value=Calc1(parseInt(oDocument.all.tbFirstSum.value),parseInt(oDocument.all.cbMonth.value)/12,nc);
			Tax=CalcTax(parseFloat(oDocument.all.tbEverySum.value),nc,parseInt(oDocument.all.cbMonth.value)/12,parseFloat(oDocument.all.tbRate.value)/100);
			oDocument.all.actualInterest.value=Round(Tax*(1-interstTaxRate));
			oDocument.all.interstTax.value=Round(Tax* interstTaxRate);
			oDocument.all.interest.value=Round(Tax);
		}
		else
		{
			if(oDocument.all.rblItem_1.checked)
			{
				oDocument.all.tbEverySum.value=Calc2(parseFloat(oDocument.all.tbFirstSum.value),parseInt(oDocument.all.cbMonth.value)/12,nc);
				Tax=CalcTax(parseFloat(oDocument.all.tbFirstSum.value),nc,parseInt(oDocument.all.cbMonth.value)/12,parseFloat(oDocument.all.tbRate.value)/100);
				oDocument.all.actualInterest.value=Round(Tax*(1-interstTaxRate));
				oDocument.all.interstTax.value=Round(Tax* interstTaxRate);
				oDocument.all.interest.value=Round(Tax);
			}
			else
			{
				Tax=CalcTax(parseFloat(oDocument.all.tbEverySum.value),nc,parseInt(oDocument.all.cbMonth.value)/12,parseFloat(oDocument.all.tbRate.value)/100);
				oDocument.all.actualInterest.value=Round(Tax*(1-interstTaxRate));
				oDocument.all.interstTax.value=Round(Tax* interstTaxRate);
				oDocument.all.interest.value=Round(Tax);
				var Month = 12*Calc3(parseInt(oDocument.all.tbFirstSum.value),parseFloat(oDocument.all.tbEverySum.value),nc);
				var x = getTerm(Month);
				if(x < 0)
				{
					msg="计算得出的储蓄存期为"+Round(Month/12)+"年，不符合银行储蓄的实际情况。";
					DispMessage(oDocument.all.tbFirstSum,msg);
					return;
				}
				//oDocument.all.cbMonth.selectedIndex=getTerm(Month);
				msg="计算得出的储蓄存期为"+oDocument.all.cbMonth.options[x].text+"。";
				alert(msg);
			}
		}
	}

</SCRIPT>
<script language="javascript">
$("beginDateID").value=datetostring(new Date());
</script>
</body>
<#include "/template/foot.ftl"/>