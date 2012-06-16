 <#include "/template/head.ftl"/>
<body>
<table id="toolbar"></table>
<@table.table id="questionnaireTable" width="100%" align="center">
 <@table.thead>
   <@table.td text=""/>
   <@table.td text="问卷名称"/>
   <@table.td text="制作人"/>
   <@table.td text="问卷类型"/>   
   <@table.td text="问卷状态"/>
 </@>
 <@table.tbody datas=questionnaires;questionnaire>
   <@table.selectTd id="questionnaireId" value=questionnaire.id type="radio"/>
   <td><a href="questionnaire!info.action?questionnaire.id=${questionnaire.id}">${questionnaire.name}</a></td>
   <td>${questionnaire.author?if_exists}</td>
   <td>${questionnaire.type.name?if_exists}</td>   
   <td>${(questionnaire.status!false)?string("有效","无效")}</td>
   </@>
 </@>

<@htm.actionForm name="actionForm" action="questionnaire.action" entity="questionnaire">
</@>

  <script language="javascript">
     var bar = new ToolBar("toolbar","问卷管理",null,true,true);
     bar.setMessage('<@getMessage/>');
     bar.addItem("添加","add()");
     bar.addItem("修改","edit()");
     bar.addItem("删除","remove()");
     bar.addItem("问题","questions()");
     bar.addItem("得分等级","ranks()");
     function questions(){
	 	var ids = getSelectIds("questionnaireId");
	 	if (ids == null || ids == "") {
	 		alert("你没有选择要操作的记录！");
	 		return false;
	 	}
		form.action="question.action?method=search&question.questionnaire.id="+ids;
		form.submit();
     }
     function ranks(){
	 	var ids = getSelectIds("questionnaireId");
	 	if (ids == null || ids == "") {
	 		alert("你没有选择要操作的记录！");
	 		return false;
	 	}
		form.action="questionnaire!rankList.action?questionnaire.id="+ids;
		form.submit();
     }
  </script>
</body>
 <#include "/template/foot.ftl"/>