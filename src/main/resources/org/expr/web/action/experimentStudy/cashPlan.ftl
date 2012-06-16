<#include "/template/head.ftl"/>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckeditor.js"></script>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckTextArea.js"></script>
<body>
<table id="taskBar"></table>
<script>
  var bar = new ToolBar('taskBar', '现金规划', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
  bar.addItem('保存', 'saveCashPlan()');
</script>
<table width="85%"  height="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td> <textarea id="noticeContent" name="notice.content.content"  style="font-size:10pt;width:100%;height:200px"></textarea></td>
  </tr>
</table>
<script>
initFCK("noticeContent","100%","100%");
</script>
</body>
<#include "/template/foot.ftl"/>