<#include "/template/head.ftl"/>
<body>
<#assign labInfo><@text name="测试信息"/></#assign>
<#include "/template/back.ftl"/>
  <table width="90%" align="center" class="infoTable">
    <tr>
      <td width="20%" id="f_code" class="title"><font color="red">*</font>测试编号:</td>
      <td width="30%">${examPaper.code?if_exists}</td>
      <td width="20%" id="f_name" class="title"><font color="red">*</font>测试名称:</td>
      <td width="30%">${examPaper.name?if_exists}</td>
    </tr>
    <tr>
      <td width="20%" id="f_beginAt" class="title"><font color="red">*</font>测试开始时间:</td>
      <td width="30%">${examPaper.beginAt?string("yyyy-MM-dd HH:mm")} </td>
      <td width="20%" id="f_endAt" class="title"><font color="red">*</font>测试结束时间:</td>
      <td width="30%">${examPaper.endAt?string("yyyy-MM-dd HH:mm")}</td>
    </tr>
        <tr>
      <td width="20%" id="f_period" class="title"><font color="red">*</font>测试用时：</td>
      <td width="80%" colspan="3">${examPaper.period}分钟 </td>
    </tr>
    <tr>
      <td class="title">导语:</td>
      <td colspan="4">${examPaper.introduction?if_exists}</td>
     </tr>
     <tr>
      <td class="title">备注:</td>
      <td colspan="4">${examPaper.memo?if_exists}</td>
     </tr>
     <tr class="darkColumn">
       <td colspan="5" align="center"><B>试题</B> </td>
     </tr>
      <tr>
       <td align="center">题目编号</td>
       <td colspan="2" align="center">
                    待选题目
       </td>
       <td align="center">题目得分</td>
     </tr>
     <#list examPaper.questionMarks?sort_by("code") as questionMark>
      <tr>
       <td align="center">${questionMark.code}</td>
       <td colspan="2" align="center">
       <#list questionMark.questions as question>
       <a href="../exam/examQuestion.action?method=info&examQuestion.id=${question.id}">${question.caze.name}</a><br>
       </#list>
       </td>
       <td align="center">${questionMark.mark}</td>
     </tr>
      </#list>
  </table>
  <br>  <br>  <br>  <br>  <br>
 </body>
 </html>