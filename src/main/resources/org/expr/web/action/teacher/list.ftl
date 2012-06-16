<#include "/template/head.ftl"/>
<BODY>
<table id="bar" width="100%"></table>
  <@table.table width="100%"  id="listTable" sortable="true">
    <@table.thead>
       <@table.td text=""/>
       <@table.sortTd name="教师工号" id="teacher.code"/>
       <@table.sortTd name="教师姓名" id="teacher.name"/>
    </@>
    <@table.tbody datas=teachers;teacher>
       <@table.selectTd id="teacherId" value=teacher.id type="radio"/>
       <td>${teacher.code}</td>
       <td>${teacher.name?if_exists}</td>
      </@>
   </@>
   <@htm.actionForm name="actionForm" entity="teacher" action="teacher.action"/>
  <script>
 var bar=new ToolBar("bar","教师列表",null,true,true);
  bar.addItem("添加","add()");
  bar.addItem("修改","edit()");
  bar.addItem("删除","remove()");
  </script>
</body>
<#include "/template/foot.ftl"/>
