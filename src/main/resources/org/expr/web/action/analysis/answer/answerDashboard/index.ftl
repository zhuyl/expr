 <#include "/template/simpleHead.ftl"/>
<BODY style="OVERFLOW-Y: hidden">
<TABLE id=logoTable style="WIDTH: 100%; HEIGHT: 30%" cellSpacing=0 
cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
   <td><IFRAME HEIGHT="100%" WIDTH="100%" 
	       FRAMEBORDER="0" src="${base}/caze!cazeDetail.action?cazeId=${cazeId}"
      name=headFrame></IFRAME></td>
   </TR></TBODY></TABLE>
<TABLE width="100%" border=0 
cellPadding=0 cellSpacing=0 id=mainTable style="WIDTH: 100%; HEIGHT: 70%">
  <TBODY>
    <TR> 
      <TD align=middle width="100%" bgColor=#e1e6e9 colSpan=3><IMG 
      src="${base}/static/images/up.jpg" name=imgup width="49" height="6" onclick=verticalSwitch('up_tag') id=up_tag 
      onmousemove="style.cursor='hand';"></TD>
    </TR>
    <TR> 
      <TD id=leftTD style="WIDTH: 16%; HEIGHT: 100%" border="0">
      <IFRAME 
      name=answerLeftFrame src="answerDashboard!analysisTree.action?caze.id=${cazeId}" frameBorder=0 
      width="100%" height="100%"> </IFRAME>
      </TD>
      <TD style="CURSOR: w-resize" bgColor=#e1e6e9 height="100%"><A 
      onclick="horizontalSwitch('left_tag')"><IMG src="${base}/static/images/left.jpg" width="6" height="49" border=0 id=left_tag 
      style="CURSOR: hand"> </A></TD>
      <TD id=rightTD style="WIDTH: 84%" align="left" valign="top">
      <IFRAME id=answerMain name=answerMain  scroll="auto" src="#" frameBorder=0 width="100%" height="100%"></IFRAME>
      </TD>
    </TR>
  </TBODY>
</TABLE>

<SCRIPT>
	var obj = null;
	function changeColor(field){
		field.className = "menuSelected";
		if(obj != null && obj != field)obj.className = "menu_blue_13px2";
		obj = field;
		//home();
	}

  //调整水平比例
  function horizontalSwitch(id) {
      var fullpath = document.getElementById(id).src;
      var filename = fullpath.substr(fullpath.lastIndexOf("/")+1, fullpath.length);
	  switch (filename) {
			case "left.jpg":
				document.getElementById(id).src = fullpath.substr(0,fullpath.lastIndexOf("/")+1)+"right.jpg";
				break;
			case "right.jpg":
				document.getElementById(id).src = fullpath.substr(0,fullpath.lastIndexOf("/")+1)+"left.jpg";
				break;	
	  }
      if(leftTD.style.width=='16%'){
        leftTD.style.width="0%";rightTD.style.width="100%";
      }else{
         leftTD.style.width="16%";rightTD.style.width="84%";
      }
   }
  //垂直调整比例
  function verticalSwitch(id){
      var fullpath = document.getElementById(id).src;
      var filename = fullpath.substr(fullpath.lastIndexOf("/")+1, fullpath.length);
	  switch (filename) {
			case "up.jpg":
				document.getElementById(id).src = fullpath.substr(0,fullpath.lastIndexOf("/")+1)+"down.jpg";
				break;
			case "down.jpg":
				document.getElementById(id).src = fullpath.substr(0,fullpath.lastIndexOf("/")+1)+"up.jpg";
				break;	
	  }
    logoTable.style.display = (logoTable.style.display == "none") ? "" : "none";
    if (mainTable.style.height=='100%') {
        mainTable.style.height='70%';
        logoTable.style.height='30%';
    }else{
        mainTable.style.height='100%';
        logoTable.style.height='0%';
    }
  }
</SCRIPT>
</BODY>
<#include "/template/foot.ftl"/>