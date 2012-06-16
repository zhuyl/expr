  <table width="100%" onkeypress="DWRUtil.onReturn(event, searchCaze)">
    <tr>
      <td colspan="2" class="infoTitle" align="left" valign="bottom" >
       <img src="${base}/static/images/action/info.gif" align="top"/>
          <B>案例查询</B>
      </td>
    <tr>
      <td colspan="2" style="font-size:0px">
          <img src="${base}/static/images/action/keyline.gif" height="2" width="100%" align="top"/>
      </td>
   </tr>
    <form name="searchForm" action="studentCaze.action?method=search" target="contentListFrame" method="post" onsubmit="return false;">
    <tr><td width="40%">编号:</td><td><input type="text" name="caze.seq" style="width:100px;" maxlength="32"/></td></tr>
   	<tr><td>案例名称:</td><td><input type="text" name="caze.name" value="${Parameters['caze.name']?if_exists}" style="width:100px;" maxlength="20"/></td></tr>
   	<tr><td>客户生命周期类型:</td>
   	    <td>
   	    <select name='caze.lifeCycleType.id' style="width:100px;">
   	    <option value=""><@text name="common.all"/></option>
   	    <#list lifeCycleTypes as lifecycletype>
   	    <option value="${lifecycletype.id}" <#if lifecycletype.id?string=Parameters['caze.lifeCycleType.id']?default('0')>selected</#if> >${lifecycletype.name}</option>
   	    </#list>
   	    </select>
    </td></tr>
    <tr height="50px"><td align="center" colspan="2"><input type="button" onclick="search();" value="<@text name="action.query"/>"   class="buttonStyle"/></td></tr>
    </form>
  </table>
