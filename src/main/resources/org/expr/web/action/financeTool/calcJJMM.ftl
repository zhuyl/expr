<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/dealdata.js" charset="gb2312"></script>
<BODY LEFTMARGIN="0" TOPMARGIN="0">
<FORM name=fundsb action=counter-aa>
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCFF" style="border-collapse:collapse;" >
  <tr> 
    <td height="23" background="${base}/static/images/titlebg.gif"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
            <td height="23" background="${base}/static/images/titlebg.gif"><img src="titlearrow.gif" width="8" height="13"> 
              <span class="title"><B>基金买卖计算器</B></span></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td>
	 <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
            
            <td height="25" class="explain"><B>基金买卖计算器，不必掌握专业知识，就可以选择最经济的基金买卖方式。</B></td>
        </tr>
      </table>
        <TABLE width=95% align="center" cellSpacing=0>
          <TBODY>
            <TR> 
              <TD height="25" align=left class="head">计算公式</TD>
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
                  width=79 height="25" align=right style="PADDING-TOP: 2px"><div align="left">基金代码：</div></TD>
                      <TD width=265 height="25"> <INPUT 
                  name=code class="inputBox" style="WIDTH: 123px" size=8 maxLength=8></TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD height="25" align=right style="PADDING-TOP: 2px"><div align="left">数　　量：</div></TD>
                      <TD height="25"> <INPUT 
                name=num1 class="inputBox" style="WIDTH: 123px" size=8 maxLength=12></TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD height="25" align=right style="PADDING-TOP: 2px"><div align="left">价　　格：</div></TD>
                      <TD height="25"> <INPUT 
                name=price class="inputBox" style="WIDTH: 123px" size=8 maxLength=12></TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD height="25" align=right style="PADDING-TOP: 2px"><div align="left">操作选择：</div></TD>
                      <TD height="25"> <SELECT name=sellbuy style="font-size:12px;">
                          <OPTION value=-1 
                    selected>请选择</OPTION>
                          <OPTION value=0>认购</OPTION>
                          <OPTION 
                    value=1>申购</OPTION>
                          <OPTION value=2>赎回</OPTION>
                        </SELECT></TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD height="25" align=right style="PADDING-TOP: 2px"><div align="left">交易费率：</div></TD>
                      <TD height="25"> <INPUT name=rate class="inputBox" size=4 maxLength=6>
                        %</TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD height="25"></TD>
                      <TD height="25"><A href="javascript:fundsendprice()"><IMG height=19 
                  src="${base}/static/images/calbt.gif" 
              width=47></A></TD>
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
              <TD ><TABLE 
              cellSpacing=0>
                  <TBODY>
                    <TR class="zhengwen"> 
                      <TD style="PADDING-TOP: 2px" align=right 
                  width=79><div align="left">金　　额：</div></TD>
                      <TD width="209"> <INPUT 
                  name=money1 class="inputBox" style="WIDTH: 110px" size=9 maxLength=16>
                        元</TD>
                    </TR>
                    <TR class="zhengwen"> 
                      <TD style="PADDING-TOP: 2px" align=right 
                  width=79><div align="left">手 续 费：</div></TD>
                      <TD> <INPUT 
                  name=moneyNumTo1 class="inputBox" style="WIDTH: 110px" size=9 maxLength=16>
                        元</TD>
                    </TR>
                    <SCRIPT language=javascript>
