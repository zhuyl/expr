<table width="100%" height="28" border="0" cellpadding="0" cellspacing="0">
<tr> 
<td style="BACKGROUND: url(${base}/static/images/navbg.gif) repeat-x" vAlign=top> 
<TABLE class=01 cellSpacing=0 cellPadding=0 width="100%" align=right border=0>
<TBODY>
   <TR> 
   <TD id=tithomepage align=middle><A class=tit href="${base}/home.action?method=curriculumList">系统首页</A></TD>
    <TD><IMG height=28 src="${base}/static/images/navline.gif" width=2> </TD>
    <TD id=myRoom align=middle><A class=tit href="${base}/experimentStudy.action?lesson.id=${Parameters['lesson.id']}">学习任务</A></TD>
    <TD><IMG height=28 src="${base}/static/images/navline.gif" width=2> </TD>
    <TD id=myRoom align=middle><A class=tit href="${base}/exam/examStudent.action?lesson.id=${Parameters['lesson.id']}">课程测试</A></TD>
    <TD><IMG height=28 src="${base}/static/images/navline.gif" width=2> </TD>
    <TD align=middle><A class=tit href="${base}/lessonNotice.action?method=stdNoticeList&lesson.id=${Parameters['lesson.id']}">课程公告</A></TD>
    <TD><IMG height=28 src="${base}/static/images/navline.gif" width=2> </TD>
    <TD align=middle><A class=tit href="${base}/lessonMessage.action?method=stdindex&lesson.id=${Parameters['lesson.id']}">课程消息</A></TD>
    </TR>
</TBODY>
</TABLE></td>
</tr>
</table>