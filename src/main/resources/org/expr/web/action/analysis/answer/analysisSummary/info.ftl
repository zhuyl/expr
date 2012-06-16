<#include "/template/head.ftl"/>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckeditor.js"></script>
<script language="javascript" type="text/javascript" src="${base}/scripts/fckeditor/fckTextArea.js"></script>
<body>
<table width="85%" border="0" class="listTable" align="center">
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
<table width="85%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td>
    <textarea id="remark" readOnly name="analysisSummaryAnswer.remark"  style="font-size:10pt;width:100%;height:200px">${answer.remark!}</textarea>
    </td>
  </tr>
</table>
</body>
<#include "/template/foot.ftl"/>