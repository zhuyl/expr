<#include "/template/head.ftl"/>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckeditor.js"></script>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckTextArea.js"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Validator.js"></script>
 <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Calendar.js"></script>
<script language="JavaScript" type="text/JavaScript" src='${base}/dwr/interface/insuranceDwrService.js'></script>
<body>
<#assign labInfo><@text name="问卷信息" /></#assign>
<#include "/template/back.ftl"/>
  <table width="90%" align="center" class="formTable">
    <form action="questionnaire!save.action" name="questionnaireForm" method="post" onsubmit="return false;">
    <@searchParams/>
    <tr>
      <td width="20%" id="f_name" class="title"><font color="red">*</font>问卷名称:</td>
      <td width="80%">
      <input id="codeValue" type="text" name="questionnaire.name" value="${questionnaire.name?if_exists}" maxLength="32" style="width:100%;">
      <input type="hidden"  name="questionnaire.id" value="${questionnaire.id!}"/>
      </td>
    </tr>
    <tr>
      <td width="20%" id="f_author" class="title">问卷作者:</td>
      <td width="80%">
      <input type="text" name="questionnaire.author" maxlength="50" value="${questionnaire.author!}" style="width:100%;"/>
      </td>
    </tr>
     <tr>
      <td width="20%" id="f_head" class="title">问卷表头:</td>
      <td width="80%">
      <textarea cols="50" id="detail" name="questionnaire.head">${questionnaire.head?if_exists}</textarea>
       </td>
    </tr>
    <tr>
      <td width="20%" id="f_type" class="title"><font color="red">*</font>问卷类型:</td>
      <td width="80%">
 <@htm.i18nSelect datas=questionnaireTypes selected="${(questionnaire.type.id)?if_exists}"  
 name="questionnaire.type.id" style="width:50%;"><option value="">...</option></@>
      </td>
    </tr>   
     <tr>
      <td width="20%" id="f_status" class="title"><font color="red">*</font>是否有效:</td>
      <td width="80%" >
      <input type="radio" name="questionnaire.status" value="1" <#if questionnaire.status!false>checked</#if> />是
      <input type="radio" name="questionnaire.status" value="0" <#if !questionnaire.status!false>checked</#if>  />否
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
         document.questionnaireForm.reset();
     }
    function save(form){
         var a_fields = {
         'questionnaire.name':{'l':'<@text name="attr.name" />', 'r':true, 't':'f_name'},
         'questionnaire.type.id':{'l':'问卷类型', 'r':true, 't':'f_type'},
         'questionnaire.status':{'l':'是否有效', 'r':false, 't':'f_status'}
         };
		 var v = new validator(form , a_fields, null);
		 if (v.exec()) {
		    form.submit();
		 }
   }
   
</script>
 </body> 
</html>