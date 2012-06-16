
  <table width="100%" onkeypress="DWRUtil.onReturn(event, searchExamQuestion)">
    <tr>
      <td colspan="2" class="infoTitle" align="left" valign="bottom" >
       <img src="${base}/static/images/action/info.gif" align="top"/>
          <B>题目查询</B>
      </td>
    <tr>
      <td colspan="2" style="font-size:0px">
          <img src="${base}/static/images/action/keyline.gif" height="2" width="100%" align="top"/>
      </td>
   </tr>
    <form name="searchForm" action="examQuestion.action?method=search" target="contentListFrame" method="post" onsubmit="return false;">
    <tr><td width="40%">题目序号:</td><td><input type="text" name="examQuestion.code" style="width:100px;" maxlength="32"/></td></tr>
   	<tr><td>题目名称:</td><td><input type="text" name="examQuestion.name" style="width:100px;" maxlength="20"/></td></tr>
   	<tr><td>案例名称:</td>
   	    <td><input type="text" name="examQuestion.caze.name" style="width:100px;" maxlength="20"/></td></tr>
    <tr height="50px"><td align="center" colspan="2"><input type="button" onclick="searchExamQuestion();" value="<@text name="action.query"/>"   class="buttonStyle"/></td></tr>
    </form>
  </table>
  