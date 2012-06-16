var InterestTax = 0.00; // 利息税

//活期储蓄计算器
function computefullsum(){ //计算出实得本息总额和存入总额
    if (savedatearray.length==0) {			   
	    var tmparray=new Array();
	    tmparray.push($("edSaveSum").value);
	    tmparray.push($("beginDateID").value);
	    tmparray.push($("endDateID").value);
	    tmparray.push($("edFullRate").value);
	    var obj=computeoncefullsum(tmparray);
	    $("edFullSum").value=Round(obj.oncefullsum);
	    $("edSaveTotal").value=Round(obj.oncesavesum);
    }else{
        var fullsumtotal=0;
        var savesumtotal=0;
        for (var i=0;i<savedatearray.length;i++){
		    var tmparray=new Array();
		    tmparray.push(savesumarray[i]);
		    tmparray.push(savedatearray[i]);
		    tmparray.push($("endDateID").value);
		    tmparray.push($("edFullRate").value);
		    var obj=computeoncefullsum(tmparray);
		    fullsumtotal+=obj.oncefullsum;
		    savesumtotal+=obj.oncesavesum;
	    }
        $("edFullSum").value=Round(fullsumtotal);
        $("edSaveTotal").value=Round(savesumtotal);
    }
}

function computeoutdate(){ //计算出提取日期
    var fullsumtotal=0;
    var savesumtotal=0;
    var lastsavedate="";
    if (savedatearray.length==0) {		
	    lastsavedate=$("beginDateID").value; ////最后存入日期等于本次存入日期, 字符串	  
	    var tmparray=new Array();
	    tmparray.push($("edSaveSum").value);
	    tmparray.push($("beginDateID").value);
	    tmparray.push(lastsavedate); 
	    tmparray.push($("edFullRate").value);
	    var obj=computeoncefullsum(tmparray);
	    fullsumtotal=(obj.oncefullsum);
	    savesumtotal=(obj.oncesavesum);
    } else {							
        for (var i=0;i<savedatearray.length;i++){
		    lastsavedate=getmaxsavedate(); //返回字符串
		    var tmparray=new Array();
		    tmparray.push(savesumarray[i]);
		    tmparray.push(savedatearray[i]);
		    tmparray.push(lastsavedate);
		    tmparray.push($("edFullRate").value);
		    var obj=computeoncefullsum(tmparray);
		    fullsumtotal+=obj.oncefullsum;
		    savesumtotal+=obj.oncesavesum;
	    }				    
    }
    if (fullsumtotal>=parseFloat($("edFullSum").value)) $("endDateID").value=lastsavedate;
    else{
	    var currfullsum=parseFloat($("edFullSum").value);
	    var currfullrate=parseFloat($("edFullRate").value)/100;
	    var gg=Math.ceil((currfullsum-fullsumtotal)/(fullsumtotal * (currfullrate/360) * (1 - InterestTax)));
	    var objlastsavedate=new Date();
	    objlastsavedate.setTime(Cal_strtodate(lastsavedate));
	    datevaild=addday(objlastsavedate,gg);
	    if (datevaild) $("endDateID").value=objlastsavedate.getFullYear()+"-"+(objlastsavedate.getMonth()+1)+"-"+objlastsavedate.getDate();
	    else{
		    DispMessage($("edSaveSum"),"计算出来的提取日期不符合实际情况");
		    return false;
	    }	
    }	
    $("edSaveTotal").value=Round(savesumtotal);
}

function computeoncefullsum(s){ //计算出一次实得本息和存入金额
	SaveInSum=parseInt(s[0]);
	var SaveDate=new Date();
	SaveDate.setTime(Cal_strtodate(s[1]));	
	var AdvDrawDate=new Date();
	AdvDrawDate.setTime(Cal_strtodate(s[2]));
	YearRate=parseFloat(s[3])/100;
	var diffday=getDiffDay(AdvDrawDate,SaveDate);
	var obj=new Object();
	obj.oncefullsum=SaveInSum * (YearRate/360) * diffday * (1 - InterestTax) + SaveInSum;
	obj.oncesavesum=SaveInSum;
	return obj;
}