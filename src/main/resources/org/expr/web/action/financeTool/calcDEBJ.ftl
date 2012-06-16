<#include "/template/head.ftl"/>
<SCRIPT type=text/javascript>
	function $(id){
		return document.getElementById(id);
	}
	var rateList = [[0.0576,0.0594,0.0333,0.0387,'08年12月23日基准利率'],[0.0594,0.0612,0.0351,0.0405,'08年11月27日基准利率'],[0.0403,0.0416,0.0333,0.0387,'08年12月23日利率下限(7折)'],[0.049,0.0505,0.0333,0.0387,'08年12月23日利率上限(8.5折)'],[0.0634,0.0653,0.0333,0.0387,'08年12月23日第二套房(1.1倍)'],[0.0653,0.0673,0.0351,0.0405,'08年11月27日利率上限'],[0.0416,0.0428,0.0351,0.0405,'08年11月27日利率下限']];
</SCRIPT>

<SCRIPT type=text/javascript>
	function setRateSelect( mortgageYear){
		var loanType = $("loanType").value;
		var selectRate = document.getElementById("rateSelect");
		selectRate.options.length = 0;
		if(loanType == 1){
			var rateIndex = mortgageYear > 5 ? 1 : 0;
		}
		else{
			var rateIndex = mortgageYear > 5 ? 3 : 2;
		}
		for(i=0;i<rateList.length;i++){
			selectRate.options.add(new Option(rateList[i][4] , rateList[i][rateIndex]));
		}
	}

</SCRIPT>
<SCRIPT language=JavaScript>
/*
*v:选择的贷款类别值
*/
function changeLoanType(fmobj,v){
	if (v==3){
		$("zuheDiv").style.display='block';
		fmobj.jisuan_radio[1].checked = true;
		$("autoRateDiv").style.display = 'block';
		$("manualRateCkx").style.display = 'none';
		$("manualRateLabel").style.display = 'none';
		changeCalcType(fmobj , 2,3);
	}else{
		$("autoRateDiv").style.display = 'block';
		$("manualRateDiv").style.display = 'none';
		$("manualRateCkx").style.display = 'block';
		$("manualRateLabel").style.display = 'block';
		$("zuheDiv").style.display='none';
		changeCalcType(fmobj , getJsRadio(), v);
	}
	setRateSelect( $("years").value);
}
//取得当前选中的计算方式的值
function getJsRadio(){
	 var radios = document.getElementsByName("jisuan_radio");
	 var total = radios.length;
	 for(var i=0;i<total;i++){
		  if(radios[i].checked==true) return radios[i].value;
	 }
}
/*
**typevalue:贷款类别的值
**v:计算方式的值
*/
function changeCalcType(fmobj , v , typevalue){
	if (v==1){
		document.getElementById("calcByAreaDiv").style.display='block';
		document.getElementById("calcByMoneyDiv").style.display='none';
		$("zuheDiv").style.display='none';
		}else{
		document.getElementById("calcByAreaDiv").style.display='none';
		document.getElementById("calcByMoneyDiv").style.display='block';
	}
	setRateSelect( 20);
	changeLoantime();
}
function formReset(fmobj){
	document.getElementById("calcByAreaDiv").style.display='block';
	document.getElementById("calcByMoneyDiv").style.display='none';
	$("zuheDiv").style.display='none';
	//fmobj.calc2_benxi.style.display='none';
}

//验证是否为数字
function reg_Num(str){
	if (str.length==0){return false;}
	var Letters = "1234567890.";

	for (i=0;i<str.length;i++){
		var CheckChar = str.charAt(i);
		if (Letters.indexOf(CheckChar) == -1){return false;}
	}
	return true;
}

//得到利率

//本金还款的月还款额(参数: 月利率 / 贷款总额 / 贷款总月份 / 贷款当前月0～length-1)
function getRefundPerMonth(lilv,total,month,cur_month){
	var lilv_month = lilv ;//月利率
	//return total * lilv_month * Math.pow(1 + lilv_month, month) / ( Math.pow(1 + lilv_month, month) -1 );
	var benjin_money = total/month;
	return (total - benjin_money * cur_month) * lilv_month + benjin_money;
}

