 <#include "/template/head.ftl"/>
<body>
<table id="taskBar"></table>
<script>
  var bar = new ToolBar('taskBar', '本实验学习记录', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
  bar.addBlankItem();
</script>
<table width="85%" border="0" class="listTable" align="center">
  <tr class="darkColumn" align="center"> 
    <td><div align="center">开始学习时间</div></td>
    <td><div align="center">结束学习时间</div></td>
    <td><div align="center">在线学习时间</div></td>
    <td><div align="center">主机</div></td>
  </tr>
  <tr class="brightStyle" onMouseOver="swapOverTR(this,this.className)"onmouseout="swapOutTR(this)" onClick="onRowChange(event)"> 
    <td>zhangsan</td>
    <td><div align="center">boy</div></td>
    <td><div align="center">30</div></td>
    <td><div align="center">lawyer</div></td>
  </tr>
  <tr class="grayStyle"onMouseOver="swapOverTR(this,this.className)"onmouseout="swapOutTR(this)" onClick="onRowChange(event)"> 
    <td height="17">wangwu</td>
    <td><div align="center">girl</div></td>
    <td><div align="center">25</div></td>
    <td><div align="center">officer</div></td>
  </tr>
</table>

</body>
 <#include "/template/foot.ftl"/>