<#include "/template/head.ftl"/>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckeditor.js"></script>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckTextArea.js"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Validator.js"></script>
 <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Calendar.js"></script>
<script language="JavaScript" type="text/JavaScript" src='${base}/dwr/interface/insuranceDwrService.js'></script>
<body>
<#assign labInfo><@text name="保险产品信息" /></#assign>
<#include "/template/back.ftl"/>
  <table width="90%" align="center" class="formTable">
    <form action="insurance!save.action" name="insuranceProductForm" method="post" onsubmit="return false;">
    <@searchParams/>
    <tr>
      <td width="20%" id="f_seqNo" class="title"><font color="red">*</font>产品编号:</td>
      <td width="80%">
      <input id="insuranceProduct.seqNo" type="text" name="insuranceProduct.seqNo" value="${insuranceProduct.seqNo?if_exists}" maxLength="32" style="width:100%;">
      <input type="hidden"  name="insuranceProduct.id" value="${insuranceProduct.id!}"/>
      </td>
    </tr>
    <tr>
      <td width="20%" id="f_name" class="title"><font color="red">*</font>产品名称:</td>
      <td width="80%">
      <input type="text" name="insuranceProduct.name" maxlength="50" value="${insuranceProduct.name!}" style="width:100%;"/>
      </td>
    </tr>
     <tr>
      <td width="20%" id="f_corporation" class="title"><font color="red">*</font>发行公司:</td>
      <td width="80%">
      <input type="text" name="insuranceProduct.corporation" maxlength="50" value="${insuranceProduct.corporation!}" style="width:100%;"/>
       </td>
    </tr>
    <tr>
      <td width="20%" id="f_type" class="title"><font color="red">*</font>产品类型:</td>
      <td width="80%">
         <select name="d" onchange="getSubTypes(this.value)" style="width:100px">
         <option value="">...</option>
         <#list InsuranceTypes as insuranceType>
             <option value="${insuranceType.id}" <#if ((insuranceProduct.type.parent.id)!(0))=insuranceType.id>selected</#if> >${insuranceType.name}</option>
         </#list>
         </select>
         <#--insuranceProduct.type.id-->
         <select name="insuranceProduct.type.id" id="insuranceProductType" style="width:100px"></select>
      </td>
    </tr>   
     <tr>
      <td width="20%" id="f_corporation" class="title"><font color="red">*</font>是否附加险:</td>
      <td width="80%" >
      <input type="radio" name="insuranceProduct.additional" value="1" <#if insuranceProduct.additional!false>checked</#if> onclick="clearAddProducts(this.value);"/>是
      <input type="radio" name="insuranceProduct.additional" value="0" <#if !insuranceProduct.additional!false>checked</#if> onclick="clearAddProducts(this.value);" />否
      </td>
    </tr>
    <tr>
    <td width="20%" class="title" id="f_insurancePayType">缴费方式：</td>
    <td width="80%">
     <table>
      <tr>
       <td>
        <select name="InsurancePayTypes" MULTIPLE size="10" style="width:200px" onDblClick="JavaScript:moveSelectedOption(this.form['InsurancePayTypes'], this.form['SelectedInsurancePayType'])" >
         <#list insurancePayTypes?sort_by('id') as insurancePayType>
          <option value="${insurancePayType.id}">${insurancePayType.name}</option>
         </#list>
        </select>
       </td>
       <td  valign="middle">
        <br><br>
        <input OnClick="JavaScript:moveSelectedOption(this.form['InsurancePayTypes'], this.form['SelectedInsurancePayType'])" type="button" value="&gt;"> 
        <br><br>
        <input OnClick="JavaScript:moveSelectedOption(this.form['SelectedInsurancePayType'], this.form['InsurancePayTypes'])" type="button" value="&lt;"> 
        <br>
       </td> 
       <td  class="normalTextStyle">
        <select name="SelectedInsurancePayType" MULTIPLE size="10" style="width:200px;" onDblClick="JavaScript:moveSelectedOption(this.form['SelectedInsurancePayType'], this.form['InsurancePayTypes'])">
         <#list insuranceProduct.paytypes?if_exists as paytype>
          <option value="${paytype.id}">${paytype.name}</option>
         </#list>
        </select>
       </td>             
      </tr>
     </table>
    </td>
   </tr> 
   <tr>
    <td width="20%" class="title" id="f_insurancePayTime">缴费期限：</td>
    <td width="80%">
     <table>
      <tr>
       <td>
        <select name="InsurancePayTimes" MULTIPLE size="10" style="width:200px" onDblClick="JavaScript:moveSelectedOption(this.form['InsurancePayTimes'], this.form['SelectedInsurancePayTime'])" >
         <#list insurancePayTimes?sort_by('id') as insurancePayTime>
          <option value="${insurancePayTime.id}">${insurancePayTime.name}</option>
         </#list>
        </select>
       </td>
       <td  valign="middle">
        <br><br>
        <input OnClick="JavaScript:moveSelectedOption(this.form['InsurancePayTimes'], this.form['SelectedInsurancePayTime'])" type="button" value="&gt;"> 
        <br><br>
        <input OnClick="JavaScript:moveSelectedOption(this.form['SelectedInsurancePayTime'], this.form['InsurancePayTimes'])" type="button" value="&lt;"> 
        <br>
       </td> 
       <td  class="normalTextStyle">
        <select name="SelectedInsurancePayTime" MULTIPLE size="10" style="width:200px;" onDblClick="JavaScript:moveSelectedOption(this.form['SelectedInsurancePayTime'], this.form['InsurancePayTimes'])">
         <#list insuranceProduct.paytimes?if_exists as paytime>
          <option value="${paytime.id}">${paytime.name}</option>
         </#list>
        </select>
       </td>             
      </tr>
     </table>
    </td>
   </tr> 
  <tr>
    <td width="20%" class="title" id="f_insuranceTime">保险期限：</td>
    <td width="80%">
     <table>
      <tr>
       <td>
        <select name="InsuranceTimes" MULTIPLE size="10" style="width:200px" onDblClick="JavaScript:moveSelectedOption(this.form['InsuranceTimes'], this.form['SelectedInsuranceTime'])" >
         <#list insuranceTimes?sort_by('id') as insuranceTime>
          <option value="${insuranceTime.id}">${insuranceTime.name}</option>
         </#list>
        </select>
       </td>
       <td  valign="middle">
        <br><br>
        <input OnClick="JavaScript:moveSelectedOption(this.form['InsuranceTimes'], this.form['SelectedInsuranceTime'])" type="button" value="&gt;"> 
        <br><br>
        <input OnClick="JavaScript:moveSelectedOption(this.form['SelectedInsuranceTime'], this.form['InsuranceTimes'])" type="button" value="&lt;"> 
        <br>
       </td> 
       <td  class="normalTextStyle">
        <select name="SelectedInsuranceTime" MULTIPLE size="10" style="width:200px;" onDblClick="JavaScript:moveSelectedOption(this.form['SelectedInsuranceTime'], this.form['InsuranceTimes'])">
         <#list insuranceProduct.times?if_exists as time>
          <option value="${time.id}">${time.name}</option>
         </#list>
        </select>
       </td>             
      </tr>
     </table>
    </td>
   </tr>  
   <!--
    <tr>
      <td class="title">投保范围：</td>
      <td colspan="2"><textarea cols="50" id="scope" name="insuranceProduct.scope">${insuranceProduct.scope?if_exists}</textarea></td>
     </tr> 
  --> 
    <tr>
      <td class="title" id="f_detail"><font color="red">*</font>产品说明：</td>
       <td colspan="2" height="400"><textarea cols="50" id="detail" name="insuranceProduct.detail">${insuranceProduct.detail?if_exists}</textarea></td>
     </tr> 
     <tr>
      <td width="20%" id="f_rateregistry" class="title"><font color="red">*</font>费率决定因素:</td>
      <td width="80%">
 <@htm.i18nSelect datas=RateRegistries selected="${(insuranceProduct.registry.id)?if_exists}"  
 name="insuranceProduct.registry.id" style="width:50%;"><option value="">...</option></@></td>
      </tr>
      <tr>
       <td width="20%" id="f_careerprofile" class="title">职业等级方案:</td>
      <td width="80%">
 <@htm.i18nSelect datas=CareerProfiles selected="${(insuranceProduct.careerprofile.id)?if_exists}"  
 name="insuranceProduct.careerprofile.id" style="width:50%;"><option value="">...</option></@></td>
    </tr> 
    <tr id="addition_tr" <#if  insuranceProduct.additional!false>style="display:none"</#if>>
    <td width="20%" class="title" id="f_insurancePayTime">附加险种：</td>
    <td width="80%">
     <table>
      <tr>
       <td>
        <select name="AdditionalProducts" MULTIPLE size="10" style="width:200px" onDblClick="JavaScript:moveSelectedOption(this.form['AdditionalProducts'], this.form['SelectedAdditionalProducts'])" >
         <#list additionalProducts?if_exists as additionalProduct>
          <option value="${additionalProduct.id}">${additionalProduct.name}</option>
         </#list>
        </select>
       </td>
       <td  valign="middle">
        <br><br>
        <input OnClick="JavaScript:moveSelectedOption(this.form['AdditionalProducts'], this.form['SelectedAdditionalProducts'])" type="button" value="&gt;"> 
        <br><br>
        <input OnClick="JavaScript:moveSelectedOption(this.form['SelectedAdditionalProducts'], this.form['AdditionalProducts'])" type="button" value="&lt;"> 
        <br>
       </td>
       <td  class="normalTextStyle">
        <select name="SelectedAdditionalProducts" MULTIPLE size="10" style="width:200px;" onDblClick="JavaScript:moveSelectedOption(this.form['SelectedAdditionalProducts'], this.form['AdditionalProducts'])">
         <#list insuranceProduct.additionalProducts?if_exists?sort_by('id') as additionalProduct>
          <option value="${additionalProduct.id}">${additionalProduct.name}</option>
         </#list>
        </select>
       </td>             
      </tr>
     </table>
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
         document.insuranceProductForm.reset();
     }
    function save(form){
         var a_fields = {
         'insuranceProduct.seqNo':{'l':'<@text name="attr.code" />', 'r':true, 't':'f_seqNo'},
         'insuranceProduct.name':{'l':'<@text name="attr.name" />', 'r':true, 't':'f_name'},
         'insuranceProduct.corporation':{'l':'发行公司', 'r':true, 't':'f_corporation'},
         'insuranceProduct.type.id':{'l':'产品类型', 'r':true, 't':'f_type'},
         'insuranceProduct.detail':{'l':'产品说明', 'r':false, 't':'f_detail'},
         'insuranceProduct.registry.id':{'l':'费率决定因素', 'r':true, 't':'f_rateregistry'}
         };
		 var v = new validator(form , a_fields, null);
		 if (v.exec()) {
		    addInput(form,"selectedInsuranceTimeIds", getAllOptionValue(form.SelectedInsuranceTime));
		    addInput(form,"selectedInsurancePayTimeIds", getAllOptionValue(form.SelectedInsurancePayTime));
		    addInput(form,"selectedInsurancePayTypeIds", getAllOptionValue(form.SelectedInsurancePayType));
		    var addProductsIds= getAllOptionValue(form.SelectedAdditionalProducts);
		    addInput(form,"selectedAdditionalProductsIds",addProductsIds);
		    form.submit();
		 }
   }
   
   function clearAddProducts(value){
      if(value=='1'){
			document.getElementById("addition_tr").style.display="none";
			var options = document.insuranceProductForm['SelectedAdditionalProducts'].options;
			for (var i=options.length-1; i>=0; i--){   
				options[i].selected = true;
			}
			moveSelectedOption(document.insuranceProductForm['SelectedAdditionalProducts'],document.insuranceProductForm['AdditionalProducts']);
      }else{
         document.getElementById("addition_tr").style.display="";
      }
   }
   initFCK("detail","100%","100%");
   
   var defaultInsuranceTypeId="${((insuranceProduct.type)?if_exists).id?default(0)}";
   function getSubTypes(parentId){
       insuranceDwrService.getInsuranceTypes(parentId,function(data){
         setSubTypes(data,defaultInsuranceTypeId);
       });
   }
   
   function setSubTypes(data,insuranceTypeId){
       dwr.util.removeAllOptions('insuranceProductType');
       dwr.util.addOptions('insuranceProductType',data,'id','name');
       setSelectedSeq($('insuranceProductType'),defaultInsuranceTypeId);
   }
   <#if  ((insuranceProduct.type)?if_exists).parent??> 
      getSubTypes(${((insuranceProduct.type)?if_exists).parent.id});
   </#if>
</script>
 </body> 
</html>