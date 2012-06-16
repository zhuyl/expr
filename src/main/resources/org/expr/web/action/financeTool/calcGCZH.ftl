<#include "/template/head.ftl"/>
<BODY LEFTMARGIN="0" TOPMARGIN="0">
        <FORM id=carForm name=carForm>
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCFF" style="border-collapse:collapse;" >
  <tr> 
    <td height="23" background="${base}/static/images/titlebg.gif"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
            
            
          <td><img src="${base}/static/images/titlearrow.gif" width="8" height="13"> <span class="title">购车综合计算器</span></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td> <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
            
            
          <td height="25" class="explain">购车综合计算器可以帮助您方便购车</td>
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
              
              <TD><TABLE cellSpacing=0 class="zhengwen">
                <TBODY>
                  <TR> 
                    <TD 
                  width=103 height="25" >车辆购置价格：</TD>
                    <TD width=387 height="25">
<INPUT class=inputBox size=15 
                  name=TextGouzhi1>
                      元</TD>
                  </TR>
                  <TR> 
                    <TD height="25" >车辆购置附加费：</TD>
                    <TD height="25">
<INPUT class=inputBox size=15 name=TextGouzhi2>
                      元 (车价÷11.7)</TD>
                  </TR>
                  <TR> 
                    <TD height="25" >第三者责任险：</TD>
                    <TD height="25">
<INPUT class=inputBox size=15 value=1430 name=TextGouzhi3>
                      元 选择赔偿限额：
                      <SELECT 
                  onclick=javascript:document.carForm.TextGouzhi3.value=document.carForm.TextGouzhi4.value; 
                  size=1 name=TextGouzhi4 style="font-size:12px;">
                        <OPTION value=1150>5万元</OPTION>
                        <OPTION value=1430 selected>10万元</OPTION>
                        <OPTION 
                    value=1650>20万元</OPTION>
                        <OPTION value=1925>50万元</OPTION>
                        <OPTION value=2035>100万元</OPTION>
                      </SELECT></TD>
                  </TR>
                  <TR> 
                    <TD height="25" >车辆损失险：</TD>
                    <TD height="25">
<INPUT class=inputBox size=15 value=1075 name=TextGouzhi5>
                      元 (车价×0.9%+175)</TD>
                  </TR>
                  <TR> 
                    <TD height="25" >不计责任免赔险：</TD>
                    <TD height="25">
<INPUT class=inputBox size=15 name=TextGouzhi6>
                      元 (第三责任险+车辆损失险)×20%</TD>
                  </TR>
                  <TR> 
                    <TD height="25" >全车盗抢险：</TD>
                    <TD height="25">
<INPUT class=inputBox size=15 value=650 name=TextGouzhi7>
                      元 选择赔偿限额：
                      <SELECT 
                  onclick=javascript:document.carForm.TextGouzhi7.value=document.carForm.TextGouzhi8.value 
                  size=1 name=TextGouzhi8 style="font-size:12px;">
                        <OPTION value=325>5万元</OPTION>
                        <OPTION value=650 selected>10万元</OPTION>
                        <OPTION 
                    value=1300>20万元</OPTION>
                        <OPTION value=3250>50万元</OPTION>
                        <OPTION value=6500>100万元</OPTION>
                      </SELECT>
                      ×0.65% </TD>
                  </TR>
                  <TR> 
                    <TD height="25" >玻璃单独破碎险：</TD>
                    <TD height="25">
<INPUT class=inputBox size=15 value=120 name=TextGouzhi9>
                      元 选择赔偿限额：
                      <SELECT 
                  onclick=javascript:document.carForm.TextGouzhi9.value=document.carForm.TextGouzhi10.value 
                  size=1 name=TextGouzhi10 style="font-size:12px;">
                        <OPTION value=60>5万元</OPTION>
                        <OPTION value=120 selected>10万元</OPTION>
                        <OPTION 
                    value=240>20万元</OPTION>
                        <OPTION value=600>50万元</OPTION>
                        <OPTION value=1200>100万元</OPTION>
                      </SELECT>
                      ×0.12%</TD>
                  </TR>
                  <TR> 
                    <TD height="25" >其它保险费用：</TD>
                    <TD height="25">
<INPUT class=inputBox size=15 value=0 name=TextGouzhi11>
                      元 如还有其它保险费用，客户自行填写。</TD>
                  </TR>
                  <TR> 
                    <TD height="25" >养路费：</TD>
                    <TD height="25">
<INPUT class=inputBox size=15 value=120 name=TextGouzhi12>
                      元 轿车120/月；面包车等140/月</TD>
                  </TR>
                  <TR> 
                    <TD height="25" >车船使用费：</TD>
                    <TD height="25">
<INPUT class=inputBox size=15 value=100 
              name=TextGouzhi13>
                      元</TD>
                  </TR>
                  <TR> 
                    <TD height="25" >无人道路看护费：</TD>
                    <TD height="25">
