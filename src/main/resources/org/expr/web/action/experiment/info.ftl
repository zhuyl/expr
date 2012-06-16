<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Validator.js"></script>
 <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Calendar.js"></script>
<body>
<#assign labInfo><@text name="学习任务信息"/></#assign>
<#include "/template/back.ftl"/>
  <table width="90%" align="center" class="infoTable">
    <tr class="darkColumn">
      <td colspan="4"><B>学习任务信息</B></td>
    </tr>
    <tr>
      <td width="20%" id="f_code" class="title"><font color="red">*</font>实验编号:</td>
      <td width="30%">${experiment.code?if_exists}</td>
      <td width="20%" id="f_name" class="title"><font color="red">*</font>实验名称:</td>
      <td width="30%">${experiment.name?if_exists}</td>
    </tr>
    <tr>
      <td width="20%" id="f_beginAt" class="title"><font color="red">*</font>实验开始时间:</td>
      <td width="30%">${experiment.beginAt?string("yyyy-MM-dd")} </td>
      <td width="20%" id="f_endAt" class="title"><font color="red">*</font>实验结束时间:</td>
      <td width="30%">${experiment.endAt?string("yyyy-MM-dd")}</td>
    </tr>
    <tr>
      <td width="20%" id="f_type" class="title"><font color="red">*</font>实验类型:</td>
      <td width="30%">${experiment.type.name}</td>
      <td width="20%" id="f_publish" class="title"><font color="red">*</font>是否公布答案:</td>
      <td width="30%">${experiment.publish?string('是 ','否')}</td>
    </tr>
    <tr>
      <td class="title">实验目标:</td>
      <td colspan="4">${experiment.aim?if_exists}</td>
     </tr>
     <tr>
      <td class="title">实验指导:</td>
      <td colspan="4">${experiment.coach?if_exists}</td>
     </tr>
    <tr>
      <td class="title">评估标准:</td>
      <td colspan="4"><a href="assessment/assessment.action?method=info&assessment.id=${experiment.assessment.id}">${experiment.assessment.name?if_exists}</a></td>
     </tr>
     <tr>
      <td class="title" id="f_caze"><font color="red">*</font>选择案例：</td>
      <td colspan="4"><a href="caze.action?method=info&caze.id=${experiment.caze.id}">${experiment.caze.name?if_exists}</a></td>
     </tr>
     <tr class="darkColumn">
       <td colspan="5" align="center"><B>分析内容</B> </td>
     </tr>
     <#list experiment.marks?sort_by(["analysis","code"]) as mark>
      <tr>
       <td colspan="5"><li>${mark.analysis.phase.name}-${mark.analysis.name} ${mark.mark?if_exists}</li></td>
     </tr>
      </#list>
  </table>
  <br>  <br>  <br>  <br>  <br>
 </body>
 </html>