<#include "/template/head.ftl"/>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckeditor.js"></script>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckTextArea.js"></script>
<body>
<table id="taskBar"></table>
<script>
  var bar = new ToolBar('taskBar', '风险管理与保险规划', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
  bar.addItem('添加', 'addInsurance()');
  bar.addItem('修改', 'editInsurance()');
  bar.addItem('删除', 'removeInsurance()');
</script>
<table width="85%" border="0" class="listTable" align="center">
  <tr class="darkColumn" align="center"> 
    <td class="select"><input type="checkBox" id="paramsIdBox" class="box" onClick="toggleCheckBox(document.getElementsByName('paramsId'),event)"></td>
    <td><div align="center">产品名称</div></td>
    <td><div align="center">被保险人姓名</div></td>
    <td><div align="center">性别</div></td>
    <td><div align="center">年龄</div></td>
    <td><div align="center">保险类型</div></td>
    <td><div align="center">保额（万）</div></td>
  </tr>
  <tr class="brightStyle" onMouseOver="swapOverTR(this,this.className)"onmouseout="swapOutTR(this)" onClick="onRowChange(event)"> 
    <td class="select>"><input class="box" name="paramsId" value="927" type="checkbox"></td>
    <td><div align="center">定期寿险</div></td>
    <td><div align="center">小刘</div></td>
    <td><div align="center">男</div></td>
    <td><div align="center">30</div></td>
    <td><div align="center">保险类型</div></td>
    <td><div align="center">10</div></td>
  </tr>
</table>
<script language="JavaScript" type="text/JavaScript" >
   function editInsurance(){
       id = getSelectIds("taskId");
       if(id=="") {alert("请选择家庭成员");return;}
       if(isMultiId(id)) {alert("请仅选择一个。");return;}
       form.action = "?method=edit&task.id=" + id;
       setSearchParams();
       form.submit();
    }
    function addInsurance(){
       form.action = "?method=selectCourse&calendar.studentType.id=" + parent.document.taskForm['calendar.studentType.id'].value;
       setSearchParams();
       form.submit();
    }
    function removeInsurance(){
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