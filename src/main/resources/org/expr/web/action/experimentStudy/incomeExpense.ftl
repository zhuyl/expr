<#include "/template/head.ftl"/>
<table id="taskBar"></table>
<script>
  var bar = new ToolBar('taskBar', '家庭月度收支分析', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
  bar.addItem('保存', 'saveIncomeExpense()');
</script>
<table width="85%" border="0" align="center" cellpadding="0" cellspacing="0" class="listTable">
  <tr height="22"> 
    <td colspan="2" class="darkColumn"> <div align="center">收入</div></td>
    <td colspan="2" class="darkColumn"> <div align="center">支出</div></td>
  </tr>
  <tr height="22"> 
    <td width="25%" class="darkColumn"> <div align="center">收入项目</div></td>
    <td width="25%" class="darkColumn"> <div align="center">金额</div></td>
    <td width="25%" class="darkColumn"> <div align="center">支出项目</div></td>
    <td width="25%" class="darkColumn"> <div align="center">金额</div></td>
  </tr>
  <tr height="22"> 
    <td class="grayStyle">薪资</td>
    <td class="brightStyle"><input name="student.name252" type="text" value="100" style="width:100%"/></td>
    <td class="grayStyle">日常支出</td>
    <td class="brightStyle"><input name="student.name2527" type="text" value="100" style="width:100%"/></td>
  </tr>
  <tr height="22"> 
    <td class="grayStyle">奖金</td>
    <td class="brightStyle"><input name="student.name25" type="text" value="100" style="width:100%"/></td>
    <td class="grayStyle">教育支出</td>
    <td class="brightStyle"><input name="student.name2526" type="text" value="100" style="width:100%"/></td>
  </tr>
  <tr height="22"> 
    <td class="grayStyle">其他</td>
    <td class="brightStyle"><input name="student.name253" type="text" value="100" style="width:100%"/></td>
    <td class="grayStyle">医疗支出</td>
    <td class="brightStyle"><input name="student.name2525" type="text" value="100" style="width:100%"/></td>
  </tr>
  <tr height="22"> 
    <td class="grayStyle"><strong>工作收入</strong></td>
    <td class="brightStyle"><input name="student.name254" type="text" value="100" style="width:100%"/></td>
    <td class="grayStyle">房屋贷款</td>
    <td class="brightStyle"><input name="student.name2524" type="text" value="100" style="width:100%"/></td>
  </tr>
  <tr height="22"> 
    <td class="grayStyle">利息收入</td>
    <td class="brightStyle"><input name="student.name255" type="text" value="100" style="width:100%"/></td>
    <td class="grayStyle">汽车贷款</td>
    <td class="brightStyle"><input name="student.name2523" type="text" value="100" style="width:100%"/></td>
  </tr>
  <tr height="22"> 
    <td class="grayStyle">投资收入</td>
    <td class="brightStyle"><input name="student.name256" type="text" value="100" style="width:100%"/></td>
    <td class="grayStyle">其他</td>
    <td class="brightStyle"><input name="student.name2522" type="text" value="100" style="width:100%"/></td>
  </tr>
  <tr height="22"> 
    <td class="grayStyle">其他</td>
    <td class="brightStyle"><input name="student.name257" type="text" value="100" style="width:100%"/></td>
    <td class="grayStyle"><strong>经常性支出</strong></td>
    <td class="brightStyle"><input name="student.name2521" type="text" value="100" style="width:100%"/></td>
  </tr>
  <tr height="22"> 
    <td class="grayStyle"><strong>理财收入</strong></td>
    <td class="brightStyle"><input name="student.name258" type="text" value="100" style="width:100%"/></td>
    <td class="grayStyle">保费支出</td>
    <td class="brightStyle"><input name="student.name25212" type="text" value="100" style="width:100%"/></td>
  </tr>
  <tr height="22"> 
    <td class="grayStyle">&nbsp;</td>
    <td class="brightStyle">&nbsp;</td>
    <td class="grayStyle">其他</td>
    <td class="brightStyle"><input name="student.name25213" type="text" value="100" style="width:100%"/></td>
  </tr>
  <tr height="22"> 
    <td class="grayStyle">&nbsp;</td>
    <td class="brightStyle">&nbsp;</td>
    <td class="grayStyle">非经常性支出</td>
    <td class="brightStyle"><input name="student.name25214" type="text" value="100" style="width:100%"/></td>
  </tr>
  <tr height="22"> 
    <td class="grayStyle"><strong>总收入</strong></td>
    <td class="brightStyle"><input name="student.name2518" type="text" value="100" style="width:100%"/></td>
    <td class="grayStyle"><strong>总支出</strong></td>
    <td class="brightStyle"><input name="student.name2520" type="text" value="100" style="width:100%"/></td>
  </tr>
  <tr height="22"> 
    <td class="grayStyle"><strong>总结余</strong></td>
    <td colspan="3" class="brightStyle"><input name="student.name2519" type="text" value="100" style="width:100%"/></td>
  </tr>
</table>
<#include "/template/foot.ftl"/>