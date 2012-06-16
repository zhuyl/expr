<#include "/template/head.ftl"/>
<BODY>
  <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/system/BaseInfo.js"></script>
  <@getMessage/>
  <@table.table width="100%"  id="listTable" sortable="true">
    <@table.thead>
       <@table.td text=""/>
       <@table.sortTd name="编码" id="caze.seq"/>
       <@table.sortTd name="名称" id="caze.name"/>
       <@table.sortTd name="客户生命周期类型" id="caze.lifeCycleType.name"/>
       <@table.sortTd name="更新日期" width="10%" id="caze.updatedAt" />
    </@>
    <@table.tbody datas=cazes;caze>
       <@table.selectTd id="cazeId" value=caze.id type="radio"/>
       <td>${caze.seq}</td>
       <td><a href="caze.action?method=info&caze.id=${caze.id}">${caze.name?if_exists}</a></td>
       <td><@i18nName caze.lifeCycleType/></td>
       <td>${(caze.updatedAt?string("yyyy-MM-dd"))?if_exists}</td>
    </@>
   </@>
  <script language="javascript">
   type="caze";
   defaultOrderBy="${Parameters['orderBy']?default('null')}";
  </script>
</body>
<#include "/template/foot.ftl"/>
