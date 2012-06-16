
  <table width="100%" onkeypress="DWRUtil.onReturn(event, searchQuestionnaire)">
    <tr>
      <td colspan="2" class="infoTitle" align="left" valign="bottom" >
       <img src="${base}/static/images/action/info.gif" align="top"/>
          <B>问卷查询</B>
      </td>
    <tr>
      <td colspan="2" style="font-size:0px">
          <img src="${base}/static/images/action/keyline.gif" height="2" width="100%" align="top"/>
      </td>
   </tr>
    <form name="searchForm" action="questionnaire.action?method=search" target="contentListFrame" method="post" onsubmit="return false;">
    <tr><td width="40%">问卷名称:</td><td><input type="text" name="qeustionnaire.name" style="width:100px;" maxlength="32"/></td></tr>
   	<tr><td>是否有效:</td><td>
   	   	 <select name="questionnaire.status"  style="width:100px">
         <option value="">...</option>
             <option value="1" >是</option>
             <option value="0" >否</option>
         </select>
   	</td></tr>
   	   <tr height="50px"><td align="center" colspan="2"><input type="button" onclick="searchQuestionnaire();" value="<@text name="action.query"/>"   class="buttonStyle"/></td></tr>
 
    </form>
  </table>