
<#include "../../experiment/metadata.ftl"/>
<#assign type>${Parameters['type']}</#assign>
<#if answer??><#assign result=answer/></#if>
<#if result??&&result.remark??>
<table width="100%" align="center">
<tr><td><B>${nameMap[type]}的说明：</B></td></tr>
<tr><td>${(result.remark)?if_exists}</td></tr>
</table>
<table width="100%" border="0" class="listTable" align="center">
<tr class="darkColumn" align="center"> 
    <td height="18" colspan="2">主要财务指标</td>
  </tr>
        <tr>
          <td class="darkColumn" align="center" width="50%">资产负债比率=总负债/总资产</td>
          <td><div align="center">${(liabilityRatio?string.percent)!}</div></td>
        </tr>
        <tr>
          <td class="darkColumn" align="center">流动比率=流动性资产/流动负债</td>
          <td><div align="center">${(currentRatio?string.percent)!}</div></td>
        </tr>
        <tr> 
          <td class="darkColumn" align="center">储蓄比例=每月的盈余/税后收入</td>
          <td><div align="center">${(saveRatio?string.percent)!}</div></td>
        </tr>       
         <tr> 
          <td class="darkColumn" align="center">流动资产比率=流动资产/总资产</td>
          <td><div align="center">${(currentAssetRatio?string.percent)!}</div></td>
        </tr>
        <tr> 
          <td class="darkColumn" align="center">财务自由度=年理财收入/年支出</td>
          <td><div align="center">${(financialFreeDegree?string.percent)!}</div></td>
        </tr>
        <tr> 
          <td class="darkColumn" align="center">平均投资报酬率=年理财收入/生息资产</td>
          <td><div align="center">${(returnRatio?string.percent)!}</div></td>
        </tr> 
        <tr> 
          <td class="darkColumn" align="center">自由储蓄率=自由储蓄额/总资产</td>
          <td><div align="center">${(savedRatio?string.percent)!}</div></td>
        </tr>        
</table>
<#else>
未做该部分
</#if>