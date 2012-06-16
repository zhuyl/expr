

var textAreaId;
var widthPx;
var heightPx;
var editorStyle;

function initFCK(fckTextAreaId, fckWidth, fckHeight, fckStyle)  {
	textAreaId = fckTextAreaId == "" || null == fckTextAreaId ? "areaTextId" : fckTextAreaId;
	widthPx = fckWidth== "" || null == fckWidth ? "700px" : fckWidth;
	heightPx = fckHeight == "" || null == fckHeight ? "300px" : fckHeight;
	editorStyle = fckStyle == "" || null == fckStyle ? "Default" : fckStyle;
	window.onload = function() {
	 	var oEditor = new FCKeditor(textAreaId, widthPx, heightPx) ;
	 	oEditor.BasePath = getRootPath()+'/scripts/fckeditor/';
	 	oEditor.ToolbarSet = editorStyle;
	 	oEditor.ReplaceTextarea() ;
	}
}

function initFCK2(fckTextAreaId,fckTextAreaId2, fckWidth, fckHeight, fckStyle)  {
	textAreaId = fckTextAreaId == "" || null == fckTextAreaId ? "areaTextId" : fckTextAreaId;
	textAreaId2 = fckTextAreaId2 == "" || null == fckTextAreaId2 ? "areaTextId2" : fckTextAreaId2;
	widthPx = fckWidth== "" || null == fckWidth ? "700px" : fckWidth;
	heightPx = fckHeight == "" || null == fckHeight ? "300px" : fckHeight;
	editorStyle = fckStyle == "" || null == fckStyle ? "Default" : fckStyle;
	window.onload = function() {
	 	var oEditor = new FCKeditor(textAreaId, widthPx, heightPx) ;
	 	oEditor.BasePath = getRootPath()+'/scripts/fckeditor/';
	 	oEditor.ToolbarSet = editorStyle;
	 	oEditor.ReplaceTextarea() ;
	 	var oEditor2 = new FCKeditor(textAreaId2, widthPx, heightPx) ;
	 	oEditor2.BasePath = getRootPath()+'/scripts/fckeditor/';
	 	oEditor2.ToolbarSet = editorStyle;
	 	oEditor2.ReplaceTextarea() ;
	}
}


function changeTextarea(fckTextAreaId, fckWidth, fckHeight, fckStyle)  {
	textAreaId = fckTextAreaId == "" || null == fckTextAreaId ? "areaTextId" : fckTextAreaId;
	widthPx = fckWidth== "" || null == fckWidth ? "700px" : fckWidth;
	heightPx = fckHeight == "" || null == fckHeight ? "300px" : fckHeight;
	editorStyle = fckStyle == "" || null == fckStyle ? "Default" : fckStyle;
	 	var oEditor = new FCKeditor(textAreaId, widthPx, heightPx) ;
	 	oEditor.BasePath = getRootPath()+'/scripts/fckeditor/';
	 	oEditor.ToolbarSet = editorStyle;
	 	oEditor.ReplaceTextarea() ;
}

function copyIt(){
 	var oEditor = FCKeditorAPI.GetInstance(textAreaId);
 	oEditor.UpdateLinkedField();
 	window.clipboardData.setData("Text", document.getElementById(textAreaId).innerHTML);
}

function getRootPath(){

var strFullPath=window.document.location.href;

var strPath=window.document.location.pathname;

var pos=strFullPath.indexOf(strPath);

var prePath=strFullPath.substring(0,pos);

var postPath=strPath.substring(0,strPath.substr(1).indexOf('/')+1);

return(prePath+postPath);

} 
