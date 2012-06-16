<#include "/template/head.ftl"/>
<BODY>
  <table id="toolbar"></table>
  <table class="formTable" align="center" width="80%">
	<form name="editForm" method="post" action="${base}/result/financeAssetAnalysis!saveRemark.action">
	<input type="hidden" name="experiment.id" value="${Parameters['experiment.id']}">
	<tr><td>金融资产明细分析说明:
	<textarea id="noticeContent" name="remark"  style="font-size:10pt;width:100%;height:80px">${(analysisResult.remark)!}</textarea>
 	</td></tr>
 	<tr><td align="right"><input value="提交" type="submit"></td></tr>
 </form>
 </table>
  <@getMessage/>
  <@table.table width="80%"  align="center" id="listTable" sortable="true">
    <@table.thead>
   <@table.selectAllTd id="financeAssetResultId" />
       <@table.sortTd name="资产名称" id="asset.asset.name"/>
       <@table.sortTd name="资产类型" id="asset.asset.financetype"/>
       <@table.sortTd name="风险等级" id="asset.asset.riskgrade"/>   
       <@table.sortTd name="流动性" id="asset.asset.mobility"/>
       <@table.sortTd name="计息周期" id="asset.asset.ratepayperiod"/>  
       <@table.sortTd name="年收益率(%)" id="asset.asset.rate"/>
       <@table.sortTd name="投资金额(元)" id="asset.asset.amount"/>                           
    </@>
    <@table.tbody datas=results;result>
       <@table.selectTd id="financeAssetResultId" value=result.id type="checkbox"/>
       <td>${result.asset.name?if_exists}</td>
       <td>${(result.asset.financetype.parent?if_exists).name?if_exists}|${(result.asset.financetype?if_exists).name?if_exists}</td> 
       <td>${(result.asset.riskgrade?if_exists).name?if_exists}</td>
       <td>${(result.asset.mobility.name?if_exists)?if_exists}</td>
       <td>${(result.asset.ratepayperiod?if_exists).name?if_exists}</td>
       <td>${result.asset.rate?if_exists}%</td> 
       <td>${result.asset.amount?if_exists}</td>                             
    </@>
   </@>
   <@htm.actionForm name="actionForm" action="financeAssetAnalysis.action" entity="financeAssetResult">
     <input type="hidden" name="experiment.id" value="${Parameters['experiment.id']}"/>
   </@>
  <script language="javascript">
     var bar = new ToolBar("toolbar","金融资产明细分析",null,true,true);
     bar.addItem("添加","add()");
     bar.addItem("修改","edit()");
     bar.addItem("删除","remove()");
  </script>
</body>
<#include "/template/foot.ftl"/>