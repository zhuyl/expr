<#include "/template/head.ftl"/>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckeditor.js"></script>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckTextArea.js"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Validator.js"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Calendar.js"></script>
<script language="JavaScript" type="text/JavaScript" src='${base}/dwr/interface/insuranceDwrService.js'></script>
<body>
<table id="taskBar"></table>
<script>
  var bar = new ToolBar('taskBar', '家庭基本信息', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
  bar.addBack();
</script>
<#assign labInfo><@text name="家庭基本信息" /></#assign>
  <table width="90%" align="center" class="formTable">
    <form action="experimentStudy.action?method=saveFamilyInfo" name="familyInfoForm" method="post" onsubmit="return false;">
     <tr>
      <td width="20%" id="f_name" class="title"><font color="red">*</font>姓名:</td>
      <td width="80%">
      <input type="text" name="familyMember.name" maxlength="50" value="" style="width:50%;"/>
       </td>
    </tr>
      <tr>
      <td width="20%" id="f_age" class="title"><font color="red">*</font>年龄:</td>
      <td width="80%">
      <input type="text" name="familyMember.age" maxlength="50" value="" style="width:50%;"/>周岁
       </td>
    </tr>
    <tr>
      <td width="20%" id="f_gender" class="title"><font color="red">*</font>性别:</td>
      <td width="80%">
 <@htm.i18nSelect datas=Genders selected=""  name="familyMember.gender.id" style="width:50%;"><option value="">请选择</option></@></td>
    </tr>  
    <tr>
      <td width="20%" id="f_job" class="title"><font color="red">*</font>职业:</td>
     <input type="text" name="familyMember.job" maxlength="50" value="" style="width:50%;"/>
    </tr> 
    <tr>
      <td width="20%" id="f_relation" class="title"><font color="red">*</font>家庭关系:</td>
      <td width="80%">
      <select name="familyMember.relation.name" id="familyMemberRelationId" style="width:100px"></select>    </tr>  
    <tr>
      <td width="20%" id="f_salary" class="title"><font color="red">*</font>收入:</td>
      <input type="text" name="familyMember.salary" maxlength="50" value="" style="width:50%;"/>
     </tr>  
      <tr>
      <td width="20%" id="f_department" class="title"><font color="red">*</font>工作单位:</td>
      <td width="80%">
    <input type="text" name="familyMember.department" maxlength="50" value="" style="width:50%;"/>
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

   
</script>

 </body> 
</html>