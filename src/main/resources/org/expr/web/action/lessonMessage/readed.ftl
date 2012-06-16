<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Calendar.js"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/SystemMessage.js"></script>
<body>
	<table id="backBar"></table>
   	<@table.table width="100%" sortable="true" id="listTable" headIndex="1">
     	<form name="msgListForm" method="post" action="lessonMessage.action?method=readed&lesson.id=${Parameters['lesson.id']}" onsubmit="return false;">
      		<input type="hidden" name="method" value="readed">
			<tr onkeypress="dwr.util.onReturn(event, query)">
   	  			<td align="center"><img src="${base}/static/images/action/search.gif"  align="top" onClick="query()" alt="<@text name="info.filterInResult"/>"/></td>
   	  			<td><input style="width:100%" type="text" name="messageReceiver.message.title" maxlength="50" value="${Parameters['messageReceiver.message.title']?if_exists}"/></td>
   	  			<td><input style="width:100%" type="text" name="messageReceiver.message.sender.name" maxlength="32" value="${Parameters['messageReceiver.message.sender.name']?if_exists}"/></td>
   	  			<td><input style="width:100%" type="text" name="messageReceiver.message.sender.fullname" maxlength="50" value="${Parameters['messageReceiver.message.sender.fullname']?if_exists}"/></td>
   	  			<td><input style="width:100%" type="text" name="messageReceiver.message.createdAt" maxlength="10" value="${Parameters['messageReceiver.message.createdAt']!}" onfocus="calendar()"/></td>
   	  		</tr>
     	</form>
	     	<@table.thead>
	         	<@table.selectAllTd id="messageReceiverId"/>
		     	<@table.sortTd  id="messageReceiver.message.title"  text="消息标题"/>
		     	<@table.sortTd id="messageReceiver.message.sender.name" text="发送者"/>
		     	<@table.sortTd id="messageReceiver.message.sender.fullname" text="发送者姓名"/>
		     	<@table.sortTd id="messageReceiver.message.createdAt"  text="接收时间"/>
		  	</@>
		   	<@table.tbody datas=messageReceivers;receiver>
		     	<@table.selectTd id="messageReceiverId" value="${receiver.id}"/>
		     	<td width="20%"><A href="lessonMessage.action?method=info&messageReceiver.id=${receiver.id}">${receiver.message.title?if_exists}</A></td>
		     	<td width="15%">${receiver.message.sender?if_exists.name?if_exists}</td>
		     	<td width="15%">${receiver.message.sender?if_exists.fullname?if_exists}</td>
		     	<td width="10%">${receiver.message.createdAt?string("yyyy-MM-dd")?if_exists}</td>
		  	</@>
   	</@>
    <script>
		var bar = new ToolBar('backBar','已读消息',null,true,true);
		bar.setMessage('<@getMessage/>');
		bar.addItem('<@text name="action.info"/>',info,'detail.gif');
		
	    var form = document.msgListForm;
	    function query(pageNo,pageSize){
	       	goToPage(form,pageNo,pageSize);
	    }
    </script>
</body>
<#include "/template/foot.ftl"/>
