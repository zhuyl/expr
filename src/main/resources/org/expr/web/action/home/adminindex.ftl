<#include "/template/simpleHead.ftl"/>
<link href="${base}/static/css/menu.css" rel="stylesheet" type="text/css">
<style>
#BakcGroup_image_td {
  background-repeat: repeat;
  background-position: center center;
  background-image: url(images/home/push_top.jpg);
}
</style>
<body style="overflow-y:hidden;">

<table width="100%" border="0" cellpadding="0" cellspacing="0" id="logoTable" style="" >
   <tr> 
    <td width="31%" height="100" background="${base}/static/images/headbackground_r1_c2.gif" align="left"><img src="${base}/static/images/headbackground_r1_c1.gif?ver=1" height="100"></td>
    <td width="47%" height="100" background="${base}/static/images/headbackground_r1_c2.gif"></td>
    <td width="22%" height="100" background="${base}/static/images/headbackground_r1_c2.gif" align="right"><img src="${base}/static/images/headbackground_r1_c3.gif" height="100"></td>
   </tr>
</table>
<#assign parentCode><#if (menus?size>0)>${menus?first.code?if_exists}<#else>${parentCode?if_exists}</#if></#assign>
<table id="mainTable" style="width:100%;height:90%" cellpadding="0" cellspacing="0" border="0">
 <tr onClick="verticalSwitch()">
  <td width="100%" colspan="3" VALIGN="TOP" height="16" id="BakcGroup_image_td" style="background-image: url(images/home/push_top.jpg);font-size:0pt">&nbsp;</td>
 </tr>
 <tr>
   <td style="HEIGHT:100%;width:14%" border="0" id="leftTD">
	   <iframe HEIGHT="100%" WIDTH="100%" SCROLLING="AUTO" 
	       FRAMEBORDER="0" src="home.action?method=moduleList&parentCode=${parentCode}" name="leftFrame" >
	   </iframe>
   </td>
   <td width="0%" height="100%" bgcolor="#ffffff" style="cursor:w-resize;">
	   <a onClick="horizontalSwitch('left_tag')">
	      <img id="left_tag" style="cursor:hand" src="${base}/static/images/home/push_left.jpg" border="0" >
	   </a>
    </td>
   <td style="width:86%" id="rightTD">
	   <iframe HEIGHT="100%" WIDTH="100%" SCROLLING="auto" 
	     FRAMEBORDER="0" src="home.action?method=welcome" name="main" id="main">
	   </iframe>
   </td>
 </tr>
</table>
<div  id="msgNotificationDIV" style="display:none;width:300px;height:150px;position:absolute;bottom:0px;right:0px;border:solid;border-width:1px;background-color:#94aef3 ">
<iframe HEIGHT="100%" WIDTH="100%" SCROLLING="AUTO" 
	       FRAMEBORDER="0" src="#" name="msgFrame" >
</iframe>
</div>
</body>
<script>
	var obj = null;
	function changeColor(field){
		field.className = "menuSelected";
		if(obj != null && obj != field)obj.className = "menu_blue_13px2";
		obj = field;
		//home();
	}   
  var categories ={<#list categories as category>'${category.name}':${category.id}<#if category_has_next>,</#if></#list>};
  var categoryValue = ${Session['security.categoryId']};
  var userCategorySelect = document.getElementById('userCategorySelect');
  for(var category in categories){
     if(1){
        userCategorySelect.options[userCategorySelect.options.length]=new Option(category,categories[category]);
     }
  }
  
  if( userCategorySelect.options.length>1){
     userCategorySelect.style.display="block";
     var curCategory=${Parameters['user.category']?default(1)};
     for(var i=0;i<userCategorySelect.options.length;i++){
         if(userCategorySelect.options[i].value==curCategory){
             userCategorySelect.options[i].selected=true;
         }
     }
  }else{
     document.getElementById("changeCategoryTd").innerHTML="";
  }
  
  function home() {
      main.location="home.action?method=welcome";
  }  
  function logout() {
      self.location = 'logout.action';
  }
  function changePassword(){
      var url = "password.action?method=changePassword";
      var selector= window.open(url, 'selector', 'scrollbars=yes,status=yes,width=1,height=1,left=1000,top=1000');
	  selector.moveTo(200,200);
	  selector.resizeTo(300,250);
  }
  function changeUserCategory(category){
     self.location="home.action?method=index&user.category="+category;
  }
  //调整水平比例
  function horizontalSwitch(id) {
      var fullpath = document.getElementById(id).src;
      var filename = fullpath.substr(fullpath.lastIndexOf("/")+1, fullpath.length);
	  switch (filename) {
			case "push_left.jpg":
				document.getElementById(id).src = fullpath.substr(0,fullpath.lastIndexOf("/")+1)+"pull_left.jpg";
				break;
			case "pull_left.jpg":
				document.getElementById(id).src = fullpath.substr(0,fullpath.lastIndexOf("/")+1)+"push_left.jpg";
				break;	
	  }
      if(leftTD.style.width=='14%'){
        leftTD.style.width="0%";rightTD.style.width="100%";
      }else{
         leftTD.style.width="14%";rightTD.style.width="86%";
      }
   }
  //垂直调整比例
  function verticalSwitch(){
    logoTable.style.display = (logoTable.style.display == "none") ? "" : "none";
    imageString = BakcGroup_image_td.style.backgroundImage;
    if(imageString.indexOf("pull")>0){
 		newImage = "url(images/home/push_top.jpg)";
	}else{
		newImage = "url(images/home/pull_top.jpg)";
	}
    BakcGroup_image_td.style.backgroundImage = newImage;
    if (mainTable.style.height=='100%') {
        mainTable.style.height='95%';
        //logoTable.style.height='80px';
    }else{
        mainTable.style.height='100%';
        logoTable.style.height='0%';
    }
  }
</script>
<#include "/template/foot.ftl"/>