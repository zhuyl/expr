<#include "/template/head.ftl"/>
<BODY>
  <table id="toolbar"></table>
  <@getMessage/>
  <@table.table width="100%"  id="listTable" sortable="true">
    <@table.thead>
       <@table.selectAllTd id="payTimeRateId"/>
       <@table.td text="产品名称" id="payTimeRate.product.name"/>
       <@table.sortTd text="缴费期限" id="payTimeRate.paytime.name"/>
       <@table.sortTd text="保险期限" id="payTimeRate.time.name"/>
       <@table.sortTd text="性别" id="payTimeRate.gender.name"/>
       <@table.sortTd text="缴费方式" id="payTimeRate.paytype.name"/>
    </@>
    <@table.tbody datas=payTimeRates;rate>
       <@table.selectTd id="payTimeRateId" value=rate.id type="checkbox"/>
       <td>${rate.product.name}</td>
       <td>${rate.paytime.name}</td>
       <td>${rate.time.name}</td>
       <td>${(rate.gender.name)!}</td>
       <td>${rate.paytype.name}
    </@>
   </@>
   <@htm.actionForm name="actionForm" action="${base}/insurance/payTimeRate.action" entity="payTimeRate"/>
  <script language="javascript">
     var bar = new ToolBar("toolbar","费率列表",null,true,true);
     bar.addItem("查看","info()");
     bar.addItem("添加","add()");
     bar.addItem("修改","edit()");
     bar.addItem("删除","remove()");
     bar.addBack();
  </script>
</body>
<#include "/template/foot.ftl"/>