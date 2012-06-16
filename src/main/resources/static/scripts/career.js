	// 缺省值
    var defaultValues=new Object();
    // 页面上所有的三级级联选择
    var selects= new Array();
    // 当前操作影响的选择
    var mySelects=new Array();
    // 当前的三级级联选择
    var career3Select=null;
    
    function addTitle(selectId){
       var options=document.getElementById(selectId).options;
       for(var i=0;i< options.length;i++){
         options[i].title=options[i].innerHTML;
       }
    }
    // 初始化部门初始化
    function initCategory1Select(departs){
        if(!document.getElementById(this.category1Id))return;
        defaultValues[this.category1Id]=document.getElementById(this.category1Id).value;
        dwr.util.removeAllOptions(this.category1Id);
	    dwr.util.addOptions(this.category1Id,departs,'id','name');	    
        if(this.category1Nullable)
           dwr.util.addOptions(this.category1Id,[{'id':'','name':'...'}],'id','name');
        setSelected(document.getElementById(this.category1Id),defaultValues[this.category1Id]);
        //document.getElementById(this.category1Id).style.width="100px";
	    document.getElementById(this.category1Id).onchange =function (event){
	        notifyCategory2Change(event);
	        notifyCategory3Change(event);
	       }
    }
    // 初始化专业选择框
    function initCategory2Select(){
       if(!document.getElementById(this.category2Id))return;
       defaultValues[this.category2Id]=document.getElementById(this.category2Id).value;
       dwr.util.removeAllOptions(this.category2Id);
       document.getElementById(this.category2Id).onchange=notifyCategory3Change;
       
       var d = document.getElementById(this.category1Id); 

       if(this.category2Nullable)
           dwr.util.addOptions(this.category2Id,[{'id':'','name':'...'}],'id','name');
       if(d.value!=""){
            career3Select=this;
       		careerDwrService.getChildren(d.value,setCategory2Options);       
       }
       //document.getElementById(this.category2Id).style.width="100px";
       //setSelected(document.getElementById(this.category2Id),defaultValues[this.category2Id]);
    }
    // 初始化专业方向选择框
    function initCategory3Select(){
       if(!document.getElementById(this.category3Id))return;
       defaultValues[this.category3Id]=document.getElementById(this.category3Id).value;
       dwr.util.removeAllOptions(this.category3Id);
       var s= document.getElementById(this.category2Id);
        if(this.category3Nullable)
           dwr.util.addOptions(this.category3Id,[{'id':'','name':'...'}],'id','name');
       if(s.value!=""){
           career3Select=this;
           careerDwrService.getChildren(s.value,setCategory3Options);
        }
        //document.getElementById(this.category3Id).style.width="100px"
       //setSelected(document.getElementById(this.category3Id),defaultValues[this.category3Id]);
    }
    // 通知专业变化,填充专业选择列表
    function notifyCategory2Change(event){
       var target=  getEventTarget(event);
       //alert("event in notifyCategory2Change");
       mySelects= getMySelects(target.id);
       //if(mySelects.length>1)
       //   dwr.engine.setAsync(false);
       for(var i=0;i<mySelects.length;i++){
	       var d = document.getElementById(mySelects[i].category1Id);
	       if(null==d) continue;
	       dwr.util.removeAllOptions(mySelects[i].category2Id);
	       if(mySelects[i].category2Nullable){
	           dwr.util.addOptions(mySelects[i].category2Id,[{'id':'','name':'...'}],'id','name');
	           setSelected(document.getElementById(mySelects[i].category2Id),"");
	       }
	       //if(s.value!=""&&d.value!=""){
	       if(d.value!=""){
	           career3Select =mySelects[i];
		       careerDwrService.getChildren(d.value,setCategory2Options);
	       }
	       // 过上半秒钟再去查找专业方向，以防专业查找还没有完成
	       //setTimeout(notifyCategory3Change,"500");
       }
      // dwr.engine.setAsync(true);
    }
    // 通知专业方向变化，填充专业方向列表
    function notifyCategory3Change(event){
       var target=  getEventTarget(event);
       //alert("event in notifyCategory3Change");
       mySelects= getMySelects(target.id);
       for(var i=0;i<mySelects.length;i++){
           //alert("removeAllOptions of :"+mySelects[i].category3Id);
	       if(null==mySelects[i].category3Id){
	           continue;
	       }
	       dwr.util.removeAllOptions(mySelects[i].category3Id);
	       if(mySelects[i].category3Nullable)
	           dwr.util.addOptions(mySelects[i].category3Id,[{'id':'','name':'...'}],'id','name');
	       var s= document.getElementById(mySelects[i].category2Id);
	       if(s.value!=""){
	          career3Select=mySelects[i];
	          //alert(career3Select.category3Id)
	          careerDwrService.getChildren(s.value,setCategory3Options);       
	       }
       }
    }
    function setCategory2Options(data){
       for(var i=0;i<data.length;i++){
       	 	dwr.util.addOptions(career3Select.category2Id,[{'id':data[i][0],'name':data[i][1]}],'id','name');
       }
       if(defaultValues[career3Select.category2Id]!=null){
           setSelected(document.getElementById(career3Select.category2Id),defaultValues[career3Select.category2Id]);
       }
       addTitle(career3Select.category2Id);
       //alert(document.getElementById(career3Select.category2Id).outerHTML)
    }
    function setCategory3Options(data){
       for(var i=0;i<data.length;i++)
          dwr.util.addOptions(career3Select.category3Id,[{'id':data[i][0],'name':data[i][1]}],'id','name');       
       if(defaultValues[career3Select.category3Id]!=null){           
           setSelected(document.getElementById(career3Select.category3Id),defaultValues[career3Select.category3Id]);
       }
       addTitle(career3Select.category3Id);
    }
    /**
     *  三级级联选择的模型
     *@param category1Id 大类下拉框id
     *@param category2Id 中类下拉框id
     *@param category3Id 小类下拉框id
     *@param category1Nullable 大类是否允许为空
     *@param category2Nullable 中类是否允许为空
     *@param category3Nullable 小类是否允许为空
     */
    function CareerSelect(category1Id,category2Id,category3Id,category1Nullable,category2Nullable,category3Nullable){
     // alert(category1Id+":"+category2Id+":"+category3Id);
      this.category1Id=category1Id;
      this.category2Id=category2Id;
      this.category3Id=category3Id;
      this.category1Nullable=category1Nullable;
      this.category2Nullable=category2Nullable;
      this.category3Nullable=category3Nullable;
      this.initCategory1Select=initCategory1Select;
      this.initCategory2Select=initCategory2Select;
      this.initCategory3Select=initCategory3Select;
      this.init=init;
      selects[selects.length]=this;
    }
    function initCategory23Select(){
      career3Select.initCategory3Select();
    }
    function init(departs){
       this.initCategory1Select(departs);
       this.initCategory2Select();
       career3Select=this;
       // 留上100毫秒等待专业初试化完毕
       setTimeout(initCategory23Select,"200");
    }
    function getMySelects(id){
        var mySelects = new Array();
        for(var i=0;i<selects.length;i++){
            if(selects[i].category1Id==id||
               selects[i].category2Id==id||
               selects[i].category3Id==id)
               mySelects[mySelects.length]=selects[i];
        }
        return mySelects;
    }
