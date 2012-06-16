<#include "/template/head.ftl"/>
<body>
<#if !result??><font color="red">还没有可以批改的作业</font>
<#elseif (result.submit)??>学生作业还没有提交<#else>
<#include "metadata.ftl"/>
<table id="backBar"></table>
<script>
	var bar = new ToolBar('backBar','作业得分',null,true,true);
	bar.setMessage('');
	bar.addPrint();
	bar.addClose();
	
function validateScore(obj){
	if(obj.value=='')return;
	value=obj.value;
	var myVal=parseFloat(value);
	if(isNaN(myVal)){
		alert(value+" 不是数字");
		obj.value="";
	}
}
function notifyScore(id,score){
	mark=parseFloat(document.getElementById(id+'Mark').value);
	percent=(score/mark*100);
	document.getElementById(id+"Score").innerHTML=("("+percent+ "*" + mark + ")/100 = " + score);
}
</script>
<h3 align="center">${result.student.name}(${result.student.code})的${result.experiment.lesson.coursename}--${result.experiment.name}作业<#if result.score??><br>总分:${result.score!}</#if></h3>
<@sj.head jquerytheme="redmond"/>
<#assign accessments={}>
<#list experiment.assessment.items as item>
	<#assign accessments=accessments+{item.phase.code:item}>
</#list>
<table width="90%" align="center"><tr><td>
	<@s.form action="experiment!submitCheck" id="checkSubmitForm"  theme="simple">
	<input name="std.id" type="hidden" value="${result.student.id}" />
	<input name="experiment.id" type="hidden" value="${result.experiment.id}" />
	<#list result.experiment.marks?sort_by(['analysis','code']) as mark>
	<B><#if (mark_index>0)><br><br></#if>${mark_index+1}.${mark.analysis.name}
	<hr></B>
	<#assign analysis=mark.analysis>
	<#if typeUriMap[analysis.code]??>
	<#assign typeUri>result/${typeUriMap[analysis.code]}!infolet.action?type=${typeMap[analysis.code]!}&std.id=${result.student.id}&experiment.id=${Parameters['experiment.id']}${extParams[analysis.code]!}</#assign>
	<@sj.div cssClass="ui-widget-content ui-corner-all" id="div${analysis.id}"  href="${typeUri}">
	</@>
	<div align="right"><#if accessments[analysis.code]??><#assign item=accessments[analysis.code]>优(90~100):${item.excellent}; 良(80~89):${item.good}; 中(70~79):${item.middle}; 及格(60~69):${item.pass}; 不及格(0～59):${item.nopass}; </#if> <input name="typeName" value="${typeMap[analysis.code]}" type="hidden"/>分数:
	<span id="${typeMap[analysis.code]}Score"></span><input type="hidden" value="${mark.mark!}" id="${typeMap[analysis.code]}Mark"></div>
	</#if>
	</#list>
	</@>
	<#--<div id="ss" align="center"><div id="checkResult">总分:${result.score!}</div><@sj.submit targets="checkResult" value="提交" formIds="checkSubmitForm"/></div>-->
</td></tr></table>
</#if>

</body>
</html>