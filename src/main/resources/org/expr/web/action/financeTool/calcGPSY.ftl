<#include "/template/head.ftl"/>
<SCRIPT language=javaScript>
function doNext() {
	document.theForm.action="/app/jsp/selfin/invest/invest2.jsp";
	theForm.submit();
}
function goToPage(url)
{
	location.href=url;
}
</SCRIPT>

<SCRIPT language=javascript>
function dealdata(z)        //保存到小数点后2位
{
var x=z;
x=parseInt(z*100.0);
x=x/100;
return x;
}

function result()
{
	//if (!checkValidator(document.theForm))
		//return false;

	for(i=0;i<document.all("amode").length;i++)
		if(document.all("amode")[i].checked)
			amode = document.all("amode")[i].value;

	for(i=0;i<document.all("cmode").length;i++)
		if(document.all("cmode")[i].checked)
			cmode = document.all("cmode")[i].value;

	//判断数据输入的有效性
	mrjg = parseFloat(document.theForm.mrjg.value);	// 股票买入价格
	mrsl = parseFloat(document.theForm.mrsl.value);	// 股票买入数量
	xjgl = parseFloat(document.theForm.xjgl.value);	// 股票股票股利
	gpgl = parseFloat(document.theForm.gpgl.value);	// 股票股票股利
	mrje = mrjg * mrsl;		// 买入金额

	if ( amode == '1' )
	{
		mcjg = parseFloat(document.theForm.mcjg.value);	// 股票卖出价格
		mcje = mcjg * ( mrsl + gpgl );	// 卖出金额
	}
	else
	{
		mcjg = 0.0;
		mcje = 0.0;
	}

	yj1 = 0.0;	yj2 = 0.0;
	yhs1 = 0.0;	yhs2 = 0.0;
	ghf1 = 0.0;	ghf2 = 0.0;
	jsf1 = 0.0;	jsf2 = 0.0;

	if ( cmode == "HA" )
	{
		yjbl = parseFloat(document.theForm.yjbl.value);
		buyyhsbl = parseFloat(document.theForm.buyyhsbl.value);
		sellyhsbl = parseFloat(document.theForm.sellyhsbl.value);
		ghfbl = parseFloat(document.theForm.ghfbl.value);

		yj1 = dealdata( mrje * yjbl / 100 );
		yj1 = yj1>10.0 ? yj1 : 10.0;
		yhs1 = dealdata( mrje * buyyhsbl / 100 );
		ghf1 = 10.0;

		if ( amode == '2' )
		{
			mrcb = dealdata( yj1 + yhs1 + ghf1 + jsf1 );
			mcjg = dealdata( ( xjgl - mrjg * mrsl - mrcb - ghf1 ) / ( (mrsl+gpgl)*(yjbl/100+buyyhsbl/100) - (mrsl+gpgl) ) );
			mcjg1 = dealdata( ( xjgl - mrjg * mrsl - mrcb - ghf1 - 10.0 ) / ( (mrsl+gpgl)*(buyyhsbl/100) - (mrsl+gpgl) ) );
			if ( mcjg * ( mrsl+gpgl) * yjbl / 100 < 10.0 )
				mcjg = mcjg1;
			mcje = mcjg * ( mrsl + gpgl );	// 卖出金额
			document.theForm.mrcb.value = dealdata( mrcb );
			document.theForm.mcjg.value = dealdata( mcjg );
		}

		yj2 = dealdata( mcje * yjbl / 100 );
		yj2 = yj2>10.0 ? yj2 : 10.0;
		yhs2 = dealdata( mcje * sellyhsbl / 100 );
		ghf2 = 10.0;

	}
	else if ( cmode == "HB" )
	{
		yjbl = parseFloat(document.theForm.yjbl.value);
		buyyhsbl = parseFloat(document.theForm.buyyhsbl.value);
		sellyhsbl = parseFloat(document.theForm.sellyhsbl.value);
		jsfbl = parseFloat(document.theForm.jsfbl.value);

		yj1 = dealdata( mrje * yjbl / 100 );
		yhs1 = dealdata( mrje * buyyhsbl / 100 );
		jsf1 = dealdata( mrje * jsfbl / 100 );

		if ( amode == '2' )
		{
			mrcb = dealdata( yj1 + yhs1 + ghf1 + jsf1 );
			mcjg = dealdata( ( xjgl - mrjg * mrsl - mrcb ) / ( (mrsl+gpgl)*(yjbl/100+buyyhsbl/100+jsfbl/100) - (mrsl+gpgl) ) );
			mcje = mcjg * ( mrsl + gpgl );	// 卖出金额
			document.theForm.mrcb.value = dealdata( mrcb );
			document.theForm.mcjg.value = dealdata( mcjg );
		}

		yj2 = dealdata( mcje * yjbl / 100 );
		yhs2 = dealdata( mcje * sellyhsbl / 100 );
		jsf2 = dealdata( mcje * jsfbl / 100 );
	}
	else if ( cmode == "SA" )
	{
		yjbl = parseFloat(document.theForm.yjbl.value);
		buyyhsbl = parseFloat(document.theForm.buyyhsbl.value);
		sellyhsbl = parseFloat(document.theForm.sellyhsbl.value);
		yj1 = dealdata( mrje * yjbl / 100 );
		yhs1 = dealdata( mrje * buyyhsbl / 100 );

		if ( amode == '2' )
		{
			mrcb = dealdata( yj1 + yhs1 + ghf1 + jsf1 );
			mcjg = dealdata( ( xjgl - mrjg * mrsl - mrcb - ghf1 ) / ( (mrsl+gpgl)*(yjbl/100+buyyhsbl/100) - (mrsl+gpgl) ) );
			mcje = mcjg * ( mrsl + gpgl );	// 卖出金额
			document.theForm.mrcb.value = dealdata( mrcb );
			document.theForm.mcjg.value = dealdata( mcjg );
		}

		yj2 = dealdata( mcje * yjbl / 100 );
		yhs2 = dealdata( mcje * sellyhsbl / 100 );
	}
	else // if ( cmode == "SB" )
	{
		yjbl = parseFloat(document.theForm.yjbl.value);
		buyyhsbl = parseFloat(document.theForm.buyyhsbl.value);
		sellyhsbl = parseFloat(document.theForm.sellyhsbl.value);
		jsfbl = parseFloat(document.theForm.jsfbl.value);
		yj1 = dealdata( mrje * yjbl / 100 );
		yhs1 = dealdata( mrje * buyyhsbl / 100 );
		jsf1 = dealdata( mrje * jsfbl / 100 );
		jsf1 = jsf1>500.0 ? 500.0 : jsf1;

		if ( amode == '2' )
		{
			mrcb = dealdata( yj1 + yhs1 + ghf1 + jsf1 );
			mcjg = dealdata( ( xjgl - mrjg * mrsl - mrcb ) / ( (mrsl+gpgl)*(yjbl/100+buyyhsbl/100+jsfbl/100) - (mrsl+gpgl) ) );
			mcjg1 = dealdata( ( xjgl - mrjg * mrsl - mrcb - 500) / ( (mrsl+gpgl)*(yjbl/100+buyyhsbl/100) - (mrsl+gpgl) ) );
			if ( mcjg * ( mrsl+gpgl) * jsfbl / 100 > 500.0 )
				mcjg = mcjg1;
			mcje = mcjg * ( mrsl + gpgl );	// 卖出金额
			document.theForm.mrcb.value = dealdata( mrcb );
			document.theForm.mcjg.value = dealdata( mcjg );
		}

		yj2 = dealdata( mcje * yjbl / 100 );
		yhs2 = dealdata( mcje * sellyhsbl / 100 );
		jsf2 = dealdata( mcje * jsfbl / 100 );
		jsf2 = jsf2>500.0 ? 500.0 : jsf2;

	}
	document.theForm.mrcb.value = dealdata( yj1 + yhs1 + ghf1 + jsf1 );
	document.theForm.mccb.value = dealdata( yj2 + yhs2 + ghf2 + jsf2 );
	document.theForm.cbhj.value = dealdata( document.theForm.mrcb.value * 1 + document.theForm.mccb.value * 1 );
	if ( amode == '2' )
		document.theForm.sy.value = "0";
	else
		document.theForm.sy.value = dealdata( mcje * 1 + document.theForm.xjgl.value * 1 - mrje - document.theForm.mrcb.value - document.theForm.mccb.value );

	//lockFields(document.theForm);
	//unlockFields(document.theForm,3);
	//disableField(document.theForm);
	//return false;	
}

