<#include "/template/head.ftl"/>
 <body>
    <#assign labInfo><@text name="课程信息"/></#assign> 
	<#include "/template/back.ftl"/>
   <table width="90%" align="center" class="infoTable">
    <@searchParams/>
    <tr>
      <td width="20%" id="f_seqNo" class="title">课程编号:</td>
      <td width="30%">${lesson.seqNo?if_exists}</td>
      <td width="20%" id="f_coursename" class="title">课程名称:</td>
      <td width="30%">${lesson.coursename?if_exists}</td>
    </tr>
    <tr>
      <td width="20%" id="f_beginAt" class="title">开始时间:</td>
      <td width="30%">${(lesson.beginAt?string("yyyy-MM-dd"))?if_exists}</td>
      <td width="20%" id="f_endAT" class="title">结束时间:</td>
      <td width="30%">${(lesson.endAt?string("yyyy-MM-dd"))?if_exists}</td>
    </tr>
     <tr>
      <td width="20%" id="f_teacher" class="title">授课教师:</td>
      <td width="80%" colspan="3"><@getBeanListNames lesson.teachers?if_exists/></td>
    </tr>
  </table>
  <#include "stdsDiv.ftl"/>
  </body>
<#include "/template/foot.ftl"/>
