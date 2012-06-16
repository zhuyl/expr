<#include "/template/head.ftl"/>
<body>
<#assign labInfo><@text name="费率信息" /></#assign>
<#include "/template/back.ftl"/>
  <table width="90%" align="center" class="infoTable">
    <tr>
      <td width="20%" class="title">产品名称:</td>
      <td colspan="3">(${payTimeRate.product.seqNo})${payTimeRate.product.name}</td>
    </tr>
    <tr>
      <td class="title">缴费期限:</td>
      <td>${payTimeRate.paytime.name}</td>
      <td width="20%" class="title">缴费方式:</td>
      <td>${payTimeRate.paytype.name}</td>
    </tr>
    <tr>
      <td width="20%" class="title">保险期限:</td>
      <td>${payTimeRate.time.name}</td>
      <td width="20%" class="title">性别:</td>
      <td>${payTimeRate.gender.name}</td>
     </tr>
	</table>
	<#macro displayRate i>
    <#local myRate=(((payTimeRate.agerates.get(i?int))!0)*1000)>
    <#if (myRate!=0)>${myRate?string('0.##')}</#if>
    </#macro>
	<table width="90%" align="center" class="infoTable">
    	<tr><td colspan="6"  class="title">每千元保额</td></tr>
    	<tr><td align="center"  class="title">0~21岁</td><td>费率</td><td align="center">22~43岁</td><td>费率</td><td align="center">44~65岁</td><td>费率</td></tr>
    	<#list 0..21 as i>
    	<tr>
	    	<td align="right" class="title">${i}</td><td><@displayRate i/></td>
	    	<td align="right" class="title">${i+22}</td><td><@displayRate i+22/></td>
	    	<td align="right" class="title">${i+44}</td><td><@displayRate i+44/></td>
    	</tr>
    	</#list>
 	</table>
 </body> 
</html>