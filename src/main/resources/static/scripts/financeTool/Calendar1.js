/*------------------------------------------------------------------------
  日期控件
  function Cal_dropdown(edit,min,max)
    弹出日历，可不给参数min和max，参数edit如无，则查找日期图片的第一个兄弟edit。

  function Cal_datevalid(edit,min,max)
    检查edit中值是否为大于等于min，小于等于max的有效日期格式字符串。
    是则返回 true，否则返回false
    可不给参数min和max(字符串格式)
    参数edit必须有，如果edit无，则必须是：edit为edit和img的父亲(如span、div)的第一个元素
  
  最新修改 文兵 2002-12-25 适用于IE 5.0以上浏览器
*/

var Cal_popup;
var Cal_edit;
var Cal_editdate = new Date();
var Cal_maxdate;
var Cal_mindate;

function Cal_clearTime(thedate)
{
  thedate.setHours(0);
  thedate.setMinutes(0);
  thedate.setSeconds(0);
  thedate.setMilliseconds(0);
}

var Cal_today = new Date();
Cal_clearTime(Cal_today);

function Cal_decDay(thedate,days)
{
  if(days==0); 
  else if (!days) days = 1;

  thedate.setTime(thedate - days*24*60*60*1000);
}

function Cal_incMonth(year,month)
{
  if (month == 11) {
    month = 0;
    year++;
  } else month++;
  Cal_writeHTML(year,month);
}

function Cal_decMonth(year,month)
{
  if (month == 0) {
    month = 11;
    year--;
  } else month--;
  Cal_writeHTML(year,month);
}

function Cal_decYear(year,month)
{
  Cal_writeHTML(year-1,month);
}

function Cal_incYear(year,month)
{
  Cal_writeHTML(year+1,month);
}

