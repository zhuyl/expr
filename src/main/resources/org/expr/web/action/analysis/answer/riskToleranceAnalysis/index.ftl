<#include "/template/head.ftl"/>
<table id="taskBar"></table>
<script>
  var bar = new ToolBar('taskBar', '${(questionnaire.name)!}', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
  bar.addBack();
</script>

<#if !questionnaire??>
案例没有设置风险承受能力问卷!
<#else>

<#if answer??>
<p align="center">
风险承受能力测验结果<br>
分数:<font color="blue">${answer.questionScore}</font>  
等级：<font color="blue">
<#list questionnaire.ranks as rank><#if (rank.lower<=answer.questionScore) && (rank.upper>=answer.questionScore)>${rank.name}</#if></#list>
</font>
</p>
</#if>

<form name="quesitonForm" name="post" action="${base}/answer/riskToleranceAnalysis!save.action">
<input name="questionnaire.id" type="hidden" value="${questionnaire.id}"/>
<input name="caze.id" type="hidden" value="${Parameters['caze.id']}"/>
<input name="params" type="hidden" value="&caze.id=${Parameters['caze.id']}"/>
<#if answer??><input name="answer.id" type="hidden" value="${answer.id}"/></#if>

<table width="85%" border="0" align="center" cellpadding="0" cellspacing="0" class='listTable'>
	<#list questionnaire.questions?sort_by("id") as question>
  <tr> 
    <td class="grayStyle">${question_index+1}、${question.description}</td>
  </tr>
  <tr> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="brightStyle">
    	<#list question.options?sort_by("seq") as option>
        <tr> 
          <td width="4%"><div align="center"> 
              <input type="radio" name="option${question.id}" value="${option.id}"  <#if (((checkedOptions.get(question).id)!0)==option.id)> checked</#if>>
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
  <tr>
  	<td align="center">
  	<button onclick="save()"> 提交</button>
  	</td>
  </tr>
</table>
</form>
</#if>

<script>
   var form=document.quesitonForm;
   function save(){
   	 if(confirm("确定提交?")){
   	     <#list (questionnaire.questions)! as question>
   	         var checked=false;
   	         for(var i=0;i<form["option${question.id}"].length;i++){
   	            if(form["option${question.id}"][i].checked){
   	            	checked=true;
   	            }
   	         }
   	         if(!checked){
   	           alert("问题${question_index+1}没有选择,请选择");return;
   	         }
   	     </#list>
   	     form.submit();
   	 }
   }
</script>
<#include "/template/foot.ftl"/>