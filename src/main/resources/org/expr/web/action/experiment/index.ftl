 <#include "/template/head.ftl"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td>
                <#include "../teacherLesson/lessonNav.ftl"/>
                  </td>
              </tr>  
 			  <tr>
			    <td height="34"> 
<table id="taskBar"></table>
<script>
  var bar = new ToolBar('taskBar', '${lesson.coursename}实验列表', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
  bar.addItem("添加","add()");
</script>
			  </td>
			  </tr>		  
              <tr>
                <td>
 <@table.table width="100%" sortable="true" id="noticeTable" style="word-break: break-all">
     <@table.thead>
	    <@table.td text="实验编号"/>
	    <@table.td text="实验名称"/>
	    <@table.td text="实验类型"/>
	    <@table.td text="开始学习时间"/>
	    <@table.td text="结束学习时间"/>
	    <@table.td text="实验指导"/>	  
	    <@table.td text="查看答案"/>	   
	    <@table.td text="修改"/>
	    <@table.td text="删除"/>	   	    
	   </@>
	   <@table.tbody datas=experiments;experiment>               
                             <td>${experiment.code}</td>
                            <td><a href="experiment.action?method=info&experimentId=${experiment.id}">${experiment.name}</a></td>
                            <td>${experiment.type.name} </td>
                            <td>${experiment.beginAt?string("yyyy-MM-dd HH:mm")}</td>
                            <td>${experiment.endAt?string("yyyy-MM-dd HH:mm")}</td>
                            <td><a href="experiment!studentList.action?experimentId=${experiment.id}&lesson.id=${experiment.lesson.id}&orderBy=student.code asc">实验指导</a></td>
                            <td><a target="_blank" href="experiment!answers.action?caze.id=${experiment.caze.id}">查看答案</a></td>  
                            <td><a href="experiment!edit.action?experimentId=${experiment.id}">修改</a></td>  
                            <td><a href="#" onclick="remove(${experiment.id})">删除</a></td>                     
      </@>
 </@>               
</td>
</tr>
 </table>
 
 <form name="actionForm" method="post" action="experiment.action?method=remove">
    <input name="experimentId" value="" type="hidden"/>
    <input name="params" value="&lesson.id=${lesson.id}" type="hidden"/>
 </form>
<script>
  function add(){
  document.actionForm.action="experiment!edit.action?lessonId=${lesson.id}";
         document.actionForm.submit();
  }

  function remove(id){
      if(confirm("确定删除改实验?")){
         document.actionForm['experimentId'].value=id;
         document.actionForm.submit();
      }
  }
</script>