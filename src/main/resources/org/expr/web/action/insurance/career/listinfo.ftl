<#include "/template/head.ftl"/>
<BODY>
  <table id="toolbar"></table>
  <@getMessage/>
  <p>${careerProfile.name}</P>
  <@table.table width="100%"  id="listTable" sortable="true">
    <@table.thead>
       <@table.selectAllTd id="careerId"/>
       <@table.sortTd text="代码" id="career.code"/>
       <@table.sortTd text="名称" id="career.name"/>
       <@table.sortTd text="上一级" id="career.parent"/>
       <@table.sortTd text="职业等级" id="career.grade"/>
    </@>
    <@table.tbody datas=careers;career>
       <@table.selectTd id="careerId" value=career.id type="checkbox"/>
       <td>${career.code!}</td>
       <td>${career.name!}</td>
       <td>${(career.parent.name)!}</td>
       <td>${(career.grade.name)!}</td>
    </@>
   </@>
   <@htm.actionForm name="actionForm" action="${base}/insurance/career.action" entity="career"/>
  <script language="javascript">
     var bar = new ToolBar("toolbar","职业列表",null,true,true);
     bar.addBack();
  </script>
</body>
<#include "/template/foot.ftl"/>