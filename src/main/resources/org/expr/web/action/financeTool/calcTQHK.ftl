<#include "/template/head.ftl"/>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/calendar.js" charset="gb2312"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/financeTool/CheckDataFunction.js" charset="gb2312"></script>

<script language='javascript'  charset="gb2312">
function ChkCZDate(edit){
    edit.value=Trim(edit.value);
    if(edit.value=="") return true;
    if(!Cal_datevalid(edit,"1910-1-1","3000-1-1")) {
        alert("日期格式不正确,日期有效范围为1910年到3000年");
        edit.focus();
    }
}

function checkCalc(){
    if ($("dkzws").value==""){
        alert("请填入贷款总额");
        $("dkzws").focus();
        return false;
    }else dkzys=parseFloat($("dkzws").value)*10000;

    if($("tqhkfs_1").checked && $("tqhkws").value==""){
        alert("请填入部分提前还款额度");
        $("tqhkws").focus();
        return false;
    }

    var s_yhkqs=parseInt($("yhkqs").value);
    //月利率
    if($("dklx_0").checked){
	    if (s_yhkqs>60){
		    dklv=getlilv($("dklv_class").value,2,10)/12; //公积金贷款利率5年以上4.23%
	    }else{
		    dklv=getlilv($("dklv_class").value,2,3)/12;  //公积金贷款利率5年(含)以下3.78%
	    }
    }
    if($("dklx_1").checked){
	    if (s_yhkqs>60){
		    dklv=getlilv($("dklv_class").value,1,10)/12; //商业性贷款利率5年以上5.31%
	    }else{
		    dklv=getlilv($("dklv_class").value,1,3)/12; //商业性贷款利率5年(含)以下4.95%
	    }
    }

    //已还贷款期数
    var ylhkDate=new Date();
	ylhkDate.setTime(Cal_strtodate($("dychksj").value));
    var tqhkDate=new Date();
	tqhkDate.setTime(Cal_strtodate($("yjtqhksj").value));
    yhdkqs=(parseInt(tqhkDate.getFullYear())*12 + parseInt(tqhkDate.getMonth()+1))-(parseInt(ylhkDate.getFullYear())*12 + parseInt(ylhkDate.getMonth()+1));

    if(yhdkqs<0 || yhdkqs>s_yhkqs){
        alert("预计提前还款时间与第一次还款时间有矛盾，请查实");
        return false;
    }

    yhk=dkzys*(dklv*Math.pow((1+dklv),s_yhkqs))/(Math.pow((1+dklv),s_yhkqs)-1);
    yhkjssj=Math.floor((parseInt(ylhkDate.getFullYear())*12+parseInt(ylhkDate.getMonth()+1)+s_yhkqs-2)/12)+"年"+((parseInt(ylhkDate.getFullYear())*12+parseInt(ylhkDate.getMonth()+1)+s_yhkqs-2)%12+1)+"月";
    yhdkys=yhk*yhdkqs;

    yhlxs=0;
    yhbjs=0;
    for(i=1;i<=yhdkqs;i++){
        yhlxs=yhlxs+(dkzys-yhbjs)*dklv;
        yhbjs=yhbjs+yhk-(dkzys-yhbjs)*dklv;
    }

    remark="";
    if($("tqhkfs_1").checked){
        tqhkys=parseInt($("tqhkws").value)*10000;
        if(tqhkys+yhk>=(dkzys-yhbjs)*(1+dklv)){
            remark="您的提前还款额已足够还清所欠贷款！";
        }else{
            yhbjs=yhbjs+yhk;
            byhk=yhk+tqhkys;
            if($("clfs_0").checked){
                yhbjs_temp=yhbjs+tqhkys;
                for(xdkqs=0;yhbjs_temp<=dkzys;xdkqs++) yhbjs_temp=yhbjs_temp+yhk-(dkzys-yhbjs_temp)*dklv;
                xdkqs=xdkqs-1;
                xyhk=(dkzys-yhbjs-tqhkys)*(dklv*Math.pow((1+dklv),xdkqs))/(Math.pow((1+dklv),xdkqs)-1);
                jslx=yhk*s_yhkqs-yhdkys-byhk-xyhk*xdkqs;
                xdkjssj=Math.floor((parseInt(tqhkDate.getFullYear())*12+parseInt(tqhkDate.getMonth()+1)+xdkqs-2)/12)+"年"+((parseInt(tqhkDate.getFullYear())*12+parseInt(tqhkDate.getMonth()+1)+xdkqs-2)%12+1)+"月";
            }else{
                xyhk=(dkzys-yhbjs-tqhkys)*(dklv*Math.pow((1+dklv),(s_yhkqs-yhdkqs)))/(Math.pow((1+dklv),(s_yhkqs-yhdkqs))-1);
                jslx=yhk*s_yhkqs-yhdkys-byhk-xyhk*(s_yhkqs-yhdkqs);
                xdkjssj=yhkjssj;
            }
        }
    }

    if($("tqhkfs_0").checked || remark!=""){
        byhk=(dkzys-yhbjs)*(1+dklv);
        xyhk=0;
        jslx=yhk*s_yhkqs-yhdkys-byhk;
        xdkjssj=tqhkDate.getFullYear()+"年"+(tqhkDate.getMonth()+1)+"月";
    }

    $("ykhke").value=Math.round(yhk*100)/100;
    $("yhkze").value=Math.round(yhdkys*100)/100;
    $("yhlxe").value=Math.round(yhlxs*100)/100;
    $("gyyihke").value=Math.round(byhk*100)/100;
    $("xyqyhke").value=Math.round(xyhk*100)/100;
    $("jslxzc").value=Math.round(jslx*100)/100;
    $("yzhhkq").value=yhkjssj;
    $("xdzhhkq").value=xdkjssj;
    $("jsjgts").value=remark;
}

