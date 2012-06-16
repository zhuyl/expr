<#include "/template/simpleHead.ftl"/>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" height="100%" border="0" align="right" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="31%" height="100" background="${base}/static/images/headbackground_r1_c2.gif" align="left"><img src="${base}/static/images/headbackground_r1_c1.gif?ver=1" height="100"></td>
    <td width="47%" height="100" background="${base}/static/images/headbackground_r1_c2.gif"></td>
    <td width="22%" height="100" background="${base}/static/images/headbackground_r1_c2.gif" align="right"><img src="${base}/static/images/headbackground_r1_c3.gif" height="100"></td>
  </tr>
  <tr align="left" valign="top"> 
    <td height="100" colspan="3" class="homepage" > 
      <table width="100%" border="0" cellspacing="0" cellpadding="0" >
        <tr>
          <td width="210" align="left" valign="top" ><table border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><table width="210" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td height="29" background="${base}/static/images/leftbanbg.gif"><img src="${base}/static/images/arrowL.gif" width="13" height="13"> 
                        <span class="subtitle">用户信息</span><span class="homepage"> 
                        </span></td>
                    </tr>
                    <tr> 
                      <td background="${base}/static/images/leftbg.gif"> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td width="60" align="right" valign="top"><img src="${base}/static/images/face1.jpg" width="50" height="50" border="0"></td>
                            <td width="150"><table width="150" border="0" align="center" cellpadding="0" cellspacing="0">
                                <tr> 
                                  <td height="25" colspan="2" class="text"><strong>&nbsp;&nbsp;您好！${user.fullname}同学</strong></td>
                                </tr>
                                <tr> 
                                  <td><div align="center" class="link"><a href='security/my-account!edit.action'>[修改密码]</a></div></td>
                                  <td><div align="center" class="link"><a href='logout.action'>[我要离开]</a></div></td>
                                </tr>
                              </table></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td valign="top"> 
                  <table width="100%" height="150" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td height="29" background="${base}/static/images/leftbanbg.gif"><table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
                          <tr> 
                            <td><img src="${base}/static/images/arrowL.gif" width="13" height="13"> 
                              <span class="subtitle">客户风险偏好分析</span> </td>
                            <td><div align="right" class="link"><a href="riskAttitudeAnalysis.action?method=list">更多&gt;&gt;</a></div></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr>
                      <td valign="middle" background="${base}/static/images/leftbg.gif"> 
                        <ul class="listarrow" >
                        <#list questionnaires as questionnaire>
                          <li class="listarrow"><a href="riskAttitudeAnalysis.action?questionnaire.id=${questionnaire.id}" target="_blank">${questionnaire.name?if_exists}</a></li>
                         </#list>                        </ul>
					  </td>
                    </tr>
                  </table>
                </td>
              </tr>
             
              <tr>
                <td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td height="29" background="${base}/static/images/leftbanbg.gif"><table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
                          <tr>
                            <td><img src="${base}/static/images/arrowL.gif" width="13" height="13"> 
                              <span class="subtitle">案例库</span> </td>
                            <td></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td align="center" valign="middle" background="${base}/static/images/leftbg.gif"> 
                        <form name="casebase" action="myCaze.action">
                          <table width="95%" border="0" cellspacing="0" cellpadding="0">
                            <tr> 
                              <td height="25" colspan="2" class="text">案例名称： 
                                <input name="casename" type="text" id="casename" size="15"></td>
                            </tr>
                            <tr> 
                              <td height="25" colspan="2" class="text">客户生命周期： 
                             <@htm.i18nSelect datas=lifeCycleTypes selected=""  name="caze.lifeCycleType.id" style="width:50%;"><option value=""><@text name="common.all"/></option></@>
                             </td>
                            </tr>
                            <tr> 
                              <td width="56%" class="text"><div align="right">
                                  <input name="casesearch" type="submit" id="casesearch" value="查询">
                                </div></td>
                              <td width="44%" class="text">
<div align="right" class="link"></div></td>
                            </tr>
                          </table>
					</form>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td valign="top">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td height="29" background="${base}/static/images/leftbanbg.gif"><table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
                          <tr> 
                            <td><img src="${base}/static/images/arrowL.gif" width="13" height="13"> 
                              <span class="subtitle">理财计算器</span> </td>
                            <td></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td height="100" align="center" valign="middle" background="${base}/static/images/leftbg.gif">
                        <table width="95%" border="0" cellspacing="0" cellpadding="0">
                          <#list financeToolCategories?chunk(2) as subList>
                          <tr>
                            <td height="25"><img src="${base}/static/images/sign25.gif" width="12" height="12">
                                 <span class="text"><a target="_blank" href="financeTool.action?method=financeToolList&category.id=${subList[0].id}">${(subList[0].name)?if_exists}</a></span>
                            </td>
                            <td height="25" class="text">
                              <#if subList[1]?exists>
                              <img src="${base}/static/images/sign25.gif" width="12" height="12"> 
                              <span class="text"><a target="_blank" href="financeTool.action?method=financeToolList&category.id=${subList[1].id}">${(subList[1].name)}</a></span>
                              </#if>
                            </td>
                          </tr>
                          </#list>
                        </table> 
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td valign="top">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td height="29" background="${base}/static/images/leftbanbg.gif"><table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
                          <tr> 
                            <td><img src="${base}/static/images/arrowL.gif" width="13" height="13"> 
                              <span class="subtitle">产品库</span> </td>
                            <td></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr height="50"> 
                      <td align="center" valign="top" background="${base}/static/images/leftbg.gif"> 
                        <table width="95%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td height="25"><img src="${base}/static/images/sign25.gif" width="12" height="12">
                                 <span class="text"><a target="_blank" href="finance.action?method=userindex">金融产品</a></span>
                            </td>
                            <td height="25" class="text">
                              <img src="${base}/static/images/sign25.gif" width="12" height="12"> 
                              <span class="text"><a target="_blank" href="insurance.action?method=userindex">保险产品</a></span>
                            </td>
                          </tr>
                        </table></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table></td>
          <td align="left"  valign="top" height="100%">
          <iframe src="home.action?method=curriculumList" width="100%" height="100%" marginheight="0" marginwidth="0"></iframe>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
