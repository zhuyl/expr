<#include "/template/head.ftl"/>
<BODY>

  <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/system/BaseInfo.js"></script>
 <table id="myBar"></table>
 <script>
  var bar = new ToolBar('myBar', '保险产品列表', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
  bar.addItem('选择并关闭', 'returnValue()');
</script>
  <@getMessage/>
  <script>
      var detailArray = {};
  </script>
  <@table.table width="100%"  id="listTable" sortable="true">
   <@table.thead>
       <@table.td text=""/>
       <@table.sortTd name="产品代码" id="insuranceProduct.seqNo"/>
       <@table.sortTd name="产品名称" id="insuranceProduct.name"/>
       <@table.sortTd name="产品类型" id="insuranceProduct.type"/>
       <@table.sortTd name="产品公司" id="insuranceProduct.corporation"/>
    </@>
     <@table.tbody datas=insuranceProducts;insuranceproduct>
       <@table.selectTd id="insuranceproductId" value=insuranceproduct.id type="radio"/>
      <script>
      detailArray['${insuranceproduct.id}'] = {'name':'${insuranceproduct.name?if_exists}'};
       </script>
       <td>${insuranceproduct.seqNo}</td>
       <td><a href="insurance.action?method=info&insuranceProduct.id=${insuranceproduct.id}">${insuranceproduct.name?if_exists}</a></td>
       <td><@i18nName insuranceproduct.type/></td>
       <td>${(insuranceproduct.corporation)?if_exists}</td>
    </@>
   </@>
  <script language="javascript">

   type="insurance";
   defaultOrderBy="${Parameters['orderBy']?default('null')}";
   

    function getIds(){
       return(getRadioValue(document.getElementsByName("insuranceproductId")));
    }

    function returnValue(){
          id= getIds();
          if(id=="")
          window.alert('请选择!');
          else{
          var name=getName(id);
           window.top.opener.doSetProduct(id,name);
		   parent.windowclose();//关闭不了
           }
		}
   function getName(id){
         return detailArray[id]['name'];
    }
  </script>
</body>
<#include "/template/foot.ftl"/>
