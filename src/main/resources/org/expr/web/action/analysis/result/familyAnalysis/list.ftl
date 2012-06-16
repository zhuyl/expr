<#include "/template/head.ftl"/>
<body>
<table id="toolbar"></table>
<table class="formTable" align="center" width="80%">
	<form name="editForm" method="post" action="${base}/result/familyAnalysis!saveRemark.action">
	<input type="hidden" name="experiment.id" value="${Parameters['experiment.id']}">
	<tr><td>家庭基本信息分析说明:
	<textarea id="noticeContent" name="remark"  style="font-size:10pt;width:100%;height:80px">${(analysisResult.remark)!}</textarea>
 	</td></tr>
 	<tr><td align="right"><input value="提交" type="submit"></td></tr>
 </form>
<@table.table id="memberTable" width="80%" align="center">
 <@table.thead>
   <@table.selectAllTd id="familyMemberResultId" />
   <@table.td text="姓名"/>
   <@table.td text="性别"/>
   <@table.td text="年龄"/>
   <@table.td text="出生日期"/>
   <@table.td text="职业"/>
   <@table.td text="家庭关系"/>
   <@table.td text="收入（元）"/>
   <@table.td text="工作单位"/>
 </@>
 <@table.tbody datas=results;result>
   <@table.selectTd id="familyMemberResultId" value=result.id type="checkbox"/>
   <td>${result.member.name}</td>
   <td>${result.member.gender.name}</td>
   <td>${result.member.age!}</td>
   <td>${(result.member.birthday?string('yyyy-MM-dd'))?if_exists}</td>  
   <td>${(result.member.career.parent.parent.name)}|${(result.member.career.parent.name)}|${(result.member.career.name)!}</td>
   <td>${(result.member.relation.name)!}</td>
   <td>${result.member.salary!}</td>
   <td>${result.member.department!}</td>
   </@>
 </@>
<@htm.actionForm name="actionForm" action="familyAnalysis.action" entity="familyMemberResult">
  <input type="hidden" name="experiment.id" value="${Parameters['experiment.id']}"/>
</@>
  <script language="javascript">
     var bar = new ToolBar("toolbar","家庭基本信息分析",null,true,true);
     bar.setMessage('<@getMessage/>');
     bar.addItem("添加","add()");
     bar.addItem("修改","edit()");
     bar.addItem("删除","remove()");
  </script>
</body>
 <#include "/template/foot.ftl"/>