<#include "/template/head.ftl"/>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckeditor.js"></script>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckTextArea.js"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Validator.js"></script>
 <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Calendar.js"></script>
<script language="JavaScript" type="text/JavaScript" src='${base}/dwr/interface/financeDwrService.js'></script>
<body>
<#assign labInfo><@text name="金融产品信息" /></#assign>
<#include "/template/back.ftl"/>
  <table width="90%" align="center" class="formTable">
    <form action="finance!save.action" name="financeProductForm" method="post" onsubmit="return false;">
    <@searchParams/>
    <tr>
      <td width="20%" id="f_name" class="title"><font color="red">*</font>产品名称:</td>
      <td width="80%">
      <input type="text" name="finance.name" maxlength="50" value="${finance.name!}" style="width:100%;"/>
      <input type="hidden"  name="finance.id" value="${finance.id!}"/>
      </td>
    </tr>
    <tr>
      <td width="20%" id="f_type" class="title"><font color="red">*</font>产品类型:</td>
      <td width="80%">
         <select name="d" onchange="getSubTypes(this.value)" style="width:100px">
         <option value="">...</option>
         <#list FinanceTypes as financeType>
             <option value="${financeType.id}" <#if ((finance.financetype.parent.id)!(0))=financeType.id>selected</#if> >${financeType.name}</option>
         </#list>
         </select>
         <#--insuranceProduct.type.id-->
         <select name="finance.financetype.id" id="financeType" style="width:100px"></select>
      </td>
    </tr>   
    <tr>
      <td width="20%" id="f_riskgrade" class="title"><font color="red">*</font>风险等级:</td>
      <td width="80%">
 <@htm.i18nSelect datas=RiskGrades selected="${(finance.riskgrade.id)?if_exists}"  
 name="finance.riskgrade.id" style="width:50%;"><option value="">...</option></@></td>
    </tr> 
    <tr>
      <td width="20%" id="f_mobility" class="title"><font color="red">*</font>流动性:</td>
      <td width="80%">
 <@htm.i18nSelect datas=Mobilities selected="${(finance.mobility.id)?if_exists}"  
 name="finance.mobility.id" style="width:50%;"><option value="">...</option></@></td>
    </tr>
    <tr>
      <td width="20%" id="f_ratepayperiod" class="title"><font color="red">*</font>计息周期:</td>
      <td width="80%">
 <@htm.i18nSelect datas=RatePayPeriods selected="${(finance.ratepayperiod.id)?if_exists}"  
 name="finance.ratepayperiod.id" style="width:50%;"><option value="">...</option></@></td>
    </tr> 
    <tr>
      <td width="20%" id="f_rate" class="title"><font color="red">*</font>利息:</td>
      <td width="80%">
      <input type="text" name="finance.rate" maxlength="10" value="${finance.rate!}" style="width:10%;"/>%
    </tr>  
    <tr>
      <td class="title" id="f_detail">产品说明：</td>
       <td colspan="2" height="400"><textarea cols="50" id="detail" name="finance.detail">${finance.detail?if_exists}</textarea></td>
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
         document.financeProductForm.reset();
     }
    function save(form){
         var a_fields = {
         'finance.name':{'l':'<@text name="attr.name" />', 'r':true, 't':'f_name'},
         'finance.financetype.id':{'l':'产品类型', 'r':true, 't':'f_type'},
         'finance.detail':{'l':'产品说明', 'r':false, 't':'f_detail'},
         'finance.riskgrade.id':{'l':'风险等级', 'r':true, 't':'f_riskgrade'},
         'finance.mobility.id':{'l':'流动性', 'r':true, 't':'f_mobility'}, 
         'finance.ratepayperiod.id':{'l':'计息周期', 'r':true, 't':'f_ratepayperiod'},  
         'finance.rate':{'l':'利息', 'r':true, 't':'f_rate'}                       
         };
		 var v = new validator(form , a_fields, null);
		 if (v.exec()) {
		    form.submit();
		 }
   }
   

   initFCK("detail","100%","100%");
   
   var defaultFinanceTypeId="${((finance.financetype)?if_exists).id?default(0)}";
   function getSubTypes(parentId){
       financeDwrService.getFinanceTypes(parentId,function(data){
         setSubTypes(data,defaultFinanceTypeId);
       });
   }
   
   function setSubTypes(data,financeTypeId){
       dwr.util.removeAllOptions('financeType');
       dwr.util.addOptions('financeType',data,'id','name');
       setSelectedSeq($('financeType'),financeTypeId);
   }
   <#if ((finance.financetype)?if_exists).parent??>
      getSubTypes(${((finance.financetype)?if_exists).parent.id});
   </#if>
</script>
 </body> 
</html>