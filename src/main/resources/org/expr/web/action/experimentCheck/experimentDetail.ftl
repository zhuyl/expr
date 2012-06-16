 <#include "/template/simpleHead.ftl"/>
<body>
<table width="102%" border="0" cellpadding="0" cellspacing="0" class="listtable">
  <tr> 
    <td width="12%" class="grayStyle">实验编号</td>
    <td width="10%" class="brightStyle">${experiment.code!}</td>
    <td width="11%" class="grayStyle">实验名称</td>
    <td colspan="3" class="brightStyle">${experiment.name!}</td>
    <td width="13%" class="grayStyle">是否必选实验</td>
    <td width="16%" class="brightStyle">${(experiment.compulsory?if_exists)?string('是 ','否')}</td>
  </tr>
  <tr> 
    <td class="grayStyle">实验开始时间</td>
    <td class="brightStyle">${(experiment.beginAt?if_exists)?string("yyyy-MM-dd")}</td>
    <td class="grayStyle">实验结束时间</td>
    <td width="21%"  class="brightStyle">${(experiment.beginAt?if_exists)?string("yyyy-MM-dd")}</td>
    <td width="9%" class="grayStyle">实验类型</td>
    <td colspan="3"  class="brightStyle">${experiment.type.name!}</td>
  </tr>
  <tr> 
    <td class="grayStyle">实验目标</td>
    <td colspan="7" class="brightStyle">${experiment.aim!}</td>
  </tr>
  <tr> 
    <td class="grayStyle">实验指导</td>
    <td colspan="7" class="brightStyle">${experiment.coach!}</td>
  </tr>
  <tr> 
    <td class="grayStyle">案例编号</td>
    <td class="brightStyle">${experiment.caze.seq!}</td>
    <td class="grayStyle">案例名称</td>
    <td class="brightStyle">${experiment.caze.name!}</td>
    <td class="grayStyle">客户生命周期类型</td>
    <td width="8%" class="brightStyle">${(experiment.caze.lifeCycleType?if_exists).name!}</td>
    <td class="grayStyle">客户风险承受态度</td>
    <td class="brightStyle">${(experiment.caze.riskBearAttitude?if_exists).name!}</td>
  </tr>
  <tr> 
    <td class="grayStyle">社会经济状态</td>
    <td colspan="7" class="brightStyle">${experiment.caze.socialState!}</td>
  </tr>
  <tr> 
    <td class="grayStyle">动态平衡约束条件</td>
    <td colspan="7" class="brightStyle">${experiment.caze.dynaEquilibrium!}</td>
  </tr>
      <tr> 
    <td class="grayStyle">动态平衡调整年度</td>
    <td colspan="7" class="brightStyle">第${experiment.caze.changeYear?if_exists}年</td>
  </tr>
  <tr> 
    <td colspan="8" class="grayStyle"> <div align="center">案例内容</div></td>
  </tr>
  <tr> 
    <td colspan="8"  class="brightStyle">${experiment.caze.content!}</td>
  </tr>
</table>
</body>
<#include "/template/foot.ftl"/>