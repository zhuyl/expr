  <table width="100%" onkeypress="DWRUtil.onReturn(event, search)">
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
    <form name="searchForm" action="student!search.action" target="contentListFrame" method="post" onsubmit="return false;">
    <tr><td width="40%">学生代码:</td><td><input type="text" name="student.code" style="width:100px;" maxlength="20"/></td></tr>
   	<tr><td>学生姓名:</td><td><input type="text" name="student.name" style="width:100px;" maxlength="20"/></td></tr>
   <tr height="50px"><td align="center" colspan="2"><input type="button" onclick="search();" value="<@text name="action.query"/>"   class="buttonStyle"/></td></tr>
    </form>
  </table>