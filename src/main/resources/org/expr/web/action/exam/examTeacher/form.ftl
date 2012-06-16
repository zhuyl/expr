<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Validator.js"></script>
 <script language="JavaScript" type="text/JavaScript" src="/skaily/static/scripts/My97DatePicker/WdatePicker.js"></script>
<body>
<table width="100%" id="bar"></table> 
    <form action="examTeacher.action?method=save" name="examTeacherForm" method="post">
  <table width="90%" align="center" class="formTable">
    <tr class="darkColumn">
      <td colspan="4"><B><strong><span class="redtext">${examPaper.lesson.coursename}</span></strong>测试信息</B></td>
    </tr>
    <tr>
      <td width="20%" id="f_code" class="title"><font color="red">*</font>测试编号:</td>
      <td width="30%">
      <input id="codeValue" type="text" name="examPaper.code" value="${examPaper.code?if_exists}" maxLength="32" style="width:100%;">
      <input type="hidden"  name="examPaper.id" value="${examPaper.id?if_exists}"/>
      <#if examPaper.id?exists><#else>
      <input type="hidden"  name="examPaper.lesson.id" value="${Parameters['lessonId']?if_exists}"/>
      </#if>
      </td>
      <td width="20%" id="f_name" class="title"><font color="red">*</font>测试名称:</td>
      <td width="30%"><input type="text" name="examPaper.name" value="${examPaper.name?if_exists}" maxLength="20" style="width:100%;"></td>
    </tr>
    <tr>
      <td width="20%" id="f_beginAt" class="title"><font color="red">*</font>测试开始时间:</td>
      <td width="30%">
      <input type="text" name="examPaper.beginAt" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})"  class="Wdate"  value="${(examPaper.beginAt?string('yyyy-MM-dd  HH:mm'))?if_exists}" />
       </td>
      <td width="20%" id="f_endAt" class="title"><font color="red">*</font>测试结束时间:</td>
      <td width="30%"><input type="text" name="examPaper.endAt"   value="${(examPaper.endAt?string('yyyy-MM-dd  HH:mm'))?if_exists}" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})"  class="Wdate" /></td>
    </tr>
      <tr>
      <td width="20%" id="f_period" class="title"><font color="red">*</font>测试用时:</td>
      <td width="80%" colspan="3">
      <input type="text" name="examPaper.period" id="period"  value="${examPaper.period?if_exists}" maxLength="20" style="width:90%;"/>分钟
       </td>
    </tr>
   <tr>
      <td class="title">导语:</td>
      <td colspan="3"><textarea rows="2" cols="70" id="description" name="examPaper.description">${examPaper.description?if_exists}</textarea></td>
     </tr>
     <tr>
      <td class="title">备注:</td>
      <td colspan="3"><textarea rows="2" cols="70" id="memo" name="examPaper.memo">${examPaper.memo?if_exists}</textarea></td>
     </tr>
  </table>
 <table class=listTable id="listTable" width="90%" align="center" >
   <tbody>
   <tr align="center" class="darkColumn" >
   <td class="select" ><input type="checkBox" id="questionMarkIdBox" class="box" onClick="toggleCheckBox(document.getElementsByName('questionMarkSeq'),event);"></td>
   <td text="题目编号"width="10%">题目编号</td>
   <td text="待选题目"width="80%">待选题目</td>
   <td text="题目得分"width="10%">题目得分</td>
   </tr>
     <#list examPaper.questionMarks?sort_by("code")  as questionMark>
      <tr>
       <td id="f_questionMark_${questionMark_index}">
            <input type="checkbox" name="questionMarkSeq"  value="${questionMark_index}"/>
            <input type="hidden" name="questionMark${questionMark_index}.id"  value="${questionMark.id}"/>
       </td>
       <td><input type="text" name="questionMark${questionMark_index}.code"  id="questionMark${questionMark_index}.code"  value="${(questionMark.code)?if_exists}" style='width:100%'></td>
       <td align="center"><select name="questionMark${questionMark_index}.questions" id="questionMark${questionMark_index}.questions" MULTIPLE size='10' style='width:300px'>
         <#list questionMark.questions?if_exists as question>
          <option value="${question.id}">${question.caze.name}</option>
         </#list>
       </select><input onClick='doSelectQuestion(this.form,${questionMark_index})' type='button' value='添加'><input OnClick='doDeleteQuestion(${questionMark_index})' type='button' value='删除'>
       <td><input type="text" name="questionMark${questionMark_index}.mark"  id="questionMark${questionMark_index}.mark"  value="${(questionMark.mark)?if_exists}" style='width:100%'></td>
     </tr>
      </#list>
  </tbody>
  </table>
 </form> 
  <br>  <br>  <br>  <br>  <br>
  <script language="javascript" > 
   var bar = new ToolBar('bar','测试信息',null,true,true);
   bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>'); 
   bar.addItem("添加","add()",'new.gif');
   bar.addItem("保存","save()",'save.gif');
   bar.addItem("删除","remove()","delete.gif");
   bar.addBack("后退");
   var optionAttrs = new Array();
   optionAttrs[0]="id";
   optionAttrs[1]="code";
   optionAttrs[2]="questions";
   optionAttrs[3]="mark";  
   var form =document.examTeacherForm;
   var index=${examPaper.questionMarks?size};
   //添加
   function add(){
	    var tb = listTable;
	    var tr = document.createElement('tr');
	    var cellsNum = tb.rows[0].cells.length;
	    for(var j = 0 ; j < cellsNum ; j++){
	        var td = document.createElement('td');
	        if(j==0){
		        td.innerHTML='<input type="checkBox"  name="questionMarkSeq" value="'+ index +'"> <input type="hidden" name="questionMark'+ index +'.id"  value=""/>';
		        td.className="select";
		    }
		    else if(j==2){
		       id="questionMark"+index+"."+optionAttrs[j];
		       td.innerHTML ="<select name='"+id+"' MULTIPLE size='10' style='width:300px'></select><input onClick='doSelectQuestion(this.form,"+index+")' type='button' value='添加'><input OnClick='doDeleteQuestion("+index+")' type='button' value='删除'> "	 ;      
		    }
		    else{
		       id="questionMark"+index+"."+optionAttrs[j];
		       td.innerHTML ="<input type='text' style='width:100%'  name='"+ id +"' id='"+id + "'>";
		    }   	
	        tr.appendChild(td);
	    }
	    tr.className="grayStyle";
	    tr.align="center";
	    tb.tBodies[0].appendChild(tr);
	    index++;
	    f_frameStyleResize(self);
	}
	
	//删除具体某表的选中的行（该表第一列是复选框）
    function remove(){
		var Ids = getCheckBoxValue(document.getElementsByName("questionMarkSeq"));
		if(Ids!=""&&!confirm("删除信息将无法恢复，确认删除?"))return;
		var count=0;
		var rows= listTable.tBodies[0].rows;
		// 跳过标题
		for(var i=rows.length-1;i>=0;i--){
			tdElements=rows[i].cells[0].children;
			for(var j=0;j<tdElements.length;j++){
				if(tdElements[j].checked){
					listTable.tBodies[0].removeChild(rows[i]);
					count++;
					break;
				}
			}
		}
		if(count==0) {alert("请选择");return;}
		f_frameStyleResize(self);
	}
	// 保存既有的设置（新增的和修改的）
	function save(){
        errorStr=check();
        errorStr=errorStr+checkTotal();

        if(form['examPaper.code'].value=="")
          errorStr +="试卷编号没有填写\n";
        if(form['examPaper.name'].value=="")
          errorStr +="试卷名称没有填写\n";   
        if(form['examPaper.beginAt'].value=="")
          errorStr +="测试开始时间没有填写\n"; 
        if(form['examPaper.endAt'].value=="")
          errorStr +="测试结束时间没有填写\n";  
         if(!/^\d+$/.test(document.getElementById('period').value)){
	         errorStr+="测试用时格式不对\n";}       
        if(errorStr!=""){alert(errorStr);return;}
        addInput(form,"optionCount",index);

       for(var i=0;i<index;i++){
        if(!document.getElementById('questionMark'+i+'.questions'))continue;
        addInput(form,"selectedQuestion"+i+"Ids", getAllOptionValue(document.getElementById('questionMark'+i+'.questions')));
        }
    	form.submit();
	}
    function check(){
	   var errorStr="";
	   for(var i=0;i<index;i++){
		if(!document.getElementById('questionMark'+i+".code")) continue;
		  if(!/^\d+$/.test(document.getElementById('questionMark'+i+".code").value)){
	         errorStr+='第'+(i+1)+"行 题目编号格式不对\n";}
	      if(document.getElementById('questionMark'+i+".questions").options.length==0)errorStr+='第'+(i+1)+"行 没有选择待选题目\n";
	      if(!/^\d+$/.test(document.getElementById('questionMark'+i+".mark").value)){
	         errorStr+='第'+(i+1)+"行 得分格式不对\n";
           }
	   }
	   return errorStr;
	}
    function checkTotal(){
    	var errorStr="";
    	   var total=0;
    	   for(var i=0;i<index;i++){
    	   if(!document.getElementById('questionMark'+i+".mark")) continue;
    	      total+=parseInt(document.getElementById('questionMark'+i+'.mark').value);
			}
		    if(total!=100){
		       errorStr+="总分为"+total+",总和应为100分";
		    }
		    return errorStr;
    }
     function reset(){
         document.examTeacherForm.reset();
     }
