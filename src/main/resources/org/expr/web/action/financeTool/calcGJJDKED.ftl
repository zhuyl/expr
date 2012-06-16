<#include "/template/head.ftl"/>
<SCRIPT language=JavaScript src="${base}/static/scripts/financeTool/calc/ll.js" charset="gb2312"> </SCRIPT>
<SCRIPT language=JavaScript src="${base}/static/scripts/financeTool/calc/gjjloan1.js" charset="gb2312"> </SCRIPT>
<SCRIPT language=JavaScript src="${base}/static/scripts/financeTool/calc/gjjloan2.js" charset="gb2312"> </SCRIPT>
<SCRIPT language=JavaScript src="${base}/static/scripts/financeTool/calc/gjjloan3.js" charset="gb2312"> </SCRIPT>

<BODY LEFTMARGIN="0" TOPMARGIN="0">
<FORM name=formt2 action="" method=post>
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCFF" style="border-collapse:collapse;" >
  <tr> 
    <td height="23" background="${base}/static/images/titlebg.gif"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
            <td><img src="${base}/static/images/titlearrow.gif" width="8" height="13"> <span class="title"><B>公积金贷款额度年限计算器</B></span></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td> <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
            <td height="25" class="explain"><B>公积金贷款额度年限计算器可以帮您计算最大贷款额及最长年限</B></td>
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
            <TD><TABLE cellSpacing=0 cellPadding=0 width="100%" 
                              align=center border=0>
                <TBODY>
                  <!--			  <TR>
                <TD align=right width="35%">身份证号码：</TD>
                <TD align=middle colspan="2" width="15%">
                  <DIV align=left>-->
                <input class="inputBox" 
                                onblur=c_id_card(this.form) type=hidden 
                                name=id_card>
                <!--</DIV></TD><TD
                   class=p10><FONT color=#cc3300><span id="age_qx"></span></FONT></TD>
              </TR>-->
                <TR class="zhengwen"> 
                  <TD width="33%" height="25" align=right> <DIV align=right>住房公积金个人月缴存额：</DIV></TD>
                  <TD width="19%" height="25" align=middle> <DIV align=left> 
                      <INPUT class="inputBox" size=10 
                                name=mount2>
                      元</DIV></TD>
                  <TD width="11%" height="25" align=right noWrap> <div align="right">缴存比例：</div></TD>
                  <TD width="37%" height="25" align=middle> <DIV align=left> 
                      <INPUT class="inputBox" size=3 
                                name=jcbl>
                      %</DIV></TD>
                </TR>
                <TR class="zhengwen"> 
                  <TD height="25" align=right> <DIV align=right>配偶住房公积金个人月缴存额：</DIV></TD>
                  <TD height="25" align=middle> <DIV align=left> 
                      <INPUT class="inputBox" size=10 
                                name=mount3>
                      元</DIV></TD>
                  <TD height="25" align=right> <div align="right">缴存比例：</div></TD>
                  <TD height="25" align=middle> <DIV align=left> 
                      <INPUT class="inputBox" size=3 
                                name=p_bl>
                      %</DIV></TD>
                </TR>
                <TR class="zhengwen"> 
                  <TD height="25" align=right> <DIV align=right>房屋评估价值或实际购房款：</DIV></TD>
                  <TD height="25" align=middle> <DIV align=left> 
                      <INPUT class="inputBox" size=10 
                                name=mount>
                      元</DIV></TD>
                  <TD height="25" align=right> <div align="right">房屋性质：</div></TD>
                  <TD height="25" align=middle> <DIV align=left> 
                      <INPUT type=radio name=xz>
                      政策性住房 
                      <INPUT type=radio CHECKED name=xz>
                      其它</DIV></TD>
                </TR>
                <TR class="zhengwen"> 
                  <TD height="25" align=right> <DIV align=right>贷款申请年限：</DIV></TD>
                  <TD height="25" align=middle> <DIV align=left> 
                      <INPUT class="inputBox" size=10 
                                name=mount10>
                      年</DIV></TD>
                  <TD height="25" colSpan=2 align=left>（注： 贷款期限最长可以计算到借款人70周岁，
                    同时不得超过30年。 ）</TD>
                </TR>
                <TR class="zhengwen"> 
                  <TD height="25" align=right> <DIV align=right>个人信用等级：</DIV></TD>
                    <TD height="25" colSpan=3 align=left> <div align="left">
                        <INPUT type=radio 
                                name=xy>
                        AAA级 
                        <INPUT type=radio name=xy option>
                        AA级 
                        <INPUT type=radio CHECKED name=xy>
                        其它</div></TD>
                </TR>
              </TABLE></TD>
          </TR>
          <TR> 
            <TD height="25" align=left class="head"><div align="center"> 
                <INPUT style="COLOR: #ffffff; PADDING-TOP: 2px; BACKGROUND-COLOR: #1070d0" onclick=gjjloan1(this.form) type=button value=开始计算 name=math2>
                　　 
                <INPUT style="COLOR: #ffffff; PADDING-TOP: 2px; BACKGROUND-COLOR: #1070d0" type=reset value=清除数据 name=qx>
              </div></TD>
          </TR>
          <TR>
            <TD height="25" align=left class="head">
			<TABLE height=1 cellSpacing=0 cellPadding=0 
                              width="100%" bgColor=#1e86b0 border=0>
                                <TBODY>
                                <TR>
                                <TD></TD></TR></TBODY></TABLE></TD></TR>
                          <TR>
                            <TD class=p10 vAlign=top height=20>
                              <DIV align=center>
                <p class="zhengwen"><SPAN 
                              class=STYLE5>您可以申请的最高贷款额度是：</SPAN> 
                  <INPUT class="inputBox" disabled
                              maxLength=4 size=4 name=ze2>
                  万元</p>
              </DIV></TD></TR>
                          <TR>
                            <TD class=p10 height=20>
                              <TABLE height=1 cellSpacing=0 cellPadding=0 
                              width="100%" bgColor=#1e86b0 border=0>
                                <TBODY>
                                <TR>
                                <TD></TD></TR></TBODY></TABLE>
			</TD>
          </TR>
          <TR> 
            <TD height="25" align=left class="head">
			<TABLE cellSpacing=0 cellPadding=0 width="100%" 
                              align=center border=0>
                <TBODY>
                                
                  <TR class="zhengwen"> 
                    <TD width="42%" height="25" align=right>您所需要的贷款额度：</TD>
                                
                    <TD width="58%" height="25" align=left> 
                      <INPUT class="inputBox" 
                                size=5 name=need> 万元<SPAN 
                                class=style1>（注：不能高于上述额度）</SPAN></TD></TR>
                                
                  <TR class="zhengwen"> 
                    <TD width="42%" height="25" align=right>请选择还款方式：</TD>
                                
                    <TD width="58%" height="25" align=left> 
                      <SELECT class=f8 
                                name=select> <OPTION 
                                value=1>等额均还</OPTION><OPTION 
                                value=2>等额本金</OPTION><OPTION value=3 
                                selected>自由还款</OPTION></SELECT></TD></TR>
                                
                  <TR class="zhengwen"> 
                    <TD height=25 colSpan=2 align=middle> 
                      <DIV align=center><BR><INPUT style="COLOR: #ffffff; PADDING-TOP: 2px; BACKGROUND-COLOR: #1070d0" onclick=gjjloan2(this.form) type=button value=开始计算 name=math3> 
                                　　 <INPUT style="COLOR: #ffffff; PADDING-TOP: 2px; BACKGROUND-COLOR: #1070d0" type=reset value=清除数据 name=qx2> 
                                </DIV></TD></TR>
                                <TR>
                                <TD align=middle colSpan=2 height=20>
                                <TABLE height=1 cellSpacing=0 cellPadding=0 
                                width="100%" bgColor=#1e86b0 border=0>
                                <TBODY>
                                <TR>
                                <TD></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE>
			</TD>
          </TR>
          <TR> 
            <TD >
			<TABLE width="100%" border=0 
                              align=center cellPadding=0 cellSpacing=0 class="zhengwen">
                <TBODY>
                                <TR>
                                <TD align=middle colSpan=2 height=25>
                                <DIV class=STYLE5 
                                align=center>[等额均还方式计算结果]</DIV></TD>
                                <TD align=middle width=1 bgColor=#000000 
                                rowSpan=5>
                                <DIV align=center></DIV></TD>
                                <TD align=middle colSpan=2>
                                <DIV class=STYLE5 
                                align=center>[等额本金方式计算结果]</DIV></TD>
                                <TD align=middle width=1 bgColor=#000000 
                                rowSpan=5>
                                <DIV align=center></DIV></TD>
                                <TD align=middle colSpan=2 height=25>
                                <DIV class=STYLE5 
                                align=center>[自由还款方式计算结果]</DIV></TD></TR>
                                <TR>
                                <TD noWrap align=middle width="17%">
                                <DIV align=right>月均还款额：</DIV></TD>
                                <TD noWrap align=middle width="16%"><INPUT class="inputBox" disabled size=9 name=ze22> 元</TD>
                                <TD noWrap align=middle width="17%">
                                <DIV align=right>首月还款额：</DIV></TD>
                                <TD noWrap align=middle width="16%"><INPUT class="inputBox" disabled size=9 name=sfk2> 元</TD><INPUT 
                                class=jsq type=hidden name=yj2> 
                                <TD noWrap align=middle width="19%">
                                <DIV align=right>最低还款额：</DIV></TD>
                                <TD noWrap align=middle width="16%"><INPUT class="inputBox" disabled size=9 name=sfk3> 元</TD>
                                <TR>
                                <TD noWrap align=middle width="17%">
                                <DIV align=right></DIV></TD>
                                <TD noWrap align=middle width="16%">&nbsp;</TD>
                                <TD noWrap align=middle width="17%">
                                <DIV align=right></DIV></TD>
                                <TD noWrap align=middle width="16%">&nbsp;</TD>
                                <TD noWrap align=middle width="19%">
                                <DIV align=right>最后期本金：</DIV></TD>
                                <TD noWrap align=middle width="16%"><INPUT class="inputBox" disabled size=9 name=lx4> 元</TD></TR>
                                <TR>
                                <TD noWrap align=middle>
                                <DIV align=right>本息合计：</DIV></TD>
                                <TD noWrap align=middle><INPUT class="inputBox" disabled size=9 
                                name=lx2> 元</TD>
                                <TD noWrap align=middle>
                                <DIV align=right>本息合计：</DIV></TD>
                                <TD noWrap align=middle><INPUT class="inputBox" disabled size=9 
                                name=lx3> 元</TD>
                                <TD noWrap align=middle width="19%">
                                <DIV align=right>最后期利息：</DIV></TD>
                                <TD noWrap align=middle width="16%"><INPUT class="inputBox" disabled size=9 name=lx5> 元</TD></TR>
                                <TR>
                                <TD align=middle width="17%">&nbsp;&nbsp;</TD>
                                <TD align=middle width="16%">&nbsp;&nbsp;</TD>
                                <TD align=middle width="17%">&nbsp;&nbsp;</TD>
                                <TD align=middle width="16%">&nbsp;&nbsp;</TD>
                                <TD noWrap align=middle width="19%">
                                <DIV align=right>总偿还利息：</DIV></TD>
                                <TD noWrap align=middle width="16%"><INPUT class="inputBox" disabled size=9 name=lx6> 
                              元</TD></TR></TBODY></TABLE>
			</TD>
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
      </TABLE>
	</td>
  </tr>
</table>
</form>
</body>
<#include "/template/foot.ftl"/>