  <table width="100%" onkeypress="DWRUtil.onReturn(event, search)">
    <tr>
      <td colspan="2" class="infoTitle" align="left" valign="bottom" >
       <img src="${base}/static/images/action/info.gif" align="top"/>
          <B>职业等级方案查询</B>
      </td>
    <tr>
      <td colspan="2" style="font-size:0px">
          <img src="${base}/static/images/action/keyline.gif" height="2" width="100%" align="top"/>
      </td>
   </tr>
    <form name="searchForm" action="careerProfile.action?method=search" target="contentListFrame" method="post" onsubmit="return false;">
    <tr><td width="40%">职业等级方案名称:</td><td><input type="text" name="careerProfile.name" style="width:100px;" maxlength="32"/></td></tr>
    <tr height="50px"><td align="center" colspan="2"><input type="button" onclick="search();" value="<@text name="action.query"/>"   class="buttonStyle"/></td></tr>
    </form>
  </table>
