<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/calendar1.js" charset="gb2312"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/CheckDataFunction1.js" charset="gb2312"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/GetRate.js" charset="gb2312"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/Components.js" charset="gb2312"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/base.js" charset="gb2312"></script>
<SCRIPT language="javascript" charset="gb2312">

function calc(oDocument)
{
	var ratio = 0;
	var endsum = 0;
	var type = oDocument.all.cbTerm.options[oDocument.all.cbTerm.selectedIndex].value;
	var result = "";

	if ((type==2)||(type==3)||(type==5))
	{
		ratio = oDocument.all.yearratio.value;
		endsum = Execute(type,ratio,oDocument.all.edSum.value);
		result = "您可以一次存"+type+"年期定期存款。税后到期本息总额为";
	}
	if (type==4)
	{
		ratio = oDocument.all.yearratio.value;
		endsum = Execute(1,ratio,oDocument.all.edSum.value);

		ratio = oDocument.all.yearratio.value;
		endsum = Execute(3,ratio,endsum);
		result = "您可以考虑先存1年期定期存款，到期本息再转存3年期定期存款。税后到期本息总额为";
	}
	if ((type==6)||(type==7)||(type==8)||(type==10))
	{
		ratio = oDocument.all.yearratio.value;
		endsum = Execute(type-5,ratio,oDocument.all.edSum.value);

		ratio = oDocument.all.yearratio.value;
		endsum = Execute(5,ratio,endsum);
		result = "您可以考虑先存"+(type-5)+"年期定期存款，到期本息再转存5年期定期存款。税后到期本息总额为";
	}
	if (type==9)
	{
		ratio = oDocument.all.yearratio.value;
		endsum = Execute(1,ratio,oDocument.all.edSum.value); 

		ratio = oDocument.all.yearratio.value;
		endsum = Execute(3,ratio,endsum);

		ratio = oDocument.all.yearratio.value;
		endsum = Execute(5,ratio,endsum);
		result = "您可以考虑先存1年期定期存款，到期本息再转存3年期定期存款，到期后本息再存入5年期定期存款。税后到期本息总额为";
	}
	window.lbResult.innerText = result+NBround(new Number(endsum),2)+"元";
	return false;
}

function Execute(type,ratio,edSum)
{
	var EndSum=0;

	EndSum=edSum*(1+0.8*ratio/100*type);
	EndSum=NBround(EndSum,2);
	return EndSum;
}
</script>



<body>
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCFF" style="border-collapse:collapse;" >
  <tr>
    <td height="23" background="titlebg.gif"><img src="titlearrow.gif" width="8" height="13"> 
      <span class="title"><strong>最佳存款时间组合计算器</strong></span> </td>
  </tr>
  <tr> 
    <td>
	  <FORM id=SavingCombCalc name=SavingCombCalc onsubmit="return false;">
	<table width="100%">
        <tr>
			<td>
	
                <div class="formula">
                    <div class="explain"><B>最佳存款时间组合计算器可以帮您计算最好的存款方式</B></div>
    	            <div class="header">计算公式</div>
    	            <div class="line">
    	                <div class="text">初始存入金额：</div>
    	                <INPUT class="inputBox" id=edSum onblur="CheckData()"  style="WIDTH: 120px" name="edSum">
                        </div>
                    <div class="line">
                        <div class="text">预期储蓄存期:</div>
<SELECT id=cbTerm style="WIDTH: 120px" tabIndex=1 name=cbTerm> 
                     <OPTION value=2 selected>2年</OPTION> <OPTION 
                    value=3>3年</OPTION> <OPTION value=4>4年</OPTION> <OPTION 
                    value=5>5年</OPTION> <OPTION value=6>6年</OPTION> <OPTION 
                    value=7>7年</OPTION> <OPTION value=8>8年</OPTION> <OPTION 
                    value=9>9年</OPTION> <OPTION value=10>10年</OPTION>
					</SELECT>
                </div>
                    <div class="line">
                        <div class="text">年利率(%):</div>
                         <div><INPUT class="inputBox" id=yearratio size=4 name=yearratio></div>
                          <DIV class=btnDiv><INPUT class=btn id=btnCalc type=button onclick="javascript:if (CheckData()) calc(document);"  name=btnCalc  value=" 计算 " >
                          </DIV></DIV>
                    <div class="header">计算结果</div>
    	            <div class="line">
                       <SPAN id=lbResult style="WIDTH: 425px; HEIGHT: 49px; TEXT-ALIGN: left"></SPAN>   
                    </div>
                    <div class="header"></div>
                    <div class="remark"><b>说明：</b></div>
            </div>
			</td>
		</tr>
	</table>
	</form>
	</td>
  </tr>
</table>
<SCRIPT language=javascript>
function CheckData()
{
 if (! CheckFN3(document.all.SavingCombCalc.edSum,"请在初始存入金额输入正数",false))
	 return false;
else
	return true;
}
</SCRIPT>
</body>
<#include "/template/foot.ftl"/>