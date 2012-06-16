 <#include "/template/head.ftl"/>
  <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Validator.js"></script>
<body>
<table id="toolbar"></table>
	<table id="formTable" class="formTable" align="center" width="80%">
	<form name="actionForm" method="post" action="${base}/answer/otherExpensePlan!save.action">
		<input type="hidden" name="params" value="&caze.id=${Parameters['caze.id']}">
		<input type="hidden" name="caze.id" value="${Parameters['caze.id']}">
		<tr><td class="title" id="f_expense"><font color="red">*</font>其他支出</td><td><input id="expense" name="expense"/></td></tr>
		<tr><td class="title" id="f_startyear"><font color="red">*</font>起止年份</td><td>
		  <select id="startYear" name="startYear"  style="width:150px">
         <option value="">请选择开始年份</option>
         <#list 1..planYears as i>
             <option value="${i}">${i}</option>
         </#list>
         </select>
         -
 		  <select id="endYear" name="endYear"  style="width:150px">
         <option value="">请选择结束年份</option>
         <#list 1..planYears as i>
             <option value="${i}">${i}</option>
         </#list>
         </select>        
		</td></tr>
		<tr><td class="title" id="f_rate">变化比率</td><td><input id="rate" name="rate" value="">变化比率与变化量必填一项，且只能填一项</td></tr>
		<tr><td class="title" id="f_amount">变化量</td><td><input id="amount" name="amount" value=""></td></tr>
		<tr class="darkColumn" align="center"><td colspan="2"><input type="button" onClick='save(this.form)' value="提交"></td></tr>
		</form>
	</table>

  <script language="javascript">
     var bar = new ToolBar("toolbar","其他支出规划",null,true,true);
     bar.setMessage('<@getMessage/>');
     bar.addBack();
  </script>
  
  <script language="javascript" > 
    function save(form){
         var a_fields = {
             'expense':{'l':'其他支出','r':true,'t':'f_expense','f':'unsignedReal'},
             'startYear':{'l':'开始年份', 'r':true,'t':'f_startyear','f':'unsigned'},
             'endYear':{'l':'结束年份', 'r':true,'t':'f_startyear','f':'unsigned'},
             'rate':{'l':'变化比率', 't':'f_rate','f':'real'},
             'amount':{'l':'变化量','t':'f_amount','f':'real'}
         };
		 var v = new validator(form , a_fields, null);
		 if (v.exec()) {
		 	if((document.getElementById('rate').value=="")&&(document.getElementById('amount').value==""))
		 	{
				alert("变化比率与变化量必填一项！");return;
		 	}
		 	if((document.getElementById('rate').value!="")&&(document.getElementById('amount').value!=""))
		 	{
				alert("变化比率与变化量只能填一项！");return;
		 	}
		   if(parseInt(document.getElementById('startYear').value)>parseInt(document.getElementById('endYear').value))
		 	{
		 		alert("开始年份必须大于等于结束年份！");return;		 		
		 	}
		 	form.submit();
		 }
   }
</script>
</body>
 <#include "/template/foot.ftl"/>