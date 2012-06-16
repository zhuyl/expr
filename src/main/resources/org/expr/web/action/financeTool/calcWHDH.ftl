<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/base.js" charset="gb2312"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/calc/forex_data.js" charset="gb2312"></script>

<SCRIPT language=javascript type=text/javascript>

<!--
function ForExc(formObj){
	if(!CheckElem(formObj.elements["amount"], "卖出金额")) return false;
	var amount = formObj.elements["amount"].value;
	culRate();
	if(!CheckElem(formObj.elements["rate"], "汇率")) return false;
	var rate = parseFloat(formObj.elements["rate"].value);
	formObj.elements["result"].value = Format(amount * rate);
}

function culRate(){
	var formObj = document.forExc;
	var rateSell = parseFloat(formObj.elements["sell"].value);//按银行买入汇率
	var rateBuy = parseFloat(formObj.elements["buy"].value);//按银行卖出汇率
	var rate = rateSell / rateBuy;
	formObj.elements["rate"].value = Math.round(rate*10000)/10000;
}

function genRate(type){
//alert(lists.length)
	for(var i=0;i<16;i++){
		document.forExc.sell.options[i].value = (parseInt(type)==0)?(parseFloat(lists[i+1][parseInt(type)])/100):((lists[i+1][parseInt(type)]=="")?(parseFloat(lists[i+1][0])/100):(parseFloat(lists[i+1][parseInt(type)])/100));
		document.forExc.buy.options[i].value = parseFloat(lists[i+1][2])/100;
	}
	culRate();
}
//-->
</SCRIPT>
<BODY LEFTMARGIN="0" TOPMARGIN="0">
  <FORM name=forExc onsubmit="ForExc(this);return false;">
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCFF" style="border-collapse:collapse;" >
  <tr> 
    <td height="23" background="${base}/static/images/titlebg.gif"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
            
            
            <td><img src="${base}/static/images/titlearrow.gif" width="8" height="13"> <span class="title"><B>外汇买卖（兑换）计算器</B></span></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td> <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
            
            
            <td height="25" class="explain"><B>外汇买卖（兑换）计算器可以帮助您计算能够兑换或买卖外币的数额</B></td>
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
              
              <TD><TABLE class=cBlue style="MARGIN-LEFT: 48px" cellSpacing=0 
width=476>
                  <TBODY>
                    <TR> 
                      <TD class="zhengwen">钞汇选择： 
                        <INPUT onclick=genRate(this.value) type=radio value=1 
                  name=type>
                        钞 
                        <INPUT onclick=genRate(this.value) type=radio 
                  CHECKED value=0 name=type>
                        汇<BR>
                        卖　　出：
                        <INPUT 
                  name=amount class="inputBox" size=12> <SELECT onchange=culRate(); name=sell style="font-size:12px;">
                          <OPTION 
                    value="" selected>美元</OPTION>
                          <OPTION value="">欧元</OPTION>
                          <OPTION value="">英镑</OPTION>
                          <OPTION value="">日元</OPTION>
                          <OPTION value="">港币</OPTION>
                          <OPTION value="">加拿大元</OPTION>
                          <OPTION value="">新西兰元</OPTION>
                          <OPTION 
                    value="">新加坡元</OPTION>
                          <OPTION value="">瑞士法郎</OPTION>
                          <OPTION value="">瑞典克朗</OPTION>
                          <OPTION value="">泰国铢</OPTION>
                          <OPTION value="">挪威克朗</OPTION>
                          <OPTION value="">澳门元</OPTION>
                          <OPTION value="">澳大利亚元</OPTION>
                          <OPTION 
                    value="">丹麦克朗</OPTION>
                          <OPTION value="">菲律宾比索</OPTION>
                          <OPTION value="">人民币</OPTION>
                        </SELECT>
                        <BR>
                        汇　　率：
                        <INPUT name=rate class="inputBox" 
                  style="BORDER-RIGHT: #666 1px solid; BORDER-TOP: #666 1px solid; BORDER-LEFT: #666 1px solid; BORDER-BOTTOM: #666 1px solid; BACKGROUND-COLOR: #f5f5f5" 
                  title=计算得出 size=12 
                  readOnly> <INPUT name="checkbox" 
                  type=checkbox 
                  onclick="document.forExc.rate.readOnly = (!this.checked)?true:false;document.forExc.rate.style.backgroundColor=(!this.checked)?'#f5f5f5':'';document.forExc.rate.style.border=(!this.checked)?'1px solid #666':'1px solid #49B8E3'">
                        手动<BR>
                        买入币种：
                        <SELECT onchange=culRate(); name=buy style="font-size:12px;">
                          <OPTION value="">美元</OPTION>
                          <OPTION value="">欧元</OPTION>
                          <OPTION value="">英镑</OPTION>
                          <OPTION value="">日元</OPTION>
                          <OPTION value="">港币</OPTION>
                          <OPTION value="">加拿大元</OPTION>
                          <OPTION value="">新西兰元</OPTION>
                          <OPTION 
                    value="">新加坡元</OPTION>
                          <OPTION value="">瑞士法郎</OPTION>
                          <OPTION value="">瑞典克朗</OPTION>
                          <OPTION value="">泰国铢</OPTION>
                          <OPTION value="">挪威克朗</OPTION>
                          <OPTION value="">澳门元</OPTION>
                          <OPTION value="">澳大利亚元</OPTION>
                          <OPTION 
                    value="">丹麦克朗</OPTION>
                          <OPTION value="">菲律宾比索</OPTION>
                          <OPTION value=1 selected>人民币</OPTION>
                        </SELECT>
                        <BR>
                        <div> 
                          <div align="center">
                            <INPUT name="submit" type=submit style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BACKGROUND-IMAGE: url(${base}/static/images/calbt.gif); BORDER-LEFT: 0px; WIDTH: 47px; CURSOR: hand; BORDER-BOTTOM: 0px; HEIGHT: 19px" value=" ">
                          </div>
                        </div></TD>
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
              <TD class=zhengwen vAlign=top height=25><TABLE class=cBlue style="MARGIN-LEFT: 48px" cellSpacing=0 
width=476>
                  <TBODY>
                    <TR> 
                      <TD class="zhengwen">买入金额： 
                        <INPUT name=result class="inputBox" 
                  title=结果显示区 size=12 
                  readOnly></TD>
                    </TR>
                  </TBODY>
                </TABLE></TD>
            </TR>
            <TR> 
          
            <TR> 
              <TD height="25" align=left class="head">说明</TD>
            </TR>
            <TR> 
              <TD height="1" background="${base}/static/images/dline.gif"></TD>
            </TR>
            <TR> 
              <TD valign="top" class="zhengwen"><P>&nbsp;</P>
                <P>&nbsp; </P>
                </TD>
            </TR>
          </TBODY>
        </TABLE>
	</td>
  </tr>
</table>
</form>
<SCRIPT language=javascript type=text/javascript>
<!--
genRate(0);
//-->
</SCRIPT>
</body>
<#include "/template/foot.ftl"/>