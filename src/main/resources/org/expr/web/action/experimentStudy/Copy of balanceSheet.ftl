<#include "/template/head.ftl"/>
<body>
<table id="taskBar"></table>
<script>
  var bar = new ToolBar('taskBar', '家庭资产负债分析', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
  bar.addItem('保存', 'saveBalanceSheet()');
</script>
<table width="85%" border="0" align="center" cellpadding="0" cellspacing="0" class="listTable">
  <tr height="22"> 
    <td colspan="2" class="darkColumn"> <div align="center">资产</div></td>
    <td colspan="2" class="darkColumn"> <div align="center">负债</div></td>
  </tr>
  <tr height="22"> 
    <td width="25%" class="darkColumn"> <div align="center">资产项目</div></td>
    <td width="25%" class="darkColumn"> <div align="center">金额</div></td>
    <td width="25%" class="darkColumn"> <div align="center">资产项目</div></td>
    <td width="25%" class="darkColumn"> <div align="center">金额</div></td>
  </tr>
  <tr height="22"> 
    <td class="grayStyle">现金</td>
    <td class="brightStyle"><input name="student.name252" type="text" value="100" style="width:100%"/></td>
    <td class="grayStyle">房屋贷款</td>
    <td class="brightStyle"><input name="student.name2527" type="text" value="100" style="width:100%"/></td>
  </tr>
  <tr height="22"> 
    <td class="grayStyle">活期存款</td>
    <td class="brightStyle"><input name="student.name25" type="text" value="100" style="width:100%"/></td>
    <td class="grayStyle">汽车贷款</td>
    <td class="brightStyle"><input name="student.name2526" type="text" value="100" style="width:100%"/></td>
  </tr>
  <tr height="22"> 
    <td class="grayStyle">其他</td>
    <td class="brightStyle"><input name="student.name253" type="text" value="100" style="width:100%"/></td>
    <td class="grayStyle">其他</td>
    <td class="brightStyle"><input name="student.name2525" type="text" value="100" style="width:100%"/></td>
  </tr>
  <tr height="22"> 
    <td class="grayStyle"><strong>流动性资产</strong></td>
    <td class="brightStyle"><input name="student.name254" type="text" value="100" style="width:100%"/></td>
    <td class="grayStyle"><strong>长期贷款</strong></td>
    <td class="brightStyle"><input name="student.name2524" type="text" value="100" style="width:100%"/></td>
  </tr>
  <tr height="22"> 
    <td class="grayStyle">定期存款</td>
    <td class="brightStyle"><input name="student.name255" type="text" value="100" style="width:100%"/></td>
    <td class="grayStyle">信用卡透支</td>
    <td class="brightStyle"><input name="student.name2523" type="text" value="100" style="width:100%"/></td>
  </tr>
  <tr height="22"> 
    <td class="grayStyle">基金</td>
    <td class="brightStyle"><input name="student.name256" type="text" value="100" style="width:100%"/></td>
    <td class="grayStyle">其他</td>
    <td class="brightStyle"><input name="student.name2522" type="text" value="100" style="width:100%"/></td>
  </tr>
  <tr height="22"> 
    <td class="grayStyle">国债</td>
    <td class="brightStyle"><input name="student.name257" type="text" value="100" style="width:100%"/></td>
    <td class="grayStyle"><strong>短期贷款</strong></td>
    <td class="brightStyle"><input name="student.name2521" type="text" value="100" style="width:100%"/></td>
  </tr>
  <tr height="22"> 
    <td class="grayStyle">企业债券</td>
    <td class="brightStyle"><input name="student.name258" type="text" value="100" style="width:100%"/></td>
    <td class="grayStyle">&nbsp;</td>
    <td class="brightStyle">&nbsp;</td>
  </tr>
  <tr height="22"> 
    <td class="grayStyle">股票</td>
    <td class="brightStyle"><input name="student.name259" type="text" value="100" style="width:100%"/></td>
    <td class="grayStyle">&nbsp;</td>
    <td class="brightStyle">&nbsp;</td>
  </tr>
  <tr height="22"> 
    <td class="grayStyle">保险</td>
    <td class="brightStyle"><input name="student.name2510" type="text" value="100" style="width:100%"/></td>
    <td class="grayStyle">&nbsp;</td>
    <td class="brightStyle">&nbsp;</td>
  </tr>
  <tr height="22"> 
    <td class="grayStyle">其他</td>
    <td class="brightStyle"><input name="student.name2511" type="text" value="100" style="width:100%"/></td>
    <td class="grayStyle">&nbsp;</td>
    <td class="brightStyle">&nbsp;</td>
  </tr>
  <tr height="22"> 
    <td class="grayStyle"><strong>投资性资产</strong></td>
    <td class="brightStyle"><input name="student.name2512" type="text" value="100" style="width:100%"/></td>
    <td class="grayStyle">&nbsp;</td>
    <td class="brightStyle">&nbsp;</td>
  </tr>
  <tr height="22"> 
    <td class="grayStyle">汽车</td>
    <td class="brightStyle"><input name="student.name2513" type="text" value="100" style="width:100%"/></td>
    <td class="grayStyle">&nbsp;</td>
    <td class="brightStyle">&nbsp;</td>
  </tr>
  <tr height="22"> 
    <td class="grayStyle">房屋</td>
    <td class="brightStyle"><input name="student.name2514" type="text" value="100" style="width:100%"/></td>
    <td class="grayStyle">&nbsp;</td>
    <td class="brightStyle">&nbsp;</td>
  </tr>
  <tr height="22"> 
    <td class="grayStyle">家具</td>
    <td class="brightStyle"><input name="student.name2515" type="text" value="100" style="width:100%"/></td>
    <td class="grayStyle">&nbsp;</td>
    <td class="brightStyle">&nbsp;</td>
  </tr>
  <tr height="22"> 
    <td class="grayStyle">其他</td>
    <td class="brightStyle"><input name="student.name2516" type="text" value="100" style="width:100%"/></td>
    <td class="grayStyle">&nbsp;</td>
    <td class="brightStyle">&nbsp;</td>
  </tr>
  <tr height="22"> 
    <td class="grayStyle"><strong>自用性资产</strong></td>
    <td class="brightStyle"><input name="student.name2517" type="text" value="100" style="width:100%"/></td>
    <td class="grayStyle">&nbsp;</td>
    <td class="brightStyle">&nbsp;</td>
  </tr>
  <tr height="22"> 
    <td class="grayStyle"><strong>总资产</strong></td>
    <td class="brightStyle"><input name="student.name2518" type="text" value="100" style="width:100%"/></td>
    <td class="grayStyle"><strong>总负债</strong></td>
    <td class="brightStyle"><input name="student.name2520" type="text" value="100" style="width:100%"/></td>
  </tr>
  <tr height="22"> 
    <td class="grayStyle"><strong>总净值</strong></td>
    <td colspan="3" class="brightStyle"><input name="student.name2519" type="text" value="100" style="width:100%"/></td>
  </tr>
</table>
</body>
<#include "/template/foot.ftl"/>