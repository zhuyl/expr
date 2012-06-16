<#include "/template/head.ftl"/>
<BODY>
  <table id="toolbar"></table>
  <@getMessage/>
  <@table.table width="100%"  id="listTable" sortable="true">
    <@table.thead>
       <@table.td text=""/>
       <@table.sortTd name="消息标题" id="message.title"/>
       <@table.sortTd name="发送者姓名" id="message.sender.fullname"/>
       <@table.sortTd name="状态" id="message.status.name"/>
       <@table.sortTd name="接收时间" id="message.createdAt"/>                       
    </@>
    <@table.tbody datas=messages;message>
       <@table.selectTd id="messageId" value=message.id type="radio"/>
       <td><a href="lessonMessage.action?method=info&message.id=${message.id}">${message.messageContent.title?if_exists}</a></td>
       <td>${(message.messageContent.sender.name)?if_exists}</td>
       <td>${(message.status.name)?if_exists}</td> 
       <td>${(message.messageContent.createdAt)?if_exists}</td>                     
    </@>
   </@>
   <@htm.actionForm name="actionForm" action="lessonMessage.action" entity="lessonMessage"/>
  <script language="javascript">
     var bar = new ToolBar("toolbar","消息列表",null,true,true);
     bar.addItem("新消息","newMessage()");
     bar.addItem("查看","info()");
     bar.addItem("删除","remove()");
     var form = document.actionForm;
     function newMessage()
     {
     	form.action="lessonMessage.action?method=newMessage&lesson.id=${Parameters['lesson.id']}";
     	form.submit();
     }
  </script>
</body>
<#include "/template/foot.ftl"/>