function chgnum(sum){
    return Math.round(sum*100)/100;
}
</script>
<script language="JavaScript">
lilv_array=new Array;          
//2004年之前的旧利率
lilv_array[1]=new Array;
lilv_array[1][1]=new Array;
lilv_array[1][2]=new Array;
lilv_array[1][1][5]=0.0477;//商贷 1～5年 4.77%
lilv_array[1][1][10]=0.0504;//商贷 5-30年 5.04%
lilv_array[1][2][5]=0.0360;//公积金 1～5年 3.60%
lilv_array[1][2][10]=0.0405;//公积金 5-30年 4.05%

//2005年	1月的新利率
lilv_array[2]=new Array;
lilv_array[2][1]=new Array;
lilv_array[2][2]=new Array;
lilv_array[2][1][5]=0.0495;//商贷 1～5年 4.95%
lilv_array[2][1][10]=0.0531;//商贷 5-30年 5.31%
lilv_array[2][2][5]=0.0378;//公积金 1～5年 3.78%
lilv_array[2][2][10]=0.0423;//公积金 5-30年 4.23%

//2006年	1月的新利率下限
lilv_array[3]=new Array;
lilv_array[3][1]=new Array;
lilv_array[3][2]=new Array;
lilv_array[3][1][5]=0.0527;//商贷 1～5年 5.27%
lilv_array[3][1][10]=0.0551;//商贷 5-30年 5.51%
lilv_array[3][2][5]=0.0396;//公积金 1～5年 3.96%
lilv_array[3][2][10]=0.0441;//公积金 5-30年 4.41%
			
//2006年	1月的新利率上限
lilv_array[4]=new Array;
lilv_array[4][1]=new Array;
lilv_array[4][2]=new Array;
lilv_array[4][1][5]=0.0527;//商贷 1～5年 5.27%
lilv_array[4][1][10]=0.0612;//商贷 5-30年 6.12%
lilv_array[4][2][5]= 0.0396;//公积金 1～5年 3.96%
lilv_array[4][2][10]=0.0441;//公积金 5-30年 4.41%

