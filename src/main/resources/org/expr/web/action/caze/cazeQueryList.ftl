<#include "/template/head.ftl"/>
<BODY>

  <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/system/BaseInfo.js"></script>
 <table id="myBar"></table>
 <script>
  var bar = new ToolBar('myBar', '案例列表', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
  bar.addItem('选择并关闭', 'returnValue()');
</script>
  <@getMessage/>
  <script>
      var detailArray = {};
  </script>
  <@table.table width="100%"  id="listTable" sortable="true">
    <@table.thead>
       <@table.td text=""/>
       <@table.sortTd name="编码" id="caze.seq"/>
       <@table.sortTd name="名称" id="caze.name"/>
       <@table.sortTd name="客户生命周期类型" id="caze.lifeCycleType.name"/>
       <@table.sortTd name="更新日期" width="10%" id="caze.updatedAt" />
       <@table.sortTd name="案例作者" id="caze.author"/>
       <@table.sortTd name="操作" id="caze.operation"/>
    </@>
    <@table.tbody datas=cazes;caze>
       <@table.selectTd id="cazeId" value=caze.id type="radio"/>
      <script>
      detailArray['${caze.id}'] = {'name':'${caze.name?if_exists}'};
       </script>
       <td>${caze.seq}</td>
       <td><a href="caze.action?method=info&caze.id=${caze.id}">${caze.name?if_exists}</a></td>
       <td><@i18nName caze.lifeCycleType/></td>
       <td>${(caze.updatedAt?string("yyyy-MM-dd"))?if_exists}</td>
       <td>${caze.author?if_exists}</td>
       <td><a href='#'  target="_blank" onclick='caze!answerEdit.action?caze.id=${caze.id}'>查看答案</a></td>
    </@>
   </@>
  <script language="javascript">

   type="caze";
   defaultOrderBy="${Parameters['orderBy']?default('null')}";
   

    function getIds(){
       return(getRadioValue(document.getElementsByName("cazeId")));
    }

    function returnValue(){
          id= getIds();
          if(id=="")
          window.alert('请选择!');
          else{
          var name=getName(id);
           window.top.opener.doSetCaze(id,name);
		   parent.windowclose();//关闭不了
           }
		}
   function getName(id){
         return detailArray[id]['name'];
    }
  </script>
</body>
<#include "/template/foot.ftl"/>