<INPUT class=inputBox size=15 value=30 name=TextGouzhi14>
                      元 固定</TD>
                  </TR>
                  <TR> 
                    <TD height="25" >照相费：</TD>
                    <TD height="25">
<INPUT class=inputBox size=15 value=30 name=TextGouzhi15>
                      元 固定</TD>
                  </TR>
                  <TR> 
                    <TD height="25" >三角牌：</TD>
                    <TD height="25">
<INPUT class=inputBox size=15 value=90 
              name=TextGouzhi16>
                      元</TD>
                  </TR>
                  <TR> 
                    <TD height="25" >灭火器：</TD>
                    <TD height="25">
<INPUT class=inputBox size=15 value=130 name=TextGouzhi17>
                      元 </TD>
                  </TR>
                  <TR> 
                    <TD height="25" >牌照费用：</TD>
                    <TD height="25">
<INPUT class=inputBox size=15 value=250 name=TextGouzhi18>
                      元 </TD>
                  </TR>
                  <TR> 
                    <TD height="25" >上牌费用：</TD>
                    <TD height="25">
<INPUT class=inputBox size=15 value=300 name=TextGouzhi19>
                      元 固定</TD>
                  </TR>
                  <TR> 
                    <TD height="25" >车船使用税：</TD>
                    <TD height="25">
<INPUT class=inputBox size=15 value=100 name=TextGouzhi20>
                      元 </TD>
                  </TR>
                  <TR> 
                    <TD height="25" >托盘费：</TD>
                    <TD height="25">
<INPUT class=inputBox size=15 value=120 name=TextGouzhi21>
                      元 固定</TD>
                  </TR>
                  <TR> 
                    <TD height="25" >交强险：</TD>
                    <TD height="25">
<INPUT class=inputBox size=15 value=1050 name=TextGouzhi24>
                      元 固定</TD>
                  </TR>
                  <TR> 
                    <TD height="25" >其它费用：</TD>
                    <TD height="25">
<INPUT class=inputBox size=15 value=0 name=TextGouzhi22>
                      元 如有其它费用，客户自行填写。</TD>
                  </TR>
                  <TR> 
                    <TD height="25"></TD>
                    <TD height="25">
<INPUT style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BACKGROUND-IMAGE: url(${base}/static/images/calbt.gif); BORDER-LEFT: 0px; WIDTH: 47px; CURSOR: hand; BORDER-BOTTOM: 0px; HEIGHT: 19px" onclick=javascript:JiSuan() type=button name=B2> 
                    </TD>
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
              <TD class=zhengwen vAlign=top height=25><TABLE class=zhengwen style="MARGIN: 18px 0px 27px" cellSpacing=0>
                <TBODY>
                  <TR> 
                    <TD 
                  width=89>购车费用合计：</TD>
                    <TD width="226"><INPUT class=inputBox readOnly size=15 value=0 
                  name=TextGouzhi23>
                      元。</TD>
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
<SCRIPT language=JavaScript>
<!--
function JiSuan(){
document.carForm.TextGouzhi2.value=Math.round(document.carForm.TextGouzhi1.value*10/117);
document.carForm.TextGouzhi5.value=Math.round(document.carForm.TextGouzhi1.value*0.009+175);
document.carForm.TextGouzhi3.value=document.carForm.TextGouzhi4.value;
document.carForm.TextGouzhi6.value=Math.round((document.carForm.TextGouzhi3.value*1+document.carForm.TextGouzhi5.value*1)*0.2);
document.carForm.TextGouzhi7.value=document.carForm.TextGouzhi8.value;
document.carForm.TextGouzhi9.value=document.carForm.TextGouzhi10.value;
document.carForm.TextGouzhi23.value=document.carForm.TextGouzhi1.value*1+document.carForm.TextGouzhi2.value*1+document.carForm.TextGouzhi3.value*1+document.carForm.TextGouzhi5.value*1+document.carForm.TextGouzhi6.value*1+document.carForm.TextGouzhi7.value*1+document.carForm.TextGouzhi9.value*1+document.carForm.TextGouzhi11.value*1+document.carForm.TextGouzhi12.value*1+document.carForm.TextGouzhi13.value*1+document.carForm.TextGouzhi14.value*1+document.carForm.TextGouzhi15.value*1+document.carForm.TextGouzhi16.value*1+document.carForm.TextGouzhi17.value*1+document.carForm.TextGouzhi18.value*1+document.carForm.TextGouzhi19.value*1+document.carForm.TextGouzhi20.value*1+document.carForm.TextGouzhi21.value*1+document.carForm.TextGouzhi22.value*1+document.carForm.TextGouzhi24.value*1
}

//-->
</SCRIPT>
   </body>
<#include "/template/foot.ftl"/>