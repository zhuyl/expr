  <table width="100%" onkeypress="DWRUtil.onReturn(event, search)">
    <tr>
      <td colspan="2" class="infoTitle" align="left" valign="bottom" >
       <img src="${base}/static/images/action/info.gif" align="top"/>
          <B>金融产品查询</B>
      </td>
    <tr>
      <td colspan="2" style="font-size:0px">
          <img src="${base}/static/images/action/keyline.gif" height="2" width="100%" align="top"/>
      </td>
   </tr>
    <form name="searchForm" action="finance.action?method=search" target="contentListFrame" method="post" onsubmit="return false;">
   	<tr><td>产品名称:</td><td><input type="text" name="finance.name" value="${Parameters['finance.name']?if_exists}" style="width:100px;" maxlength="20"/></td></tr>
   	<tr><td>产品类型:</td>
   	    <td>
   	     <select name="finance.financetype.parent.id" onchange="getSubTypes(this.value)" style="width:100px">
         <option value="">...</option>
         <#list FinanceTypes as financeType>
             <option value="${financeType.id}" >${financeType.name}</option>
         </#list>
         </select>
         <select name="finance.financetype.id" id="financeType" style="width:100px"></select>
   	     </td>
   	</tr>
   	<tr><td>风险等级:</td>
   	    <td><@htm.i18nSelect datas=RiskGrades selected="0"  name="finance.riskgrade.id" style="width:100px;"><option value=""><@text name="common.all"/></option></@>
    </td></tr>
   	<tr><td>流动性:</td>
   	    <td><@htm.i18nSelect datas=Mobilities selected="0"  name="finance.mobility.id" style="width:100px;"><option value=""><@text name="common.all"/></option></@>
    </td></tr> 
    <tr><td>计息周期:</td>
   	    <td><@htm.i18nSelect datas=RatePayPeriods selected="0"  name="finance.ratepayperiod.id" style="width:100px;"><option value=""><@text name="common.all"/></option></@>
    </td></tr>   
    <tr height="50px"><td align="center" colspan="2"><input type="button" onclick="search();" value="<@text name="action.query"/>"   class="buttonStyle"/></td></tr>
    </form>
  </table>
