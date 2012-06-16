<#include "/template/head.ftl"/>
<body>
<table id="taskBar"></table>
<script>
  var bar = new ToolBar('taskBar', '保险资产明细分析', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
  bar.addItem('添加', 'addInsuranceDetail()');
  bar.addItem('修改', 'editInsuranceDetail()');
  bar.addItem('删除', 'removeInsuranceDetail()');
</script>
<table width="85%" border="0" class="listTable" align="center">
  <tr class="darkColumn" align="center"> 
    <td width="4%" class="select"><input type="checkBox" id="paramsIdBox" class="box" onClick="toggleCheckBox(document.getElementsByName('paramsId'),event)"></td>
    <td width="9%">保单编号</td>
    <td width="10%">保险公司</td>
    <td width="9%">被保险人、物</td>
    <td width="12%">主契约险种</td>
    <td width="7%">主契约保额</td>
    <td width="14%">主契约年保费</td>
    <td width="13%">缴费年限</td>
    <td width="22%">详细</td>
  </tr>
  <tr class="brightStyle" onMouseOver="swapOverTR(this,this.className)"onmouseout="swapOutTR(this)" onClick="onRowChange(event)"> 
    <td class="select>"><input class="box" name="paramsId" value="927" type="checkbox"></td>
    <td>zhangsan</td>
    <td>boy</td>
    <td>30</td>
    <td>lawyer</td>
    <td><div align="center">father</div></td>
    <td><div align="center">5000</div></td>
    <td><div align="center">bank</div></td>
    <td><div align="center">详细</div></td>
  </tr>
  <tr class="grayStyle"onMouseOver="swapOverTR(this,this.className)"onmouseout="swapOutTR(this)" onClick="onRowChange(event)"> 
    <td class="select>"><input class="box" name="paramsId" value="927" type="checkbox"></td>
    <td>wangwu</td>
    <td>girl</td>
    <td>25</td>
    <td>officer</td>
    <td><div align="center">mather</div></td>
    <td><div align="center">3000</div></td>
    <td><div align="center">school</div></td>
    <td><div align="center">详细</div></td>
  </tr>
</table>
</body>
<#include "/template/foot.ftl"/>