//  组合型贷款(组合型贷款的计算，只和商业贷款额、和公积金贷款额有关，和按贷款总额计算无关)
function calcZuhe(fmobj){
	//先清空月还款数下拉框
	while ((k=fmobj.refundMonth.length-1)>=0){
		fmobj.refundMonth.options.remove(k);
	}
	var years = fmobj.years.value;
	var month = fmobj.years.value * 12;

	fmobj.loanMonth.value = month+"(月)";
		if (!reg_Num(fmobj.total_sy.value)){
			alert("混合型贷款请填写商贷比例");
			fmobj.total_sy.focus();return false;
		}
		if (!reg_Num(fmobj.total_gjj.value)){
			alert("混合型贷款请填写公积金比例");
			fmobj.total_gjj.focus();return false;
		}
		if (fmobj.total_sy.value==null){fmobj.total_sy.value=0;}
		if (fmobj.total_gjj.value==null){fmobj.total_gjj.value=0;}
		var total_sy = fmobj.total_sy.value;
		var total_gjj = fmobj.total_gjj.value;
		fmobj.fangkuan_total.value = "略";//房款总额
		fmobj.money_first.value = 0;//首期付款

		//贷款总额
		var total_sy = parseInt(fmobj.total_sy.value);
		var total_gjj = parseInt(fmobj.total_gjj.value);
		var daikuan_total = total_sy + total_gjj;
		fmobj.daikuan_total.value = daikuan_total;

		//月还款
		var lilv_gjj = fmobj.rateSelect.value;
		var arrIndex = fmobj.rateSelect.selectedIndex;
		var rateIndex = years > 5 ? 1 :0;
		var lilv_biz = rateList[arrIndex][rateIndex];
		//月还款
		var refundMonth = "";
		var refund = 0;
		for(j=0;j<month;j++) {
			//调用函数计算: 本金月还款额
			huankuan = getRefundPerMonth(lilv_biz,total_sy,month,j) + getRefundPerMonth(lilv_gjj,total_gjj,month,j);
			refund += huankuan;
			huankuan = Math.round(huankuan*1);
			//fmobj.refundMonth.options[j] = new Option( (j+1) +"月," + huankuan + "(元)", huankuan);
			refundMonth += (j+1) +"月," + huankuan + "(元)\n";
		}
		fmobj.refundMonth.value = refundMonth;
		//还款总额
		fmobj.refund.value = Math.round(refund*1);
		//支付利息款
		fmobj.accrual2.value = Math.round( (refund - daikuan_total) *1);
}
//--  商业贷款、公积金贷款
function calcGjjBiz(fmobj){
	//先清空月还款数下拉框
	while ((k=fmobj.refundMonth.length-1)>=0){
		fmobj.refundMonth.options.remove(k);
	}
	var years = fmobj.years.value;
	var month = fmobj.years.value * 12;

	fmobj.loanMonth.value = month+"(月)";

	//var lilv = fmobj.rateSelect.value;
	if($("manualRateDiv").style.display == 'block'){
		if($("rateText").value * 1 <= 0 || isNaN($('rateText').value)){
			alert("请输入正确利率");
			return false;
		}
		lilv = ($("rateText").value/100 /12).toFixed(4) * 1;
	}
	else{
		lilv = ($("rateSelect").value /12).toFixed(4) * 1;
	}
	if (fmobj.jisuan_radio[0].checked == true){
		//------------ 根据单价面积计算
		if (!reg_Num(fmobj.price.value)){
			alert("请填写单价");
			fmobj.price.focus();
			return false;
		}
		if (!reg_Num(fmobj.sqm.value)){
			alert("请填写面积");
			fmobj.sqm.focus();
			return false;
		}

		//房款总额
		var fangkuan_total = fmobj.price.value * fmobj.sqm.value;
		fmobj.fangkuan_total.value = fangkuan_total;
		//贷款总额
		var daikuan_total = (fmobj.price.value * fmobj.sqm.value) * (fmobj.anjie.value/10);
		fmobj.daikuan_total.value = daikuan_total;
		//首期付款
		var money_first = fangkuan_total - daikuan_total;
		fmobj.money_first.value = money_first;
	}else{
		//------------ 根据贷款总额计算
		if (fmobj.daikuan_totalinput.value.length==0){
			alert("请填写贷款总额");
			fmobj.daikuan_totalinput.focus();return false;
		}

		//房款总额
		fmobj.fangkuan_total.value = "略";
		//贷款总额
		var daikuan_total = fmobj.daikuan_totalinput.value;
		fmobj.daikuan_total.value = daikuan_total;
		//首期付款
		fmobj.money_first.value = 0;
	}
	//月还款
	var refund = 0;
	var refundMonth = "";
	for(j=0;j<month;j++) {
		//调用函数计算: 本金月还款额
		huankuan = getRefundPerMonth(lilv,daikuan_total,month,j);
		refund += huankuan;
		huankuan = Math.round(huankuan*1);
		refundMonth += (j+1) +"月," + huankuan + "(元)\n";
	}
	fmobj.refundMonth.value = refundMonth;
	//还款总额
	fmobj.refund.value = Math.round(refund*1);
	//支付利息款
	fmobj.accrual2.value = Math.round( (refund - daikuan_total) *100)/100;
}
/**
 * getResult 
 * 计算得到结果
 * @param formObj $formObj 
 * @access public
 * @return void
 */
