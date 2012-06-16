<#include "/template/head.ftl"/>
<BODY>
  <table id="toolbar"></table>
  <@getMessage/>
    <form action="careerRate!save.action" name="careerRateForm" method="post" onsubmit="return false;">
  <input type="hidden" name="product.id" value="${Parameters['product.id']}"/> 
    <table width="90%" align="center" class="formTable">
    	<tr>
	    	<td align="center" class="title">职业等级</td>
	    	<td align="center" class="title">费率(每千元保额)</td>
    	</tr>
    	<#list grades as grade>
    	<tr>	    	
       <td align="center">
       <input type="hidden" id="grades${grade_index}.id" name="grades${grade_index}.id"  value="${grade.id}"/>${(grade.name)?if_exists}
       </td>
       <td>
       <input type="text" name="rates${grade_index}.rate"  id="rates${grade_index}.rate"  value="${(careerRate.rates.get(grade.id)*1000)!}" style="width:50%"></td>
	    	
    	</tr>
    	</#list>
 	</table>
</form>
 	  <script language="javascript">
 	     var index=${grades?size};
     var bar = new ToolBar("toolbar","费率列表",null,true,true);
     bar.addItem("保存","save()");
     bar.addBack();
   var form =document.careerRateForm;
	function save(){
        errorStr=check();         
        if(errorStr!=""){alert(errorStr);return;}
        
    	form.submit();
	}
    function check(){
	   var errorStr="";
	   for(var i=0;i<index;i++){
	   	  if(document.getElementById('rates'+i+".rate").value=="")errorStr+='第'+(i+1)+"行 费率没有填写\n";

	   }
	   return errorStr;
	}

  </script>
</body>
<#include "/template/foot.ftl"/>