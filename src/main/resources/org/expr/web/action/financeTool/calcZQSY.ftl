<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/base.js" charset="gb2312"></script>
<BODY LEFTMARGIN="0" TOPMARGIN="0">

<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCFF" style="border-collapse:collapse;" >
  <tr> 
    <td height="23" background="${base}/static/images/titlebg.gif"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
        <td height="23" background="${base}/static/images/titlebg.gif"><img src="${base}/static/images/titlearrow.gif" width="8" height="13"> 
          <span class="title">债券收益计算器</span></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td>
	 <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
            <td height="25" class="explain">债券收益计算器可以帮您计算您手中债券的收益率</td>
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
            <TD height="25"><TABLE cellSpacing=0 
width=476>
                <TBODY>
                  <TR> 
                    <TD class="zhengwen">计算 
                      <SELECT name="select" onchange=ChgItem(this.value) style="font-size:12px;">
                        <OPTION 
                    value=c0 selected>债券购买收益率</OPTION>
                        <OPTION 
                    value=c1>债券出售收益率</OPTION>
                        <OPTION 
                  value=c2>债券持有期间收益率</OPTION>
                      </SELECT>
                      <BR>
                      <BR>
                      <!--（变量
发行价格<input type=text name="t" size=12>元
债券面值<input type=text name="a" size=12>元
买入价格<input type=text name="b" size=12>元
卖出价格<input type=text name="c" size=12>元
持有时间<input type=text name="d" size=12>天
到期时间<input type=text name="f" size=12>天
票面年利率<input type=text name="i" size=12>
-->
                      <DIV id=c0 style="DISPLAY: none"> 
                        <FORM name=cal0 
                  onsubmit="Cal0(this);return false;">
                          <B>债券购买收益率计算器</B><BR>
                          债券面值：　
                          <INPUT name=a class="inputBox" 
                  size=12>
                          元<BR>
                          买入价格：　
                          <INPUT 
                  name=b class="inputBox" size=12>
                          元<BR>
                          到期时间：　
                          <INPUT name=f class="inputBox" size=12>
                          天<BR>
                          票面年利率：
                          <INPUT name=i class="inputBox" 
                  size=12>
                          %<BR>
                          <BR>
                          <INPUT name="submit" type=submit style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BACKGROUND-IMAGE: url(${base}/static/images/calbt.gif); BORDER-LEFT: 0px; WIDTH: 47px; CURSOR: hand; BORDER-BOTTOM: 0px; HEIGHT: 19px" value=" ">
                          <BR>
                          <TABLE cellSpacing=0 width=476>
                            <TBODY>
                              <TR> 
                                <TD class=zhengwen vAlign=bottom 
                      height=25><B>计算结果</B></TD>
                              </TR>
          <TR> 
            <TD height="1" background="${base}/static/images/dline.gif"></TD>
          </TR>
                            </TBODY>
                          </TABLE>
                          <BR>
                          债券购买收益率为：
                          <INPUT name=r class="inputBox" size=12 
                  readOnly>
                          %<BR>
                          <!--[a+a*I*f/365-b]/(b*f/365)*100%-->
                        </FORM>
                        <SCRIPT language=javascript type=text/javascript>
<!--
function Cal0(formObj){

	if(!CheckElem(formObj.elements["a"], "债券面值")) return false;
	if(!CheckElem(formObj.elements["b"], "买入价格")) return false;
	if(!CheckElem(formObj.elements["f"], "到期时间")) return false;
	if(!CheckElem(formObj.elements["i"], "票面年利率")) return false;

	var a = parseFloat(formObj.a.value);
	var b = parseFloat(formObj.b.value);
	var f = parseFloat(formObj.f.value);
	var i = parseFloat(formObj.i.value)/100;

	var r = (a+a*i*f/365-b)/(b*f/365);
	formObj.elements["r"].value = Format(r*100);
}
//-->
</SCRIPT>
                      </DIV>
                      <DIV id=c1 style="DISPLAY: none"> 
                        <FORM name=cal1 
                  onsubmit="Cal1(this);return false;">
                          <B>债券出售收益率计算器</B><BR>
                          发行价格：　
                          <INPUT name=t class="inputBox" 
                  size=12>
                          元<BR>
                          卖出价格：　
                          <INPUT 
                  name=c class="inputBox" size=12>
                          元<BR>
                          持有时间：　
                          <INPUT name=d class="inputBox" size=12>
                          天<BR>
                          票面年利率：
                          <INPUT name=i class="inputBox" 
                  size=12>
                          %<BR>
                          <BR>
                          <INPUT name="submit" type=submit style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BACKGROUND-IMAGE: url(${base}/static/images/calbt.gif); BORDER-LEFT: 0px; WIDTH: 47px; CURSOR: hand; BORDER-BOTTOM: 0px; HEIGHT: 19px" value=" ">
                          <BR>
                          <TABLE cellSpacing=0 width=476>
                            <TBODY>
                              <TR> 
                                <TD class=zhengwen height=25><B>计算结果</B></TD>
                              </TR>
          <TR> 
            <TD height="1" background="${base}/static/images/dline.gif"></TD>
          </TR>
                            </TBODY>
                          </TABLE>
                          <BR>
                          债券出售收益率为：
                          <INPUT name=r class="inputBox" size=12 
                  readOnly>
                          %<BR>
                          <!--（c-t+d*t*i/365）/(t*d/365)*100%-->
                        </FORM>
                        <SCRIPT language=javascript type=text/javascript>
