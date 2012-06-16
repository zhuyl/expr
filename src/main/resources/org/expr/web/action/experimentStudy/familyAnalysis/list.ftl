 <#include "/template/head.ftl"/>
<body>
<table id="taskBar"></table>
  <script language="javascript">
     var bar = new ToolBar("toolbar","家庭基本信息列表",null,true,true);
     bar.addItem("添加","add()");
     bar.addItem("修改","edit()");
     bar.addItem("删除","remove()");
  </script>
<table id="toolbar"></table>
  <@getMessage/>
<table width="85%" border="0" class="listTable" align="center">
  <tr class="darkColumn" align="center"> 
    <td class="select"><input type="checkBox" id="paramsIdBox" class="box" onClick="toggleCheckBox(document.getElementsByName('paramsId'),event)"></td>
    <td>姓名</td>
    <td><div align="center">性别</div></td>
    <td><div align="center">年龄</div></td>
    <td><div align="center">职业</div></td>
    <td><div align="center">关系</div></td>
    <td><div align="center">收入</div></td>
    <td>工作单位</td>
  </tr>
  <tr class="brightStyle" onMouseOver="swapOverTR(this,this.className)"onmouseout="swapOutTR(this)" onClick="onRowChange(event)"> 
    <td class="select>"><input class="box" name="paramsId" value="927" type="checkbox"></td>
    <td>zhangsan</td>
    <td><div align="center">boy</div></td>
    <td><div align="center">30</div></td>
    <td><div align="center">lawyer</div></td>
    <td><div align="center">father</div></td>
    <td><div align="center">5000</div></td>
    <td>bank</td>
  </tr>
  <tr class="grayStyle"onMouseOver="swapOverTR(this,this.className)"onmouseout="swapOutTR(this)" onClick="onRowChange(event)"> 
    <td height="17" class="select>"> <input class="box" name="paramsId" value="927" type="checkbox"></td>
    <td>wangwu</td>
    <td><div align="center">girl</div></td>
    <td><div align="center">25</div></td>
    <td><div align="center">officer</div></td>
    <td><div align="center">mather</div></td>
    <td><div align="center">3000</div></td>
    <td>school</td>
  </tr>
</table>

</body>
 <#include "/template/foot.ftl"/>