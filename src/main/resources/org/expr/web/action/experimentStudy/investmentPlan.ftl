<#include "/template/head.ftl"/>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckeditor.js"></script>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckTextArea.js"></script>
<body>
<table id="taskBar"></table>
<script>
  var bar = new ToolBar('taskBar', '金融投资规划', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
  bar.addItem('添加', 'addInvestment()');
  bar.addItem('修改', 'editInvestment()');
  bar.addItem('删除', 'removeInvestment()');
</script>
  <table class=listTable id="listTable" width="80%" sortable="true" align="center">
   <tr align="center" class="darkColumn" >   <td text=""></td>
   <td name="产品名称" id="finance.name" class="tableHeaderSort">产品名称</td>
   <td name="产品类型" id="finance.financetype" class="tableHeaderSort">产品类型</td>
   <td name="风险等级" id="finance.riskgrade" class="tableHeaderSort">风险等级</td>
   <td name="流动性" id="finance.mobility" class="tableHeaderSort">流动性</td>
   <td name="计息周期" id="finance.ratepayperiod" class="tableHeaderSort">计息周期</td>
   <td name="利息率" id="finance.rate" class="tableHeaderSort">利息</td>
   <td name="金额" id="finance.rate" class="tableHeaderSort">金额（元）</td>
</tr>
    <tbody>
   <tr class="brightStyle" align="center" onmouseover="swapOverTR(this,this.className)"onmouseout="swapOutTR(this)" onclick="onRowChange(event)">   <td class="select"><input class="box" name="financeId" value="3"  type="radio"></td>
       <td><a href="finance.action?method=info&finance.id=3">人民币活期存款</a></td>
       <td>活期储蓄</td> 
       <td>低</td>
       <td>强</td>
       <td>随时</td>
       <td>0.74%</td> 
      <td>20000</td>                       
</tr>
   <tr class="grayStyle" align="center" onmouseover="swapOverTR(this,this.className)"onmouseout="swapOutTR(this)" onclick="onRowChange(event)">   <td class="select"><input class="box" name="financeId" value="5"  type="radio"></td>
       <td><a href="finance.action?method=info&finance.id=5">人民币定期一年</a></td>
       <td>整存整取</td> 
       <td>低</td>
       <td>中</td>
       <td>1年</td>
       <td>2.67%</td>
       <td>50000</td>                        
</tr>
	   <tr class="darkColumn">
	    <td colspan="32" align="center">
	      	      &nbsp;
	      &nbsp;
	      该页2共2条&nbsp;
	      每页<select id="myPageSize" name="pageSize" onChange="go(1,this.value)">
	         <option value="10" >10</option>
	         <option value="15" >15</option>
	         <option value="20" selected>20</option>
  	         <option value="25" >25</option>
	         <option value="30" >30</option>
	         <option value="50" >50</option>
	         <option value="70" >70</option>
	         <option value="90" >90</option>
	         <option value="100" >100</option>
	         <option value="150" >150</option>
	         <option value="300" >300</option>
	         <option value="1000" >1000</option>
	        </select>
	      <input type="text" id="myPageNo" name="pageNo" value="1" style="width:30px;background-color:#CDD6ED">/1
	      <input type="button" name="button11" value="GO" class="buttonStyle" onClick="go()">
	    </td>
	   </tr>
</table>

</body>
<#include "/template/foot.ftl"/>