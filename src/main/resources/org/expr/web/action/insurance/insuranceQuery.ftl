<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src='${base}/dwr/interface/insuranceDwrService.js'></script>
<BODY LEFTMARGIN="0" TOPMARGIN="0">
  <table class="frameTable">
   <tr>
    <td width="20%" class="frameTable_view">
        <#include "searchForm.ftl"/>
        <table><tr height="400px"><td></td></tr></table>
    </td>
    <td valign="top">
	 <iframe src="insurance.action?method=insuranceQueryList" id="contentListFrame" name="contentListFrame" marginwidth="0" marginheight="0" scrolling="no" frameborder="0"  height="100%" width="100%"></iframe>
    </td>
   </tr>
  </table>
  <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/baseinfo/BaseInfo.js"></script>
  <script language="javascript">
		    
    type="insurance";
    labelInfo="保险产品信息";

   function search(){
   document.searchForm.action='insurance.action?method=insuranceQueryList';
   	document.searchForm.submit();
   }
       function windowclose(){
          window.close();	
		}
   function getSubTypes(parentId){
       insuranceDwrService.getInsuranceTypes(parentId,setSubTypes);
   }
   function setSubTypes(data){
       dwr.util.removeAllOptions('insuranceProductType');
       var empty=[{"id":'',"name":''}];
       dwr.util.addOptions('insuranceProductType',empty,'id','name');
       dwr.util.addOptions('insuranceProductType',data,'id','name');
   }
		     	
  </script>  
  </body>
<#include "/template/foot.ftl"/>