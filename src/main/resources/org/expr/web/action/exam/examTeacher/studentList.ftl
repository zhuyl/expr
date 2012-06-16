<#include "/template/head.ftl"/>
<BODY>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/system/BaseInfo.js"></script>
 <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
    <#include "../../teacherLesson/lessonNav.ftl"/>
      </td>
  </tr>  
  <tr>
</table>
 <table id="taskBar"></table>
<script>
  var bar = new ToolBar('taskBar', '${examPaper.lesson.coursename}课程-${examPaper.name}(共${totals}人，已提交${submiteds}人)', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
  bar.addItem("导出","exportStudent()");
  bar.addItem("发送",'addSelected()','send.gif');
  bar.addBack("<@text name="action.back"/>"); 
  function exportStudent(){
  	 document.actionForm.action="examTeacher!export.action?lessonId=${examPaper.lesson.id}&examPaperId=${examPaper.id}&template=" + encodeURI('org/expr/web/action/exam/examTeacher/examMark.xls');
  	  document.actionForm.submit();
  }
</script>
 <@getMessage/>
  <@table.table width="100%"  id="listTable" sortable="true">
    <@table.thead>
       <@table.td text=""/>
       <@table.td text="序号"/>
       <@table.td text="学号" id="student.code"/>
       <@table.td text="姓名" id="student.name"/>
       <@table.td text="测试时间" />
       <@table.td text="测试得分"/>
    </@>
    <#if students??>
    <@table.tbody datas=(students?if_exists)?sort_by("code");student,studentIndex>
	   <@table.selectTd id="studentId" value=student.id />
	    <td>${studentIndex+1}</td>
	    <td>${student.code}</td>
        <td>${student.name}</td>
        <#if examPaperResults.get(student.id).mark?exists>
        <td>
           ${(examPaperResults.get(student.id).beginAt)?string("yyyy-MM-dd HH:mm")}-${(examPaperResults.get(student.id).beginAt)?string("yyyy-MM-dd HH:mm")}
           	<a href="examTeacher!backTest.action?examPaperId=${examPaper.id}&studentId=${student.id}">退回重测</a>
        </td>
        <td>
        <a target="_blank" title="点击查看详细结果" href="examTeacher.action?method=examAnswer&examPaperId=${examPaper.id}&studentId=${student.id}">${examPaperResults.get(student.id).mark}</a>
        </td>
        <#else>
        <td></td>
        <td></td>
        </#if>               
    </@>
    </#if>
  </@>
    <form name="actionForm" method="post" action="../lessonMessage.action?method=newStudentMessage" target="_blank">
    <input name="studentId" value="" type="hidden"/>
    <input name="studentCode" value="" type="hidden"/>   
    <input name="lesson.id" value="${examPaper.lesson.id}" type="hidden"/>
    <input name="params" value="" type="hidden"/>
 </form>
  <script language="javascript">
   type="student";
   defaultOrderBy="${Parameters['orderBy']?default('null')}";
   
      function addSelected(){
   	var studentId = getSelectIds("studentId");
   	if(studentId!=""){
   	
		document.actionForm.studentId.value = studentId;
        document.actionForm.submit();
	}else
	{
	alert("请选择学生！");
   }
   
	}
  </script>
</body>
<#include "/template/foot.ftl"/>