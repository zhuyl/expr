<#include "/template/head.ftl"/>
<BODY LEFTMARGIN="0" TOPMARGIN="0">
 <table id="bar"></table>
  <table class="frameTable">
   <tr>
    <td width="20%" class="frameTable_view">
        <#include "searchForm.ftl"/>
        <table><tr height="400px"><td></td></tr></table>
    </td>
    <td valign="top">
	 <iframe src="#" id="contentListFrame" name="contentListFrame" marginwidth="0" marginheight="0" scrolling="no" frameborder="0"  height="100%" width="100%"></iframe>
    </td>
   </tr>
  </table>
  <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/baseinfo/BaseInfo.js"></script>
  <script language="javascript">
    type="caze";
    keys="code,name,engName,lifeCycleType.name";
    titles="编码,名称,客户生命周期类型";  
    labelInfo="案例信息";
    search();
    searchCaze=search;
    //initBaseInfoBar();	
     var bar = new ToolBar("bar","案例管理",null,true,true);
     bar.addItem("添加","add()");
     bar.addItem("修改","edit()");
     bar.addItem("删除","remove()");	     	
  </script>  
  </body>
<#include "/template/foot.ftl"/>
