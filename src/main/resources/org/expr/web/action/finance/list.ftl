<#include "/template/head.ftl"/>
<BODY>
  <table id="toolbar"></table>
  <@getMessage/>
  <@table.table width="100%"  id="listTable" sortable="true">
    <@table.thead>
       <@table.td text=""/>
       <@table.sortTd name="产品名称" id="finance.name"/>
       <@table.sortTd name="产品类型" id="finance.financetype"/>
       <@table.sortTd name="风险等级" id="finance.riskgrade"/>   
       <@table.sortTd name="流动性" id="finance.mobility"/>
       <@table.sortTd name="计息周期" id="finance.ratepayperiod"/>  
       <@table.sortTd name="利息" id="finance.rate"/>                        
    </@>
    <@table.tbody datas=finances;finance>
       <@table.selectTd id="financeId" value=finance.id type="radio"/>
       <td><a href="finance.action?method=info&finance.id=${finance.id}">${finance.name?if_exists}</a></td>
       <td><@i18nName (finance.financetype)?if_exists/></td> 
       <td>${(finance.riskgrade?if_exists).name?if_exists}</td>
       <td>${(finance.mobility.name?if_exists)?if_exists}</td>
       <td>${(finance.ratepayperiod?if_exists).name?if_exists}</td>
       <td>${finance.rate?if_exists}%</td>                       
    </@>
   </@>
   <@htm.actionForm name="actionForm" action="finance.action" entity="finance"/>
  <script language="javascript">
     var bar = new ToolBar("toolbar","金融产品列表",null,true,true);
     bar.addItem("添加","add()");
     bar.addItem("修改","edit()");
     bar.addItem("删除","remove()");
  </script>
</body>
<#include "/template/foot.ftl"/>