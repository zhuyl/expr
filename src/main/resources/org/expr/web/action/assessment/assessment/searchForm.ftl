
  <table width="100%" onkeypress="DWRUtil.onReturn(event, searchAssessment)">
    <tr>
      <td colspan="2" class="infoTitle" align="left" valign="bottom" >
       <img src="${base}/static/images/action/info.gif" align="top"/>
          <B>评估标准查询</B>
      </td>
    <tr>
      <td colspan="2" style="font-size:0px">
          <img src="${base}/static/images/action/keyline.gif" height="2" width="100%" align="top"/>
      </td>
   </tr>
    <form name="searchForm" action="assessment.action?method=search" target="contentListFrame" method="post" onsubmit="return false;">
    <tr><td width="40%">评估标准名称:</td><td><input type="text" name="assessment.name" style="width:100px;" maxlength="32"/></td></tr>
    <tr><td width="40%">作者:</td><td><input type="text" name="assessment.author" style="width:100px;" maxlength="32"/></td></tr>
   	   <tr height="50px"><td align="center" colspan="2"><input type="button" onclick="searchAssessment();" value="<@text name="action.query"/>"   class="buttonStyle"/></td></tr>
 
    </form>
  </table>