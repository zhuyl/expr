 <#include "/template/head.ftl"/>
<body>
<table id="toolbar"></table>
<table class="formTable" align="center" width="80%">
	<form name="editForm" method="post" action="${base}/answer/insuranceAnalysis!saveRemark.action">
	<input type="hidden" name="caze.id" value="${Parameters['caze.id']}">
	<tr><td>保险资产明细分析说明:
	<textarea id="noticeContent" name="remark"  style="font-size:10pt;width:100%;height:80px">${(analysisAnswer.remark)!}</textarea>
 	</td></tr>
 	<tr><td align="right"><input value="提交" type="submit"></td></tr>
 </form>
<@table.table id="policyTable" width="80%" align="center" sortable="true">
 <@table.thead>
   <@table.selectAllTd id="insurancePolicyAnswerId" />
   <@table.sortTd text="保险名称" id="policy.policy.name"/>
   <@table.sortTd text="保险公司" id="policy.policy.company"/>
   <@table.sortTd text="被保险人" id="policy.policy.insurant"/>
   <@table.sortTd text="投保人" id="policy.policy.proposer"/>
   <@table.sortTd text="受益人" id="policy.policy.benefit"/>
   <@table.sortTd text="投保日期" id="policy.policy.applyOn"/>  
   <@table.sortTd text="保险类型" id="policy.policy.type.id"/>
   <@table.sortTd text="保额（元）" id="policy.policy.coverage"/>
   <@table.sortTd text="年保费（元）" id="policy.policy.expense"/>  
   <@table.sortTd text="缴费期限" id="policy.policy.payTime.id"/>
   <@table.sortTd text="缴费方式" id="policy.policy.payType.id"/>
   <@table.sortTd text="保险期限" id="policy.policy.time.id"/>          
   <@table.sortTd text="是否附加险" id="policy.policy.additional"/>  
   <@table.td text="主险名称" />   
 </@>
 <@table.tbody datas=answers;answer>
   <@table.selectTd id="insurancePolicyAnswerId" value=answer.id type="checkbox"/>
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
   </@>
 </@>
<@htm.actionForm name="actionForm" action="insuranceAnalysis.action" entity="insurancePolicyAnswer">
  <input type="hidden" name="caze.id" value="${Parameters['caze.id']}"/>
</@>
  <script language="javascript">
     var bar = new ToolBar("toolbar","保险资产明细分析",null,true,true);
     bar.setMessage('<@getMessage/>');
     bar.addItem("添加","add()");
     bar.addItem("修改","edit()");
     bar.addItem("删除","remove()");
  </script>
</body>
 <#include "/template/foot.ftl"/>