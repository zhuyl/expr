<#include "/template/head.ftl"/>
<SCRIPT language=javascript>
var navIndex = 11;
rhb=new Array(440.104,301.103,231.7,190.136,163.753,144.08,129.379,117.991,108.923,101.542,95.425,90.282,85.902,82.133,78.861,75.997,73.473,71.236,69.241,67.455,65.848,64.397,63.082,61.887,60.798,59.802,58.890,58.052,57.282)
yhz=new Array(1.978,2.9344,3.8699,4.7847,5.6794,6.5544,7.4102,8.2472,9.0657,9.8662,10.6491,11.4148,12.1636,12.8959,13.6121,14.3126,14.9977,15.6677,16.3229,16.9637,17.5904,18.2034,18.8028,19.389,19.9624,20.5231,21.0715,21.6078,22.1323)
function chk01()
{
if (parseFloat(document.myform.governableMoney.value)<4.7)
	alert("--您确定是"+parseFloat(document.myform.governableMoney.value)+"万元?--"+"\n\n"+"那么您目前尚不具备购房能力，"+"\n\n"+"建议积攒积蓄或能筹集更多的资金。")
if (parseFloat(document.myform.governableMoney.value)>10000)
	alert("您确定拥有超过一亿元的购房资金？");

}
function chk02()
{
if (parseFloat(document.myform.monthlyExpense.value)>parseFloat(document.myform.rg02.value)*0.7)
	{
	alert("您预计家庭每月可用于购房支出已超过家庭月收入的70%，"+"\n\n"+"是否确定不会影响您的正常生活消费？"+"\n\n"+"建议在40%（"+parseFloat(document.myform.rg02.value)*0.4+"元）左右")
	}
}
function chk03()
{
if (document.myform.governableMoney.value=="")
	alert("请填写现可用于购房的资金")
else
	if (document.myform.rg02.value=="")
			alert("请填写现家庭月收入")
	else	
		if (document.myform.monthlyExpense.value=="")
			alert("请填写预计家庭每月可用于购房支出")
	else	
		if (document.myform.area.value=="")
			alert("请填写您计划购买房屋的面积")
	else
		chk04()

}
function chk04()
{
	governableMoney=parseFloat(document.myform.governableMoney.value)*10000
	var monthlyExpense =parseFloat(document.myform.monthlyExpense.value)
	js02=Math.round(monthlyExpense /rhb[parseInt(document.myform.rg04.options[document.myform.rg04.selectedIndex].value)/12-2])*10000
	var area =parseFloat(document.myform.area.value)

	if (js02>governableMoney*3.2)
	js02=governableMoney*3.2
	//房屋总价
	var totalMoney=Math.round((js02+0.8*governableMoney)*100)/100;
	document.myform.totalMoney.value = totalMoney;
	document.myform.unitMoney.value=Math.round(parseFloat(totalMoney)/area *100)/100
	var taxRate = document.myform.taxRate.value / 100;
	if (area <120)
		document.myform.tax.value=Math.round(parseFloat(totalMoney) * taxRate);
	else
		document.myform.tax.value=Math.round((parseFloat(totalMoney)-parseFloat(document.myform.unitMoney.value)*120)*4+parseFloat(document.myform.unitMoney.value)*120*2)/100
	maintainFundRate = document.myform.maintainFundRate.value / 100;
	document.myform.maintainFund.value=Math.round(parseFloat(totalMoney)* maintainFundRate);
	document.myform.rg12.value=Math.round(parseFloat(totalMoney)*20)/100
	document.myform.rg13.value=Math.round(Math.round(parseFloat(totalMoney)*0.05)/100*yhz[parseInt(document.myform.rg04.options[document.myform.rg04.selectedIndex].value)/12-2]*100)/100
	document.myform.rg14.value=Math.round(parseFloat(totalMoney)*0.3)/100
	document.myform.rg15.value="200~500"
}
</SCRIPT>