function Cal_writeHTML(theyear,themonth)
{
  var html=
	'<TABLE style=background-color:#BBE4F5; border-left: 1px solid #D6D6D6;border-top: 1px solid #D6D6D6;'+
	'cellSpacing="0" cellPadding="5"  border="0" width=100% bgcolor=#f1f1f1>'+
	'<TR style="background-color:#BBE4F5;BORDER-RIGHT: #c9c9c9 1px solid; BORDER-TOP: #ffffff 1px solid; BORDER-LEFT: #ffffff 1px solid; COLOR: #545454; BORDER-BOTTOM: #c9c9c9 1px solid;"><TD style="cursor:hand;color:#B94F00;background-color:#BBE4F5" align="center" height=20 width=26 onmouseover="this.style.color=' +
    "'#FF0000';" + '"' + ' onmouseout="this.style.color=' + "'#B94F00';" + '"' +
    ' onclick="Cal_decYear(' + theyear + ',' + themonth + ');" '+
    '><年</TD>'+
	'<TD style="cursor:hand;color:#B94F00;background-color:#BBE4F5" align="left" width=26 onmouseover="this.style.color=' +
    "'#FF0000';" + '"' + ' onmouseout="this.style.color=' + "'#B94F00';" + '"' +
    ' onclick="Cal_decMonth(' + theyear + ',' + themonth + ');" '+
    '><月</TD>'+
	'<TD align="center" colspan="3" width=78 style="color:#B94F00;background-color:#BBE4F5" >';
	
  html += theyear + '年' + (themonth + 1) + '月</TD>'+
    '<TD style="cursor:hand;color:#B94F00;background-color:#BBE4F5" align="right" width=26 onmouseover="this.style.color=' +
    "'#FF0000';" + '"' + ' onmouseout="this.style.color=' + "'#B94F00';" + '"' +
    ' onclick="Cal_incMonth(' + theyear + ',' + themonth + ');" '+
    '>月></TD>'+
    '<TD style="cursor:hand;color:#B94F00;background-color:#BBE4F5" align="right" width=26 onmouseover="this.style.color=' +
    "'#FF0000';" + '"' + ' onmouseout="this.style.color=' + "'#B94F00';" + '"' +
    ' onclick="Cal_incYear(' + theyear + ',' + themonth + ');" '+
    '>年></TD>';
    
  html +=
	'</TR></TABLE>'+
	'<TABLE style="font-weight:bold;text-align:center;   COLOR: #545454;  BACKGROUND-COLOR: #f1f1f1" '+
	'cellSpacing="0" cellPadding="0" width="100%">'+
	'<TR><TD style="color:#545454;BORDER-RIGHT: #c9c9c9 1px solid; BORDER-TOP: #ffffff 1px solid; BORDER-LEFT: #ffffff 1px solid; COLOR: #545454; BORDER-BOTTOM: #c9c9c9 1px solid; BACKGROUND-COLOR: #e3e3e3" width=26>日</TD><TD  width=26 style="color:#545454;BORDER-RIGHT: #c9c9c9 1px solid; BORDER-TOP: #ffffff 1px solid; BORDER-LEFT: #ffffff 1px solid; COLOR: #545454; BORDER-BOTTOM: #c9c9c9 1px solid; BACKGROUND-COLOR: #e3e3e3">一</TD><TD width=26 style="color:#545454;BORDER-RIGHT: #c9c9c9 1px solid; BORDER-TOP: #ffffff 1px solid; BORDER-LEFT: #ffffff 1px solid; COLOR: #545454; BORDER-BOTTOM: #c9c9c9 1px solid; BACKGROUND-COLOR: #e3e3e3">二</TD><TD width=26 style="color:#545454;BORDER-RIGHT: #c9c9c9 1px solid; BORDER-TOP: #ffffff 1px solid; BORDER-LEFT: #ffffff 1px solid; COLOR: #545454; BORDER-BOTTOM: #c9c9c9 1px solid; BACKGROUND-COLOR: #e3e3e3">三</TD><TD width=26  style="color:#545454;BORDER-RIGHT: #c9c9c9 1px solid; BORDER-TOP: #ffffff 1px solid; BORDER-LEFT: #ffffff 1px solid; COLOR: #545454; BORDER-BOTTOM: #c9c9c9 1px solid; BACKGROUND-COLOR: #e3e3e3">四</TD><TD width=26 style="color:#545454;BORDER-RIGHT: #c9c9c9 1px solid; BORDER-TOP: #ffffff 1px solid; BORDER-LEFT: #ffffff 1px solid; COLOR: #545454; BORDER-BOTTOM: #c9c9c9 1px solid; BACKGROUND-COLOR: #e3e3e3">五</TD><TD  width=26 style="color:#545454b;BORDER-RIGHT: #c9c9c9 1px solid; BORDER-TOP: #ffffff 1px solid; BORDER-LEFT: #ffffff 1px solid; COLOR: #545454; BORDER-BOTTOM: #c9c9c9 1px solid; BACKGROUND-COLOR: #e3e3e3">六</TD>'+
	'</TR></table>'+
	'<TABLE style="FONT-SIZE: 9pt;text-align:center;cursor:hand;background-color: #f1f1f1" cellSpacing="0" '+
	'cellPadding="0" width="100%">';

  var day1 = new Date(theyear,themonth,1);
  Cal_decDay(day1,day1.getDay()); // 日历开始日
  for (var i=1;i<=6;i++) {
    html += '<TR>';
    for (var j=1;j<=7;j++) {
      html += '<TD';
      if (day1.getTime()==Cal_today.getTime())
        html += ' style="color:#ff0000;BORDER-RIGHT: #c9c9c9 1px solid; BORDER-TOP: #ffffff 1px solid; BORDER-LEFT: #ffffff 1px solid; COLOR: #545454; BORDER-BOTTOM: #c9c9c9 1px solid; BACKGROUND-COLOR: #f1f1f1"';
      else
      if (day1.getTime()==Cal_editdate.getTime())
        html += ' style="color:#545454;BORDER-RIGHT: #c9c9c9 1px solid; BORDER-TOP: #ffffff 1px solid; BORDER-LEFT: #ffffff 1px solid; COLOR: #545454; BORDER-BOTTOM: #c9c9c9 1px solid; BACKGROUND-COLOR: #f1f1f1"';
      else
      if (day1.getMonth() != themonth)
        html +=  ' style="color:#545454;BORDER-RIGHT: #c9c9c9 1px solid; BORDER-TOP: #ffffff 1px solid; BORDER-LEFT: #ffffff 1px solid; COLOR: #545454; BORDER-BOTTOM: #c9c9c9 1px solid; BACKGROUND-COLOR: #f1f1f1"';
      html += ' onmouseover="this.style.background=' +
              "'#BBE4F5';" + '"'+
              ' onmouseout="this.style.background=' +
              "'#f1f1f1';" + '"';
      html += ' onclick="Cal_clickday('+day1.getTime() + ');"';
      html +=' style="color:#545454;BORDER-RIGHT: #c9c9c9 1px solid; BORDER-TOP: #ffffff 1px solid; BORDER-LEFT: #ffffff 1px solid; COLOR: #545454; BORDER-BOTTOM: #c9c9c9 1px solid; BACKGROUND-COLOR: #f1f1f1">' + day1.getDate() + '</TD>';
      Cal_decDay(day1,-1);
    }
    html += '</TR>';
    if (day1.getMonth() != themonth) break;
  }
	
  html +=
	'</TABLE>'+
	'<div style="border-top:#f1f1f1 1px solid;text-align:right;padding:2px;color:#545454">今天是 '+
	'<span style="color:#ff0000;cursor:hand;text-decoration:underline" onclick="javascript:Cal_clickday('+
	Cal_today.getTime() + ');">'+
	Cal_today.getFullYear() + '-' + (Cal_today.getMonth()+1) + '-' + Cal_today.getDate() +
	'</span></div>';

  if (!Cal_popup) {
    Cal_popup = document.createElement(
      '<div id="Cal_div1" style="z-index:20000;position: absolute;width:231px;FONT-SIZE:9pt;' +
      'BORDER-RIGHT: #c9c9c9 1px solid; BORDER-TOP: #ffffff 1px solid; BORDER-LEFT: #ffffff 1px solid; COLOR: #545454; BORDER-BOTTOM: #c9c9c9 1px solid; BACKGROUND-COLOR: #f1f1f1" '+
      'hidefocus=true onclick="Cal_capture_click()" ondblclick="this.click()" '+
      'onmouseover="Cal_capture_mover()" onmouseout="Cal_capture_mout()">');
    document.body.insertAdjacentElement('beforeEnd',Cal_popup);
  }
  Cal_popup.innerHTML = html;
}

