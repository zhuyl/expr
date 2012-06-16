<#include "/template/head.ftl"/>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckeditor.js"></script>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckTextArea.js"></script>
<body>
  <table class="formTable" align="center" width="80%">
	<tr><td>综合理财规划说明:<br>
	${(answer.remark)!}
 	</td></tr>
</table>

  <@table.table id="memberTable" width="80%" align="center">
   
 <@table.thead>
   <@table.td text="年份"/>
   <@table.td text="工资收入"/>   
   <@table.td text="奖金收入"/>    
   <@table.td text="理财性收入"/> 
   <@table.td text="其他收入"/>   
   <@table.td text="消费支出"/>  
   <@table.td text="教育支出"/>       
   <@table.td text="保险支出"/>    
   <@table.td text="医疗支出"/>
   <@table.td text="旅游支出"/> 
   <@table.td text="还贷支出"/> 
   <@table.td text="投资支出"/> 
   <@table.td text="其他支出"/> 
   <@table.td text="总收入"/> 
   <@table.td text="总支出"/>
   <@table.td text="总结余"/> 
 </@>
     
   <#list 1..planYears as i>
   <#assign totalincome=0>
   <#assign totalexpense=0>
   <#assign total=0>
   <tr align="center">
   <td>第${i}年</td>
   <td>${cashes.get(i)!0}</td>
   <td>${bonuses.get(i)!0}</td>
   <td>${investincomes.get(i)!0}</td>
   <td>${incomes.get(i)!0}</td>
   <td>${consumes.get(i)!0}</td>
   <td>${educations.get(i)!0}</td>
   <td>${insurances.get(i)!0}</td>
   <td>${medicals.get(i)!0}</td>
   <td>${trips.get(i)!0}</td>
   <td>${deposits.get(i)!0}</td>
   <td>${investexpenses.get(i)!0}</td>
   <td>${expenses.get(i)!0}</td> 
   <#assign totalincome=(cashes.get(i)!0)+(bonuses.get(i)!0)+(investincomes.get(i)!0)+(incomes.get(i)!0)>
   <#assign totalexpense=(consumes.get(i)!0)+(educations.get(i)!0)+(insurances.get(i)!0)+(medicals.get(i)!0)+(trips.get(i)!0)+(deposits.get(i)!0)+(investexpenses.get(i)!0)+(expenses.get(i)!0)>
   <#assign total=totalincome-totalexpense>   
   <td>${totalincome}</td>
   <td>${totalexpense}</td>  
   <td>${total}</td>
   </tr>
   </#list>
 </@>
 
   <@table.table id="memberTable2" width="80%" align="center">
   
 <@table.thead>
   <@table.td text="年份"/>
   <@table.td text="金融资产"/>   
   <@table.td text="保险资产"/>    
   <@table.td text="房产"/> 
   <@table.td text="汽车"/>   
   <@table.td text="房屋贷款"/>  
   <@table.td text="汽车贷款"/>       
   <@table.td text="总资产"/>    
   <@table.td text="总负债"/>
   <@table.td text="净资产"/> 
 </@>
    <#list 1..planYears as i>
   <#assign totalcapital=0>
   <#assign totaldebt=0>
   <#assign neatcapital=0>
   <tr align="center">
   <td>第${i}年</td>
   <td>${capitals.get(i)!0}</td>
   <td>${coverages.get(i)!0}</td>
   <td>${estates.get(i)!0}</td>
   <td>${cars.get(i)!0}</td>
   <td>${housedeposits.get(i)!0}</td>
   <td>${cardeposits.get(i)!0}</td>
   <#assign totalcapital=(capitals.get(i)!0)+(coverages.get(i)!0)+(estates.get(i)!0)+(cars.get(i)!0)>
   <#assign totaldebt=(housedeposits.get(i)!0)+(cardeposits.get(i)!0)>
   <#assign neatcapital=totalcapital-totaldebt>   
   <td>${totalcapital}</td>
   <td>${totaldebt}</td>  
   <td>${neatcapital}</td>
   </tr>
   </#list>
  </@>
</body>
<#include "/template/foot.ftl"/>