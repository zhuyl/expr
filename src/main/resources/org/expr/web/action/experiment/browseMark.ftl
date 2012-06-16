<#include "/template/head.ftl"/>
<table id="taskBar"></table>
<table width="90%" border="0" align="center" cellpadding="0" cellspacing="0" class="listTable">
  <tr> 
    <td width="96%" class="darkColumn" align='center'><B>分析内容</B></td>
    <td width="5%" class="darkColumn"><div align="center"><B>得分</B></div></td>
  </tr>
  <tr class="darkColumn"> 
    <td width="96%"><B>客户分析</B></td>
    <td width="5%" class="redtext"><div align="center"></div></td>
  </tr>
  <tr class="grayStyle"> 
    <td height="18">家庭基本信息分析</td>
    <td width="5%" class="redtext"><div align="center">90</div></td>
  </tr>
  <tr> 
    <td> <table width="85%" border="0" class="listTable" align="center">
        <tr class="darkColumn" align="center"> 
          <td>姓名</td>
          <td><div align="center">性别</div></td>
          <td><div align="center">年龄</div></td>
          <td><div align="center">职业</div></td>
          <td><div align="center">家庭角色</div></td>
          <td><div align="center">收入</div></td>
          <td>工作单位</td>
        </tr>
        <tr class="brightStyle" onMouseOver="swapOverTR(this,this.className)"onmouseout="swapOutTR(this)" onClick="onRowChange(event)"> 
          <td>zhangsan</td>
          <td><div align="center">boy</div></td>
          <td><div align="center">30</div></td>
          <td><div align="center">lawyer</div></td>
          <td><div align="center">father</div></td>
          <td><div align="center">5000</div></td>
          <td>bank</td>
        </tr>
        <tr class="grayStyle"onMouseOver="swapOverTR(this,this.className)"onmouseout="swapOutTR(this)" onClick="onRowChange(event)"> 
          <td>wangwu</td>
          <td><div align="center">girl</div></td>
          <td><div align="center">25</div></td>
          <td><div align="center">officer</div></td>
          <td><div align="center">mather</div></td>
          <td><div align="center">3000</div></td>
          <td>school</td>
        </tr>
      </table></td>
    <td width="5%" class="redtext"><div align="center"></div></td>
  </tr>
  <tr class="grayStyle"> 
    <td>家庭资产负债信息分析</td>
    <td width="5%" class="redtext"><div align="center">90</div></td>
  </tr>
  <tr> 
    <td> <table width="85%" border="0" align="center" cellpadding="0" cellspacing="0" class="listTable">
        <tr height="22"> 
          <td colspan="2" class="darkColumn"> <div align="center">资产</div></td>
          <td colspan="2" class="darkColumn"> <div align="center">负债</div></td>
        </tr>
        <tr height="22"> 
          <td width="25%" class="darkColumn"> <div align="center">资产项目</div></td>
          <td width="25%" class="darkColumn"> <div align="center">金额</div></td>
          <td width="25%" class="darkColumn"> <div align="center">资产项目</div></td>
          <td width="25%" class="darkColumn"> <div align="center">金额</div></td>
        </tr>
        <tr height="22"> 
          <td class="grayStyle">现金</td>
          <td class="brightStyle"><input name="student.name252" type="text" value="100" style="width:100%"/></td>
          <td class="grayStyle">房屋贷款</td>
          <td class="brightStyle"><input name="student.name2527" type="text" value="100" style="width:100%"/></td>
        </tr>
        <tr height="22"> 
          <td class="grayStyle">活期存款</td>
          <td class="brightStyle"><input name="student.name25" type="text" value="100" style="width:100%"/></td>
          <td class="grayStyle">汽车贷款</td>
          <td class="brightStyle"><input name="student.name2526" type="text" value="100" style="width:100%"/></td>
        </tr>
        <tr height="22"> 
          <td class="grayStyle">其他</td>
          <td class="brightStyle"><input name="student.name253" type="text" value="100" style="width:100%"/></td>
          <td class="grayStyle">其他</td>
          <td class="brightStyle"><input name="student.name2525" type="text" value="100" style="width:100%"/></td>
        </tr>
        <tr height="22"> 
          <td class="grayStyle"><strong>流动性资产</strong></td>
          <td class="brightStyle"><input name="student.name254" type="text" value="100" style="width:100%"/></td>
          <td class="grayStyle"><strong>长期贷款</strong></td>
          <td class="brightStyle"><input name="student.name2524" type="text" value="100" style="width:100%"/></td>
        </tr>
        <tr height="22"> 
          <td class="grayStyle">定期存款</td>
          <td class="brightStyle"><input name="student.name255" type="text" value="100" style="width:100%"/></td>
          <td class="grayStyle">信用卡透支</td>
          <td class="brightStyle"><input name="student.name2523" type="text" value="100" style="width:100%"/></td>
        </tr>
        <tr height="22"> 
          <td class="grayStyle">基金</td>
          <td class="brightStyle"><input name="student.name256" type="text" value="100" style="width:100%"/></td>
          <td class="grayStyle">其他</td>
          <td class="brightStyle"><input name="student.name2522" type="text" value="100" style="width:100%"/></td>
        </tr>
        <tr height="22"> 
          <td class="grayStyle">国债</td>
          <td class="brightStyle"><input name="student.name257" type="text" value="100" style="width:100%"/></td>
          <td class="grayStyle"><strong>短期贷款</strong></td>
          <td class="brightStyle"><input name="student.name2521" type="text" value="100" style="width:100%"/></td>
        </tr>
        <tr height="22"> 
          <td class="grayStyle">企业债券</td>
          <td class="brightStyle"><input name="student.name258" type="text" value="100" style="width:100%"/></td>
          <td class="grayStyle">&nbsp;</td>
          <td class="brightStyle">&nbsp;</td>
        </tr>
        <tr height="22"> 
          <td class="grayStyle">股票</td>
          <td class="brightStyle"><input name="student.name259" type="text" value="100" style="width:100%"/></td>
          <td class="grayStyle">&nbsp;</td>
          <td class="brightStyle">&nbsp;</td>
        </tr>
        <tr height="22"> 
          <td class="grayStyle">保险</td>
          <td class="brightStyle"><input name="student.name2510" type="text" value="100" style="width:100%"/></td>
          <td class="grayStyle">&nbsp;</td>
          <td class="brightStyle">&nbsp;</td>
        </tr>
        <tr height="22"> 
          <td class="grayStyle">其他</td>
          <td class="brightStyle"><input name="student.name2511" type="text" value="100" style="width:100%"/></td>
          <td class="grayStyle">&nbsp;</td>
          <td class="brightStyle">&nbsp;</td>
        </tr>
        <tr height="22"> 
          <td class="grayStyle"><strong>投资性资产</strong></td>
          <td class="brightStyle"><input name="student.name2512" type="text" value="100" style="width:100%"/></td>
          <td class="grayStyle">&nbsp;</td>
          <td class="brightStyle">&nbsp;</td>
        </tr>
        <tr height="22"> 
          <td class="grayStyle">汽车</td>
          <td class="brightStyle"><input name="student.name2513" type="text" value="100" style="width:100%"/></td>
          <td class="grayStyle">&nbsp;</td>
          <td class="brightStyle">&nbsp;</td>
        </tr>
        <tr height="22"> 
          <td class="grayStyle">房屋</td>
          <td class="brightStyle"><input name="student.name2514" type="text" value="100" style="width:100%"/></td>
          <td class="grayStyle">&nbsp;</td>
          <td class="brightStyle">&nbsp;</td>
        </tr>
        <tr height="22"> 
          <td class="grayStyle">家具</td>
          <td class="brightStyle"><input name="student.name2515" type="text" value="100" style="width:100%"/></td>
          <td class="grayStyle">&nbsp;</td>
          <td class="brightStyle">&nbsp;</td>
        </tr>
        <tr height="22"> 
          <td class="grayStyle">其他</td>
          <td class="brightStyle"><input name="student.name2516" type="text" value="100" style="width:100%"/></td>
          <td class="grayStyle">&nbsp;</td>
          <td class="brightStyle">&nbsp;</td>
        </tr>
        <tr height="22"> 
          <td class="grayStyle"><strong>自用性资产</strong></td>
          <td class="brightStyle"><input name="student.name2517" type="text" value="100" style="width:100%"/></td>
          <td class="grayStyle">&nbsp;</td>
          <td class="brightStyle">&nbsp;</td>
        </tr>
        <tr height="22"> 
          <td class="grayStyle"><strong>总资产</strong></td>
          <td class="brightStyle"><input name="student.name2518" type="text" value="100" style="width:100%"/></td>
          <td class="grayStyle"><strong>总负债</strong></td>
          <td class="brightStyle"><input name="student.name2520" type="text" value="100" style="width:100%"/></td>
        </tr>
        <tr height="22"> 
          <td class="grayStyle"><strong>总净值</strong></td>
          <td colspan="3" class="brightStyle"><input name="student.name2519" type="text" value="100" style="width:100%"/></td>
        </tr>
      </table></td>
    <td width="5%" class="redtext"><div align="center"></div></td>
  </tr>
  <tr class="grayStyle"> 
    <td>家庭月度收支分析</td>
    <td width="5%" class="redtext"><div align="center">90</div></td>
  </tr>
  <tr> 
    <td> <table width="85%" border="0" align="center" cellpadding="0" cellspacing="0" class="listTable">
        <tr height="22"> 
          <td colspan="2" class="darkColumn"> <div align="center">收入</div></td>
          <td colspan="2" class="darkColumn"> <div align="center">支出</div></td>
        </tr>
        <tr height="22"> 
          <td width="25%" class="darkColumn"> <div align="center">收入项目</div></td>
          <td width="25%" class="darkColumn"> <div align="center">金额</div></td>
          <td width="25%" class="darkColumn"> <div align="center">支出项目</div></td>
          <td width="25%" class="darkColumn"> <div align="center">金额</div></td>
        </tr>
        <tr height="22"> 
          <td class="grayStyle">薪资</td>
          <td class="brightStyle"><input name="student.name252" type="text" value="100" style="width:100%"/></td>
          <td class="grayStyle">日常支出</td>
          <td class="brightStyle"><input name="student.name2527" type="text" value="100" style="width:100%"/></td>
        </tr>
        <tr height="22"> 
          <td class="grayStyle">奖金</td>
          <td class="brightStyle"><input name="student.name25" type="text" value="100" style="width:100%"/></td>
          <td class="grayStyle">教育支出</td>
          <td class="brightStyle"><input name="student.name2526" type="text" value="100" style="width:100%"/></td>
        </tr>
        <tr height="22"> 
          <td class="grayStyle">其他</td>
          <td class="brightStyle"><input name="student.name253" type="text" value="100" style="width:100%"/></td>
          <td class="grayStyle">医疗支出</td>
          <td class="brightStyle"><input name="student.name2525" type="text" value="100" style="width:100%"/></td>
        </tr>
        <tr height="22"> 
          <td class="grayStyle"><strong>工作收入</strong></td>
          <td class="brightStyle"><input name="student.name254" type="text" value="100" style="width:100%"/></td>
          <td class="grayStyle">房屋贷款</td>
          <td class="brightStyle"><input name="student.name2524" type="text" value="100" style="width:100%"/></td>
        </tr>
        <tr height="22"> 
          <td class="grayStyle">利息收入</td>
          <td class="brightStyle"><input name="student.name255" type="text" value="100" style="width:100%"/></td>
          <td class="grayStyle">汽车贷款</td>
          <td class="brightStyle"><input name="student.name2523" type="text" value="100" style="width:100%"/></td>
        </tr>
        <tr height="22"> 
          <td class="grayStyle">投资收入</td>
          <td class="brightStyle"><input name="student.name256" type="text" value="100" style="width:100%"/></td>
          <td class="grayStyle">其他</td>
          <td class="brightStyle"><input name="student.name2522" type="text" value="100" style="width:100%"/></td>
        </tr>
        <tr height="22"> 
          <td class="grayStyle">其他</td>
          <td class="brightStyle"><input name="student.name257" type="text" value="100" style="width:100%"/></td>
          <td class="grayStyle"><strong>经常性支出</strong></td>
          <td class="brightStyle"><input name="student.name2521" type="text" value="100" style="width:100%"/></td>
        </tr>
        <tr height="22"> 
          <td class="grayStyle"><strong>理财收入</strong></td>
          <td class="brightStyle"><input name="student.name258" type="text" value="100" style="width:100%"/></td>
          <td class="grayStyle">保费支出</td>
          <td class="brightStyle"><input name="student.name25212" type="text" value="100" style="width:100%"/></td>
        </tr>
        <tr height="22"> 
          <td class="grayStyle">&nbsp;</td>
          <td class="brightStyle">&nbsp;</td>
          <td class="grayStyle">其他</td>
          <td class="brightStyle"><input name="student.name25213" type="text" value="100" style="width:100%"/></td>
        </tr>
        <tr height="22"> 
          <td class="grayStyle">&nbsp;</td>
          <td class="brightStyle">&nbsp;</td>
          <td class="grayStyle">非经常性支出</td>
          <td class="brightStyle"><input name="student.name25214" type="text" value="100" style="width:100%"/></td>
        </tr>
        <tr height="22"> 
          <td class="grayStyle"><strong>总收入</strong></td>
          <td class="brightStyle"><input name="student.name2518" type="text" value="100" style="width:100%"/></td>
          <td class="grayStyle"><strong>总支出</strong></td>
          <td class="brightStyle"><input name="student.name2520" type="text" value="100" style="width:100%"/></td>
        </tr>
        <tr height="22"> 
          <td class="grayStyle"><strong>总结余</strong></td>
          <td colspan="3" class="brightStyle"><input name="student.name2519" type="text" value="100" style="width:100%"/></td>
        </tr>
      </table></td>
    <td width="5%" class="redtext"><div align="center"></div></td>
  </tr>
  <tr class="grayStyle"> 
    <td>保险资产明细分析</td>
    <td width="5%" class="redtext"><div align="center">90</div></td>
  </tr>
  <tr> 
    <td> <table width="85%" border="0" class="listTable" align="center">
        <tr class="darkColumn" align="center"> 
          <td width="9%">保单编号</td>
          <td width="10%">保险公司</td>
          <td width="9%">被保险人、物</td>
          <td width="12%">主契约险种</td>
          <td width="7%">主契约保额</td>
          <td width="14%">主契约年保费</td>
          <td width="13%">缴费年限</td>
          <td width="22%">详细</td>
        </tr>
        <tr class="brightStyle" onMouseOver="swapOverTR(this,this.className)"onmouseout="swapOutTR(this)" onClick="onRowChange(event)"> 
          <td>zhangsan</td>
          <td>boy</td>
          <td>30</td>
          <td>lawyer</td>
          <td><div align="center">father</div></td>
          <td><div align="center">5000</div></td>
          <td><div align="center">bank</div></td>
          <td><div align="center">详细</div></td>
        </tr>
        <tr class="grayStyle"onMouseOver="swapOverTR(this,this.className)"onmouseout="swapOutTR(this)" onClick="onRowChange(event)"> 
          <td>wangwu</td>
          <td>girl</td>
          <td>25</td>
          <td>officer</td>
          <td><div align="center">mather</div></td>
          <td><div align="center">3000</div></td>
          <td><div align="center">school</div></td>
          <td><div align="center">详细</div></td>
        </tr>
      </table></td>
    <td width="5%" class="redtext"><div align="center"></div></td>
  </tr>
  <tr class="grayStyle"> 
    <td>客户风险承受能力分析</td>
    <td width="5%" class="redtext"><div align="center">90</div></td>
  </tr>
  <tr> 
    <td> <table width="85%" border="0" align="center" cellpadding="0" cellspacing="0" class='listTable'>
        <tr> 
          <td class="grayStyle">1、就业状况</td>
        </tr>
        <tr> 
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="brightStyle">
              <tr> 
                <td width="4%"><div align="center"> 
                    <input type="radio" name="radiobutton" value="radiobutton">
                  </div></td>
                <td width="96%">公教人员</td>
              </tr>
              <tr> 
                <td><div align="center"> 
                    <input type="radio" name="radiobutton" value="radiobutton">
                  </div></td>
                <td>上班族</td>
              </tr>
              <tr> 
                <td><div align="center"> 
                    <input type="radio" name="radiobutton" value="radiobutton">
                  </div></td>
                <td>佣金收入者</td>
              </tr>
              <tr> 
                <td><div align="center"> 
                    <input type="radio" name="radiobutton" value="radiobutton">
                  </div></td>
                <td>自营失业者</td>
              </tr>
              <tr> 
                <td><div align="center"> 
                    <input type="radio" name="radiobutton" value="radiobutton">
                  </div></td>
                <td>失业</td>
              </tr>
              <tr> 
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
            </table></td>
        </tr>
      </table></td>
    <td width="5%" class="redtext"><div align="center"></div></td>
  </tr>
  <tr class="grayStyle"> 
    <td>客户分析综述</td>
    <td width="5%" class="redtext"><div align="center"><input type='text' name='mark' vlaue='' style="WIDTH: 40px" ></div></td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
    <td width="5%" class="redtext"><div align="center"></div></td>
  </tr>
  <tr class="darkColumn"> 
    <td><B>理财目标分析</B></td>
    <td width="5%" class="redtext"><div align="center"></div></td>
  </tr>
  <tr class="grayStyle"> 
    <td>客户理财目标分析</td>
    <td width="5%" class="redtext"><div align="center"><input type='text' name='mark' vlaue='' style="WIDTH: 40px" ></div></td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
    <td width="5%" class="redtext"><div align="center"></div></td>
  </tr>
  <tr class="darkColumn"> 
    <td><B>理财规划制定</B></td>
    <td width="5%" class="redtext"><div align="center"></div></td>
  </tr>
  <tr class="grayStyle"> 
    <td>现金规划制定</td>
    <td width="5%" class="redtext"><div align="center"><input type='text' name='mark' vlaue='' style="WIDTH: 40px" ></div></td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
    <td width="5%" class="redtext"><div align="center"></div></td>
  </tr>
  <tr class="grayStyle"> 
    <td>消费支出规划制定</td>
    <td width="5%" class="redtext"><div align="center"><input type='text' name='mark' vlaue='' style="WIDTH: 40px" ></div></td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
    <td width="5%" class="redtext"><div align="center"></div></td>
  </tr>
  <tr class="grayStyle"> 
    <td>教育规划制定</td>
    <td width="5%" class="redtext"><div align="center"><input type='text' name='mark' vlaue='' style="WIDTH: 40px" ></div></td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
    <td width="5%" class="redtext"><div align="center"></div></td>
  </tr>
  <tr class="grayStyle"> 
    <td>风险管理与保险规划制定</td>
    <td width="5%" class="redtext"><div align="center"><input type='text' name='mark' vlaue='' style="WIDTH: 40px" ></div></td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
    <td width="5%" class="redtext"><div align="center"></div></td>
  </tr>
  <tr class="grayStyle"> 
    <td>税收规划制定</td>
    <td width="5%" class="redtext"><div align="center"><input type='text' name='mark' vlaue='' style="WIDTH: 40px" ></div></td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
    <td width="5%" class="redtext"><div align="center"></div></td>
  </tr>
  <tr class="grayStyle"> 
    <td>退休养老规划制定</td>
    <td width="5%" class="redtext"><div align="center"><input type='text' name='mark' vlaue='' style="WIDTH: 40px" ></div></td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
    <td width="5%" class="redtext"><div align="center"></div></td>
  </tr>
  <tr class="grayStyle"> 
    <td>投资规划制定</td>
    <td width="5%" class="redtext"><div align="center"><input type='text' name='mark' vlaue='' style="WIDTH: 40px" ></div></td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
    <td width="5%" class="redtext"><div align="center"></div></td>
  </tr>
  <tr class="grayStyle"> 
    <td>财产分配和传承规划制定</td>
    <td width="5%" class="redtext"><div align="center"><input type='text' name='mark' vlaue='' style="WIDTH: 40px" ></div></td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
    <td width="5%" class="redtext"><div align="center"></div></td>
  </tr>
  <tr class="grayStyle"> 
    <td>房产规划制定</td>
    <td width="5%" class="redtext"><div align="center"><input type='text' name='mark' vlaue='' style="WIDTH: 40px" ></div></td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
    <td width="5%" class="redtext"><div align="center"></div></td>
  </tr>
  <tr class="grayStyle"> 
    <td>综合理财规划制定</td>
    <td width="5%" class="redtext"><div align="center"><input type='text' name='mark' vlaue='' style="WIDTH: 40px" ></div></td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
    <td width="5%" class="redtext"><div align="center"></div></td>
  </tr>
  <tr class="darkColumn"> 
    <td><B>动态平衡</B></td>
    <td width="5%" class="redtext"><div align="center"></div></td>
  </tr>
  <tr class="grayStyle"> 
    <td>动态平衡调整</td>
    <td width="5%" class="redtext"><div align="center"><input type='text' name='mark' vlaue='' style="WIDTH: 40px" ></div></td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
    <td width="5%" class="redtext"><div align="center"></div></td>
  </tr>
  <tr class="darkColumn"> 
    <td><B>理财方案评估</B></td>
    <td width="5%" class="redtext"><div align="center"></div></td>
  </tr>
  <tr class="grayStyle"> 
    <td>理财方案评估</td>
    <td width="5%" class="redtext"><div align="center"><input type='text' name='mark' vlaue='' style="WIDTH: 40px" ></div></td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
    <td width="5%" class="redtext"><div align="center"></div></td>
  </tr>
  <tr class="darkColumn"> 
    <td><B>总分</B></td>
    <td width="5%" class="redtext"><div align="center"><input type='text' name='mark' vlaue='' style="WIDTH: 40px" readonly></div></td>
  </tr>
  <tr class="darkColumn" align="center">
      <td colspan="4">
          <input type="button" onClick='save(this.form)' value="<@text name="system.button.submit"/>" class="buttonStyle"/>
          <input type="button" onClick='reset()' value="<@text name="system.button.reset"/>" class="buttonStyle"/>
      </td>
    </tr>
</table>
<script language="javascript">
    var bar=new ToolBar("taskBar","实验得分",null,true,true);
    bar.setMessage('<div class="message fade-ffff00"  id="error"></div><div class="message fade-ffff00"  id="message"></div>');
    bar.addBackOrClose("关闭", "关闭");
</script>
<#include "/template/foot.ftl"/>