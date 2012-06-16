<table align="center" width="90%" border="0" cellspacing="0" cellpadding="0" class='listTable'>
  <tr align='center' class='darkColumn'>
    <td>学号</td>
    <td>姓名</td>
  </tr>
  <#list lesson.students as std>
  <tr align='center'>
    <td>${std.code}</td>
    <td>${std.name}</td>
  </tr>
  </#list>
</table>