//2006年	4月28日的新利率下限
lilv_array[5]=new Array;
lilv_array[5][1]=new Array;
lilv_array[5][2]=new Array;
lilv_array[5][1][5]=0.0551;//商贷 1～5年 5.51%
lilv_array[5][1][10]=0.0575;//商贷 5-30年 5.75%
lilv_array[5][2][5]= 0.0414;//公积金 1～5年 4.14%
lilv_array[5][2][10]=0.0459;//公积金 5-30年 4.59%

//2006年	4月28日的新利率上限
lilv_array[6]=new Array;
lilv_array[6][1]=new Array;
lilv_array[6][2]=new Array;
lilv_array[6][1][5]=0.0612;//商贷 1～5年 6.12%
lilv_array[6][1][10]=0.0639;//商贷 5-30年 6.39%
lilv_array[6][2][5]= 0.0414;//公积金 1～5年 4.14%
lilv_array[6][2][10]=0.0459;//公积金 5-30年 4.59%

//2006年	8月19日的新利率下限
lilv_array[7]=new Array;
lilv_array[7][1]=new Array;
lilv_array[7][2]=new Array;
lilv_array[7][1][5]=0.0551;//商贷 1～5年 5.51%
lilv_array[7][1][10]=0.0581;//商贷 5-30年 5.81%
lilv_array[7][2][5]= 0.0414;//公积金 1～5年 4.14%
lilv_array[7][2][10]=0.0459;//公积金 5-30年 4.59%

//2006年	8月19日的新利率上限
lilv_array[8]=new Array;
lilv_array[8][1]=new Array;
lilv_array[8][2]=new Array;
lilv_array[8][1][5]=0.0648;//商贷 1～5年 6.48%
lilv_array[8][1][10]=0.0684;//商贷 5-30年 6.84%
lilv_array[8][2][5]= 0.0414;//公积金 1～5年 4.14%
lilv_array[8][2][10]=0.0459;//公积金 5-30年 4.59%


//2007年	3月18日的新利率下限
lilv_array[9]=new Array;
lilv_array[9][1]=new Array;
lilv_array[9][2]=new Array;
lilv_array[9][1][5]=0.0574;//商贷 1～5年 5.74%
lilv_array[9][1][10]=0.0604;//商贷 5-30年 6.04%
lilv_array[9][2][5]=0.0432;//公积金 1～5年 4.32%
lilv_array[9][2][10]=0.0477;//公积金 5-30年 4.77%

//2007年	3月18日的新利率上限
lilv_array[10]=new Array;
lilv_array[10][1]=new Array;
lilv_array[10][2]=new Array;
lilv_array[10][1][5]=0.0675;//商贷 1～5年 6.75%
lilv_array[10][1][10]=0.0711;//商贷 5-30年 7.11%
lilv_array[10][2][5]=0.0432;//公积金 1～5年 4.32%
lilv_array[10][2][10]=0.0477;//公积金 5-30年 4.77%


//2007年	5月19日的新利率下限
lilv_array[11]=new Array;
lilv_array[11][1]=new Array;
lilv_array[11][2]=new Array;
lilv_array[11][1][5]=0.0589;//商贷 1～5年 5.89%
lilv_array[11][1][10]=0.0612;//商贷 5-30年 6.12%
lilv_array[11][2][5]=0.0441;//公积金 1～5年 4.41%%
lilv_array[11][2][10]=0.0486;//公积金 5-30年 4.86%%

//2007年	5月19日的新利率上限
lilv_array[12]=new Array;
lilv_array[12][1]=new Array;
lilv_array[12][2]=new Array;
lilv_array[12][1][5]=0.0693;//商贷 1～5年 6.93%
lilv_array[12][1][10]=0.0720;//商贷 5-30年 7.20%
lilv_array[12][2][5]=0.0441;//公积金 1～5年 4.41%%
lilv_array[12][2][10]=0.0486;//公积金 5-30年 4.86%%

//2007年	7月21日的新利率下限
lilv_array[13]=new Array;
lilv_array[13][1]=new Array;
lilv_array[13][2]=new Array;
lilv_array[13][1][5]=0.0612;//商贷 1～5年 6.12%
lilv_array[13][1][10]=0.06273;//商贷 5-30年 6.273%
lilv_array[13][2][5]=0.0450;//公积金 1～5年 4.50%%
lilv_array[13][2][10]=0.0495;//公积金 5-30年 4.95%%

