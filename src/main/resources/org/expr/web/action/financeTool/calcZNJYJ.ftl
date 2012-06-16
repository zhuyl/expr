<#include "/template/head.ftl"/>
<script language="JavaScript" src="${base}/static/scripts/financeTool/base.js" charset="gb2312"></script>

<BODY LEFTMARGIN="0" TOPMARGIN="0">
    <FORM name=eduFun >
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCFF" style="border-collapse:collapse;" >
  <tr> 
    <td height="23" background="${base}/static/images/titlebg.gif"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
            <td><img src="${base}/static/images/titlearrow.gif" width="8" height="13"> <span class="title"><B>子女教育基金计算器</B></span></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td> <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
            <td height="25" class="explain"><B>子女教育基金计算器可以帮您计算：准备小孩上大学的每年投资额</B></td>
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
              <TD><TABLE class=zhengwen style="MARGIN-LEFT: 48px" cellSpacing=0 
width=476>
                  <TBODY>
                    <TR> 
                      <TD>您或您小孩还有多少年上大学：
                        <SELECT name=a style="font-size:12px;">
                          <SCRIPT language=javascript type=text/javascript>
	<!--
	for(var i=1;i<=20;i++){
	document.writeln("<option value='"+i+"'>"+i+"</option>");
	}
	//-->
	</SCRIPT>
                        </SELECT>
                        <!--a [下拉1-20]-->
                        <BR>
                        <BR>
                        预计读大学的学年：　　　　　
                        <SELECT name=b style="font-size:12px;">
                          <SCRIPT language=javascript type=text/javascript>
	<!--
	for(var i=1;i<=6;i++){
	document.writeln("<option value='"+i+"'"+(i==4?" selected":"")+">"+i+"</option>");
	}
	//-->
	</SCRIPT>
                        </SELECT>
                        <!--b[下拉1-6]-->
                        <BR>
                        <BR>
                        每年大学费用：　　　　　　　
                        <SELECT 
                  onchange=document.eduFun.c.value=document.eduFun.cSlt.value 
                  name=cSlt style="font-size:12px;">
                          <OPTION value=5000>国内大专</OPTION>
                          <OPTION 
                    value=8000 selected>国内大学</OPTION>
                          <OPTION 
                    value=80000>加拿大</OPTION>
                          <OPTION value=150000>美国</OPTION>
                          <OPTION value=100000>英国</OPTION>
                          <OPTION 
                    value=80000>澳洲</OPTION>
                          <OPTION 
                  value=80000>其他</OPTION>
                        </SELECT> <INPUT class="inputBox" style="HEIGHT: 20px" 
                  size=12 name=c>
                        （可手动输入）<BR>
                        <BR>
                        当前年利率：　　　　　　　　
                        <INPUT class="inputBox" size=12  name=i>
                        %
                        <!--i[默认银行定期存款一年利率]-->
                        <BR>
                        <BR>
                        <img id=btnCalc
                  style="CURSOR: hand" onClick="EduFun(this.form);return false;"  tabindex=7 
                  height=19 src="${base}/static/images/calbt.gif" 
                  width=47 name=btnCalc > 
                        <BR></TD>
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
              <TD class=zhengwen vAlign=top height=25>
                <!-- 结果 begin -->
                <BR>
            <DIV class=cBlue id=result 
            style="MARGIN-LEFT: 48px; WIDTH: 500px">计算得出...</DIV><!-- 结果 end --><BR></TD>
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
      </body>
<SCRIPT language=javascript type=text/javascript>
<!--
document.eduFun.c.value=document.eduFun.cSlt.value;
//document.eduFun.i.value = rate12;
function EduFun(formObj){
	if(!CheckElem(document.eduFun.elements["c"], "每年大学费用")) return false;
	if(!CheckElem(document.eduFun.elements["i"], "当前年利率")) return false;

	var a = parseFloat(document.eduFun.a.value);
	var b = parseFloat(document.eduFun.b.value);
	var c = parseFloat(document.eduFun.c.value);
	var i = parseFloat(document.eduFun.i.value)/100;

	GetObj("result").innerHTML = "结果：为顺利完成 <b style='color:#f00;'>"+b+"</b> 年深造，您需要从现在起，每年为你或你的小孩投资 <b style='color:#f00;'>"+ Format(b*c*i/(Math.pow((1+i),a)-1)) +"</b> 元，共投资 <b style='color:#f00;'>"+a+"</b> 年。";
	//bci/[(1+i)^a-1]

	CheckTextBox(document.eduFun);
}
//-->
</SCRIPT>
<#include "/template/foot.ftl"/>