 <#include "/template/head.ftl"/>
<body>
<table id="toolbar"></table>
<p>案例名称:${(examItems?first.question.caze.name)!}</p>

<@table.table id="examItemTable" width="100%" align="center">
 <@table.thead>
   <@table.selectAllTd id="examItemId"/>
   <@table.td text="序号"/>
   <@table.td text="问题内容"/>
   <@table.td text="得分权重"/>   
   <@table.td text="答案"/>     
 </@>
 <@table.tbody datas=(examItems?if_exists)?sort_by("code");examItem>
   <@table.selectTd id="examItemId" value=examItem.id type="checkbox"/>
   <td>${examItem.code?if_exists}</td>
   <td>${examItem.description?if_exists}</td>
   <td>${examItem.weight?if_exists}</td> 
   <td>${examItem.answer?if_exists}</td>      
   </@>
 </@>

<@htm.actionForm name="actionForm" action="examItem.action" entity="examItem">
<input type="hidden" name="examQuestion.id" value="${Parameters['examItem.question.id']}"/>
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