//2007年	7月21日的新利率上限
lilv_array[14]=new Array;
lilv_array[14][1]=new Array;
lilv_array[14][2]=new Array;
lilv_array[14][1][5]=0.0720;//商贷 1～5年 7.20%
lilv_array[14][1][10]=0.0738;//商贷 5-30年 7.38%
lilv_array[14][2][5]=0.0450;//公积金 1～5年 4.50%%
lilv_array[14][2][10]=0.0495;//公积金 5-30年 4.95%%

//2007年	8月22日的新利率下限
lilv_array[15]=new Array;
lilv_array[15][1]=new Array;
lilv_array[15][2]=new Array;
lilv_array[15][1][5]=0.06273;//商贷 1～5年 6.273%
lilv_array[15][1][10]=0.06426;//商贷 5-30年 6.426%
lilv_array[15][2][5]=0.0459;//公积金 1～5年 4.59%
lilv_array[15][2][10]=0.0504;//公积金 5-30年 5.04%

//2007年	8月22日的新利率上限
lilv_array[16]=new Array;
lilv_array[16][1]=new Array;
lilv_array[16][2]=new Array;
lilv_array[16][1][5]=0.0738;//商贷 1～5年 7.38%
lilv_array[16][1][10]=0.0756;//商贷 5-30年 7.56%
lilv_array[16][2][5]=0.0459;//公积金 1～5年 4.59%
lilv_array[16][2][10]=0.0504;//公积金 5-30年 5.04%

//2007年	9月15日的新利率下限
lilv_array[17]=new Array;
lilv_array[17][1]=new Array;
lilv_array[17][2]=new Array;
lilv_array[17][1][5]=0.06503;//商贷 1～5年 6.503%
lilv_array[17][1][10]=0.06656;//商贷 5-30年 6.656%
lilv_array[17][2][5]=0.0477;//公积金 1～5年 4.77%
lilv_array[17][2][10]=0.0522;//公积金 5-30年 5.22%

//2007年	9月15日的新利率上限
lilv_array[18]=new Array;
lilv_array[18][1]=new Array;
lilv_array[18][2]=new Array;
lilv_array[18][1][5]=0.0765;//商贷 1～5年 7.65%
lilv_array[18][1][10]=0.0783;//商贷 5-30年 7.83%
lilv_array[18][2][5]=0.0477;//公积金 1～5年 4.77%
lilv_array[18][2][10]=0.0522;//公积金 5-30年 5.22%

//2007年	9月15日新利率(第二套房)
lilv_array[19]=new Array;
lilv_array[19][1]=new Array;
lilv_array[19][2]=new Array;
lilv_array[19][1][5]=0.08415;//商贷 1～5年 8.415%
lilv_array[19][1][10]=0.08613;//商贷 5-30年 8.613%
lilv_array[19][2][5]=0.0477;//公积金 1～5年 4.77%
lilv_array[19][2][10]=0.0522;//公积金 5-30年 5.22%

//2007年	12月21日的新利率下限
lilv_array[20]=new Array;
lilv_array[20][1]=new Array;
lilv_array[20][2]=new Array;
lilv_array[20][1][5]=0.06579;//商贷 1～5年 6.579%
lilv_array[20][1][10]=0.06656;//商贷 5-30年 6.656%
lilv_array[20][2][5]=0.0477;//公积金 1～5年 4.77%
lilv_array[20][2][10]=0.0522;//公积金 5-30年 5.22%

//2007年	12月21日的新利率上限
lilv_array[21]=new Array;
lilv_array[21][1]=new Array;
lilv_array[21][2]=new Array;
lilv_array[21][1][5]=0.0774;//商贷 1～5年 7.74%
lilv_array[21][1][10]=0.0783;//商贷 5-30年 7.83%
lilv_array[21][2][5]=0.0477;//公积金 1～5年 4.77%
lilv_array[21][2][10]=0.0522;//公积金 5-30年 5.22%

