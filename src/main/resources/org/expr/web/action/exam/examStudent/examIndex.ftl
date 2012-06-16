 <#include "/template/head.ftl"/>
 <script>
 window.history.go(+1);
 	function unloadCancel()
 	{
	window.event.returnValue="是否确认结束测试?";
 	}
 	function checkLeave(){
 var n = window.event.screenX - window.screenLeft;
 var b = n > document.documentElement.scrollWidth-20;     
 if(b && window.event.clientY < 0 || window.event.altKey)     
 {        window.event.returnValue = "确定结束测试吗？";     }
}
 </script>
<body onbeforeunload="checkLeave();">
<table id="taskBar"></table>
<script>
  var bar = new ToolBar('taskBar', '${examPaper.lesson.coursename!}课程测试', null, true, false);
  bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
  bar.addPrint();
</script>
<#if examPaperResult.mark?exists>
	<table align="center" width="90%">
	<tr>
		<td  align="center" colspan="4"><font color="red"><B>您已参加了测试！得分为${examPaperResult.mark}！<a href="examStudent.action?method=examAnswer&examPaperId=${examPaper.id}">点击查看试卷！</a></B></font></td>
	</tr>
	</table>
<#else>
  <#if (examPaper.questionMarks?size)==(questions?size)>
	<form name="LogoutForm" action="${base}/exam/examStudent!submitAnswer.action" method="post">
    <input type="hidden"  name="examPaper.id" value="${examPaper.id}">
	<table align="center" width="90%">
	<tr>
		<td  align="center" colspan="4"><font color="red"><B>测试结束前请勿关闭或刷新浏览器，否则测试将提前结束！</B></font></td>
	</tr>
	<tr>
		<td  align="center" colspan="4"><h3>${examPaper.name}</h3></td>
	</tr>
	<tr>
		<td align="right">学生姓名：</td><td align="left"><B>${std.name}</B></td><td align="right">学号：</td><td align="left"><B>${std.code}</B></td>
	</tr>
	<tr>
		<td align="right">开始测试时间：</td><td align="left"><B>${startAt?string("yyyy-MM-dd HH:mm")}</B></td><td align="right">测试总时间：</td><td align="left"><B>${examPaper.period!}分钟</B></td>
	</tr>
	<tr>
		<td align="right">已测试时间：</td><td align="left"><B><span id="studyTimeSpan"></span></B></td><td align="right">测试剩余时间：</td><td align="left"><B><span id="studyTimeLeft"></span></B></td>
	</tr>
	<table>
		<table align="center" width="90%">
	<tr>
		<td align="left"><B>${examPaper.description!}</B></td>
	</tr>
	<#list examPaper.questionMarks?sort_by("code") as questionMark>
	<#assign key=questionMark.code?c>
	<#if questions[key]?exists>
	<#assign question=questions[key]>
    <input type="hidden"  name="question${questionMark.code}Id" value="${question.id}">
	<tr>
	<td align="left">
		<B>${questionMark.code}、${question.name}(${questionMark.mark}分)</B>
	</td>
	</tr>
	<tr><td align="left">${question.introduction!}</td></tr>
	<tr><td>
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class='listTable'>
  <tr> 
    <td>${question.caze.content!}</td>
  </tr>
	<#list (question.items?if_exists)?sort_by("code") as item>
	<#assign mark=item.weight*questionMark.mark/totals[key]>
  <tr> 
    <td class="grayStyle">${item.code!}、${item.description!}<font color="#FF0000">(${item.weight}*${questionMark.mark}/${totals[key]}=${mark}分)</font></td>
  </tr>
  <tr> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="brightStyle">
    	<#list (item.options?if_exists)?sort_by("code") as option>
        <tr> 
          <td width="4%"><div align="center"> 
              <input type="checkBox"  name="option${questionMark.code}_${item.id}" value="${option.code}">
          </td>
          <td width="96%">${option.code}、${option.description}</td>
        </tr>
        </#list>
      </table>
    </td>
  </tr>
  </#list>
</table>
	</td></tr>

	</#if>
	</#list>
<tr>
  	<td align="center">
  	<button onclick="save()" name="btSubmit" id="btSubmit"> 提交</button>
  	</td>
  </tr>
	</table>
	
	</form>

  <SCRIPT language="javascript">
		refrestInterval=1;
		var thisStudyTime=0;
		function refreshStudyTime(){
			thisStudyTime+=refrestInterval;
			studyTimeSpan.innerHTML=timeToStr(thisStudyTime);
			studyTimeLeft.innerHTML=timeToStr(${examPaper.period}*60-thisStudyTime);
			if((${examPaper.period}*60-thisStudyTime)==0){
   	         		form.submit();			
			}
		}
		var interval=setInterval('refreshStudyTime()',refrestInterval*1000);
	  	function notifyClose(){
   	    	form.submit();
		}
		function timeToStr(sec){
			min=Math.floor(sec/60);
			second=sec%60;
			return min+"分"+second+"秒";
		}
	  	if (window.addEventListener) {window.addEventListener("onunload", notifyClose, false); }else if (window.attachEvent) {window.attachEvent("onunload", notifyClose);  }else {window.onunload = notifyClose; }
   var form=document.LogoutForm;
   function save(){
   	 if(confirm("确定提交?")){
   	 		var str="";
   	 	<#list examPaper.questionMarks?sort_by("code") as questionMark>
   	<#assign key=questionMark.code?c>
	<#if questions[key]?exists>
	<#assign question=questions[key]>
   	     <#list ((question?if_exists).items?if_exists) as item>
   	         var checked=false;
   	         for(var i=0;i<form["option${questionMark.code}_${item.id}"].length;i++){
   	            if(form["option${questionMark.code}_${item.id}"][i].checked){
   	            	checked=true;
   	            }
   	         }
   	         if(!checked){
   	           str=str+"第${questionMark.code}大题的第${item.code}小题没有选择;\n";
   	         }       
   	     </#list>
   	    </#if>
   	    </#list>
   	    if(!str=="")
   	         {
   	         	str=str+"确认提交?";
   	         	if(confirm(str))
   	         	{
   	         		form.submit();
   	         	}else
   	         	{
   	         	return;
   	         	}
   	         }
   	     else
   	     {
   	     form.submit();
   	    }
   	 }
   }
	  </SCRIPT>
	  <#else>
	  	请刷新页面重新出题！
	  </#if>
</#if>
</body>