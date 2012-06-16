  <table width="100%" onkeypress="DWRUtil.onReturn(event, searchLesson)">
    <tr>
      <td colspan="2" class="infoTitle" align="left" valign="bottom" >
       <img src="${base}/static/images/action/info.gif" align="top"/>
          <B>学习记录查询</B>
      </td>
    <tr>
      <td colspan="2" style="font-size:0px">
          <img src="${base}/static/images/action/keyline.gif" height="2" width="100%" align="top"/>
      </td>
   </tr>
    <form name="searchForm" action="experimentStudy.action?method=search" target="contentListFrame" method="post" onsubmit="return false;">
    <tr><td width="40%">开始时间:</td><td><input type="text" name="lesson.seqNo" style="width:100px;" maxlength="32"/></td></tr>
   	<tr><td>结束时间:</td><td><input type="text" name="lesson.coursename" value="" style="width:100px;" maxlength="20"/></td></tr>
   	<tr><td>学号:</td><td><input type="text" name="lesson.coursename" value="" style="width:100px;" maxlength="20"/></td></tr>
   	<tr><td>姓名:</td><td><input type="text" name="lesson.coursename" value="" style="width:100px;" maxlength="20"/></td></tr>
    <tr height="50px"><td align="center" colspan="2"><input type="button" onclick="searchStudyRecord();" value="<@text name="action.query"/>"   class="buttonStyle"/></td></tr>
    </form>
  </table>