//2007年	12月21日新利率(第二套房)
lilv_array[22]=new Array;
lilv_array[22][1]=new Array;
lilv_array[22][2]=new Array;
lilv_array[22][1][5]=0.08514;//商贷 1～5年 8.514%
lilv_array[22][1][10]=0.08613;//商贷 5-30年 8.613%
lilv_array[22][2][5]=0.0477;//公积金 1～5年 4.77%
lilv_array[22][2][10]=0.0522;//公积金 5-30年 5.22%

//2008年	9月16日的新利率下限
lilv_array[23]=new Array;
lilv_array[23][1]=new Array;
lilv_array[23][2]=new Array;
lilv_array[23][1][5]=0.06426;//商贷 1～5年 6.426%
lilv_array[23][1][10]=0.06579;//商贷 5-30年 6.579%
lilv_array[23][2][5]=0.0459;//公积金 1～5年 4.59%
lilv_array[23][2][10]=0.0513;//公积金 5-30年 5.13%

//2008年	9月16日的新利率上限
lilv_array[24]=new Array;
lilv_array[24][1]=new Array;
lilv_array[24][2]=new Array;
lilv_array[24][1][5]=0.0756;//商贷 1～5年 7.56%
lilv_array[24][1][10]=0.0774;//商贷 5-30年 7.74%
lilv_array[24][2][5]=0.0459;//公积金 1～5年 4.59%
lilv_array[24][2][10]=0.0513;//公积金 5-30年 5.13%

//2008年	9月16日新利率(第二套房)
lilv_array[25]=new Array;
lilv_array[25][1]=new Array;
lilv_array[25][2]=new Array;
lilv_array[25][1][5]=0.08316;//商贷 1～5年 8.316%
lilv_array[25][1][10]=0.08514;//商贷 5-30年 8.514%
lilv_array[25][2][5]=0.0459;//公积金 1～5年 4.59%
lilv_array[25][2][10]=0.0513;//公积金 5-30年 5.13%

//2008年	10月9日的新利率下限
lilv_array[26]=new Array;
lilv_array[26][1]=new Array;
lilv_array[26][2]=new Array;
lilv_array[26][1][5]=0.061965;//商贷 1～5年 6.1965%
lilv_array[26][1][10]=0.063495;//商贷 5-30年 6.3495%
lilv_array[26][2][5]=0.0432;//公积金 1～5年 4.32%
lilv_array[26][2][10]=0.0486;//公积金 5-30年 4.86%

//2008年	10月9日的新利率上限
lilv_array[27]=new Array;
lilv_array[27][1]=new Array;
lilv_array[27][2]=new Array;
lilv_array[27][1][5]=0.0729;//商贷 1～5年 7.29%
lilv_array[27][1][10]=0.0747;//商贷 5-30年 7.47%
lilv_array[27][2][5]=0.0432;//公积金 1～5年 4.32%
lilv_array[27][2][10]=0.0486;//公积金 5-30年 4.86%

//2008年	10月9日新利率(第二套房)
lilv_array[28]=new Array;
lilv_array[28][1]=new Array;
lilv_array[28][2]=new Array;
lilv_array[28][1][5]=0.08019;//商贷 1～5年 8.019%
lilv_array[28][1][10]=0.08217;//商贷 5-30年 8.217%
lilv_array[28][2][5]=0.0432;//公积金 1～5年 4.32%
lilv_array[28][2][10]=0.0486;//公积金 5-30年 4.86%

//2008年	10月30日的新利率下限
lilv_array[29]=new Array;
lilv_array[29][1]=new Array;
lilv_array[29][2]=new Array;
lilv_array[29][1][5]=0.04914;//商贷 1～5年 4.914%
lilv_array[29][1][10]=0.0504;//商贷 5-30年 5.04%
lilv_array[29][2][5]=0.0405;//公积金 1～5年 4.05%
lilv_array[29][2][10]=0.0459;//公积金 5-30年 4.59%