<BODY LEFTMARGIN="0" TOPMARGIN="0">
<FORM name="myform">
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCFF" style="border-collapse:collapse;" >
  <tr> 
    <td height="23" background="${base}/static/images/titlebg.gif"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td><img src="${base}/static/images/titlearrow.gif" width="8" height="13"> <span class="title">购房能力评估计算器</span></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td> <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="25" class="explain">购房能力评估计算器可以帮您评估您的买房能力</td>
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
            <TD><TABLE style="WIDTH: 550px" cellSpacing=0>

                  <TBODY>
                    <TR class="zhengwen"> 
                      <TD width="209" height="25"  >现可用于购房的资金：</TD>
                      <TD width=335 height="25"> 
                        <INPUT onblur=chk01() size=10 name=governableMoney class="inputBox">万元</TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD height="25"  >现家庭月收入：</TD>
                      <TD height="25"> 
                        <INPUT size=10 name=rg02 class="inputBox">元</TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD height="25" >预计家庭每月可用于购房支出：</TD>
                      <TD height="25"> 
                        <INPUT onblur=chk02() size=10 name=monthlyExpense class="inputBox" >元/月</TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD height="25" >您期望偿还贷款的年限：</TD>
                      <TD height="25"> 
                        <SELECT size=1 name=rg04 style="font-size:12px;">
                          <OPTION value=24 
                    selected>2年(24期)</OPTION>
                          <OPTION 
                    value=36>3年(36期)</OPTION>
                          <OPTION 
                    value=48>4年(48期)</OPTION>
                          <OPTION 
                    value=60>5年(60期)</OPTION>
                          <OPTION 
                    value=72>6年(72期)</OPTION>
                          <OPTION 
                    value=84>7年(84期)</OPTION>
                          <OPTION 
                    value=96>8年(96期)</OPTION>
                          <OPTION 
                    value=108>9年(108期)</OPTION>
                          <OPTION 
                    value=120>10年(120期)</OPTION>
                          <OPTION 
                    value=180>15年(180期)</OPTION>
                          <OPTION 
                    value=240>20年(240期)</OPTION>
                          <OPTION 
                    value=300>25年(300期)</OPTION>
                          <OPTION 
                    value=360>30年(360期)</OPTION>
                        </SELECT>
                        年</TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD height="25"  >您计划购买房屋的面积：</TD>
                      <TD height="25"> 
                        <INPUT size=10 name=area class="inputBox">平方米</TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD height="25">房屋公共维修基金收取比例：</TD>
                      <TD height="25"> 
                        <INPUT size=4 name=taxRate class="inputBox">%</TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD height="25">契税税率：</TD>
                      <TD height="25"> 
                        <INPUT size=4 name=maintainFundRate class="inputBox">%</TD>
                    </TR>
                    <TR> 
                      <TD height="25"></TD>
                      <TD height="25"> <img id=btnCalc
                  style="CURSOR: hand" onClick="chk03();" tabindex=7 
                  height=19 src="${base}/static/images/calbt.gif" 
                  width=47 name=btnCalc ></TD>
                    </TR>
                    <TR> 
                      <TD 
                colSpan=2 class="zhengwen" 
                style="PADDING-RIGHT: 8px; PADDING-LEFT: 8px; PADDING-BOTTOM: 8px; PADDING-TOP: 8px">说明： 房屋公共维修基金收取比例根据房屋不同而变化<BR>
                        多层楼房、别墅一般按照购房款2％的比例收取。<BR>
                        高层楼房及多层带电梯楼房一般按照购房款3％的比例收取。<BR>
                        售房单位按多层住宅售房款的20%、高层住宅售房款的30%的比例，筹集公共维修基金。</TD>
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
            <TD ><table border="0" cellpadding="0"  cellspacing=0 >
                <tbody>
                  <tr class="zhengwen"> 
                    <td width=151 height="25">您可购买的房屋总价为：</td>
                    <td width="145" height="25"> <input size=8 name=totalMoney class="inputBox" value="计算得出" disabled>元。</td>
                  </tr>
                  <tr class="zhengwen"> 
                    <td height="25" >您可购买的房屋单价为：</td>
                    <td height="25"> <input size=8 name=unitMoney class="inputBox" value="计算得出" disabled>
                      元。</td>
                  </tr>
                  <tr> 
                    <td height=25  colspan=2 class="head"><b>购房相关税费</b></td>
                  </tr>
                  <tr class="zhengwen"> 
                    <td height="25" >契税：</td>
                    <td height="25"> <input size=8 name=tax class="inputBox" value="计算得出" disabled>
                      元。</td>
                  </tr>
                  <tr class="zhengwen"> 
                    <td height="25" >公共维修基金：</td>
                    <td height="25"> <input size=8 name=maintainFund class="inputBox" value="计算得出" disabled>
                      元。</td>
                  </tr>
                  <tr> 
                    <td height=25 colspan=2 class="head"><b>银行贷款需支付的费用</b></td>
                  </tr>
                  <tr class="zhengwen"> 
                    <td height="25" >首付款：</td>
                    <td height="25"> 
                      <input size=8 name=rg12 class="inputBox" value="计算得出" disabled>元。</td>
                  </tr>
                  <tr class="zhengwen"> 
                    <td height="25" >保险费：</td>
                    <td height="25"> 
                      <input size=8 name=rg13 class="inputBox" value="计算得出" disabled>元。</td>
                  </tr>
                  <tr class="zhengwen"> 
                    <td height="25" >律师费：</td>
                    <td height="25"> 
                      <input size=8 name=rg14 class="inputBox" value="计算得出" disabled>元。</td>
                  </tr>
                  <tr class="zhengwen"> 
                    <td height="25" >抵押登记费：</td>
                    <td height="25"> 
                      <input size=8 name=rg15 class="inputBox" value="计算得出" disabled>元。</td>
                  </tr>
                </tbody>
              </table></TD>
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
      </TABLE>
	</td>
  </tr>
</table>
 </form>
</body>
<#include "/template/foot.ftl"/>