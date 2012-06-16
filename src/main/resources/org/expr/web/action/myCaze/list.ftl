<#include "/template/head.ftl"/>
<BODY>
  <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/system/BaseInfo.js"></script>
    <@getMessage/>
   <form name='actionForm' method="post" action="myCaze.action">
  <@table.table width="100%"  id="listTable" sortable="true">
    <@table.thead>
           <@table.td text=""/>
       <@table.td name="编码" id="caze.seq"/>
       <@table.td name="名称" id="caze.name"/>
       <@table.td name="客户生命周期类型" id="caze.lifeCycleType.name"/>
       <@table.td name="更新日期" width="10%" id="caze.updatedAt" />
       <@table.td name="案例作者" id="caze.author"/>
       <@table.td name="操作"/>

    </@>
    <@table.tbody datas=cazes?if_exists;caze>
      <@table.selectTd id="cazeId" name="cazeId" value=caze.id type="radio"/>
       <td>${caze.seq}</td>
       <td><a href="myCaze.action?method=info&caze.id=${caze.id}">${caze.name?if_exists}</a></td>
       <td><@i18nName caze.lifeCycleType/></td>
       <td>${(caze.updatedAt?string("yyyy-MM-dd"))?if_exists}</td>
       <td>${caze.author?if_exists}</td>
       <td><a href='answer/answerDashboard.action?method=index&cazeId=${caze.id}'  target="_blank" >编辑答案</a></td>      
    </@>
   </@>
</from>
  <script language="javascript">
   type="caze";
   defaultOrderBy="${Parameters['orderBy']?default('null')}";
   //queryStr=getInputParams(searchForm,null,false);
   
  </script>
</body>
<#include "/template/foot.ftl"/>