function doSelectQuestion(form,listname){
       
	   url='examQuestion.do?method=questionQuery&listname=questionMark'+listname;
	   window.open(url, '试题信息', 'scrollbars=yes,width=750,height=650,status=yes,titlebar=no');
	}
function doSetQuestion(questionid,questionname,listname)
		{

		obj=document.getElementById(listname+".questions");
		if(jsSelectIsExitItem(obj,questionid)!=true){
			obj.options.add(new Option(questionname,questionid));
		}	
        }
function doDeleteQuestion(listname){
		obj=document.getElementById("questionMark"+listname+".questions");
		//obj.remove(obj.selectedIndex);
		jsRemoveSelectedItemFromSelect(obj);
	}
function jsSelectIsExitItem(objSelect, objItemValue) {        
    var isExit = false;        
    for (var i = 0; i < objSelect.options.length; i++) {        
        if (objSelect.options[i].value == objItemValue) {        
            isExit = true;        
            break;        
        }        
    }        
    return isExit;        
} 
function jsRemoveSelectedItemFromSelect(objSelect) {        
    var length = objSelect.options.length - 1;    
    for(var i = length; i >= 0; i--){    
        if(objSelect[i].selected == true){    
            objSelect.options[i] = null;    
        }    
    }    
}   
  
</script>
 </body> 
</html>
