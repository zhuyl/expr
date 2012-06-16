 <#include "/template/head.ftl"/>
<body>
<table id="taskBar"></table>
<script>
  var bar = new ToolBar('taskBar', '题目分析', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
  bar.addPrint();
  bar.addBack();
</script>

	<table align="center" width="90%">
	<tr>
		<td  align="center" colspan="4"><h3>${examQuestion.name}试题分析</h3></td>
	</tr>
	<tr>
	<td>
			<table align="center" width="60%"  class="listTable" >
			<tr  align="center">
				<td class="darkColumn">案例名</td>
				<td>${examQuestion.caze.name}</td>
			</tr>
			<tr  align="center">
				<td class="darkColumn">平均分</td>
				<td>${average!0}</td>
			</tr>
	</td>
	</tr>
	</table>
<#if total gt 0>
	<table align="center" width="90%">	
	<tr>
		<table align="center" width="60%"  class="listTable" >
			<tr class="darkColumn" align="center">
				<td>小题序号</td>
				<td>参答人数</td>
				<td>正确率</td>
			</tr>
			<#list examQuestion.items?sort_by("code") as item>
			<tr align="center">
				<td>${item.code}</td>
				<td>${total}</td>
				<td>${corrects[(item.code)?string.number]}%</td>
			</tr>
			</#list>
		</table>
	</tr>
	</table>
<#else>
	尚没有学生完成此题！
</#if>
</body>