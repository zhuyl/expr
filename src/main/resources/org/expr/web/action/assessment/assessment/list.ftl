 <#include "/template/head.ftl"/>
<body>
<table id="toolbar"></table>
<@table.table id="assessmentTable" width="100%" align="center">
 <@table.thead>
   <@table.td text=""/>
   <@table.td text="评估标准名称"/>
   <@table.td text="制作人"/>
   <@table.td text="说明"/>   
 </@>
 <@table.tbody datas=assessments;assessment>
   <@table.selectTd id="assessmentId" value=assessment.id type="radio"/>
   <td><a href="assessment!info.action?assessment.id=${assessment.id}">${assessment.name}</a></td>
   <td>${assessment.author?if_exists}</td>
   <td>${assessment.remark?if_exists}</td>   
   </@>
 </@>

<@htm.actionForm name="actionForm" action="assessment.action" entity="assessment">
</@>

  <script language="javascript">
     var bar = new ToolBar("toolbar","评估标准管理",null,true,true);
     bar.addItem("添加","add()");
     bar.addItem("修改","edit()");
     bar.addItem("删除","remove()");
     bar.addItem("项目管理","items()");
     function items(){
	 	var ids = getSelectIds("assessmentId");
	 	if (ids == null || ids == "") {
	 		alert("你没有选择要操作的记录！");
	 		return false;
	 	}
		form.action="assessItem.action?method=search&assessment.id="+ids;
		form.submit();
     }
  </script>
</body>
 <#include "/template/foot.ftl"/>