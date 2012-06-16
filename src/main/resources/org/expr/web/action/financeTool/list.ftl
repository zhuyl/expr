<#include "/template/head.ftl"/>
<body>
<#list financeToolCategories as category>
 <br> ${category.name}<br>
  <#list category.tools?sort_by("code")?chunk(4) as tl>
     <ul>
     <#list tl as t>
       <li><a href="${base}/financeTool!show.action?tool=${t.engName?if_exists}">${t.name}</a></li>
     </#list>
     </ul>
  </#list>
</#list>
</body>
<#include "/template/foot.ftl"/>