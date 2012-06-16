<#if ((Parameters['type']!"")?length>0)>
<#assign infoPage>${Parameters['type']}.ftl</#assign>
<#include infoPage/>
<#include "updateScore.ftl">
</#if>