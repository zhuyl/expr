<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src='${base}/dwr/interface/financeDwrService.js'></script>
<BODY LEFTMARGIN="0" TOPMARGIN="0">
  <table class="frameTable">
   <tr>
    <td width="30%" class="frameTable_view">
        <#include "searchForm.ftl"/>
        <table><tr height="400px"><td></td></tr></table>
    </td>
    <td valign="top">
	 <iframe src="finance.action?method=financeQueryList" id="contentListFrame" name="contentListFrame" marginwidth="0" marginheight="0" scrolling="no" frameborder="0"  height="100%" width="100%"></iframe>
    </td>
   </tr>
  </table>
  <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/baseinfo/BaseInfo.js"></script>
  <script language="javascript">
		    
    type="finance";
    labelInfo="金融产品信息";

   function search(){
   document.searchForm.action='finance.action?method=financeQueryList';
   	document.searchForm.submit();
   }
       function windowclose(){
          window.close();	
		}
   function getSubTypes(parentId){
       financeDwrService.getFinanceTypes(parentId,setSubTypes);
   }
   function setSubTypes(data){
       dwr.util.removeAllOptions('financeType');
       var empty=[{"id":'',"name":''}];
       dwr.util.addOptions('financeType',empty,'id','name');
       dwr.util.addOptions('financeType',data,'id','name');
   }
		     	
  </script>  
  </body>
<#include "/template/foot.ftl"/>