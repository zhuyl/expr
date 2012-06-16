<#if result??>
  <#assign assetProjects=[]>
  <#assign assetMap={}/>
  <#assign liabilityProjects=[]/>
  <#assign liabilityMap={}/>
  <#list result.form.assets as a>
  <#assign assetProjects=assetProjects+[a.asset.assetProject]/>
  <#assign assetMap=assetMap+{a.asset.assetProject.id:a.asset.amount!0}/>
  </#list>
  <#assign assetProjects= assetProjects?sort_by('code')/>
  <#list result.form.liabilities as a>
  <#assign liabilityProjects=liabilityProjects+[a.liability.liabilityProject]/>
  <#assign liabilityMap=liabilityMap+{a.liability.liabilityProject.id?string:a.liability.amount!0}/>
  </#list>
  <#assign liabilityProjects=liabilityProjects?sort_by("code")/>
  <#assign maxItems=assetProjects?size>
  <#if (maxItems<liabilityProjects?size)><#assign maxItems=liabilityProjects?size></#if>
  <#if (maxItems>0)>
<table width="100%" align="center">
<#include "../../experiment/metadata.ftl"/>
<#assign type>${Parameters['type']}</#assign>
<tr><td><B>${nameMap[type]}的说明：</B></td></tr>
<tr><td>${result.remark!}</td></tr>
</table>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="listTable">
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
  <#list 0..maxItems-1 as i>
  <tr height="22">
  <#if (i<assetProjects?size)>
  <#assign isSummary=false>
  <#if !(assetProjects[i].parent)?exists><#assign isSummary=true /></#if>
    <td ${isSummary?string('class="grayStyle" style="font-weight:bold;"','class="grayStyle"')}>${(assetProjects[i].name)?default("&nbsp;")}</td>
    <td ${isSummary?string('class="grayStyle" style="font-weight:bold;"','class="brightStyle"')}>${(assetMap[(assetProjects[i].id?string)?default('0')])?if_exists}</td>
    <td ${isSummary?string('class="grayStyle" style="font-weight:bold;"','class="brightStyle"')} id="label_assetProject${assetProjects[i].id}">
    <#if assetMap[(assetProjects[i].id?string?default('0'))]?exists && (result.form.totalAssets)?exists && (result.form.totalAssets)?if_exists != 0>
    	${(assetMap[(assetProjects[i].id?string)?default('0')])?if_exists/(result.form.totalAssets)?if_exists*100}%
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
    <td ${isSummary?string('class="grayStyle" style="font-weight:bold;"','class="brightStyle"')} >${(liabilityMap[(liabilityProjects[i].id?string)?default('0')])?if_exists}</td>
    <td ${isSummary?string('class="grayStyle" style="font-weight:bold;"','class="brightStyle"')} id="label_liabilityProject${liabilityProjects[i].id}">
	<#if liabilityMap[(liabilityProjects[i].id?string?default('0'))]?exists && (result.form.totalLiabilities)?exists && (result.form.totalLiabilities)?if_exists != 0>
    	${(liabilityMap[liabilityProjects[i].id?string])?default(0)/(result.form.totalLiabilities)?default(1)*100}%
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
    <td class="grayStyle" colspan="2">${(result.form.totalAssets)?if_exists}</td>
    <td class="grayStyle"><strong>总负债</strong></td>
    <td class="grayStyle"  colspan="2">${(result.form.totalLiabilities)?if_exists}</td>
  </tr>
  <tr height="22"> 
    <td class="grayStyle"><strong>总净值</strong></td>
    <td colspan="5" class="brightStyle">${(result.form.totalNet)?if_exists}</td>
  </tr>
</table>
	<#else>
	未做该部分
	</#if>
<#else>
未做该部分
</#if>