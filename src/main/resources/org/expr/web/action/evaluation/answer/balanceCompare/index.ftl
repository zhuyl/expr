<#include "/template/head.ftl"/>
 <body >
 	<form name="editForm" method="post" action="${base}/answer/balanceCompare!saveRemark.action">
 <table id="gpBar"></table>
 <script>  
  function incomeExpense(year){
     self.location="balanceCompare.action?faceyear="+year+"&caze.id=${Parameters['caze.id']}";
  }
 var select ="<select name='year' onchange='incomeExpense(this.value)'><#list 1..planYears as i> <option value='${i}' <#if i?string=defaultYear?if_exists> selected</#if>>${i}</option></#list ></select>"
  var bar = new ToolBar("gpBar","统计结果(年)"+select,null,true,true);
  bar.setMessage('<@getMessage/>');
 <#-- bar.addItem("<@text name="action.print"/>","print()");-->
  bar.addHelp();
 </script>
 
  <table class="formTable" align="center" width="80%">
	<input type="hidden" name="caze.id" value="${Parameters['caze.id']}">
	<tr><td>收支结构对比分析说明:
	<textarea id="noticeContent" name="remark"  style="font-size:10pt;width:100%;height:80px">${(analysisAnswer.remark)!}</textarea>
 	</td></tr>
 	<tr><td align="right"><input value="提交" type="submit"></td></tr>
 </table>
 </form> 
	 <table class="formTable" align="center" width="80%" >
		 <#--
		 <td  width="50%" valign="top" align="center"><B>当前收入（按类型数据统计）</B>
			 <table width="100%" class="listTable" >
			    <tr align="center" class="darkColumn">
			      <td width="10%">序号</td>
			      <td width="50%">收入类型</td>
			      <td width="20%">金额</td>
			    </tr>
			    <#assign sum0 = 0/>
			    <#list countResultIncome as countItem>
			     <tr align="center" >
			      <td>${countItem_index + 1}</td>
			      <td><@i18nName countItem.what/></td>
			      <td><#assign sum0 = sum0 + (countItem.count)?default(0)/>${countItem.count}</td>
			    </tr>
				</#list>
				<tr class="darkColumn" style="text-align:center; font-weight: bold">
					<td>合计</td>
					<td></td>
					<td>${sum0?default(0)}</td>
				</tr>
				</table>
			<#list 1..5 as i><br></#list>
		</td>
		-->
		<tr colspan="2">
		<td valign="top">
			<@cewolf.chart  id="line"  title="理财前收入${nowTotalIncomeAmount?default(0)}（按类型图表统计）"   type="pie" 
			  xaxislabel="Page"  yaxislabel="Views" showlegend=true
			  backgroundimagealpha=0.5>   
			 <@cewolf.data>
			    <@cewolf.producer id="nowIncome"/>    
			 </@cewolf.data>
			 </@cewolf.chart>
			 <p>
			 <@cewolf.img chartid="line" renderer="/cewolf" width=400 height=300/>
		</td>
		<td valign="top">
			<@cewolf.chart  id="line"  title="第${defaultYear}年收入${laterTotalIncomeAmount?default(0)}（按类型图表统计）"   type="pie" 
			  xaxislabel="Page"  yaxislabel="Views" showlegend=true
			  backgroundimagealpha=0.5>   
			 <@cewolf.data>
			    <@cewolf.producer id="laterIncome"/>    
			 </@cewolf.data>
			 </@cewolf.chart>
			 <p>
			 <@cewolf.img chartid="line" renderer="/cewolf" width=400 height=300/>
		</td>
		</tr>
		<tr colspan="2">
				<td valign="top">
			<@cewolf.chart  id="line"  title="理财前支出${nowTotalExpendAmount?default(0)}（按类型图表统计）"   type="pie" 
			  xaxislabel="Page"  yaxislabel="Views" showlegend=true
			  backgroundimagealpha=0.5>   
			 <@cewolf.data>
			    <@cewolf.producer id="nowExpense"/>    
			 </@cewolf.data>
			 </@cewolf.chart>
			 <p>
			 <@cewolf.img chartid="line" renderer="/cewolf" width=400 height=300/>
		</td>

		<td valign="top">
			<@cewolf.chart  id="line"  title="第${defaultYear}年支出${laterTotalExpendAmount?default(0)}（按类型图表统计）"   type="pie" 
			  xaxislabel="Page"  yaxislabel="Views" showlegend=true
			  backgroundimagealpha=0.5>   
			 <@cewolf.data>
			    <@cewolf.producer id="laterExpense"/>    
			 </@cewolf.data>
			 </@cewolf.chart>
			 <p>
			 <@cewolf.img chartid="line" renderer="/cewolf" width=400 height=300/>
		</td>
		</tr>
	</table>
	<#--
	<table width="100%" >
		 <td  width="50%" valign="top" align="center"><B>当前支出（按类型数据统计）</B>
			 <table width="100%" class="listTable" >
			    <tr align="center" class="darkColumn">
			      <td width="10%">序号</td>
			      <td width="50%">支出类型</td>
			      <td width="20%">金额</td>
			    </tr>
			    <#assign sum0 = 0/>
			    <#list countResultExpense as countItem>
			     <tr align="center" >
			      <td>${countItem_index + 1}</td>
			      <td><@i18nName countItem.what/></td>
			      <td><#assign sum0 = sum0 + (countItem.count)?default(0)/>${countItem.count}</td>
			    </tr>
				</#list>
				<tr class="darkColumn" style="text-align:center; font-weight: bold">
					<td>合计</td>
					<td></td>
					<td>${sum0?default(0)}</td>
				</tr>
				</table>
			<#list 1..5 as i><br></#list>
		</td>
		<td valign="top">
			<@cewolf.chart  id="line"  title="当前支出（按类型图表统计）"   type="pie" 
			  xaxislabel="Page"  yaxislabel="Views" showlegend=false
			  backgroundimagealpha=0.5>   
			 <@cewolf.data>
			    <@cewolf.producer id="nowExpense"/>    
			 </@cewolf.data>
			 </@cewolf.chart>
			 <p>
			 <@cewolf.img chartid="line" renderer="/cewolf" width=400 height=300/>
		</td>
	</table>
	-->
	
	
</body>
<#include "/template/foot.ftl"/> 
