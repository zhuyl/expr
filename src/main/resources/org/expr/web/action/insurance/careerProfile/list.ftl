<#include "/template/head.ftl"/>
<BODY>
  <table id="toolbar"></table>
  <@getMessage/>
  <@table.table width="100%"  id="listTable" sortable="true">
    <@table.thead>
       <@table.selectAllTd id="careerProfileId"/>
       <@table.td text="职业等级方案名称" id="careerProfile.name"/>
    </@>
    <@table.tbody datas=careerProfiles;profile>
       <@table.selectTd id="careerProfileId" value=profile.id type="checkbox"/>
       <td>${profile.name}</td>
    </@>
   </@>
   <@htm.actionForm name="actionForm" action="careerProfile.action" entity="careerProfile"/>
  <script language="javascript">
     var bar = new ToolBar("toolbar","职业等级方案列表",null,true,true);
     bar.addItem("添加","add()");
     bar.addItem("修改","edit()");
     bar.addItem("删除","remove()");
     bar.addItem("职业表","careerList()");
    function careerList(){		
	   var ids = getSelectIds("careerProfileId");
	 	if (ids == null || ids == "") {
	 		alert("你没有选择要操作的记录！");
	 		return false;
	 	}
		form.action="${base}/insurance/career!search.action?profile.id="+ids;
		form.submit();
	}
  </script>
</body>
<#include "/template/foot.ftl"/>