# JSP 学生信息管理系统

这是《JSP程序设计技术》课程的实验4项目，一个基础的学生信息管理系统。

项目使用 JSP 脚本 (Scriptlet) 和 JDBC 直接连接 MySQL 数据库，实现了对学生信息的增、删、改、查 (CRUD) 操作。

## 技术栈

* **后端**: JSP, JDBC(本人jdk为21)
* **数据库**: MySQL 8.x
* **构建工具**: Maven
* **服务器**: Apache Tomcat11

## 如何运行

1.  **克隆项目**
    ```bash
    git clone https://github.com/yamleric/jsp_work3_test.git
    ```

2.  **创建数据库**
    * 确保你的 MySQL 8.x 服务正在运行。
    * 在 MySQL 中执行项目根目录下的 `db_setup.sql` 脚本 (你需要自己创建一个 `db_setup.sql` 文件，把步骤一的SQL代码放进去)。
    * **SQL脚本如下:**
        ```sql
        CREATE DATABASE IF NOT EXISTS test9 DEFAULT CHARACTER SET utf8mb4;
        USE test9;
        CREATE TABLE IF NOT EXISTS stuinfo (
          id VARCHAR(20) PRIMARY KEY,
          name VARCHAR(50) NOT NULL,
          gender VARCHAR(10),
          age INT,
          weight DECIMAL(5, 2)
        );
        ```

3.  **修改数据库密码 (重要！)**
    * 打开 `src/main/webapp/index.jsp` 文件。
    * 打开 `src/main/webapp/inputCheck.jsp` 文件。
    * 在
      这两个文件中，找到 `your_password` 字符串，并将其**修改为你自己的 MySQL 数据库密码**。

4.  **在 IntelliJ IDEA 中运行**
    * 使用 IntelliJ IDEA 旗舰版打开项目 (选择 `pom.xml` 文件打开)。
    * 等待 Maven 自动下载所有依赖。
    * 配置 Tomcat 服务器 (参见 IDEA 的 "Add Configuration..." 菜单)。
    * 在 "Deployment" 选项卡中，添加 "exploded" war 包，并设置 "Application context" (例如 `/`)。
    * 点击 "Run" 启动服务器。
    * 在浏览器中访问 `http://localhost:8080/`。


