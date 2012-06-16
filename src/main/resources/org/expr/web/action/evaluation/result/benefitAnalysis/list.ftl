 <#include "/template/head.ftl"/>
<body>
<table id="toolbar"></table>
  <table class="formTable" align="center" width="80%">
	<form name="editForm" method="post" action="${base}/result/benefitAnalysis!saveRemark.action">
	<input type="hidden" name="experiment.id" value="${Parameters['experiment.id']}">
	<tr><td>单个产品收益率分析说明:
	<textarea id="noticeContent" name="remark"  style="font-size:10pt;width:100%;height:80px">${(benefitResult.remark)!}</textarea>
 	</td></tr>
 	<tr><td align="right"><input value="提交" type="submit"></td></tr>
 </form>
 </table>
<@table.table id="memberTable" width="80%" align="center">
 <@table.thead>
   <@table.selectAllTd id="benefitItemResultId" />
   <@table.td text="产品类型"/>
   <@table.td text="收益率分析"/>
 </@>
 <@table.tbody datas=items;item>
   <@table.selectTd id="benefitItemResultId" value=item.id type="checkbox"/>
   <td>${(item.financetype.name)!}</td>
   <td>${(item.content)!}</td>
   </@>
 </@>

<@htm.actionForm name="actionForm" action="benefitAnalysis.action" entity="benefitItemResult">
  <input type="hidden" name="experiment.id" value="${Parameters['experiment.id']}"/>
</@>
  <script language="javascript">
     var bar = new ToolBar("toolbar","单个产品收益率分析",null,true,true);
     bar.setMessage('<@getMessage/>');
     bar.addItem("添加","add()");
     bar.addItem("修改","edit()");
     bar.addItem("删除","remove()");
  </script>
</body>
 <#include "/template/foot.ftl"/>