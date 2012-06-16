 <#include "/template/head.ftl"/>
<body>
<table id="toolbar"></table>
<table class="formTable" align="center" width="80%">
	<form name="editForm" method="post" action="${base}/result/insuranceAnalysis!saveRemark.action">
	<input type="hidden" name="experiment.id" value="${Parameters['experiment.id']}">
	<tr><td>保险资产明细分析说明:
	<textarea id="noticeContent" name="remark"  style="font-size:10pt;width:100%;height:80px">${(analysisResult.remark)!}</textarea>
 	</td></tr>
 	<tr><td align="right"><input value="提交" type="submit"></td></tr>
 </form>
<@table.table id="policyTable" width="80%" align="center" sortable="true">
 <@table.thead>
   <@table.selectAllTd id="insurancePolicyResultId" />
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
 <@table.tbody datas=results;result>
   <@table.selectTd id="insurancePolicyResultId" value=result.id type="checkbox"/>
   <td>${result.policy.name}</td>
   <td>${result.policy.company}</td>
   <td>${result.policy.insurant}</td>
   <td>${result.policy.proposer}</td>
   <td>${result.policy.benefit}</td>   
   <td>${(result.policy.applyOn?string("yyyy-MM-dd"))?if_exists}</td>   
   <td>${(result.policy.type.parent.name)!}|${(result.policy.type.name)!}</td>
   <td>${result.policy.coverage}</td>
   <td>${result.policy.expense}</td>  
   <td>${result.policy.payTime.name}</td> 
   <td>${result.policy.payType.name}</td>    
   <td>${result.policy.time.name}</td> 
   <td>${(result.policy.additional!false)?string("是","否")}</td>
   <td>${(result.master.name)!}</td>
   </@>
 </@>
<@htm.actionForm name="actionForm" action="insuranceAnalysis.action" entity="insurancePolicyResult">
  <input type="hidden" name="experiment.id" value="${Parameters['experiment.id']}"/>
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