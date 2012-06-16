<#include "/template/head.ftl"/>
 <body >
 <table id="gpBar"></table>
 <script>  
  function insuranceAnalysis(year){
     self.location="analysisChartsStat.action?method=insuranceAnalysis&year="+year+"&caze.id=${Parameters['caze.id']}";
  }
　var select ="<select name='year' onchange='insuranceAnalysis(this.value)'><#list 1..planYears as i> <option value='${i}' <#if i?string=defaultYear?if_exists> selected</#if>>${i}</option></#list ></select>"
  var bar = new ToolBar("gpBar","统计结果(年)"+select,null,true,true);
  bar.setMessage('<@getMessage/>');
 <#-- bar.addItem("<@text name="action.print"/>","print()");-->
  bar.addHelp();
 </script>
	 <table width="100%" >
		<tr colspan="2">
			<td valign="top">
				<@cewolf.chart  id="line"  title="当前保险资产${nowTotalAmount?default(0)}（按保险类型图表统计）"   type="pie" 
				  xaxislabel="Page"  yaxislabel="Views" showlegend=true
				  backgroundimagealpha=0.5>   
				 <@cewolf.data>
				    <@cewolf.producer id="nowInsuranceType"/>    
				 </@cewolf.data>
				 </@cewolf.chart>
				 <p>
				 <@cewolf.img chartid="line" renderer="/cewolf" width=400 height=300/>
			</td>
			
			<td valign="top">
				<@cewolf.chart  id="line"  title="第${defaultYear}年保险资产${laterTotalCoverage?default(0)}（按保险类型图表统计）"   type="pie" 
				  xaxislabel="Page"  yaxislabel="Views" showlegend=true
				  backgroundimagealpha=0.5>   
				 <@cewolf.data>
				    <@cewolf.producer id="laterInsuranceType"/>    
				 </@cewolf.data>
				 </@cewolf.chart>
				 <p>
				 <@cewolf.img chartid="line" renderer="/cewolf" width=400 height=300/>
			</td>
		</tr>
		<tr>	
			<td valign="top">
				<@cewolf.chart  id="line"  title="当前保险资产${nowTotalAmount?default(0)}（按被保险人图表统计）"   type="pie" 
				  xaxislabel="Page"  yaxislabel="Views" showlegend=true
				  backgroundimagealpha=0.5>   
				 <@cewolf.data>
				    <@cewolf.producer id="nowInsurant"/>    
				 </@cewolf.data>
				 </@cewolf.chart>
				 <p>
				 <@cewolf.img chartid="line" renderer="/cewolf" width=400 height=300/>
			</td>
			<td valign="top">
				<@cewolf.chart  id="line"  title="第${defaultYear}年保险资产${laterTotalCoverage?default(0)}（按被保险人图表统计）"   type="pie" 
				  xaxislabel="Page"  yaxislabel="Views" showlegend=true
				  backgroundimagealpha=0.5>   
				 <@cewolf.data>
				    <@cewolf.producer id="laterInsurant"/>    
				 </@cewolf.data>
				 </@cewolf.chart>
				 <p>
				 <@cewolf.img chartid="line" renderer="/cewolf" width=400 height=300/>
			</td>
		</tr>
	 </table>
 <table width="100%" >
 <tr conspan="2">
 <td valign="top">
   <#list members as member> 
   <#if nowMemberTotalAmountMap[member.name]!=0>
 <table width="100%" >
		<tr>
			<td valign="top">
				<@cewolf.chart  id="line"  title="当前${member.name}保险资产${nowMemberTotalAmountMap[member.name]?default(0)}（按保险类型图表统计）"   type="pie" 
				  xaxislabel="Page"  yaxislabel="Views" showlegend=true
				  backgroundimagealpha=0.5>   
				 <@cewolf.data>
				    <@cewolf.producer id="nowMemberInsuranceType"+member.name/>    
				 </@cewolf.data>
				 </@cewolf.chart>
				 <p>
				 <@cewolf.img chartid="line" renderer="/cewolf" width=400 height=300/>
			</td>
</tr>
	 </table>
	 </#if>
</#list>
</td>
<td valign="top">
   <#list members as member> 
   <#if laterMemberTotalAmountMap[member.name]!=0>
 <table width="100%" >
		<tr>
			<td valign="top">
				<@cewolf.chart  id="line"  title="第${defaultYear}年${member.name}保险资产${laterMemberTotalAmountMap[member.name]?default(0)}（按保险类型图表统计）"   type="pie" 
				  xaxislabel="Page"  yaxislabel="Views" showlegend=true
				  backgroundimagealpha=0.5>   
				 <@cewolf.data>
				    <@cewolf.producer id="laterMemberInsuranceType"+member.name/>    
				 </@cewolf.data>
				 </@cewolf.chart>
				 <p>
				 <@cewolf.img chartid="line" renderer="/cewolf" width=400 height=300/>
			</td>
</tr>
	 </table>
	 </#if>
</#list>


</td>
</tr>
</table>
</body>
<#include "/template/foot.ftl"/> 
