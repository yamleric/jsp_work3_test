<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>添加新学生</title></head>
<body>
<h2>请输入学生信息</h2>
<form action="inputCheck.jsp" method="post">
    <p>学号: <input type="text" name="id"></p>
    <p>姓名: <input type="text" name="name"></p>
    <p>性别: <input type="text" name="gender"></p>
    <p>年龄: <input type="text" name="age"></p>
    <p>体重: <input type="text" name="weight"></p>
    <p><input type="submit" value="提交"></p>
</form>
</body>
</html>
