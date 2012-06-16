<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/itemSelect.js"></script>
<body>


<table width="100%" border="0" cellpadding="0" cellspacing="0" valign="top">
              <tr>
                <td>
                <#include "../teacherLesson/lessonNav.ftl"/>
                  </td>
              </tr> 
<tr>
</table>
<table id="backBar"></table>
<script>
   var bar = new ToolBar('backBar','${lesson.coursename!}课程消息',null,true,true);
   bar.setMessage('<@getMessage/>');
   bar.addBlankItem();
   function displayMessageList(td,kind){
      clearSelected(viewTables,td);
      setSelectedRow(viewTables,td);
      messageListFrame.location="lessonMessage.action?method="+kind+"&lesson.id=${Parameters['lesson.id']}";
   }
   function newSystemMessage(td,toWho){
      messageListFrame.location="lessonMessage!newMessage.action?lesson.id=${Parameters['lesson.id']}&who="+toWho;
   }
</script>
<table width="100%" height="93%" class="frameTable">
   <tr>
   <td valign="top" class="frameTable_view" width="17%" style="font-size:10pt">
      <table  width="100%" id ="viewTables" style="font-size:10pt">
	    <tr>
	      <td  class="infoTitle" align="left" valign="bottom">
	       <img src="${base}/static/images/action/info.gif" align="top"/>
	          <B>消息分类</B>      
	      </td>
	    <tr>
	      <td  colspan="8" style="font-size:0px">
	          <img src="${base}/static/images/action/keyline.gif" height="2" width="100%" align="top">
	      </td>
	   </tr>    
       <tr>
         <td class="padding"  onclick="displayMessageList(this,'newly')"  onmouseover="MouseOver(event)" onmouseout="MouseOut(event)">
         &nbsp;&nbsp;<image src="${base}/static/images/action/inbox.gif"> 新消息
         </td>
       </tr>
       <tr >
         <td class="padding" onclick="displayMessageList(this,'readed')"  onmouseover="MouseOver(event)" onmouseout="MouseOut(event)">
          &nbsp;&nbsp;<image src="${base}/static/images/action/readedMessage.gif">已读消息
         </td>
       </tr>
       <tr>
         <td class="padding"  onclick="displayMessageList(this,'sendbox')" onmouseover="MouseOver(event)" onmouseout="MouseOut(event)">
           &nbsp;&nbsp;<image src="${base}/static/images/action/sentbox.gif">已发送的
         </td>
       </tr>
           <tr>
	      <td  class="infoTitle" align="left" valign="bottom">
	       <img src="${base}/static/images/action/info.gif" align="top"/>
	          <B>发送消息</B>      
	      </td>
	    <tr>
	      <td  colspan="8" style="font-size:0px">
	          <img src="${base}/static/images/action/keyline.gif" height="2" width="100%" align="top">
	      </td>
	   </tr>    
       <tr>
         <td class="padding"  onclick="newSystemMessage(this,'std')" onmouseover="MouseOver(event)" onmouseout="MouseOut(event)">
         &nbsp;&nbsp;<image src="${base}/static/images/action/new.gif">发送到学生
         </td>
       </tr>
	  </table>
	<td>
	<td valign="top">
     	<iframe name="messageListFrame" src="lessonMessage.action?method=newly&lesson.id=${Parameters['lesson.id']}" width="100%" frameborder="0" scrolling="no">
	</td>
</table>
<#include "/template/foot.ftl"/>
