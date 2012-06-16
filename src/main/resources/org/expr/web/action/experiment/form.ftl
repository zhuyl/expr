<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Validator.js"></script>
 <script language="JavaScript" type="text/JavaScript" src="/skaily/static/scripts/My97DatePicker/WdatePicker.js"></script>
<body>
<#assign labInfo><@text name="学习任务信息"/></#assign>
<#include "/template/back.ftl"/>
    <form action="experiment.action?method=save" name="experimentForm" method="post">
  <table width="90%" align="center" class="formTable">
    <tr class="darkColumn">
      <td colspan="4"><B><strong><span class="redtext">${experiment.lesson.coursename}</span></strong>学习任务信息</B></td>
    </tr>
    <tr>
      <td width="20%" id="f_code" class="title"><font color="red">*</font>实验编号:</td>
      <td width="30%">
      <input id="codeValue" type="text" name="experiment.code" value="${experiment.code?if_exists}" maxLength="32" style="width:100%;">
      <input type="hidden"  name="experiment.id" value="${experiment.id?if_exists}"/>
      <#if experiment.id?exists><#else>
      <input type="hidden"  name="experiment.lesson.id" value="${Parameters['lessonId']?if_exists}"/>
      </#if>
      <input type="hidden"  name="experiment.compulsory" value="1"/>
      </td>
      <td width="20%" id="f_name" class="title"><font color="red">*</font>实验名称:</td>
      <td width="30%"><input type="text" name="experiment.name" value="${experiment.name?if_exists}" maxLength="20" style="width:100%;"></td>
    </tr>
    <tr>
      <td width="20%" id="f_beginAt" class="title"><font color="red">*</font>实验开始时间:</td>
      <td width="30%">
      <input type="text" name="experiment.beginAt" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})"  class="Wdate"  value="${(experiment.beginAt?string('yyyy-MM-dd  HH:mm'))?if_exists}" />
       </td>
      <td width="20%" id="f_endAt" class="title"><font color="red">*</font>实验结束时间:</td>
      <td width="30%"><input type="text" name="experiment.endAt"   value="${(experiment.endAt?string('yyyy-MM-dd  HH:mm'))?if_exists}" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})"  class="Wdate" /></td>
    </tr>
    <tr>
      <td width="20%" id="f_type" class="title"><font color="red">*</font>实验类型:</td>
      <td width="30%">
      <#list experimentTypes as attr><input name="experiment.type.id" type="radio" value="${attr.id}" <#if attr.id=(experiment.type.id)?default(0)>checked</#if>>${attr.name}</#list>
       </td>
      <td width="20%" id="f_publish" class="title"><font color="red">*</font>是否公布答案:</td>
      <td width="30%"><@htm.radio2  name="experiment.publish" value=experiment.publish?default(false)/></td>
    </tr>
    <tr>
      <td class="title">实验目标:</td>
      <td colspan="3"><textarea rows="5" cols="70" id="experimentaim" name="experiment.aim">${experiment.aim?if_exists}</textarea></td>
     </tr>
     <tr>
      <td class="title">实验指导:</td>
      <td colspan="3"><textarea rows="5" cols="70" id="experimentcoach" name="experiment.coach">${experiment.coach?if_exists}</textarea></td>
     </tr>
     <tr>
      <td class="title" id="f_assessment"><font color="red">*</font>评估标准:</td>
      <td colspan="3"><@htm.i18nSelect datas=assessments selected="${(experiment.assessment.id)?if_exists}"  name="experiment.assessment.id" style="width:50%;"><option value=""></option></@></td>
     </tr>
    <tr>
      <td width="20%" id="f_publish" class="title"><font color="red">*</font>是否公布分数:</td>
      <td width="30%"><@htm.radio2  name="experiment.publishScore" value=experiment.publishScore?default(false)/></td>
    </tr>
     <tr>
      <td class="title" id="f_caze"><font color="red">*</font>选择案例：</td>
      <td colspan="3"><input type="text" name="experiment.caze.name" id="dcy" value="${(experiment.caze.name)?if_exists}" readonly>     	     		
		<input type="button" name="choosecaze" value="选择" class="buttonStyle" onClick="doSelectCaze(this.form)"/>
		<input type="button" value="清空" class="buttonStyle" onClick="doClearCaze(this.form)"/>				<div id="sb"></div>
	   <input type="hidden" name="caze.id"  value="${(experiment.caze.id)?if_exists}"/>
		</td>
     </tr>
     <tr class="darkColumn">
       <td colspan="2" align="center"><B>分析内容</B> </td>
        <td colspan="2" align="center"><B>阶段得分</B> </td>      
     </tr>
     <#list analysisTables?sort_by(["code"]) as analysistable>
       <#assign mark=(experiment.getMark(analysistable))?if_exists/>
      <tr>
       <td colspan="2" id="f_analysis_${analysistable.id}">
            <input type="checkbox" name="analysisId" onclick="enableMark(${analysistable.id},this)" value="${analysistable.id}" <#if (mark.id)?exists>checked</#if>>${analysistable.phase.name}-${analysistable.name}
       </td>
       <td colspan="2"><input type="text" class=inputBox name="${analysistable.id}mark" <#if mark.mark?exists><#else>disabled</#if> value="${(mark.mark)?if_exists}" maxlength='3'></td>
     </tr>
      </#list>
    <tr class="darkColumn" align="center">
      <td colspan="4">
          <input type="button" onClick='save(this.form);' value="<@text name="system.button.submit"/>" class="buttonStyle"/>
          <input type="button" onClick='reset()' value="<@text name="system.button.reset"/>" class="buttonStyle"/>
      </td>
    </tr>
  </table>
 </form> 
  <br>  <br>  <br>  <br>  <br>
  <script language="javascript" > 
     function reset(){
         document.experimentForm.reset();
     }
     function enableMark(analysisId,checkbox){
        var form =document.experimentForm;
        if(checkbox.checked){
        	form[analysisId+"mark"].disabled=false;
        }else{
        	form[analysisId+"mark"].disabled=true;
        }
     }
    function save(form){
         var a_fields = {
         'experiment.code':{'l':'<@text name="attr.code" />', 'r':true, 't':'f_code'},
         'experiment.name':{'l':'<@text name="attr.name" />', 'r':true, 't':'f_name'},
         'experiment.beginAt':{'l':'实验开始时间', 'r':true, 't':'f_beginAt'},
         'experiment.endAt':{'l':'实验结束时间', 'r':true, 't':'f_endAt'},        
         'experiment.type.id':{'l':'实验类型', 'r':true, 't':'f_type'},
         'experiment.publish':{'l':'是否公布答案', 'r':true, 't':'f_publish'}, 
         'experiment.assessment.id':{'l':'评估标准', 'r':true, 't':'f_assessment'},
         'experiment.caze.name':{'l':'选择案例', 'r':true, 't':'f_caze'},
         <#list analysisTables as analysis>
         '${analysis.id}mark':{'l':'${analysis.name}', 'f':'unsigned','r':false, 't':'f_analysis_${analysis.id}'}<#if analysis_has_next>,</#if>
         </#list>
         };
		 var v = new validator(form , a_fields, null);
		 if (v.exec()) {
		    var total=0;
		    var checks = document.getElementsByName("analysisId");
		    for(var i=0;i<checks.length;i++){
		       analysisId=checks[i].value;
		       if(checks[i].checked){
		            if(form[analysisId+"mark"].value==""){
		               alert("不能提交空值");
		               return;
		            }else{
		                total+=parseInt(form[analysisId+"mark"].value);
		            }
		       }
		    }
		    if(total!=100){
		       alert("总分为"+total+",总和应为100分");return;
		    }
		    form.action="experiment.action?method=save";
		    form.submit();
		 }
   }
function doSetCaze(cazeid,cazename)
		{
         document.experimentForm['experiment.caze.name'].value=cazename;
         document.experimentForm['caze.id'].value=cazeid;
        }
function doSelectCaze(form){
       
	   url='caze.do?method=cazeQuery';
	   window.open(url, '案例信息', 'scrollbars=yes,width=750,height=650,status=yes,titlebar=no');
	}
    function doClearCaze(form){
       	document.experimentForm['experiment.caze.name'].value='';
        document.experimentForm['caze.id'].value='';   
	}  
</script>
 </body> 
</html>
