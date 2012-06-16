<#if result??>
<#include "../../experiment/metadata.ftl"/>
  <#assign incomeProjects=[]>
  <#assign incomeMap={}/>
  <#assign expendProjects=[]/>
  <#assign expendMap={}/>
  <#list result.form.incomes as a>
  <#assign incomeProjects=incomeProjects+[a.income.incomeProject]/>
  <#assign incomeMap=incomeMap+{a.income.incomeProject.id:a.income.amount!0}/>
  </#list>
  <#list result.form.expends as a>
  <#assign expendProjects=expendProjects+[a.expend.expendProject]/>
  <#assign expendMap=expendMap+{a.expend.expendProject.id?string:a.expend.amount!0}/>
  </#list>
  
  <#assign incomeProjects=incomeProjects?sort_by("code")/>
  <#assign expendProjects=expendProjects?sort_by("code")/>
  <#assign maxItems=incomeProjects?size>
  <#if (maxItems<expendProjects?size)><#assign maxItems=expendProjects?size></#if>
  <#if (maxItems>0)>
<table width="100%" align="center">
<#assign type>${Parameters['type']}</#assign>
<tr><td><B>${nameMap[type]}的说明：</B></td></tr>
<tr><td>${(result.remark)!}</td></tr>
</table>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="listTable">
 <tr height="22"> 
    <td colspan="3" class="darkColumn"> <div align="center">收入</div></td>
    <td colspan="3" class="darkColumn"> <div align="center">支出</div></td>
  </tr>
  <tr height="22"> 
    <td width="20%" class="darkColumn"> <div align="center">收入项目</div></td>
    <td width="20%" class="darkColumn"> <div align="center">金额</div></td>
    <td width="10%" class="darkColumn"> <div align="center">比重</div></td>
    <td width="20%" class="darkColumn"> <div align="center">支出项目</div></td>
    <td width="20%" class="darkColumn"> <div align="center">金额</div></td>
    <td width="10%" class="darkColumn"> <div align="center">比重</div></td>
  </tr>
  <#list 0..maxItems-1 as i>
  <tr height="22">
  <#if (i<incomeProjects?size)>
    <td class="grayStyle" <#if !(incomeProjects[i].parent)?exists>style="font-weight:bold;"</#if>>${(incomeProjects[i].name)?default("&nbsp;")}</td>
    <td class="brightStyle">${(incomeMap[(incomeProjects[i].id?string)?default('0')])?if_exists}</td>
    <td class="brightStyle" id="label_incomeProject${incomeProjects[i].id}">
    <#if incomeMap[(incomeProjects[i].id?string?default('0'))]?exists && (result.form.totalIncome)?exists && (result.form.totalIncome)?if_exists != 0>
    	${(incomeMap[(incomeProjects[i].id?string)?default('0')])?if_exists/(result.form.totalIncome)?if_exists*100}%
    </#if>
    </td>
  <#else>
    <td class="grayStyle"></td>
    <td class="brightStyle"></td>
    <td class="brightStyle"></td>
  </#if>
  <#if (i<expendProjects?size)>
    <td class="grayStyle" <#if !(expendProjects[i].parent)?exists>style="font-weight:bold;"</#if>>${(expendProjects[i].name)?default("&nbsp;")}</td>
    <td class="brightStyle">${(expendMap[(expendProjects[i].id?string)?default('0')])?if_exists}</td>
	<td class="brightStyle" id="label_expendProject${expendProjects[i].id}">
    <#if expendMap[(expendProjects[i].id?string?default('0'))]?exists && (result.form.totalExpend)?exists && (result.form.totalExpend)?if_exists != 0>
    	${(expendMap[(expendProjects[i].id?string)?default('0')])?if_exists/(result.form.totalExpend)?if_exists*100}%
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
    <td class="grayStyle" id="f_totalIncome" ><strong>总收入</strong></td>
    <td class="brightStyle" colspan="2">${(result.form.totalIncome)?if_exists}</td>
    <td class="grayStyle" id="f_totalExpend"><strong>总支出</strong></td>
    <td class="brightStyle" colspan="2">${(result.form.totalExpend)?if_exists}</td>
  </tr>
  <tr height="22">
    <td class="grayStyle" id="f_totalBalance"><strong>总结余</strong></td>
    <td colspan="5" class="brightStyle">${(result.form.totalBalance)?if_exists}</td>
  </tr>
</table>
	<#else>
	未做该部分
	</#if>
<#else>
未做该部分
</#if>