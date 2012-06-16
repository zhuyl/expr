<#include "/template/head.ftl"/>
<script language="JavaScript" src="${base}/static/scripts/financeTool/base.js" charset="gb2312"></script>
<BODY LEFTMARGIN="0" TOPMARGIN="0">
    <FORM name=finMan onsubmit="Asset(this);return false;">
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCFF" style="border-collapse:collapse;" >
  <tr> 
    <td height="23" background="${base}/static/images/titlebg.gif"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
            
          <td><img src="${base}/static/images/titlearrow.gif" width="8" height="13"> <span class="title"><B>资产净值计算器</B></span></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td> <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
            
          <td height="25" class="explain"><B>资产净值计算器可以帮助计算您个人或家庭的资产净值</B></td>
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
              
            <TD>
			
			<TABLE width="446" cellSpacing=0 >
                <TBODY>
                  <TR class="zhengwen"> 
                    <TD height=25><B>流动性资产</B></TD>
                  </TR>
                  <TR class="zhengwen"> 
                    <TD 
                  width=141 height="25" align=right style="PADDING-TOP: 2px"><div align="left">流动性资产总值（元）：</div></TD>
                    <TD width=299 height="25"> <INPUT 
name=a class="inputBox" style="WIDTH: 120px" size=12></TD>
                  </TR>
                  <TR class="zhengwen"> 
                    <TD height="25" align=right style="PADDING-TOP: 2px"><div align="left">短期负债（元）：</div></TD>
                    <TD height="25"> <INPUT name=b class="inputBox" style="WIDTH: 120px" size=12></TD>
                  </TR>
                  <TR class="zhengwen"> 
                    <TD height=25><div align="left"><B>投资性资产</B></div></TD>
                  </TR>
                  <TR class="zhengwen"> 
                    <TD height="25" align=right style="PADDING-TOP: 2px"><div align="left">投资性资产总值（元）：</div></TD>
                    <TD height="25"> <INPUT name=c class="inputBox" style="WIDTH: 120px" size=12></TD>
                  </TR>
                  <TR class="zhengwen"> 
                    <TD height="25" align=right style="PADDING-TOP: 2px"><div align="left">长期借贷总值（元）：</div></TD>
                    <TD height="25"> <INPUT name=d class="inputBox" style="WIDTH: 120px" size=12></TD>
                  </TR>
                  <TR class="zhengwen"> 
                    <TD height="25"></TD>
                    <TD height="25"> <INPUT name="submit" type=submit style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BACKGROUND-IMAGE: url(${base}/static/images/calbt.gif); BORDER-LEFT: 0px; WIDTH: 47px; CURSOR: hand; BORDER-BOTTOM: 0px; HEIGHT: 19px" value=" "></TD>
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
              <TD class=zhengwen vAlign=top height=25><TABLE cellSpacing=0>
                <TBODY>
                  <TR class="zhengwen"> 
                    <TD 
                  width=162 height="25"><div align="left">流动性资产净值（元）：</div></TD>
                    <TD width=400 height="25"> <INPUT 
name=e class="inputBox" style="WIDTH: 120px" size=12></TD>
                  </TR>
                  <TR class="zhengwen"> 
                    <TD height="25" ><div align="left">投资性资产净值（元）：</div></TD>
                    <TD height="25"> <INPUT name=f class="inputBox" style="WIDTH: 120px" size=12 readonly></TD>
                  </TR>
                  <TR class="zhengwen"> 
                    <TD height="25"><div align="left">您的个人资产总值（元）：</div></TD>
                    <TD height="25"> <INPUT name=m class="inputBox" style="WIDTH: 120px" size=12 readonly></TD>
                  </TR>
                  <TR class="zhengwen"> 
                    <TD height="25" ><div align="left">您的个人借贷总值（元）：</div></TD>
                    <TD height="25"> <INPUT name=n class="inputBox" style="WIDTH: 120px" size=12 readonly></TD>
                  </TR>
                  <TR class="zhengwen"> 
                    <TD height="25" ><div align="left">您的个人资产净值（元）：</div></TD>
                    <TD height="25"> <INPUT name=o class="inputBox" style="WIDTH: 120px" size=12 readonly></TD>
                  </TR>
                  <TR class="zhengwen"> 
                    <TD height="25" colSpan=2 >您的个人资产总值中，流动性资产占 
                      <!--a/(a+c)*100%-->
                      　　 <INPUT name=g class="inputBox" 
                  size=6 readOnly>
                      %，投资性资产占 
                      <!--c/(a+c)*100%-->
                      　　 <INPUT 
                  name=h class="inputBox" 
                  size=6 readOnly>
                      %。<BR>
                      您的个人借贷总值中，短期负债占 
                      <!--b/(b+d)*100%-->
                      　　　 <INPUT name=i class="inputBox" size=6 
                  readOnly>
                      %，长期借贷占 
                      <!--d/(b+d)*100%-->
                      　　　 <INPUT name=j class="inputBox" size=6 
                  readOnly>
                      %。<BR>
                      您的个人资产净值中，流动性资产净值占 
                      <!--(a-b)/(a+c-b-d)*100%-->
                      <input 
                  name=k class="inputBox" size=6 
                  readonly>
                      %，投资性资产净值占 
                      <!--(c-d)/(a+c-b-d)*100%-->
                      <INPUT name=l class="inputBox" 
                  size=6 readOnly>
                      %。 </TD>
                  </TR>
                </TBODY>
              </TABLE> </TD>
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
function Asset(formObj){
	if(!CheckElem(formObj.elements["a"], "流动性资产总值")) return false;
	if(!CheckElem(formObj.elements["b"], "短期负债")) return false;
	if(!CheckElem(formObj.elements["c"], "投资性资产总值")) return false;
	if(!CheckElem(formObj.elements["d"], "长期借贷总值")) return false;

	var a = parseFloat(formObj.elements["a"].value);
	var b = parseFloat(formObj.elements["b"].value);
	var c = parseFloat(formObj.elements["c"].value);
	var d = parseFloat(formObj.elements["d"].value);

	formObj.elements["e"].value = Format(a-b);
	formObj.elements["f"].value = Format(c-d);
	formObj.elements["g"].value = Format(a/(a+c)*100);
	formObj.elements["h"].value = Format(c/(a+c)*100);
	formObj.elements["i"].value = Format(b/(b+d)*100);
	formObj.elements["j"].value = Format(d/(b+d)*100);
	formObj.elements["k"].value = Format((a-b)/(a+c-b-d)*100);
	formObj.elements["l"].value = Format((c-d)/(a+c-b-d)*100);
	formObj.elements["m"].value = Format(a+c);
	formObj.elements["n"].value = Format(b+d);
	formObj.elements["o"].value = Format(a+c-b-d);

	CheckTextBox(formObj);
}
//-->
</SCRIPT>
      </body>
<#include "/template/foot.ftl"/>