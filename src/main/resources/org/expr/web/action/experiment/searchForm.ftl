  <table width="100%" onkeypress="DWRUtil.onReturn(event, searchStudent)">
    <tr>
      <td colspan="2" class="infoTitle" align="left" valign="bottom" >
       <img src="${base}/static/images/action/info.gif" align="top"/>
          <B>学生查询</B>
      </td>
    <tr>
      <td colspan="2" style="font-size:0px">
          <img src="${base}/static/images/action/keyline.gif" height="2" width="100%" align="top"/>
      </td>
   </tr>
    <form name="searchForm" action="experiment.action?method=studentList" target="contentListFrame" method="post" onsubmit="return false;">
    <tr><td width="40%">学号</td><td><input type="text" name="student.code" style="width:100px;" maxlength="32"/></td></tr>
   	<tr><td>姓名</td><td><input type="text" name="student.name" value="" style="width:100px;" maxlength="20"/></td></tr>
   <tr height="50px"><td align="center" colspan="2"><input type="button" onclick="searchStudent();" value="<@text name="action.query"/>"   class="buttonStyle"/></td></tr>
    </form>
  </table>
  
