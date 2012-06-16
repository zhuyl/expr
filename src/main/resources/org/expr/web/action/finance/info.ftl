<#include "/template/head.ftl"/>
 <body>
    <#assign labInfo><@text name="金融产品信息"/></#assign> 
	<#include "/template/back.ftl"/>
   <table width="90%" align="center" class="infoTable">
    <@searchParams/>
    <tr>
      <td width="20%" id="f_name" class="title">产品名称:</td>
      <td width="80%">${finance.name}</td>
    </tr>
    <tr>
      <td width="20%" id="f_type" class="title">产品类型:</td>
      <td width="80%">${finance.financetype.name}</td>
    </tr>
    <tr>
      <td width="20%" id="f_riksgrade" class="title">风险等级:</td>
      <td width="80%">${finance.riskgrade.name}</td>
    </tr>
    <tr>
      <td width="20%" id="f_mobility" class="title">流动性:</td>
      <td width="80%">${finance.mobility.name}</td>
    </tr> 
    <tr>
      <td width="20%" id="f_ratepayperiod" class="title">计息周期:</td>
      <td width="80%">${finance.ratepayperiod.name}</td>
    </tr>
    <tr>
      <td width="20%" id="f_ratepayperiod" class="title">利息:</td>
      <td width="80%">${finance.rate}%</td>
    </tr>
    <tr>
      <td width="20%" id="f_detail" class="title">产品说明:</td>
      <td width="80%">${finance.detail?if_exists}</td>
    </tr>
  </table>
  </body>
<#include "/template/foot.ftl"/>