<#include "/template/head.ftl"/>
<BODY>
  <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/system/BaseInfo.js"></script>
  <@getMessage/>
  <@table.table width="100%"  id="listTable" sortable="true">
    <@table.thead>
       <@table.td name="编号" id="caze.seq"/>
       <@table.td name="名称" id="caze.name"/>
       <@table.td name="客户生命周期类型" id="caze.lifeCycleType.name"/>
       <@table.td name="更新日期" width="10%" id="caze.updatedAt" />
       <@table.td name="案例作者" id="caze.author"/>
    </@>
    <@table.tbody datas=cazes;caze>
       <#if caze.open>    
       <td>${caze.seq}</td>
       <td><a href="studentCaze.action?method=info&caze.id=${caze.id}">${caze.name?if_exists}</a></td>
       <td><@i18nName caze.lifeCycleType/></td>
       <td>${(caze.updatedAt?string("yyyy-MM-dd"))?if_exists}</td>
       <td>${caze.author?if_exists}</td>      
       </#if>
    </@>
   </@>
   <form name='a' method="post"></from>
  <script language="javascript">
   type="caze";
   defaultOrderBy="${Parameters['orderBy']?default('null')}";
   queryStr=getInputParams(queryForm,null,false);
   
  </script>
</body>
<#include "/template/foot.ftl"/>