function setlabel(dw)
{
	for(i=1;i<=7;i++)
		document.all("bzdw"+i).innerText = dw;
}

function setable(type)
{
	if ( type == "HA" )
	{
		document.all("sp_yjbl").style.display="block";
		document.all("yjbl").value=document.all("stock_commision_rate_HB").value;
		//document.all("yhsbl").value=document.all("stock_stamptax_rate_HA").value;
		document.all("ghfbl").value=document.all("stock_change_fee_HA").value;
		document.all("jsfbl").value="0";
		setlabel("元");
	}
	else if ( type == "HB" )
	{
		document.all("sp_yjbl").style.display="none";
		document.all("yjbl").value=document.all("stock_commision_rate_HB").value;
		//document.all("yhsbl").value=document.all("stock_stamptax_rate_HB").value;
		document.all("ghfbl").value="0";
		document.all("jsfbl").value=document.all("stock_balance_rate_HB").value;
		setlabel("美元");
	}
	else if ( type == "SA" )
	{
		document.all("sp_yjbl").style.display="block";
		document.all("sp_yjbl").value="";
		document.all("yjbl").value=document.all("stock_commision_rate_SB").value;
		//document.all("yhsbl").value=document.all("stock_stamptax_rate_SA").value;
		document.all("ghfbl").value="0";
		document.all("jsfbl").value="0";
		setlabel("元");
	}
	else // if ( type == "SB" )
	{
		document.all("sp_yjbl").style.display="none";
		document.all("yjbl").value=document.all("stock_commision_rate_SB").value;
		//document.all("yhsbl").value=document.all("stock_stamptax_rate_SB").value;
		document.all("ghfbl").value="0";
		document.all("jsfbl").value=document.all("stock_balance_rate_SB").value;
		setlabel("港币");
	}
	document.all("mrcb").value="计算得到";
	document.all("mccb").value="计算得到";
	document.all("sy").value="计算得到"
	return true;
}