//2008年	10月30日的新利率上限
lilv_array[30]=new Array;
lilv_array[30][1]=new Array;
lilv_array[30][2]=new Array;
lilv_array[30][1][5]=0.0702;//商贷 1～5年 7.02%
lilv_array[30][1][10]=0.072;//商贷 5-30年 7.20%
lilv_array[30][2][5]=0.0405;//公积金 1～5年 4.05%
lilv_array[30][2][10]=0.0459;//公积金 5-30年 4.59%

//2008年	11月27日的新利率下限
lilv_array[31]=new Array;
lilv_array[31][1]=new Array;
lilv_array[31][2]=new Array;
lilv_array[31][1][5]=0.04158;//商贷 1～5年 4.158%
lilv_array[31][1][10]=0.04284;//商贷 5-30年 4.284%
lilv_array[31][2][5]=0.0351;//公积金 1～5年 3.51%
lilv_array[31][2][10]=0.0405;//公积金 5-30年 4.05%

//2008年	11月27日的新利率上限
lilv_array[32]=new Array;
lilv_array[32][1]=new Array;
lilv_array[32][2]=new Array;
lilv_array[32][1][5]=0.0594;//商贷 1～5年 5.94%
lilv_array[32][1][10]=0.0612;//商贷 5-30年 6.12%
lilv_array[32][2][5]=0.0351;//公积金 1～5年 3.51%
lilv_array[32][2][10]=0.0405;//公积金 5-30年 4.05%

//得到利率
function getlilv(lilv_class,type,years){
	var lilv_class = parseInt(lilv_class);
    if (years<=5){
		 return lilv_array[lilv_class][type][5];
	}else{
		return lilv_array[lilv_class][type][10];
	}
}

