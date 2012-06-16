 <#include "/template/head.ftl"/>
<body>
<table id="taskBar"></table>
<script>
  var bar = new ToolBar('taskBar', '学习记录', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
  bar.addBack("<@text name="action.back"/>");  
</script>
<table width="85%" border="0" class="listTable" align="center">
  <tr class="darkColumn" align="center"> 
    <td><div align="center">开始学习时间</div></td>
    <td><div align="center">结束学习时间</div></td>
    <td><div align="center">在线学习时间</div></td>
    <td><div align="center">主机</div></td>
  </tr>
  <#assign time = 0 />
  <#list logs as log>
  <tr class="brightStyle" align="center" onMouseOver="swapOverTR(this,this.className)"onmouseout="swapOutTR(this)" onClick="onRowChange(event)"> 
    <td>${log.startAt?string("yyyy-MM-dd HH:mm")}</td>
    <td>${log.finishAt?string("yyyy-MM-dd HH:mm")}</td>
    <td>${(log.time/60)?int}分${(log.time%60)}秒</td>
    <td>${log.ip}</td>
    <#assign time=time+log.time/>
  </tr>
  </#list>
  <tr class="brightStyle" align="center" onMouseOver="swapOverTR(this,this.className)"onmouseout="swapOutTR(this)" onClick="onRowChange(event)"> 
    <td colspan="2">累计</td>
    <td>${(time/60)?int}分${(time%60)}秒</td>
    <td></td>
  </tr>
</table>

</body>
 <#include "/template/foot.ftl"/>