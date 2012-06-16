 <#include "/template/head.ftl"/>
<body>
<table id="taskBar"></table>
<script>
  var bar = new ToolBar('taskBar', '${examPaper.lesson.coursename!}课程测试试卷分析', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
  bar.addPrint();
  bar.addBack();
</script>

	<table align="center" width="90%">
	<tr>
		<td  align="center" colspan="4"><h3>${examPaper.name}试卷分析</h3></td>
	</tr>
	</table>
<#if total gt 0>
	<table align="center" width="90%">	
	<tr>
		<table align="center" width="60%"  class="listTable" >
			<tr class="darkColumn" align="center">
				<td>等级</td>
				<td>人数(比例)</td>
			</tr>
			<tr  align="center">
				<td>优秀[90~100]</td>
				<td>${analysisResults['excellent']!0}(${percentResults['excellent']!0}%)</td>
			</tr>
			<tr  align="center">
				<td>良[80~90)</td>
				<td>${analysisResults['good']!0}(${percentResults['good']!0}%)</td>
			</tr>
			<tr  align="center">
				<td>中[70~80)</td>
				<td>${analysisResults['middle']!0}(${percentResults['middle']!0}%)</td>
			</tr>
			<tr  align="center">
				<td>及格[60~70)</td>
				<td>${analysisResults['pass']!0}(${percentResults['pass']!0}%)</td>
			</tr>
			<tr  align="center">
				<td>不及格[0~60)</td>
				<td>${analysisResults['nopass']!0}(${percentResults['nopass']!0}%)</td>
			</tr>
			<tr class="darkColumn" align="center">
				<td>平均分</td>
				<td>${average}</td>
			</tr>
		</table>
	</tr>
	</table>
	<br>
	<table align="center" width="60%" class="listTable">	
	<tr class="darkColumn" align="center">
	<td>题号</td><td>平均分</td><td>总分</td>
	</tr>	
	<#list examPaper.questionMarks?sort_by("code") as questionMark>
	<tr align="center">
	<td>第${questionMark.code}题</td><td>${questionAverages[(questionMark.code)?string.number]}</td><td>${questionMark.mark}</td>
	</tr>
	</#list>
	</table>
<#else>
	尚没有学生完成测试！
</#if>
</body>