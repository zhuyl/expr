<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src='${base}/dwr/interface/financeDwrService.js'></script>
<BODY LEFTMARGIN="0" TOPMARGIN="0">
 <table id="myBar"></table>
  <table class="frameTable">
   <tr>
    <td width="20%" class="frameTable_view">
        <#include "usersearchForm.ftl"/>
        <table><tr height="400px"><td></td></tr></table>
    </td>
    <td valign="top">
	 <iframe src="${base}/finance.action?method=userlist" id="contentListFrame" name="contentListFrame" marginwidth="0" marginheight="0" scrolling="no" frameborder="0"  height="100%" width="100%"></iframe>
    </td>
   </tr>
  </table>
  <script language="javascript">
    var bar = new ToolBar("myBar","金融产品信息",null,true,true);
     bar.addBlankItem();
    
    function search(pageNo,pageSize,orderBy){
     document.searchForm.action="finance!userlist.action";
     goToPage(document.searchForm,pageNo,pageSize,orderBy);
	}
   search();

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