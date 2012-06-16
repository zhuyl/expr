<#include "/template/head.ftl"/>
<BODY LEFTMARGIN="0" TOPMARGIN="0">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td>
                <#include "../teacherLesson/lessonNav.ftl"/>
                  </td>
              </tr>  
 			  <tr>
</table>
<table id="taskBar"></table>
<script>
  var bar = new ToolBar('taskBar', '实验指导', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
 bar.addBlankItem();
</script>
  <table class="frameTable">
   <tr>
    <td width="20%" class="frameTable_view">
        <#include "searchForm.ftl"/>
        <table><tr height="400px"><td></td></tr></table>
    </td>
    <td valign="top">
	 <iframe src="experiment.action?method=studentList&experimentId=${experiment.id}" id="contentListFrame" name="contentListFrame" marginwidth="0" marginheight="0" scrolling="no" frameborder="0"  height="100%" width="100%"></iframe>
    </td>
   </tr>
  </table>
  <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/baseinfo/BaseInfo.js"></script> 

  </body>
<#include "/template/foot.ftl"/>

  <script language="javascript">

   function searchStudent(){
   document.searchForm.action='experiment.action?method=studentList&experimentId=${experiment.id}';
   	document.searchForm.submit();
   }
   

  </script>