<table width="85%" border="0" align="center" cellpadding="0" cellspacing="0" class='listTable'>
  <tr> 
    <td class="grayStyle">分析表</td>
    <td class="grayStyle">项目总分</td>    
    <td class="grayStyle">优(90-100)</td>
    <td class="grayStyle">良(80-89)</td>
    <td class="grayStyle">中(70-79)</td>
    <td class="grayStyle">及格(60-69)</td>
    <td class="grayStyle">不及格(0-69)</td>    
    <td class="grayStyle">得分</td>
  </tr>
<#assign accessments={}>
<#list experiment.assessment.items as item>
	<#assign accessments=accessments+{item.phase.code:item}>
</#list>
 <#list result.experiment.marks?sort_by(['analysis','phase','code']) as mark>
 	<#assign analysis=mark.analysis>
  <tr> 
   <td>${mark_index+1}.${mark.analysis.name}</td>
   <td>${mark.mark!}</td>   
  <#if accessments[analysis.code]??>
  <#assign item=accessments[analysis.code]>
   <td>${item.excellent}</td>
   <td>${item.good}</td>   
   <td>${item.middle}</td>  
   <td>${item.pass}</td> 
   <td>${item.nopass}</td> 
   </#if>
   <td>
   <#assign analysiscode=typeMap[analysis.code]>
   <input name="typeName" value="${typeMap[analysis.code]}" type="hidden"/>
	<input type="text" name="${analysiscode}Score" id="${analysiscode}Score" maxlength="3" value="${(ScoreMap[analysiscode])!}" style="width:50%;"/>	
   </td>
  </tr>
  </#list>
  <tr>
  <td  colspans="7" align="right">总得分</td>
  <td>ddd</td>
  </tr>
</table>
