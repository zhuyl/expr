<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Validator.js"></script>
<body>
<table id="taskBar"></table>
<script>
  var bar = new ToolBar('taskBar', '家庭基本信息', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
  bar.addBack();
</script>
<#assign labInfo><@text name="家庭基本信息" /></#assign>
  <table width="90%" align="center" class="formTable">
    <form action="familyAnalysis!save.action" name="familyInfoForm" method="post" onsubmit="return false;">
    <input name="familyMemberAnswer.id" type="hidden" value="${familyMemberAnswer.id!}"/>
    <input type="hidden" name="caze.id" value="${Parameters['caze.id']}"/>
    <input type="hidden" name="params" value="&caze.id=${Parameters['caze.id']}"/>
     <tr>
      <td width="20%" id="f_name" class="title"><font color="red">*</font>姓名:</td>
      <td width="80%">
      <input type="text" name="familyMemberAnswer.member.name" value="${(familyMemberAnswer.member.name)!}" maxlength="50" value="" style="width:50%;"/>
       </td>
    </tr>
      <tr>
      <td width="20%" id="f_age" class="title"><font color="red">*</font>年龄:</td>
      <td width="80%">
      <input type="text" name="familyMemberAnswer.member.age" value="${(familyMemberAnswer.member.age)!}" maxlength="50" value="" style="width:50%;"/>周岁
       </td>
    </tr>
    <tr>
      <td width="20%" id="f_gender" class="title"><font color="red">*</font>性别:</td>
      <td width="80%">
 <@htm.i18nSelect datas=Genders selected="${(familyMemberAnswer.member.gender.id)?if_exists}" 
   name="familyMemberAnswer.member.gender.id" style="width:50%;"><option value="">请选择</option></@></td>
    </tr>  
    <tr>
      <td width="20%" id="f_job" class="title">职业:</td>
     <td>
        <select id="category1" name="category1" style="width:100px;">
       		<option value="${(familyMemberAnswer.member.career.parent.parent.id)!}"></option>
    	</select>
        <select id="category2" name="category1" style="width:100px;">
       		<option value="${(familyMemberAnswer.member.career.parent.id)!}"></option>
    	</select>
        <select id="category3" name="familyMemberAnswer.member.career.id" style="width:100px;">
       		<option value="${(familyMemberAnswer.member.career.id)!}"></option>
    	</select>
    	<script src='${base}/dwr/interface/careerDwrService.js'></script>
    	<script src='${base}/static/scripts/career.js'></script>
		<script>
		    var categories = new Array();
		    <#list categories as category>
		    categories[${category_index}]={'id':'${category.id?if_exists}','name':'<@i18nName category/>'};
		    </#list>
		    var sds = new CareerSelect("category1","category2","category3",true,true,true);
		    sds.init(categories);
		</script>
     </td>
    </tr> 
    <tr>
      <td width="20%" id="f_relation" class="title"><font color="red">*</font>家庭关系:</td>
      <td width="80%">
  <@htm.i18nSelect datas=BenefitRealtion selected="${(familyMemberAnswer.member.relation.id)!}"  
 name="familyMemberAnswer.member.relation.id" style="width:50%;"><option value="">请选择</option></@>
  </tr>  
    <tr>
      <td width="20%" id="f_salary" class="title">收入:</td>
      <td><input type="text" name="familyMemberAnswer.member.salary" value="${(familyMemberAnswer.member.salary)!}" maxlength="30" value="" style="width:50%;"/>元</td>
     </tr>  
      <tr>
      <td width="20%" id="f_department" class="title">工作单位:</td>
      <td width="80%">
    <input type="text" name="familyMemberAnswer.member.department"  value="${(familyMemberAnswer.member.department)!}"  maxlength="50" value="" style="width:50%;"/>
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
    function save(form){
         var a_fields = {
             'familyMemberAnswer.member.name':{'l':'姓名', 'r':true, 't':'f_name'},
             'familyMemberAnswer.member.age':{'l':'年龄', 'r':true, 't':'f_age','f':'unsigned'},
             'familyMemberAnswer.member.salary':{'l':'收入', 't':'f_salary','f':'unsignedReal'},
             'familyMemberAnswer.member.gender.id':{'l':'性别', 'r':true,'t':'f_gender'},
             'familyMemberAnswer.member.relation.id':{'l':'家庭关系', 'r':true,'t':'f_relation'}
         };
		 var v = new validator(form , a_fields, null);
		 if (v.exec()) {
		    form.submit();
		 }
   }
</script>
 </body> 
</html>