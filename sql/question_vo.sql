INSERT INTO `question_vo` (`id`, `question_user_id`, `title`, `question`, `pay_score`, `createtime`, `deleted`, `useful_answer_id`, `ack_answer_time`, `username`, `pic`) VALUES ('2250B44ACB434814A8B971B76E67DF44', 13, '这两个if else是一样的吗?', '<pre><code class=\"prettyprint\">if(表达式1)\n{\n    ....;\n}\nelse\n{\n    if(表达式2)\n    { \n      ....;\n    }\n    else\n    {\n      ....;\n    }\n}\n----------\nif(表达式1)\n{\n    ....;\n}\nelse if(表达式2)\n      {\n         ....;\n      }\n      else\n      {\n        ....;\n      }</code></pre>', 3, '2018-5-14 21:18:53', 0, NULL, NULL, 'sliver', '/ITbbs_web\\\\upload/img/5FA\\\\1526300696378369.jpg');
INSERT INTO `question_vo` (`id`, `question_user_id`, `title`, `question`, `pay_score`, `createtime`, `deleted`, `useful_answer_id`, `ack_answer_time`, `username`, `pic`) VALUES ('88A10677A6F1444DB1456EF4587C8DC7', 13, '关于SQLdistinct和order by的问题', '<div class=\"questions_detail_con\"><dl><dd><p>想实现以下功能<a href=\"http://img-ask.csdn.net/upload/201805/14/1526298924_197850.png\" target=\"_blank\"><img src=\"http://img-ask.csdn.net/upload/201805/14/1526298924_197850.png\" alt=\"将数据进行去重、排列、映射、wm_concat、和替换逗号\"></a></p><p>目前SQL如下<br>create table test0514<br>(<br>name varchar2(500),<br>score varchar2(500)<br>)</p><p>insert into test0514 values(\'张三\');<br>insert into test0514 values(\'张三\');<br>insert into test0514 values(\'张三\');<br>insert into test0514 values(\'张三\');<br>insert into test0514 values(\'李四\');<br>insert into test0514 values(\'王五\');<br>insert into test0514 values(\'赵六\');<br>insert into test0514 values(\'戴七\');<br>insert into test0514 values(\'鬼八\');</p><p>select replace(wm_concat(distinct decode(name,\'张三\',\'钢铁侠\',\'李四\',\'美国队长\',\'王五\',\'绿巨人\',\'赵六\',\'蜘蛛侠\',\'戴七\',\'黑寡妇\',\'鬼八\',\'猩红女巫\',\'老十\',\'sb\')),\',\',\'+\') from test0514 order by rownum</p><p>无法实现排序功能，请教各位大神如何实现！！在线等！！！</p></dd></dl></div><div class=\"share_bar_con share_bar_con_01\" id=\"question_689057\"></div>', 3, '2018-5-14 21:11:49', 0, NULL, NULL, 'sliver', '/ITbbs_web\\\\upload/img/5FA\\\\1526300696378369.jpg');
INSERT INTO `question_vo` (`id`, `question_user_id`, `title`, `question`, `pay_score`, `createtime`, `deleted`, `useful_answer_id`, `ack_answer_time`, `username`, `pic`) VALUES ('A23E6EDD5DA245E78B51834262018807', 13, 'cs', 'cs', 3, '2018-5-19 08:28:53', 1, NULL, NULL, 'sliver', '/ITbbs_web\\\\upload/img/5FA\\\\1526300696378369.jpg');
INSERT INTO `question_vo` (`id`, `question_user_id`, `title`, `question`, `pay_score`, `createtime`, `deleted`, `useful_answer_id`, `ack_answer_time`, `username`, `pic`) VALUES ('AB844C17B2DE4E39951954BB79AA39E3', 13, 'java异常', 'javac常见异常有哪些', 3, '2018-5-8 14:50:55', 0, NULL, NULL, 'sliver', '/ITbbs_web\\\\upload/img/5FA\\\\1526300696378369.jpg');
INSERT INTO `question_vo` (`id`, `question_user_id`, `title`, `question`, `pay_score`, `createtime`, `deleted`, `useful_answer_id`, `ack_answer_time`, `username`, `pic`) VALUES ('C9C0DFF8348E4BB2B7D209660EE9C0B1', 13, '如何从jsp页面向mysql按条件更新数据', '<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"288\" class=\"layui-table\"><tbody><tr height=\"66\">\n  <td height=\"66\" class=\"xl65\" width=\"288\">代码如下<br>\n    <br>\n    &nbsp;&lt;% <br>\n    &nbsp;&nbsp;&nbsp; String ID = new\n  String(request.getParameter(\"dId\").getBytes(\"ISO8859_1\"),\"UTF-8\");<br>\n    &nbsp;&nbsp;&nbsp; String AIS = new\n  String(request.getParameter(\"AIS\").getBytes(\"ISO8859_1\"),\"UTF-8\");<br>\n    &nbsp;&nbsp;&nbsp; try{<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n  Class.forName(\"com.mysql.jdbc.Driver\");<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; String url =\n  \"XXXXXXXXX\";<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; String username =\n  \"XXXXXXX\";<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; String password =\n  \"XXXXXXX\";<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection conn =\n  DriverManager.getConnection(url,username,password);<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; String isExist =\n  \"select * from newshipinfo where newshipinfo.AIS =\n  \'\"+AIS+\"\'\";<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PreparedStatement\n  pstmt = conn.prepareStatement(isExist);<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ResultSet rs =\n  pstmt.executeQuery();<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(rs.next()){<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n  out.print(\"该数据已存在,请不要重复添加!\");<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }else{&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; String sql =\n  \"insert into newshipinfo(AIS) values (?) where ID =\n  \'\"+ID+\"\'\";<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PreparedStatement ps\n  = conn.prepareStatement(sql);<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ps.setString(1,AIS);<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int row =\n  ps.executeUpdate();<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(row &gt;0){<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; out.print(\"数据添加成功\");<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ps.close();<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conn.close();<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>\n    &nbsp;&nbsp;&nbsp; }catch(Exception e){<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n  out.print(\"数据添加失败!\");<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; e.printStackTrace();<br>\n    &nbsp;&nbsp;&nbsp; }<br>\n    %&gt;<br>\n   \n  这个页面的目的是将前一个页面所提交的数据（ID号与AIS的值）填写到数据库里进行数据更新，数据库里AIS的初始值均为0，现在把页面的值传进去变成1或者2。传之前会判断数据库里AIS的值是不是1或者2，若是则提示不要重复输入。<br>\n    现在值可以传到这个页面没有问题，就是无法传入数据库，老是报这个错<br>\n    <br>\n    &nbsp;You have an error in your SQL\n  syntax; check the manual that corresponds to your MySQL server version for\n  the right syntax to use near \'where ID = \'12259\'\' at line 1<br>\n    是sql语句的错误吗，想请教下怎么修改代码。</td></tr></tbody></table>', 3, '2018-5-19 11:21:48', 0, NULL, NULL, 'sliver', '/ITbbs_web\\\\upload/img/5FA\\\\1526300696378369.jpg');