var win=null;
function popwin(fileurl){ 
  win=window.open(fileurl,"popwin",
"toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=0,width=600,height=500"); 
 win.focus(); 
}
function fundgetrate(){
        var objArray=new Array;
        objArray[0]=document.fundsb.code;
        objArray[1]=document.fundsb.num1;
        objArray[2]=document.fundsb.price;
        var rst=checkData(objArray);//调用函数检验是否有空字符
        if(rst=="false")
        	{return;}                 
        var code1=document.fundsb.code.value;
        var num=document.fundsb.num1.value;
        var price=document.fundsb.price.value;
        var money=parseFloat(num)*parseFloat(price);        
        var true1=0;
        var n=document.fundsb.sellbuy.selectedIndex;
        if (n==0)
           { alert("请选择操作类型！");
             document.fundsb.sellbuy.focus;
             return;
           }
        var sellType=document.fundsb.sellbuy.value;
        for(i=0;i<=codeArray.length;i++)
          {
          if (codeArray[i]==code1) 
            {
             returnRate(i,sellType,code1,money);            
             true1=1;
            }
          }
        if(true1==0){
        alert("请输入正确的基金代码!");
        document.fundsb.code.focus();
        return;
        }     
   }  
  function returnRate(n,sellType,code1,money){
      var max;
      if(sellType==0) {
         max=money0[n].length;       
         if(max==1) {document.fundsb.rate.value=rate0[n][0];return;}
         if(money<money0[n][0])  document.fundsb.rate.value=rate0[n][0];
         else if(money>=money0[n][max-2])  document.fundsb.rate.value=rate0[n][max-1];
         else{
               for(i=1;i<max;i++){
                  if ((money<money0[n][i])&&(money>=money0[n][i-1]))
                  document.fundsb.rate.value=rate0[n][i];
                  }
             }
      }      
     if(sellType==1) {
         max=money1[n].length;            
         if(max==1) {document.fundsb.rate.value=rate1[n][0];return;}         
         if(money<money1[n][0])  document.fundsb.rate.value=rate1[n][0];
         else if(money>=money1[n][max-2])  document.fundsb.rate.value=rate1[n][max-1];
         else{
               for(i=1;i<max;i++){
                  if ((money<money1[n][i])&&(money>=money1[n][i-1]))
                  document.fundsb.rate.value=rate1[n][i];
                  }
             }
      }    

      if(sellType==2) {
         max=money2[n].length;
         if(max==1) {document.fundsb.rate.value=rate2[n][0];return;}
         if(money<money2[n][0])  document.fundsb.rate.value=rate2[n][0];
         else if(money>=money2[n][max-2])  document.fundsb.rate.value=rate2[n][max-1];
         else{
               for(i=1;i<max;i++){
                  if ((money<money2[n][i])&&(money>=money2[n][i-1]))
                  document.fundsb.rate.value=rate2[n][i];
                  }
             }
      }    
  }
function getprice(){
	if(document.fundsb.inputSelect.value="自动")
	{
	var m=document.fundsb.debtkindFrom.selectedIndex;
	var n=document.fundsb.sellbuy.selectedIndex;

	if(m==0){
		alert("选择股票代码！");
		document.fundsb.debtkindFrom.focus();
		return;
	       }
	if(n==0){
		alert("选择操作类型！");
		document.fundsb.sellbuy.focus();
		return;
	       }

	if(n==1)  {document.fundsb.price.value=buyArray[m];}
	else    {document.fundsb.price.value=sellArray[m];} 
     }
}
//计算函数，返回计算结果并显示在相应的结果项上。
function fundsendprice(){
	//设定一个数组，把要检验的字段对应的输入框的字符串表示赋给数组   
        var objArray=new Array;
        var objArray1=new Array;
        var i;
        objArray[0]=document.fundsb.num1;
        objArray[1]=document.fundsb.price;
        objArray1[0]=document.fundsb.price;
        objArray1[1]=document.fundsb.money1; 
        var rate;
        var rst=checkData1(objArray);//调用函数检验是否有空字符
        var code1=document.fundsb.code.value;
        var n=document.fundsb.sellbuy.selectedIndex;
        rate=document.fundsb.rate.value;
	if(n==0){
		alert("选择操作类型！");
		document.fundsb.sellbuy.focus();
		return;
	       }
	else{       
           if(rst=="false")
        	{
        	var rst1=checkData(objArray1);
        	if (rst1=="false")    return;
        	else{
        	       var money=document.fundsb.money1.value;
                       var price=document.fundsb.price.value;   
                        if (parseFloat(money)<=0||parseFloat(price)<=0||parseFloat(rate)<=0)
                           {  alert("请正确输入！");
                                   return;
                            }                    
                       var r2=parseFloat(money)*parseFloat(rate)/100;

                       var money1=money-r2;
        	       var r1=parseFloat(money1)/parseFloat(price);
        	       var result2=Math.round(r2*100)/100;
	               var result=Math.round(r1*100)/100;
	               document.fundsb.moneyNumTo1.value=result2;      //显示手续费
                       document.fundsb.num1.value=result;        //显示数量
        	     }

        	}
              else{
                       var num=document.fundsb.num1.value;
                       var price=document.fundsb.price.value;
                       if (parseFloat(num)<=0||parseFloat(price)<=0||parseFloat(rate)<=0)
                           {  alert("请正确输入！");
                                   return;
                            }
        	       var r1=parseFloat(num)*parseFloat(price);
        	       var r2=r1*parseFloat(rate)/100;
        	       var result2=Math.round(r2*100)/100;
	               var result1=Math.round(r1*100)/100;
	               var result=result1+result2;
	               document.fundsb.moneyNumTo1.value=result2;      //显示手续费
                       document.fundsb.money1.value=result;        //显示金额

              }
           }

} 

</SCRIPT>

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
              <TD valign="top" class="zhengwen">&nbsp;</TD>
            </TR>
          </TBODY>
        </TABLE></td>
</tr>

</table>
</form>
</body>
<#include "/template/foot.ftl"/>