<#include "/template/head.ftl"/>
 <BODY LEFTMARGIN="0" TOPMARGIN="0" onload="f_frameStyleResize(parent)">
    <table id="myBar"></table>
     <@table.table width="100%"  onkeypress="dwr.util.onReturn(event,query)" sortable="true" id="listTable" headIndex="1">
       <form name="actionForm" onSubmit="return false;" method="post" action="lessonMessage.action?method=userList">
       <tr>
           <td><img src="${base}/static/images/action/search.png"  align="top" onClick="query()" alt="<@text name="info.filterInResult"/>"/></td>
           <td><input style="width:100%" type="text" name="user.code" maxlength="32" value="${Parameters['user.code']?if_exists}"></td>
           <td><input style="width:100%" type="text" name="user.name" maxlength="50" value="${Parameters['user.name']?if_exists}"></td>       </tr>
      </form>
       <@table.thead>
         <@table.selectAllTd id="code"/>
	     <@table.td text="用户名" id="user.code"/>
	     <td>姓名</td>
	   </@>
	   <@table.tbody datas=users;user>
	     <@table.selectTd id="code" value="${user.code}" />
	     <td>${user.code}</td>
  	     <td>${user.name}</td>
	   </@>
     </@>
 <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/system/SendMessage.js"></script>
<script>
    var bar= new ToolBar("myBar","班级学生列表",null,true,true);
    bar.addItem("选中添加","addSelected()");
    function getIds(){
       return(getCheckBoxValue(document.getElementsByName("code")));
    }
    <#list users as user>
	detailArray['${user.code}'] = {'name':'${user.code}'};
	</#list>

</script>
 </body>
<#include "/template/foot.ftl"/>
