<#include "/template/head.ftl"/>
 <body>
    <#assign labInfo><@text name="保险产品信息"/></#assign> 
	<#include "/template/back.ftl"/>
   <table width="90%" align="center" class="infoTable">
    <@searchParams/>
      <tr>
      <td width="20%" id="f_seqNo" class="title"><font color="red">*</font>产品编号:</td>
      <td width="80%">${insuranceProduct.seqNo?if_exists}</td>
    </tr>
    <tr>
      <td width="20%" id="f_name" class="title"><font color="red">*</font>产品名称:</td>
      <td width="80%">${insuranceProduct.name!}</td>
    </tr>
     <tr>
      <td width="20%" id="f_corporation" class="title"><font color="red">*</font>发行公司:</td>
      <td width="80%">${insuranceProduct.corporation!}</td>
    </tr>
    <tr>
      <td width="20%" id="f_type" class="title"><font color="red">*</font>产品类型:</td>
      <td width="80%">${insuranceProduct.type.name}</td>
    </tr>
     <tr>
      <td width="20%" id="f_corporation" class="title"><font color="red">*</font>是否附加险:</td>
      <td width="80%">
		<#if insuranceProduct.additional!false>是</#if>
		<#if !insuranceProduct.additional!false>否</#if>
      </td>
    </tr>
    <tr>
    <td width="20%" class="title" id="f_insurancePayType">缴费方式：</td>
    <td width="80%">
 	<#list insuranceProduct.paytypes?if_exists as paytype>${paytype.name}&nbsp;</#list>
    </td>
   </tr> 
   <tr>
    <td width="20%" class="title" id="f_insurancePayTime">缴费期限：</td>
    <td width="80%">
    <#list insuranceProduct.paytimes?if_exists as paytime>${paytime.name}&nbsp;</#list>
    </td>
   </tr> 
  <tr>
    <td width="20%" class="title" id="f_insuranceTime">保险期限：</td>
    <td width="80%">
     <#list insuranceProduct.times?if_exists as time>${time.name}&nbsp;</#list>
    </td>
   </tr>
    <tr>
      <td class="title" id="f_detail"><font color="red">*</font>产品说明：</td>
<td>${insuranceProduct.detail?if_exists}</td>
     </tr> 
     <tr>
      <td width="20%" id="f_rateregistry" class="title"><font color="red">*</font>费率决定因素:</td>
      <td width="80%">
 ${insuranceProduct.registry.name?if_exists}</td>
      </tr>
      <tr>
       <td width="20%" id="f_careerprofile" class="title">职业等级方案:</td>
      <td width="80%">
		${(insuranceProduct.careerprofile?if_exists).name?if_exists}</td>
      </tr> 
      <tr>
    <td width="20%" class="title" id="f_insurancePayTime">附加险种：</td>
    <td width="80%">
     <#list insuranceProduct.additionalProducts?if_exists?sort_by('id') as additionalProduct>
          ${additionalProduct.name}&nbsp;
     </#list>
    </td>
   </tr>
  </table>
  </body>
<#include "/template/foot.ftl"/>