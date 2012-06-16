<#include "/template/head.ftl"/>
<BODY LEFTMARGIN="0" TOPMARGIN="0">
    <@getMessage/>
	<@table.table width="100%" sortable="true" id="listTable">
       	<@table.thead>
         	<@table.selectAllTd id="baseCodeId"/>
         	<@table.sortTd name="common.code" id="baseCode.code" width="10%"/>
         	<@table.sortTd  name="common.name" id="baseCode.name" width="20%"/>
         	<@table.sortTd  name="common.engName" id="baseCode.engName"  width="30%"/>
	     	<@table.sortTd  name="common.updatedAt" id="baseCode.updatedAt"/>
	     	<@table.sortTd  name="common.status" id="baseCode.enabled"/>
	     	<@table.sortTd  text="上级类型" id="baseCode.parent"/>
	   	</@>
	   	<@table.tbody datas=baseCodes;baseCode>
         	<@table.selectTd id="baseCodeId" value=baseCode.id/>
	    	<td>${baseCode.code?if_exists}</td>
	    	<td>${baseCode.name?if_exists}</td>
	    	<td><#if baseCode.engName?exists><a target="_blank" href="${base}/financeTool!show.action?tool=${baseCode.engName}">${baseCode.engName}</a></#if></td>
	    	<td>${(baseCode.updatedAt?string("yyyy-MM-dd"))?if_exists}</td>
	    	<td>
		       	<#if baseCode.enabled?if_exists == true><@text name="common.yes"/><#else><@text name="common.no"/></#if>
	    	</td>
	    	<td>
	    	${baseCode.parent?if_exists.name?if_exists}
	    	</td>
	   	</@>
	</@>
</body>
<#include "/template/foot.ftl"/>