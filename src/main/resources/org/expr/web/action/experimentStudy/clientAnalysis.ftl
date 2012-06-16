<#include "/template/head.ftl"/>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckeditor.js"></script>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckTextArea.js"></script>
<body>
<table id="taskBar"></table>
<script>
  var bar = new ToolBar('taskBar', '客户分析综述', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
  bar.addItem('保存', 'saveCientAnalysis()');
</script>
<table width="85%" border="0" class="listTable" align="center">
      <tr class="darkColumn" align="center"> 
    <td height="18" colspan="2">主要财务指标</td>
  </tr>
        <tr> 
          <td class="darkColumn" align="center">资产负债比率</td>
          <td><div align="center">72.56%</div></td>
        </tr>
        <tr> 
          <td class="darkColumn" align="center">流动比率</td>
          <td><div align="center">72.18%</div></td>
        </tr>
        <tr> 
          <td class="darkColumn" align="center">储蓄比例</td>
          <td><div align="center">26.45%</div></td>
        </tr>       
         <tr> 
          <td class="darkColumn" align="center">流动资产比率</td>
          <td><div align="center">1.17%</div></td>
        </tr>
        <tr> 
          <td class="darkColumn" align="center">财务自由度</td>
          <td><div align="center">39.93%</div></td>
        </tr>
        <tr> 
          <td class="darkColumn" align="center">平均投资报酬率</td>
          <td><div align="center">3.42%</div></td>
        </tr> 
        <tr> 
          <td class="darkColumn" align="center">自由储蓄率</td>
          <td><div align="center">17.28%%</div></td>
        </tr>        
</table>
<table width="85%" height="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td> <textarea id="noticeContent" name="notice.content.content"  style="font-size:10pt;width:100%;height:200px"></textarea></td>
  </tr>
</table>
<script>
initFCK("noticeContent","100%","100%");
</script>
</body>
<#include "/template/foot.ftl"/>