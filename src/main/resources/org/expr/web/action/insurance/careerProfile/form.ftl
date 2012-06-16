<#include "/template/head.ftl"/>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckeditor.js"></script>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckTextArea.js"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Validator.js"></script>
 <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Calendar.js"></script>
<body>
<#assign labInfo><@text name="职业等级方案" /></#assign>
<#include "/template/back.ftl"/>
  <table width="90%" align="center" class="formTable">
    <form action="careerProfile!save.action" name="careerProfileForm" method="post" onsubmit="return false;">
    <@searchParams/>
    <tr>
      <td width="20%" id="f_name" class="title"><font color="red">*</font>方案名称:</td>
      <td width="80%">
      <input id="careerProfile.name" type="text" name="careerProfile.name" value="${careerProfile.name?if_exists}" maxLength="32" style="width:100%;">
      <input type="hidden"  name="careerProfile.id" value="${careerProfile.id!}"/>
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
         document.careerProfileForm.reset();
     }
    function save(form){
         var a_fields = {
         'careerProfile.name':{'l':'方案名称', 'r':false, 't':'f_name'}
         };
		 var v = new validator(form , a_fields, null);
		 if (v.exec()) {
		    form.submit();
		 }
   }
</script>
 </body> 
</html>