<!--
function Cal1(formObj){

	if(!CheckElem(formObj.elements["t"], "发行价格")) return false;
	if(!CheckElem(formObj.elements["c"], "卖出价格")) return false;
	if(!CheckElem(formObj.elements["d"], "持有时间")) return false;
	if(!CheckElem(formObj.elements["i"], "票面年利率")) return false;

	var t = parseFloat(formObj.t.value);
	var c = parseFloat(formObj.c.value);
	var d = parseFloat(formObj.d.value);
	var i = parseFloat(formObj.i.value)/100;

	var r = (c-t+d*t*i/365)/(t*d/365);
	formObj.elements["r"].value = Format(r*100);
}
//-->
</SCRIPT>
                      </DIV>
                      <DIV id=c2 style="DISPLAY: none"> 
                        <FORM name=cal2 
                  onsubmit="Cal2(this);return false;">
                          <B>债券持有期间收益率计算器</B><BR>
                          债券面值：　
                          <INPUT name=a class="inputBox" 
                  size=12>
                          元<BR>
                          买入价格：　
                          <INPUT 
                  name=b class="inputBox" size=12>
                          元<BR>
                          卖出价格：　
                          <INPUT name=c class="inputBox" size=12>
                          元<BR>
                          持有时间：　
                          <INPUT name=d class="inputBox" 
                  size=12>
                          天<BR>
                          票面年利率：
                          <INPUT name=i class="inputBox" size=12>
                          %<BR>
                          <BR>
                          <INPUT name="submit" type=submit style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BACKGROUND-IMAGE: url(${base}/static/images/calbt.gif); BORDER-LEFT: 0px; WIDTH: 47px; CURSOR: hand; BORDER-BOTTOM: 0px; HEIGHT: 19px" value=" ">
                          <BR>
                          <TABLE cellSpacing=0 width=476>
                            <TBODY>
                              <TR> 
                                <TD class=zhengwen style="PADDING-BOTTOM: 7px" vAlign=bottom 
                      height=25><B>计算结果</B></TD>
                              </TR>
          <TR> 
            <TD height="1" background="${base}/static/images/dline.gif"></TD>
          </TR>
                            </TBODY>
                          </TABLE>
                          <BR>
                          债券持有期间收益率为：
                          <INPUT name=r class="inputBox" size=12 
                  readOnly>
                          %<BR>
                          <!--(c-b+a*I*d/365)/(b*d/365)*100%-->
                        </FORM>
                        <SCRIPT language=javascript type=text/javascript>
<!--
function Cal2(formObj){

	if(!CheckElem(formObj.elements["a"], "债券面值")) return false;
	if(!CheckElem(formObj.elements["b"], "买入价格")) return false;
	if(!CheckElem(formObj.elements["c"], "卖出价格")) return false;
	if(!CheckElem(formObj.elements["d"], "持有时间")) return false;
	if(!CheckElem(formObj.elements["i"], "票面年利率")) return false;

	var a = parseFloat(formObj.a.value);
	var b = parseFloat(formObj.b.value);
	var c = parseFloat(formObj.c.value);
	var d = parseFloat(formObj.d.value);
	var i = parseFloat(formObj.i.value)/100;

	var r = (c-b+a*i*d/365)/(b*d/365);
	formObj.elements["r"].value = Format(r*100);
}
function ChgItem(itemName){
	for(var i=0;i<3;i++){
		GetObj("c"+i).style.display = "none";
	}
	GetObj(itemName).style.display = "block";
}
ChgItem("c0");
//-->
</SCRIPT>
                      </DIV></TD>
                  </TR>
                </TBODY>
              </TABLE> </TD>
          </TR>
          <TR> 
            <TD height="1" background="${base}/static/images/dline.gif"></TD>
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

</body>
<#include "/template/foot.ftl"/>