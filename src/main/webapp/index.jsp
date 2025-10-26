<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head><title>学生信息列表</title></head>
<body>
<h2>学生信息管理系统</h2>
<table border="1" cellpadding="5" cellspacing="0" style="border-collapse: collapse;">
    <tr style="background-color: #f2f2f2;">
        <th>学号</th>
        <th>姓名</th>
        <th>性别</th>
        <th>年龄</th>
        <th>体重</th>
    </tr>
    <%
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            // 1. 加载驱动
            Class.forName("com.mysql.cj.jdbc.Driver");
            // 2. 建立连接 (!!! 关键：修改为你自己的密码 !!!)
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test9?useUnicode=true&characterEncoding=UTF-8", "root", "123456");
            // 3. 创建语句
            stmt = conn.createStatement();
            // 4. 执行SQL
            rs = stmt.executeQuery("SELECT id, name, gender, age, weight FROM stuinfo");
            // 5. 处理结果
            while (rs.next()) {
    %>
    <tr>
        <td><%= rs.getString("id") %></td>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getString("gender") %></td>
        <td><%= rs.getInt("age") %></td>
        <td><%= rs.getFloat("weight") %></td>
    </tr>
    <%
            } // while 循环结束
        } catch (Exception e) {
            e.printStackTrace();
            out.println("数据库查询出错：" + e.getMessage());
        } finally {
            // 6. 关闭资源
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    %>
</table>
<p><a href="input.jsp">添加新学生</a></p>
</body>
</html>