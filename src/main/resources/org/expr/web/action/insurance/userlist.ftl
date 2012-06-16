<#include "/template/head.ftl"/>
<BODY>
  <table id="toolbar"></table>
  <@getMessage/>
  <@table.table width="100%"  id="listTable" sortable="true">
    <@table.thead>
       <@table.td text=""/>
       <@table.sortTd name="产品代码" id="insuranceProduct.seqNo"/>
       <@table.sortTd name="产品名称" id="insuranceProduct.name"/>
       <@table.sortTd name="产品类型" id="insuranceProduct.type"/>
       <@table.sortTd name="产品公司" id="insuranceProduct.corporation"/>
       <@table.sortTd name="是否附加险" id="insuranceProduct.additional"/>
    </@>
    <@table.tbody datas=insuranceProducts;product>
       <@table.selectTd id="insuranceProductId" value=product.id type="radio"/>
       <td>${product.seqNo}</td>
       <td><a href="insurance.action?method=info&insuranceProduct.id=${product.id}">${product.name?if_exists}</a></td>
       <td><@i18nName product.type/></td>
       <td>${(product.corporation)?if_exists}</td>
       <td>${(product.additional!false)?string("是","否")}</td>
    </@>
   </@>
   <@htm.actionForm name="actionForm" action="insurance.action" entity="insuranceProduct"/>
  <script language="javascript">
     var bar = new ToolBar("toolbar","产品列表",null,true,true);
     bar.addBlankItem();
  </script>
</body>
<#include "/template/foot.ftl"/>