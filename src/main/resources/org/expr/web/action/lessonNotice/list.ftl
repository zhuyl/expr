 <#include "/template/head.ftl"/>
 <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Validator.js"></script>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0" valign="top">
              <tr>
                <td>
                <#include "../teacherLesson/lessonNav.ftl"/>
                  </td>
              </tr> 
<tr>
<table id="toolbar"></table>
<@htm.actionForm name="actionForm" action="lessonNotice.action" entity="lessonNotice">
  <input type="hidden" name="lesson.id" value="${Parameters['lesson.id']}"/>
</@>
 <@table.table width="100%" sortable="true" id="noticeTable" style="word-break: break-all">
     <@table.thead>
     <@table.td text=""/>
	    <@table.td width="45%" id="notice.title" text="公告标题"/>
	    <@table.td text="发布人"  id="notice.publisher.name"/>
	    <@table.td text="发布时间" id="notice.updatedAt"/>
	   </@>
	   <@table.tbody datas=lessonNotices;notice>
	     <@table.selectTd id="lessonNoticeId" value=notice.id/>
	     <td><a href="lessonNotice.action?method=info&notice.id=${notice.id}">${notice.title}</a></td>
	     <td>${notice.publisher.name}</td>
	     <td>${(notice.updatedAt?string("yyyy-MM-dd"))!}</td>
	   </@>
	  </@>
 
</tr> 
</table>

   <script language="javascript">
     var bar = new ToolBar("toolbar","${lesson.coursename!}课程公告",null,true,true);
     bar.setMessage('<@getMessage/>');
     bar.addItem("添加","add()");
     bar.addItem("修改","edit()");
     bar.addItem("删除","remove()");

  </script>             


</body>
 <#include "/template/foot.ftl"/>