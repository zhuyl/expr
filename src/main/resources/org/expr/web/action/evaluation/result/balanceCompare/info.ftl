<#include "/template/head.ftl"/>
 <body >
 
  <table class="formTable" align="center" width="80%">
	<tr><td>收支结构对比分析说明:<br>
	${(analysisResult.remark)!}
 	</td></tr>
 </table>
	 <table class="formTable" align="center" width="80%" >
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
	
</body>
<#include "/template/foot.ftl"/> 
