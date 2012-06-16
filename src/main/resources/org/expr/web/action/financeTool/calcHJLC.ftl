<#include "/template/head.ftl"/>
<script language="JavaScript" src="${base}/static/scripts/financeTool/dealdata.js" charset="gb2312"></script>
<BODY LEFTMARGIN="0" TOPMARGIN="0">
<FORM name=goldsb action=counter-aa>
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCFF" style="border-collapse:collapse;" >
  <tr> 
    <td height="23" background="${base}/static/images/titlebg.gif"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
            
            <td><img src="${base}/static/images/titlearrow.gif" width="8" height="13"> <span class="title"><B>黄金理财计算器</B></span></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td> <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
            
            <td height="25" class="explain"><B>黄金买卖计算器，忘掉复杂多样的价格吧，它自动帮您计算收益。</B></td>
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
              
              <TD><TABLE 
              cellSpacing=0>
                  <TBODY>
                    <TR class="zhengwen"> 
                      <TD 
                  width=79 height="25" >买入价格：</TD>
                      <TD width=265 height="25"> 
                        <INPUT 
                  name=price1 class="inputBox" style="WIDTH: 65px" size=6 maxLength=8>
                        元/克 </TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD height="25">卖出价格：</TD>
                      <TD height="25"> 
                        <INPUT name=price2 class="inputBox" style="WIDTH: 65px" size=6 maxLength=8>
                        元/克</TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD height="25" >数　　量：</TD>
                      <TD height="25"> 
                        <INPUT name=num class="inputBox" style="WIDTH: 65px" size=6 maxLength=8>
                        克</TD>
                    </TR>
                    <TR> 
                      <TD height="25"></TD>
                      <TD height="25"><A href="javascript:goldsendprice()"><IMG height=19 
                  src="${base}/static/images/calbt.gif" 
              width=47></A></TD>
                    </TR>
                  </TBODY>
                </TABLE> </TD>
            </TR>
            <TR> 
              
            <TD height="25" align=left class="head">计算结果</TD>
            </TR>
			            <TR> 
              <TD height="1" background="${base}/static/images/dline.gif"></TD>
            </TR>
            <TR> 
              <TD class=zhengwen vAlign=top height=25><TABLE class=zhengwen 
              cellSpacing=0>
                  <TBODY>
                    <TR> 
                      <TD 
                  width=65>收　　益：</TD>
                      <TD width="178"><INPUT 
                  name=moneyNumTo class="inputBox" style="WIDTH: 65px" size=8 maxLength=15 readonly>
                        元</TD>
                    </TR>
                    <SCRIPT language=javascript>

//计算函数，返回计算结果并显示在相应的结果项上。
function goldsendprice(){
	//设定一个数组，把要检验的字段对应的输入框的字符串表示赋给数组   
        var objArray=new Array;
        objArray[0]=document.goldsb.num;
        objArray[1]=document.goldsb.price1; 
        objArray[2]=document.goldsb.price2;
        var rst=checkData(objArray);//调用函数检验是否有空字符
        if(rst=="false")
        	{
        	return;
        	}
        else{
              var num1=document.goldsb.num.value;
              var price1=document.goldsb.price1.value;
              var price2=document.goldsb.price2.value;  
              if (parseFloat(num1)<=0||parseFloat(price1)<=0||parseFloat(price2)<=0)
                {  alert("请正确输入！");
                   return;
                 }            
	      var result=parseFloat(num1)*(parseFloat(price2)-parseFloat(price1));
	      result=Math.round(result*100)/100;
              document.goldsb.moneyNumTo.value=result;        //显示金额
             }
} 
            </SCRIPT>
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
   </body>
<#include "/template/foot.ftl"/>