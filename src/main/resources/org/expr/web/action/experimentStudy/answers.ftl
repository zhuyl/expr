<#include "/template/head.ftl"/>
<table id="backBar"></table>
<script>
   var bar = new ToolBar('backBar','案例答案',null,true,true);
   bar.setMessage('');
   bar.addPrint();
   bar.addClose();
</script>
<#if !experiment.publish>答案没有开放
<#else>
<#include "../experiment/metadata.ftl"/>
<@sj.head jquerytheme="redmond"/>
<table width="90%" align="center">
  <tr><td>
	<#list experiment.marks?sort_by(['analysis','code']) as mark>
	<#assign analysis=mark.analysis>
	<B><#if (mark_index>0)><br><br></#if>${mark_index+1}.${analysis.name}<hr></B>
	<#if typeUriMap[analysis.code]??>
	<#assign typeUri>answer/${typeUriMap[analysis.code]}!infolet.action?type=${typeMap[analysis.code]!}&caze.id=${experiment.caze.id}${extParams[analysis.code]!}</#assign>
	</#if>
	<@sj.div cssClass="ui-widget-content ui-corner-all" id="div${analysis.id}"  href="${typeUri}">
	</@>
	</#list>
  </td>
  </tr>
</table>
</#if>
<#include "/template/foot.ftl"/>