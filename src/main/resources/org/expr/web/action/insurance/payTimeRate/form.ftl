<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Validator.js"></script>
<body>
<#assign labInfo>费率信息</#assign>
<#include "/template/back.ftl"/>
  <table width="90%" align="center" class="formTable">
    <form action="payTimeRate!save.action" name="payTimeRateForm" method="post" onsubmit="return false;">
    <input type="hidden" name="payTimeRate.id" value="${payTimeRate.id!}">
    <@searchParams/>
    <tr>
      <td width="20%" id="f_product" class="title"><font color="red">*</font>产品名称:</td>
      <td colspan="3">
	<@htm.i18nSelect datas=products selected="${(payTimeRate.product.id)!(0)}"  name="payTimeRate.product.id" style="width:50%;"><option value="">请选择</option></@>
      </td>
    </tr>
    <tr>
      <td id="f_paytime" class="title"><font color="red">*</font>缴费期限:</td>
      <td>
      <@htm.i18nSelect datas=payTimes selected="${(payTimeRate.paytime.id)!(0)}"  name="payTimeRate.paytime.id" style="width:50%;"><option value="">请选择</option></@>
      </td>
      <td width="20%" id="f_paytype" class="title"><font color="red">*</font>缴费方式:</td>
      <td>
      <@htm.i18nSelect datas=payTypes selected="${(payTimeRate.paytype.id)!(0)}"  name="payTimeRate.paytype.id" style="width:50%;"><option value="">请选择</option></@>
      </td>
    </tr>  
    <tr>
      <td width="20%" id="f_time" class="title"><font color="red">*</font>保险期限:</td>
      <td>
      <@htm.i18nSelect datas=times selected="${(payTimeRate.time.id)!(0)}"  name="payTimeRate.time.id" style="width:50%;"><option value="">请选择</option></@>
      </td>
      <td width="20%" id="f_gender" class="title"><font color="red">*</font>性别:</td>
      <td>
      <@htm.i18nSelect datas=genders selected="${(payTimeRate.gender.id)!(0)}"  name="payTimeRate.gender.id" style="width:50%;"><option value="">请选择</option></@>
      </td>
     </tr>
    </table>
    <#macro rateInput i>
    <#local myRate=(((payTimeRate.agerates.get(i?int))!0)*1000)>
    <input name="rate${i}" value="<#if (myRate>0)>${myRate?string('0.##')}</#if>" tabindex="${i+1}" style="width:80px">
    </#macro>
    <table width="90%" align="center" class="formTable">
    	<tr><td colspan="6" class="title">每千元保额</td></tr>
    	<tr><td align="center">0~21岁</td><td>费率</td><td align="center">22~43岁</td><td>费率</td><td align="center">44~65岁</td><td>费率</td></tr>
    	<#list 0..21 as i>
    	<tr>
	    	<td align="right">${i}</td><td><@rateInput i/></td>
	    	<td align="right">${i+22}</td><td><@rateInput i+22/></td>
	    	<td align="right">${i+44}</td><td><@rateInput i+44/></td>
    	</tr>
    	</#list>
		<tr class="darkColumn" align="center">
	      <td colspan="6">
	          <input type="button" onClick='save(this.form)' value="<@text name="system.button.submit"/>" class="buttonStyle"/>       
	          <input type="button" onClick='reset()' value="<@text name="system.button.reset"/>" class="buttonStyle"/>
	      </td>
	    </tr>
 	</table>
    </form> 
  <script language="javascript" > 
     function reset(){
         document.payTimeRateForm.reset();
     }
    function save(form){
         var a_fields = {
         'payTimeRate.product.id':{'l':'保险产品', 'r':true, 't':'f_product'},
         'payTimeRate.paytime.id':{'l':'缴费期限', 'r':true, 't':'f_paytime'},
         'payTimeRate.paytype.id':{'l':'缴费类型', 'r':true, 't':'f_paytype'},
         'payTimeRate.gender.id':{'l':'性别', 'r':true, 't':'f_gender'},
         'payTimeRate.time.id':{'l':'保险期限', 'r':true, 't':'f_time'}
         };
		 var v = new validator(form , a_fields, null);
		 if (v.exec()) {
		    form.submit();
		 }
   }
</script>
<#list 1..5 as i><br></#list>
 </body> 
</html>