 <#include "/template/head.ftl"/>
<body>
<table id="taskBar"></table>
<script>
  var bar = new ToolBar('taskBar', '${examPaperResult.paper.lesson.coursename!}课程测试结果', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
  bar.addPrint();
  bar.addClose();
</script>

	<table align="center" width="90%">
	<tr>
		<td  align="center" colspan="4"><h3>${examPaperResult.paper.name}</h3></td>
	</tr>
	<tr>
		<td align="right">学生姓名(学号)：</td><td align="left"><B>${std.name}(${std.code})</B></td><td align="right">得分：</td><td align="left"><B>${examPaperResult.mark!}</B></td>
	</tr>
	<tr>
		<td align="right">开始测试时间：</td><td align="left"><B>${examPaperResult.beginAt?string("yyyy-MM-dd HH:mm")}</B></td><td align="right">提交试卷时间：</td><td align="left"><B>${examPaperResult.endAt?string("yyyy-MM-dd HH:mm")}</B></td>
	</tr>
	<tr>
		<td align="right">测试用时：</td><td align="left"><B>${examSpan!}</B></td><td align="right"></td><td align="left"><B></B></td>
	</tr>
	<table>
		<table align="center" width="90%">
	<tr>
		<td align="left"><B>${examPaperResult.paper.description!}</B></td>
	</tr>
	<#list examPaperResult.questionResults?sort_by("code") as questionResult>
	<#assign question=questionResult.question>
	<tr>
	<td align="left">
		<B>${questionResult.code}、${question.name}<font color="#FF0000">(${questionResult.mark}分)</font></B>
	</td>
	</tr>
	<tr><td align="left">${question.introduction!}</td></tr>
	<tr><td>
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class='listTable'>
  <tr> 
    <td>${question.caze.content!}</td>
  </tr>
	<#list (questionResult.itemResults?if_exists)?sort_by('item') as itemResult>
	<#assign item=itemResult.item>
  <tr> 
    <td class="grayStyle">${item.code!}、${item.description!}<font color="#FF0000">(${itemResult.mark!}分)</font></td>
  </tr>
  <tr> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="brightStyle">
    	<#list (item.options?if_exists)?sort_by("code") as option>
        <tr> 
          <td width="4%"><div align="center"> 
              <input type="checkBox"  disabled name="option${questionResult.code}_${item.id}" value="${option.code}" <#if (itemResult.result?index_of(option.code,0)!=-1)> checked</#if>>
          </td>
          <td width="96%">${option.code}、${option.description}</td>
        </tr>
        </#list>
      </table>
    </td>
  </tr>
  <tr><td><B>答案：${item.answer!}</B></td></tr>
  <tr><td><B>解析：${item.explain!}</B></td></tr>
  </#list>
</table>
	</td></tr>
	</#list>

	</table>
</body>