function Cal_hide()
{
  Cal_popup.releaseCapture();
  Cal_popup.style.display="none";
}


function Cal_capture_click()
{
  var obj=event.srcElement;
  if (Cal_popup.contains(obj)) {
    if ( (obj!=Cal_popup) && obj.onclick) obj.onclick();
  } else {
    Cal_hide();
  }
}

function Cal_capture_mover()
{
  var obj=event.srcElement;
  if (Cal_popup.contains(obj)) {
    if ( (obj!=Cal_popup) && obj.onmouseover) obj.onmouseover();
  }
}

function Cal_capture_mout()
{
  var obj=event.srcElement;
  if (Cal_popup.contains(obj)) {
    if ( (obj!=Cal_popup) && obj.onmouseout) obj.onmouseout();
  }
}

// 字符串转换为日期 
function Cal_strtodate(str)
{
  var date = Date.parse(str);
  if (isNaN(date)) {
    date = Date.parse(str.replace(/-/g,"/")); // 识别日期格式：YYYY-MM-DD 
    if (isNaN(date)) date = 0;
  }
  return(date);
}

//返回日期间相差的天数
function Cal_DateDiff(Date1, Date2)
{
	return (Date2-Date1)/(24*60*60*1000);
}

//返回日期间相差的月数(最大误差小于一个月)
function Cal_MonthDiff(DateA, DateB)
{
	Date1=new Date();
	Date2=new Date();
	Date1.setTime(DateA);
	Date2.setTime(DateB);
	months = (Date2.getFullYear() - Date1.getFullYear()) * 12;
	addmonths = Date2.getMonth() - Date1.getMonth();
	months = months + addmonths;
	if(Date2.getDate() < Date1.getDate())
		months--;
	return months;
}

