 <#include "/template/head.ftl"/>
<body>
<table id="toolbar"></table>
<@table.table id="policyTable" width="80%" align="center">
 <@table.thead>
   <@table.td text=""/>
   <@table.td text="保险名称"/>
   <@table.td text="保险公司"/>
   <@table.td text="被保险人物"/>
   <@table.td text="保险种类"/>
   <@table.td text="是否附加险"/>  
   <@table.td text="主险名称"/>   
 </@>
 <@table.tbody datas=answers;answer>
   <@table.selectTd id="insurancePolicyAnswerId" value=answer.id type="radio"/>
   <td>${answer.policy.name}</td>
   <td>${answer.policy.company}</td>
   <td>${answer.policy.insurant}</td>
   <td>${(answer.policy.type.name)!}</td>
   <td>${answer.additional?string("是","否")}</td>
   <td>${(answer.master.name)!}</td>
   </@>
 </@>
<@htm.actionForm name="actionForm" action="insuranceAnalysis.action" entity="insurancePolicyAnswer">
  <input type="hidden" name="caze.id" value="${Parameters['caze.id']}"/>
</@>
  <script language="javascript">
     var bar = new ToolBar("toolbar","保险资产分析",null,true,true);
     bar.setMessage('<@getMessage/>');
     bar.addItem("添加","add()");
     bar.addItem("修改","edit()");
     bar.addItem("删除","remove()");
  </script>
</body>
 <#include "/template/foot.ftl"/>