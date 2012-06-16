<#include "/template/head.ftl"/>
<table id="taskBar"></table>
<script>
  var bar = new ToolBar('taskBar', '客户风险承受能力分析', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
  bar.addItem('保存', 'saveRiskAnalysis()');
</script>
<table width="85%" border="0" align="center" cellpadding="0" cellspacing="0" class='listTable'>
  <tr> 
    <td class="grayStyle">1、就业状况</td>
  </tr>
  <tr> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="brightStyle">
        <tr> 
          <td width="4%"><div align="center"> 
              <input type="radio" name="radiobutton" value="radiobutton">
            </div></td>
          <td width="96%">公教人员</td>
        </tr>
        <tr> 
          <td><div align="center"> 
              <input type="radio" name="radiobutton" value="radiobutton">
            </div></td>
          <td>上班族</td>
        </tr>
        <tr> 
          <td><div align="center"> 
              <input type="radio" name="radiobutton" value="radiobutton">
            </div></td>
          <td>佣金收入者</td>
        </tr>
        <tr> 
          <td><div align="center"> 
              <input type="radio" name="radiobutton" value="radiobutton">
            </div></td>
          <td>自营失业者</td>
        </tr>
        <tr> 
          <td><div align="center"> 
              <input type="radio" name="radiobutton" value="radiobutton">
            </div></td>
          <td>失业</td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
      </table></td>
  </tr>
</table>
<#include "/template/foot.ftl"/>