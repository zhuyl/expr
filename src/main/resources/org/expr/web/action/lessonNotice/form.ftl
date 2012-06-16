<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Validator.js"></script>
<script language="javascript" type="text/javascript" src="../${base}/static/scripts/fckeditor/fckeditor.js"></script>
<script language="javascript" type="text/javascript" src="../${base}/static/scripts/fckeditor/fckTextArea.js"></script>
<#assign textAreaId = "noticeContent"/>
<body>

<table width="100%" id="noticeBar"></table>       
<table width="100%"  class="listTable" >
   <form name="noticeForm" method="post" action="" onsubmit="return false;">
    <input type="hidden" name="lesson.id" value="${Parameters['lesson.id']}"/>  
   <input type="hidden" name="lessonNotice.id" value="${(notice.id)?if_exists}"/>
   <tr class="darkColumn">
     <td class="darkColumn" id="f_title" style="text-align:left"><font color="red">*</font>&nbsp;公告标题</td>
   </tr>
   <tr>
     <td  align="left">
     <input type="text" name="lessonNotice.title" style="width:100%" value="${(notice.title)?if_exists}" maxLength="60"></td>
   </tr>
   <tr class="darkColumn">
     <td class="darkColumn" id="f_content" style="text-align:left"><font color="red">*</font>&nbsp公告内容</td>
   </tr>
   <tr>
     <td  align="left" height="400">
	 <textarea id="lessonNotice.content" name="lessonNotice.content"  style="font-size:10pt;width:100%;height=100%">${(notice.content)?if_exists}</textarea>
     </td>
   </tr>
 </form>
</table>
<script>

   var bar = new ToolBar('noticeBar','公告详情',null,true,true);
   bar.setMessage('<@getMessage/>');
   bar.addItem("<@text name="action.save"/>",'save()','save.gif');
   bar.addBack("<@text name="action.back"/>");	


   function save(){
     var form = document.noticeForm;
     var a_fields = {
         'lessonNotice.title':{'l':'公告标题', 'r':true, 't':'f_title'}
     };
   var v = new validator(form , a_fields, null);
     if (v.exec()) {     
      form.action="lessonNotice.action?method=save";
      form.submit();
    }
   }
   
	initFCK("lessonNotice.content", "100%", "100%");
</script>
</body>
<#include "/template/foot.ftl"/>