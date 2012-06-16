<script>
<#if result.score??>
obj=document.getElementById("${Parameters['type']}Score");
if(typeof obj=="undefined")obj.value=${result.score};
</#if>
</script>