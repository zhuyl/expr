<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/itemSelect.js"></script>
<body>
<table id="backBar"></table>
<script>
   var bar = new ToolBar('backBar','理财方案图表统计',null,true,true);
   bar.setMessage('<@getMessage/>');
   bar.addHelp();
   function stat(td,kind){
      clearSelected(viewTables,td);
      setSelectedRow(viewTables,td);
      statFrame.location="analysisChartsStat.action?method="+kind+"&caze.id=${Parameters['caze.id']}";
   }
</script>
<table width="100%" height="93%" class="frameTable">
   <tr>
   <td valign="top" class="frameTable_view" width="20%" style="font-size:10pt">
      <table  width="100%" id ="viewTables" style="font-size:10pt">
	    <tr>
	      <td  class="infoTitle" align="left" valign="bottom">
	       <img src="${base}/static/images/action/info.gif" align="top"/>
	          <B>统计项目</B>      
	      </td>
	    <tr>
	      <td  colspan="8" style="font-size:0px">
	          <img src="${base}/static/images/action/keyline.gif" height="2" width="100%" align="top">
	      </td>
	   </tr>    
       <tr>
         <td class="padding"  onclick="stat(this,'incomeExpense')"  onmouseover="MouseOver(event)" onmouseout="MouseOut(event)">
         &nbsp;&nbsp;<image src="${base}/static/images/action/info.gif"> 收支结构对比
         </td>
       </tr>
       <tr>
         <td class="padding"  onclick="stat(this,'insuranceAnalysis')"  onmouseover="MouseOver(event)" onmouseout="MouseOut(event)">
         &nbsp;&nbsp;<image src="${base}/static/images/action/info.gif"> 保险资产结构对比
         </td>
       </tr>
       <tr >
         <td class="padding" onclick="stat(this,'financeAssetAnalysis')"  onmouseover="MouseOver(event)" onmouseout="MouseOut(event)">
          &nbsp;&nbsp;<image src="${base}/static/images/action/info.gif"> 金融资产结构对比
         </td>
       </tr>
	  </table>
	<td>
	<td valign="top">
     	<iframe name="statFrame" src="analysisChartsStat.action?method=incomeExpense&caze.id=${Parameters['caze.id']}" width="100%" frameborder="0" scrolling="no">
	</td>
</table>
<#include "/template/foot.ftl"/>
