<#include "/template/head.ftl"/>
<table id="backBar"></table>
<script>
   var bar = new ToolBar('backBar','案例答案',null,true,true);
   bar.setMessage('');
   bar.addPrint();
   bar.addBack();
</script>
<#include "metadata.ftl"/>
<@sj.head jquerytheme="redmond"/>
<table width="90%" align="center">
  <tr><td>
	<#list analysises?sort_by('code') as analysis>
	<B><#if (analysis_index>0)><br><br></#if>${analysis_index+1}.${analysis.name}<hr></B>
	<#if typeUriMap[analysis.code]??>
	<#assign typeUri>answer/${typeUriMap[analysis.code]}!infolet.action?type=${typeMap[analysis.code]!}&caze.id=${Parameters['caze.id']}&nopage=1${extParams[analysis.code]!}</#assign>
	<#else>
	<#assign typeUri>experiment!answer.action?caze.id=${caze.id}&type=${typeMap[analysis.code]!}&phase=${phaseMap[analysis.phase.code]!}${extParams[analysis.code]!}</#assign>
	</#if>
	<@sj.div cssClass="ui-widget-content ui-corner-all" id="div${analysis.id}"  href="${typeUri}">
	</@>
	</#list>
  </td>
  </tr>
</table>
<#include "/template/foot.ftl"/>