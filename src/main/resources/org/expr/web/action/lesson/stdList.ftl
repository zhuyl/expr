<#include "/template/head.ftl"/>
<BODY>
<table id="myBar"></table>
  <@table.table width="100%"  id="listTable" sortable="true">
    <@table.thead>
       <@table.selectAllTd id="studentId"/>
       <@table.td text="学号" id="student.code"/>
       <@table.td text="姓名" id="student.name"/>
    </@>
    <@table.tbody datas=students?sort_by("code");student>
       <@table.selectTd id="studentId" value=student.id type="checkbox"/>
       <td>${student.code}</td>
       <td>${student.name}</td>
    </@>
   </@>
   <@htm.actionForm name="actionForm" entity="student" action="lesson.action">
   <input type="hidden" name="lesson.id" value="${lesson.id}">
   <input type="hidden" name="params" value="&lesson.id=${lesson.id}">
   </@>
  <script language="javascript">
    var bar=new ToolBar('myBar',"${lesson.coursename!}课程学生列表",null,true,false);
    bar.setMessage('<@getMessage/>');
    bar.addItem("导入学生名单","importStd()");
    bar.addItem("删除","removeStd()");
    bar.addBack();
    function  importStd(){
    	form.action="lesson!importStdForm.action?lessonId=${lesson.id}";
		form.submit();
    }
    function removeStd()
    {
    	multiAction("removeStd","确认是否删除学生?");
    }
  </script>
</body>
<#include "/template/foot.ftl"/>