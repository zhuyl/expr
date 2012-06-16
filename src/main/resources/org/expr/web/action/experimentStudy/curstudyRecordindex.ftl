<#include "/template/head.ftl"/>
<BODY LEFTMARGIN="0" TOPMARGIN="0">
 <table id="myBar"></table>
  <table class="frameTable">
   <tr>
    <td width="20%" class="frameTable_view">
        <#include "studyRecordSearchForm.ftl"/>
        <table><tr height="400px"><td></td></tr></table>
    </td>
    <td valign="top">
	 <iframe src="experimentStudy?method=curStudyRecord" id="contentListFrame" name="contentListFrame" marginwidth="0" marginheight="0" scrolling="no" frameborder="0"  height="100%" width="100%"></iframe>
    </td>
   </tr>
  </table>
  <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/baseinfo/BaseInfo.js"></script>
  <script language="javascript">

    labelInfo="课程学习记录";

  </script>  
  </body>
<#include "/template/foot.ftl"/>