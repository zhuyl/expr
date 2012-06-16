 <#include "/template/head.ftl"/>
 <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Validator.js"></script>
<body>
<table id="toolbar"></table>
	<table id="formTable" class="formTable" align="center" width="80%">
	<form name="actionForm" method="post" action="${base}/answer/estateLoanPlan!save.action">
		<input type="hidden" name="params" value="&caze.id=${Parameters['caze.id']}">
		<input type="hidden" name="caze.id" value="${Parameters['caze.id']}">
		<input type="hidden" name="loanType" value="${Parameters['loanType']}">
		<tr>
			<td class="title" id="f_payType"><font color="red">*</font>还款方式</td>
			<td>
			<select id="payType" name="payType">
				<option value="averageCapital">等额本金</option>
				<option value="averageCapitalInterest">等额本息</option>
			</select>
			</td>
			<td class="title" id="f_rate"><font color="red">*</font>年利率</td><td><input id="rate" name="rate" value="">%</td>
		</tr>
		<tr><td class="title" id="f_startYear"><font color="red">*</font>起止年份</td><td><input id="startYear" name="startYear" value="0" width="30px"></td>
			<td class="title" id="f_years"><font color="red">*</font>按揭年数</td><td>
			<select id="years" name="years" >
			<#list 1..20 as year>
			<OPTION value="${year}">${year}年（${12*year}期）</OPTION>
			</#list>
			<OPTION value=25>25年（300期）</OPTION>
			<OPTION value=30>30年（360期）</OPTION>
			</select>
			</td>
		</tr>
		<tr ><td class="title" id="f_capital"><font color="red">*</font>贷款总额</td><td colspan="3"><input id="capital" name="capital" value="${total?if_exists}">元</td></tr>
		<tr class="darkColumn" align="center"><td colspan="4"><input type="button" onClick='save(this.form)' value="提交"></td></tr>
		</form>
	</table>

  <script language="javascript">
     var bar = new ToolBar("toolbar","房产规划",null,true,true);
     bar.setMessage('<@getMessage/>');
     bar.addBack();
     
     function save(form){
         var a_fields = {
             'payType':{'l':'还款方式','r':true,'t':'f_payType'},
             'startYear':{'l':'开始年份', 'r':true,'t':'f_startYear','f':'unsigned'},
             'years':{'l':'按揭年数', 'r':true,'t':'f_years','f':'unsigned'},
             'rate':{'l':'年利率','r':true,'t':'f_rate','f':'real'},
             'capital':{'l':'贷款总额','r':true,'t':'f_capital','f':'unsigned'}
         };
		 var v = new validator(form , a_fields, null);
		 if (v.exec()) {
		 	form.submit();
		 }
     }
  </script>
</body>
 <#include "/template/foot.ftl"/>