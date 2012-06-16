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
    <form name="searchForm" action="caze.action?method=search" target="contentListFrame" method="post" onsubmit="return false;">
    <tr><td width="40%">编号:</td><td><input type="text" name="caze.seq" style="width:100px;" maxlength="32"/></td></tr>
   	<tr><td>案例名称:</td><td><input type="text" name="caze.name" value="${Parameters['caze.name']?if_exists}" style="width:100px;" maxlength="20"/></td></tr>
   	<tr><td>客户生命周期类型:</td>
   	    <td><@htm.i18nSelect datas=lifeCycleTypes selected="0"  name="caze.lifeCycleType.id" style="width:100px;"><option value=""><@text name="common.all"/></option></@>
    </td></tr>
    <tr><td>是否发布:</td>
   	    <td>
   	        <select name="caze.publish" style="width:100px;">
    			<option value=''>--请选择--</option>
    			<option value='1'>是</option>
    			<option value='0'>否</option>
    		</select>	
    </td></tr>
    <tr height="50px"><td align="center" colspan="2"><input type="button" onclick="searchCaze();" value="<@text name="action.query"/>"   class="buttonStyle"/></td></tr>
    </form>
  </table>
