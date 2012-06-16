<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/calendar.js" charset="gb2312"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/CheckDataFunction.js" charset="gb2312"></script>
<script language='javascript'  charset="gb2312">
//计算函数，返回计算结果并显示在相应的结果项上。
function checkCalc(){
//设定一个数组，把要检验的字段对应的输入框的字符串表示赋给数组   
    var objArray=new Array;
    objArray[0]=$("original");
    objArray[1]=$("active");
    objArray[2]=$("yearSpan");

    var rst=checkData(objArray);//调用函数检验是否有空字符
    if(rst=="false") {return;}
    rst=isInteger(objArray);//调用函数检验是否为整数
    if(rst=="false") {return;}           	    	      	   
    //从表单中取值
    var original=$("original").value;  //贷款金额
    var active=$("active").value;      //贷款利息
    var yearSpan=$("yearSpan").value;  //年份
    if(parseFloat(original)<=0){
        alert("请输入正确的贷款金额");
        objArray[0].focus();
        return;
    }
    if(parseFloat(yearSpan)<=0){
        alert("请输入正确的详细期限");
        objArray[2].focus();
        return;
    }
    if (parseFloat(active)<=0){
        alert("请输入正确的贷款利率！");
        objArray[1].focus();
        return;
    }
    
	var timeSpan=parseFloat(yearSpan)*12;
	active=active*10/12;
    //计算贷款利息、本息合计
    var result=new Array(); 


    if($("inputSelect").value=="等额本息还款"){
        result=estateBorrow(original,active,timeSpan);//贷款利息、利息税额、实得利息、本息合计封在返回的数组中
        //将贷款利息本息合计显示
        $("monthBack").value=result[0];        //显示贷款利息
        $("totalBack").value=result[1];              //显示本息合计
        $("totalInterest").value=result[3];              //显示本息合计
    }
    else{
        var result=estateBorrow1(original,active,timeSpan);
        $("totalInterest").value=result[0]; //显示贷款利息
        $("totalBack").value=result[1]; //显示本息合计
        $("monthBackDEBJ").value=result[2];//显示每月还款额
    }
}
function chgobj(){
    if($("inputSelect").value=="等额本息还款"){
		$("tr_debj").style.display="none";
		$("monthBackDEBJ").value = "计算得出";
		$("tr_debx").style.display="";
    }else{
		$("tr_debx").style.display="none";
		$("tr_debj").style.display="";
		$("monthBackDEBJ").value = "计算得出";
    }
}
</SCRIPT>



<BODY LEFTMARGIN="0" TOPMARGIN="0">
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCFF" style="border-collapse:collapse;" >
  <tr> 
    <td height="23" background="${base}/static/images/titlebg.gif"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td><img src="${base}/static/images/titlearrow.gif" width="8" height="13"> <span class="title">个人贷款计算器</span></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td> <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="25" class="explain">个人贷款计算器可以帮您计算个人贷款的数额</td>
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
                    <TD  width=156 height="25" class=zhengwen>贷款种类:</TD>
                    <TD width=495 height="25"> <SELECT name="borrowtype" id="borrowtype" style="font-size:12px;">
                        <OPTION value="个人住房贷款" selected>个人住房贷款</OPTION>
                        <OPTION value="个人旅游贷款">个人旅游贷款</OPTION>
                        <OPTION value="个人综合消费贷款">个人综合消费贷款</OPTION>
                        <OPTION value="个人短期信用贷款">个人短期信用贷款</OPTION>
                        <OPTION value="个人小额抵押贷款">个人小额抵押贷款</OPTION>
                        <OPTION value="个人汽车贷款">个人汽车贷款</OPTION>
                        <OPTION value="助学贷款">助学贷款</OPTION>
                        <OPTION value="个人留学贷款">个人留学贷款</OPTION>
                        <OPTION value="大额耐用消费品贷款">大额耐用消费品贷款</OPTION>
                      </SELECT></TD>
                  </TR>
                  <TR> 
                    <TD height="25" class="zhengwen" >贷款金额(元):</TD>
                    <TD height="25" > <INPUT class="inputBox" id="original" type="text" name="original"></TD>
                  </TR>
                  <TR> 
                    <TD 
                  width=156 height="25" class=zhengwen>详细期限(年):</TD>
                    <TD width=495 height="25" class="zhengwen"><INPUT class="inputBox" id="yearSpan" type="text" name="original"></TD>
                  </TR>
                  <TR> 
                    <TD height=25 class="zhengwen">还款方式:</TD>
                    <TD height=25 class="zhengwen"> <SELECT name="inputSelect" id="inputSelect" onchange="chgobj();" style="font-size:12px;">
                        <OPTION value="等额本息还款" selected>等额本息还款</OPTION>
                        <OPTION value="等额本金还款">等额本金还款</OPTION>
                      </SELECT></TD>
                  </TR>
                  <TR>
                    <TD height=25 class="zhengwen">贷款利率(%):</TD>
                    <TD height=25><input name="active" type="text" id="active" class="inputBox"></TD>
                  </TR>
                  <TR> 
                    <TD height=25>&nbsp; </TD>
                    <TD height=25><img id=btnCalc
                  style="CURSOR: hand" onClick="checkCalc();" tabindex=7 
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
            <TD ><TABLE width="51%" height="100"  border="0" cellpadding="0" cellspacing="0" >
                <TBODY>
                  <TR id="tr_debj" style="display:none"> 
                    <TD height="25" align=left class=zhengwen >月还金额(元):</TD>
                    <TD height="25" align=left class=zhengwen ><textarea name="monthBackDEBJ" id="monthBackDEBJ" class="inputBox" rows="5" cols="20" readonly></textarea></TD>
                  </TR>
                  <TR id="tr_debx"> 
                    <TD height="25" align=left class=zhengwen >每月支付本息(元):</TD>
                    <TD height="25" align=left class=zhengwen > <INPUT id="monthBack" name="monthBack" type="text" class="inputBox" value="计算得出" style="width:112px; " disabled /></TD>
                  </TR>
                  <TR > 
                    <TD height="25" align=left class=zhengwen >累计支付利息(元):</TD>
                    <TD height="25" align=left class=zhengwen ><INPUT id="totalInterest" name="totalInterest" type="text" class="inputBox" value="计算得出" style="width:112px;" disabled /></TD>
                  </TR>
                  <TR >
                    <TD height="25" align=left class=zhengwen >累计还款总额(元):</TD>
                    <TD height="25" align=left class=zhengwen ><INPUT id="totalBack" name="totalBack" type="text" class="inputBox" value="计算得出" style="width:112px; " disabled /></TD>
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
              
            <TD valign="top" class="zhengwen">&nbsp;</TD>
          </TR>
        </TBODY>
      </TABLE>
	</td>
  </tr>
