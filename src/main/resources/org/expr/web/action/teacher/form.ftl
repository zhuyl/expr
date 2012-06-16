<#include "/template/head.ftl"/>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckeditor.js"></script>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckTextArea.js"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Validator.js"></script>
<body>
<#assign labInfo><@text name="教师信息" /></#assign>
<#include "/template/back.ftl"/>
  <table width="90%" align="center" class="formTable">
    <form action="teacher.action?method=save" name="teacherForm" method="post" onsubmit="return false;">
    <@searchParams/>
    <tr class="darkColumn">
      <td colspan="4"><B>教师信息</B></td>
    </tr>
    <tr>
      <td width="20%" id="f_code" class="title"><font color="red">*</font>教师工号：</td>
      <td width="30%">
      <input id="codeValue" type="text" name="teacher.code" value="${teacher.code?if_exists}" maxLength="32" style="width:100%;">
      <input type="hidden"  name="teacher.id" value="${teacher.id?if_exists}"/>
      </td>
      <td width="20%" id="f_name" class="title"><font color="red">*</font>教师姓名:</td>
      <td width="30%"><input type="text" name="teacher.name" value="${teacher.name?if_exists}" maxLength="20" style="width:100%;"></td>
    </tr>
    <tr class="darkColumn" align="center">
      <td colspan="4">
          <input type="button" onClick='save(this.form)' value="<@text name="system.button.submit"/>" class="buttonStyle"/>       
          <input type="button" onClick='reset()' value="<@text name="system.button.reset"/>" class="buttonStyle"/>
      	  <input type="hidden"  name="teacher.gender.id" value="1"/>
      </td>
    </tr>
    </form> 
  </table>
  <br>  <br>  <br>  <br>  <br>
  <script language="javascript" > 
     function reset(){
         document.lessonForm.reset();
     }
    function save(form,params){
         var a_fields = {
         'teacher.code':{'l':'<@text name="attr.code" />', 'r':true, 't':'f_code'},
         'teacher.name':{'l':'<@text name="attr.name" />', 'r':true, 't':'f_name'}
         };
		 var v = new validator(form , a_fields, null);
		 if (v.exec()) {
		    form.action="teacher.action?method=save";
		    if(null!=params)
		       form.action+=params;
		    form.submit();
		 }
   }
</script>
 </body> 
</html>
