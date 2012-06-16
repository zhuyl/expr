<html>
 <head>
  <meta http-equiv="content-type" content="text/html; charset=utf-8">
  <meta http-equiv="pragma" content="no-cache">
  <meta http-equiv="cache-control" content="no-cache">
  <meta http-equiv="expires" content="0">
  <title>上海金融学院金融理财综合实验教学系统</title>
  <link href="${base}/static/css/default.css" rel="stylesheet" type="text/css">
 </head>
 <#import "/template/message.ftl" as msg>
  <#import "/template/table.ftl" as table>
 <#import "/template/htm.ftl" as htm>
 <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Common.js"></script>
 <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/ToolBar.js"></script>
 <script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/Table.js"></script>

 <link href="css/toolBar.css" rel="stylesheet" type="text/css">
 <#if Session['WW_TRANS_I18N_LOCALE']?exists>
 <#assign language= Session['WW_TRANS_I18N_LOCALE'].language>
 <#else>
 <#assign language="zh">
 </#if>
 <#macro i18nName(entity)><#if language?index_of("en")!=-1><#if entity.engName?if_exists?trim=="">${entity.name?if_exists}<#else>${entity.engName?if_exists}</#if><#else><#if entity.name?if_exists?trim!="">${entity.name?if_exists}<#else>${entity.engName?if_exists}</#if></#if></#macro>
 <#macro getMessage></#macro>
 <#macro text name><@msg.text name/></#macro>
 <#macro getBeanListNames(beanList)><#list beanList as bean>${bean.name}&nbsp;</#list></#macro>
 <#macro getTeacherNames(teachers)><@getBeanListNames teachers/></#macro>
