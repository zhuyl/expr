 <#include "/template/head.ftl"/>
<body>
<table id="toolbar"></table>
<@table.table id="memberTable" width="80%" align="center">
 <@table.thead>
   <@table.td text=""/>
   <@table.td text="姓名"/>
   <@table.td text="性别"/>
   <@table.td text="年龄"/>
   <@table.td text="职业"/>
   <@table.td text="关系"/>
   <@table.td text="收入"/>
   <@table.td text="工作单位"/>
 </@>
 <@table.tbody datas=answers;answer>
   <@table.selectTd id="familyMemberAnswerId" value=answer.id type="radio"/>
   <td>${answer.member.name}</td>
   <td>${answer.member.gender.name}</td>
   <td>${answer.member.age!}</td>
   <td>${(answer.member.career.name)!}</td>
   <td>${(answer.member.relation.name)!}</td>
   <td>${answer.member.salary!}</td>
   <td>${answer.member.department!}</td>
   </@>
 </@>
 <#--
<table width="85%" border="0" class="listTable" align="center">
  <tr class="darkColumn" align="center"> 
    <td class="select"><input type="checkBox" id="paramsIdBox" class="box" onClick="toggleCheckBox(document.getElementsByName('paramsId'),event)"></td>
    <td></td>
    <td><div align="center"></div></td>
    <td><div align="center"></div></td>
    <td><div align="center"></div></td>
    <td><div align="center"></div></td>
    <td><div align="center"></div></td>
    <td></td>
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
-->
<@htm.actionForm name="actionForm" action="familyAnalysis.action" entity="familyMemberAnswer">
  <input type="hidden" name="caze.id" value="${Parameters['caze.id']}"/>
</@>
  <script language="javascript">
     var bar = new ToolBar("toolbar","家庭基本信息分析",null,true,true);
     bar.setMessage('<@getMessage/>');
     bar.addItem("添加","add()");
     bar.addItem("修改","edit()");
     bar.addItem("删除","remove()");
  </script>
</body>
 <#include "/template/foot.ftl"/>