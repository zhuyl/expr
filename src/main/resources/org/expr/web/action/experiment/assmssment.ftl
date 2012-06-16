<#include "/template/head.ftl"/>
<table id="backBar"></table>


<#assign infoPage>../${Parameters['infoPage']}.ftl</#assign>
<#include infoPage/>

<script language="javascript">
     var bar = new ToolBar("toolbar",${result.student.name}的${tableName},null,true,true);
     bar.addBlankItem();
</script>
<#include "/template/foot.ftl"/>