<#include "/template/head.ftl"/>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckTextArea.js"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Validator.js"></script>
<body>
<#assign labInfo><@text name="题目信息" /></#assign>
<#include "/template/back.ftl"/>
  <table width="90%" align="center" class="formTable">
    <form action="examQuestion!save.action" name="examQuestionForm" method="post" onsubmit="return false;">
    <@searchParams/>
     <tr>
      <td width="20%" id="f_code" class="title"><font color="red">*</font>题目序号：</td>
      <td width="80%">
      <input type="text" name="examQuestion.code" maxlength="50" value="${examQuestion.code!}" style="width:100%;"/>
      </td>
    </tr>
    <tr>
      <td width="20%" id="f_name" class="title"><font color="red">*</font>题目名称：</td>
      <td width="80%">
      <input id="codeValue" type="text" name="examQuestion.name" value="${examQuestion.name?if_exists}" maxLength="50" style="width:100%;">
      <input type="hidden"  name="examQuestion.id" value="${examQuestion.id!}"/>
      </td>
    </tr>
     <tr>
      <td width="20%" id="f_introduction" class="title">题目导语：</td>
      <td width="80%">
      <textarea cols="50" id="detail" name="examQuestion.introduction">${examQuestion.introduction?if_exists}</textarea>      </td>
    </tr>   
    <tr>
      <td width="20%" id="f_author" class="title">题目作者：</td>
      <td width="80%">
      <input type="text" name="examQuestion.author" maxlength="50" value="${examQuestion.author!}" style="width:100%;"/>
      </td>
    </tr>
    <tr>
      <td class="title" id="f_caze"><font color="red">*</font>题目案例：</td>
      <td width="80%"><input type="text" name="examQuestion.caze.name" id="dcy" value="${(examQuestion.caze.name)?if_exists}" style="width:70%;" readonly>     	     		
		<input type="button" name="choosecaze" value="选择" class="buttonStyle" onClick="doSelectCaze(this.form)"/>
		<input type="button" value="清空" class="buttonStyle" onClick="doClearCaze(this.form)"/>				<div id="sb"></div>
	   <input type="hidden" name="caze.id"  value="${(examQuestion.caze.id)?if_exists}"/>
		</td>
     </tr>
    <tr class="darkColumn" align="center">
      <td colspan="2">
          <input type="button" onClick='save(this.form)' value="<@text name="system.button.submit"/>" class="buttonStyle"/>       
          <input type="button" onClick='reset()' value="<@text name="system.button.reset"/>" class="buttonStyle"/>
      </td>
    </tr>
    </form> 
  </table>
  <br>  <br>  <br>  <br>  <br>  <br>  <br>  <br>  <br>  <br>
  <script language="javascript" > 
     function reset(){
         document.examQuestionForm.reset();
     }
    function save(form){
         var a_fields = {
         'examQuestion.code':{'l':'题目序号', 'r':true, 't':'f_code'},
         'examQuestion.name':{'l':'题目名称', 'r':true, 't':'f_name'},
         'examQuestion.caze.name':{'l':'题目案例', 'r':true, 't':'f_caze'}     
         };
		 var v = new validator(form , a_fields, null);
		 if (v.exec()) {
		    form.submit();
		 }
   }
   function doSetCaze(cazeid,cazename)
		{
         document.examQuestionForm['examQuestion.caze.name'].value=cazename;
         document.examQuestionForm['caze.id'].value=cazeid;
        }
function doSelectCaze(form){
       
	   url='${base}/caze.do?method=cazeQuery';
	   window.open(url, '案例信息', 'scrollbars=yes,width=750,height=650,status=yes,titlebar=no');
	}
    function doClearCaze(form){
       	document.examQuestionForm['examQuestion.caze.name'].value='';
        document.examQuestionForm['caze.id'].value='';   
	}  
</script>
 </body> 
</html>