</script>
<BODY LEFTMARGIN="0" TOPMARGIN="0">
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCFF" style="border-collapse:collapse;" >
  <tr> 
    <td height="23" background="${base}/static/images/titlebg.gif"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td><img src="${base}/static/images/titlearrow.gif" width="8" height="13"> <span class="title">提前还款计算器</span></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td> <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="25" class="explain">提前还贷计算器可以帮您计算提前还贷节省的利息支出</td>
        </tr>
      </table>
      <TABLE width=95% align="center" cellSpacing=0>
        <TBODY>
          <TR> 
            <TD height="21" align=left class="head">计算公式</TD>
          </TR>
          <TR> 
            <TD height="1" background="${base}/static/images/dline.gif"></TD>
          </TR>
          <TR> 
            <TD><TABLE cellSpacing=0 
            cellPadding=0 width=651 border=0>
                <TBODY>
                  <TR> 
                    <TD  width=156 height="25" class=zhengwen>贷款金额(元):</TD>
                    <TD width=495 height="25" class="zhengwen"> <INPUT class="inputBox" id="dkzws" type="text" name="dkzws" style="width:30px;">
                      万元 </TD>
                  </TR>
                  <TR> 
                    <TD height="25" class="zhengwen" >原贷款期限:</TD>
                    <TD height="25" > <select name="yhkqs" id="yhkqs" style="font-size:12px;">
                        <option value="24">2年(24期)</option>
                        <option value="36">3年(36期)</option>
                        <option value="48">4年(48期)</option>
                        <option value="60">5年(60期)</option>
                        <option value="72">6年(72期)</option>
                        <option value="84">7年(84期)</option>
                        <option value="96">8年(96期)</option>
                        <option value="108">9年(108期)</option>
                        <option value="120">10年(120期)</option>
                        <option value="132">11年(132期)</option>
                        <option value="144">12年(144期)</option>
                        <option value="156">13年(156期)</option>
                        <option value="168">14年(168期)</option>
                        <option value="180" selected>15年(180期)</option>
                        <option value="240">20年(240期)</option>
                        <option value="300">25年(300期)</option>
                        <option value="360">30年(360期)</option>
                      </select></TD>
                  </TR>
                  <TR> 
                    <TD 
                  width=156 height="25" class=zhengwen>利率:</TD>
                    <TD width=495 height="25" class="zhengwen">
					<select name="dklv_class" id="dklv_class">
                        		<option value='32' selected="selected">08年11月27日利率上限</option>
														<option value='31'>08年11月27日利率下限</option>
														<option value='30'>08年10月30日利率上限</option>
														<option value='29'>08年10月30日利率下限</option>
														<option value='28'>08年10月9日第二套房</option>
														<option value='27'>08年10月9日利率上限</option>
														<option value='26'>08年10月9日利率下限</option>
														<option value='25'>08年9月16日第二套房</option>
														<option value='24'>08年9月16日利率上限</option>
														<option value='23'>08年9月16日利率下限</option>
			                			<option value="22">07年12月21日第二套房</option>
                            <option value="21">07年12月21日利率上限</option>
                            <option value="20">07年12月21日利率下限</option>
                            <option value="19">07年9月15日第二套房</option>
                            <option value="18">07年9月15日利率上限</option>
                            <option value="17">07年9月15日利率下限</option>
                            <option value="16">07年8月22日利率上限</option>
                            <option value="15">07年8月22日利率下限</option>

                            <option value="14">07年7月21日利率上限</option>
                            <option value="13">07年7月21日利率下限</option>
                            <option value="12">07年5月19日利率上限</option>
                            <option value="11">07年5月19日利率下限</option>
                            <option value="10">07年3月18日利率上限</option>
                            <option value="9">07年3月18日利率下限</option>
                            <option value="8">06年8月19日利率上限</option>
                            <option value="7">06年8月19日利率下限</option>
                            <option value="6">06年4月28日利率上限</option>

                            <option value="5">06年4月28日利率下限</option>
                            <option value="4">05年3月17日后利率上限</option>
                            <option value="3">05年3月17日后利率下限</option>
                            <option value="2">05年1月1日-3月17日利率</option>
                            <option value="1">05年1月1日前利率</option>
                        </select>
					</TD>
                  </TR>
                  <TR> 
                    <TD height=25 class="zhengwen">第一次还款时间:</TD>
                    <TD height=25 class="zhengwen"><input type="text" name="dychksj" id="dychksj" onblur="ChkCZDate(this)" value="2001-1-1" class="inputBox" style="width: 75px" /> 
                      <IMG src="${base}/static/images/calbtn.gif" width="18" height="18" align="absMiddle" style="CURSOR:pointer;" onclick="MyCalendar.SetDate(this,$('dychksj'))"> 
                    </TD>
                  </TR>
                  <TR> 
                    <TD height=25 class="zhengwen">预计提前还款时间:</TD>
                    <TD height=25><input type="text" name="yjtqhksj" id="yjtqhksj" onblur="ChkCZDate(this)" value="2001-1-1" class="inputBox" style="width: 75px" /> 
                      <IMG src="${base}/static/images/calbtn.gif" width="18" height="18" align="absMiddle" style="CURSOR:pointer;" onclick="MyCalendar.SetDate(this,$('yjtqhksj'))"></TD>
                  </TR>
                  <TR>
                    <TD height=25 class="zhengwen">贷款类型:</TD>
                    <TD height=25 class="zhengwen">
<input type="radio" name="dklx" id="dklx_0" value="0" checked />公积金贷款<input type="radio" name="dklx" id="dklx_1" value="1" />商业性贷款</TD>
                  </TR>
                  <TR> 
                    <TD height=25 class="zhengwen">还款方式:</TD>
                    <TD height=25 class="zhengwen">
<input type="radio" name="tqhkfs" id="tqhkfs_0" value="0" checked />一次提前还清<input type="radio" name="tqhkfs" id="tqhkfs_1" value="1" />部分提前还款</label>　<input name="tqhkws" id="tqhkws" size="6" style="width:30px;" class="inputBox"> 万元(不含当月应还款额)</TD>
                  </TR>
                  <TR> 
                    <TD height=25 class="zhengwen">处理方式:</TD>
                    <TD height=25 class="zhengwen">
