<#include "/template/simpleHead.ftl"/>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/common/OnReturn.js"></script>
<body bgcolor="#6699CC">
<script>
if(this.parent!=this)
{
	this.top.location="index.action";
}
</script>
<div align="center"  >
<form name="loginForm" method="post" action="login.action">
  <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" onkeypress="ret.focus(event)">
    <tr>
      <td align="center" valign="middle"> 
        <table width="550" height="361" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr> 
            <td colspan="2" height="262"><img src="${base}/static/images/jrlc_01_r1_c1.jpg?ver=1" width="550" height="262"></td>
          </tr>
          <tr height="99"> 
            <td height="99"  width="263"><img src="${base}/static/images/jrlc_01_r3_c1.jpg" width="263" height="99"></td>
            <td width="287" height="99" background="${base}/static/images/jrlc_01_r3_c2.jpg">
            <TABLE WIDTH="287"  BORDER="0" CELLPADDING="0" CELLSPACING="0" style="font-size:16px">
                <tr>
                  <td ALIGN="right" width="93"><STRONG><font color="#006699">用户名:</font></STRONG></td>
                  <td width="194"> <INPUT NAME="loginForm.name" TYPE="text" value="" style="width:150px;background-color:#ffffff"> 
                  </td>
                </tr>
                <tr> 
                  <td ALIGN="right" ><STRONG><font color="#006699">密码:</font></STRONG></td>
                  <td><INPUT NAME="loginForm.password" TYPE="password"   style="width:150px;background-color:#ffffff"> 
                    <INPUT NAME="encodedPassword" type="hidden" value=""></td>
                </tr>
                <tr> 
                  <td ALIGN="right"><STRONG><font color="#006699">验证码:</font></STRONG></td>
                  <td align="bottom"><INPUT NAME="loginForm.captcha" TYPE="text" style="width:85px;background-color:#ffffff"> 
                    <img src="captcha/image.action" width="100" height="30" style="vertical-align:top;margin-top:1px;border:0px"></td>
                </tr>
                <tr>
          		<td align="center" colspan="2" style="font-size:10px">
          		  <button name="submitButton" onclick ="submitLogin()" style="height:15pt;width:38pt;" BORDER="0"><B>登录</B></button>
          		  <@s.actionerror theme="expr"/>
          		</td>
            	</tr>
              </table>
              </td>
          </tr>
        </table>
        </td>
    </tr>
  </table>
  </form>
</div>
<script>
  var ret = new OnReturn(document.loginForm);
  ret.add("loginForm.name");
  ret.add("loginForm.password");
  ret.add("loginForm.captcha");
  ret.add("submitButton");
  var form  = document.loginForm;
  
  function submitLogin(){
     if(form['loginForm.name'].value==""){
        alert("用户名称不能为空");return;
     }
     if(form['loginForm.password'].value==""){
        alert("密码不能为空");return;
     }
     form.submit();
  }
  
  if("${language}".indexOf("en")!=-1){
     document.getElementById('engVersion').checked=true;
  }
  
  var username=getCookie("username");
  if(null!=username){
    form['loginForm.name'].value=username;
  }

</script>
</body>
<#include "/template/foot.ftl"/>
