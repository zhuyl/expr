<#include "/template/head.ftl"/>
<body>
<table id="backBar"></table>
<script>
  	 var bar = new ToolBar('backBar','公告详情',null,true,true);
  	 bar.setMessage('<@getMessage/>');
  	 bar.addBack("<@text name="action.back"/>");  	 
</script>
<table class="infoTable" width="100%">
    <tr>
		<td class="title"	width="30%">公告标题</td>
		<td class="content" >${notice.title}</td>
    </tr>
    <tr>
		<td class="title">公告内容</td>
		<td class="content" >${(notice.content)?default("")}</td>
    </tr>

    <tr>
		<td class="title">发送者</td>
		<td >${notice.publisher.name}</td>
    </tr>
    <tr>
		<td class="title" >发布时间</td>
		<td >${notice.updatedAt}</td>
    </tr>
</table>
</body>
<#include "/template/foot.ftl"/>