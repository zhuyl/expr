<#include "/template/head.ftl"/>
<body>
<table id="backBar"></table>
<script>
     function reply(msgId){
        self.location="lessonMessage.action?method=reply&messageReceiver.id="+msgId;
     }
  	 var bar = new ToolBar('backBar','消息详情',null,true,true);
  	 bar.setMessage('<@getMessage/>');
  	 bar.addItem("回复","reply(${messageReceiver.id})","reply.gif");
  	 bar.addBack("<@text name="action.back"/>");
</script>
<table class="infoTable" width="100%">
    <tr>
		<td class="title"	width="30%">消息标题</td>
		<td class="content" >${messageReceiver.message.title?if_exists}</td>
    </tr>
    <tr>
		<td class="title">消息内容</td>
		<td class="content" >${messageReceiver.message.content?if_exists}</td>
    </tr>
    <tr>
		<td class="title">发送者</td>
		<td >${messageReceiver.message.sender.fullname?if_exists}</td>
    </tr>
    <tr>
		<td class="title" >发送时间</td>
		<td >${messageReceiver.message.createdAt?if_exists}</td>
    </tr>
</table>
</body>
<#include "/template/foot.ftl"/>
	  