<input type="radio" name="clfs" id="clfs_0" value="0" checked />缩短还款年限，月还款额基本不变<input type="radio" name="clfs" id="clfs_1" value="1" />减少月还款额，还款期不变</TD>
                  </TR>
                  <TR> 
                    <TD height=25>&nbsp; </TD>
                    <TD height=25><img id=btnCalc
                  style="CURSOR: hand" onClick="checkCalc();" tabindex=7 
                  height=19 src="${base}/static/images/calbt.gif" 
                  width=47 name=btnCalc ></TD>
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
            <TD ><TABLE width="51%" height="225"  border="0" cellpadding="0" cellspacing="0" >
                <TBODY>
                  <TR > 
                    <TD height="25" align=left class=zhengwen >原月还款额(元):</TD>
                    <TD height="25" align=left class=zhengwen ><INPUT id="ykhke" name="ykhke" value="计算得出" type="text" class="inputBox" style="width:112px; " disabled /></TD>
                  </TR>
                  <TR > 
                    <TD height="25" align=left class=zhengwen >原最后还款期:</TD>
                    <TD height="25" align=left class=zhengwen > <INPUT id="yzhhkq" name="yzhhkq" value="计算得出" type="text" class="inputBox" style="width:112px; " disabled /></TD>
                  </TR>
                  <TR > 
                    <TD height="25" align=left class=zhengwen >已还款总额(元):</TD>
                    <TD height="25" align=left class=zhengwen ><INPUT id="yhkze" name="yhkze" value="计算得出" type="text" class="inputBox" style="width:112px; " disabled /></TD>
                  </TR>
                  <TR > 
                    <TD height="25" align=left class=zhengwen >已还利息额(元):</TD>
                    <TD height="25" align=left class=zhengwen ><INPUT id="yhlxe" name="yhlxe" value="计算得出" type="text" class="inputBox" style="width:112px; " disabled /></TD>
                  </TR>
                  <TR > 
                    <TD height="25" align=left class=zhengwen >该月一次还款额(元):</TD>
                    <TD height="25" align=left class=zhengwen ><INPUT id="gyyihke" name="gyyihke" value="计算得出" type="text" class="inputBox" style="width:112px; " disabled /></TD>
                  </TR>
                  <TR > 
                    <TD height="25" align=left class=zhengwen >下月起月还款额(元):</TD>
                    <TD height="25" align=left class=zhengwen > <INPUT id="xyqyhke" name="xyqyhke" value="计算得出" type="text" class="inputBox" style="width:112px; " disabled /></TD>
                  </TR>
                  <TR > 
                    <TD height="25" align=left class=zhengwen >节省利息支出(元):</TD>
                    <TD height="25" align=left class=zhengwen ><INPUT id="jslxzc" name="jslxzc" value="计算得出" type="text" class="inputBox" style="width:112px; " disabled /></TD>
                  </TR>
                  <TR > 
                    <TD height="25" align=left class=zhengwen >新的最后还款期:</TD>
                    <TD height="25" align=left class=zhengwen ><INPUT id="xdzhhkq" name="xdzhhkq" value="计算得出" type="text" class="inputBox" style="width:112px; " disabled /></TD>
                  </TR>
                  <TR >
                    <TD height="25" align=left class=zhengwen >计算结果提示:</TD>
                    <TD height="25" align=left class=zhengwen ><INPUT id="jsjgts" name="jsjgts" value="计算得出" type="text" class="inputBox" style="width:212px; " disabled /></TD>
                  </TR>
                </TBODY>
              </TABLE></TD>
          </TR>
          <TR> 
            <TD height="25" align=left class="head">说明</TD>
          </TR>
          <TR> 
            <TD height="1" background="${base}/static/images/dline.gif"></TD>
          </TR>
          <TR> 
              
            <TD valign="top" class="zhengwen">&nbsp;</TD>
          </TR>
        </TBODY>
      </TABLE>
	</td>
  </tr>
</table>
<script language="javascript">
$("dychksj").value=datetostring(new Date());
$("yjtqhksj").value=datetostring(new Date());
</script>
</body>
<#include "/template/foot.ftl"/>