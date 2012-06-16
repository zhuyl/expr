
  <table width="100%" onkeypress="DWRUtil.onReturn(event, searchLesson)">
    <tr>
      <td colspan="2" class="infoTitle" align="left" valign="bottom" >
       <img src="${base}/static/images/action/info.gif" align="top"/>
          <B>课程查询</B>
      </td>
    <tr>
      <td colspan="2" style="font-size:0px">
          <img src="${base}/static/images/action/keyline.gif" height="2" width="100%" align="top"/>
      </td>
   </tr>
    <form name="searchForm" action="lesson.action?method=search" target="contentListFrame" method="post" onsubmit="return false;">
    <tr><td width="40%">课程代码:</td><td><input type="text" name="lesson.seqNo" style="width:100px;" maxlength="32"/></td></tr>
   	<tr><td>课程名称:</td><td><input type="text" name="lesson.coursename" value="${Parameters['lesson.coursename']?if_exists}" style="width:100px;" maxlength="20"/></td></tr>
   	<tr><td>主讲教师:</td>
   	    <td><@htm.i18nSelect datas=teachers selected="${(lesson.teachers[0].id)?if_exists}"  name="teacher.id" style="width:100%;"><option value=""><@text name="common.all"/></option></@></td></tr>
    <tr height="50px"><td align="center" colspan="2"><input type="button" onclick="searchLesson();" value="<@text name="action.query"/>"   class="buttonStyle"/></td></tr>
    </form>
  </table>
  