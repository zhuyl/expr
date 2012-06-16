<#include "/template/head.ftl"/>
<script language="JavaScript" src="${base}/static/scripts/financeTool/base.js" charset="gb2312"></script>

<BODY LEFTMARGIN="0" TOPMARGIN="0">
  <FORM name=finMan >
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCFF" style="border-collapse:collapse;" >
  <tr> 
    <td height="23" background="${base}/static/images/titlebg.gif"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
            <td><img src="${base}/static/images/titlearrow.gif" width="8" height="13"> <span class="title"><B>理财规划计算器</B></span></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td> <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
            <td height="25" class="explain"><B>理财规划计算器可以帮您筹划日常生活的理财</B></td>
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
              <TD><TABLE cellSpacing=0>
                  <TBODY>
                    <TR class="zhengwen"> 
                      <TD 
                  width=134 height="25" align=right  ><div align="left">您打算近期做的事：</div></TD>
                      <TD width=200 height="25"> <SELECT style="WIDTH: 120px;font-size:12px;" 
                  onchange="if(this.value=='other') GetObj('hiddenSpan').style.display='block';else GetObj('hiddenSpan').style.display='none'" 
                  name=target>
                          <OPTION value=旅游 selected>旅游</OPTION>
                          <OPTION 
                    value=准备婚礼>准备婚礼</OPTION>
                          <OPTION value=购置钢琴>购置钢琴</OPTION>
                          <OPTION value=探亲>探亲</OPTION>
                          <OPTION 
                  value=other>其他</OPTION>
                        </SELECT> <SPAN id=hiddenSpan 
                  style="DISPLAY: none"> 
                        <INPUT 
                name=otherTarget class="inputBox" size=12>
                        </SPAN></TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD height="25" align=right ><div align="left">时间期限：</div></TD>
                      <TD height="25"> <INPUT name=a class="inputBox" style="WIDTH: 120px" size=12>
                        月</TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD height="25" align=right ><div align="left">需要的金额：</div></TD>
                      <TD height="25"> <INPUT name=b class="inputBox" style="WIDTH: 120px" size=12>
                        元</TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD height="25" align=right  ><div align="left">已准备了金额：</div></TD>
                      <TD height="25"> <INPUT name=c class="inputBox" style="WIDTH: 120px" size=12>
                        元</TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD height="25" align=right  ><div align="left">投资年收益率：</div></TD>
                      <TD height="25"> <INPUT 
              name=d class="inputBox" style="WIDTH: 120px" size=12>
                        %</TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD height="25">&nbsp; </TD>
                      <TD height="25"><img id=btnCalc
                  style="CURSOR: hand" onClick="FinMan(this);"  tabindex=7 
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
              <TD class=p10 vAlign=top height=25><TABLE width="700" 
              cellSpacing=0 class=zhengwen >
                  <TBODY>
                    <TR> 
                      <TD 
                  width=68 height="25"   align=right >
<div align="left">您已经有 </div></TD>
                      <TD width=626 height="25">
<INPUT 
                  name=c2 disabled class="inputBox" style="WIDTH: 120px" size=12 >
                        元了</TD>
                    </TR>
                    <TR> 
                      <TD height="25"   align=right>
<div align="left">现在再投资</div></TD>
                      <TD height="25">
<INPUT 
name=m disabled class="inputBox" style="WIDTH: 120px" size=12>
                        元</TD>
                    </TR>
                    <TR> 
                      <TD height="25"   align=right>
<div align="left">就能实现您</div></TD>
                      <TD height="25">
<INPUT 
                  name=a2 disabled class="inputBox" style="WIDTH: 120px" size=12>
                        月后<SPAN id=myTarget></SPAN>的愿望了。</TD>
                    </TR>
                    <!-- 公式：m(1+d/12)^(a-1)=b-c -->
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
      <SCRIPT language=javascript type=text/javascript charset="gb2312">
<!--
//if(typeof rateDemand != "undefined") document.forms["finMan"].elements["d"].value = rateDemand;
function FinMan(formObj){
	if(!CheckElem(document.forms["finMan"].elements["a"], "时间期限")) return false;
	if(!CheckElem(document.forms["finMan"].elements["b"], "需要的金额")) return false;
	if(!CheckElem(document.forms["finMan"].elements["c"], "已准备金额")) return false;
	if(!CheckElem(document.forms["finMan"].elements["d"], "投资年收益率")) return false;
	document.forms["finMan"].elements["a2"].value = document.forms["finMan"].elements["a"].value;
	document.forms["finMan"].elements["c2"].value = document.forms["finMan"].elements["c"].value;
	document.forms["finMan"].elements["m"].value = Format((document.forms["finMan"].elements["b"].value - document.forms["finMan"].elements["c"].value)/Math.pow(1+document.forms["finMan"].elements["d"].value/100/12, document.forms["finMan"].elements["a"].value-1));

	CheckTextBox(document.forms["finMan"]);

	GetObj("myTarget").innerText = (document.forms["finMan"].target.value == "other")?document.forms["finMan"].otherTarget.value:document.forms["finMan"].target.value
}
//-->
</SCRIPT>
</body>
<#include "/template/foot.ftl"/>