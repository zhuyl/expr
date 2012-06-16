 <#include "/template/simpleHead.ftl"/>
<body>
<table width="102%" border="0" cellpadding="0" cellspacing="0" class="listtable">
  <tr> 
    <td class="grayStyle">案例编号</td>
    <td class="brightStyle">${caze.seq!}</td>
    <td class="grayStyle">案例名称</td>
    <td class="brightStyle">${caze.name!}</td>
    <td class="grayStyle">客户生命周期类型</td>
    <td width="8%" class="brightStyle">${caze.lifeCycleType.name}</td>
    <td class="grayStyle">客户风险承受态度</td>
    <td class="brightStyle">${(caze.riskBearAttitude?if_exists).name?if_exists}</td>
  </tr>
  <tr> 
    <td class="grayStyle">社会经济状态</td>
    <td colspan="7" class="brightStyle">${caze.socialState!}</td>
  </tr>
  <tr> 
    <td class="grayStyle">动态平衡约束条件</td>
    <td colspan="7" class="brightStyle">${caze.dynaEquilibrium!}</td>
  </tr>
  <tr> 
    <td class="grayStyle">动态平衡调整年度</td>
    <td colspan="7" class="brightStyle">第${caze.changeYear?if_exists}年</td>
  </tr>   
  <tr> 
    <td colspan="8" class="grayStyle"> <div align="center">案例内容</div></td>
  </tr>
  <tr> 
    <td colspan="8"  class="brightStyle">${caze.content!}</td>
  </tr>
</table>
</body>
<#include "/template/foot.ftl"/>