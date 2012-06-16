<#include "/template/head.ftl"/>
 <body>
    <#assign labInfo><@text name="案例信息"/></#assign> 
	<#include "/template/back.ftl"/>
   <table width="90%" align="center" class="infoTable">
    <@searchParams/>
    <tr>
      <td width="20%" id="f_code" class="title"><font color="red">*</font>案例编号:</td>
      <td width="30%">${caze.seq?if_exists}</td>
      <td width="20%" id="f_name" class="title"><font color="red">*</font>案例名称:</td>
      <td width="30%">${caze.name?if_exists}</td>
    </tr>
    <tr>  
      <td id="f_author" class="title"><font color="red">*</font>案例作者:</td>
      <td>${caze.author?if_exists}</td>
      <td id="f_lifeCycleType" class="title"><font color="red">*</font>客户生命周期类型:</td>
      <td>${caze.lifeCycleType.name?if_exists}</td>
    </tr>
    <tr>
      <td class="title">案例内容:</td>
      <td colspan="4">${caze.content?if_exists}</td>
     </tr>
     <tr>
      <td class="title">社会经济状态:</td>
      <td colspan="4">${caze.socialState?if_exists}</td>
     </tr>
     <tr>
      <td class="title">动态平衡约束条件:</td>
      <td colspan="4">${caze.dynaEquilibrium?if_exists}</td>
     </tr>
     <tr>
      <td class="title"><font color="red">*</font>动态平衡调整年度:</td>
      <td colspan="4">第${caze.changeYear?if_exists}年</td>
     </tr>
     <tr>
       <td class="title">客户风险承受态度:</td>
       <td colspan="4">${(caze.riskBearAttitude?if_exists).name?if_exists}</td>     
     </tr>
     <tr>
       <td class="title">客户风险承受能力问卷:</td>
       <td colspan="4">${((caze.questionnaire?if_exists).name)?if_exists}</td>
     </tr>
      <tr>
       <td class="title">是否向学生公开:</td>
       <td>${caze.open?string('是 ','否')}</td>
       <td class="title">是否发布:</td>
       <td>${caze.publish?string('是 ','否')}</td>       
     </tr>   
    <tr>
      <td class="title">  <@text name="attr.dateCreated" />: </td>
      <td>${(caze.createdAt?string("yyyy-MM-dd"))?if_exists}</td>    
      <td class="title">  <@text name="attr.dateLastModified" />:</td>
      <td>${(caze.updatedAt?string("yyyy-MM-dd"))?if_exists}</td>
    </tr>
    </form> 
  </table>
  </body>
<#include "/template/foot.ftl"/>
