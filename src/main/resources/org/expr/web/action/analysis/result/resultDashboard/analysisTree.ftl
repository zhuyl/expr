 <#include "/template/simpleHead.ftl"/>
 <script language="javascript" src="${base}/static/scripts/common/SelectableTree.js"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/ieemu.js"></script>
 <body style="overflow-x:auto;overflow-y:auto;" LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0" 
 BGCOLOR="#EEEEEE">
 <table width="100%" height="100%"  background="/skaily/static/images/leftbg.gif">
 <tr>
	 <td height="20" background="${base}/static/images/leftbanbg.gif">
	 <img src="${base}/static/images/arrowL.gif" width="13" height="13"> 
	                        <span class="subtitle">学习记录</span>
	 </td>
 </tr>
  <tr>
   <td height="10">实验时间:<B>${experiment.beginAt?string("yy-MM-dd HH:mm")}</B>
	<br><B>${experiment.endAt?string("yy-MM-dd HH:mm")}</B>
	<br>本次学习时间:<B><span id="studyTimeSpan"></span></B>
	<br><a href="${base}/result/resultDashboard!studyLogs.action?experimentId=${experiment.id}" target="answerMain">[学习记录]</a>&nbsp;&nbsp;<a href="#" onclick="logoutStudy()">[退出学习]</a>
	<form name="logoutForm" action="${base}/result/resultDashboard!endStudy.action" method="post">
	</form>
	</td>
  </tr>
   <tr>
	 <td height="20" background="${base}/static/images/leftbanbg.gif">
	 <img src="${base}/static/images/arrowL.gif" width="13" height="13"><span class="subtitle">分析与规划</span>
	 </td>
 </tr>
  <tr>
   <td valign="top">
	  <SCRIPT language="javascript">
		var menuTree = new MenuToc_toc('menuTree');
		menuTree.multiSelect = true;
		menuTree.selectChildren = false;
		menuTree.styleSelected = 'MenuTocSelected';
		menuTree.styleNotSelected = 'MenuTocItemLinkStyle';
		menuTree.onClick = '';
		menuTree.styleItemLink = 'MenuTocItemLinkStyle';
		menuTree.styleItemNoLink = 'MenuTocItemNoLinkStyle';
		menuTree.styleItemFolderLink = 'MenuTocItemFolderLinkStyle';
		menuTree.styleItemFolderNoLink = 'MenuTocItemFolderNoLinkStyle';
		menuTree.showRoot = false;
		menuTree.showIcons = true;
		menuTree.showTextLinks = true;
		menuTree.iconWidth = '24';
		menuTree.iconHeight = '22';
		menuTree.iconPath = '';
		menuTree.iconEmpty = '${base}/images/tree/empty.gif';
		menuTree.iconPlus = '${base}/images/tree/plus.gif';
		menuTree.iconPlus1 = '${base}/images/tree/plus.gif';
		menuTree.iconPlus2 = '${base}/images/tree/plus.gif';
		menuTree.iconMinus = '${base}/images/tree/minus.gif';
		menuTree.iconMinus1 = '${base}/images/tree/minus.gif';
		menuTree.iconMinus2 = '${base}/images/tree/minus.gif';
		menuTree.iconLine1 = '${base}/images/tree/line.gif';
		menuTree.iconLine2 = '${base}/images/tree/line.gif';
		menuTree.iconLine3 = '${base}/images/tree/line.gif';
		menuTree.iconItem = '${base}/images/tree/sanjiao.gif';
		menuTree.iconFolderCollapsed = '${base}/images/tree/entityfolder.gif';
		menuTree.iconFolderExpanded = '${base}/images/tree/entityfolder.gif';
		menuTree.node0 = menuTree.makeFolder('根节点','','','','1');
		     <#if analysisPhaseSet?seq_contains("01")>
		     menuTree.node01 = menuTree.makeFolder("客户分析",'javascript:menuTree.nodeClicked(1)','','',"客户分析");
		     menuTree.insertNode(menuTree.node0, menuTree.node01);
				 <#if analysisSet?seq_contains("0101")>
				 menuTree.node0101 = menuTree.makeItem("家庭基本信息分析",'${base}/result/familyAnalysis!search.action?experiment.id=${experiment.id}','answerMain','',"家庭基本信息分析", 'javascript:menuTree.nodeClickedAndSelected(2)');
			     menuTree.insertNode(menuTree.node01, menuTree.node0101);
				 </#if>
				 <#if analysisSet?seq_contains("0102")>
				 menuTree.node0102 = menuTree.makeItem("家庭资产负债分析",'${base}/result/balanceSheet.action?experiment.id=${experiment.id}','answerMain','',"家庭资产负债分析", 'javascript:menuTree.nodeClickedAndSelected(3)');
			     menuTree.insertNode(menuTree.node01, menuTree.node0102);
				 </#if>
				 <#if analysisSet?seq_contains("0103")>
				 menuTree.node0103 = menuTree.makeItem("家庭月度收支分析",'${base}/result/incomeExpense.action?experiment.id=${experiment.id}','answerMain','',"家庭月度收支分析", 'javascript:menuTree.nodeClickedAndSelected(4)');
			     menuTree.insertNode(menuTree.node01, menuTree.node0103);
				 </#if>
				 <#if analysisSet?seq_contains("0104")>
				 menuTree.node0104 = menuTree.makeItem("保险资产明细分析",'${base}/result/insuranceAnalysis!search.action?experiment.id=${experiment.id}','answerMain','',"保险资产明细分析", 'javascript:menuTree.nodeClickedAndSelected(5)');
			     menuTree.insertNode(menuTree.node01, menuTree.node0104);
				 </#if>
				 <#if analysisSet?seq_contains("0105")>
				 menuTree.node0105 = menuTree.makeItem("金融资产明细分析",'${base}/result/financeAssetAnalysis!search.action?experiment.id=${experiment.id}','answerMain','',"金融资产明细分析", 'javascript:menuTree.nodeClickedAndSelected(6)');
			     menuTree.insertNode(menuTree.node01, menuTree.node0105);
				 </#if>
				 <#if analysisSet?seq_contains("0106")>
				 menuTree.node0106 = menuTree.makeItem("客户风险承受能力分析",'${base}/result/riskToleranceAnalysis.action?experiment.id=${experiment.id}','answerMain','',"客户风险承受能力分析", 'javascript:menuTree.nodeClickedAndSelected(7)');
			     menuTree.insertNode(menuTree.node01, menuTree.node0106);
			     </#if>
				 <#if analysisSet?seq_contains("0107")>
				 menuTree.node0107 = menuTree.makeItem("客户分析综述",'${base}/result/analysisSummary.action?experiment.id=${experiment.id}','answerMain','',"客户分析综述", 'javascript:menuTree.nodeClickedAndSelected(8)');
			     menuTree.insertNode(menuTree.node01, menuTree.node0107);
			     </#if>
			 </#if>	
 		     <#if analysisPhaseSet?seq_contains("02")>    
		     menuTree.node02 = menuTree.makeFolder("理财目标分析",'javascript:menuTree.nodeClicked(9)','','',"理财目标分析");
        	 menuTree.insertNode(menuTree.node0, menuTree.node02);
				 <#if analysisSet?seq_contains("0201")>
			 	 menuTree.node0201 = menuTree.makeItem("客户理财目标分析",'${base}/result/aimAnalysis!search.action?experiment.id=${experiment.id}','answerMain','',"客户理财目标分析", 'javascript:menuTree.nodeClickedAndSelected(10)');
			     menuTree.insertNode(menuTree.node02, menuTree.node0201);
			     </#if>
			 </#if>
		     <#if analysisPhaseSet?seq_contains("03")>  
		     menuTree.node03 = menuTree.makeFolder("理财规划",'javascript:menuTree.nodeClicked(11)','','',"理财规划");
		     menuTree.insertNode(menuTree.node0, menuTree.node03);
				 <#if analysisSet?seq_contains("0301")>
				 menuTree.node0301 = menuTree.makeItem("工作收入规划",'${base}/result/cashPlan.action?experiment.id=${experiment.id}','answerMain','',"工作收入规划", 'javascript:menuTree.nodeClickedAndSelected(12)');
			     menuTree.insertNode(menuTree.node03, menuTree.node0301);
			     </#if>
				 <#if analysisSet?seq_contains("0302")>
			     menuTree.node0302 = menuTree.makeItem("奖金收入规划",'${base}/result/bonusPlan.action?experiment.id=${experiment.id}','answerMain','',"奖金收入规划", 'javascript:menuTree.nodeClickedAndSelected(13)');
			     menuTree.insertNode(menuTree.node03, menuTree.node0302);
			     </#if>
				 <#if analysisSet?seq_contains("0303")>
			     menuTree.node0303 = menuTree.makeItem("其他收入规划",'${base}/result/otherIncomePlan.action?experiment.id=${experiment.id}','answerMain','',"其他收入规划", 'javascript:menuTree.nodeClickedAndSelected(14)');
			     menuTree.insertNode(menuTree.node03, menuTree.node0303);
			     </#if>
				 <#if analysisSet?seq_contains("0304")>
			     menuTree.node0304 = menuTree.makeItem("消费支出规划",'${base}/result/consumePlan.action?experiment.id=${experiment.id}','answerMain','',"消费支出规划", 'javascript:menuTree.nodeClickedAndSelected(15)');
			     menuTree.insertNode(menuTree.node03, menuTree.node0304);
			     </#if>
				 <#if analysisSet?seq_contains("0305")>
			     menuTree.node0305 = menuTree.makeItem("教育支出规划",'${base}/result/educationPlan.action?experiment.id=${experiment.id}','answerMain','',"教育支出规划", 'javascript:menuTree.nodeClickedAndSelected(16)');
			     menuTree.insertNode(menuTree.node03, menuTree.node0305);
			     </#if>
				 <#if analysisSet?seq_contains("0306")>
			     menuTree.node0306 = menuTree.makeItem("保险支出规划",'${base}/result/insurancePlan.action?experiment.id=${experiment.id}','answerMain','',"保险支出规划", 'javascript:menuTree.nodeClickedAndSelected(17)');
			     menuTree.insertNode(menuTree.node03, menuTree.node0306);
			     </#if>
				 <#if analysisSet?seq_contains("0307")>
			     menuTree.node0307 = menuTree.makeItem("医疗支出规划",'${base}/result/medicalPlan.action?experiment.id=${experiment.id}','answerMain','',"医疗支出规划", 'javascript:menuTree.nodeClickedAndSelected(18)');
			     menuTree.insertNode(menuTree.node03, menuTree.node0307);
			     </#if>
				 <#if analysisSet?seq_contains("0308")>
			     menuTree.node0308 = menuTree.makeItem("旅游支出规划",'${base}/result/tripPlan.action?experiment.id=${experiment.id}','answerMain','',"旅游支出规划", 'javascript:menuTree.nodeClickedAndSelected(19)');
			     menuTree.insertNode(menuTree.node03, menuTree.node0308);
			     </#if>
				 <#if analysisSet?seq_contains("0309")>
			     menuTree.node0309 = menuTree.makeItem("投资支出规划",'${base}/result/financeAssetPlan!search.action?experiment.id=${experiment.id}','answerMain','',"投资支出规划", 'javascript:menuTree.nodeClickedAndSelected(20)');
			     menuTree.insertNode(menuTree.node03, menuTree.node0309);
			     </#if>
				 <#if analysisSet?seq_contains("0310")>
			     menuTree.node0310 = menuTree.makeItem("购车支出规划",'${base}/result/carPlan.action?experiment.id=${experiment.id}','answerMain','',"购车支出规划", 'javascript:menuTree.nodeClickedAndSelected(21)');
			     menuTree.insertNode(menuTree.node03, menuTree.node0310);
			     </#if>
				 <#if analysisSet?seq_contains("0311")>
			     menuTree.node0311 = menuTree.makeItem("房产支出规划",'${base}/result/estateLoanPlan.action?experiment.id=${experiment.id}','answerMain','',"房产支出规划", 'javascript:menuTree.nodeClickedAndSelected(22)');
			     menuTree.insertNode(menuTree.node03, menuTree.node0311);
			     </#if>
			     <#if analysisSet?seq_contains("0312")>
			     menuTree.node0312 = menuTree.makeItem("其他支出规划",'${base}/result/otherExpensePlan.action?experiment.id=${experiment.id}','answerMain','',"其他支出规划", 'javascript:menuTree.nodeClickedAndSelected(23)');
			     menuTree.insertNode(menuTree.node03, menuTree.node0312);
			     </#if>
			     <#if analysisSet?seq_contains("0313")>
			     menuTree.node0313 = menuTree.makeItem("综合理财规划",'${base}/result/planSummary.action?experiment.id=${experiment.id}','answerMain','',"综合理财规划", 'javascript:menuTree.nodeClickedAndSelected(24)');
			     menuTree.insertNode(menuTree.node03, menuTree.node0313);
			     </#if>
		     </#if>
		     <#if analysisPhaseSet?seq_contains("04")>  
		     menuTree.node04 = menuTree.makeFolder("动态平衡",'javascript:menuTree.nodeClicked(25)','','',"动态平衡");
		     menuTree.insertNode(menuTree.node0, menuTree.node04);
				 <#if analysisSet?seq_contains("0401")>
		     	menuTree.node0401 = menuTree.makeItem("动态平衡调整",'${base}/result/changeAnalysis.action?experiment.id=${experiment.id}','answerMain','',"动态平衡调整", 'javascript:menuTree.nodeClickedAndSelected(26)');
		     	menuTree.insertNode(menuTree.node04, menuTree.node0401);
			     </#if>
		     </#if>	
   		     <#if analysisPhaseSet?seq_contains("05")>  
		     menuTree.node05 = menuTree.makeFolder("理财方案评估",'javascript:menuTree.nodeClicked(27)','','',"理财方案评估");
		     menuTree.insertNode(menuTree.node0, menuTree.node05);
				 <#if analysisSet?seq_contains("0501")>
		     	menuTree.node0501 = menuTree.makeItem("单个产品收益率分析",'${base}/result/benefitAnalysis!search.action?experiment.id=${experiment.id}','answerMain','',"单个产品收益率分析", 'javascript:menuTree.nodeClickedAndSelected(28)');
		     	menuTree.insertNode(menuTree.node05, menuTree.node0501);
			     </#if>
			     <#if analysisSet?seq_contains("0502")>
		     	menuTree.node0502= menuTree.makeItem("单个产品风险分析",'${base}/result/riskAnalysis!search.action?experiment.id=${experiment.id}','answerMain','',"单个产品风险分析", 'javascript:menuTree.nodeClickedAndSelected(29)');
		     	menuTree.insertNode(menuTree.node05, menuTree.node0502);
			     </#if>
			     <#if analysisSet?seq_contains("0503")>
		     	menuTree.node0503= menuTree.makeItem("收支结构对比分析",'${base}/result/balanceCompare.action?experiment.id=${experiment.id}','answerMain','',"收支结构对比分析", 'javascript:menuTree.nodeClickedAndSelected(30)');
		     	menuTree.insertNode(menuTree.node05, menuTree.node0503);
			     </#if>
			   <#if analysisSet?seq_contains("0504")>
		     	menuTree.node0504= menuTree.makeItem("金融资产结构对比分析",'${base}/result/financeCompare.action?experiment.id=${experiment.id}','answerMain','',"金融资产结构对比分析", 'javascript:menuTree.nodeClickedAndSelected(31)');
		     	menuTree.insertNode(menuTree.node05, menuTree.node0504);
			     </#if>
			   <#if analysisSet?seq_contains("0505")>
		     	menuTree.node0505= menuTree.makeItem("保险资产结构对比分析",'${base}/result/insuranceCompare.action?experiment.id=${experiment.id}','answerMain','',"保险资产结构对比分析", 'javascript:menuTree.nodeClickedAndSelected(32)');
		     	menuTree.insertNode(menuTree.node05, menuTree.node0505);
			    </#if>
			 </#if>
		menuTree.display(menuTree.node0,1);
		function logoutStudy(){
			if(confirm("确定退出本次学习?")){
				top.close();
			}
		}
		refrestInterval=1;
		var thisStudyTime=0;
		function refreshStudyTime(){
			thisStudyTime+=refrestInterval;
			studyTimeSpan.innerHTML=timeToStr(thisStudyTime);
		}
		var interval=setInterval('refreshStudyTime()',refrestInterval*1000);
	  	function notifyClose(){
		  	document.logoutForm.submit();
		  	alert("本次学习结束.本次学习时间"+timeToStr(thisStudyTime));
		}
		function timeToStr(sec){
			min=Math.floor(sec/60);
			second=sec%60;
			return min+"分"+second+"秒";
		}
	  	if (window.addEventListener) {window.addEventListener("onunload", notifyClose, false); }else if (window.attachEvent) {window.attachEvent("onunload", notifyClose);  }else {window.onunload = notifyClose; }
	  </SCRIPT>
   </td>
  </tr>
 </table>
</body>
 <#include "/template/foot.ftl"/>