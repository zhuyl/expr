 <#include "/template/head.ftl"/>
<body>
<table width="100%"  border="0" cellpadding="0" cellspacing="0">
                    <tr> 
                      <td style="BACKGROUND: url(${base}/static/images/navbg.gif) repeat-x" vAlign=top> 

 <TABLE class=01 cellSpacing=0 cellPadding=0 width="100%" align=right 
      border=0>
                          <TBODY>
                            <TR> 
                              <TD id=tithomepage align=middle><A class=tit 
            href="home.action?method=curriculumList">系统首页</A></TD>
                              <TD><IMG height=28 src="${base}/static/images/navline.gif" width=2> </TD>
                              <TD id=myRoom align=middle><A class=tit 
            href="experimentStudy.action">学习任务</A></TD>
                              <TD><IMG height=28 src="${base}/static/images/navline.gif" width=2> </TD>
                              <TD  align=middle><A class=tit 
            href="http://yingxin.shfc.edu.cn:2971/jiuye/articleList.jsp?id=D0056BEAB72045C88680CE52ECB81A3A">课程考试</A> 
                              </TD>
                              <TD><IMG height=28 src="${base}/static/images/navline.gif" width=2> </TD>
                              <TD align=middle><A class=tit 
            href="experimentStudy.action?method=curStudyRecord">学习记录</A> 
                              </TD>
                              <TD><IMG height=28 src="${base}/static/images/navline.gif" width=2> </TD>
                              <TD align=middle><A class=tit 
            href="http://yingxin.shfc.edu.cn:2971/jiuye/articleList.jsp?id=40288b921a72e104011a7550be110001">课程公告</A> 
                              </TD>
                              <TD><IMG height=28 src="${base}/static/images/navline.gif" width=2> </TD>
                            </TR>
                          </TBODY>
                        </TABLE></td>
                    </tr>
                  </table>
 <table width="100%">
               <tr>     
			    <td height="34"> 
                  <DIV style="PADDING-BOTTOM: 6px; PADDING-TOP: 6px">
            <TABLE cellSpacing=0 cellPadding=0 width="98%" align=center 
border=0>
              <TBODY>
              <TR>
                        <TD background="${base}/static/images/milldbg.gif" height=34><TABLE height=34 cellSpacing=0 cellPadding=6 width="100%" 
                  border=0>
                              <TBODY>
                                <TR> 
                                  <TD vAlign=center align=right width=20><IMG height=13 
                        src="${base}/static/images/arrowL.gif" width=13> </TD>
                                  <TD class=font_tit vAlign=center><strong><span class="subtitle">课程学习记录</span></strong></TD>
                                </TR>
                              </TBODY>
                            </TABLE> </TD>
                      </TR>
</TBODY></TABLE>
                  </DIV>
			  </td>
			  </tr>
 </table>                 
<table width="100%" cellpadding="0" cellspacing="0" style="border-collapse: collapse">
                    <tr> 
                      <td height="100%"><br> 
                      <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
                          <tr class="subtitle" align="center"> 
                            <td height="23" class="tableheadborder">实验编号</td>
                            <td  height="23" class="tableheadborder">实验名称</td>
                            <td  height="23" class="tableheadborder">开始学习时间</td>
                            <td  height="23" class="tableheadborder">结束学习时间</td>          
                            <td  height="23" class="tableheadborder">在线学习时间</td> 
                            <td  height="23" class="tableheadborder">主机</td> 
                          </tr>
                          <tr style="background-color:expression('#e1e8f5,#FFFFFF'.split(',')[rowIndex>0&&rowIndex%2])" align="center"> 
                               <td><div align="center">exp_001</div></td>
    <td><div align="center">实验一</div></td> 
    <td>2009-09-01 12:12:20</td>
    <td><div align="center">2009-09-01 13:12:20</div></td>
    <td><div align="center">60分</div></td>
    <td><div align="center">192.168.1.1</div></td></tr>
                          <tr style="background-color:expression('#e1e8f5,#FFFFFF'.split(',')[rowIndex>0&&rowIndex%2])" align="center"> 
                                   <td><div align="center">exp_002</div></td>
    <td><div align="center">实验二</div></td> 
    <td height="17">2009-09-03 01:12:20</td>
    <td><div align="center">2009-09-03 02:42:20</div></td>
    <td><div align="center">90分</div></td>
    <td><div align="center">192.168.1.1</div></td></tr>    
                        </table></td>
                    </tr>
                  </table>


</body>
 <#include "/template/foot.ftl"/>