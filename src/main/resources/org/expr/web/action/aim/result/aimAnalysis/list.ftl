 <#include "/template/head.ftl"/>
<body>
<table id="toolbar"></table>
  <table class="formTable" align="center" width="80%">
	<form name="editForm" method="post" action="${base}/result/aimAnalysis!saveRemark.action">
	<input type="hidden" name="experiment.id" value="${Parameters['experiment.id']}">
	<tr><td>理财目标分析说明:
	<textarea id="noticeContent" name="remark"  style="font-size:10pt;width:100%;height:80px">${(analysisResult.remark)!}</textarea>
 	</td></tr>
 	<tr><td align="right"><input value="提交" type="submit"></td></tr>
 </form>
 </table>
<@table.table id="memberTable" width="80%" align="center">
 <@table.thead>
   <@table.selectAllTd id="aimItemResultId" />
   <@table.td text="目标类型"/>
   <@table.td text="目标内容"/>
 </@>
 <@table.tbody datas=results;result>
   <@table.selectTd id="aimItemResultId" value=result.id type="checkbox"/>
   <td>${(result.aimtype.name)!}</td>
   <td>${(result.content)!}</td>
   </@>
 </@>

<@htm.actionForm name="actionForm" action="aimAnalysis.action" entity="aimItemResult">
  <input type="hidden" name="experiment.id" value="${Parameters['experiment.id']}"/>
</@>
  <script language="javascript">
     var bar = new ToolBar("toolbar","理财目标分析",null,true,true);
     bar.setMessage('<@getMessage/>');
     bar.addItem("添加","add()");
     bar.addItem("修改","edit()");
     bar.addItem("删除","remove()");
  </script>
</body>
 <#include "/template/foot.ftl"/>