</table>
<script language="javascript">chgobj();</script>
<script language="JavaScript">
/*函数：住房贷款计算器计算公式
 *输入参数：original（贷款金额）         active（贷款利率）
 *          timeSpan（贷款时间：月份）   
 *	    objArray[0]为月还款额 objArray[1]为月还款总额
 *	    结果保留两位小数
 */
function estateBorrow(original,active,timeSpan){
	var monthBack=original*active*0.001*Math.pow((1+parseFloat(active*0.001)),parseFloat(timeSpan))/(Math.pow((1+parseFloat(active*0.001)),parseFloat(timeSpan))-1);
    var totalBack=monthBack*timeSpan;
    var totalInterest=totalBack-original;
    var monthInterest=totalInterest/timeSpan;
	totalInterest=(Math.round(totalInterest*100))/100;//存款利息：取两位小数
	monthInterest=(Math.round(monthInterest*10000))/10000;//存款利息：取两位小数	
	monthBack=(Math.round(monthBack*10000))/10000;//存款利息：取两位小数
    totalBack=(Math.round(totalBack*100))/100;//本息合计：取两位小数
    var objArray=new Array();
    objArray[0]=monthBack;
    objArray[1]=totalBack;
    objArray[2]=monthInterest;
    objArray[3]=totalInterest;        
    return objArray;
}
function estateBorrow1(original,active,timeSpan){
	active = active*0.001;
	var monthOriginal = original / timeSpan;
	var timeSpan1=parseInt(timeSpan);
	var interestTotal=0;	
	var backMonth = "";
	for(i=1;i<timeSpan1+1;i++){
		interestM=(original-original*(i-1)/timeSpan1)*active;
		backMonth += i + "月:" + (monthOriginal + interestM).toFixed(2) + "元";
		if(i<timeSpan1)backMonth+="\n";
		interestTotal=parseFloat(interestTotal)+parseFloat(interestM);			
	}
	var monthBack=original*active*Math.pow((1+parseFloat(active)),parseFloat(timeSpan))/(Math.pow((1+parseFloat(active)),parseFloat(timeSpan))-1);

	interestTotal=(Math.round(interestTotal*100))/100;//贷款利息：取两位小数
    var moneyTotal=parseFloat(original)+parseFloat(interestTotal);
    var objArray=new Array();
    objArray[0]=interestTotal;
    objArray[1]=moneyTotal;
	objArray[2] = backMonth;
    return objArray;
}
</script>
</body>
<#include "/template/foot.ftl"/>