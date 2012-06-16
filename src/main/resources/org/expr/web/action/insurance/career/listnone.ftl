<#include "/template/head.ftl"/>
<BODY>
  <table id="toolbar"></table>
  <@getMessage/>
  <p>无职业表</P>
  <script language="javascript">
     var bar = new ToolBar("toolbar","职业列表",null,true,true);
     bar.addBack();
  </script>
</body>
<#include "/template/foot.ftl"/>