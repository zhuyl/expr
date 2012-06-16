<#include "/template/head.ftl"/>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckeditor.js"></script>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckTextArea.js"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Validator.js"></script>
 <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Calendar.js"></script>
<body>
<#assign labInfo><@text name="项目信息" /></#assign>
<#include "/template/back.ftl"/>
    <form action="assessItem!save.action" name="assessItemForm" method="post" onsubmit="return false;">
    <input type="hidden" name="assessment.id" value="${Parameters['assessment.id']}"/> 
     <input type="hidden"  name="assessItem.id" value="${assessItem.id!}"/>
    <@searchParams/>
    <table width="90%" align="center" class="formTable">
    <tr>
      <td width="20%" id="f_phase" class="title"><font color="red">*</font>分析阶段:</td>
      <td width="80%">
 <@htm.i18nSelect datas=analysisTables?sort_by(['code']) selected="${(assessItem.phase.id)?if_exists}" 
 name="assessItem.phase.id" style="width:50%;"><option value="">...</option></@>
      </td>
    </tr> 
     <tr>
      <td width="20%" id="f_excellent" class="title"><font color="red">*</font>优:</td>
      <td width="80%">
 <textarea cols="50" id="assessItem.excellent" name="assessItem.excellent">${assessItem.excellent?if_exists}</textarea>
      </td>
    </tr> 
    <tr>
      <td width="20%" id="f_good" class="title"><font color="red">*</font>良:</td>
      <td width="80%">
 <textarea cols="50" id="assessItem.good" name="assessItem.good">${assessItem.good?if_exists}</textarea>
      </td>
    </tr> 
    <tr>
      <td width="20%" id="f_middle" class="title"><font color="red">*</font>中:</td>
      <td width="80%">
 <textarea cols="50" id="assessItem.middle" name="assessItem.middle">${assessItem.middle?if_exists}</textarea>
      </td>
    </tr> 
    <tr>
      <td width="20%" id="f_pass" class="title"><font color="red">*</font>及格:</td>
      <td width="80%">
 <textarea cols="50" id="assessItem.pass" name="assessItem.pass">${assessItem.pass?if_exists}</textarea>
      </td>
    </tr> 
    <tr>
      <td width="20%" id="f_nopass" class="title"><font color="red">*</font>不及格:</td>
      <td width="80%">
 <textarea cols="50" id="assessItem.nopass" name="assessItem.nopass">${assessItem.nopass?if_exists}</textarea>
      </td>
    </tr> 
        <tr class="darkColumn" align="center">
      <td colspan="2">
          <input type="button" onClick='save(this.form)' value="<@text name="system.button.submit"/>" class="buttonStyle"/>       
          <input type="button" onClick='reset()' value="<@text name="system.button.reset"/>" class="buttonStyle"/>
      </td>
    </tr>
  </table>
  
      </form> 
  <br>  <br>  <br>  <br>  <br>  <br>  <br>  <br>  <br>  <br>
  <script language="javascript" > 

     function reset(){
         document.assessItemForm.reset();
     }
    function save(form){
         var a_fields = {
        'assessItem.phase.id':{'l':'分析阶段', 'r':true, 't':'f_phase'},
        'assessItem.excellent':{'l':'优', 'r':true, 't':'f_excellent'},        
        'assessItem.good':{'l':'良', 'r':true, 't':'f_good'},  
        'assessItem.middle':{'l':'中', 'r':true, 't':'f_middle'},  
        'assessItem.pass':{'l':'及格', 'r':true, 't':'f_good'},  
        'assessItem.nopass':{'l':'不及格', 'r':true, 't':'f_nopass'}
        };
		 var v = new validator(form , a_fields, null);
		 if (v.exec()) {
		    form.submit();
		 }
   }
</script>
 </body> 
</html>