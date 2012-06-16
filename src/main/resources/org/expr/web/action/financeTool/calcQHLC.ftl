<#include "/template/head.ftl"/>
<BODY LEFTMARGIN="0" TOPMARGIN="0">
<FORM id=cal name=cal  onsubmit="javascript:return false;">
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCFF" style="border-collapse:collapse;" >
  <tr> 
    <td height="23" background="${base}/static/images/titlebg.gif"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
        <td height="23" background="${base}/static/images/titlebg.gif"><img src="titlearrow.gif" width="8" height="13"> 
          <span class="title"><B>期货理财计算器</B></span></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td>
	 <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
            
        <td height="25" class="explain"><B>本计算器将帮您计算期货交易所需的费用。</B></td>
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
              <TD><TABLE 
              cellSpacing=0>
                  <TBODY>
                    <TR class="zhengwen"> 
                      <TD 
                width=99 height="25" align=right style="PADDING-TOP: 2px"></TD>
                      <TD width=245 height="25"> 
                        <SELECT name=cls style="font-size:12px;">
                          <OPTION value="" 
                    selected>--品种--</OPTION>
                          <OPTION value=cu>铜</OPTION>
                          <OPTION 
                    value=al>铝</OPTION>
                          <OPTION value=trxj>天然橡胶</OPTION>
                          <OPTION 
                    value=hddyh>黄大豆1号</OPTION>
                          <OPTION value=dp>豆粕</OPTION>
                          <OPTION value=ndbxm>硬冬白小麦</OPTION>
                          <OPTION 
                    value=yzqjxm>优质强筋小麦</OPTION>
                          <OPTION 
                    value=yhmh>一号棉花</OPTION>
                          <OPTION value=rly>燃料油</OPTION>
                          <OPTION value=hym>黄玉米</OPTION>
                          <OPTION value=dy>豆油</OPTION>
                          <OPTION value=lldpe>LLDPE</OPTION>
                          <OPTION 
                    value=zn>锌</OPTION>
                          <OPTION value=czy>菜籽油</OPTION>
                          <OPTION 
                    value=pta>PTA</OPTION>
                          <OPTION 
                value=bst>白砂糖</OPTION>
                        </SELECT></TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD height="25" >成交价格：</TD>
                      <TD height="25"> 
                        <INPUT style="WIDTH: 75px" size=10 name=price></TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD height="25" >交易手数：</TD>
                      <TD height="25"> 
                        <INPUT style="WIDTH: 75px" size=10 name=amount></TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD height="25" >保证金比例：</TD>
                      <TD height="25"> 
                        <INPUT style="WIDTH: 75px" size=10 name=cMoneyRate>
                        %</TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD height="25" >每手交易手续费：</TD>
                      <TD height="25"> 
                        <INPUT style="WIDTH: 75px" size=10 name=poundage></TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD height="25"></TD>
                      <TD height="25"> 
                        <INPUT name="button" type=button style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BACKGROUND-IMAGE: url(${base}/static/images/calbt.gif); BORDER-LEFT: 0px; WIDTH: 47px; CURSOR: hand; BORDER-BOTTOM: 0px; HEIGHT: 19px" onclick=javascript:calc();></TD>
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
              <TD ><TABLE class=zhengwen 
              cellSpacing=0>
                  <TBODY>
                    <TR> 
                      <TD 
                  width=59>总金额：</TD>
                      <TD width="194"><INPUT name=sumMoney class="inputBox" style="WIDTH: 75px" readOnly>
                        元</TD>
                    </TR>
                    <SCRIPT languange="javascript">
function isNum(num)
{
	var validnum = "0123456789.";
	var temp;
	var i;
	if(num.length<1)
	{
		return 0;
	}
	for (i=0; i<num.length; i++)
	{
		temp = "" + num.substring(i, i+1);
		if (validnum.indexOf(temp) == "-1")
		{
			return 0;
		}
	}
	return 1;
}

function calc()
{
	//map为期货本身及对应的每手吨数
	var map={"hym":10,
		"hddyh":10,
		"dp":10,
		"dy":10,
		"lldpe":5,
		"cu":5,
		"al":5,
		"trxj":5,
		"rly":10,
		"zn":5,
		"yhmh":5,
		"czy":5,
		"yzqjxm":10,
		"pta":5,
		"bst":10,
		"ndbxm":10		 
		};
	var aform = cal;
	var product = aform.cls.value;
	var unit = map[product];//每手吨数
	var idx = aform.cls.value;
	if (idx=="")
	{
		alert("请正确选择期货品种");
		aform.cls.focus();
		return false;
	}
	var price=aform.price.value
	if(isNum(price)==0)
	{
		alert("请正确填写成交价格");
		aform.price.select();
		return false;
	}
	var amount = aform.amount.value;
	if(isNum(amount)==0)
	{
		alert("请正确填写交易手数");
		aform.amount.select();
		return false;
	}

	var poundage =aform.poundage.value; 
	if(isNum(poundage)==0)
	{
		alert("请正确填写每手交易手续费");
		aform.poundage.select();
		return false;
	}
	rate = aform.cMoneyRate.value;
	if(isNum(rate)==0)
	{
		alert("请正确填写保证金比例");
		aform.cMoneyRate.select();
		return false;
	}

	//开始计算
	var result = price*amount*unit*rate/100+poundage*amount;
	result += "";
	if(result.indexOf(".")!="-1" && result.indexOf(".")<(result.length-4))
	{
		all = result.substring(0, result.indexOf(".")+4);
	}
	aform.sumMoney.value = result;
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
        </TABLE></td>
</tr>

</table>
</form>
</body>
<#include "/template/foot.ftl"/>