 <#include "/template/head.ftl"/>
<body>
<table id="taskBar"></table>
<script>
  var bar = new ToolBar('taskBar', '家庭基本信息分析', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
  bar.addItem('添加', 'addFamilyMember()');
  bar.addItem('修改', 'editFamilyMember()');
  bar.addItem('删除', 'removeFamilyMember()');
</script>
<table width="85%" border="0" class="listTable" align="center">
  <tr class="darkColumn" align="center"> 
    <td class="select"><input type="checkBox" id="paramsIdBox" class="box" onClick="toggleCheckBox(document.getElementsByName('paramsId'),event)"></td>
    <td>姓名</td>
    <td><div align="center">性别</div></td>
    <td><div align="center">年龄</div></td>
    <td><div align="center">职业</div></td>
    <td><div align="center">家庭角色</div></td>
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
<script language="JavaScript" type="text/JavaScript" >
   function editFamilyMember(){
       id = getSelectIds("taskId");
       if(id=="") {alert("请选择家庭成员");return;}
       if(isMultiId(id)) {alert("请仅选择一个。");return;}
       form.action = "?method=edit&task.id=" + id;
       setSearchParams();
       form.submit();
    }
    function addFamilyMember(){
       form.action = "?method=selectCourse&calendar.studentType.id=" + parent.document.taskForm['calendar.studentType.id'].value;
       setSearchParams();
       form.submit();
    }
    function removeFamilyMember(){
       ids = getSelectIds("taskId");
       if(ids=="") {alert("请选择教学任务");return;}
       if(!checkConfirmIdSeq(ids)) return;
       if(confirm("将要删除选定的:"+countId(ids)+"个任务\n删除教学任务，将会级联删除对应的选课结果、课程安排等信息，且不可恢复。确认删除？")!=true)return;
       form.action="?method=remove&taskIds=" + ids;
       setSearchParams();
       form.submit();
    }
</script>
</body>
 <#include "/template/foot.ftl"/>