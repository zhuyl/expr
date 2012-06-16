<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/functionBX.js" charset="gb2312"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/calcBX.js" charset="gb2312"></script>

<BODY LEFTMARGIN="0" TOPMARGIN="0">
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCFF" style="border-collapse:collapse;" >
  <tr> 
    <td height="23" background="${base}/static/images/titlebg.gif"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td><img src="${base}/static/images/titlearrow.gif" width="8" height="13"> <span class="title"><B>医疗保险金计算器</B></span></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td> <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="25" class="explain"><B>医疗保险金计算器可以帮您计算您每月缴存的基本养老保险金</B></td>
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
            cellPadding=0 width=413 border=0>
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
                  width=144 height="25" class=zhengwen>基本医疗保险金单位缴存比例：</TD>
                    <TD width=200 height="25"> <input type="text" name="jiBenDanWei" id="jiBenDanWei" class="inputBox" style="width: 80px" /> 
                      <span class="zhengwen">%</span></TD>
                  </TR>
                  <TR> 
                    <TD height="25" class="zhengwen" >基本医疗保险金个人缴存比例：</TD>
                    <TD height="25"> <input type="text" name="jiBenGeRen" id="jiBenGeRen" class="inputBox" style="width: 80px" /> 
                      <span class="zhengwen">%</span></TD>
                  </TR>
                  <TR>
                    <TD height=25 class="zhengwen">大额医疗费用互助资金单位缴存比例：</TD>
                    <TD height=25><input type="text" name="daEDanWei" id="daEDanWei"  class="inputBox" style="width:80px" /> <span class="zhengwen">%</span></TD>
                  </TR>
                  <TR> 
                    <TD height=25 class="zhengwen">大额医疗费用互助资金个人缴存金额：</TD>
                    <TD height=25><input type="text" name="daEGeRen" id="daEGeRen"  class="inputBox" style="width: 80px" />  <span class="zhengwen">元</span></TD>
                  </TR>
                  <TR> 
                    <TD height=25>&nbsp; </TD>
                    <TD height=25><img id=btnCalc
                  style="CURSOR: hand" onClick="YiLiao();" tabindex=7 
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
            <TD ><TABLE border="0" cellpadding="0" cellspacing="0" >
                <TBODY>
                  <TR> 
                    <TD 
                  width=220 height="25" align=left class=zhengwen style="PADDING-TOP: 2px">今年您每月缴存的医疗保险金为</TD>
                    <TD height="25"> 
                      <input type="text" name="jiaoCun" id="jiaoCun" value="计算得出" disabled class="inputBox" style="width: 100px; " />
					<span class="zhengwen">元</span></TD>
                  </TR>
                  <TR> 
                    <TD height="25" align=left class="zhengwen" style="PADDING-TOP: 2px">其中基本医疗保险:</TD>
                    <TD height="25"> 
                      <input type="text" name="jiBenJiaoCun" id="jiBenJiaoCun" value="计算得出" disabled class="inputBox" style="width: 100px; " />
                      <span class="zhengwen">元</span></TD>
                  </TR>
                  <TR> 
                    <TD height="25" align=left class="zhengwen" style="PADDING-TOP: 2px">大额医疗费用互助资金:</TD>
                    <TD height="25">
<input type="text" name="daEJiaoCun" id="daEJiaoCun" value="计算得出" disabled class="inputBox" style="width: 100px;" /> <span class="zhengwen">元</span></TD>
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
              
            <TD valign="top" class="zhengwen"></TD>
          </TR>
        </TBODY>
      </TABLE>
	</td>
  </tr>
</table>

</body>
<#include "/template/foot.ftl"/>