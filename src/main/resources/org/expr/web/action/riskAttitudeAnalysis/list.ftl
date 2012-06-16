<#include "/template/head.ftl"/>
<BODY>
  <table id="toolbar"></table>
  <@getMessage/>
  <@table.table width="80%"  id="listTable" sortable="true" align="center">
    <@table.thead>
       <@table.sortTd name="问卷名称" id="quesitonnaire.name"/>                     
    </@>
    <@table.tbody datas=questionnaires;questionnaire>
       <td><a href="riskAttitudeAnalysis.action?questionnaire.id=${questionnaire.id}">${questionnaire.name?if_exists}</a></td>
    </@>
   </@>
  <script language="javascript">
     var bar = new ToolBar("toolbar","客户风险偏好分析",null,true,true);
     bar.addBlankItem();
  </script>
</body>
<#include "/template/foot.ftl"/>