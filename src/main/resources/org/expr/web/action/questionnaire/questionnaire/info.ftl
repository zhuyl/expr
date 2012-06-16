<#include "/template/head.ftl"/>
<table id="taskBar"></table>
<script>
  var bar = new ToolBar('taskBar', '${questionnaire.name}', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
  bar.addBack();
</script>
<table width="85%" border="0" align="center" cellpadding="0" cellspacing="0" class='listTable'>
	<#list questionnaire.questions as question>
  <tr> 
    <td class="grayStyle">${question_index+1}、${question.description}</td>
  </tr>
  <tr> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="brightStyle">
    	<#list question.options as option>
        <tr> 
          <td width="4%"><div align="center"> 
              <input type="radio" name="option${question.id}" >
          </td>
          <td width="96%">${option.context}</td>
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
  	<td>
  	得分等级列表：
  	<ul>
  	<#list questionnaire.ranks?sort_by("lower")  as rank>
  	<li>${rank.name} : ${rank.lower}~${rank.upper}</li>
  	</#list>
  	</ul>
  	</td>
  </tr>
</table>
<#include "/template/foot.ftl"/>