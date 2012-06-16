<#include "/template/head.ftl"/>
<table id="toolbar"></table>
<#include "metadata.ftl"/>

<#assign type=Parameters['type']>
<#list typeMap?keys as key>
<#if typeMap[key]=type><#assign code=key/><#break/></#if>
</#list>
<@sj.head jquerytheme="redmond"/>
<table width="80%" align="center"><tr><td>
	<#assign typeUri>result/${typeUriMap[code]}!infolet.action?type=${Parameters['type']}&std.id=${Parameters['std.id']}&experiment.id=${Parameters['experiment.id']}&nopage=1${extParams[code]!}</#assign>
	<@sj.div cssClass="ui-widget-content ui-corner-all" id="div${code}"  href="${typeUri}">
	</@>
<#--
<#assign infoPage>../${Parameters['phase']}/infolet/${Parameters['type']}.ftl</#assign>
<#include infoPage/>
-->
</td></tr></table>
<br>
<form name="actionForm" method="post" action="experimentCheck!saveAnswer.action">
	<input type="hidden" name="experiment.id" value="${Parameters['experiment.id']}">
	<input type="hidden" name="std.id" value="${Parameters['std.id']}">	
	<input type="hidden" name="phase" value="${Parameters['phase']}">
	<input type="hidden" name="type" value="${Parameters['type']}">
	<input type="hidden" name="totalmark" value="${totalmark!0}">	
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0" class='listTable'>
  <tr> 
    <td class="grayStyle">分析内容</td>
    <td class="grayStyle">优</td>
    <td class="grayStyle">良</td>
    <td class="grayStyle">中</td>
    <td class="grayStyle">及格</td>
    <td class="grayStyle">不及格</td>
    <td class="grayStyle">评分</td>
    <td class="grayStyle">总分</td>  
    <td class="grayStyle">得分</td>       
  </tr>
  <#if item??>
  <tr> 
   <td>${(item.phase!).name!}</td>
   <td>${item.excellent!}</td>
   <td>${item.good!}</td>   
   <td>${item.middle!}</td>  
   <td>${item.pass!}</td> 
   <td>${item.nopass!}</td>
   <td>
   <input type="text" name="scorePercent" id="scorePercent" maxlength="3" value="${((result.score!0)/(totalmark!0)*100)!}"   onchange="calcScore()" style="width:100%;"/>
   <input type="hidden" name="score" id="score" value="${(result.score)!0}"/></td>
   <td align="center">${totalmark!0}</td>
   <td id="mark" align="center">${result.score!0}</td>
  </tr>
</#if>
 	<tr><td align="right"  colspan="9"><input value="提交" type="submit"></td></tr>
</table>
</form>


<#assign type>${Parameters['type']}</#assign>
<script language="javascript">
     var bar = new ToolBar("toolbar",'${result.student.name!}的${nameMap[type]}',null,true,true);
     bar.addPrint();
     
     
    function calcScore(){
	    var valueStr= document.actionForm['scorePercent'].value;
	    myvalue=parseFloat(valueStr);
	    if(isNaN(myvalue)){
			alert(valueStr+" 不是数字");
			myvalue=0;
			document.actionForm['scorePercent'].value='0';
		}else{
			if(myvalue>100|| myvalue<0){
				alert(valueStr+" 不是0~100之间数字");
				myvalue=0;
				document.actionForm['scorePercent'].value='0';
			}
		}
		document.getElementById("mark").innerHTML=Math.round(myvalue*${totalmark})/100;
		document.getElementById("score").value=Math.round(myvalue*${totalmark})/100;
	}
</script>
<#include "/template/foot.ftl"/>