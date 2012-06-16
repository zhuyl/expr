 <#include "/template/head.ftl"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td>
                <#include "../../experimentStudy/lessonNav.ftl"/>
                  </td>
              </tr>  
 			  <tr>
			    <td height="34"> 
<table id="taskBar"></table>
<script>
  var bar = new ToolBar('taskBar', '${lesson.coursename}测试列表', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
  bar.addBlankItem();
</script>
			  </td>
			  </tr>		  
              <tr>
                <td>
 <@table.table width="100%" sortable="true" id="noticeTable" style="word-break: break-all">
     <@table.thead>
	    <@table.td text="测试编号"/>
	    <@table.td text="测试名称"/>
	    <@table.td text="测试有效时间"/>
	    <@table.td text="测试用时"/>
	    <@table.td text="进入测试"/> 
	    <@table.td text="查看试卷（得分）"/> 	    
	   </@>
	   <@table.tbody datas=examPapers?sort_by("code");paper> 
	   <#assign examPaperResult=examPaperResults.get(paper.id)>              
                            <td>${paper.code}</td>
                            <td>${paper.name}</td>
                            <td>${paper.beginAt?string("yyyy-MM-dd HH:mm")}-${paper.endAt?string("yyyy-MM-dd HH:mm")}</td>
                            <td>${paper.period!}分钟</td>
                            <td>
                            <#if examPaperResult.mark?exists>
                            <a href="examStudent!examAnswer.action?examPaperId=${paper.id}" target="_blank">已完成测试</a>
                            <#else>
                            	<#if ((currentTime?datetime>=paper.beginAt)&&(currentTime?datetime<=paper.endAt))>
                            	<a href="examStudent!examIndex.action?examPaperId=${paper.id}" target="_blank">进入测试</a>
                            	<#else>
                            	不在测试时间
                            	</#if>
                            </#if>
                            </td>                   
                            <td><a href="examStudent!examAnswer.action?examPaperId=${paper.id}" target="_blank">查看试卷（${examPaperResult.mark!0}）</a></td>                   
      </@>
 </@>               
</td>
</tr>
 </table>
 
 <form name="actionForm" method="post" action="examTeacher.action?method=remove">
    <input name="examPaperId" value="" type="hidden"/>
    <input name="params" value="&lesson.id=${lesson.id}" type="hidden"/>
 </form>