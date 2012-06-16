<script>
<#if (result.score)??>
obj=document.getElementById("${Parameters['type']}Score");
if((typeof obj)!="undefined"){notifyScore('${Parameters['type']}',${(result.score)!});}
</#if>
</script>