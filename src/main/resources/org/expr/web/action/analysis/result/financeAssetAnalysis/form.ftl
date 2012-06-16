<#include "/template/head.ftl"/>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckeditor.js"></script>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckTextArea.js"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Validator.js"></script>
 <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Calendar.js"></script>
<script language="JavaScript" type="text/JavaScript" src='${base}/dwr/interface/financeDwrService.js'></script>
<body>
<#assign labInfo><@text name="金融资产信息" /></#assign>
<#include "/template/back.ftl"/>
  <table width="90%" align="center" class="formTable">
    <form action="financeAssetAnalysis!save.action" name="financeInfoForm" method="post" onsubmit="return false;">
    <input name="financeAssetResult.id" type="hidden" value="${financeAssetResult.id!}"/>
    <input type="hidden" name="experiment.id" value="${Parameters['experiment.id']}"/>
    <input type="hidden" name="params" value="&experiment.id=${Parameters['experiment.id']}"/>
    <@searchParams/>
    <tr>
      <td width="20%" id="f_name" class="title"><font color="red">*</font>资产名称:</td>
      <td width="80%">
      <input type="text" name="financeAssetResult.asset.name" maxlength="50" value="${(financeAssetResult.asset.name)!}" style="width:100%;"/>
      </td>
    </tr>
    <tr>
      <td width="20%" id="f_type" class="title"><font color="red">*</font>资产类型:</td>
      <td width="80%">
         <select name="d" onchange="getSubTypes(this.value)" style="width:100px">
         <option value="">...</option>
         <#list FinanceTypes as financeType>
             <option value="${financeType.id}" <#if ((financeAssetResult.asset.financetype.parent.id)!(0))=financeType.id>selected</#if> >${financeType.name}</option>
         </#list>
         </select>
         <#--insuranceProduct.type.id-->
         <select name="financeAssetResult.asset.financetype.id" id="financeType" style="width:100px"></select>
      </td>
    </tr>   
    <tr>
      <td width="20%" id="f_riskgrade" class="title"><font color="red">*</font>风险等级:</td>
      <td width="80%">
 <@htm.i18nSelect datas=RiskGrades selected="${(financeAssetResult.asset.riskgrade.id)?if_exists}"  
 name="financeAssetResult.asset.riskgrade.id" style="width:50%;"><option value="">...</option></@></td>
    </tr> 
    <tr>
      <td width="20%" id="f_mobility" class="title"><font color="red">*</font>流动性:</td>
      <td width="80%">
 <@htm.i18nSelect datas=Mobilities selected="${(financeAssetResult.asset.mobility.id)?if_exists}"  
 name="financeAssetResult.asset.mobility.id" style="width:50%;"><option value="">...</option></@></td>
    </tr>
    <tr>
      <td width="20%" id="f_ratepayperiod" class="title"><font color="red">*</font>计息周期:</td>
      <td width="80%">
 <@htm.i18nSelect datas=RatePayPeriods selected="${(financeAssetResult.asset.ratepayperiod.id)?if_exists}"  
 name="financeAssetResult.asset.ratepayperiod.id" style="width:50%;"><option value="">...</option></@></td>
    </tr> 
    <tr>
      <td width="20%" id="f_rate" class="title"><font color="red">*</font>年收益率:</td>
      <td width="80%">
      <input type="text" name="financeAssetResult.asset.rate" maxlength="10" value="${(financeAssetResult.asset.rate)!}" style="width:10%;"/>%
    </tr>  
    <tr>
      <td width="20%" id="f_amount" class="title"><font color="red">*</font>投资金额:</td>
      <td width="80%">
      <input type="text" name="financeAssetResult.asset.amount" maxlength="10" value="${(financeAssetResult.asset.amount)!}" style="width:10%;"/>元
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
         document.financeInfoForm.reset();
     }
    function save(form){
         var a_fields = {
         'financeAssetResult.asset.name':{'l':'<@text name="attr.name" />', 'r':true, 't':'f_name'},
         'financeAssetResult.asset.financetype.id':{'l':'产品类型', 'r':true, 't':'f_type'},
         'financeAssetResult.asset.riskgrade.id':{'l':'风险等级', 'r':true, 't':'f_riskgrade'},
         'financeAssetResult.asset.mobility.id':{'l':'流动性', 'r':true, 't':'f_mobility'}, 
         'financeAssetResult.asset.ratepayperiod.id':{'l':'计息周期', 'r':true, 't':'f_ratepayperiod'},  
         'financeAssetResult.asset.rate':{'l':'年收益率', 'r':true, 't':'f_rate','f':'unsignedReal'},
         'financeAssetResult.asset.amount':{'l':'投资金额', 'r':true, 't':'f_amount'}
         };
		 var v = new validator(form , a_fields, null);
		 if (v.exec()) {
		    form.submit();
		 }
   }
   

   
   var defaultFinanceTypeId="${((financeAssetResult.asset.financetype)?if_exists).id?default(0)}";
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
   <#if ((financeAssetResult.asset.financetype)?if_exists).parent??>
      getSubTypes(${((financeAssetResult.asset.financetype)?if_exists).parent.id});
   </#if>
</script>
 </body> 
</html>