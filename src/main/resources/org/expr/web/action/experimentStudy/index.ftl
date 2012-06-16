 <#include "/template/head.ftl"/>
<body>
<SCRIPT type=text/javascript>
window.onload = function onrun(){
var id = "";
   if(id!=""&&document.getElementById(id)){
      document.getElementById(id).style.background='url(navbg1.gif)';
   }else if(id==""){
      document.getElementById('tithomepage').style.background='url(navbg1.gif)';
   }
}
</SCRIPT>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td> <#include "./lessonNav.ftl"/></td>
              </tr>
</table>
<table id="taskBar"></table>
<script>
  var bar = new ToolBar('taskBar', '${lessons[0].coursename}已选学习任务', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
  bar.addBlankItem();
</script>
 <@table.table width="100%" sortable="true" id="noticeTable" style="word-break: break-all">
     <@table.thead>
	    <@table.td text="实验编号"/>
	    <@table.td text="实验名称"/>
	    <@table.td text="实验类型"/>
	    <@table.td text="开始学习时间"/>
	    <@table.td text="结束学习时间"/>
	    <@table.td text="已学时间"/>	  
	    <@table.td text="进入学习"/>	   
	    <@table.td text="查看得分"/>
	    <@table.td text="查看答案"/>	   	    
	   </@>
	   <@table.tbody datas=experiments;experiment>
	                               <td>${experiment.code}</td>
                            <td><a href="experiment.action?method=info&experimentId=${experiment.id}">${experiment.name}</a></td>
                            <td>${experiment.type.name} </td>
                            <td>${experiment.beginAt?string("yyyy-MM-dd  HH:mm")}</td>
                            <td>${experiment.endAt?string("yyyy-MM-dd HH:mm")}</td>
                            <td><#if experimenttimes[experiment.id?string]??><a href="studyLog.action?method=studyLogs&experimentId=${experiment.id}">${(experimenttimes[experiment.id?string]/60)?int}分${(experimenttimes[experiment.id?string]%60)}秒</a></#if></td>
                            <td>                            	
                            	<#if (currentTime?datetime>=experiment.beginAt)&&(currentTime?datetime<=experiment.endAt)>
                            		<#if cazeResults.get(experiment.id)?if_exists.isSubmit?if_exists != true>
                            		<a href="result/resultDashboard!index.action?experimentId=${experiment.id}" target="_blank" >进入学习</a>&nbsp;&nbsp;
                            		<a href="experimentStudy!submitAnswer.action?experimentId=${experiment.id}&lesson.id=${Parameters['lesson.id']}">提交作业</a>
                            		<#else>
                            		作业已提交(${cazeResults.get(experiment.id)?if_exists.submitAt?if_exists})
                        			</#if>	
                            	<#else>
                            		不在学习时间
                        		</#if>	
                            </td>
                            <td>
	                            	<a href="experimentStudy!result.action?experiment.id=${experiment.id}" target="_blank">
	                            	<#if (experiment.publishScore?if_exists)!=true>
	                            	查看作业
	                            	<#else>
	                            	查看作业(${cazeResults.get(experiment.id)?if_exists.score?if_exists})
	                            	</#if>
	                            	</a>
	                        	</td>	
                            <td>
                            	<#if experiment.publish>
	                            	<a  target="_blank" href="experimentStudy!answers.action?experiment.id=${experiment.id}">查看答案</a>
                            	<#else>
                            		答案未公布
                        		</#if>	
                            </td>    
          </@>
</@>
<table id="taskBar2"></table>
<script>
  var bar = new ToolBar('taskBar2', '${lessons[0].coursename}可选学习任务', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
  bar.addItem("添加","add()");
</script>
 <@table.table width="100%" sortable="true" id="noticeTable" style="word-break: break-all">
     <@table.thead>
            <@table.td text=""/>
	    <@table.td text="实验编号"/>
	    <@table.td text="实验名称"/>
	    <@table.td text="实验类型"/>
	    <@table.td text="开始学习时间"/>
	    <@table.td text="结束学习时间"/>  	    
	   </@>
	   <@table.tbody datas=chooseexperiments;chooseexperiment>
	   <@table.selectTd id="chooseexperimentId" value=chooseexperiment.id />
	                               <td>${chooseexperiment.code}</td>
                            <td><a href="experiment.action?method=info&experimentId=${chooseexperiment.id}">${chooseexperiment.name}</a></td>
                            <td>${chooseexperiment.type.name} </td>
                            <td>${chooseexperiment.beginAt?string("yyyy-MM-dd  HH:mm")}</td>
                            <td>${chooseexperiment.endAt?string("yyyy-MM-dd HH:mm")}</td>
          </@>
</@>
 <form name="actionForm" method="post" action="experimentStudy.action?method=addExperiment">
    <input name="chooseexperimentId" value="" type="hidden"/>
    <input name="lesson.id" value="${lessons[0].id}" type="hidden"/>
    <input name="params" value="&lesson.id=${lessons[0].id}" type="hidden"/>
 </form>
<script>
  function add(){
  		var chooseexperimentId = getSelectIds("chooseexperimentId");
  		document.actionForm.chooseexperimentId.value = chooseexperimentId;//alert(chooseexperimentId);return;
         document.actionForm.submit();
  }
 </script>
</body>