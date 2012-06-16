<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Validator.js"></script>
<body>
<table id="taskBar"></table>
<script>
  var bar = new ToolBar('taskBar', '单个产品收益率分析', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
  bar.addBack();
</script>
<#assign labInfo><@text name="单个产品收益率分析" /></#assign>
  <table width="90%" align="center" class="formTable">
    <form action="benefitAnalysis!save.action" name="benefitForm" method="post" onsubmit="return false;">
    <input name="benefitItemAnswer.id" type="hidden" value="${benefitItemAnswer.id!}"/>
    <input type="hidden" name="caze.id" value="${Parameters['caze.id']}"/>
    <input type="hidden" name="params" value="&caze.id=${Parameters['caze.id']}"/>
    <tr>
      <td width="20%" id="f_incomeproject" class="title"><font color="red">*</font>产品类型:</td>
      <td width="80%">
 <@htm.i18nSelect datas=financeTypes selected="${(benefitItemAnswer.financetype.id)?if_exists}" 
   name="benefitItemAnswer.financetype.id" style="width:50%;"><option value="">请选择</option></@></td>
    </tr>  
     <tr>
      <td width="20%" id="f_content" class="title"><font color="red">*</font>收益率分析:</td>
      <td width="80%">
      <textarea rows="5" cols="70" id="content" name="benefitItemAnswer.content">${(benefitItemAnswer.content)?if_exists}</textarea></td>
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
    function save(form){
         var a_fields = {
             'benefitItemAnswer.financetype.id':{'l':'产品类型', 'r':true, 't':'f_incomeproject'},
             'benefitItemAnswer.content':{'l':'收益率分析', 'r':true, 't':'f_content'}
         };
		 var v = new validator(form , a_fields, null);
		 if (v.exec()) {
		    form.submit();
		 }
   }
</script>
 </body> 
</html>