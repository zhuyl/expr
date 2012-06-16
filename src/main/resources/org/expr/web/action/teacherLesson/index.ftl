 <#include "/template/head.ftl"/>
  <table id="taskBar"></table>
<script>
  var bar = new ToolBar('taskBar', '在授课程', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
  bar.addBlankItem();
</script>
 <@table.table width="100%" sortable="true" id="noticeTable" style="word-break: break-all">
     <@table.thead>
	    <@table.td text="课程序号"/>
	    <@table.td text="课程名称"/>
	    <@table.td text="主讲教师"/>   	    
	   </@>
	   <@table.tbody datas=curLessons;lesson>
	     <td>${lesson.seqNo}</td>
         <td><a href="experiment.action?lesson.id=${lesson.id}">${lesson.coursename}</a></td>
         <td><#list lesson.teachers as teacher>${teacher.name}</#list> </td>
        </@>
	   </@>
<table id="taskBar2"></table>
<script>
  var bar = new ToolBar('taskBar2', '已授课程', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
  bar.addBlankItem();
</script>
 <@table.table width="100%" sortable="true" id="noticeTable" style="word-break: break-all">
     <@table.thead>
	    <@table.td text="课程序号"/>
	    <@table.td text="课程名称"/>
	    <@table.td text="主讲教师"/>   	    
	   </@>
	   <@table.tbody datas=hisLessons;lesson>
	     <td>${lesson.seqNo}</td>
         <td><a href="experiment.action?lesson.id=${lesson.id}">${lesson.coursename}</a></td>
         <td><#list lesson.teachers as teacher>${teacher.name}</#list> </td>
        </@>
	   </@>