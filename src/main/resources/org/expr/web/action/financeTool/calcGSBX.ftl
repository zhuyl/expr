<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/functionBX.js" charset="gb2312"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/calcBX.js" charset="gb2312"></script>

<BODY LEFTMARGIN="0" TOPMARGIN="0">
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCFF" style="border-collapse:collapse;" >
  <tr> 
    <td height="23" background="${base}/static/images/titlebg.gif"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td><img src="${base}/static/images/titlearrow.gif" width="8" height="13"> <span class="title"><B>工伤保险计算器</B></span></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td> <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="25" class="explain"><B>工伤保险计算器可以帮您计算今年您每月缴存的工伤保险金额</B></td>
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
            <TD><TABLE cellSpacing=0 
            cellPadding=0 width=651 border=0>
                <TBODY>
                  <TR> 
                    <TD  width=156 height="25" class=zhengwen>您上年度平均月工资：</TD>
                    <TD width=495 height="25"> <input type="text" name="pingJunGongZi" id="pingJunGongZi" value="" class="inputBox" style="width: 80px" /> 
                      <span class="zhengwen">元</span></TD>
                  </TR>
                  <TR> 
                    <TD height="25" class="zhengwen" >本市职工上年月平均工资：</TD>
                    <TD height="25" > <input type="text" name="zhiGongGongZi" id="zhiGongGongZi"  class="inputBox" style="width: 80px" /> 
                      <span class="zhengwen"> 元</span> </TD>
                  </TR>
                  <TR> 
                    <TD 
                  width=156 height="25" class=zhengwen>单位缴存比例:</TD>
                    <TD width=495 height="25" class="zhengwen">
<input type="text" name="danWeiBiLi" id="danWeiBiLi" class="inputBox" style="width: 80px" /> %(一般缴存比例为0.3%-1.5%)</TD>
                  </TR>
                  <TR> 
                    <TD height=25>&nbsp; </TD>
                    <TD height=25><img id=btnCalc
                  style="CURSOR: hand" onClick="GongShang();" tabindex=7 
                  height=19 src="${base}/static/images/calbt.gif" 
                  width=47 name=btnCalc ></TD>
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
            <TD ><TABLE width="81%"  border="0" cellpadding="0" cellspacing="0" >
                <TBODY>
                  <TR> 
                    <TD width="32%" height="25" align=left class=zhengwen >今年您每月缴存的工伤保险为: 
                    </TD>
                    <TD width="68%" align=left class=zhengwen ><input type="text" name="jiaoCun" id="jiaoCun" value="计算得出" disabled class="inputBox" style="width: 100px; text-align:right;" /> 元</TD>
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
              
            <TD valign="top" class="zhengwen">通过本计算器，可以根据您上年度平均月工资及您所在市职工上年度平均月工资与单位缴存比例计算出今年您每月缴存的工伤保险金额。</TD>
          </TR>
        </TBODY>
      </TABLE>
	</td>
  </tr>
</table>

</body>
<#include "/template/foot.ftl"/>