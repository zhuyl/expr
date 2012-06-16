<#include "/template/head.ftl"/>
 <body >
 <table id="gpBar"></table>
 <script>  
  function financeAssetAnalysis(year){
     self.location="analysisChartsStat.action?method=financeAssetAnalysis&year="+year+"&caze.id=${Parameters['caze.id']}";
  }
　var select ="<select name='year' onchange='financeAssetAnalysis(this.value)'><#list 1..planYears as i> <option value='${i}' <#if i?string=defaultYear?if_exists> selected</#if>>${i}</option></#list ></select>"
  var bar = new ToolBar("gpBar","统计结果(年)"+select,null,true,true);
  bar.setMessage('<@getMessage/>');
  bar.addItem("<@text name="action.print"/>","print()");
  bar.addHelp();
 </script>
	 <table width="100%" >
		<tr colspans="2">
			<td valign="top">
				<@cewolf.chart  id="line"  title="当前金融资产${nowTotalAmount?default(0)}（按资产类型图表统计）"   type="pie" 
				  xaxislabel="Page"  yaxislabel="Views" showlegend=true
				  backgroundimagealpha=0.5>   
				 <@cewolf.data>
				    <@cewolf.producer id="nowFinanceType"/>    
				 </@cewolf.data>
				 </@cewolf.chart>
				 <p>
				 <@cewolf.img chartid="line" renderer="/cewolf" width=400 height=300/>
			</td>
			<td valign="top">
				<@cewolf.chart  id="line"  title="第${defaultYear}年金融资产${totalcapitals?default(0)}（按资产类型图表统计）"   type="pie" 
				  xaxislabel="Page"  yaxislabel="Views" showlegend=true
				  backgroundimagealpha=0.5>   
				 <@cewolf.data>
				    <@cewolf.producer id="laterFinanceType"/>    
				 </@cewolf.data>
				 </@cewolf.chart>
				 <p>
				 <@cewolf.img chartid="line" renderer="/cewolf" width=400 height=300/>
			</td>
		</tr>
		</tr colspans="2">
			<td valign="top">
				<@cewolf.chart  id="line"  title="当前金融资产${nowTotalAmount?default(0)}（按风险等级图表统计）"   type="pie" 
				  xaxislabel="Page"  yaxislabel="Views" showlegend=true
				  backgroundimagealpha=0.5>   
				 <@cewolf.data>
				    <@cewolf.producer id="nowRiskGrade"/>    
				 </@cewolf.data>
				 </@cewolf.chart>
				 <p>
				 <@cewolf.img chartid="line" renderer="/cewolf" width=400 height=300/>
			</td>
			<td valign="top">
				<@cewolf.chart  id="line"  title="第${defaultYear}年金融资产${totalcapitals?default(0)}（按风险等级图表统计）"   type="pie" 
				  xaxislabel="Page"  yaxislabel="Views" showlegend=true
				  backgroundimagealpha=0.5>   
				 <@cewolf.data>
				    <@cewolf.producer id="laterRiskGrade"/>    
				 </@cewolf.data>
				 </@cewolf.chart>
				 <p>
				 <@cewolf.img chartid="line" renderer="/cewolf" width=400 height=300/>
			</td>
		</tr>
		<tr>
			<td valign="top">
				<@cewolf.chart  id="line"  title="当前金融资产${nowTotalAmount?default(0)}（按流动性图表统计）"   type="pie" 
				  xaxislabel="Page"  yaxislabel="Views" showlegend=true
				  backgroundimagealpha=0.5>   
				 <@cewolf.data>
				    <@cewolf.producer id="nowMobility"/>    
				 </@cewolf.data>
				 </@cewolf.chart>
				 <p>
				 <@cewolf.img chartid="line" renderer="/cewolf" width=400 height=300/>
			</td>
			
			<td valign="top">
				<@cewolf.chart  id="line"  title="第${defaultYear}年金融资产${totalcapitals?default(0)}（按流动性图表统计）"   type="pie" 
				  xaxislabel="Page"  yaxislabel="Views" showlegend=true
				  backgroundimagealpha=0.5>   
				 <@cewolf.data>
				    <@cewolf.producer id="laterMobility"/>    
				 </@cewolf.data>
				 </@cewolf.chart>
				 <p>
				 <@cewolf.img chartid="line" renderer="/cewolf" width=400 height=300/>
			</td>
		</tr>
		<tr colspan="2">
			
			<td valign="top">
				<@cewolf.chart  id="line"  title="当前金融资产${nowTotalAmount?default(0)}（按收益性图表统计）"   type="pie" 
				  xaxislabel="Page"  yaxislabel="Views" showlegend=true
				  backgroundimagealpha=0.5>   
				 <@cewolf.data>
				    <@cewolf.producer id="nowRate"/>    
				 </@cewolf.data>
				 </@cewolf.chart>
				 <p>
				 <@cewolf.img chartid="line" renderer="/cewolf" width=400 height=300/>
			</td>
			<td valign="top">
				<@cewolf.chart  id="line"  title="第${defaultYear}年金融资产${totalcapitals?default(0)}（按收益性图表统计）"   type="pie" 
				  xaxislabel="Page"  yaxislabel="Views" showlegend=true
				  backgroundimagealpha=0.5>   
				 <@cewolf.data>
				    <@cewolf.producer id="laterBenefit"/>    
				 </@cewolf.data>
				 </@cewolf.chart>
				 <p>
				 <@cewolf.img chartid="line" renderer="/cewolf" width=400 height=300/>
			</td>
		</tr>
		
	</table>
	
</body>
<#include "/template/foot.ftl"/> 
