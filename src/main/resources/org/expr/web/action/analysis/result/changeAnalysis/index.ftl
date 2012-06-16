<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Validator.js"></script>
<table id="taskBar"></table>
  <table class="formTable" align="center" width="80%">
	<form name="editForm" method="post" action="${base}/result/changeAnalysis!saveRemark.action">
	<input type="hidden" name="experiment.id" value="${Parameters['experiment.id']}">
	<tr><td>动态平衡:
	<textarea id="noticeContent" name="remark"  style="font-size:10pt;width:100%;height:80px">${(result.remark)!}</textarea>
 	</td></tr>
 	<tr><td align="right"><input value="提交" type="submit"></td></tr>
 </form>
 </table>
 
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0" class="listTable">
<form name="actionForm" method="post" action="changeAnalysis!saveIncomeExpense.action">
<tr>
    <td colspan="10" class="darkColumn" align="center"> 
第${changeYear}年的收支表
</td>
</tr>
  <#if (result.id)?exists>
  <input name="result.id" type="hidden" value="${result.id}"/>
  <#else>
  <input name="result.experiment.id" type="hidden" value="${Parameters['experiment.id']}"/>
  </#if>
  <input name="params" type="hidden" value="&experiment.id=<#if Parameters['experiment.id']?exists>${Parameters['experiment.id']}<#else>${result.experiment.id}</#if>"/>
 <tr height="22"> 
    <td colspan="5" class="darkColumn"> <div align="center">收入</div></td>
    <td colspan="5" class="darkColumn"> <div align="center">支出</div></td>
  </tr>
  <tr height="22"> 
    <td width="20%" class="darkColumn"> <div align="center">收入项目</div></td>
    <td width="10%" class="darkColumn"> <div align="center">金额</div></td>
    <td width="5%" class="darkColumn"> <div align="center">比重</div></td>
    <td width="10%" class="darkColumn"> <div align="center">金额</div></td>
    <td width="5%" class="darkColumn"> <div align="center">比重</div></td>
    <td width="20%" class="darkColumn"> <div align="center">支出项目</div></td>
    <td width="10%" class="darkColumn"> <div align="center">金额</div></td>
    <td width="5%" class="darkColumn"> <div align="center">比重</div></td>
    <td width="10%" class="darkColumn"> <div align="center">金额</div></td>
    <td width="5%" class="darkColumn"> <div align="center">比重</div></td>
  </tr>
  <#assign maxItems=incomeProjects?size>
  <#if (maxItems<expendProjects?size)><#assign maxItems=expendProjects?size></#if>
  <#list 0..maxItems-1 as i>
  <tr height="22">
  <#if (i<incomeProjects?size)>
    <td class="grayStyle" id="f_incomeProject${incomeProjects[i].id}" <#if !(incomeProjects[i].parent)?exists>style="font-weight:bold;"</#if>>${(incomeProjects[i].name)?default("&nbsp;")}</td>
    <td class="brightStyle">${(incomeMap?if_exists[(incomeProjects[i].id?string)?default('0')])?if_exists}</td>
    <td class="brightStyle">
    <#if incomeMap?if_exists[(incomeProjects[i].id?string?default('0'))]?exists && (totalincome)?exists && (totalincome)?if_exists != 0>
    	${(incomeMap?if_exists[(incomeProjects[i].id?string)?default('0')])?if_exists/(totalincome)?if_exists*100}%
    </#if>
    </td>
    <td class="brightStyle">
    	<input name="incomeProject${incomeProjects[i].id}"
	    <#if incomeProjects[i].children?size!=0>readOnly<#else> tabindex="${i+1}"  onchange="calcSum('incomeProject${incomeProjects[i].id}')"</#if>
    	 type="text" value="${(changeIncomeMap?if_exists[(incomeProjects[i].id?string)?default('0')])?if_exists}" 
    	 style="width:100%"/>
    </td>
    <td class="brightStyle" id="label_incomeProject${incomeProjects[i].id}">
    <#if changeIncomeMap?if_exists[(incomeProjects[i].id?string?default('0'))]?exists && (totalchangeincome)?exists && (totalchangeincome)?if_exists != 0>
    	${(changeIncomeMap?if_exists[(incomeProjects[i].id?string)?default('0')])?if_exists/(totalchangeincome)?if_exists*100}%
    </#if>
    </td>
  <#else>
    <td class="grayStyle"></td>
    <td class="brightStyle"></td>
    <td class="brightStyle"></td>
    <td class="brightStyle"></td>
    <td class="brightStyle"></td>
  </#if>
  <#if (i<expendProjects?size)>
    <td class="grayStyle" id="f_expendProject${expendProjects[i].id}" <#if !(expendProjects[i].parent)?exists>style="font-weight:bold;"</#if>>${(expendProjects[i].name)?default("&nbsp;")}</td>
    <td class="brightStyle">${(expendMap?if_exists[(expendProjects[i].id?string)?default('0')])?if_exists}</td>
	<td class="brightStyle">
    <#if expendMap?if_exists[(expendProjects[i].id?string?default('0'))]?exists && (totalexpend)?exists && (totalexpend)?if_exists != 0>
    	${(expendMap?if_exists[(expendProjects[i].id?string)?default('0')])?if_exists/(totalexpend)?if_exists*100}%
    </#if>
    </td>
    <td class="brightStyle">
    <input name="expendProject${expendProjects[i].id}" type="text" 
    <#if expendProjects[i].children?size!=0>readOnly<#else> tabindex="${i+maxItems+1}"  onchange="calcSum('expendProject${expendProjects[i].id}')"</#if>
    value="${(changeExpendMap?if_exists[(expendProjects[i].id?string)?default('0')])?if_exists}" style="width:100%"/>
    </td>
	<td class="brightStyle" id="label_expendProject${expendProjects[i].id}">
    <#if changeExpendMap?if_exists[(expendProjects[i].id?string?default('0'))]?exists && (totalchangeexpend)?exists && (totalchangeexpend)?if_exists != 0>
    	${(changeExpendMap?if_exists[(expendProjects[i].id?string)?default('0')])?if_exists/(totalchangeexpend)?if_exists*100}%
    </#if>
    </td>
  <#else>
    <td class="grayStyle"></td>
    <td class="brightStyle"></td>
    <td class="brightStyle"></td>
  </#if>
  </tr>
  </#list>
  <tr height="22"> 
    <td class="grayStyle" id="f_totalIncome" ><strong>总收入</strong></td>
    <td class="brightStyle" colspan="4">${(totalincome)?if_exists},调整后:<input readOnly name="result.form.totalIncome" type="text" value="${(totalchangeincome)?if_exists}" style="width:100px"/></td>
    <td class="grayStyle" id="f_totalExpend"><strong>总支出</strong></td>
    <td class="brightStyle" colspan="4">${(totalexpend)?if_exists},调整后:<input readOnly name="result.form.totalExpend" type="text" value="${(totalchangeexpend)?if_exists}" style="width:100px"/></td>
  </tr>
  <tr height="22">
    <td class="grayStyle" id="f_totalBalance"><strong>总结余</strong></td>
    <td colspan="9" class="brightStyle">${(totalbalance)?if_exists},调整后:<input  readOnly name="result.form.totalBalance" type="text" value="${(totalchangebalance)?if_exists}" style="width:100px"/></td>
  </tr>
  <tr> 
    <td class="darkColumn" colspan="10" align="center"><input type="submit" value="提交"/></td>
  </tr>
