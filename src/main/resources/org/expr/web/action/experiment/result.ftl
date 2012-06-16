<#if ((Parameters['type']!"")?length>0)>
<#assign resultInfoPage>resultInfo/${Parameters['type']}.ftl</#assign>
<#include resultInfoPage/>
</#if>