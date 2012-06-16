<#include "/template/head.ftl"/>
<BODY LEFTMARGIN="0" TOPMARGIN="0">
<FORM name=formt3 action="" method=post>
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCFF" style="border-collapse:collapse;" >
  <tr> 
    <td height="23" background="${base}/static/images/titlebg.gif"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
            <td><img src="${base}/static/images/titlearrow.gif" width="8" height="13"> <span class="title"><B>购房税费计算器</B></span></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td> <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
            <td height="25" class="explain"><B>购房税费计算器可以帮助您计算买房时要缴的税费额</B></td>
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
            <TD><TABLE width="527" >
                  <TBODY>
                    <TR class="zhengwen"> 
                      <TD height="25">单价:</TD>
                      <TD height="25"> 
                        <INPUT id= "unitPrice" name="unitPrice" class="inputBox" size=8 maxLength=6>
                        元/平米</TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD height="25" >面积:</TD>
                      <TD height="25" > 
                        <INPUT name=area class="inputBox" size=8 maxLength=7>
                        平方米</TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD height="25" >印花税税率:</TD>
                      <TD height="25" > 
                        <INPUT 
                  name=stampTaxRate class="inputBox" size=4 maxLength=7>
                        %</TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD height="25" >契税税率:</TD>
                      <TD height="25" > 
                        <INPUT 
                  name=contractTaxRate class="inputBox" size=4 maxLength=7>
                        %</TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD height="25" colSpan=2>说明： 对个人首次购买90平方米及以下普通住房的，契税税率暂统一下调到1%；对个人销售或购买住房暂免征收印花税。</TD>
                    </TR>
                    <TR> 
                      <TD height="25"></TD>
                      <TD height="25"> <img id=btnCalc
                  style="CURSOR: hand" onClick="runjs3(this.form)" tabindex=7 
                  height=19 src="${base}/static/images/calbt.gif" 
                  width=47 name=btnCalc > </TD>
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
              <TD ><TABLE width="339">
                  <TBODY>
                    <TR class="zhengwen"> 
                      <TD height="25" >房款总价：</TD>
                      <TD height="25"> 
                        <INPUT name=totalMoney class="inputBox" style="WIDTH: 120px" size=8 disabled>
                        元</TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD height="25" >印 花 税：</TD>
                      <TD height="25"> 
                        <INPUT name=stampTax class="inputBox" style="WIDTH: 120px" size=8 disabled>
                        元</TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD height="25">公 证 费：</TD>
                      <TD height="25"> 
                        <INPUT  name=notarialFee class="inputBox" style="WIDTH: 120px" size=8 disabled>
                        元</TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD height="25">契税：</TD>
                      <TD height="25"> 
                        <INPUT name=contractTax class="inputBox" style="WIDTH: 120px" size=8 disabled>
                        元</TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD height="25" >委托办理产权手续费：</TD>
                      <TD height="25"> 
                        <INPUT name=wt class="inputBox" style="WIDTH: 120px" size=8 disabled>
                        元</TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD height="25" >房屋买卖手续费：</TD>
                      <TD height="25"> 
                        <INPUT name=fw class="inputBox" style="WIDTH: 120px" size=8 disabled>
                        元</TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD height="25">总费用：</TD>
                      <TD height="25"> 
                        <INPUT name=fullMoney class="inputBox" style="WIDTH: 120px" size=8 disabled>
                        元</TD>
                    </TR>
                    <SCRIPT language=JavaScript>
			function runjs3(obj){
				var intunitPrice=parseFloat(document.formt3.unitPrice.value);
				var intarea=parseFloat(document.formt3.area.value);
				var totalMoney=intunitPrice*intarea;
				//印花税率
				var stampTaxRate = document.formt3.stampTaxRate.value / 100;
				var stampTax=totalMoney * stampTaxRate;
				//契税税率
				var contractTaxRate = document.formt3.contractTaxRate.value / 100;
				var contractTax = totalMoney * contractTaxRate;
				if (intarea<=120)  fw=500;
				else if (120<intarea && intarea<=5000)   fw=1500;
				if (intarea>5000)  fw=5000
				notarialFee=totalMoney*0.003;
				wt = notarialFee;
				document.formt3.stampTax.value=Math.round(stampTax*100)/100
				document.formt3.totalMoney.value=Math.round(totalMoney*100)/100
				document.formt3.contractTax.value=Math.round(contractTax*100)/100
				document.formt3.notarialFee.value=Math.round(notarialFee*100)/100
				document.formt3.wt.value=Math.round(wt *100)/100
				document.formt3.fw.value=Math.round(fw*100)/100;
				document.formt3.fullMoney.value = Math.round(totalMoney + stampTax + contractTax + notarialFee + wt + fw );
			}
		</SCRIPT>
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
      </TABLE>
	</td>
  </tr>
</table>
</form>

</body>
<#include "/template/foot.ftl"/>