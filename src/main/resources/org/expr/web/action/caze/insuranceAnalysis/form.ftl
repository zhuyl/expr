<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Validator.js"></script>
 <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Calendar.js"></script>
<body>
<table id="taskBar"></table>
<script>
  var bar = new ToolBar('taskBar', '保险资产信息', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
  bar.addBack();
</script>
<#assign labInfo><@text name="保险资产信息" /></#assign>
  <table width="90%" align="center" class="formTable">
    <form action="insuranceAnalysis!save.action" name="insuranceInfoForm" method="post" onsubmit="return false;">
    <input name="insurancePolicyAnswer.id" type="hidden" value="${insurancePolicyAnswer.id!}"/>
    <input type="hidden" name="caze.id" value="${Parameters['caze.id']}"/>
    <input type="hidden" name="params" value="&caze.id=${Parameters['caze.id']}"/>
     <tr>
      <td width="20%" id="f_name" class="title"><font color="red">*</font>保险名称:</td>
      <td width="80%">
      <input type="text" name="insurancePolicyAnswer.policy.name" value="${(insurancePolicyAnswer.policy.name)!}" maxlength="50" value="" style="width:50%;"/>
       </td>
    </tr>
      <tr>
      <td width="20%" id="f_company" class="title"><font color="red">*</font>保险公司:</td>
      <td width="80%">
      <input type="text" name="insurancePolicyAnswer.policy.company" value="${(insurancePolicyAnswer.policy.company)!}" maxlength="50" value="" style="width:50%;"/>
       </td>
    </tr>
    <tr>
      <td width="20%" id="f_insurant" class="title"><font color="red">*</font>被保险人物:</td>
      <td width="80%">
      <input type="text" name="insurancePolicyAnswer.policy.insurant" value="${(insurancePolicyAnswer.policy.insurant)!}" maxlength="50" value="" style="width:50%;"/>
       </td>
    </tr>
    <tr>
      <td width="20%" id="f_proposer" class="title"><font color="red">*</font>投保人:</td>
      <td width="80%">
      <input type="text" name="insurancePolicyAnswer.policy.proposer" value="${(insurancePolicyAnswer.policy.proposer)!}" maxlength="50" value="" style="width:50%;"/></td>
    </tr>  
    <tr>
      <td width="20%" id="f_proposer" class="title"><font color="red">*</font>受益人:</td>
      <td width="80%">
      <input type="text" name="insurancePolicyAnswer.policy.benefit" value="${(insurancePolicyAnswer.policy.benefit)!}" maxlength="50" value="" style="width:50%;"/></td>
    </tr>
    <tr>
      <td width="20%" id="f_applyOn" class="title">投保日期:</td>
     <td><input type="text" name="insurancePolicyAnswer.policy.applyOn" maxlength="10" value="${(insurancePolicyAnswer.policy.applyOn?string('yyyy-MM-dd'))?if_exists}" onfocus="calendar()"/></td>
    </tr> 
    <tr>
      <td width="20%" id="f_type" class="title"><font color="red">*</font>保险种类:</td>
      <td width="80%">
  <@htm.i18nSelect datas=InsuranceTypes selected="${(insurancePolicyAnswer.policy.type.id)!}"  
 name="insurancePolicyAnswer.policy.type.id" style="width:50%;"><option value="">请选择</option></@>
	</td> 
  </tr>  
    <tr>
      <td width="20%" id="f_coverage" class="title"><font color="red">*</font>保额:</td>
      <td width="80%">
      <input type="text" name="insurancePolicyAnswer.policy.coverage" value="${(insurancePolicyAnswer.policy.coverage)!}" maxlength="50" value="" style="width:50%;"/>元</td>
    </tr> 
    <tr>
      <td width="20%" id="f_expense" class="title">保费:</td>
      <td><input type="text" name="insurancePolicyAnswer.policy.expense" value="${(insurancePolicyAnswer.policy.expense)!}" maxlength="30" value="" style="width:50%;"/>元</td>
     </tr>  
    <tr>
      <td width="20%" id="f_payTime" class="title"><font color="red">*</font>缴费年限:</td>
      <td width="80%">
  <@htm.i18nSelect datas=InsurancePayTimes selected="${(insurancePolicyAnswer.policy.payTime.id)!}"  
 name="insurancePolicyAnswer.policy.payTime.id" style="width:50%;"><option value="">请选择</option></@>
 	</td> 
  </tr> 
  <tr>
      <td width="20%" id="f_payType" class="title"><font color="red">*</font>缴费方式:</td>
      <td width="80%">
  <@htm.i18nSelect datas=InsurancePayTypes selected="${(insurancePolicyAnswer.policy.payType.id)!}"  
 name="insurancePolicyAnswer.policy.payType.id" style="width:50%;"><option value="">请选择</option></@>
 	</td> 
  </tr> 
  <tr>
      <td width="20%" id="f_time" class="title"><font color="red">*</font>保险期限:</td>
      <td width="80%">
  <@htm.i18nSelect datas=InsuranceTimes selected="${(insurancePolicyAnswer.policy.time.id)!}"  
 name="insurancePolicyAnswer.policy.time.id" style="width:50%;"><option value="">请选择</option></@>
	</td> 
  </tr>
  <tr>
      <td width="20%" id="f_value" class="title">现金价值:</td>
      <td width="80%"><input type="text" name="insurancePolicyAnswer.policy.value" value="${(insurancePolicyAnswer.policy.value)!}" maxlength="30" value="" style="width:50%;"/>元</td>
  </tr>
    <tr>
      <td width="20%" id="f_impawn" class="title">保单质押贷款:</td>
      <td width="80%"><input type="text" name="insurancePolicyAnswer.policy.impawn" value="${(insurancePolicyAnswer.policy.impawn)!}" maxlength="30" value="" style="width:50%;"/>元</td>
  </tr>
  <tr>
      <td width="20%" id="f_additional" class="title"><font color="red">*</font>是否附加险:</td>
      
      <td width="80%"><@htm.radio2  name="insurancePolicyAnswer.additional" value=(insurancePolicyAnswer.additional)!(false)/></td>
 </tr>
    <tr>
      <td width="20%" id="f_master" class="title">主险:</td>
      <td width="80%">
      
  <@htm.i18nSelect datas=masters selected="${(insurancePolicyAnswer.master.id)!}"  
 name="insurancePolicyAnswer.master.id" style="width:50%;"><option value="">请选择</option></@>
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
    a_formats['money']=/^\d*\.?\d{0,2}$/;
    function save(form){
      var a_fields = {
         'insurancePolicyAnswer.policy.name':{'l':'保险名称', 'r':true, 't':'f_name'},
         'insurancePolicyAnswer.policy.coverage':{'l':'保额', 'r':true, 't':'f_coverage','f':'money'}
      };
	  var v = new validator(form , a_fields, null);
	  if (v.exec()) {
	    form.submit();
	  }
   }
</script>
 </body> 
</html>