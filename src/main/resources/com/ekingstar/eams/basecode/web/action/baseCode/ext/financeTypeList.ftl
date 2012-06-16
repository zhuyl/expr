<#include "/template/head.ftl"/>
<BODY LEFTMARGIN="0" TOPMARGIN="0">
    <@getMessage/>
	<@table.table width="100%" sortable="true" id="listTable">
       	<@table.thead>
         	<@table.selectAllTd id="baseCodeId"/>
         	<@table.sortTd name="attr.code" id="baseCode.code" width="10%"/>
         	<@table.sortTd  name="名称" id="baseCode.name" width="20%"/>
         	<@table.sortTd  name="英文名" id="baseCode.engName"  width="30%"/>
	     	<@table.sortTd  name="修改日期" id="baseCode.updatedAt"/>
	     	<@table.sortTd  name="状态" id="baseCode.enabled"/>
	   	    <td>上级类型</td>
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