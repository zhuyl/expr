<#include "/template/head.ftl"/>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckeditor.js"></script>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckTextArea.js"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Validator.js"></script>
 <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Calendar.js"></script>
<script language="JavaScript" type="text/JavaScript" src='${base}/dwr/interface/insuranceDwrService.js'></script>
<body>
<table width="100%" id="bar"></table> 
    <form action="question!save.action" name="questionForm" method="post" onsubmit="return false;">
    <input type="hidden" name="questionnaire.id" value="${Parameters['questionnaire.id']}"/> 
    <@searchParams/>
    <table width="90%" align="center" class="formTable">
    <tr>
      <td width="20%" id="f_description" class="title"><font color="red">*</font>问题描述:</td>
      <td width="80%">
 <textarea cols="50" id="detail" name="question.description">${question.description?if_exists}</textarea>
 <input type="hidden"  name="question.id" value="${question.id!}"/>
      </td>
    </tr>
    <tr>
      <td width="20%" id="f_type" class="title"><font color="red">*</font>问题类型:</td>
      <td width="80%">
 <@htm.i18nSelect datas=questionTypes selected="${(question.questionType.id)?if_exists}"  
 name="question.questionType.id" style="width:50%;"><option value="">...</option></@>
      </td>
    </tr>  
  </table>
  <table class=listTable id="listTable" width="90%" align="center" >
   <tbody>
   <tr align="center" class="darkColumn" >
   <td class="select" ><input type="checkBox" id="optionIdBox" class="box" onClick="toggleCheckBox(document.getElementsByName('optionSeq'),event);"></td>
   <td text="选项编号"width="10%">选项编号</td>
   <td text="选项内容"width="80%">选项内容</td>
   <td text="选项得分"width="10%">选项得分</td>
   </tr>
     <#list question.options?sort_by("seq")  as option>
      <tr>
       <td id="f_option_${option_index}">
            <input type="checkbox" name="optionSeq"  value="${option_index}"/>
            <input type="hidden" name="option${option_index}.id"  value="${option.id}"/>
       </td>
       <td><input type="text" name="option${option_index}.seq"  id="option${option_index}.seq"  value="${(option.seq)?if_exists}" ></td>
       <td><input type="text" name="option${option_index}.name"  id="option${option_index}.name"  value="${(option.context)?if_exists}" style="width:100%"></td>
       <td><input type="text" name="option${option_index}.score"  id="option${option_index}.score"  value="${(option.score)?if_exists}" ></td>
     </tr>
      </#list>
  </tbody>
  </table>
      </form> 
  <br>  <br>  <br>  <br>  <br>  <br>  <br>  <br>  <br>  <br>
  <script language="javascript" > 

    var bar = new ToolBar('bar','问题信息',null,true,true);
   bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>'); 
    bar.addItem("添加","add()",'new.gif');
   bar.addItem("保存","save()",'save.gif');
   bar.addItem("删除","remove()","delete.gif");
   bar.addBack("后退");
   var optionAttrs = new Array();
   optionAttrs[0]="id";
   optionAttrs[1]="seq";
   optionAttrs[2]="name";
   optionAttrs[3]="score";  
   var form =document.questionForm;
   var index=${question.options?size};
   //添加
   function add(){
	    var tb = listTable;
	    var tr = document.createElement('tr');
	    var cellsNum = tb.rows[0].cells.length;
	    for(var j = 0 ; j < cellsNum ; j++){
	        var td = document.createElement('td');
	        if(j==0){
		        td.innerHTML='<input type="checkBox"  name="optionSeq" value="'+ index +'"> <input type="hidden" name="option'+ index +'.id"  value=""/>'
		        td.className="select";
		    }
		    else{
		       id="option"+index+"."+optionAttrs[j];
		       td.innerHTML ="<input type='text' style='width:100%'  name='"+ id +"' id='"+id + "'>"
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
		var Ids = getCheckBoxValue(document.getElementsByName("optionSeq"));
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
        if(form['question.description'].value=="")
          errorStr +="问题描述没有填写\n";
        if(form['question.questionType.id'].value=="")
          errorStr +="问题类型没有填写\n";          
        if(errorStr!=""){alert(errorStr);return;}
        addInput(form,"optionCount",index);
    	form.submit();
	}
    function check(){
	   var errorStr="";
	   for(var i=0;i<index;i++){
			if(!document.getElementById('option'+i+".seq")) continue;
	   	  if(document.getElementById('option'+i+".seq").value=="")errorStr+='第'+(i+1)+"行 选项编号没有填写\n";
	      if(document.getElementById('option'+i+".name").value=="")errorStr+='第'+(i+1)+"行 选项内容没有填写\n";
	      if(!/^\d+$/.test(document.getElementById('option'+i+".score").value)){
	         errorStr+='第'+(i+1)+"行 得分格式不对\n";
           }
	   }
	   return errorStr;
	}
</script>
 </body> 
</html>
