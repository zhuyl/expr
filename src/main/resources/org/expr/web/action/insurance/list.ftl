<#include "/template/head.ftl"/>
<BODY>
  <table id="toolbar"></table>
  <@getMessage/>
  <@table.table width="100%"  id="listTable" sortable="true">
    <@table.thead>
       <@table.td text=""/>
       <@table.sortTd text="产品代码" id="insuranceProduct.seqNo"/>
       <@table.sortTd text="产品名称" id="insuranceProduct.name"/>
       <@table.sortTd text="产品类型" id="insuranceProduct.type"/>
       <@table.sortTd text="产品公司" id="insuranceProduct.corporation"/>
       <@table.sortTd text="是否附加险" id="insuranceProduct.additional"/>
    </@>
    <@table.tbody datas=insuranceProducts?if_exists;product>
       <@table.selectTd id="insuranceProductId" value=product.id type="radio"/>
       <td>${product.seqNo}</td>
       <td><a href="insurance.action?method=info&insuranceProduct.id=${product.id}">${product.name?if_exists}</a></td>
       <td>${(product.type.parent.name)!}|${(product.type.name)!}</td>
       <td>${(product.corporation)?if_exists}</td>
       <td>${(product.additional!false)?string("是","否")}</td>
    </@>
   </@>
   <@htm.actionForm name="actionForm" action="insurance.action" entity="insuranceProduct"/>
  <script language="javascript">
     var bar = new ToolBar("toolbar","产品列表",null,true,true);
     bar.addItem("添加","add()");
     bar.addItem("修改","edit()");
     bar.addItem("删除","remove()");
     bar.addItem("费率表","payTimeRateList()");
     bar.addItem("职业费率表","careerRateList()");
     bar.addItem("职业表","careerList()");

    function careerList(){		
	   var ids = getSelectIds("insuranceProductId");
	 	if (ids == null || ids == "") {
	 		alert("你没有选择要操作的记录！");
	 		return false;
	 	}
		form.action="${base}/insurance/career!listinfo.action?product.id="+ids;
		form.submit();
	}
	function payTimeRateList(){
	   var ids = getSelectIds("insuranceProductId");
	 	if (ids == null || ids == "") {
	 		alert("你没有选择要操作的记录！");
	 		return false;
	 	}
		form.action="${base}/insurance/payTimeRate!search.action?product.id="+ids;
		form.submit();
	}
   function careerRateList(){
	   var ids = getSelectIds("insuranceProductId");
	 	if (ids == null || ids == "") {
	 		alert("你没有选择要操作的记录！");
	 		return false;
	 	}
		form.action="${base}/insurance/careerRate!search.action?product.id="+ids;
		form.submit();
	}
  </script>
</body>
<#include "/template/foot.ftl"/>