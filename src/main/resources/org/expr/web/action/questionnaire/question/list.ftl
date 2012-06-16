 <#include "/template/head.ftl"/>
<body>
<table id="toolbar"></table>
<p>问卷名称:${(questions?first.questionnaire.name)!}</p>

<@table.table id="questionTable" width="100%" align="center">
 <@table.thead>
   <@table.selectAllTd id="questionId"/>
   <@table.td text="序号"/>
   <@table.td text="问题内容"/>
   <@table.td text="问题类型"/>   
 </@>
 <@table.tbody datas=questions;question,question_index>
   <@table.selectTd id="questionId" value=question.id type="checkbox"/>
   <td>${question_index+1}</td>
   <td>${question.description?if_exists}</td>
   <td>${(question.questionType!).name?if_exists}</td>   
   </@>
 </@>

<@htm.actionForm name="actionForm" action="question.action" entity="question">
<input type="hidden" name="questionnaire.id" value="${Parameters['question.questionnaire.id']}"/>
</@>
  <script language="javascript">
     var bar = new ToolBar("toolbar","问题管理",null,true,true);
     bar.setMessage('<@getMessage/>');
     bar.addItem("添加","add()");
     bar.addItem("修改","edit()");
     bar.addItem("删除","remove()");
     bar.addBack("后退");
  </script>
</body>
 <#include "/template/foot.ftl"/>