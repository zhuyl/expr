<#include "/template/head.ftl"/>
<table id="taskBar"></table>
<script>
  var bar = new ToolBar('taskBar', '${examQuestion.name!}:${examQuestion.caze.name!}', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
  bar.addBack();
</script>
<p align="center">${examQuestion.introduction!}</p>
<table width="85%" border="0" align="center" cellpadding="0" cellspacing="0" class='listTable'>
  <tr> 
    <td>${examQuestion.caze.content!}</td>
  </tr>
	<#list (examQuestion.items?if_exists)?sort_by("code") as item>
  <tr> 
    <td class="grayStyle">${item.code!}、${item.description!}<font color="#FF0000">(${item.weight}分)</font></td>
  </tr>
  <tr> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="brightStyle">
    	<#list (item.options?if_exists)?sort_by("code") as option>
        <tr> 
          <td width="4%"><div align="center"> 
              <input type="checkBox" disabled name="option${item.id}"  <#if (item.answer?index_of(option.code,0)!=-1)> checked</#if>>
          </td>
          <td width="96%">${option.code}、${option.description}</td>
        </tr>
        </#list>
        <tr> 
          <td>解析：</td>
          <td>${item.explain!}</td>
        </tr>
      </table>
    </td>
  </tr>
  </#list>
</table>
<#include "/template/foot.ftl"/>