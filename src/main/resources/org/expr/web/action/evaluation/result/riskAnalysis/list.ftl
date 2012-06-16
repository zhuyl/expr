 <#include "/template/head.ftl"/>
<body>
<table id="toolbar"></table>
  <table class="formTable" align="center" width="80%">
	<form name="editForm" method="post" action="${base}/result/riskAnalysis!saveRemark.action">
	<input type="hidden" name="experiment.id" value="${Parameters['experiment.id']}">
	<tr><td>单个产品风险分析说明:
	<textarea id="noticeContent" name="remark"  style="font-size:10pt;width:100%;height:80px">${(analysisResult.remark)!}</textarea>
 	</td></tr>
 	<tr><td align="right"><input value="提交" type="submit"></td></tr>
 </form>
 </table>
<@table.table id="memberTable" width="80%" align="center">
 <@table.thead>
   <@table.selectAllTd id="riskItemResultId" />
   <@table.td text="产品类型"/>
   <@table.td text="风险分析"/>
 </@>
 <@table.tbody datas=results;result>
   <@table.selectTd id="riskItemResultId" value=result.id type="checkbox"/>
   <td>${(result.financetype.name)!}</td>
   <td>${(result.content)!}</td>
   </@>
 </@>

<@htm.actionForm name="actionForm" action="riskAnalysis.action" entity="riskItemResult">
  <input type="hidden" name="experiment.id" value="${Parameters['experiment.id']}"/>
</@>
  <script language="javascript">
     var bar = new ToolBar("toolbar","单个产品风险分析",null,true,true);
     bar.setMessage('<@getMessage/>');
     bar.addItem("添加","add()");
     bar.addItem("修改","edit()");
     bar.addItem("删除","remove()");
  </script>
</body>
 <#include "/template/foot.ftl"/>