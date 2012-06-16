<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Validator.js"></script>
<@sj.head compressed="false" jqueryui=true   jquerytheme="redmond" loadFromGoogle="false"  defaultIndicator="myDefaultIndicator"/>
<body>
<table width="100%" id="bar"></table> 
    <form action="questionnaire!saveRank.action" name="questionForm" method="post" onsubmit="return false;">
    <input type="hidden" name="questionnaire.id" value="${Parameters['questionnaire.id']}"/> 
    <@searchParams/>
	  <table class=listTable id="listTable" width="90%" align="center" >
	   <tbody>
	   <tr align="center" class="darkColumn" >
	   <td class="select" ><input type="checkBox" id="rankIdBox" class="box" onClick="toggleCheckBox(document.getElementsByName('rankSeq'),event);"></td>
	   <td width="60%">得分等级名称</td>
	   <td width="20%">最低分</td>
	   <td width="20%">最高分</td>
	   </tr>
	     <#list questionnaire.ranks?sort_by("lower")  as rank>
	      <tr>
	       <td id="f_rank_${rank_index}">
	            <input type="checkbox" name="rankSeq"  value="${rank_index}"/>
	            <input type="hidden" name="rank${rank_index}.id"  value="${rank.id}"/>
	       </td>
	       <td><input type="text" name="rank${rank_index}.name"  id="rank${rank_index}.name"  value="${(rank.name)?if_exists}" style="width:100%"></td>
	       <td><input type="text" name="rank${rank_index}.lower"  id="rank${rank_index}.lower"  value="${(rank.lower)?if_exists}" style="width:100%"></td>
	       <td><input type="text" name="rank${rank_index}.upper"  id="rank${rank_index}.upper"  value="${(rank.upper)?if_exists}" style="width:100%"></td>
	     </tr>
	     </#list>
	   </tbody>
	  </table>
 </form> 
  <br>  <br>  <br>  <br>  <br>  <br>  <br>  <br>  <br>  <br>
  <script language="javascript" > 

    var bar = new ToolBar('bar','得分等级信息',null,true,true);
   bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>'); 
    bar.addItem("添加","add()",'new.gif');
   bar.addItem("保存","save()",'save.gif');
   bar.addItem("删除","remove()","delete.gif");
   bar.addBack("后退");
   var rankAttrs = new Array();
   rankAttrs[0]="id";
   rankAttrs[1]="name";
   rankAttrs[2]="lower";
   rankAttrs[3]="upper";  
   var form =document.questionForm;
   var index=${questionnaire.ranks?size};
   //添加
   function add(){
	    var tb = listTable;
	    var tr = document.createElement('tr');
	    var cellsNum = tb.rows[0].cells.length;
	    for(var j = 0 ; j < cellsNum ; j++){
	        var td = document.createElement('td');
	        if(j==0){
		        td.innerHTML='<input type="checkBox"  name="rankSeq" value="'+ index +'"> <input type="hidden" name="rank'+ index +'.id"  value=""/>'
		        td.className="select";
		    }
		    else{
		       id="rank"+index+"."+rankAttrs[j];
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
		var Ids = getCheckBoxValue(document.getElementsByName("rankSeq"));
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
        if(errorStr!=""){alert(errorStr);return;}
        addInput(form,"rankCount",index);
    	form.submit();
	}
    function check(){
	   var errorStr="";
	   for(var i=0;i<index;i++){
	      var ele=document.getElementById('rank'+i+".name");
	      if(ele ==null){
	      	continue;
	      }
	      if(document.getElementById('rank'+i+".name").value=="")errorStr+='第'+(i+1)+"行 名称没有填写\n";
	      if(!/^\d+$/.test(document.getElementById('rank'+i+".lower").value)){
	         errorStr+='第'+(i+1)+"行 最低分格式不对\n";
          }
          if(!/^\d+$/.test(document.getElementById('rank'+i+".upper").value)){
	         errorStr+='第'+(i+1)+"行最高分格式不对\n";
          }
	   }
	   return errorStr;
	}
</script>
 </body> 
</html>