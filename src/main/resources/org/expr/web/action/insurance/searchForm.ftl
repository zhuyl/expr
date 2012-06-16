  <table width="100%" onkeypress="DWRUtil.onReturn(event, search)">
    <tr>
      <td colspan="2" class="infoTitle" align="left" valign="bottom" >
       <img src="${base}/static/images/action/info.gif" align="top"/>
          <B>保险产品查询</B>
      </td>
    <tr>
      <td colspan="2" style="font-size:0px">
          <img src="${base}/static/images/action/keyline.gif" height="2" width="100%" align="top"/>
      </td>
   </tr>
    <form name="searchForm" action="insurance.action?method=search" target="contentListFrame" method="post" onsubmit="return false;">
    <tr><td width="40%">产品代码:</td><td><input type="text" name="insuranceProduct.seqNo" style="width:100px;" maxlength="32"/></td></tr>
   	<tr><td>产品名称:</td><td><input type="text" name="insuranceProduct.name" value="${Parameters['insurance.name']?if_exists}" style="width:100px;" maxlength="20"/></td></tr>
   	<tr><td>产品公司:</td><td><input type="text" name="insuranceProduct.corporation" value="${Parameters['insurance.corporation']?if_exists}" style="width:100px;" maxlength="20"/></td></tr>
   	<tr><td>产品类型:</td>
   	    <td>
   	     <select name="insuranceProduct.type.parent.id" onchange="getSubTypes(this.value)" style="width:100px">
         <option value="">...</option>
         <#list InsuranceTypes as insuranceType>
             <option value="${insuranceType.id}" >${insuranceType.name}</option>
         </#list>
         </select>
         <select name="insuranceProduct.type.id" id="insuranceProductType" style="width:100px"></select>
   	     </td>
   	</tr>
    <tr height="50px"><td align="center" colspan="2"><input type="button" onclick="search();" value="<@text name="action.query"/>"   class="buttonStyle"/></td></tr>
    </form>
  </table>
