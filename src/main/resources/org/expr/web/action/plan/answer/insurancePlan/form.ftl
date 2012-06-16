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
     <input name="policyAnswer.id" type="hidden" value="${(policyAnswer.id)!}"/>
     <input name="caze.id" type="hidden" value="${Parameters['caze.id']}"/>
     <tr>
      <td class="title" id="f_porduct"><font color="red">*</font>选择产品:</td>
      <td>
      <input type="text" name="product.name" id="dcy" value="${(policyAnswer.product.name)!}" readonly> 
      <input type="button" name="chooseInsurance" value="选择" class="buttonStyle" onClick="doSelectInsurance(this.form)"/>
	  <input type="button" value="清空" class="buttonStyle" onClick="doClearInsurance(this.form)"/>				<div id="sb"></div>     
      <input type="hidden" name="product.id"  value="${(policyAnswer.product.id)!}"/>      
      </td> 
     </tr>

  <!--
  
     <tr>
      <td width="20%" id="f_applyOn" class="title"><font color="red">*</font>投保日期:</td>
      <td width="80%">
      <input type="text" name="policyAnswer.policy.applyOn"  
      class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" maxlength="10"
       value="${(policyAnswer.policy.applyOn?string("yyyy-MM-dd"))!}" style="width:50%;"/>
      </td>
     </tr>-->
     <tr>
      <td width="20%" id="f_applyOn" class="title"><font color="red">*</font>投保年份：</td>
      <td width="80%">
      <select id="policyAnswer.applyOn" name="policyAnswer.applyOn"  onchange="calcRate()" style="width:150px">
         <option value="">请选择</option>
         <#list 1..planYears as i>
         
             <option value="${i}" <#if i=(policyAnswer.applyOn)!0>selected</#if>>${i}</option>
         </#list>
         </select>
      </td>
     </tr>
    <tr>
      <td width="20%" id="f_name" class="title"><font color="red">*</font>被保险人姓名:</td>
      <td width="80%">
      <select  name="policyAnswer.insurant"  style="width:250px;"  onchange="calcRate()">
      <#list members as member>
      <option value="${member.name}" <#if member.name=(policyAnswer.insurant)!>selected</#if>>
      ${member.name}(年龄:${member.age} 职业:${(member.career.name)!}) 
      </option>
      </#list>
      </select>
      </td>
    </tr>
    <tr>
      <td width="20%" id="f_proposername" class="title"><font color="red">*</font>投保人姓名:</td>
      <td width="80%">
      <input type="text" name="policyAnswer.proposer" maxlength="50" value="${(policyAnswer.proposer)!}" style="width:50%;"/>
      </td>
    </tr>
    <tr>
      <td width="20%" id="f_benefitname" class="title"><font color="red">*</font>受益人姓名:</td>
      <td width="80%">
      <input type="text" name="policyAnswer.benefit" maxlength="50" value="${(policyAnswer.benefit)!}" style="width:50%;"/>
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
      <@htm.i18nSelect datas=payTimes id="insuranceProductPayTime" selected="${(policyAnswer.payTime.id)!(0)}"  name="policyAnswer.payTime.id" style="width:50%;"  onchange="calcRate()">
      <option value="">请选择</option>
      </@>
      </td>
    </tr> 
    <tr>
      <td width="20%" id="f_paytype" class="title"><font color="red">*</font>缴费方式:</td>
      <td width="80%">
      <@htm.i18nSelect datas=payTypes id="insuranceProductPayType" selected="${(policyAnswer.payType.id)!(0)}"  name="policyAnswer.payType.id" style="width:50%;"  onchange="calcRate()">
      <option value="">请选择</option>
      </@>
      </td>
    </tr>  
    <tr>
      <td width="20%" id="f_time" class="title"><font color="red">*</font>保险期限:</td>
      <td width="80%">
      <@htm.i18nSelect datas=times id="insuranceProductTime" selected="${(policyAnswer.time.id)!(0)}"  name="policyAnswer.time.id" style="width:50%;"  onchange="calcRate()">
      <option value="">请选择</option>
      </@>
      </td>
     </tr>  
     <tr>
      <td width="20%" id="f_value" class="title"><font color="red">*</font>保额:</td>
      <td width="80%">
        <input type="text" name="policyAnswer.coverage" maxlength="50"
         value="${(policyAnswer.coverage)!}" style="width:50%;" onchange="calcRate()"/>元
      </td>
    </tr>
    <tr>
      <td width="20%" id="f_fee" class="title"><font color="red">*</font>保费:</td>
      <td width="80%">
        <input type="text" readonly name="policyAnswer.expense" maxlength="50" value="${(policyAnswer.expense)!}" style="width:50%;"/>元
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
  	cazeId=${Parameters['caze.id']};
  	productId=form['product.id'].value;
  	paytimeId=form['policyAnswer.payTime.id'].value;
  	paytypeId=form['policyAnswer.payType.id'].value;
  	timeId=form['policyAnswer.time.id'].value;
  	name=form['policyAnswer.insurant'].value;
  	coverage=form['policyAnswer.coverage'].value;
  	age=form['policyAnswer.applyOn'].value;
  	if(""==productId||""==paytimeId||""==paytypeId||""==timeId||""==name||""==coverage){
  		return;
  	}else{
  		insuranceRateDwrService.calc(cazeId,productId,paytimeId,paytypeId,timeId,name,coverage,age,setRate);
  	}
  }
  function setRate(data){
    if(null==data){
    	alert("所选产品没有该缴费方式组合的保费计算公式，无法计算保费？");
  		form['policyAnswer.expense'].value="";
  	}else{
  		form['policyAnswer.expense'].value=data;
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
		document.policyForm['policyAnswer.expense'].value=""
	}
	
    function save(form){
         var a_fields = {
             'product.name':{'l':'保险产品名称','r':true,'t':'f_porduct'},
             'policyAnswer.applyOn':{'l':'投保年份','r':true,'t':'f_applyOn'},
             'policyAnswer.proposer':{'l':'投保人姓名','r':true,'t':'f_proposername'},
             'policyAnswer.benefit':{'l':'受益人姓名','r':true,'t':'f_benefitname'},
             'policyAnswer.payTime.id':{'l':'缴费期限','r':true,'t':'f_paytime'},
             'policyAnswer.coverage':{'l':'保额','r':true,'t':'f_value','f':'unsignedReal'},
             'policyAnswer.payType.id':{'l':'缴费方式','r':true,'t':'f_paytype'},
             'policyAnswer.time.id':{'l':'保险期限','r':true,'t':'f_time'},
             'policyAnswer.expense':{'l':'保费','r':true,'t':'f_fee'}
         };
		 var v = new validator(form , a_fields, null);
		 if (v.exec()) {
            form.action="${base}/answer/insurancePlan!save.action";
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