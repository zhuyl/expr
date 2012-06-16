<#assign cewolf=JspTaglibs["/WEB-INF/cewolf.tld"]>
<html>
 <head>
  <meta http-equiv="content-type" content="text/html; charset=utf-8">
  <meta http-equiv="pragma" content="no-cache">
  <meta http-equiv="cache-control" content="no-cache">
  <meta http-equiv="expires" content="0">
  <title>上海金融学院金融理财综合实验教学系统</title>
  <link href="${base}/static/css/default.css" rel="stylesheet" type="text/css">
  <link href="${base}/static/css/messages.css" rel="stylesheet" type="text/css">
  <link href="${base}/static/css/toolBar.css" rel="stylesheet" type="text/css">
 <link href="${base}/static/css/homepage.css" rel="stylesheet" type="text/css">
 <link href="${base}/static/css/Calculator.css" rel="stylesheet" type="text/css">
 <link href="${base}/static/css/Calculator2.css" rel="stylesheet" type="text/css">
 </head>
 <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Common.js"></script>
 <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/ToolBar.js"></script>
 <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Table.js"></script>
<script language="JavaScript" type="text/JavaScript" src='${base}/dwr/engine.js'></script>
<script language="JavaScript" type="text/JavaScript" src='${base}/dwr/util.js'></script>
 <#import "/template/table.ftl" as table>
 <#import "/template/htm.ftl" as htm>
 <#import "/template/message.ftl" as msg>
 
 <#if Session['WW_TRANS_I18N_LOCALE']?exists>
 <#assign language= Session['WW_TRANS_I18N_LOCALE'].language>
 <#else>
 <#assign language="zh">
 </#if>
 <#macro i18nName(entity)><#if language?index_of("en")!=-1><#if entity.engName?if_exists?trim=="">${entity.name?if_exists}<#else>${entity.engName?if_exists}</#if><#else><#if entity.name?if_exists?trim!="">${entity.name?if_exists}<#else>${entity.engName?if_exists}</#if></#if></#macro>
 <#macro localAttrName(entityName)><#if language?index_of("en")!=-1>#{entityName}.engName<#else>${entityName}.name</#if></#macro>
 <#macro yesOrNoOptions(selected)>
 	<option value="0" <#if "0"==selected> selected </#if> ><@msg.text name="common.no" /></option> 
    <option value="1" <#if "1"==selected> selected </#if>><@msg.text name="common.yes" /></option> 
    <option value="" <#if ""==selected> selected </#if>><@msg.text name="common.all" /></option> 
 </#macro>
 <#macro eraseComma(nameSeq)><#if (nameSeq?length>2)>${nameSeq[1..nameSeq?length-2]}<#else>${nameSeq}</#if></#macro>
 <#macro getBeanListNames(beanList)><#list beanList as bean>${bean.name}<#if bean_has_next> </#if></#list></#macro>
 
 <#function sort_byI18nName entityList>   
   <#return sort_byI18nNameWith(entityList,"")>
 </#function>
 
 <#function sort_byI18nNameWith entityList nestedAttr>
   <#local name="name">
   <#if nestedAttr!="">
      <#local name=[nestedAttr,name]/>
   </#if>
   <#return entityList?sort_by(name)>
 </#function> 

 <#macro text name><@msg.text name/></#macro>
 <#macro getMessage><@s.actionerror theme="beanfuse"/></#macro>
 <#macro searchParams><input name="params" type="hidden" value="${Parameters['params']?default('')}"></#macro>

<script>
	function f_frameStyleResize(targObj,extraHight){
		if(targObj.name!=""&&targObj.name!="main"&&targObj.name!="answerMain"){
	       var frames = targObj.parent.document.getElementsByName(targObj.name);
	       if(frames.length<1) return;
	       var targWin=frames[0];
 		   if(targWin != null) {
	 			var HeightValue = targObj.document.body.scrollHeight;	
	 			if(null==extraHight)
	 			    extraHight=0;
 			    targWin.style.height = HeightValue+extraHight;
	 		}
	 		targObj.parent.f_frameStyleResize(targObj.parent);
	 	}
 	}
 if (window.addEventListener) {window.addEventListener("load", adaptFrameSize, false);}else if (window.attachEvent) {window.attachEvent("onload", adaptFrameSize);}else {window.onload = adaptFrameSize;}
</script>