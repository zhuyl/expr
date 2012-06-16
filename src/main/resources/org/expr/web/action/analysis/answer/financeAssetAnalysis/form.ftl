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
    <input name="financeAssetAnswer.id" type="hidden" value="${financeAssetAnswer.id!}"/>
    <input type="hidden" name="caze.id" value="${Parameters['caze.id']}"/>
    <input type="hidden" name="params" value="&caze.id=${Parameters['caze.id']}"/>
    <@searchParams/>
    <tr>
      <td width="20%" id="f_name" class="title"><font color="red">*</font>资产名称:</td>
      <td width="80%">
      <input type="text" name="financeAssetAnswer.asset.name" maxlength="50" value="${(financeAssetAnswer.asset.name)!}" style="width:100%;"/>
      </td>
    </tr>
    <tr>
      <td width="20%" id="f_type" class="title"><font color="red">*</font>资产类型:</td>
      <td width="80%">
         <select name="d" onchange="getSubTypes(this.value)" style="width:100px">
         <option value="">...</option>
         <#list FinanceTypes as financeType>
             <option value="${financeType.id}" <#if ((financeAssetAnswer.asset.financetype.parent.id)!(0))=financeType.id>selected</#if> >${financeType.name}</option>
         </#list>
         </select>
         <#--insuranceProduct.type.id-->
         <select name="financeAssetAnswer.asset.financetype.id" id="financeType" style="width:100px"></select>
      </td>
    </tr>   
    <tr>
      <td width="20%" id="f_riskgrade" class="title"><font color="red">*</font>风险等级:</td>
      <td width="80%">
 <@htm.i18nSelect datas=RiskGrades selected="${(financeAssetAnswer.asset.riskgrade.id)?if_exists}"  
 name="financeAssetAnswer.asset.riskgrade.id" style="width:50%;"><option value="">...</option></@></td>
    </tr> 
    <tr>
      <td width="20%" id="f_mobility" class="title"><font color="red">*</font>流动性:</td>
      <td width="80%">
 <@htm.i18nSelect datas=Mobilities selected="${(financeAssetAnswer.asset.mobility.id)?if_exists}"  
 name="financeAssetAnswer.asset.mobility.id" style="width:50%;"><option value="">...</option></@></td>
    </tr>
    <tr>
      <td width="20%" id="f_ratepayperiod" class="title"><font color="red">*</font>计息周期:</td>
      <td width="80%">
 <@htm.i18nSelect datas=RatePayPeriods selected="${(financeAssetAnswer.asset.ratepayperiod.id)?if_exists}"  
 name="financeAssetAnswer.asset.ratepayperiod.id" style="width:50%;"><option value="">...</option></@></td>
    </tr> 
    <tr>
      <td width="20%" id="f_rate" class="title"><font color="red">*</font>年收益率:</td>
      <td width="80%">
      <input type="text" name="financeAssetAnswer.asset.rate" maxlength="10" value="${(financeAssetAnswer.asset.rate)!}" style="width:10%;"/>%
    </tr>  
    <tr>
      <td width="20%" id="f_amount" class="title"><font color="red">*</font>投资金额:</td>
      <td width="80%">
      <input type="text" name="financeAssetAnswer.asset.amount" maxlength="10" value="${(financeAssetAnswer.asset.amount)!}" style="width:10%;"/>元
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
         'financeAssetAnswer.asset.name':{'l':'<@text name="attr.name" />', 'r':true, 't':'f_name'},
         'financeAssetAnswer.asset.financetype.id':{'l':'产品类型', 'r':true, 't':'f_type'},
         'financeAssetAnswer.asset.riskgrade.id':{'l':'风险等级', 'r':true, 't':'f_riskgrade'},
         'financeAssetAnswer.asset.mobility.id':{'l':'流动性', 'r':true, 't':'f_mobility'}, 
         'financeAssetAnswer.asset.ratepayperiod.id':{'l':'计息周期', 'r':true, 't':'f_ratepayperiod'},  
         'financeAssetAnswer.asset.rate':{'l':'年收益率', 'r':true, 't':'f_rate','f':'unsignedReal'},
         'financeAssetAnswer.asset.amount':{'l':'投资金额', 'r':true, 't':'f_amount'}
         };
		 var v = new validator(form , a_fields, null);
		 if (v.exec()) {
		    form.submit();
		 }
   }
   

   
   var defaultFinanceTypeId="${((financeAssetAnswer.asset.financetype)?if_exists).id?default(0)}";
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
   <#if ((financeAssetAnswer.asset.financetype)?if_exists).parent??>
      getSubTypes(${((financeAssetAnswer.asset.financetype)?if_exists).parent.id});
   </#if>
</script>
 </body> 
</html>