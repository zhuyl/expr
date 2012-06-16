 <#include "/template/head.ftl"/>
 <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Validator.js"></script>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0" valign="top">
              <tr>
                <td>
                <#include "../experimentStudy/lessonNav.ftl"/>
                  </td>
              </tr> 
<tr>
<table id="toolbar"></table>
 <@table.table width="100%" sortable="true" id="noticeTable" style="word-break: break-all">
     <@table.thead>
	    <@table.sortTd width="45%" id="notice.title" text="公告标题"/>
	    <@table.sortTd text="发布人"  id="notice.publisher.name"/>
	    <@table.sortTd text="发布时间" id="notice.updatedAt"/>
	   </@>
	   <@table.tbody datas=lessonNotices;notice>
	     <td><a href="lessonNotice.action?method=info&notice.id=${notice.id}">${notice.title}</a></td>
	     <td>${notice.publisher.name}</td>
	     <td>${(notice.updatedAt?string("yyyy-MM-dd"))!}</td>
	   </@>
	  </@>
 
</tr> 
</table>
   <script language="javascript">
     var bar = new ToolBar("toolbar","${lesson.coursename!}课程公告",null,true,true);
     bar.addBlankItem();
  </script>          
</body>
 <#include "/template/foot.ftl"/>