<#include "/template/head.ftl"/>
<BODY>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/system/BaseInfo.js"></script>
 <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
    <#include "../teacherLesson/lessonNav.ftl"/>
      </td>
  </tr>  
  <tr>
</table>
 <table id="taskBar"></table>
<script>
  var bar = new ToolBar('taskBar', '${experiment.name}实验指导', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
  bar.addItem("导出","exportStudent()");
  bar.addItem("发送",'addSelected()','send.gif');
  bar.addBack("<@text name="action.back"/>"); 
  function exportStudent(){
  	 document.actionForm.action="experiment!export.action?experimentId=${experiment.id}&template=" + encodeURI('org/expr/web/action/experiment/experiment.xls');
  	  document.actionForm.submit();
  }
</script>
 <@getMessage/>
  <@table.table width="100%"  id="listTable" sortable="true">
    <@table.thead>
       <@table.td text=""/>
       <@table.td text="序号"/>
       <@table.sortTd text="学号" id="student.code"/>
       <@table.sortTd text="姓名" id="student.name"/>
       <@table.td text="累积学习时间" />
       <@table.td text="作业批改" />
       <@table.td text="作业得分"/>
    </@>
    <#if students??>
    <@table.tbody datas=students?if_exists;student,studentIndex>
	   <@table.selectTd id="studentId" value=student.id />
	    <td>${studentIndex+1}</td>
	    <td>${student.code}</td>
        <td>${student.name}</td>
        <td><#if experimenttimes[student.id?string]??><a href="studyLog.action?method=studentStudyLogs&studentcode=${student.code}&experimentId=${experiment.id}" target="_blank">${(experimenttimes[student.id?string]/60)?int}分${(experimenttimes[student.id?string]%60)}秒</a></#if></td>
        <td>                            	
    		<#if cazeResults.get(student.id)?if_exists.isSubmit?if_exists == true>
    		<a target="_blank" href="experimentCheck!index.action?std.id=${student.id}&experiment.id=${experiment.id}">作业批改(${cazeResults.get(student.id)?if_exists.submitAt?if_exists})</a>
    		&nbsp;&nbsp;&nbsp;&nbsp;<a href="experiment!cancelAnswer.action?std.id=${student.id}&experimentId=${experiment.id}&lesson.id=${Parameters['lesson.id']}&orderBy=student.code asc">退回修改</a>
    		<#else>
    		作业未提交    		
			</#if>	
        </td>
        <td><#if (cazeResults.get(student.id).score)??><a  target="_blank" title="点击查看详细结果" href="experimentCheck!checkResult.action?std.id=${student.id}&experiment.id=${experiment.id}">${(cazeResults.get(student.id).score)!0}</a></#if></td>
    </@>
    </#if>
  </@>
    <form name="actionForm" method="post" action="lessonMessage.action?method=newStudentMessage" target="_blank">
    <input name="studentId" value="" type="hidden"/>
    <input name="studentCode" value="" type="hidden"/>   
    <input name="lesson.id" value="${experiment.lesson.id}" type="hidden"/>
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