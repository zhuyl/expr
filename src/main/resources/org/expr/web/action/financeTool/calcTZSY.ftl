<#include "/template/head.ftl"/>
<script language="JavaScript" src="${base}/static/scripts/financeTool/base.js" charset="gb2312"></script>
<BODY LEFTMARGIN="0" TOPMARGIN="0">
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCFF" style="border-collapse:collapse;" >
  <tr> 
    <td height="23" background="${base}/static/images/titlebg.gif"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
            <td><img src="${base}/static/images/titlearrow.gif" width="8" height="13"> <span class="title"><B>投资收益计算器</B></span></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td> <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
            <td height="25" class="explain"><B>投资收益计算器可以帮您计算投资收益、投资年限和投资收益率</B></td>
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
                      <TD class="zhengwen">计算： 
                        <SELECT name="select" onchange=ChgItem(this.value) style="font-size:12px;">
                          <OPTION 
                    value=c0 selected>投资收益率</OPTION>
                          <OPTION 
                    value=c1>投资收益</OPTION>
                          <OPTION 
                value=c2>投资年限</OPTION>
                        </SELECT></TD>
                    </TR>
                  </TBODY>
                </TABLE></TD>
            </TR>
            <TR> 
              <TD height="25" align=left class="head"><TABLE width=100% border="0" cellpadding="0"  cellSpacing=0>
                  <TBODY>
                    <TR> 
                      <TD> <DIV id=c0 style="DISPLAY: none"> 
                              <FORM name=cal0  onsubmit="Cal0(this);return false;">
                          <p class="zhengwen"><B>投资收益率计算器</B><BR>
                            初始投资金额：　 
                            <INPUT name=a class="inputBox" 
                  size=12>
                            元<BR>
                            投资年限：　　　 
                            <INPUT name=b class="inputBox" size=12>
                            年<BR>
                            实现本金加收益： 
                            <input name=c class="inputBox" size=12>
                            元<BR>
                            <BR>
                            <INPUT name="submit" type=submit style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BACKGROUND-IMAGE: url(${base}/static/images/calbt.gif); BORDER-LEFT: 0px; WIDTH: 47px; CURSOR: hand; BORDER-BOTTOM: 0px; HEIGHT: 19px" value=" ">
                            <BR>
                          </p>
                          <TABLE width=100%>
                            <TBODY>
                              <TR> 
                                <TD class=zhengwen style="PADDING-BOTTOM: 7px" vAlign=bottom 
                      height=39><B>计算结果</B></TD>
                              </TR>
                                         <TR> 
              <TD height="1" background="${base}/static/images/dline.gif"></TD>
            </TR>
                            </TBODY>
                          </TABLE>
                          <p class="zhengwen">
                            结果 你的年平均收益率为 
                            <INPUT name=i class="inputBox" size=12 
                  readonly>
                            %<BR>
                            <!-- a(1+i)^b=c --></form>
                            <SCRIPT language=javascript type=text/javascript>
<!--
function Cal0(formObj){

	if(!CheckElem(formObj.elements["a"], "初始投资金额")) return false;
	if(!CheckElem(formObj.elements["b"], "投资年限")) return false;
	if(!CheckElem(formObj.elements["c"], "实现本金加收益")) return false;

	var a = parseFloat(formObj.a.value);
	var b = parseFloat(formObj.b.value);
	var c = parseFloat(formObj.c.value);
	//var i = parseFloat(formObj.i.value)/100;
//alert(Math.pow(c, 1/b))
	var i = Math.pow(c/a, 1/b) -1;
	formObj.elements["i"].value = Format(i*100);
}
//-->
</SCRIPT>
                          </p>
                        </DIV>
                        <DIV id=c1 style="DISPLAY: none"> 
						    <FORM name=cal1    onsubmit="Cal1(this);return false;">
                          <p class="zhengwen"><B>投资收益计算器</B><BR>
                            初始投资金额：　　 
                            <INPUT name=a class="inputBox" 
                  size=12>
                            元<BR>
                            投资年限：　　　　 
                            <INPUT 
                  name=b class="inputBox" size=12>
                            年<BR>
                            预期年投资收益率： 
                            <INPUT name=i class="inputBox" size=12>
                            %<BR>
                            <BR>
                            <INPUT name="submit" type=submit style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BACKGROUND-IMAGE: url(${base}/static/images/calbt.gif); BORDER-LEFT: 0px; WIDTH: 47px; CURSOR: hand; BORDER-BOTTOM: 0px; HEIGHT: 19px" value=" ">
                            <BR>
                          </p>
                          <TABLE width=100%>
                            <TBODY>
                              <TR> 
                                <TD class=zhengwen style="PADDING-BOTTOM: 7px" vAlign=bottom 
                      height=39><B>计算结果</B></TD>
                              </TR>
                                        <TR> 
              <TD height="1" background="${base}/static/images/dline.gif"></TD>
            </TR>
                            </TBODY>
                          </TABLE>
                          <p class="zhengwen"><BR>
                            您在 
                            <INPUT name=b2 class="inputBox" 
                  size=6 readonly>
                            年后，<BR>
                            投资收益为 
                            <INPUT name=d class="inputBox" size=12 readonly>
                            元 
                            <!-- a(1+I)^b-a -->
                            ，<BR>
                            本金与收益共为 
                            <INPUT 
                  name=c class="inputBox" size=12 readonly>
                            元 
                            <!-- a(1+I)^b --></form>
                            <SCRIPT language=javascript type=text/javascript>
