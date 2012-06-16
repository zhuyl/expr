<#include "/template/head.ftl"/>
<body>
<#list financeProductCategories as category>
 <br> ${category.name}<br>
  <#list category.products?sort_by("code")?chunk(4) as tl>
     <ul>
     <#list tl as t>
       <li><a href="${base}/financeProduct!show.action?product=${t.engName?if_exists}">${t.name}</a></li>
     </#list>
     </ul>
  </#list>
</#list>
</body>
<#include "/template/foot.ftl"/>