function setamode(type)
{
	if ( type == '2' )
	{
		document.all("mcjg").value="计算得到";
		document.all("mcjg").disabled=true;
		document.theForm.sy.value = "0";
	}
	else
	{
		if ( document.all("mcjg").value == "计算得到" )
			document.all("mcjg").value="";
		document.all("mcjg").disabled=false;
		document.theForm.sy.value = "计算得到";
	}
}

function resetvalue()
{
	document.all("amode")[0].checked = true;
	document.all("amode")[1].checked = false;
	document.all("cmode")[0].checked = true;
	document.all("cmode")[1].checked = false;
	document.all("cmode")[2].checked = false;
	document.all("cmode")[2].checked = false;
	document.all("mrjg").value="";
	document.all("mrsl").value="";
	document.all("xjgl").value="";
	document.all("gpgl").value="";
	document.all("mcjg").value="";

	setable('HA');
}
</SCRIPT>

<BODY LEFTMARGIN="0" TOPMARGIN="0">
<FORM name=theForm action="">
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCFF" style="border-collapse:collapse;" >
  <tr> 
    <td height="23" background="${base}/static/images/titlebg.gif"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
            <td height="23" background="${base}/static/images/titlebg.gif"><img src="titlearrow.gif" width="8" height="13"> 
              <span class="title"><B>股票收益计算器</B></span></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td>
	 <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
            
            <td height="25" class="explain"><B>股票收益计算器可以帮您计算买卖股票的成本和收益</B></td>
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
              cellSpacing=0 class="zhengwen">
                  <TBODY>
                    <TR> 
                      <TD height="25" colSpan=2> <INPUT type=hidden value=5 
                  name=stock_commision_limit_HA> <INPUT type=hidden value=0.2 
                  name=stock_stamptax_rate_HA> <INPUT type=hidden value=10 
                  name=stock_change_fee_HA> <INPUT type=hidden value=0.3 
                  name=stock_commision_rate_HB> <INPUT type=hidden value=0.2 
                  name=stock_stamptax_rate_HB> <INPUT type=hidden value=0.05 
                  name=stock_balance_rate_HB> <INPUT type=hidden value=0.2 
                  name=stock_stamptax_rate_SA> <INPUT type=hidden value=0.3 
                  name=stock_commision_rate_SB> <INPUT type=hidden value=0.2 
                  name=stock_stamptax_rate_SB> <INPUT type=hidden value=0.05 
                  name=stock_balance_rate_SB> <INPUT type=hidden value=500 
                  name=stock_balance_limit_SB> 
                        <!--印花税-->
                        <INPUT type=hidden 
                  value=0 name=buyyhsbl> <INPUT type=hidden value=0.1 
                  name=sellyhsbl> <INPUT type=hidden value=10 name=ghfbl> <INPUT 
                  type=hidden value=0 name=jsfbl></TD>
                    </TR>
                    <TR> 
                      <TD 
                  width=144 height="25" align=right ><div align="left">计算项目：</div></TD>
                      <TD width=250 height="25"> <INPUT id=amode1 onclick="setamode('1')" 
                  type=radio CHECKED value=1 name=amode> <LABEL 
                  for=amode1>计算投资损益</LABEL> <INPUT id=amode2 
                  onclick="setamode('2')" type=radio value=2 name=amode> <LABEL 
                  for=amode2> 计算保本卖出价格</LABEL></TD>
                    </TR>
                    <TR> 
                      <TD height="25" align=right style="PADDING-TOP: 2px"><div align="left">交易对象：</div></TD>
                      <TD height="25"> <INPUT id=cmode1 onclick="setable('HA');" type=radio 
                  CHECKED value=HA name=cmode> <LABEL for=cmode1>上海A股</LABEL> 
                        <INPUT id=cmode2 onclick="setable('HB');" type=radio value=HB 
                  name=cmode> <LABEL for=cmode2>上海B股</LABEL> <INPUT id=cmode3 
                  onclick="setable('SA');" type=radio value=SA name=cmode> <LABEL for=cmode3>深圳A股</LABEL> 
                        <INPUT id=cmode4 
                  onclick="setable('SB');" type=radio value=SB name=cmode> <LABEL for=cmode4>深圳B股</LABEL></TD>
                    </TR>
                    <TR> 
                      <TD height="25" align=right style="PADDING-TOP: 2px"><div align="left">股票买入价格：</div></TD>
                      <TD height="25" id=tddrawsum> <INPUT name=mrjg class="inputBox" style="TEXT-ALIGN: right" 
                  size=10 maxLength=20 validPat="numberPat" message="股票买入价格"> <LABEL id=bzdw1>元</LABEL></TD>
                    </TR>
                    <TR> 
                      <TD height="25" align=right style="PADDING-TOP: 2px"><div align="left">股票买入数量：</div></TD>
                      <TD height="25" id=tddrawsum> <INPUT name=mrsl class="inputBox" style="TEXT-ALIGN: right" 
                  size=10 maxLength=20 validPat="numberPat" message="股票买入数量">
                        股</TD>
                    </TR>
                    <TR><SPAN id=sp_yjbl style="DISPLAY: block"> 
                      <TD height="23" align=right style="PADDING-TOP: 2px">
