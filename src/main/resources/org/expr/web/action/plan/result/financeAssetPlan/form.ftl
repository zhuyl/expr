<#include "/template/head.ftl"/>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckeditor.js"></script>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckTextArea.js"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Validator.js"></script>
 <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Calendar.js"></script>
<script language="JavaScript" type="text/JavaScript" src='${base}/dwr/interface/financeDwrService.js'></script>
<body>
<#assign labInfo><@text name="金融投资信息" /></#assign>
<#include "/template/back.ftl"/>
  <table width="90%" align="center" class="formTable">
    <form action="financeAssetPlan!save.action" name="financeInfoForm" method="post" onsubmit="return false;">
    <input name="financePlanResult.id" type="hidden" value="${financePlanResult.id!}"/>
    <input type="hidden" name="experiment.id" value="${Parameters['experiment.id']}"/>
    <input type="hidden" name="params" value="&experiment.id=${Parameters['experiment.id']}"/>
    <@searchParams/>
     <tr>
      <td width="20%" id="f_type" class="title"><font color="red">*</font>资产类型:</td>
      <td width="80%">
         <select name="d" onchange="getSubTypes(this.value)" style="width:100px">
         <option value="">...</option>
         <#list FinanceTypes as financeType>
             <option value="${financeType.id}" <#if ((financePlanResult.financetype.parent.id)!(0))=financeType.id>selected</#if> >${financeType.name}</option>
         </#list>
         </select>
         <#--insuranceProduct.type.id-->
         <select name="financePlanResult.financetype.id" id="financeType" style="width:100px"></select>
      </td>
    </tr>   
    <tr>
      <td width="20%" id="f_riskgrade" class="title"><font color="red">*</font>风险等级:</td>
      <td width="80%">
 <@htm.i18nSelect datas=RiskGrades selected="${(financePlanResult.riskgrade.id)?if_exists}"  
 name="financePlanResult.riskgrade.id" style="width:50%;"><option value="">...</option></@></td>
    </tr> 
    <tr>
      <td width="20%" id="f_mobility" class="title"><font color="red">*</font>流动性:</td>
      <td width="80%">
 <@htm.i18nSelect datas=Mobilities selected="${(financePlanResult.mobility.id)?if_exists}"  
 name="financePlanResult.mobility.id" style="width:50%;"><option value="">...</option></@></td>
    </tr>
    <tr>
      <td width="20%" id="f_ratepayperiod" class="title"><font color="red">*</font>计息周期:</td>
      <td width="80%">
 <@htm.i18nSelect datas=RatePayPeriods selected="${(financePlanResult.ratepayperiod.id)?if_exists}"  
 name="financePlanResult.ratepayperiod.id" style="width:50%;"><option value="">...</option></@></td>
    </tr> 
    <tr>
      <td width="20%" id="f_rate" class="title"><font color="red">*</font>预计年收益率:</td>
      <td width="80%">
      <input type="text" name="financePlanResult.rate" maxlength="10" value="${(financePlanResult.rate)!}" style="width:10%;"/>%
    </tr>  
    <tr>
      <td width="20%" id="f_amount" class="title"><font color="red">*</font>投资金额:</td>
      <td width="80%">
      <input type="text" name="financePlanResult.amount" maxlength="10" value="${(financePlanResult.amount)!}" style="width:10%;"/>元
    </tr>  
    <tr>
      <td width="20%" id="f_amount" class="title"><font color="red">*</font>追加投资占比:</td>
      <td width="80%">
      <input type="text" name="financePlanResult.append" maxlength="10" value="${(financePlanResult.append)!}" style="width:10%;"/>%
    </tr>  
    <tr><td class="title" id="f_startyear"><font color="red">*</font>起止年份</td><td>
		  <select id="startYear" name="financePlanResult.startYear" style="width:150px">
         <option value="">请选择开始年份</option>
         <#list 1..planYears as i>
             <option value="${i}">${i}</option>
         </#list>
         </select>
         -
 		  <select id="endYear" name="financePlanResult.endYear" style="width:150px">
         <option value="">请选择结束年份</option>
         <#list 1..planYears as i>
             <option value="${i}">${i}</option>
         </#list>
         </select>    
         <script>
         	document.financeInfoForm["financePlanResult.startYear"].value='${(financePlanResult.startYear)!}';
         	document.financeInfoForm["financePlanResult.endYear"].value='${(financePlanResult.endYear)!}';
         </script>    
		</td>
	</tr>
	    <tr>
      <td width="20%" id="f_finances" class="title">建议产品:</td>
      <td width="80%">
