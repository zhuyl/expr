 <#include "/template/head.ftl"/>
<body>
<table class="formTable" align="center" width="80%">
	<tr><td>保险资产明细分析说明:<br>
	${(analysisAnswer.remark)!}
 	</td></tr>
<@table.table id="policyTable" width="80%" align="center" sortable="true">
 <@table.thead>
   <@table.td text="保险名称" id="policy.policy.name"/>
   <@table.td text="保险公司" id="policy.policy.company"/>
   <@table.td text="被保险人" id="policy.policy.insurant"/>
   <@table.td text="投保人" id="policy.policy.proposer"/>
   <@table.td text="受益人" id="policy.policy.benefit"/>
   <@table.td text="投保日期" id="policy.policy.applyOn"/>  
   <@table.td text="保险类型" id="policy.policy.type.id"/>
   <@table.td text="保额（元）" id="policy.policy.coverage"/>
   <@table.td text="年保费（元）" id="policy.policy.expense"/>  
   <@table.td text="缴费期限" id="policy.policy.payTime.id"/>
   <@table.td text="缴费方式" id="policy.policy.payType.id"/>
   <@table.td text="保险期限" id="policy.policy.time.id"/>          
   <@table.td text="是否附加险" id="policy.policy.additional"/>  
   <@table.td text="主险名称" />   
 </@>
 <#list answers as answer>
 <tr>
   <td>${answer.policy.name}</td>
   <td>${answer.policy.company}</td>
   <td>${answer.policy.insurant}</td>
   <td>${answer.policy.proposer}</td>
   <td>${answer.policy.benefit}</td>   
   <td>${(answer.policy.applyOn?string("yyyy-MM-dd"))?if_exists}</td>   
   <td>${(answer.policy.type.parent.name)!}|${(answer.policy.type.name)!}</td>
   <td>${answer.policy.coverage}</td>
   <td>${answer.policy.expense}</td>  
   <td>${answer.policy.payTime.name}</td> 
   <td>${answer.policy.payType.name}</td>    
   <td>${answer.policy.time.name}</td> 
   <td>${(answer.policy.additional!false)?string("是","否")}</td>
   <td>${(answer.master.name)!}</td>
   </tr>  
 </#list>
 </@>
</body>
 <#include "/template/foot.ftl"/>