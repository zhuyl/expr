<#include "/template/head.ftl"/>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckeditor.js"></script>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckTextArea.js"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Validator.js"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Calendar.js"></script>
<script language="JavaScript" type="text/JavaScript" src='${base}/dwr/interface/insuranceDwrService.js'></script>
<body>
<table id="taskBar"></table>
<script>
  var bar = new ToolBar('taskBar', '保单信息', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
  bar.addBack();
  
</script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/My97DatePicker/WdatePicker.js"></script>

<#assign labInfo>保单信息</#assign>
  <table width="90%" align="center" class="formTable">
    <form  name="policyForm" method="post" onsubmit="return false;">
     <input name="policyResult.id" type="hidden" value="${(policyResult.id)!}"/>
     <input name="experiment.id" type="hidden" value="${Parameters['experiment.id']}"/>
     <input type="hidden" name="student.code" value="${studentCode}"/>
     <tr>
      <td class="title" id="f_porduct"><font color="red">*</font>选择产品:</td>
      <td>
      <input type="text" name="product.name" id="dcy" value="${(policyResult.product.name)!}" readonly> 
      <input type="button" name="chooseInsurance" value="选择" class="buttonStyle" onClick="doSelectInsurance(this.form)"/>
	  <input type="button" value="清空" class="buttonStyle" onClick="doClearInsurance(this.form)"/>				<div id="sb"></div>     
      <input type="hidden" name="product.id"  value="${(policyResult.product.id)!}"/>      
      </td> 
     </tr>

  <!--
  
     <tr>
      <td width="20%" id="f_applyOn" class="title"><font color="red">*</font>投保日期:</td>
      <td width="80%">
      <input type="text" name="policyResult.policy.applyOn"  
      class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" maxlength="10"
       value="${(policyResult.policy.applyOn?string("yyyy-MM-dd"))!}" style="width:50%;"/>
      </td>
     </tr>-->
     <tr>
      <td width="20%" id="f_applyOn" class="title"><font color="red">*</font>投保年份：</td>
      <td width="80%">
      <select id="policyResult.applyOn" name="policyResult.applyOn"  onchange="calcRate()" style="width:150px">
         <option value="">请选择</option>
         <#list 1..planYears as i>
         
             <option value="${i}" <#if i=(policyResult.applyOn)!0>selected</#if>>${i}</option>
         </#list>
         </select>
      </td>
     </tr>
    <tr>
      <td width="20%" id="f_name" class="title"><font color="red">*</font>被保险人姓名:</td>
      <td width="80%">
      <select  name="policyResult.insurant"  style="width:250px;"  onchange="calcRate()">
      <#list members as member>
      <option value="${member.name}" <#if member.name=(policyResult.insurant)!>selected</#if>>
      ${member.name}(年龄:${member.age} 职业:${(member.career.name)!}) 
      </option>
      </#list>
      </select>
      </td>
    </tr>
    <tr>
      <td width="20%" id="f_proposername" class="title"><font color="red">*</font>投保人姓名:</td>
      <td width="80%">
      <input type="text" name="policyResult.proposer" maxlength="50" value="${(policyResult.proposer)!}" style="width:50%;"/>
      </td>
    </tr>
    <tr>
      <td width="20%" id="f_benefitname" class="title"><font color="red">*</font>受益人姓名:</td>
      <td width="80%">
      <input type="text" name="policyResult.benefit" maxlength="50" value="${(policyResult.benefit)!}" style="width:50%;"/>
      </td>
    </tr>
<#--    <tr>
      <td width="20%" id="f_age" class="title"><font color="red">*</font>年龄:</td>
      <td width="80%">
      <input type="text" name="age" maxlength="50" value="" style="width:50%;"/>周岁
       </td>
    </tr>
    <tr>
      <td width="20%" id="f_gender" class="title"><font color="red">*</font>性别:</td>
      <td width="80%">
 <@htm.i18nSelect datas=Genders selected=""  name="policy.gender.id" style="width:50%;"><option value="">请选择</option></@></td>
    </tr>  
    -->
    <tr>
      <td width="20%" id="f_paytime" class="title"><font color="red">*</font>缴费期限:</td>
      <td width="80%">
      <@htm.i18nSelect datas=payTimes id="insuranceProductPayTime" selected="${(policyResult.payTime.id)!(0)}"  name="policyResult.payTime.id" style="width:50%;"  onchange="calcRate()">
      <option value="">请选择</option>
      </@>
      </td>
    </tr> 
    <tr>
      <td width="20%" id="f_paytype" class="title"><font color="red">*</font>缴费方式:</td>
      <td width="80%">
      <@htm.i18nSelect datas=payTypes id="insuranceProductPayType" selected="${(policyResult.payType.id)!(0)}"  name="policyResult.payType.id" style="width:50%;"  onchange="calcRate()">
      <option value="">请选择</option>
      </@>
      </td>
    </tr>  
    <tr>
      <td width="20%" id="f_time" class="title"><font color="red">*</font>保险期限:</td>
      <td width="80%">
      <@htm.i18nSelect datas=times id="insuranceProductTime" selected="${(policyResult.time.id)!(0)}"  name="policyResult.time.id" style="width:50%;"  onchange="calcRate()">
      <option value="">请选择</option>
      </@>
      </td>
     </tr>  
     <tr>
      <td width="20%" id="f_value" class="title"><font color="red">*</font>保额:</td>
      <td width="80%">
        <input type="text" name="policyResult.coverage" maxlength="50"
         value="${(policyResult.coverage)!}" style="width:50%;" onchange="calcRate()"/>元
      </td>
    </tr>
    <tr>
      <td width="20%" id="f_fee" class="title"><font color="red">*</font>保费:</td>
      <td width="80%">
        <input type="text" readonly name="policyResult.expense" maxlength="50" value="${(policyResult.expense)!}" style="width:50%;"/>元
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
  <script language="JavaScript" type="text/JavaScript" src='${base}/dwr/interface/insuranceRateDwrService.js'></script>
  <script language="javascript" > 
  form=document.policyForm;
  
  function calcRate(){
  	experimentId=${Parameters['experiment.id']};
  	productId=form['product.id'].value;
  	paytimeId=form['policyResult.payTime.id'].value;
  	paytypeId=form['policyResult.payType.id'].value;
  	timeId=form['policyResult.time.id'].value;
  	name=form['policyResult.insurant'].value;
  	coverage=form['policyResult.coverage'].value;
  	age=form['policyResult.applyOn'].value;
  	code=form['student.code'].value
  	if(""==productId||""==paytimeId||""==paytypeId||""==timeId||""==name||""==coverage||""==age){
  		return;
  	}else{
  		insuranceRateDwrService.Expcalc(code,experimentId,productId,paytimeId,paytypeId,timeId,name,coverage,age,setRate);
  	}
  }
  function setRate(data){
    if(null==data){
    	alert("所选产品没有该缴费方式组合的保费计算公式，无法计算保费？");
  		form['policyResult.expense'].value="";
  	}else{
  		form['policyResult.expense'].value=data;
  	}
  }
  
	function doSetProduct(productid,productname){
		document.policyForm['product.name'].value=productname;
		document.policyForm['product.id'].value=productid;
		setDetails(productid);
	}

	function doSelectProduct(form){
	   url='insurance.do?method=insuranceQuery';
	   window.open(url, '保险产品信息', 'scrollbars=yes,width=750,height=650,status=yes,titlebar=no');
	}
	function doClearProduct(form){
       	document.policyForm['product.name'].value='';
        document.policyForm['product.id'].value='';   
	}
	
	function setDetails(productId){
		if (productId!=null){
			insuranceDwrService.getInsuranctPayTypes(productId,function(data){setSelect('insuranceProductPayType',data)});
			insuranceDwrService.getInsuranctPayTimes(productId,function(data){setSelect('insuranceProductPayTime',data)});
			insuranceDwrService.getInsuranctTimes(productId,function(data){setSelect('insuranceProductTime',data)});
		}
	}
	function setSelect(select,data){
		dwr.util.removeAllOptions(select);
		dwr.util.addOptions(select,[{"id":'',"name":'请选择...'}],'id','name')
		dwr.util.addOptions(select,data,'id','name');
		document.policyForm['policyResult.expense'].value=""
	}
	
    function save(form){
         var a_fields = {
             'product.name':{'l':'保险产品名称','r':true,'t':'f_porduct'},
             'policyResult.applyOn':{'l':'投保年份','r':true,'t':'f_applyOn'},
             'policyResult.proposer':{'l':'投保人姓名','r':true,'t':'f_proposername'},
             'policyResult.benefit':{'l':'受益人姓名','r':true,'t':'f_benefitname'},
             'policyResult.payTime.id':{'l':'缴费期限','r':true,'t':'f_paytime'},
             'policyResult.coverage':{'l':'保额','r':true,'t':'f_value','f':'unsignedReal'},
             'policyResult.payType.id':{'l':'缴费方式','r':true,'t':'f_paytype'},
             'policyResult.time.id':{'l':'保险期限','r':true,'t':'f_time'},
             'policyResult.expense':{'l':'保费','r':true,'t':'f_fee'}
         };
		 var v = new validator(form , a_fields, null);
		 if (v.exec()) {
            form.action="${base}/result/insurancePlan!save.action";
		 	form.submit();
		 }
   }
   
   function doSetProduct(productid,productname)
		{
         document.policyForm['product.name'].value=productname;
         document.policyForm['product.id'].value=productid;
        }
        
      function doSelectInsurance(form){
	   url='../insurance.action?method=insuranceQuery';
	   window.open(url, '保险产品信息', 'scrollbars=yes,width=750,height=650,status=yes,titlebar=no');
	}
    function doClearInsurance(form){
       	document.policyForm['product.name'].value='';
        document.policyForm['product.id'].value=''; 
    }
</script>
 </body> 
</html>