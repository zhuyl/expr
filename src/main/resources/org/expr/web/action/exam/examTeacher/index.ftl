 <#include "/template/head.ftl"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td>
                <#include "../../teacherLesson/lessonNav.ftl"/>
                  </td>
              </tr>  
 			  <tr>
			    <td height="34"> 
<table id="taskBar"></table>
<script>
  var bar = new ToolBar('taskBar', '${lesson.coursename}测试列表', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
  bar.addItem("添加","add()");
</script>
			  </td>
			  </tr>		  
              <tr>
                <td>
 <@table.table width="100%" sortable="true" id="noticeTable" style="word-break: break-all">
     <@table.thead>
	    <@table.td text="测试编号"/>
	    <@table.td text="测试名称"/>
	    <@table.td text="测试有效时间"/>
	    <@table.td text="测试用时"/>
	    <@table.td text="学生测试查看"/> 
	    <@table.td text="试卷分析"/> 
	    <@table.td text="修改"/>
	    <@table.td text="删除"/>	   	    
	   </@>
	   <@table.tbody datas=examPapers?sort_by("code");paper>               
                             <td>${paper.code}</td>
                            <td><a href="examTeacher!info.action?examPaperId=${paper.id}">${paper.name}</a></td>
                            <td>${paper.beginAt?string("yyyy-MM-dd HH:mm")}-${paper.endAt?string("yyyy-MM-dd HH:mm")}</td>
                            <td>${paper.period!}分钟</td>
                            <td><a href="examTeacher!studentList.action?examPaperId=${paper.id}&lesson.id=${paper.lesson.id}&orderBy=student.code asc">学生测试查看</a></td>
                            <td><a href="examTeacher!examAnalysis.action?examPaperId=${paper.id}">试卷分析</a></td>                              
                            <td><a href="examTeacher!edit.action?examPaperId=${paper.id}">修改</a></td>  
                            <td><a href="#" onclick="remove(${paper.id})">删除</a></td>                     
      </@>
 </@>               
</td>
</tr>
 </table>
 
 <form name="actionForm" method="post" action="examTeacher.action?method=remove">
    <input name="examPaperId" value="" type="hidden"/>
    <input name="params" value="&lesson.id=${lesson.id}" type="hidden"/>
 </form>
<script>
  function add(){
  document.actionForm.action="examTeacher!edit.action?lessonId=${lesson.id}";
         document.actionForm.submit();
  }

  function remove(id){
      if(confirm("确定删除该测试?")){
         document.actionForm['examPaperId'].value=id;
         document.actionForm.submit();
      }
  }
</script>