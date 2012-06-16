<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Validator.js"></script>
<body>
<#assign labInfo>职业信息</#assign>
<#include "/template/back.ftl"/>
  <table width="90%" align="center" class="formTable">
    <form action="career!save.action" name="careerForm" method="post" onsubmit="return false;">
    <input type="hidden" name="career.id" value="${career.id!}">
    <input type="hidden" name="career.profile.id" value="${career.profile.id!}">
    <@searchParams/>
    <tr>
      <td width="20%" id="f_code" class="title"><font color="red">*</font>职业代码:</td>
      <td colspan="3">
      <input id="career.code" type="text" name="career.code" value="${career.code?if_exists}" maxLength="32" style="width:100%;">
      </td>
    </tr>
    <tr>
      <td id="f_name" class="title"><font color="red">*</font>职业名称:</td>
      <td>
     <input id="career.name" type="text" name="career.name" value="${career.name?if_exists}" maxLength="32" style="width:100%;">
       </td>
     </tr>
     <tr>
      <td id="f_parent" class="title">上一级职业:</td>
      <td>
      <@htm.i18nSelect datas=careers selected=""  name="career.parent.id" style="width:50%;"><option value="">请选择</option></@>
      </td>
    </tr>  
    <tr>
      <td width="20%" id="f_grade" class="title">职业等级:</td>
      <td>
      <@htm.i18nSelect datas=grades selected=""  name="career.grade.id" style="width:50%;"><option value="">请选择</option></@>
      </td>
    </tr>
		<tr class="darkColumn" align="center">
	      <td colspan="6">
	          <input type="button" onClick='save(this.form)' value="<@text name="system.button.submit"/>" class="buttonStyle"/>       
	          <input type="button" onClick='reset()' value="<@text name="system.button.reset"/>" class="buttonStyle"/>
	      </td>
	    </tr>
 	</table>
    </form> 
  <script language="javascript" > 
     function reset(){
         document.careerForm.reset();
     }
    function save(form){
         var a_fields = {
         'career.code':{'l':'职业代码', 'r':true, 't':'f_code'},
         'career.name':{'l':'职业名称', 'r':true, 't':'f_name'}
         };
		 var v = new validator(form , a_fields, null);
		 if (v.exec()) {
		    form.submit();
		 }
   }
</script>
 </body> 
</html>