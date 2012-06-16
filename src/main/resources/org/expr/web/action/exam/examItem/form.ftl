<#include "/template/head.ftl"/>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckeditor.js"></script>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckTextArea.js"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Validator.js"></script>
<body>
<table width="100%" id="bar"></table> 
    <form action="examItem!save.action" name="examItemForm" method="post">
    <input type="hidden" name="examQuestion.id" value="${Parameters['examQuestion.id']}"/> 
    <@searchParams/>
    <table width="90%" align="center" class="formTable">
   <tr>
      <td width="20%" id="f_code" class="title"><font color="red">*</font>问题序号:</td>
      <td width="80%">
      <input type="text" name="examItem.code" id="itemcode" maxlength="50" value="${examItem.code!}" style="width:100%;"/>
      </td>
    </tr> 
    <tr>
      <td width="20%" id="f_description" class="title"><font color="red">*</font>问题描述:</td>
      <td width="80%">
 <textarea cols="50" id="detail" name="examItem.description">${examItem.description?if_exists}</textarea>
 <input type="button"  id="changeDescription" name="changeDescription" value="富文本输入" onClick="javascript:changeTextarea('detail','90%','100%');document.getElementById('changeDescription').disabled = true;" />
 <input type="hidden"  name="examItem.id" value="${examItem.id!}"/>
      </td>
    </tr>
    <tr>
      <td width="20%" id="f_weight" class="title"><font color="red">*</font>得分权重:</td>
      <td width="80%">
      <input type="text" name="examItem.weight" id="weight" maxlength="50" value="${examItem.weight!}" style="width:100%;"/>
      </td>
    </tr> 
     <tr>
      <td width="20%" id="f_answer" class="title"><font color="red">*</font>问题答案:</td>
      <td width="80%">
      <input type="text" name="examItem.answer" maxlength="50" value="${examItem.answer!}" style="width:60%;"/>
      (多个答案间请用","分割)</td>
    </tr> 
    <tr>
      <td width="20%" id="f_explain" class="title">问题解析:</td>
      <td width="80%">
 <textarea cols="50" id="explain" name="examItem.explain">${examItem.explain?if_exists}</textarea>
 <input type="button"  id="changeExplain" name="changeExplain" value="富文本输入" onClick="javascript:changeTextarea('explain','90%','100%');document.getElementById('changeExplain').disabled = true;" />
      </td>
    </tr> 
  </table>
  <table class=listTable id="listTable" width="90%" align="center" >
   <tbody>
   <tr align="center" class="darkColumn" >
   <td class="select" ><input type="checkBox" id="optionIdBox" class="box" onClick="toggleCheckBox(document.getElementsByName('optionCode'),event);"></td>
   <td text="选项编号"width="10%">选项编号</td>
   <td text="选项内容"width="90%">选项内容</td>
   </tr>
     <#list examItem.options?sort_by("code")  as option>
      <tr>
       <td id="f_option_${option_index}">
            <input type="checkbox" name="optionCode"  value="${option_index}"/>
            <input type="hidden" name="option${option_index}.id"  value="${option.id}"/>
       </td>
       <td><input type="text" name="option${option_index}.code"  id="option${option_index}.code"  value="${(option.code)?if_exists}" ></td>
       <td><input type="text" name="option${option_index}.description"  id="option${option_index}.description"  value="${(option.description)?if_exists}" style="width:100%"></td>
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
   optionAttrs[1]="code";
   optionAttrs[2]="description";
   var form =document.examItemForm;
   var index=${examItem.options?size};
   //添加
   function add(){
	    var tb = listTable;
	    var tr = document.createElement('tr');
	    var cellsNum = tb.rows[0].cells.length;
	    for(var j = 0 ; j < cellsNum ; j++){
	        var td = document.createElement('td');
	        if(j==0){
		        td.innerHTML='<input type="checkBox"  name="optionCode" value="'+ index +'"> <input type="hidden" name="option'+ index +'.id"  value=""/>'
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
		var Ids = getCheckBoxValue(document.getElementsByName("optionCode"));
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
		if(typeof FCKeditorAPI != "undefined"){
			if(FCKeditorAPI.GetInstance('detail')){
				form['examItem.description'].value=FCKeditorAPI.GetInstance('detail').GetXHTML( true );
			}
			if(FCKeditorAPI.GetInstance('explain')){
				form['examItem.explain'].value=FCKeditorAPI.GetInstance('explain').GetXHTML( true );
			}
		}
        errorStr=check();
        if(form['examItem.code'].value=="")
          errorStr +="问题序号没有填写\n";
     if((form['examItem.description'].value==""))
          errorStr +="问题描述没有填写\n";
        if(form['examItem.weight'].value=="")
          errorStr +="得分权重没有填写\n";   
        if(form['examItem.answer'].value=="")
          errorStr +="问题答案没有填写\n";  
     	 if(!/^\d+$/.test(document.getElementById('itemcode').value)){
	         errorStr+="问题序号格式不对\n";
           }
     	 if(!/^\d+$/.test(document.getElementById('weight').value)){
	         errorStr+="得分权重格式不对\n";
           }
        if(errorStr!=""){alert(errorStr);return;}
        addInput(form,"optionCount",index);
    	form.submit();
	}
    function check(){
	   var errorStr="";
	   for(var i=0;i<index;i++){
			if(!document.getElementById('option'+i+".code")) continue;
	   	  if(document.getElementById('option'+i+".code").value=="")errorStr+='第'+(i+1)+"行 选项编号没有填写\n";
	      if(document.getElementById('option'+i+".description").value=="")errorStr+='第'+(i+1)+"行 选项内容没有填写\n";

	   }
	   return errorStr;
	}
</script>
</body> 
</html>