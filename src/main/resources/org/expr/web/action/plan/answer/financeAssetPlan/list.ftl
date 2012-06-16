<#include "/template/head.ftl"/>
<BODY>
  <table id="toolbar"></table>
  <table class="formTable" align="center" width="80%">
	<form name="editForm" method="post" action="${base}/answer/financeAssetPlan!saveRemark.action">
	<input type="hidden" name="caze.id" value="${Parameters['caze.id']}">
	<tr><td>金融资产明细分析说明:
	<textarea id="noticeContent" name="remark"  style="font-size:10pt;width:100%;height:80px">${(planAnswer.remark)!}</textarea>
 	</td></tr>
 	<tr><td align="right"><input value="提交" type="submit"></td></tr>
 </form>
 </table>
  <@getMessage/>
  <@table.table width="80%"  align="center" id="listTable" sortable="true">
    <@table.thead>
   <@table.selectAllTd id="financePlanAnswerId" />
       <@table.sortTd name="资产类型" id="asset.finance.financetype"/>
       <@table.sortTd name="风险等级" id="asset.finance.riskgrade"/>   
       <@table.sortTd name="流动性" id="asset.finance.mobility"/>
       <@table.sortTd name="计息周期" id="asset.finance.ratepayperiod"/>  
       <@table.sortTd name="预计年收益率(%)" id="asset.finance.rate"/>
       <@table.sortTd name="投资金额(元)" id="asset.amount"/>     
       <@table.sortTd name="追加投资占比(%)" id="asset.amount"/>   
       <@table.sortTd name="开始年份" id="asset.startYear"/> 
       <@table.sortTd name="结束年份" id="asset.endYear"/>  
       <@table.sortTd name="建议产品" id="asset.endYear"/>                      
    </@>
    <@table.tbody datas=answers?if_exists;answer>
       <@table.selectTd id="financePlanAnswerId" value=answer.id type="checkbox"/>
       <td>${(answer.financetype.parent)?if_exists.name?if_exists}|${(answer.financetype)?if_exists.name?if_exists}</td> 
       <td>${(answer.riskgrade)?if_exists.name?if_exists}</td>
       <td>${(answer.mobility.name)?if_exists}</td>
       <td>${(answer.ratepayperiod)?if_exists.name?if_exists}</td>
       <td>${(answer.rate)?if_exists}%</td> 
       <td>${answer.amount?if_exists}</td>  
       <td>${answer.append?if_exists}</td>                           
       <td>${answer.startYear?if_exists}</td>
       <td>${answer.endYear?if_exists}</td>
       <td>${answer.finances?if_exists}</td>
    </@>
   </@>
   
<@table.table id="memberTable" width="80%" align="center">  
 <@table.thead>
   <@table.td text="年份"/>
   <#list answers as answer>
   <td colspan="4">金融资产名称 <br>${answer.financetype.name}</td>
   </#list>
   <@table.td text="期初总资产"/>
   <@table.td text="总投入"/>
   <@table.td text="总收益"/>
   <@table.td text="期末总资产"/>   
 </@>
   <tr align="center">
   <@table.td text=""/>
   <#list answers as answer>
 <td>期初资产</td>
 <td>追加投资</td>
 <td>收益</td>
 <td>期末资产</td>
   </#list>
   <td>&nbsp;</td>
   <td>&nbsp;</td>
   <td>&nbsp;</td>
   <td>&nbsp;</td>
   </tr>
   
   <#list 1..planYears as i>
   <tr align="center">
   <td>第${i}年</td>
   <#assign totalincome=0>
   <#assign totalexpense=0>
   <#assign totalcapital=0>
   <#list answers as answer>
  <td>${capitals[answer.financetype.name].get(i)!0}</td>
  <td>${expenses[answer.financetype.name].get(i)!0}</td>
  <td>${incomes[answer.financetype.name].get(i)!0}</td>
  <td>${(incomes[answer.financetype.name].get(i)!0)+(capitals[answer.financetype.name].get(i)!0)+(expenses[answer.financetype.name].get(i)!0)}</td>  
  <#assign totalincome=totalincome+(incomes[answer.financetype.name].get(i)!0)>
 <#assign totalexpense=totalexpense+(expenses[answer.financetype.name].get(i)!0)>
  <#assign totalcapital=totalcapital+(capitals[answer.financetype.name].get(i)!0)>
   </#list>
   <td>${totalcapital!0}</td>
   <td>${totalexpense!0}</td>
    <td>${totalincome!0}</td>
    <td>${(totalexpense!0)+(totalcapital!0)+(totalincome!0)}</td>
   </tr>
   </#list>
 </@>
   <@htm.actionForm name="actionForm" action="financeAssetPlan.action" entity="financePlanAnswer">
     <input type="hidden" name="caze.id" value="${Parameters['caze.id']}"/>
   </@>
  <script language="javascript">
     var bar = new ToolBar("toolbar","金融投资规划",null,true,true);
     bar.addItem("添加","add()");
     bar.addItem("修改","edit()");
     bar.addItem("删除","remove()");
  </script>
</body>
<#include "/template/foot.ftl"/>