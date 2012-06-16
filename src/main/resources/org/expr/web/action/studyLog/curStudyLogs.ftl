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
	    <@table.td text="实验编号"/>
	    <@table.td text="实验名称"/>
	    <@table.td text="实验类型"/>
	    <@table.td text="开始学习时间"/>
	    <@table.td text="结束学习时间"/>
	    <@table.td text="累计学习时间"/>	    
	   </@>
	   <@table.tbody datas=experiments;experiment>
	       <td>${experiment.code}</td>
	       <td>${experiment.name}</td>
	       <td>${experiment.type.name} </td>
	       <td>${experiment.beginAt?string("yyyy-MM-dd  HH:mm")}</td>
	       <td>${experiment.endAt?string("yyyy-MM-dd HH:mm")}</td>
	       <td><a href="studyLog.action?method=studyLogs&experimentId=${experiment.id}">累计时间</a></td>	       
	   </@>
	  </@>
 
</tr> 
</table>
   <script language="javascript">
     var bar = new ToolBar("toolbar","学习记录",null,true,true);
     bar.addBlankItem();
  </script>          
</body>
 <#include "/template/foot.ftl"/>