</form>
</table>
<script>
  var bar = new ToolBar('taskBar', '动态平衡', null, true, false);
  bar.setMessage('<@getMessage/>');
  bar.addBlankItem();
  a_formats['money']=/^\d*\.?\d{0,2}$/;
  function save(){
  	var form=document.actionForm;
     var a_fields = {
     <#list 0..maxItems-1 as i>
     	<#if incomeProjects[i]??>
         'incomeProject${incomeProjects[i].id}':{'l':'${incomeProjects[i].name}', 'r':true,'f':'money', 't':'f_incomeProject${incomeProjects[i].id}'},
        </#if>
        <#if expendProjects[i]??>
         'expendProject${expendProjects[i].id}':{'l':'${expendProjects[i].name}', 'r':true,'f':'money', 't':'f_expendProject${expendProjects[i].id}'},
        </#if>
     </#list>
        'result.form.totalIncome':{'l':'总收入', 'r':true,'f':'money', 't':'f_totalIncome'},
        'result.form.totalExpend':{'l':'总支出', 'r':true,'f':'money', 't':'f_totalExpend'},
        'result.form.totalBalance':{'l':'总结余', 'r':true,'f':'money', 't':'f_totalBalance'}
     };
	 var v = new validator(form , a_fields, null);
	 if (v.exec()) {
	    form.submit();
	 }
  }
  	var itemTree=new Object();
	<#list incomeProjects as ap>
	<#if ap.parent??>itemTree['incomeProject${ap.id}']='incomeProject${ap.parent.id}';
	<#else>
	itemTree['incomeProject${ap.id}']='result.form.totalIncome';
	</#if>
	</#list>
	<#list expendProjects as bp>
	<#if bp.parent??>itemTree['expendProject${bp.id}']='expendProject${bp.parent.id}';
	<#else>
	itemTree['expendProject${bp.id}']='result.form.totalExpend';
	</#if>
	</#list>
	itemTree['result.form.totalIncome']='result.form.totalBalance';
	itemTree['result.form.totalExpend']='result.form.totalBalance';
	//计算汇总
	
	var childTree=new Object();
	function getChildren(parentId){
		if((typeof childTree[parentId]) == "undefined"){
			var mychildIds=new Array();
			for(var id in itemTree){
				if(parentId==itemTree[id]){
					mychildIds.push(id);
				}
			}
			childTree[parentId]=mychildIds;
		}
		return childTree[parentId];
	}
	var isCalcAssert=true;
	function calcSum(parentId){
		if(parentId==null) return;
		if(parentId=='result.form.totalIncome'){
			isCalcAssert=true;
		}else if(parentId=='result.form.totalExpend'){
			isCalcAssert=false;
		}
		var sum=0;
		var childIds=getChildren(parentId);
		for(var i=0;i<childIds.length;i++){
			id=childIds[i]
			value=document.actionForm[id].value;
			if(value=="") continue;
			if(id=='result.form.totalExpend'){
				value="-"+value;
			}
			var myVal=parseFloat(value);
			if(!isNaN(myVal)){
				sum+=myVal;
			}else {
				alert(value+" 不是数字");
				document.actionForm[id].value="";
			}
		}
		if(childIds.length>0){
		sum=Math.round(sum*100)/100
			document.actionForm[parentId].value=sum;
		}
		if((typeof itemTree[parentId])!="undefined"){
			calcSum(itemTree[parentId]);
		}else{
			if(isCalcAssert){
				refreshPersent('result.form.totalIncome',null);
			}else{
				refreshPersent('result.form.totalExpend',null);
			}
		}
	}
	
	function refreshPersent(rootId,sum){
		if(null==sum || sum <= 0){
			var sumStr= document.actionForm[rootId].value;
			if(""==sumStr) return;
			sum=parseFloat(sumStr);
			if(isNaN(sum)) return;
		}
		var childIds=getChildren(rootId);
		for(var i=0;i<childIds.length;i++){
			var valueStr= document.actionForm[childIds[i]].value;
			if(""==valueStr) {
				document.getElementById('label_'+childIds[i]).innerHTML="";
				continue;
			}
			myvalue=parseFloat(valueStr);
			document.getElementById('label_'+childIds[i]).innerHTML=Math.round(myvalue*10000/sum)/100 +"%";
			refreshPersent(childIds[i],sum);
		}
	}
</script>
<#include "/template/foot.ftl"/>