// 弹出日历，可不给参数min和max，参数edit必须有 
function Cal_dropdown(edit,min,max) {
  var DateIMG = window.event.srcElement;
  if (!edit) {
    edit = DateIMG.parentElement.children(0);
    if ((!edit.type) || (edit.type.toLowerCase() != "text")) return;
  }
  if(edit.readOnly) return;
  Cal_edit = edit;
  var date = Cal_strtodate(edit.value);
  if (date == 0) date = Cal_today.getTime();
  if (max) Cal_maxdate = Cal_strtodate(max);
  else Cal_maxdate=0;
  if (min) Cal_mindate = Cal_strtodate(min);
  //else Cal_mindate = 0;  // modified by huhao, 2003/4/30: 大部分调用都没有给min和max参数。而Date(0)是1970年1月1日。max = 0时认为是无限制，不用改。
  else Cal_mindate = new Date(1900, 1, 1);		
  Cal_editdate.setTime(date);
  Cal_writeHTML(Cal_editdate.getFullYear(),Cal_editdate.getMonth());

  // 定位
  var pos =
    event.clientX - event.offsetX - DateIMG.offsetLeft
     + edit.offsetLeft - document.body.clientLeft + document.body.scrollLeft;
  var max =
    document.body.scrollLeft + document.body.getBoundingClientRect().right
    - Cal_popup.style.pixelWidth;
  // 如果下拉框宽度超出则往左移
  if (pos > max) Cal_popup.style.left = max;
  else Cal_popup.style.left =  pos;
  
  pos = 
    event.clientY - event.offsetY - DateIMG.offsetTop
    + edit.offsetTop + edit.offsetHeight - document.body.clientTop + document.body.scrollTop;
  // 如果下拉框高度超出则往上弹出
  if (pos > document.body.scrollTop + document.body.getBoundingClientRect().bottom - Cal_popup.clientHeight)
    pos -= document.body.clientTop + edit.offsetHeight + Cal_popup.clientHeight; 
  Cal_popup.style.top = pos;
  Cal_popup.style.display="";

  // 如果下拉框弹出后看不见（超出底部），则自动滚页
//  if (Cal_popup.offsetTop + Cal_popup.offsetHeight + document.body.clientTop>= 
//      document.body.offsetHeight + document.body.scrollTop)
//    document.body.doScroll("scrollbarPageDown");
  
  Cal_popup.setCapture();
}

// 点击日期 
function Cal_clickday(day,edit)
{
  if (Cal_maxdate != 0) day = Math.min(day,Cal_maxdate);
  day = Math.max(day,Cal_mindate);
  Cal_editdate.setTime(day);
  Cal_edit.value = Cal_editdate.getFullYear() + "-" + (Cal_editdate.getMonth()+1) + "-" 
                   + Cal_editdate.getDate();
  Cal_hide();
  Cal_edit.focus();
}

function Cal_datevalid(edit,min,max)
{
  // 检查edit中值是否为大于等于min，小于等于max的有效日期格式字符串。 
  
  var date = Cal_strtodate(edit.value);
  if (date == 0) return false;
  if (max) {
    var max = Cal_strtodate(max);
    if ((max!=0)&&(date>max)) return false;
  }
  if (min) {
    var min = Cal_strtodate(min);
    if ((min!=0)&&(date<min)) return false;
  }
  date = new Date(date);
  edit.value = date.getFullYear() + "-" + (date.getMonth()+1) +
			   "-" + date.getDate();
  return true;
}
