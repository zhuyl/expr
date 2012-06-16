<#include "/template/head.ftl"/>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckeditor.js"></script>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckTextArea.js"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Validator.js"></script>
 <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Calendar.js"></script>
<body>
<#assign labInfo><@text name="评估标准信息" /></#assign>
<#include "/template/back.ftl"/>
  <table width="90%" align="center" class="formTable">
    <form action="assessment!save.action" name="assessmentForm" method="post" onsubmit="return false;">
    <@searchParams/>
    <tr>
      <td width="20%" id="f_name" class="title"><font color="red">*</font>评估标准名称:</td>
      <td width="80%">
      <input id="codeValue" type="text" name="assessment.name" value="${assessment.name?if_exists}" maxLength="32" style="width:100%;">
      <input type="hidden"  name="assessment.id" value="${assessment.id!}"/>
      </td>
    </tr>
    <tr>
      <td width="20%" id="f_author" class="title">评估标准作者:</td>
      <td width="80%">
      <input type="text" name="assessment.author" maxlength="50" value="${assessment.author!}" style="width:100%;"/>
      </td>
    </tr>
     <tr>
      <td width="20%" id="f_remark" class="title">评估标准说明:</td>
      <td width="80%">
         <textarea cols="50" id="assessment.remark" name="assessment.remark">${assessment.remark?if_exists}</textarea>

       </td>
    </tr>
    <tr class="darkColumn" align="center">
      <td colspan="2">
          <input type="button" onClick='save(this.form)' value="<@text name="system.button.submit"/>" class="buttonStyle"/>       
          <input type="button" onClick='reset()' value="<@text name="system.button.reset"/>" class="buttonStyle"/>
      </td>
    </tr>
    </form> 
  </table>
  <br>  <br>  <br>  <br>  <br>  <br>  <br>  <br>  <br>  <br>
  <script language="javascript" > 
     function reset(){
         document.assessmentForm.reset();
     }
    function save(form){
         var a_fields = {
         'assessment.name':{'l':'<@text name="attr.name" />', 'r':true, 't':'f_name'}
         };
		 var v = new validator(form , a_fields, null);
		 if (v.exec()) {
		    form.submit();
		 }
   }
   
</script>
 </body> 
</html>