<!--
function Cal1(formObj){

	if(!CheckElem(formObj.elements["a"], "初始投资金额")) return false;
	if(!CheckElem(formObj.elements["b"], "投资年限")) return false;
	if(!CheckElem(formObj.elements["i"], "预期年投资收益率")) return false;

	var a = parseFloat(formObj.a.value);
	var b = parseFloat(formObj.b.value);
	//var c = parseFloat(formObj.c.value);
	var i = parseFloat(formObj.i.value)/100;

	formObj.elements["b2"].value = b;
	var c = Math.pow((1+i), b) * a ;
	formObj.elements["c"].value = Format(c);
	formObj.elements["d"].value = Format(c-a);
}
//-->
</SCRIPT>
                          </p>
                        </DIV>
                        <DIV id=c2 style="DISPLAY: none"> 
						      <FORM name=cal2  onsubmit="Cal2(this);return false;">
                          <p class="zhengwen"><B>投资年限计算器</B><BR>
                            初始投资金额：　　　 
                            <INPUT name=a class="inputBox" 
                  size=12>
                            元<BR>
                            欲实现本金加收益共： 
                            <INPUT 
                  name=c class="inputBox" size=12>
                            元<BR>
                            预期年投资收益率：　 
                            <INPUT name=i class="inputBox" size=12>
                            %<BR>
                            <BR>
                            <INPUT name="submit" type=submit style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BACKGROUND-IMAGE: url(${base}/static/images/calbt.gif); BORDER-LEFT: 0px; WIDTH: 47px; CURSOR: hand; BORDER-BOTTOM: 0px; HEIGHT: 19px" value=" ">
                            <BR>
                          </p>
                          <TABLE width=100%>
                            <TBODY>
                              <TR> 
                                <TD class=zhengwen style="PADDING-BOTTOM: 7px" vAlign=bottom 
                      height=39><B>计算结果</B></TD>
                              </TR>
                <TR> 
              <TD height="1" background="${base}/static/images/dline.gif"></TD>
            </TR>
                            </TBODY>
                          </TABLE>
                          <p class="zhengwen"><BR>
                            你需要 
                            <INPUT name=b class="inputBox" 
                  size=6 readonly>
                            年才能达成目标<BR>
                            <!-- a(1+I)^b=c --></FORM>
                            <SCRIPT language=javascript type=text/javascript>
<!--
function Cal2(formObj){

	if(!CheckElem(formObj.elements["a"], "初始投资金额")) return false;
	if(!CheckElem(formObj.elements["c"], "欲实现本金加收益共")) return false;
	if(!CheckElem(formObj.elements["i"], "预期年投资收益率")) return false;

	var a = parseFloat(formObj.a.value);
	//var b = parseFloat(formObj.b.value);
	var c = parseFloat(formObj.c.value);
	var i = parseFloat(formObj.i.value)/100;

	var b = Math.log(c/a)/Math.log(1+i);
	formObj.elements["b"].value = Format(b);
}
//5^2=25
//alert(Math.log(25)/Math.log(5))//shoult be 2

function ChgItem(itemName){
	for(var i=0;i<3;i++){
		GetObj("c"+i).style.display = "none";
	}
	GetObj(itemName).style.display = "block";
}
ChgItem("c0");
//-->
</SCRIPT>
                          </p>
                        </DIV></TD>
                    </TR>
                  </TBODY>
                </TABLE></TD>
            </TR>
            <TR> 
              <TD class=zhengwen vAlign=top height=25>&nbsp; </TD>
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

      </body>
<#include "/template/foot.ftl"/>