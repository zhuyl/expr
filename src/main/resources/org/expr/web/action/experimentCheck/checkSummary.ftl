<#include "/template/head.ftl"/>
<table id="toolbar"></table>
<#include "metadata.ftl"/>
<body>
<form name="actionForm" method="post" action="experimentCheck!saveSummary.action">
	<input type="hidden" name="experiment.id" value="${Parameters['experiment.id']}">
	<input type="hidden" name="std.id" value="${Parameters['std.id']}">	
<table width="85%" border="0" align="center" cellpadding="0" cellspacing="0" class='listTable'>
  <tr> 
    <td class="grayStyle" align="center">分析表</td>  
    <td class="grayStyle" align="center">优(90-100)</td>
    <td class="grayStyle" align="center">良(80-89)</td>
    <td class="grayStyle" align="center">中(70-79)</td>
    <td class="grayStyle" align="center">及格(60-69)</td>
    <td class="grayStyle" align="center">不及格(0-69)</td>    
    <td class="grayStyle" align="center">评分</td>
    <td class="grayStyle" align="center">满分</td> 
    <td class="grayStyle" align="center">得分</td>  
  </tr>
<#assign accessments={}>
<#list experiment.assessment.items as item>
	<#assign accessments=accessments+{item.phase.code:item}>
</#list>
 <#list result.experiment.marks?sort_by(['analysis','code']) as mark>
 	<#assign analysis=mark.analysis>
  <tr> 
   <td>${mark_index+1}.${mark.analysis.name}</td> 
  <#if accessments[analysis.code]??>
  <#assign item=accessments[analysis.code]>
  <td>${item.excellent!}</td>
   <td>${item.good!}</td>   
   <td>${item.middle!}</td>  
   <td>${item.pass!}</td> 
   <td>${item.nopass!}</td>
   <#else>
   <td></td> 
      <td></td> 
         <td></td> 
            <td></td> 
               <td></td> 
   </#if>
   <td>
   <#assign analysiscode=typeMap[analysis.code]>
   <input name="typeName" value="${typeMap[analysis.code]}" type="hidden"/>
   <input type="text" name="${analysiscode}ScorePercent" id="${analysiscode}ScorePercent" maxlength="3" value="${((ScoreMap[analysiscode]!0)/mark.mark*100)!0}" onchange="calcScore('${analysiscode}')" style="width:100%;"/>
   <input type="hidden" name="${analysiscode}Score" id="${analysiscode}Score" value="${(ScoreMap[analysiscode])!0}" />	
   </td>
   <td align="center" id="${analysiscode}totalmark">${mark.mark!0}</td> 
   <td align="center" id="${analysiscode}mark" >${(ScoreMap[analysiscode])!0}</td>   
  </tr>
  </#list>
  <tr>
  <td   class="grayStyle" colspan="8" align="right">总得分</td>
  <td id="lastscore">${result.score!0}</td>
  </tr>
   	<tr><td align="right"  colspan="9"><input value="提交" type="submit"></td></tr>
</table>
</form>
</body>
<script language="javascript">
     var bar = new ToolBar("toolbar",'${result.student.name!}的作业评分',null,true,true);
     bar.addPrint();
	function calcScore(analysiscode){
		if(analysiscode==null) return;
		var valueStr= document.actionForm[analysiscode+'ScorePercent'].value;
		var totalmark=document.getElementById(analysiscode+'totalmark').innerHTML;
		myvalue=parseFloat(valueStr);
		totalmarkvalue=parseFloat(totalmark);
		if(isNaN(myvalue)){
			alert(valueStr+" 不是数字");
			myvalue=0;
			document.actionForm[analysiscode+'ScorePercent'].value='0';
		}else{
			if(myvalue>100|| myvalue<0){
				alert(valueStr+" 不是0~100之间数字");
				myvalue=0;
				document.actionForm[analysiscode+'ScorePercent'].value='0';
			}
		}
		document.getElementById(analysiscode+'mark').innerHTML=Math.round(myvalue*totalmarkvalue)/100;
		document.getElementById(analysiscode+'Score').value=Math.round(myvalue*totalmarkvalue)/100;
		refreshSum();
	}
	function refreshSum()
	{
		var sum=0;
		var typeNames=document.getElementsByName('typeName');
		for(var i=0;i<typeNames.length;i++)
		{
			var valueStr= document.getElementById(typeNames[i].value+'mark').innerHTML;
			myvalue=parseFloat(valueStr);
			sum=sum+myvalue;
		}
		document.getElementById('lastscore').innerHTML=Math.round(sum*100)/100;
	}
</script>
 <#include "/template/foot.ftl"/>