<div align="left">佣金比率：</div></TD>
                      <TD height="23" id=tddrawsum> 
                        <INPUT name=yjbl class="inputBox" style="TEXT-ALIGN: right" 
                  size=10 maxLength=20 validPat="ratePat" message="佣金比率">
                        %</TD>
                      </SPAN></TR>
                    <TR><SPAN id=Label4> 
                      <TD height="25" align=right style="PADDING-TOP: 2px"><div align="left">持有期间获得现金股利：</div></TD>
                      <TD height="25" id=tddrawsum> <INPUT name=xjgl class="inputBox" style="TEXT-ALIGN: right" 
                  size=10 maxLength=20 message="现金股利" 
                  validpat="ratePat"> <LABEL id=bzdw2> 元</LABEL></TD>
                      </SPAN></TR>
                    <TR> 
                      <TD height="25" align=right style="PADDING-TOP: 2px"><div align="left">持有期间获得股票股利：</div></TD>
                      <TD height="25" id=tddrawsum> <INPUT name=gpgl class="inputBox" style="TEXT-ALIGN: right" 
                  size=10 maxLength=20 validPat="ratePat" message="股票股利">
                        股</TD>
                    </TR>
                    <TR> 
                      <TD height="25" align=right style="PADDING-TOP: 2px"><div align="left">股票卖出价格：</div></TD>
                      <TD height="25" id=tddrawsum> <INPUT name=mcjg class="inputBox" style="TEXT-ALIGN: right" 
                  size=10 maxLength=20 message="卖出价格"> <LABEL 
              id=bzdw3>元</LABEL></TD>
                    </TR>
                    <TR> 
                      <TD height="25"></TD>
                      <TD height="25"><IMG style="CURSOR: hand" onclick="return result();" 
                  height=19 src="${base}/static/images/calbt.gif" 
                  width=47 name=Submit></TD>
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
              <TD ><TABLE width="312" 
              cellSpacing=0 class=zhengwen>
                  <TBODY>
                    <TR> 
                      <TD 
                  width=140 height="25" align=right ><div align="left">买入成本：</div></TD>
                      <TD width="98" height="25" id=tddrawsum> <INPUT name=mrcb disabled class="inputBox" style="TEXT-ALIGN: right" size=10 
                  maxLength=20 keyField="readOnly"> <LABEL 
                  id=bzdw4>元</LABEL></TD>
                    </TR>
                    <TR> 
                      <TD 
                  width=140 height="25" align=right ><div align="left">卖出成本：</div></TD>
                      <TD height="25"> <INPUT name=mccb disabled class="inputBox" style="TEXT-ALIGN: right" 
                  size=10 maxLength=20 keyField="readOnly"> <LABEL 
                  id=bzdw5>元</LABEL></TD>
                    </TR>
                    <TR> 
                      <TD 
                  width=140 height="25" align=right ><div align="left">交易税费合计：</div></TD>
                      <TD height="25"> <INPUT name=cbhj disabled class="inputBox" style="TEXT-ALIGN: right" 
                  size=10 maxLength=20 keyField="readOnly"> <LABEL 
                  id=bzdw6>元</LABEL></TD>
                    </TR>
                    <TR> 
                      <TD 
                  width=140 height="25" align=left ><div align="left">投资该只股票的损益：</div></TD>
                      <TD height="25"> <INPUT name=sy disabled class="inputBox" style="TEXT-ALIGN: right" 
                  size=10 maxLength=20 keyField="readOnly"> <LABEL 
                id=bzdw7>元</LABEL></TD>
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
        </TABLE></td>
</tr>

</table>
</form>
</body>
<#include "/template/foot.ftl"/>