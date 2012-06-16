<#include "/template/head.ftl"/>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckeditor.js"></script>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckTextArea.js"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Validator.js"></script>
 <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Calendar.js"></script>
<body>
<#assign labInfo><@text name="课程信息" /></#assign>
<#include "/template/back.ftl"/>
  <table width="90%" align="center" class="formTable">
    <form action="lesson.action?method=save" name="lessonForm" method="post" onsubmit="return false;">
    <@searchParams/>
    <tr>
      <td width="20%" id="f_seqNo" class="title"><font color="red">*</font>课程编号:</td>
      <td width="30%">
      <input id="codeValue" type="text" name="lesson.seqNo" value="${lesson.seqNo?if_exists}" maxLength="32" style="width:100%;">
      <input type="hidden"  name="lesson.id" value="${lesson.id?if_exists}"/>
      </td>
      <td width="20%" id="f_coursename" class="title"><font color="red">*</font>课程名称:</td>
      <td width="30%"><input type="text" name="lesson.coursename" value="${lesson.coursename?if_exists}" maxLength="20" style="width:100%;"></td>
    </tr>
     <tr>
      <td width="20%" id="f_beginAt" class="title"><font color="red">*</font>开始时间:</td>
      <td width="30%">
      <input type="text" name="lesson.beginAt" maxlength="10" value="${(lesson.beginAt?string('yyyy-MM-dd'))?if_exists}" onfocus="calendar()"/>
       </td>
      <td width="20%" id="f_endAt" class="title"><font color="red">*</font>结束时间:</td>
      <td width="30%"><input type="text" name="lesson.endAt" maxlength="10" value="${(lesson.endAt?string('yyyy-MM-dd'))?if_exists}" onfocus="calendar()"/></td>
    </tr>
     <tr>
      <td width="20%" id="f_teacher" class="title"><font color="red">*</font>授课教师:</td>
      <td width="80%" colspan="3">
		<@htm.i18nSelect datas=teachers selected="${(lesson.teachers[0].id)?if_exists}" 
		 name="teacher.id" style="width:150px;"><option value=""></option>
		</@>
		<@htm.i18nSelect datas=teachers selected="${(lesson.teachers[1].id)?if_exists}" 
		 name="teacher.id" style="width:150px;"><option value=""></option>
		</@> 
		<@htm.i18nSelect datas=teachers selected="${(lesson.teachers[2].id)?if_exists}" 
		 name="teacher.id" style="width:150px;"><option value=""></option>
		</@>
      </td>
    </tr>
    <tr class="darkColumn" align="center">
      <td colspan="4">
          <input type="button" onClick='save(this.form)' value="<@text name="system.button.submit"/>" class="buttonStyle"/>       
          <input type="button" onClick='reset()' value="<@text name="system.button.reset"/>" class="buttonStyle"/>
      </td>
    </tr>
    </form> 
  </table>
  <br>  <br>  <br>  <br>  <br>  <br>  <br>  <br>  <br>  <br>
  <script language="javascript" > 
     function reset(){
         document.lessonForm.reset();
     }
    function save(form,params){
         var a_fields = {
         'lesson.seqNo':{'l':'<@text name="attr.code" />', 'r':true, 't':'f_seqNo'},
         'lesson.coursename':{'l':'<@text name="attr.name" />', 'r':true, 't':'f_coursename'},
        'lesson.beginAt':{'l':'开始时间', 'r':true, 't':'f_beginAt'},
         'lesson.endAt':{'l':'结束时间', 'r':true, 't':'f_endAt'}//,      
         //'teacher.id':{'l':'<@text name="attr.name" />', 'r':true, 't':'f_teacher'}
         };
		 var v = new validator(form , a_fields, null);
		 if (v.exec()) {
		    form.action="lesson.action?method=save";
		    if(null!=params)
		       form.action+=params;
		    form.submit();
		 }
   }
</script>
 </body> 
</html>