function getResult(formObj){
	if($("loanType").options[$("loanType").selectedIndex].value == 3){
		calcZuhe(formObj);
	}
	else calcGjjBiz(formObj);
}
function changeLoantime()
{
 	if(document.forms[0].loanType.value==1) document.getElementById("loantime").innerHTML="还款期数：";
	else document.getElementById("loantime").innerHTML="贷款月数：";
}
</SCRIPT>


<BODY LEFTMARGIN="0" TOPMARGIN="0">
    <FORM id=calcForm name=calc2 action=calc_win.php method=post>
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCFF" style="border-collapse:collapse;" >
  <tr> 
    <td height="23" background="${base}/static/images/titlebg.gif"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
            <td><img src="${base}/static/images/titlearrow.gif" width="8" height="13"> <span class="title"><B>等额本金还款计算器</B></span></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td> <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
            <td height="25" class="explain"><B>等额本金还款计算器可以帮助您计算在等额本息还款方式下的各项数据</B></td>
        </tr>
      </table>
        
        <TABLE width=95% border="0" align="center" cellpadding="0" cellSpacing=0>
          <TBODY>
            <TR> 
              <TD height="21" align=left class="head">计算公式</TD>
            </TR>
            <TR> 
              <TD height="1" background="${base}/static/images/dline.gif"></TD>
            </TR>
            <TR> 
              <TD><TABLE class=cBlue cellSpacing=1 cellPadding=5 width=524 
                  align=left border=0>
                  <TBODY>
                    <TR class="zhengwen"> 
                      <TD width="104" height=24>贷款类别：</TD>
                      <TD width="491"> 
                        <SELECT id=loanType 
                        onchange=changeLoanType(this.form,this.value); 
                        name=loanType style="font-size:12px;">
                          <OPTION value=1 selected>商业贷款</OPTION>
                          <OPTION value=2>公积金</OPTION>
                          <OPTION 
                          value=3>组合型</OPTION>
                        </SELECT></TD>
                    </TR>
                    <TR class=zhengwen vAlign=top> 
                      <TD height=24>计算方式：</TD>
                      <TD>　 
                        <DIV>
                          <INPUT id=calc2_radio1 
                        onclick=changeCalcType(document.forms[0],1,document.forms[0].loanType.value); 
                        type=radio CHECKED value=1 name=jisuan_radio>
                          <LABEL 
                        for=calc2_radio1>根据面积、单价计算</LABEL>
                        </DIV>
                        <DIV id=calcByAreaDiv style="DISPLAY: block"> 
                          <TABLE class=cBlue cellSpacing=0 cellPadding=0 width=200 
                        border=0>
                            <TBODY>
                              <TR> 
                                <TD class=l15 colSpan=2>　<span class="zhengwen">单价： 
                                  <input class="inputBox" maxLength=8 
                              size=8 name=price>
                                  元/平米<BR>
                                  　面积： 
                                  <input class="inputBox" maxLength=7 
                              size=8 name=sqm>
                                  平方米<BR>
                                  　按揭成数： 
                                  <SELECT size=1 
                              name=anjie style="font-size:12px;">
                                    <OPTION value=9>9成</OPTION>
                                    <OPTION 
                                value=8 selected>8成</OPTION>
                                    <OPTION 
                                value=7>7成</OPTION>
                                    <OPTION value=6>6成</OPTION>
                                    <OPTION value=5>5成</OPTION>
                                    <OPTION 
                                value=4>4成</OPTION>
                                    <OPTION value=3>3成</OPTION>
                                    <OPTION value=2>2成</OPTION>
                                  </SELECT>
                                  </span> </TD>
                              </TR>
                            </TBODY>
                          </TABLE>
                        </DIV>
                        <DIV>
                          <INPUT id=calc2_radio2 
                        onclick=changeCalcType(document.forms[0],2,document.forms[0].loanType.value); 
                        type=radio value=2 name=jisuan_radio>
                          <LABEL 
                        for=calc2_radio2>根据贷款总额计算</LABEL>
                        </DIV>
                        <DIV id=zuheDiv style="DISPLAY: none"> 
                          <TABLE width="258" cellPadding=0 cellSpacing=0 class=cBlue>
                            <TBODY>
                              <TR> 
                                <TD class="zhengwen">组合比例：</TD>
                              </TR>
                              <TR> 
                                <TD class="zhengwen">商业性： 
                                  <input class="inputBox" maxLength=8 size=8 
                              name=total_sy>
                                  元</TD>
                              </TR>
                              <TR> 
                                <TD class="zhengwen">公积金： 
                                  <input class="inputBox" maxLength=8 size=8 
                              name=total_gjj>
                                  元</TD>
                              </TR>
                            </TBODY>
                          </TABLE>
                        </DIV>
                        　 
                        <DIV id=calcByMoneyDiv style="DISPLAY: none"> 
                          <TABLE class=cBlue cellSpacing=0 cellPadding=0 
                        width="51%" border=0>
                            <TBODY>
                              <TR class="zhengwen"> 
                                <TD>贷款总额：</TD>
                                <TD> 
                                  <input class="inputBox" maxLength=8 size=10 
                              name=daikuan_totalinput>
                                  元 </TD>
                              </TR>
                            </TBODY>
                          </TABLE>
                        </DIV></TD>
                    </TR>
                    <TR class=zhengwen> 
                      <TD height=24>按揭年数：</TD>
                      <TD> 
                        <SELECT id=years 
                        onchange=setRateSelect(this.value) size=1 name=years style="font-size:12px;">
                          <OPTION value=1>1年（12期）</OPTION>
                          <OPTION 
                          value=2>2年（24期）</OPTION>
                          <OPTION 
                          value=3>3年（36期）</OPTION>
                          <OPTION 
                          value=4>4年（48期）</OPTION>
                          <OPTION 
                          value=5>5年（60期）</OPTION>
                          <OPTION 
                          value=6>6年（72期）</OPTION>
                          <OPTION 
                          value=7>7年（84期）</OPTION>
                          <OPTION 
                          value=8>8年（96期）</OPTION>
                          <OPTION 
                          value=9>9年（108期）</OPTION>
                          <OPTION 
                          value=10>10年（120期）</OPTION>
                          <OPTION 
                          value=11>11年（132期）</OPTION>
                          <OPTION 
                          value=12>12年（124期）</OPTION>
                          <OPTION 
                          value=13>13年（156期）</OPTION>
                          <OPTION 
                          value=14>14年（168期）</OPTION>
                          <OPTION 
                          value=15>15年（180期）</OPTION>
                          <OPTION 
                          value=16>16年（192期）</OPTION>
                          <OPTION 
                          value=17>17年（204期）</OPTION>
                          <OPTION 
                          value=18>18年（216期）</OPTION>
                          <OPTION 
                          value=19>19年（228期）</OPTION>
                          <OPTION value=20 
                          selected>20年（240期）</OPTION>
                          <OPTION 
                          value=25>25年（300期）</OPTION>
                          <OPTION 
                          value=30>30年（360期）</OPTION>
                        </SELECT></TD>
                    </TR>
                    <!--------------需要添加input元素的地方开始--------------->
                    <TR class=zhengwen> 
                      <TD id=lilvtitle 
                      height=24 style="font-size:12px;">利率：</TD>
                      <TD>　 
                        <DIV id=autoRateDiv>
                          <SELECT id=rateSelect 
                        name=rateSelect style="font-size:12px;">
                          </SELECT>
                          <INPUT id=manualRateCkx 
                        type=checkbox value=manual name=manualRateCkx>
                          <LABEL 
                        id=manualRateLabel for=manualRateCkx 
                        name="manualRateLabel">手动输入利率</LABEL>
                        </DIV>
                        <DIV id=manualRateDiv style="DISPLAY: none">
                          <input class="inputBox" 
                        id=rateText size=5 name=rateText>
                          % 
                          <INPUT id=autoRateCkx 
                        type=checkbox value=manual name=autoRateCkx>
                          <LABEL 
                        for=autoRateCkx>选择给定利率</LABEL>
                        </DIV></TD>
                    </TR>
                    <!---------------需要添加input元素的地方结束--------------->
                    <TR class=zhengwen> 
                      <TD height=24 colSpan=2> 
                        <DIV align=center>
                          <INPUT class=btn200040701 style="COLOR: #ffffff; PADDING-TOP: 2px; BACKGROUND-COLOR: #1070d0" onclick=getResult(this.form); type=button value=开始计算 name=button1>
                          　 
                          <INPUT class=btn200040701 style="COLOR: #ffffff; PADDING-TOP: 2px; BACKGROUND-COLOR: #1070d0" onclick=formReset(this.form); type=reset value=重新计算 name=button2>
                        </DIV></TD>
                    </TR>
                  </TBODY>
                </TABLE></TD>
            </TR>
            <TR> 
              <TD height="25" align=left class="head">计算结果</TD>
            </TR>
			            <TR> 
              <TD height="1" background="${base}/static/images/dline.gif"></TD>
            </TR>
            <TR> 
              <TD class=p10 vAlign=top height=25><DIV id=calc2_benjin 
                  style=" LEFT: 0px; POSITION: relative; TOP: 0px;"> 
                  <TABLE width=350  border=0>
                    <TBODY>
                      <TR class="zhengwen"> 
                        <TD width="41%" height=25>房款总额：</TD>
                        <TD width="59%" height="25">　 
                          <input class="inputBox" disabled
                    name=fangkuan_total></TD>
                      </TR>
                      <TR class="zhengwen"> 
                        <TD height=25>贷款总额：</TD>
                        <TD height="25">　 
                          <input class="inputBox" disabled name=daikuan_total></TD>
                      </TR>
                      <TR class="zhengwen"> 
                        <TD height=25>还款总额：</TD>
                        <TD height="25">　 
                          <input class="inputBox" disabled name=refund></TD>
                      </TR>
                      <TR class="zhengwen"> 
                        <TD height=25 noWrap>支付利息：</TD>
                        <TD height="25">　 
                          <input class="inputBox" disabled name=accrual2></TD>
                      </TR>
                      <TR class="zhengwen"> 
                        <TD height=25>首期付款：</TD>
                        <TD height="25">　 
                          <input class="inputBox" disabled name=money_first></TD>
                      </TR>
                      <TR class="zhengwen"> 
                        <TD height=25 id=loantime>贷款月数：</TD>
                        <TD height="25">　 
                          <input class="inputBox" disabled name=loanMonth></TD>
                      </TR>
                      <TR class="zhengwen"> 
                        <TD height=25>月还金额：</TD>
                        <TD height=25>　 
                          <TEXTAREA class=p9 name=refundMonth rows=5></TEXTAREA></TD>
                      </TR>
                    </TBODY>
                  </TABLE>
                </DIV> </TD>
            </TR>
            <TR> 
          
            <TR> 
              <TD height="25" align=left class="head">说明</TD>
            </TR>
            <TR> 
              <TD height="1" background="${base}/static/images/dline.gif"></TD>
            </TR>
            <TR> 
              <TD valign="top" class="zhengwen"><P>等额本金还款方式是将本金每月等额偿还，然后根据剩余本金计算利息，所以初期由于本金较多，将支付较多的利息，从而使还款额在初期较多，而在随后的时间每月递减，这种方式的好处是，由于在初期偿还较大款项而减少利息的支出，比较适合还款能力较强的家庭。 
                </P>
                <P>注：１北京公积金贷款最高额度为80万元人民币；</P>
                <P>２对已贷款购买一套住房但人均面积低于当地平均水平，再申请购买第二套普通自住房的居民，比照执行首次贷款购买普通自住房的优惠政策。 
                </P></TD>
            </TR>
          </TBODY>
        </TABLE>
	</td>
  </tr>
</table>
</form>
<SCRIPT type=text/javascript>
$("manualRateCkx").onclick=function(){
	$("manualRateDiv").style.display="block";
	$("autoRateDiv").style.display="none";
	$("autoRateCkx").checked=false;
	$("manualRateCkx").checked= true;
}
$("autoRateCkx").onclick=function(){
	$("manualRateDiv").style.display="none";
	$("autoRateDiv").style.display="block";
	$("autoRateCkx").checked= true;
	$("manualRateCkx").checked= false;
}
window.onload=function(){
	changeCalcType(document.forms[0] ,1,document.forms[0].loanType.value );
}
</SCRIPT>
</body>
<#include "/template/foot.ftl"/>