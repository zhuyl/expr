<#include "/template/head.ftl"/>
<body>
<table id="taskBar"></table>
<script>
  var bar = new ToolBar('taskBar', '家庭资产负债分析', null, true, false);
  bar.setMessage('<@getMessage/>');
  bar.addItem('保存', 'save()');
  function save(){
  
    document.actionForm.submit();
  }
</script>
<table width="85%" border="0" align="center" cellpadding="0" cellspacing="0" class="listTable">
<form name="actionForm" method="post" action="experimentStudy.action?method=saveBalanceSheet">
  <#if (answer.id)?exists>
  <input name="answer.id" type="hidden" value="${answer.id}"/>
  <#else>
  <input name="answer.caze.id" type="hidden" value="${Parameters['caze.id']}"/>
  </#if>
  <input name="params" type="hidden" value="&caze.id=<#if Parameters['caze.id']?exists>${Parameters['caze.id']}<#else>${answer.caze.id}</#if>"/>
  <tr height="22"> 
    <td colspan="2" class="darkColumn"> <div align="center">资产</div></td>
    <td colspan="2" class="darkColumn"> <div align="center">负债</div></td>
  </tr>
  <tr height="22"> 
    <td width="25%" class="darkColumn"> <div align="center">资产项目</div></td>
    <td width="25%" class="darkColumn"> <div align="center">金额</div></td>
    <td width="25%" class="darkColumn"> <div align="center">负债项目</div></td>
    <td width="25%" class="darkColumn"> <div align="center">金额</div></td>
  </tr>
  <#assign maxItems=assetProjects?size>
  <#if (maxItems<liabilityProjects?size)><#assign maxItems=liabilityProjects?size></#if>
  <#list 0..maxItems-1 as i>
  <tr height="22">
    <td class="grayStyle" <#if !(assetProjects[i].parent)?exists>style="font-weight:bold;"</#if>>${(assetProjects[i].name)?default("&nbsp;")}</td>
    <td class="brightStyle"><input name="assetProject${assetProjects[i].id}" type="text" value="${(assetMap[(assetProjects[i].id?string)?default('0')])?if_exists}" style="width:100%"/></td>
    <td class="grayStyle" <#if !(liabilityProjects[i].parent)?exists>style="font-weight:bold;"</#if>>${(liabilityProjects[i].name)?default("&nbsp;")}</td>
    <td class="brightStyle"><input name="liabilityProject${liabilityProjects[i].id}" type="text" value="${(liabilityMap[(liabilityProjects[i].id?string)?default('0')])?if_exists}" style="width:100%"/></td>
  </tr>
  </#list>
  <tr height="22"> 
    <td class="grayStyle"><strong>总资产</strong></td>
    <td class="brightStyle"><input name="answer.form.totalAssets" type="text" value="${(answer.form.totalAssets)?if_exists}" style="width:100%"/></td>
    <td class="grayStyle"><strong>总负债</strong></td>
    <td class="brightStyle"><input name="answer.form.totalLiabilities" type="text" value="${(answer.form.totalLiabilities)?if_exists}" style="width:100%"/></td>
  </tr>
  <tr height="22"> 
    <td class="grayStyle"><strong>总净值</strong></td>
    <td colspan="3" class="brightStyle"><input name="answer.form.totalNet" type="text" value="${(answer.form.totalNet)?if_exists}" style="width:100%"/></td>
  </tr>
  </form>
</table>
</body>
<#include "/template/foot.ftl"/>