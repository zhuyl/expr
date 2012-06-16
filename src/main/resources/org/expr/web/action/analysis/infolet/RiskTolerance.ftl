<#if result??>
<table width="100%" align="center">
<#include "../../experiment/metadata.ftl"/>
<#assign type>${Parameters['type']}</#assign>
<table>
<#if !result.questionnaire??>
案例没有设置风险承受能力问卷!
<#else>
<table width="100%"  align="center">
<tr>
<td align="center">
风险承受能力测验结果<br>
分数:<font color="blue">${result.questionScore}</font>  
等级：<font color="blue">
<#list result.questionnaire.ranks as rank><#if (rank.lower<=result.questionScore) && (rank.upper>=result.questionScore)>${rank.name}</#if></#list>
</font>
</td>
</tr>
</table>
<#assign questionnaire=result.questionnaire/>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class='listTable'>
  <#assign checkedOptions={}>
  <#list result.answers  as an>
  	<#assign checkedOptions = checkedOptions+{an.question.id?string:an.option.id}/>
  </#list>
  <#list questionnaire.questions?sort_by("id") as question>
  <tr> 
    <td class="grayStyle">${question_index+1}、${question.description}</td>
  </tr>
  <tr> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="brightStyle">
    	<#list question.options?sort_by("seq") as option>
        <tr> 
          <td width="4%"><div align="center"> 
              <#if ((checkedOptions[question.id?string]!0)==option.id)><input type="radio" disabled  checked name="option${question.id}" value="${option.id}"></#if>
          </td>
          <td width="96%">${option.context} </td>
        </tr>
        </#list>
        <tr> 
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
  </#list>
</table>
</#if>
<#else>
未做该部分
</#if>