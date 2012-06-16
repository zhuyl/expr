<#include "/template/head.ftl"/>
<body>
<table id="taskBar"></table>
<script>
  var bar = new ToolBar('taskBar', '家庭资产负债分析', null, true, false);
  bar.setMessage('<@getMessage/>');
  bar.addBlankItem();
  function save(){
  
    document.actionForm.submit();
  }
</script>
  <table class="formTable" align="center" width="80%">
	<form name="editForm" method="post" action="${base}/result/balanceSheet!saveRemark.action">
	<input type="hidden" name="experiment.id" value="${Parameters['experiment.id']}">
	<tr><td>家庭资产负债分析说明:
	<textarea id="noticeContent" name="remark"  style="font-size:10pt;width:100%;height:80px">${(analysisResult.remark)!}</textarea>
 	</td></tr>
 	<tr><td align="right"><input value="提交" type="submit"></td></tr>
 </form>
 </table>
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0" class="listTable">
<form name="actionForm" method="post" action="balanceSheet!saveBalanceSheet.action">
  <#if (result.id)?exists>
  <input name="result.id" type="hidden" value="${result.id}"/>
  <#else>
  <input name="result.experiment.id" type="hidden" value="${Parameters['experiment.id']}"/>
  </#if>
  <input name="params" type="hidden" value="&experiment.id=<#if Parameters['experiment.id']?exists>${Parameters['experiment.id']}<#else>${result.experiment.id}</#if>"/>
  <tr height="22"> 
    <td colspan="3" class="darkColumn"> <div align="center">资产</div></td>
    <td colspan="3" class="darkColumn"> <div align="center">负债</div></td>
  </tr>
  <tr height="22"> 
    <td width="20%" class="darkColumn"> <div align="center">资产项目</div></td>
    <td width="20%" class="darkColumn"> <div align="center">金额</div></td>
    <td width="10%" class="darkColumn"> <div align="center">比重</div></td>
    <td width="20%" class="darkColumn"> <div align="center">负债项目</div></td>
    <td width="20%" class="darkColumn"> <div align="center">金额</div></td>
    <td width="10%" class="darkColumn"> <div align="center">比重</div></td>
  </tr>
  <#assign maxItems=assetProjects?size>
  <#if (maxItems<liabilityProjects?size)><#assign maxItems=liabilityProjects?size></#if>
  <#list 0..maxItems-1 as i>
  <tr height="22">
  <#if (i<assetProjects?size)>
  <#assign isSummary=false>
  <#if !(assetProjects[i].parent)?exists><#assign isSummary=true /></#if>
    <td ${isSummary?string('class="grayStyle" style="font-weight:bold;"','class="grayStyle"')}>${(assetProjects[i].name)?default("&nbsp;")}</td>
    <td ${isSummary?string('class="grayStyle" style="font-weight:bold;"','class="brightStyle"')}>
    <input name="assetProject${assetProjects[i].id}" 
    type="text" <#if isSummary>readOnly<#else> tabindex="${i+1}"  onchange="calcSum('assetProject${assetProjects[i].parent.id}')"</#if>  value="${(assetMap[(assetProjects[i].id?string)?default('0')])?if_exists}" 
    style="width:100%"/>
    </td>
    <td ${isSummary?string('class="grayStyle" style="font-weight:bold;"','class="brightStyle"')} id="label_assetProject${assetProjects[i].id}">
    <#if assetMap[(assetProjects[i].id?string?default('0'))]?exists && (result.form.totalAssets)?exists && (result.form.totalAssets)?if_exists != 0>
    	${(assetMap[(assetProjects[i].id?string)?default('0')])?if_exists/(result.form.totalAssets)?if_exists*100}%
    </#if>
    </td>
  <#else>
    <td class="grayStyle"></td>
    <td class="brightStyle"></td>
    <td class="brightStyle"></td>
  </#if>
  <#if (i<liabilityProjects?size)>
  	<#assign isSummary=false>
    <#if !(liabilityProjects[i].parent)?exists><#assign isSummary=true /></#if>
    <td ${isSummary?string('class="grayStyle" style="font-weight:bold;"','class="grayStyle"')}>${(liabilityProjects[i].name)?default("&nbsp;")}</td>
    <td ${isSummary?string('class="grayStyle" style="font-weight:bold;"','class="brightStyle"')} >
    <input name="liabilityProject${liabilityProjects[i].id}"  type="text" <#if isSummary>readOnly<#else> tabindex="${i+maxItems+1}" onchange="calcSum('liabilityProject${liabilityProjects[i].parent.id}')"</#if> value="${(liabilityMap[(liabilityProjects[i].id?string)?default('0')])?if_exists}" style="width:100%"/>
    </td>
    <td ${isSummary?string('class="grayStyle" style="font-weight:bold;"','class="brightStyle"')} id="label_liabilityProject${liabilityProjects[i].id}">
	<#if liabilityMap[(liabilityProjects[i].id?string?default('0'))]?exists && (result.form.totalLiabilities)?exists && (result.form.totalLiabilities)?if_exists != 0>
    	${(liabilityMap[(liabilityProjects[i].id?string)?default('0')])?if_exists/(result.form.totalLiabilities)?if_exists*100}%
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
    <td class="grayStyle"><strong>总资产</strong></td>
    <td class="grayStyle" colspan="2"><input name="result.form.totalAssets" readOnly type="text" value="${(result.form.totalAssets)?if_exists}" style="width:100%"/></td>
    <td class="grayStyle"><strong>总负债</strong></td>
    <td class="grayStyle"  colspan="2"><input name="result.form.totalLiabilities" readOnly type="text" value="${(result.form.totalLiabilities)?if_exists}" style="width:100%"/></td>
  </tr>
  <tr height="22"> 
    <td class="grayStyle"><strong>总净值</strong></td>
    <td colspan="5" class="brightStyle"><input name="result.form.totalNet" type="text"  readOnly value="${(result.form.totalNet)?if_exists}" style="width:100%"/></td>
  </tr>
  <tr> 
    <td class="darkColumn" colspan="6" align="center"><input type="submit" value="提交"/></td>
  </tr>
  </form>
</table>
<script>
	var itemTree=new Object();
	<#list assetProjects as ap>
	<#if ap.parent??>itemTree['assetProject${ap.id}']='assetProject${ap.parent.id}';
	<#else>
	itemTree['assetProject${ap.id}']='result.form.totalAssets';
	</#if>
	</#list>
	<#list liabilityProjects as bp>
	<#if bp.parent??>itemTree['liabilityProject${bp.id}']='liabilityProject${bp.parent.id}';
	<#else>
	itemTree['liabilityProject${bp.id}']='result.form.totalLiabilities';
	</#if>
	</#list>
	itemTree['result.form.totalAssets']='result.form.totalNet';
	itemTree['result.form.totalLiabilities']='result.form.totalNet';
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
		if(parentId=='result.form.totalAssets'){
			isCalcAssert=true;
		}else if(parentId=='result.form.totalLiabilities'){
			isCalcAssert=false;
		}
		var sum=0;
		var childIds=getChildren(parentId);
		for(var i=0;i<childIds.length;i++){
			id=childIds[i]
			value=document.actionForm[id].value;
			if(value=="") continue;
			if(id=='result.form.totalLiabilities'){
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
			document.actionForm[parentId].value=sum;
		}
		if((typeof itemTree[parentId])!="undefined"){
			calcSum(itemTree[parentId]);
		}else{
			if(isCalcAssert){
				refreshPersent('result.form.totalAssets',null);
			}else{
				refreshPersent('result.form.totalLiabilities',null);
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
</body>
<#include "/template/foot.ftl"/>