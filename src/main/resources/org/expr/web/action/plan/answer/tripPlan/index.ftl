 <#include "/template/head.ftl"/>
<body>
<table id="toolbar"></table>
<table class="formTable" align="center" width="80%">
	<form name="editForm" method="post" action="${base}/answer/tripPlan!saveRemark.action">
	<input type="hidden" name="caze.id" value="${Parameters['caze.id']}">
	<tr><td>旅游支出说明:
	<textarea id="noticeContent" name="remark"  style="font-size:10pt;width:100%;height:80px">${(answer.remark)!}</textarea>
 	</td></tr>
 	<tr><td align="right"><input value="提交" type="submit"></td></tr>
 </form>
</table>
 <#include "list.ftl"/>
  <script language="javascript">
     var bar = new ToolBar("toolbar","旅游规划",null,true,true);
     bar.setMessage('<@getMessage/>');
     bar.addBlankItem();
  </script>
</body>
 <#include "/template/foot.ftl"/>