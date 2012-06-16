<#include "/template/head.ftl"/>
<table id="taskBar"></table>
<script>
  var bar = new ToolBar('taskBar', '${assessment.name}', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
  bar.addBack();
</script>
<table width="85%" border="0" align="center" cellpadding="0" cellspacing="0" class='listTable'>
  <tr> 
    <td class="grayStyle">分析表</td>
    <td class="grayStyle">优</td>
    <td class="grayStyle">良</td>
    <td class="grayStyle">中</td>
    <td class="grayStyle">及格</td>
    <td class="grayStyle">不及格</td>
  </tr>
 <#list assessment.items?sort_by(["phase","code"]) as assessItem>
  <tr> 
   <td>${(assessItem.phase!).name!}</td>
   <td>${assessItem.excellent!}</td>
   <td>${assessItem.good!}</td>   
   <td>${assessItem.middle!}</td>  
   <td>${assessItem.pass!}</td> 
   <td>${assessItem.nopass!}</td> 
  </tr>
  </#list>
</table>
<#include "/template/foot.ftl"/>