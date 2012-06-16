<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Validator.js"></script>
 <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Calendar.js"></script>
<script language="JavaScript" type="text/JavaScript" src='${base}/dwr/interface/insuranceDwrService.js'></script>
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
    <input name="insurancePolicyResult.id" type="hidden" value="${insurancePolicyResult.id!}"/>
    <input type="hidden" name="experiment.id" value="${Parameters['experiment.id']}"/>
    <input type="hidden" name="params" value="&experiment.id=${Parameters['experiment.id']}"/>
     <tr>
      <td width="20%" id="f_name" class="title"><font color="red">*</font>保险名称:</td>
      <td width="80%">
      <input type="text" name="insurancePolicyResult.policy.name" value="${(insurancePolicyResult.policy.name)!}" maxlength="50" value="" style="width:50%;"/>
       </td>
    </tr>
      <tr>
      <td width="20%" id="f_company" class="title"><font color="red">*</font>保险公司:</td>
      <td width="80%">
      <input type="text" name="insurancePolicyResult.policy.company" value="${(insurancePolicyResult.policy.company)!}" maxlength="50" value="" style="width:50%;"/>
       </td>
    </tr>
    <tr>
      <td width="20%" id="f_insurant" class="title"><font color="red">*</font>被保险人:</td>
      <td width="80%">
        <select  name="insurancePolicyResult.policy.insurant"  style="width:250px;"  >
      <#list members as member>
      <option value="${member.name}" <#if member.name=(insurancePolicyResult.policy.insurant)!>selected</#if>>
      ${member.name}(年龄:${member.age} 职业:${(member.career.name)!}) 
      </option>
      </#list>
      </select>       </td>
    </tr>
    <tr>
      <td width="20%" id="f_proposer" class="title">投保人:</td>
      <td width="80%">
      <input type="text" name="insurancePolicyResult.policy.proposer" value="${(insurancePolicyResult.policy.proposer)!}" maxlength="50" value="" style="width:50%;"/></td>
    </tr>  
    <tr>
      <td width="20%" id="f_proposer" class="title">受益人:</td>
      <td width="80%">
      <input type="text" name="insurancePolicyResult.policy.benefit" value="${(insurancePolicyResult.policy.benefit)!}" maxlength="50" value="" style="width:50%;"/></td>
    </tr>
    <tr>
      <td width="20%" id="f_applyOn" class="title"><font color="red">*</font>投保日期:</td>
     <td><input type="text" name="insurancePolicyResult.policy.applyOn" maxlength="10" value="${(insurancePolicyResult.policy.applyOn?string('yyyy-MM-dd'))?if_exists}" onfocus="calendar()"/></td>
    </tr>  
      <tr>
      <td width="20%" id="f_type" class="title"><font color="red">*</font>保险类型:</td>
      <td width="80%">
         <select name="d" onchange="getSubTypes(this.value)" style="width:100px">
         <option value="">...</option>
         <#list InsuranceTypes as insuranceType>
             <option value="${insuranceType.id}" <#if ((insurancePolicyResult.policy.type.parent.id)!(0))=insuranceType.id>selected</#if> >${insuranceType.name}</option>
         </#list>
         </select>
         <#--insuranceProduct.type.id-->
         <select name="insurancePolicyResult.policy.type.id" id="insuranceProductType" style="width:100px"></select>
      </td>
    </tr>  
    <tr>
      <td width="20%" id="f_coverage" class="title"><font color="red">*</font>保额:</td>
      <td width="80%">
      <input type="text" name="insurancePolicyResult.policy.coverage" value="${(insurancePolicyResult.policy.coverage)!}" maxlength="50" value="" style="width:50%;"/>元</td>
    </tr> 
    <tr>
      <td width="20%" id="f_expense" class="title"><font color="red">*</font>年保费:</td>
      <td><input type="text" name="insurancePolicyResult.policy.expense" value="${(insurancePolicyResult.policy.expense)!}" maxlength="30" value="" style="width:50%;"/>元</td>
     </tr>  
    <tr>
      <td width="20%" id="f_payTime" class="title"><font color="red">*</font>缴费年限:</td>
      <td width="80%">
  <@htm.i18nSelect datas=InsurancePayTimes selected="${(insurancePolicyResult.policy.payTime.id)!}"  
 name="insurancePolicyResult.policy.payTime.id" style="width:50%;"><option value="">请选择</option></@>
 	</td> 
  </tr> 
  <tr>
      <td width="20%" id="f_payType" class="title"><font color="red">*</font>缴费方式:</td>
      <td width="80%">
  <@htm.i18nSelect datas=InsurancePayTypes selected="${(insurancePolicyResult.policy.payType.id)!}"  
 name="insurancePolicyResult.policy.payType.id" style="width:50%;"><option value="">请选择</option></@>
 	</td> 
  </tr> 
  <tr>
      <td width="20%" id="f_time" class="title"><font color="red">*</font>保险期限:</td>
      <td width="80%">
  <@htm.i18nSelect datas=InsuranceTimes selected="${(insurancePolicyResult.policy.time.id)!}"  
 name="insurancePolicyResult.policy.time.id" style="width:50%;"><option value="">请选择</option></@>
	</td> 
  </tr>
  <tr>
      <td width="20%" id="f_additional" class="title"><font color="red">*</font>是否附加险:</td>
      
      <td width="80%"><@htm.radio2  name="insurancePolicyResult.policy.additional" value=(insurancePolicyResult.policy.additional)!(false)/></td>
 </tr>
    <tr>
      <td width="20%" id="f_master" class="title">主险:</td>
      <td width="80%">
      
  <@htm.i18nSelect datas=masters selected="${(insurancePolicyResult.master.id)!}"  
 name="insurancePolicyResult.master.id" style="width:50%;"><option value="">请选择</option></@>
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
         'insurancePolicyResult.policy.name':{'l':'保险名称', 'r':true, 't':'f_name'},
         'insurancePolicyResult.policy.company':{'l':'保险公司', 'r':true, 't':'f_company'},
         'insurancePolicyResult.policy.insurant':{'l':'被保险人物', 'r':true, 't':'f_insurant'},
         'insurancePolicyResult.policy.applyOn':{'l':'投保日期', 'r':true, 't':'f_applyOn'},
         'insurancePolicyResult.policy.type.id':{'l':'保险类型', 'r':true, 't':'f_type'},         
         'insurancePolicyResult.policy.coverage':{'l':'保额', 'r':true, 't':'f_coverage','f':'money'},
         'insurancePolicyResult.policy.expense':{'l':'年保费', 'r':true, 't':'f_expense','f':'money'},
         'insurancePolicyResult.policy.payTime.id':{'l':'缴费年限', 'r':true, 't':'f_payTime'},   
         'insurancePolicyResult.policy.payType.id':{'l':'缴费方式', 'r':true, 't':'f_payType'},   
         'insurancePolicyResult.policy.time.id':{'l':'保险期限', 'r':true, 't':'f_time'}
               
        
      };
	  var v = new validator(form , a_fields, null);
	  if (v.exec()) {
	  	if(form['insurancePolicyResult.policy.additional'][0].checked && form['insurancePolicyResult.master.id'].value==''){
	  		alert("该附加险应当填写主险");
	  		return;
	  	}
	    form.submit();
	  }
   }
   
   var defaultInsuranceTypeId="${(insurancePolicyResult.policy.type.id)?default(0)}";
   function getSubTypes(parentId){
       insuranceDwrService.getInsuranceTypes(parentId,function(data){
         setSubTypes(data,defaultInsuranceTypeId);
       });
   }
   
   function setSubTypes(data,insuranceTypeId){
       dwr.util.removeAllOptions('insuranceProductType');
       dwr.util.addOptions('insuranceProductType',data,'id','name');
       setSelectedSeq($('insuranceProductType'),insuranceTypeId);
   }
   <#if (insurancePolicyResult.policy.type.parent)??>
      getSubTypes(${insurancePolicyResult.policy.type.parent.id});
   </#if>
</script>
 </body> 
</html>