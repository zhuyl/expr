 <#include "/template/head.ftl"/>
<body>

<table id="toolbar"></table>
  <script language="javascript">
     var bar = new ToolBar("toolbar","项目管理",null,true,true);
     bar.addItem("添加","add()");
     bar.addItem("修改","edit()");
     bar.addItem("删除","remove()");
     bar.addBack("后退");
  </script>
<p>评估标准名称:${(assessment.name)!}</p>

<@table.table id="assessItemTable" width="100%" align="center">
 <@table.thead>
   <@table.selectAllTd id="assessItemId"/>
   <@table.td text="分析阶段"/>
   <@table.td text="优"/>
   <@table.td text="良"/>  
   <@table.td text="中"/> 
   <@table.td text="及格"/>  
   <@table.td text="不及格"/> 
 </@>
 <@table.tbody datas=assessItems?sort_by(["phase","code"]);assessItem>
   <@table.selectTd id="assessItemId" value=assessItem.id type="checkbox"/>
   <td>${(assessItem.phase!).name!}</td>
   <td>${assessItem.excellent!}</td>
   <td>${assessItem.good!}</td>   
   <td>${assessItem.middle!}</td>  
   <td>${assessItem.pass!}</td> 
   <td>${assessItem.nopass!}</td> 
   </@>
 </@>

<@htm.actionForm name="actionForm" action="assessItem.action" entity="assessItem">
<input type="hidden" name="assessment.id" value="${assessment.id!}"/>
</@>

</body>
 <#include "/template/foot.ftl"/>