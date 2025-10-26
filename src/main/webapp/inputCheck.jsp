<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head><title>操作结果</title></head>
<body>
<%
    // 1. 设置编码并获取参数
    request.setCharacterEncoding("UTF-8");
    String id = request.getParameter("id");
    String name = request.getParameter("name");
    String gender = request.getParameter("gender");
    String ageStr = request.getParameter("age");
    String weightStr = request.getParameter("weight");

    // 2. 健壮性校验
    if (id == null || id.trim().isEmpty()) {
        out.println("<h2>错误：学号不能为空！</h2>");
        out.println("<a href='input.jsp'>返回重试</a>");
        return; // 停止执行
    }

    int age = 0;
    float weight = 0.0f;
    try {
        age = Integer.parseInt(ageStr);
        weight = Float.parseFloat(weightStr);
    } catch (NumberFormatException e) {
        out.println("<h2>错误：年龄和体重必须是数字！</h2>");
        out.println("<a href='input.jsp'>返回重试</a>");
        return;
    }


    Connection conn = null;
    PreparedStatement pstmt = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        // 3. 连接数据库
        Class.forName("com.mysql.cj.jdbc.Driver");
        // (!!! 关键：修改为你自己的密码 !!!)
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test9?useUnicode=true&characterEncoding=UTF-8", "root", "123456");

        // 4. 操作1：插入 (INSERT)
        String sqlInsert = "INSERT INTO stuinfo (id, name, gender, age, weight) VALUES (?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sqlInsert);
        pstmt.setString(1, id);
        pstmt.setString(2, name);
        pstmt.setString(3, gender);
        pstmt.setInt(4, age);
        pstmt.setFloat(5, weight);
        pstmt.executeUpdate();
        out.println("<h3>已插入学生信息：" + name + "</h3>");
        pstmt.close(); // 每次操作后及时关闭 PreparedStatement

        // 5. 操作2：修改 (UPDATE) - 修改刚插入的学生年龄
        String sqlUpdate = "UPDATE stuinfo SET age = age + 1 WHERE id = ?";
        pstmt = conn.prepareStatement(sqlUpdate);
        pstmt.setString(1, id);
        pstmt.executeUpdate();
        out.println("<h3>已更改学生信息（年龄+1）：" + name + "</h3>");
        pstmt.close();

        // 6. 操作3：删除 (DELETE) - 删除年龄大于100的 (按实验任务要求)
        String sqlDelete = "DELETE FROM stuinfo WHERE age > 100";
        pstmt = conn.prepareStatement(sqlDelete);
        int deleteCount = pstmt.executeUpdate();
        out.println("<h3>已删除 " + deleteCount + " 条年龄大于100的学生信息</h3>");
        pstmt.close();

        // 7. 操作4：查询 (SELECT) - 显示所有
        out.println("<h2>当前所有学生信息：</h2>");
        stmt = conn.createStatement();
        rs = stmt.executeQuery("SELECT * FROM stuinfo");

%>
<table border="1" cellpadding="5" cellspacing="0" style="border-collapse: collapse;">
    <tr style="background-color: #f2f2f2;">
        <th>学号</th>
        <th>姓名</th>
        <th>性别</th>
        <th>年龄</th>
        <th>体重</th>
    </tr>
    <%
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
    %>
</table>
<p><a href="index.jsp">返回首页</a></p>
<%
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h3>操作失败: " + e.getMessage() + "</h3>");
    } finally {
        // 8. 关闭所有资源
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
</body>
</html>
