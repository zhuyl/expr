 <#include "/template/head.ftl"/>
<body>
<table id="toolbar"></table>
<@table.table id="questionnaireTable" width="100%" align="center">
 <@table.thead>
   <@table.td text=""/>
   <@table.td text="题目序号"/>  
   <@table.td text="题目名称"/> 
   <@table.td text="案例名称"/>
   <@table.td text="制作人"/> 
 </@>
 <@table.tbody datas=(examQuestions?if_exists)?sort_by("code");examQuestion>
   <@table.selectTd id="examQuestionId" value=examQuestion.id type="radio"/>
   <td>${examQuestion.code?if_exists}</td>
   <td><a href="examQuestion.action?method=info&examQuestion.id=${examQuestion.id}">${examQuestion.name?if_exists}</a></td>
   <td><a href="${base}/caze.action?method=info&caze.id=${examQuestion.caze.id?if_exists}">${examQuestion.caze.name?if_exists}</a></td>   
   <td>${examQuestion.author?if_exists}</td>
   </@>
 </@>

<@htm.actionForm name="actionForm" action="examQuestion.action" entity="examQuestion">
</@>

  <script language="javascript">
     var bar = new ToolBar("toolbar","题目管理",null,true,true);
     bar.setMessage('<@getMessage/>');
     bar.addItem("添加","add()");
     bar.addItem("修改","edit()");
     bar.addItem("删除","remove()");
     bar.addItem("问题","questions()");
     bar.addItem("试题分析","analysis()");
     function questions(){
	 	var ids = getSelectIds("examQuestionId");
	 	if (ids == null || ids == "") {
	 		alert("你没有选择要操作的记录！");
	 		return false;
	 	}
		form.action="examItem.action?method=search&examItem.question.id="+ids;
		form.submit();
     }
      function analysis(){
	 	var ids = getSelectIds("examQuestionId");
	 	if (ids == null || ids == "") {
	 		alert("你没有选择要操作的记录！");
	 		return false;
	 	}
		form.action="examQuestion.action?method=questionAnalysis&examQuestionId="+ids;
		form.submit();
     }
  </script>
</body>
 <#include "/template/foot.ftl"/>