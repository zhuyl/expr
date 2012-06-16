<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Validator.js"></script>
<script language="javascript" type="text/javascript" src="${base}/static/scripts/fckeditor/fckeditor.js"></script>
<script language="javascript" type="text/javascript" src="${base}/static/scripts/fckeditor/fckTextArea.js"></script>
<#assign textAreaId = "bodyMessage"/>
<body>
<table id="backBar"></table>
     <table width="100%">       
   		<tr>
   		<td valign="top" width="40%">
   		<table width="100%"  class="formTable">
   		<form name="listForm" method="post" action="">
   		 <input type="hidden" name="lesson.id" value="${Parameters['lesson.id']}">
   		 <input type="hidden" name="who" value="${Parameters['who']}">
   		 <input type="hidden" name="params" value="&lesson.id=${Parameters['lesson.id']}">
		   <tr>
		     <td class="title" id="f_title">&nbsp;发送者</td><td  align="left">${me.fullname} (${me.name})</td>
		   </tr>
	   <#if Parameters['who']=="std">
		   <tr>
		   	 <td  class="title" id="f_receiptors">&nbsp;接收者</td>
		   	 <td >
		   	     <select id="showText" onchange="changeText();">
		   	        <option value="choice">手工选择账号</option>
		   	        <option value="input">手工输入账号</option>
		   	     </select>
		   	   <div id="show">
		   	  	<input id="receiptorIds" type="hidden" name="receiptorIds">
		   	  	<textarea id="receiptorNames" name="receiptorNames" rows="2" cols="60" readonly style="font-size:10pt"></textarea>
		   	     <button onclick="receiptorIds.value='';receiptorNames.value='';return false;">清空</button>
		   	   </div>  
		   	 </td>
		   </tr>
		  <#else>
		    <tr>
		   	 <td  class="title" id="f_receiptors">&nbsp;接收者</td>
		   	 <td>
		   	  	<input id="receiptorIds" name="receiptorIds" value="<#list lesson.teachers as teacher>${teacher.code}<#if teacher_has_next>,</#if></#list>">
		   	 </td>
		   </tr>
		   </#if>
		   <tr>
		     <td class="title" id="f_title">&nbsp;消息标题</td><td  align="left"><input type="text" name="message.title" style="width:500px;"></td>
		   </tr>
		   <tr>
		     <td class="title" id="f_body">&nbsp;消息内容</td>
		     <td align="left"><textarea id="messagebody" name="message.content" rows="10" cols="50"></textArea></td>
		   </tr>
		   </table>
	   </form>
	  </td>
	  </tr>
	   <#if Parameters['who']=="std">
	  <tr>
	  <td valign="top">
    <table id="myBar"></table>
     <@table.table width="100%"  onkeypress="dwr.util.onReturn(event,query)" sortable="true" id="listTable">
       <@table.thead>
         <@table.selectAllTd id="code"/>
	     <@table.td text="用户名" id="user.code"/>
	     <td>姓名</td>
	   </@>
	   <@table.tbody datas=lesson.students;student>
	     <@table.selectTd id="code" value="${student.code}" />
	     <td>${student.code}</td>
  	     <td>${student.name}</td>
	   </@>
     </@>
	 <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/system/SendMessage.js?ver=2"></script>
	<script>
	    var bar= new ToolBar("myBar","班级学生列表",null,true,true);
	    bar.addItem("选中添加","addSelected()");
	    function getIds(){
	       return(getCheckBoxValue(document.getElementsByName("code")));
	    }
	    <#list lesson.students as student>
		detailArray['${student.code}'] = {'name':'${student.code}'};
		</#list>
	</script>
	  </td>
	  </tr>
	  </#if>
	  </table>
	  <form method="post" action="" name="actionForm"></form>
	<script>
	  	var bar = new ToolBar('backBar','发送消息',null,true,true);
	  	bar.setMessage('<@getMessage/>');
	  	bar.addItem("发送",'doAction()','send.gif');
	  	
	  	initFCK("messagebody", "100%", "");
	  	
		function doAction(){
			var a_fields = {
	          'message.title':{'l':'消息标题', 'r':true, 't':'f_title'},
	          'receiptorIds':{'l':'接收者','r':true, 't':'f_receiptors'}
	     	};
	     var v = new validator(document.listForm, a_fields, null);
	     if (v.exec()) {
	     	if (FCKeditorAPI.GetInstance("messagebody").GetXHTML(true) == "" ) {
	     		alert("消息内容没有填写。");
	     		return;
	     	}
	        document.listForm.action="lessonMessage!sendTo.action";
	        document.listForm.submit();
	     }
		}
		function addValue(id,name){
			if(id!=""){
	   		    var inputIds = document.getElementById("receiptorIds");
				addInputValue(id,inputIds);
			}
			if(name!=""){
	   		   var inputNames = document.getElementById("receiptorNames");
				addInputValue(name,inputNames);
			}
		}
	    function removeValue(id,name){
			if(id!=""){
	   		    var inputIds = document.getElementById("receiptorIds");
				removeInputValue(id,inputIds);
			}
			if(name!=""){
	   		   var inputNames = document.getElementById("receiptorNames");
				removeInputValue(name,inputNames);
			}
	    }
		function removeInputValue(value,input){
		   if(input.value.indexOf(value)!=-1){
		      var index = input.value.indexOf(value);
		      input.value=input.value.substr(0,index)+input.value.substr(index+value.length+1);
		   }
		}
		function addInputValue(value,input){
			if(input.value.indexOf(value)==-1){
	           input.value+=value+",";
	        }
		}
		function cleanChoiceReceiptor(){
		    document.getElementById("receiptorIds").value='';
		    document.getElementById("receiptorNames").value='';
			return false;
		} 
		function cleanInputReceiptor(){
		    document.getElementById("receiptorIds").value='';
			return false;
		} 
		function changeText(){
		  var text=document.getElementById("showText").value;
		  var choiceText='<input id="receiptorIds" type="hidden" name="receiptorIds">';
		  choiceText+='<textarea id="receiptorNames" name="receiptorNames" rows="2" cols="60" readonly  style="font-size:10pt"></textarea>';
		  choiceText+='<button onclick="cleanChoiceReceiptor();">清空</button>';
		  var inputText='<textarea id="receiptorIds" name="receiptorIds" rows="2" cols="60"  style="font-size:10pt"></textarea>';
		  inputText+='<button onclick="cleanInputReceiptor();">清空</button>';
		  if(text=='choice'){
		    document.getElementById("show").innerHTML=choiceText;
		  }else{
		    document.getElementById("show").innerHTML=inputText;
		  }
		}
	</script>
</body>
<#include "/template/foot.ftl"/>
