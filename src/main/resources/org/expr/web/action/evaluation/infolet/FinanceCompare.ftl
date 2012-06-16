<#include "../../experiment/metadata.ftl"/>
<#assign type>${Parameters['type']}</#assign>
<#if analysisAnswer??><#assign result=analysisAnswer/></#if>
<#if analysisResult??><#assign result=analysisResult/></#if>
<#if result??&&result.remark??>
<table width="100%" align="center">
<tr><td><B>${nameMap[type]}的说明：</B></td></tr>
<tr><td>${(result.remark)?if_exists}</td></tr>
</table>
<#assign cewolf=JspTaglibs["/WEB-INF/cewolf.tld"]>
 <table class="formTable" align="center" width="100%" >
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
<#else>
未做该部分
</#if>