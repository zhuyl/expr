<#include "/template/head.ftl"/>
<BODY LEFTMARGIN="0" TOPMARGIN="0">
 <table id="myBar"></table>
  <table class="formTable" width="100%">
  <tr>
    <td valign="top">${lesson.coursename!}课程名单,已有${(lesson.students?size)!0}人,请输入要添加的学号，以半角逗号、分号、空格、回车相隔。 </td>
   </tr>
   <tr>
    <td>
	<form name="lessonForm" method="post" action="lesson!importStd.action">
		<input name="lesson.id" type="hidden" value="${lesson.id!}">
		<input type="hidden" name="params" value="&lesson.id=${lesson.id}">
		<textarea name="stdCodes" cols="70" rows="10"></textarea>
	</form>
    </td>
   </tr>
  </table>
  <#include "stdsDiv.ftl"/>
  <script language="javascript">
  	var bar=new ToolBar('myBar',"课程名单添加",null,true,false);
  	bar.addItem("添加","addStd()");
  	bar.addBack();
    function addStd(){
    	if(confirm("确定添加填入的学号?")){
    		lessonForm.submit();
    	}
    }
  </script>
  </body>
<#include "/template/foot.ftl"/>