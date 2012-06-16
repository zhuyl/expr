<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Validator.js"></script>
  <table class="formTable" align="center" width="80%">
	<tr><td>家庭月度收支分析说明:<br>
	${(analysisAnswer.remark)!}
 	</td></tr>
 </table>
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0" class="listTable">
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
  <#assign maxItems=incomeProjects?size>
  <#if (maxItems<expendProjects?size)><#assign maxItems=expendProjects?size></#if>
  <#list 0..maxItems-1 as i>
  <tr height="22">
  <#if (i<incomeProjects?size)>
    <td class="grayStyle" id="f_incomeProject${incomeProjects[i].id}" <#if !(incomeProjects[i].parent)?exists>style="font-weight:bold;"</#if>>${(incomeProjects[i].name)?default("&nbsp;")}</td>
    <td class="brightStyle">
    	${(incomeMap[(incomeProjects[i].id?string)?default('0')])?if_exists}
    </td>
    <td class="brightStyle" id="label_incomeProject${incomeProjects[i].id}">
    <#if incomeMap[(incomeProjects[i].id?string?default('0'))]?exists && (answer.form.totalIncome)?exists && (answer.form.totalIncome)?if_exists != 0>
    	${(incomeMap[(incomeProjects[i].id?string)?default('0')])?if_exists/(answer.form.totalIncome)?if_exists*100}%
    </#if>
    </td>
  <#else>
    <td class="grayStyle"></td>
    <td class="brightStyle"></td>
    <td class="brightStyle"></td>
  </#if>
  <#if (i<expendProjects?size)>
    <td class="grayStyle" id="f_expendProject${expendProjects[i].id}" <#if !(expendProjects[i].parent)?exists>style="font-weight:bold;"</#if>>${(expendProjects[i].name)?default("&nbsp;")}</td>
    <td class="brightStyle">
    ${(expendMap[(expendProjects[i].id?string)?default('0')])?if_exists}
    </td>
	<td class="brightStyle" id="label_expendProject${expendProjects[i].id}">
    <#if expendMap[(expendProjects[i].id?string?default('0'))]?exists && (answer.form.totalExpend)?exists && (answer.form.totalExpend)?if_exists != 0>
    	${(expendMap[(expendProjects[i].id?string)?default('0')])?if_exists/(answer.form.totalExpend)?if_exists*100}%
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
    <td class="brightStyle" colspan="2"><B>${(answer.form.totalIncome)?if_exists}</B></td>
    <td class="grayStyle" id="f_totalExpend"><strong>总支出</strong></td>
    <td class="brightStyle" colspan="2"><B>${(answer.form.totalExpend)?if_exists}</B></td>
  </tr>
  <tr height="22">
    <td class="grayStyle" id="f_totalBalance"><strong>总结余</strong></td>
    <td colspan="5" class="brightStyle"><B>${(answer.form.totalBalance)?if_exists}</B></td>
  </tr>
</table>
<#include "/template/foot.ftl"/>