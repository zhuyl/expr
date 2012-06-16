<#if ((Parameters['type']!"")?length>0)>
<#assign infoPage>${(Parameters['phase']!"")}/${Parameters['type']}.ftl</#assign>
<#include infoPage/>
</#if>