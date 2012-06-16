<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Calendar.js"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/SystemMessage.js"></script>
<body>
	<table id="backBar"></table>
	<script>
	   var bar = new ToolBar('backBar','已发送消息',null,true,true);
	   bar.setMessage('<@getMessage/>');
	   bar.addItem('<@text name="action.info"/>','info()','detail.gif');
	</script>
	<@table.table width="100%" sortable="true" id="listTable" headIndex="1">
   		<form name="msgListForm" method="post" action="lessonMessage!sendbox.action?lesson.id=${Parameters['lesson.id']}" onsubmit="return false;">
			<input type="hidden" name="method" value="sendbox">
			<tr  onkeypress="dwr.util.onReturn(event, query)">
				<td align="center"><img src="${base}/static/images/action/search.gif"  align="top" onClick="query()" alt="<@text name="info.filterInResult"/>"/></td>
				<td><input type="text" name="messageReceiver.message.title" maxlength="50" style="width:100%" value="${Parameters['messageReceiver.message.title']?if_exists}"/></td>
				<td><input type="text" name="messageReceiver.recipient.name" maxlength="32" style="width:100%" value="${Parameters['messageReceiver.recipient.name']?if_exists}"/></td>
				<td><input type="text" name="messageReceiver.recipient.fullname" maxlength="50" style="width:100%" value="${Parameters['messageReceiver.recipient.fullname']?if_exists}"/></td>
				<td>&nbsp;</td>
				<td><input type="text" name="messageReceiver.message.createdAt"  onfocus="calendar()" maxlength="10" style="width:100%" value="${Parameters['messageReceiver.message.createdAt']?if_exists}" onfocus="calendar()"/></td>
			</tr>
		</form>
			<@table.thead>
				<@table.selectAllTd id="messageReceiverId"/>
				<@table.sortTd id="messageReceiver.message.title" width="10%"  text="消息标题"/>
				<@table.sortTd width="15%" text="接收人帐号" id="messageReceiver.recipient.name"/>
				<@table.sortTd width="15%" text="接收人姓名" id="messageReceiver.recipient.fullname"/>
				<@table.sortTd width="10%" text="状态" id="messageReceiver.status.name"/>
				<@table.sortTd width="10%" text="接收时间" id="messageReceiver.message.createdAt" />
			</@>
			<@table.tbody datas=messageReceivers;receiver>
			    <@table.selectTd id="messageReceiverId" value=receiver.id/>
			    <td><A href="lessonMessage.action?method=info&messageReceiver.id=${receiver.id}">${receiver.message.title?if_exists}</A></td>
			    <td>${receiver.recipient.name}</td>
			    <td>${receiver.recipient.fullname}</td>
			    <td>${receiver.status.name}</td>
			    <td>${receiver.message.createdAt?string("yyyy-MM-dd")?if_exists}</td>
			</@>
	</@>
    <@htm.actionForm name="actionForm" action="lessonMessage.action" entity="messageReceiver" onsubmit="return false;">
    </@>
    <script>
	    function query(){
	       	document.msgListForm.submit();
	    }
    </script>
</body>
<#include "/template/foot.ftl"/>