<textarea id="financePlanResult.finances" name="financePlanResult.finances"  style="font-size:10pt;width:100%;height:80px">${(financePlanResult.finances)!}</textarea> 
     <input type="button" name="chooseInsurance" value="选择" class="buttonStyle" onClick="doSelectFinance(this.form)"/>

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
  form=document.financeInfoForm;
    function setFinanceInfo(data) {
      if(null != data) {
        document.getElementById("financetype").innerHTML=data["financetype"]["parent"]["name"]+"  "+data["financetype"]["name"];
        document.getElementById("riskgrade").innerHTML=data["riskgrade"]["name"];
        document.getElementById("mobility").innerHTML=data["mobility"]["name"];
        document.getElementById("ratepayperiod").innerHTML=data["ratepayperiod"]["name"];
        document.getElementById("rate").innerHTML=data["rate"];
      }  
    }
    
    function doSetProduct(productid,productname){
        document.financeInfoForm['financePlanResult.finance.name'].value=productname;
        document.financeInfoForm['financePlanResult.finance.id'].value=productid;
        financeDwrService.getFinance(productid,setFinanceInfo);
        
    }
    function doSetFinance(productid,productname){
        document.financeInfoForm['financePlanResult.finances'].value=document.financeInfoForm['financePlanResult.finances'].value+"|"+productname;
        
    }
    
    function doSelectFinance(form){
	    url='../finance.action?method=financeQuery';
	    window.open(url, '金融产品信息', 'scrollbars=yes,width=950,height=600,status=yes,titlebar=no');
	}
    function doClearFinance(form){
       	document.financeInfoForm['financePlanResult.finance.name'].value='';
        document.financeInfoForm['financePlanResult.finance.id'].value=''; 
    }
  
    function reset(){
        document.financeInfoForm.reset();
    }
    function save(form){
         var a_fields = {

         
         'financePlanResult.financetype.id':{'l':'产品类型', 'r':true, 't':'f_type'},
         'financePlanResult.riskgrade.id':{'l':'风险等级', 'r':true, 't':'f_riskgrade'},
         'financePlanResult.mobility.id':{'l':'流动性', 'r':true, 't':'f_mobility'}, 
         'financePlanResult.ratepayperiod.id':{'l':'计息周期', 'r':true, 't':'f_ratepayperiod'},  
         'financePlanResult.rate':{'l':'预计年收益率', 'r':true, 't':'f_rate','f':'unsignedReal'},
         'financePlanResult.amount':{'l':'投资金额', 'r':true, 't':'f_amount','f':'unsignedReal'},       
         'financePlanResult.append':{'l':'追加投资占比', 'r':true, 't':'f_amount','f':'unsignedReal'},
         'financePlanResult.startYear':{'l':'起始年份', 'r':true, 't':'f_startyear','f':'unsignedReal'},
         'financePlanResult.endYear':{'l':'结束年份', 'r':true, 't':'f_startyear','f':'unsignedReal'}        
         };
		 var v = new validator(form , a_fields, null);
		 if (v.exec()) {
		 	if(parseInt(document.getElementById('startYear').value)>parseInt(document.getElementById('endYear').value))
		 	{
		 		alert("开始年份必须大于等于结束年份！");return;		 		
		 	}
		    form.submit();
		 }
   }
   

   
   var defaultFinanceTypeId="${((financePlanResult.financetype)?if_exists).id?default(0)}";
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
   <#if ((financePlanResult.financetype)?if_exists).parent??>
      getSubTypes(${((financePlanResult.financetype)?if_exists).parent.id});
   </#if>
   

</script>
 </body> 
</html>