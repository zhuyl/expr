<#include "/template/head.ftl"/>
<BODY LEFTMARGIN="0" TOPMARGIN="0">
    <@getMessage/>
	<@table.table width="100%" sortable="true" id="listTable">
       	<@table.thead>
         	<@table.selectAllTd id="baseCodeId"/>
         	<@table.sortTd name="attr.code" id="baseCode.code" width="10%"/>
         	<@table.sortTd  name="名称" id="baseCode.name" width="20%"/>
         	<@table.sortTd  name="英文名称" id="baseCode.engName"  width="30%"/>
            <@table.sortTd  name="缴费期限" id="baseCode.enabled"/>
	     	<@table.sortTd  name="更新日期" id="baseCode.updatedAt"/>
	     	<@table.sortTd  name="使用状态" id="baseCode.enabled"/>
	   	</@>
	   	<@table.tbody datas=baseCodes;baseCode>
         	<@table.selectTd id="baseCodeId" value=baseCode.id/>
	    	<td>${baseCode.code?if_exists}</td>
	    	<td>${baseCode.name?if_exists}</td>
	    	<td>${baseCode.engName?if_exists}</td>
	    	<td>${baseCode.duration?if_exists}</td>
	    	<td>${(baseCode.updatedAt?string("yyyy-MM-dd"))?if_exists}</td>
	    	<td>
		       	<#if baseCode.enabled?if_exists == true><@text name="common.yes"/><#else><@text name="common.no"/></#if>
	    	</td>
	   	</@>
	</@>
</body>
<#include "/template/foot.ftl"/>