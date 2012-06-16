<#include "/template/head.ftl"/>
<BODY>
<table id="myBar"></table>
  <@table.table width="100%"  id="listTable" sortable="true">
    <@table.thead>
       <@table.td text=""/>
       <@table.sortTd text="课程代码" id="lesson.seqNo"/>
       <@table.sortTd text="课程名称" id="lesson.coursename"/>
       <@table.td text="主讲教师" id="lesson.teacher.name"/>
       <@table.sortTd text="开始时间" id="lesson.beginAt"/>
       <@table.sortTd text="结束时间" id="lesson.endAt"/>
    </@>
    <@table.tbody datas=lessons;lesson>
       <@table.selectTd id="lessonId" value=lesson.id type="radio"/>
       <td>${lesson.seqNo}</td>
       <td><a href="lesson.action?method=info&lesson.id=${lesson.id}">${lesson.coursename?if_exists}</a></td>
       <td><@getBeanListNames lesson.teachers?if_exists/></td>
       <td>${(lesson.beginAt?string("yyyy-MM-dd"))?if_exists}</td>
       <td>${(lesson.endAt?string("yyyy-MM-dd"))?if_exists}</td>
    </@>
   </@>
   <@htm.actionForm name="actionForm" entity="lesson" action="lesson.action"/>
  <script language="javascript">
    var bar=new ToolBar('myBar',"课程列表",null,true,false);
    bar.setMessage('<@getMessage/>');
    bar.addItem("新增",add);
    bar.addItem("学生名单","stdList()");
    bar.addItem("查看",info);
    bar.addItem("修改",edit);
    bar.addItem("删除","remove()");
    function  stdList(){
    	singleAction("stdList","_self",null);
    }
  </script>
</body>
<#include "/template/foot.ftl"/>
