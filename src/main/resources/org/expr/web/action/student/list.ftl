<#include "/template/head.ftl"/>
<BODY>
<table id="bar" width="100%"></table>
  <@table.table width="100%"  id="listTable" sortable="true">
    <@table.thead>
       <@table.td text=""/>
       <@table.sortTd name="学生学号" id="student.code"/>
       <@table.sortTd name="学生姓名" id="student.name"/>
    </@>
    <@table.tbody datas=students;student>
       <@table.selectTd id="studentId" value=student.id type="radio"/>
       <td>${student.code}</td>
       <td>${student.name?if_exists}</td>
      </@>
   </@>
   <@htm.actionForm name="actionForm" entity="student" action="student.action"/>
  <script language="javascript">
     var bar = new ToolBar("bar","学生列表",null,true,true);
     bar.addItem("添加","add()");
     bar.addItem("修改","edit()");
     bar.addItem("删除","remove()");
  </script>
</body>
<#include "/template/foot.ftl"/>
