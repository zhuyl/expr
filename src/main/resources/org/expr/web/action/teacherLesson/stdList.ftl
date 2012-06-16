 <#include "/template/head.ftl"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td>
                <#include "../teacherLesson/lessonNav.ftl"/>
                  </td>
              </tr>  
 			  <tr>
			    <td height="34"> 
                  <DIV style="PADDING-BOTTOM: 6px; PADDING-TOP: 6px">
            <TABLE cellSpacing=0 cellPadding=0 width="98%" align=center 
border=0>
              <TBODY>
              <TR>
                        <TD background="${base}/static/images/milldbg.gif" height=34><TABLE height=34 cellSpacing=0 cellPadding=6 width="100%" 
                  border=0>
                              <TBODY>
                                <TR>
                                  <TD vAlign=center align=right width=20><IMG height=13 
                        src="${base}/static/images/arrowL.gif" width=13> </TD>
                                  <TD class=font_tit vAlign=center><strong><span class="redtext">${lesson.coursename}</span></strong><span class="subtitle">学生名单</span></TD>
                                  <TD class=font_tit vAlign=center color="red"><@getMessage/></TD>
                                  <TD class=font_tit align=right><a href='#' onclick="alert('on developing')">导入学生</a>&nbsp;&nbsp;<a href='#' onclick='addStd()'>添加学生</a></TD>
                                </TR>
                              </TBODY>
                            </TABLE> </TD>
                      </TR>
</TBODY></TABLE>
                  </DIV>
			  </td>
			  </tr>		  
              <tr>
                <td><table width="100%" cellpadding="0" cellspacing="0" style="border-collapse: collapse">
                    <tr> 
                      <td height="100%"><br> 
                      <table align="center" width="90%" border="0" cellspacing="0" cellpadding="0">
						  <tr class="subtitle" align="center"> 
                            <td class="tableheadborder">学号</td>
                            <td class="tableheadborder">姓名</td>
                            <td class="tableheadborder">学习时间</td>
                            <td class="tableheadborder">查看作业</td>
                            <td class="tableheadborder">发消息</td>
                          </tr>
						  <#list lesson.students as std>
						  <tr align='center'>
						    <td>${std.code}</td>
						    <td><a href='experiment.action?method=browseMark' target='_blank'>${std.name}</a></td>
						    <td><a href='experimentStudy.action?method=browseMark'>0</a></td>
						  </tr>
						  </#list>
						</table>
                        </td>
                    </tr>
                  </table></td>
              </tr>
 </table>
  <form name="actionForm" method="post" action="teacherLesson.action">
    <input name="lesson.id" value="${lesson.id}" type="hidden"/>
    <input name="params" value="&lesson.id=${lesson.id}" type="hidden"/>
 </form>
<script>
  function addStd(){
     var form=document.actionForm;
     var stdNos="";
     stdNos=prompt("请输入学号:","");
     if(stdNos==null) return;
     addInput(form,"stdNos",stdNos);
     form.action+="?method=addStd";
     form.submit();
  }
</script>
</body>
<#include "/template/foot.ftl"/>