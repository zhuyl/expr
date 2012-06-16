<#include "/template/head.ftl"/>
<BODY>
  <table id="toolbar"></table>
  <@getMessage/>
  <@table.table width="80%"  id="listTable" sortable="true" align="center">
    <@table.thead>
       <@table.sortTd name="计算器类型" id="financeTool.name"/>
       <@table.sortTd name="计算器名称" id="financeTool.name"/>                     
    </@>
    <@table.tbody datas=financeTools;financeTool>
       <td>${financeTool.category.name}</td>   
       <td><a href="financeTool!show.action?tool=${financeTool.engName}">${financeTool.name}</a></td>
    </@>
   </@>
  <script language="javascript">
     var bar = new ToolBar("toolbar","理财计算器",null,true,true);
     bar.addBlankItem();
  </script>
</body>
<#include "/template/foot.ftl"/>