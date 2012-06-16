 <#include "/template/head.ftl"/>
<body>
<table id="toolbar"></table>
  <table class="formTable" align="center" width="80%">
	<form name="editForm" method="post" action="${base}/answer/aimAnalysis!saveRemark.action">
	<input type="hidden" name="caze.id" value="${Parameters['caze.id']}">
	<tr><td>理财目标分析说明:
	<textarea id="noticeContent" name="remark"  style="font-size:10pt;width:100%;height:80px">${(analysisAnswer.remark)!}</textarea>
 	</td></tr>
 	<tr><td align="right"><input value="提交" type="submit"></td></tr>
 </form>
 </table>
<@table.table id="memberTable" width="80%" align="center">
 <@table.thead>
   <@table.selectAllTd id="aimItemAnswerId" />
   <@table.td text="目标类型"/>
   <@table.td text="目标内容"/>
 </@>
 <@table.tbody datas=answers;answer>
   <@table.selectTd id="aimItemAnswerId" value=answer.id type="checkbox"/>
   <td>${(answer.aimtype.name)!}</td>
   <td>${(answer.content)!}</td>
   </@>
 </@>

<@htm.actionForm name="actionForm" action="aimAnalysis.action" entity="aimItemAnswer">
  <input type="hidden" name="caze.id" value="${Parameters['caze.id']}"/>
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