<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/functionBX.js" charset="gb2312"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/calcBX.js" charset="gb2312"></script>

<BODY LEFTMARGIN="0" TOPMARGIN="0">
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCFF" style="border-collapse:collapse;" >
  <tr> 
    <td height="23" background="${base}/static/images/titlebg.gif"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td><img src="${base}/static/images/titlearrow.gif" width="8" height="13"> <span class="title"><B>退休养老保险金计算器</B></span></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td> <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="25" class="explain"><B>退休养老保险金计算器可以帮您计算退休时每月领取的养老金和目前应准备的养老投入</B></td>
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
            cellPadding=0 width=516 border=0>
                <TBODY>
                  <TR> 
                    <TD  width=144 height="25" class=zhengwen>您上年度平均月工资：</TD>
                    <TD width=200 height="25"> <input type="text" name="pingJunGongZi" id="pingJunGongZi" value="" class="inputBox" style="width: 80px" /> 
                      <span class="zhengwen">元</span></TD>
                  </TR>
                  <TR> 
                    <TD height="25" class="zhengwen" >本市职工上年月平均工资：</TD>
                    <TD height="25" > <input type="text" name="zhiGongGongZi" id="zhiGongGongZi"  class="inputBox" style="width: 80px" /> 
                      <span class="zhengwen"> 元</span> </TD>
                  </TR>
                  <TR> 
                    <TD 
                  width=144 height="25" class=zhengwen>现在年龄:</TD>
                    <TD width=200 height="25"><input type="text" name="nianLing" id="nianLing" value="" class="inputBox" style="width: 25px" /> 
                      <span class="zhengwen">岁</span></TD>
                  </TR>
                  <TR> 
                    <TD height="25" class="zhengwen" >您打算退休时年龄:</TD>
                    <TD height="25"> <input type="text" name="tuiXiu" id="tuiXiu" class="inputBox" style="width: 25px" /> 
                      <span class="zhengwen">岁</span></TD>
                  </TR>
                  <TR> 
                    <TD height=25 class="zhengwen">现在您帐户累积的养老金额:</TD>
                    <TD height=25><input type="text" name="jiLei" id="jiLei" value="" class="inputBox" style="width: 75px" /> 
                      <span class="zhengwen">元 (具体数额可到当地社保部门查询)</span></TD>
                  </TR>
                  <TR> 
                    <TD height=25 class="zhengwen">默认个人工资增长率:</TD>
                    <TD height=25> <input type="text" name="geRenZenZhang" id="geRenZenZhang" class="inputBox" style="width: 75px" /> 
                      <span class="zhengwen">%</span></TD>
                  </TR>
                  <TR> 
                    <TD height=25 class="zhengwen">默认职工工资增长率:</TD>
                    <TD height=25> <input type="text" name="zhiGongZenZhang" id="zhiGongZenZhang" class="inputBox" style="width: 75px" /> 
                      <span class="zhengwen">%</span></TD>
                  </TR>
                  <TR>
                    <TD height=25 class="zhengwen">您期望退休后每月的生活水平:</TD>
                    <TD height=25><input type="text" name="qiWang" id="qiWang" value="" class="inputBox" style="width: 75px" />
                      <span class="zhengwen">元</span></TD>
                  </TR>
                  <TR> 
                    <TD height=25>&nbsp; </TD>
                    <TD height=25><img id=btnCalc
                  style="CURSOR: hand" onClick="LingQuYangLao();" tabindex=7 
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
            <TD ><TABLE width="100%"  border="0" cellpadding="0" cellspacing="0" >
                <TBODY>
                  <TR> 
                    <TD height="25" align=left class=zhengwen > 您现在 
                      <input type="text" name="nianLing2" id="nianLing2" value="" disabled class="inputBox" style="width: 25px" />
                      岁，打算 
                      <input type="text" name="tuiXiu2" id="tuiXiu2" value="" disabled class="inputBox" style="width: 25px" />
                      岁退休，退休后每月大致能拿基础养老金为： <input type="text" name="yangLaoJin" id="yangLaoJin" value="计算得出" disabled class="inputBox" style="width: 75px; text-align:right;" />
                      元</TD>
                  </TR>
                  <TR>
                    <TD height="25" align=left class=head >养老规划</TD>
                  </TR>
                  <TR>
                    <TD height="25" align=left class=zhengwen id="result">请填写各选项并计算结果！</TD>
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
              
            <TD valign="top" class="zhengwen">通过本计算器，可以根据您上年度平均月工资及您所在市职工上年度平均月工资与现在年龄、打算退休时年龄、帐户累积的养老金额、默认个人工资增长率几默认职工工资增长率计算出退休后每月大致能拿基础养老金金额。</TD>
          </TR>
        </TBODY>
      </TABLE>
	</td>
  </tr>
</table>
</body>
<#include "/template/foot.ftl"/>