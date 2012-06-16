 <#include "/template/head.ftl"/>
 <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Validator.js"></script>
 
<body>
<table id="toolbar"></table>
	<table id="formTable" class="formTable" align="center" width="80%">
	<form name="actionForm" method="post" action="${base}/answer/investmentPlan!save.action">
		<input type="hidden" name="params" value="&caze.id=${Parameters['caze.id']}">
		<input type="hidden" name="caze.id" value="${Parameters['caze.id']}">
		<tr><td class="title" id='f_expense'><font color="red">*</font>金融投资</td><td><input id="expense" name="expense" value=""/></td></tr>
		<tr><td class="title" id="f_startyear"><font color="red">*</font>起止年份</td><td><input id="startYear" name="startYear" value="1" width="30px">-<input name="endYear" value="" width="30px"></td></tr>
		<tr><td class="title" id="f_rate">变化比率</td><td><input id="rate" name="rate" value="">变化比率与变化量必填一项，且只能填一项</td></tr>
		<tr><td class="title" id="f_amount">变化量</td><td><input id="amount" name="amount" value=""></td></tr>
		<tr class="darkColumn" align="center"><td colspan="2"><input type="button" onClick='save(this.form)' value="提交"></td></tr>
		</form>
	</table>

  <script language="javascript">
     var bar = new ToolBar("toolbar","金融投资规划",null,true,true);
     bar.setMessage('<@getMessage/>');
     bar.addBack();
  </script>
  <script language="javascript" > 
    function save(form){
         var a_fields = {
             'expense':{'l':'金融投资','r':true,'t':'f_expense','f':'unsignedReal'},
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
		 	form.submit();
		 }
   }
</script>
</body>
 <#include "/template/foot.ftl"/>