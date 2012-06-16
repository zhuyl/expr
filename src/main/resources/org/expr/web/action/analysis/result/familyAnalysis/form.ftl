<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Validator.js"></script>
 <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Calendar.js"></script>
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
    <input name="familyMemberResult.id" type="hidden" value="${familyMemberResult.id!}"/>
    <input type="hidden" name="experiment.id" value="${Parameters['experiment.id']}"/>
    <input type="hidden" name="params" value="&experiment.id=${Parameters['experiment.id']}"/>
     <tr>
      <td width="20%" id="f_name" class="title"><font color="red">*</font>姓名:</td>
      <td width="80%">
      <input type="text" name="familyMemberResult.member.name" value="${(familyMemberResult.member.name)!}" maxlength="50" value="" style="width:50%;"/>
       </td>
    </tr>
      <tr>
      <td width="20%" id="f_age" class="title"><font color="red">*</font>年龄:</td>
      <td width="80%">
      <input type="text" name="familyMemberResult.member.age" value="${(familyMemberResult.member.age)!}" maxlength="50" value="" style="width:50%;"/>周岁
       </td>
    </tr>
    <tr>
      <td width="20%" id="f_birthday" class="title"><font color="red">*</font>出生日期:</td>
     <td><input type="text" name="familyMemberResult.member.birthday" maxlength="10" value="${(familyMemberResult.member.birthday?string('yyyy-MM-dd'))?if_exists}" onfocus="calendar()"/></td>
    </tr> 
    <tr>
      <td width="20%" id="f_gender" class="title"><font color="red">*</font>性别:</td>
      <td width="80%">
 <@htm.i18nSelect datas=Genders selected="${(familyMemberResult.member.gender.id)?if_exists}" 
   name="familyMemberResult.member.gender.id" style="width:50%;"><option value="">请选择</option></@></td>
    </tr>  
    <tr>
      <td width="20%" id="f_job" class="title"><font color="red">*</font>职业:</td>
     <td>
        <select id="category1" name="category1" style="width:100px;">
       		<option value="${(familyMemberResult.member.career.parent.parent.id)!}"></option>
    	</select>
        <select id="category2" name="category1" style="width:100px;">
       		<option value="${(familyMemberResult.member.career.parent.id)!}"></option>
    	</select>
        <select id="category3" name="familyMemberResult.member.career.id" style="width:100px;">
       		<option value="${(familyMemberResult.member.career.id)!}"></option>
    	</select>
    	<script src='${base}/dwr/interface/careerDwrService.js'></script>
    	<script src='${base}/static/scripts/career.js'></script>
		<script>
		    var categories = new Array();
		    <#list careers as career>
		    categories[${career_index}]={'id':'${career.id?if_exists}','name':'<@i18nName career/>'};
		    </#list>
		    var sds = new CareerSelect("category1","category2","category3",true,true,true);
		    sds.init(categories);
		</script>
     </td>
    </tr> 
    <tr>
      <td width="20%" id="f_relation" class="title"><font color="red">*</font>家庭关系:</td>
      <td width="80%">
  <@htm.i18nSelect datas=BenefitRealtion selected="${(familyMemberResult.member.relation.id)!}"  
 name="familyMemberResult.member.relation.id" style="width:50%;"><option value="">请选择</option></@>
  </tr>  
    <tr>
      <td width="20%" id="f_salary" class="title">收入:</td>
      <td><input type="text" name="familyMemberResult.member.salary" value="${(familyMemberResult.member.salary)!}" maxlength="30" value="" style="width:50%;"/>元</td>
     </tr>  
      <tr>
      <td width="20%" id="f_department" class="title">工作单位:</td>
      <td width="80%">
    <input type="text" name="familyMemberResult.member.department"  value="${(familyMemberResult.member.department)!}"  maxlength="50" value="" style="width:50%;"/>
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
             'familyMemberResult.member.name':{'l':'姓名', 'r':true, 't':'f_name'},
             'familyMemberResult.member.gender.id':{'l':'性别', 'r':true,'t':'f_gender'},
             'familyMemberResult.member.birthday':{'l':'出生日期', 'r':true,'t':'f_birthday'},
             'familyMemberResult.member.age':{'l':'年龄', 'r':true, 't':'f_age','f':'unsigned'},
             'familyMemberResult.member.career.id':{'l':'职业', 'r':true,'t':'f_job'},
             'familyMemberResult.member.relation.id':{'l':'家庭关系', 'r':true,'t':'f_relation'},
             'familyMemberResult.member.salary':{'l':'收入', 't':'f_salary','f':'unsignedReal'}
         };
		 var v = new validator(form , a_fields, null);
		 if (v.exec()) {
		    form.submit();
		 }
   }
</script>
 </body> 
</html>