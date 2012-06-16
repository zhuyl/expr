<#include "/template/head.ftl"/>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckeditor.js"></script>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckTextArea.js"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Validator.js"></script>
<body>
<#assign labInfo><@text name="案例信息" /></#assign>
<#include "/template/back.ftl"/>
  <table width="90%" align="center" class="formTable">
    <form action="caze.action?method=save" name="cazeForm" method="post" onsubmit="return false;">
    <@searchParams/>
    <tr>
      <td width="20%" id="f_code" class="title"><font color="red">*</font>案例编号:</td>
      <td width="30%">
      <input id="codeValue" type="text" name="caze.seq" value="${caze.seq?if_exists}" maxLength="32" style="width:100%;">
      <input type="hidden"  name="caze.id" value="${caze.id?if_exists}"/>
      </td>
      <td width="20%" id="f_name" class="title"><font color="red">*</font>案例名称:</td>
      <td width="30%"><input type="text" name="caze.name" value="${caze.name?if_exists}" maxLength="20" style="width:100%;"></td>
    </tr>
    <tr>  
      <td id="f_author" class="title"><font color="red">*</font>案例作者:</td>
      <td><input id="authorValue" type="text" name="caze.author" value="${caze.author?if_exists}" maxLength="32" style="width:100%;">
      <td id="f_lifeCycleType" class="title"><font color="red">*</font>客户生命周期类型:</td>
      <td><@htm.i18nSelect datas=lifeCycleTypes selected="${(caze.lifeCycleType.id)?if_exists}"  name="caze.lifeCycleType.id" style="width:100%;"><option value=""><@text name="common.all"/></option></@></td>
    </tr>
    <tr>
      <td class="title">案例内容:</td>
      <td colspan="4" height="400"><textarea cols="70" id="cazecontent" name="caze.content">${caze.content?if_exists}</textarea></td>
     </tr>
     <tr>
      <td class="title">社会经济状态:</td>
      <td colspan="4"><textarea rows="3" cols="70" id="cazesocialstate" name="caze.socialState">${caze.socialState?if_exists}</textarea></td>
     </tr>
     <tr>
      <td class="title">动态平衡约束条件:</td>
      <td colspan="4"><textarea rows="3" cols="70" id="cazedynaequilibrium" name="caze.dynaEquilibrium">${caze.dynaEquilibrium?if_exists}</textarea></td>
     </tr>
     <tr>
      <td class="title"><font color="red">*</font>动态平衡调整年度:</td>
      <td colspan="4">		 
       <select id="f_changeYear" name="caze.changeYear"  style="width:150px">
         <option value="">请选择动态平衡调整年度</option>
         <#list 1..30 as i>
          <#if i=(caze.changeYear!1)>
             <option value="${i}" selected>${i}</option>
             <#else>
             <option value="${i}">${i}</option>
           </#if>
         </#list>
         </select></td>
     </tr>
     <tr>
       <td class="title">客户风险承受态度:</td>
       <td colspan="4"><#list riskBearAttitudes as attr><input name="caze.riskBearAttitude.id" type="radio" value="${attr.id}" <#if attr.id=(caze.riskBearAttitude.id)?default(0)>checked</#if>>${attr.name}</#list></td>
     </tr>
     <tr>
       <td class="title">客户风险承受能力问卷:</td>
       <td colspan="4"><@htm.i18nSelect datas=questionnaires selected="${(caze.questionnaire.id)?if_exists}"  name="caze.questionnaire.id" style="width:50%;"><option value=""></option></@></td>
     </tr>
      <tr>
       <td class="title">是否向学生公开：</td>
       <td><@htm.radio2  name="caze.open" value=caze.open?default(false)/>
       </td>
       <td class="title">是否发布:</td>
       <td><@htm.radio2  name="caze.publish" value=caze.publish?default(false)/></td>       
     </tr>

    <tr>
      <td class="title">  <@text name="attr.dateCreated" />: </td>
      <td>${(caze.createdAt?string("yyyy-MM-dd"))?if_exists}</td>    
      <td class="title">  <@text name="attr.dateLastModified" />:</td>
      <td>${(caze.updatedAt?string("yyyy-MM-dd"))?if_exists}</td>
    </tr>
    <tr class="darkColumn" align="center">
      <td colspan="4">
          <input type="button" onClick='save(this.form)' value="<@text name="system.button.submit"/>" class="buttonStyle"/>
           <input type="button" onClick='reset()' value="<@text name="system.button.reset"/>" class="buttonStyle"/>
      </td>
    </tr>
    </form> 
  </table>
  <br>  <br>  <br>  <br>  <br>
  <script language="javascript" > 

     function reset(){
         document.cazeForm.reset();
     }
    function save(form,params){
         var a_fields = {
         'caze.seq':{'l':'<@text name="attr.code" />', 'r':true, 't':'f_code'},
         'caze.name':{'l':'<@text name="attr.name" />', 'r':true, 't':'f_name'},
         'caze.lifeCycleType.id':{'l':'客户生命周期类型', 'r':true, 't':'f_lifeCycleType'},
         'caze.changeYear':{'l':'动态平衡调整年份', 'r':true,'t':'f_changeYear','f':'unsigned'}
         };
		 var v = new validator(form , a_fields, null);
		 if (v.exec()) {
		    form.action="caze.action?method=save";
		    if(null!=params)
		       form.action+=params;
		    form.submit();
		 }
   }
initFCK("cazecontent","100%","100%");
</script>
 </body> 
</html>
