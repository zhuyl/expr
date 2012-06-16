<#include "/template/head.ftl"/>
<BODY>

  <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/system/BaseInfo.js"></script>
 <table id="myBar"></table>
 <script>
  var bar = new ToolBar('myBar', '金融产品列表', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
  bar.addItem('选择并关闭', 'returnValue()');
</script>
  <@getMessage/>
  <script>
      var detailArray = {};
  </script>
  <@table.table width="100%"  id="listTable" sortable="true">
    <@table.thead>
   <@table.selectAllTd id="financeId" />
       <@table.sortTd name="产品名称" id="finance.name"/>
       <@table.sortTd name="产品类型" id="finance.financetype"/>
       <@table.sortTd name="风险等级" id="finance.riskgrade"/>   
       <@table.sortTd name="流动性" id="finance.mobility"/>
       <@table.sortTd name="计息周期" id="finance.ratepayperiod"/>  
       <@table.sortTd name="利息" id="finance.rate"/>                        
    </@>
    <@table.tbody datas=finances;finance>
       <@table.selectTd id="financeId" value="${finance.id}" type="checkbox"/>
       <script>
      	detailArray['${finance.id}'] = {'name':'${finance.name?if_exists}'};
       </script>
       <td><a href="finance.action?method=info&finance.id=${finance.id}">${finance.name?if_exists}</a></td>
       <td><@i18nName (finance.financetype)?if_exists/></td> 
       <td>${(finance.riskgrade?if_exists).name?if_exists}</td>
       <td>${(finance.mobility.name?if_exists)?if_exists}</td>
       <td>${(finance.ratepayperiod?if_exists).name?if_exists}</td>
       <td>${finance.rate?if_exists}%</td>                       
    </@>
   </@>
  <script language="javascript">

   type="finance";
   defaultOrderBy="${Parameters['orderBy']?default('null')}";
   
    function getIds(){
       return(getCheckBoxValue(document.getElementsByName("financeId")));
    }

    function returnValue(){
      id= getIds();
      if(id==""){
      	window.alert('请选择!');
      	return;
      }
      ids=id.split(',');
      for(var i=0;i<ids.length;i++){
          window.top.opener.doSetFinance(ids[i],getName(ids[i]));
      }
	  parent.windowclose();//关闭不了
    }
    function getName(id){
         return detailArray[id]['name'];
    }
  </script>
</body>
<#include "/template/foot.ftl"/>
