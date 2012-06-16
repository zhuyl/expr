<#include "/template/head.ftl"/>
<body>
  <table class="formTable" align="center" width="80%">
	<tr><td>家庭资产负债分析说明:<br>
	${(analysisAnswer.remark)!}
 	</td></tr>
 </table>
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0" class="listTable">
  <tr height="22"> 
    <td colspan="3" class="darkColumn"> <div align="center">资产</div></td>
    <td colspan="3" class="darkColumn"> <div align="center">负债</div></td>
  </tr>
  <tr height="22"> 
    <td width="20%" class="darkColumn"> <div align="center">资产项目</div></td>
    <td width="20%" class="darkColumn"> <div align="center">金额</div></td>
    <td width="10%" class="darkColumn"> <div align="center">比重</div></td>
    <td width="20%" class="darkColumn"> <div align="center">负债项目</div></td>
    <td width="20%" class="darkColumn"> <div align="center">金额</div></td>
    <td width="10%" class="darkColumn"> <div align="center">比重</div></td>
  </tr>
  <#assign maxItems=assetProjects?size>
  <#if (maxItems<liabilityProjects?size)><#assign maxItems=liabilityProjects?size></#if>
  <#list 0..maxItems-1 as i>
  <tr height="22">
  <#if (i<assetProjects?size)>
  <#assign isSummary=false>
  <#if !(assetProjects[i].parent)?exists><#assign isSummary=true /></#if>
    <td ${isSummary?string('class="grayStyle" style="font-weight:bold;"','class="grayStyle"')}>${(assetProjects[i].name)?default("&nbsp;")}</td>
    <td ${isSummary?string('class="grayStyle" style="font-weight:bold;"','class="brightStyle"')}>
    ${(assetMap[(assetProjects[i].id?string)?default('0')])?if_exists}
    </td>
    <td ${isSummary?string('class="grayStyle" style="font-weight:bold;"','class="brightStyle"')} id="label_assetProject${assetProjects[i].id}">
    <#if assetMap[(assetProjects[i].id?string?default('0'))]?exists && (answer.form.totalAssets)?exists && (answer.form.totalAssets)?if_exists != 0>
    	${(assetMap[(assetProjects[i].id?string)?default('0')])?if_exists/(answer.form.totalAssets)?if_exists*100}%
    </#if>
    </td>
  <#else>
    <td class="grayStyle"></td>
    <td class="brightStyle"></td>
    <td class="brightStyle"></td>
  </#if>
  <#if (i<liabilityProjects?size)>
  	<#assign isSummary=false>
    <#if !(liabilityProjects[i].parent)?exists><#assign isSummary=true /></#if>
    <td ${isSummary?string('class="grayStyle" style="font-weight:bold;"','class="grayStyle"')}>${(liabilityProjects[i].name)?default("&nbsp;")}</td>
    <td ${isSummary?string('class="grayStyle" style="font-weight:bold;"','class="brightStyle"')} >
    ${(liabilityMap[(liabilityProjects[i].id?string)?default('0')])?if_exists}
    </td>
    <td ${isSummary?string('class="grayStyle" style="font-weight:bold;"','class="brightStyle"')} id="label_liabilityProject${liabilityProjects[i].id}">
	<#if liabilityMap[(liabilityProjects[i].id?string?default('0'))]?exists && (answer.form.totalLiabilities)?exists && (answer.form.totalLiabilities)?if_exists != 0>
    	${(liabilityMap[(liabilityProjects[i].id?string)?default('0')])?if_exists/(answer.form.totalLiabilities)?if_exists*100}%
    </#if>
	</td>
  <#else>
    <td class="grayStyle"></td>
    <td class="brightStyle"></td>
    <td class="brightStyle"></td>
  </#if>
  </tr>
  </#list>
  <tr height="22"> 
    <td class="grayStyle"><strong>总资产</strong></td>
    <td class="brightStyle" colspan="2"><B>${(answer.form.totalAssets)?if_exists}</B></td>
    <td class="grayStyle"><strong>总负债</strong></td>
    <td class="brightStyle"  colspan="2"><B>${(answer.form.totalLiabilities)?if_exists}</B></td>
  </tr>
  <tr height="22"> 
    <td class="grayStyle"><strong>总净值</strong></td>
    <td colspan="5" class="brightStyle"><B>${(answer.form.totalNet)?if_exists}</B></td>
  </tr>
</table>
</body>
<#include "/template/foot.ftl"/>