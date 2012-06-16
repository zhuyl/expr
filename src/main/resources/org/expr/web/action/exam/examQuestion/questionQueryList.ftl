 <#include "/template/head.ftl"/>
 
<body>

  <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/system/BaseInfo.js"></script>

<table id="toolbar"></table>
 <script>
  var bar = new ToolBar('toolbar', '题目列表', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
  bar.addItem('选择并关闭', 'returnValue()');
</script>
  <script>
      var detailArray = {};
  </script>
<@table.table id="questionnaireTable" width="100%" align="center">
    <@table.thead>
 <@table.selectAllTd id="examQuestionId" />
   <@table.td text="题目序号"/>  
   <@table.td text="题目名称"/> 
   <@table.td text="案例名称"/>
   <@table.td text="制作人"/> 
 </@>
 <@table.tbody datas=(examQuestions?if_exists)?sort_by("code");examQuestion>
   <@table.selectTd id="examQuestionId" value=examQuestion.id type="checkBox"/>
   <script>
      	detailArray['${examQuestion.id}'] = {'name':'${examQuestion.caze.name?if_exists}'};
   </script>
   <td>${examQuestion.code?if_exists}</td>
   <td><a href="examQuestion.action?method=info&examQuestion.id=${examQuestion.id}">${examQuestion.name?if_exists}</a></td>
   <td><a href="${base}/caze.action?method=info&caze.id=${examQuestion.caze.id?if_exists}">${examQuestion.caze.name?if_exists}</a></td>   
   <td>${examQuestion.author?if_exists}</td>
   </@>
 </@>

  <script language="javascript">

   type="examQuestion";
   defaultOrderBy="${Parameters['orderBy']?default('null')}";
    function getIds(){
       return(getCheckBoxValue(document.getElementsByName("examQuestionId")));
    }

    function returnValue(){
      id= getIds();
      if(id==""){
      	window.alert('请选择!');
      	return;
      }
      ids=id.split(',');
      listname="${Parameters['listname']}";
      for(var i=0;i<ids.length;i++){
          window.top.opener.doSetQuestion(ids[i],getName(ids[i]),listname);
      }
	  parent.windowclose();//关闭不了
    }
    function getName(id){
         return detailArray[id]['name'];
    }
  </script>

</body>
 <#include "/template/foot.ftl"/>