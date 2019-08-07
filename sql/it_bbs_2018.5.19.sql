/*
Navicat MySQL Data Transfer

Source Server         : Lin
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : it_bbs

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2018-05-19 21:47:24
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `answer`
-- ----------------------------
DROP TABLE IF EXISTS `answer`;
CREATE TABLE `answer` (
  `id` varchar(32) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `question_id` varchar(32) DEFAULT NULL,
  `content` varchar(4096) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_answer_question` (`question_id`),
  KEY `FK_user_answer` (`user_id`),
  CONSTRAINT `FK_answer_question` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`),
  CONSTRAINT `FK_user_answer` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of answer
-- ----------------------------
INSERT INTO `answer` VALUES ('1CEBCB5359CB4078B7930506A167D7E7', '14', 'AB844C17B2DE4E39951954BB79AA39E3', '数组越界、空指针等', '2018-05-18 18:37:26');
INSERT INTO `answer` VALUES ('1EBF1AFC12ED44259C31FEE2769CE941', '14', 'AB844C17B2DE4E39951954BB79AA39E3', '<p style=\"text-align: justify;\"><span>1、java.lang.NullPointerException(空指针异常)</span>&nbsp;<br></p><br>', '2018-05-08 15:02:40');
INSERT INTO `answer` VALUES ('5D6C2986B57748868632DF4DA88AB508', '14', 'AB844C17B2DE4E39951954BB79AA39E3', '<p style=\"text-align: justify;\"><br></p>', '2018-05-08 15:04:42');
INSERT INTO `answer` VALUES ('A2FD7E09A3D342C3B663D6F57E4D1E5B', '14', 'AB844C17B2DE4E39951954BB79AA39E3', '1', '2018-05-08 15:08:37');
INSERT INTO `answer` VALUES ('C4820C3AAADA422FAA18FCF7ED9EAF8A', '14', '88A10677A6F1444DB1456EF4587C8DC7', '<p><span>问题貌似没描述清楚吧，再描述下吧，这样没法解答</span></p>', '2018-05-14 21:12:58');
INSERT INTO `answer` VALUES ('E2ADF5CEA1584FD19F8346FAADBE7755', '14', 'AB844C17B2DE4E39951954BB79AA39E3', '<p style=\"text-align: justify;\"><span>1、java.lang.NullPointerException(空指针异常)</span>&nbsp;<br>　 调用了未经初始化的对象或者是不存在的对象</p><p style=\"text-align: justify;\">经常出现在创建图片，调用数组这些操作中，比如图片未经初始化，或者图片创建时的路径错误等等。对数组操作中出现空指针，&nbsp;<br>即把数组的初始化和数组元素的初始化混淆起来了。数组的初始化是对数组分配需要的空间，而初始化后的数组，其中的元素并没有实例化，&nbsp;<br>依然是空的，所以还需要对每个元素都进行初始化（如果要调用的话）。</p><hr><p style=\"text-align: justify;\"><span>2、 java.lang.ClassNotFoundException</span></p><p style=\"text-align: justify;\">指定的类不存在</p><p style=\"text-align: justify;\">这里主要考虑一下类的名称和路径是否正确即可，通常都是程序试图通过字符串来加载某个类时可能引发 异常</p><p style=\"text-align: justify;\">比如：调用Class.forName();</p><pre class=\"prettyprint\"><code class=\"has-numbering\">    或者调用ClassLoad的finaSystemClass();或者LoadClass();\n</code><ul class=\"pre-numbering\" style=\"text-align: right;\"><li>1</li><li>2</li></ul></pre><hr><p style=\"text-align: justify;\"><span>3、 java.lang.NumberFormatException</span></p><p style=\"text-align: justify;\">字符串转换为数字异常</p><p style=\"text-align: justify;\">当试图将一个String转换为指定的数字类型，而该字符串确不满足数字类型要求的格式时，抛出该异常.如现在讲字符型的数据“123456”转换为数值型数据时，是允许的。</p><p style=\"text-align: justify;\">但是如果字符型数据中包含了非数字型的字符，如123#56，此时转换为数值型时就会出现异常。系统就会捕捉到这个异常，并进行处理.</p><br>', '2018-05-08 15:01:27');

-- ----------------------------
-- Table structure for `apply_boarder`
-- ----------------------------
DROP TABLE IF EXISTS `apply_boarder`;
CREATE TABLE `apply_boarder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `username` varchar(55) COLLATE utf8mb4_unicode_ci NOT NULL,
  `board_id` int(11) NOT NULL,
  `board_name` varchar(55) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apply_reason` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deal` tinyint(1) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `deal_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_apply_boarder` (`user_id`),
  CONSTRAINT `FK_apply_boarder` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of apply_boarder
-- ----------------------------

-- ----------------------------
-- Table structure for `basic_set`
-- ----------------------------
DROP TABLE IF EXISTS `basic_set`;
CREATE TABLE `basic_set` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `set_name` varchar(255) NOT NULL,
  `set_value` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of basic_set
-- ----------------------------
INSERT INTO `basic_set` VALUES ('1', 'admin_mail', 'admin1@sliver.com');
INSERT INTO `basic_set` VALUES ('2', 'filter_string', '流氓|擦|我日|sb');

-- ----------------------------
-- Table structure for `board`
-- ----------------------------
DROP TABLE IF EXISTS `board`;
CREATE TABLE `board` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `board_name` varchar(32) NOT NULL,
  `introduce` varchar(1024) DEFAULT NULL,
  `pic` varchar(1024) DEFAULT NULL,
  `user_id` int(11) DEFAULT '-1',
  `createtime` datetime DEFAULT NULL,
  `altertime` datetime DEFAULT NULL,
  `order_num` int(11) DEFAULT '0',
  `username` varchar(32) DEFAULT NULL,
  `owner_time` datetime DEFAULT NULL COMMENT '成为版主的时间',
  `score` int(11) DEFAULT '10',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of board
-- ----------------------------
INSERT INTO `board` VALUES ('19', 'java', 'Java是一门面向对象编程语言，不仅吸收了C++语言的各种优点，还摒弃了C++里难以理解的多继承、指针等概念，因此Java语言具有功能强大和简单易用两个特征。Java语言作为静态面向对象编程语言的代表，极好地实现了面向对象理论，允许程序员以优雅的思维方式进行复杂的编程', '/ITbbs_web\\upload/img/F33\\1525761735457014.jpg', '-1', '2018-05-08 14:42:57', '2018-05-08 14:42:57', '5', '', '2018-05-08 14:42:57', '0');
INSERT INTO `board` VALUES ('20', 'python', 'Python [1]  （英国发音：/ˈpaɪθən/ 美国发音：/ˈpaɪθɑːn/）, 是一种面向对象的解释型计算机程序设计语言，由荷兰人Guido van Rossum于1989年发明，第一个公开发行版发行于1991年。', '/ITbbs_web\\upload/img/89C\\1525761791158611.jpg', '-1', '2018-05-08 14:45:25', '2018-05-08 14:45:25', '1', null, '2018-05-08 14:45:25', '0');
INSERT INTO `board` VALUES ('21', 'javascript', 'JavaScript一种直译式脚本语言，是一种动态类型、弱类型、基于原型的语言，内置支持类型。它的解释器被称为JavaScript引擎，为浏览器的一部分，广泛用于客户端的脚本语言，最早是在HTML（标准通用标记语言下的一个应用）网页上使用，用来给HTML网页增加动态功能。', '/ITbbs_web\\upload/img/537\\1525761960958426.jpg', '17', '2018-05-08 14:46:12', '2018-05-08 14:46:12', '3', 'board03', '2018-05-08 14:46:12', '50');
INSERT INTO `board` VALUES ('22', 'php', 'php是世界上最好的语言', '/ITbbs_web\\upload/img/82E\\1525761982382410.jpg', '16', '2018-05-08 14:46:40', '2018-05-08 14:46:40', '2', 'board02', '2018-05-08 14:46:40', '500');
INSERT INTO `board` VALUES ('23', 'c', 'C语言是一门通用计算机编程语言，应用广泛。C语言的设计目标是提供一种能以简易的方式编译、处理低级存储器、产生少量的机器码以及不需要任何运行环境支持便能运行的编程语言。', '/ITbbs_web\\upload/img/459\\1525762008713925.jpg', '15', '2018-05-08 14:47:12', '2018-05-08 14:47:12', '4', 'board01', '2018-05-08 14:47:12', '20');

-- ----------------------------
-- Table structure for `favorite`
-- ----------------------------
DROP TABLE IF EXISTS `favorite`;
CREATE TABLE `favorite` (
  `id` varchar(32) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `post_id` varchar(32) DEFAULT NULL,
  `post_title` varchar(255) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_favorite_post` (`post_id`),
  KEY `FK_favorite_user` (`user_id`),
  CONSTRAINT `FK_favorite` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`),
  CONSTRAINT `FK_favorite_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of favorite
-- ----------------------------
INSERT INTO `favorite` VALUES ('A2ECE060F42044F6BFBE4FA8D2450CDC', '13', '2C15035ECAFB4812B6130DADAB1AD114', '有没有懂mybatis的大神帮帮忙，很急，谢谢！！！', '2018-05-19 11:18:37');

-- ----------------------------
-- Table structure for `file`
-- ----------------------------
DROP TABLE IF EXISTS `file`;
CREATE TABLE `file` (
  `id` char(32) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `path` varchar(1024) DEFAULT NULL,
  `introduce` varchar(2048) DEFAULT NULL,
  `score` int(11) DEFAULT NULL COMMENT '所需积分',
  `download_num` int(11) DEFAULT '0',
  `createtime` datetime DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `username` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_file` (`user_id`),
  CONSTRAINT `FK_file` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of file
-- ----------------------------
INSERT INTO `file` VALUES ('1b3acca2bf3c5d3d1cc33f375c27281a', 'Socket_WebSocket客户端程序v120.zip', 'upload/file/77B\\1525762277320160.zip', '<p>Socket_WebSocket客户端程序v120</p>', '1', '3', '2018-05-08 14:51:17', '13', 'sliver');
INSERT INTO `file` VALUES ('697c9dc5f6cfea1f7f421f7a22176d23', 'WebSocket压力并发测试v106.zip', 'upload/file/B31\\1526636179166173.zip', '<p>WebSocket压力并发测试</p>', '1', '2', '2018-05-18 17:36:19', '14', 'test');
INSERT INTO `file` VALUES ('ebe81d0c086fbbf4eb63a7c37a08061c', 'sweetalert.rar', 'upload/file/4EF\\1526606104071015.rar', '友好的提示插件', '5', '0', '2018-05-18 09:15:04', '13', 'sliver');

-- ----------------------------
-- Table structure for `log`
-- ----------------------------
DROP TABLE IF EXISTS `log`;
CREATE TABLE `log` (
  `id` varchar(32) NOT NULL,
  `content` varchar(4096) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of log
-- ----------------------------

-- ----------------------------
-- Table structure for `message`
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` varchar(32) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `receiver` varchar(255) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `content` varchar(4096) DEFAULT NULL,
  `sender_id` int(11) NOT NULL,
  `send_time` datetime DEFAULT NULL,
  `readed` tinyint(1) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `receive_time` datetime DEFAULT NULL,
  `sender` varchar(32) DEFAULT NULL,
  `delete_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_message` (`receiver_id`),
  CONSTRAINT `FK_message` FOREIGN KEY (`receiver_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES ('0973B2AA3FBD454C9D879E54EDC59B18', '13', 'sliver', '问题回复', '有人回答了你的问题：java异常，快去看看吧', '4', '2018-05-08 15:02:40', '1', '1', '2018-05-10 09:51:03', 'admin', '2018-05-10 09:51:23');
INSERT INTO `message` VALUES ('69C5954F446F4DFBBCFCD8ADE75F5412', '13', 'sliver', '问题回复', '有人回答了你的问题：java异常，快去看看吧', '4', '2018-05-08 15:08:37', '1', '1', '2018-05-10 09:51:00', 'admin', '2018-05-10 09:51:22');
INSERT INTO `message` VALUES ('980CF83FC691436591D1D7FEFA4AA34E', '13', 'sliver', '问题回复', '有人回答了你的问题：java异常，快去看看吧', '4', '2018-05-08 15:04:42', '1', '1', '2018-05-10 09:51:16', 'admin', '2018-05-10 09:51:23');
INSERT INTO `message` VALUES ('ABD03B9D9E6E4979A07BF899D60797EA', '13', 'sliver', '问题回复', '有人回答了你的问题：java异常，快去看看吧', '4', '2018-05-18 18:37:26', '0', '0', null, 'admin', null);
INSERT INTO `message` VALUES ('BFAEB3C32D324375811960475DBB8DEB', '13', 'sliver', '问题回复', '有人回答了你的问题：关于SQLdistinct和order by的问题，快去看看吧', '4', '2018-05-14 21:12:58', '1', '1', '2018-05-18 09:00:58', 'admin', '2018-05-18 09:14:11');
INSERT INTO `message` VALUES ('E3864B4ABBBD43B489EE243BC50A606B', '13', 'sliver', '问题回复', '有人回答了你的问题：java异常，快去看看吧', '4', '2018-05-08 15:01:27', '1', '1', '2018-05-10 09:51:13', 'admin', '2018-05-10 09:51:23');

-- ----------------------------
-- Table structure for `orders`
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `order_id` varchar(32) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `money` float DEFAULT NULL,
  `finished` tinyint(1) DEFAULT '0',
  `createtime` datetime DEFAULT NULL,
  `finished_time` datetime DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `FK_order_user` (`user_id`),
  CONSTRAINT `FK_order_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES ('147F6CD084EB48979F9ED293BC6786CE', '13', '10', '1', '0', '2018-05-19 08:24:51', null);
INSERT INTO `orders` VALUES ('1BA86ADBEB54485090E73081040B0590', '13', '50', '5', '0', '2018-05-14 21:21:25', null);
INSERT INTO `orders` VALUES ('32CDFCECC76D479880542D6EDF122237', '13', '50', '5', '0', '2018-05-14 21:25:59', null);
INSERT INTO `orders` VALUES ('5071BE6309984184859B882C96247A4F', '13', '100', '10', '0', '2018-05-14 21:24:58', null);
INSERT INTO `orders` VALUES ('58E459F592B4429A9FBB46EA83E1B491', '13', '50', '5', '1', '2018-05-19 11:21:55', '2018-05-19 11:22:41');
INSERT INTO `orders` VALUES ('7839EAF920BC4AD8B29C9E82A39EB026', '13', '50', '5', '0', '2018-05-14 21:29:19', null);
INSERT INTO `orders` VALUES ('935310BFE84D49C0BEBEC87FE62FA924', '13', '10', '1', '0', '2018-05-08 14:49:36', null);
INSERT INTO `orders` VALUES ('AAB0F8360F0E400AA29ABB1C81C22341', '13', '100', '10', '0', '2018-05-14 21:24:52', null);
INSERT INTO `orders` VALUES ('AADAEB185D064FDCA054EBE997BF1FE0', '13', '20', '2', '0', '2018-05-18 22:49:08', null);
INSERT INTO `orders` VALUES ('B358C02B85324AFCB6D8629ABB175755', '13', '100', '10', '0', '2018-05-14 21:25:54', null);
INSERT INTO `orders` VALUES ('D9F397F6AFF44F638ECC6B4E7C724041', '13', '10', '1', '0', '2018-05-14 21:25:19', null);

-- ----------------------------
-- Table structure for `post`
-- ----------------------------
DROP TABLE IF EXISTS `post`;
CREATE TABLE `post` (
  `id` varchar(32) CHARACTER SET utf8 NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` varchar(15000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `board_id` int(11) DEFAULT NULL,
  `is_top` tinyint(1) DEFAULT '0' COMMENT '是否置顶',
  `board_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_name` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除',
  `createtime` datetime DEFAULT NULL,
  `altertime` datetime DEFAULT NULL,
  `view_num` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_post_user` (`user_id`),
  KEY `FK_post_board` (`board_id`),
  CONSTRAINT `FK_post` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_post_board` FOREIGN KEY (`board_id`) REFERENCES `board` (`id`),
  CONSTRAINT `FK_post_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of post
-- ----------------------------
INSERT INTO `post` VALUES ('2C15035ECAFB4812B6130DADAB1AD114', '13', '有没有懂mybatis的大神帮帮忙，很急，谢谢！！！', '<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"385\" class=\"layui-table\"><tbody><tr height=\"92\">\n  <td height=\"92\" class=\"xl63\" width=\"385\">insert<font class=\"font8\">操作如何返回主键，网上资料都是参数类型为</font><font class=\"font6\">javabean</font><font class=\"font8\">，返回到</font><font class=\"font6\">javabean</font><font class=\"font8\">中。</font><font class=\"font9\">想请教如果没有创建</font><font class=\"font7\">javabean</font><font class=\"font9\">，可以返回主键吗？具体如何操作？</font></td></tr></tbody></table>', '19', '0', 'java', 'sliver', '0', '2018-05-19 11:18:15', null, '1');
INSERT INTO `post` VALUES ('383AB0CF692F48C0BB2AA27756BC05EB', '13', 'test', 'test', '19', '0', 'java', 'sliver', '1', '2018-05-19 08:27:38', null, '0');
INSERT INTO `post` VALUES ('AE9DACE73A5B4CB49500EE79EFEEEDBB', '13', 'java的优势', '<pre id=\"best-content-2237051462\" accuse=\"aContent\" class=\"best-text mb-10\">Java是一种跨平台，适合于分布式计算环境的面向对象<a href=\"https://www.baidu.com/s?wd=%E7%BC%96%E7%A8%8B%E8%AF%AD%E8%A8%80&amp;tn=44039180_cpr&amp;fenlei=mv6quAkxTZn0IZRqIHckPjm4nH00T1Y4uWwWmW9BuHb4uARLrHD10ZwV5Hcvrjm3rH6sPfKWUMw85HfYnjn4nH6sgvPsT6KdThsqpZwYTjCEQLGCpyw9Uz4Bmy-bIi4WUvYETgN-TLwGUv3EP1RsrH6krjTdPHfLPjTsnHcY\" target=\"_blank\" class=\"baidu-highlight\">编程语言</a>。 <br><br>  具体来说，它具有如下特性: <br><br>  简单性、面向对象、分布式、解释型、可靠、安全、平台无关、可移植、高性能、多线程、动态性等。 <br><br>  下面我们将重点介绍Java语言的面向对象、平台无关、分布式、多线程、可靠和安全等特性。 <br><br>  1.面向对象 <br><br>  面向对象其实是现实世界模型的自然延伸。现实世界中任何实体都可以看作是对象。对象之间通过消息相互作用。另外，现实世界中任何实体都可归属于某类事物，任何对象都是某一类事物的实例。如果说传统的过程式<a href=\"https://www.baidu.com/s?wd=%E7%BC%96%E7%A8%8B%E8%AF%AD%E8%A8%80&amp;tn=44039180_cpr&amp;fenlei=mv6quAkxTZn0IZRqIHckPjm4nH00T1Y4uWwWmW9BuHb4uARLrHD10ZwV5Hcvrjm3rH6sPfKWUMw85HfYnjn4nH6sgvPsT6KdThsqpZwYTjCEQLGCpyw9Uz4Bmy-bIi4WUvYETgN-TLwGUv3EP1RsrH6krjTdPHfLPjTsnHcY\" target=\"_blank\" class=\"baidu-highlight\">编程语言</a>是以过程为中心以算法为驱动的话，面向对象的<a href=\"https://www.baidu.com/s?wd=%E7%BC%96%E7%A8%8B%E8%AF%AD%E8%A8%80&amp;tn=44039180_cpr&amp;fenlei=mv6quAkxTZn0IZRqIHckPjm4nH00T1Y4uWwWmW9BuHb4uARLrHD10ZwV5Hcvrjm3rH6sPfKWUMw85HfYnjn4nH6sgvPsT6KdThsqpZwYTjCEQLGCpyw9Uz4Bmy-bIi4WUvYETgN-TLwGUv3EP1RsrH6krjTdPHfLPjTsnHcY\" target=\"_blank\" class=\"baidu-highlight\">编程语言</a>则是以对象为中心以消息为驱动。用公式表示，过程式编程语言为:程序=算法+数据；面向对象编程语言为:程序=对象+消息。 <br><br>  所有面向对象编程语言都支持三个概念:封装、多态性和继承，Java也不例外。现实世界中的对象均有属性和行为，映射到计算机程序上，属性则表示对象的数据，行为表示对象的方法（其作用是处理数据或同外界交互）。所谓封装，就是用一个自主式框架把对象的数据和方法联在一起形成一个整体。可以说，对象是支持封装的手段，是封装的基本单位。Java语言的封装性较强，因为Java无全程变量，无主函数，在Java中绝大部分成员是对象，只有简单的数字类型、字符类型和布尔类型除外。而对于这些类型，Java也提供了相应的对象类型以便与其他对象交互操作。 <br><br>  多态性就是多种表现形式，具体来说，可以用“一个对外接口，多个内在实现方法”表示。举一个例子，计算机中的堆栈可以存储各种格式的数据，包括整型，浮点或字符。不管存储的是何种数据，堆栈的算法实现是一样的。针对不同的数据类型，编程人员不必手工选择，只需使用统一接口名，系统可自动选择。运算符重载（operatoroverload)一直被认为是一种优秀的多态机制体现，但由于考虑到它会使程序变得难以理解，所以Java最后还是把它取消了。 <br><br>  继承是指一个对象直接使用另一对象的属性和方法。事实上，我们遇到的很多实体都有继承的含义。例如，若把汽车看成一个实体，它可以分成多个子实体，如:卡车、公共汽车等。这些子实体都具有汽车的特性，因此，汽车是它们的“父亲”，而这些子实体则是汽车的“孩子”。Java提供给用户一系列类（class），Java的类有层次结构，子类可以继承父类的属性和方法。与另外一些面向对象编程语言不同，Java只支持单一继承。 <br><br>  2平台无关性 <br><br>  Java是平台无关的语言是指用Java写的应用程序不用修改就可在不同的软硬件平台上运行。平台无关有两种:源代码级和目标代码级。C和C++具有一定程度的源代码级平台无关，表明用C或C++写的应用程序不用修改只需重新编译就可以在不同平台上运行。 <br><br>  Java主要靠Java虚拟机（JVM）在目标码级实现平台无关性。JVM是一种抽象机器，它附着在具体操作系统之上，本身具有一套虚机器指令，并有自己的栈、寄存器组等。但JVM通常是在软件上而不是在硬件上实现。（目前，SUN系统公司已经设计实现了Java芯片，主要使用在网络计算机NC上。 <br><br>  另外，Java芯片的出现也会使Java更容易嵌入到家用电器中。）JVM是Java平台无关的基础，在JVM上，有一个Java解释器用来解释Java编译器编译后的程序。Java编程人员在编写完软件后，通过Java编译器将Java源程序编译为JVM的字节代码。任何一台机器只要配备了Java解释器，就可以运行这个程序，而不管这种字节码是在何种平台上生成的。另外，Java采用的是基于IEEE标准的数据类型。通过JVM保证数据类型的一致性，也确保了Java的平台无关性。 <br><br>  Java的平台无关性具有深远意义。首先，它使得编程人员所梦寐以求的事情（开发一次软件在任意平台上运行）变成事实，这将大大加快和促进软件产品的开发。其次Java的平台无关性正好迎合了“网络计算机”思想。如果大量常用的应用软件（如字处理软件等）都用Java重新编写，并且放在某个Internet服务器上，那么具有NC的用户将不需要占用大量空间安装软件，他们只需要一个 <br><br>  Java解释器，每当需要使用某种应用软件时，下载该软件的字节代码即可，运行结果也可以发回服务器。目前，已有数家公司开始使用这种新型的计算模式构筑自己的企业信息系统。<br>3分布式 <br><br>  分布式包括数据分布和操作分布。数据分布是指数据可以分散在网络的不同主机上，操作分布是指把一个计算分散在不同主机上处理。 <br><br>  Java支持WWW客户机/服务器计算模式，因此，它支持这两种分布性。对于前者，Java提供了一个叫作URL的对象，利用这个对象，你可以打开并访问具有相同URL地址上的对象，访问方式与访问本地文件系统相同。对于后者，Java的applet小程序可以从服务器下载到客户端，即部分计算在客户端进行，提高系统执行效率。 <br><br>  Java提供了一整套网络类库，开发人员可以利用类库进行网络程序设计，方便得实现Java的分布式特性。 <br><br>  4可靠性和安全性 <br><br>  Java最初设计目的是应用于电子类消费产品，因此要求较高的可靠性。Java虽然源于C++，但它消除了许多C++不可靠因素，可以防止许多编程错误。首先，Java是强类型的语言，要求显式的方法声明，这保证了编译器可以发现方法调用错误，保证程序更加可靠；其次，Java不支持指针，这杜绝了内存的非法访问；第三，Java的自动单元收集防止了内存丢失等动态内存分配导致的问题；第四，Java解释器运行时实施检查，可以发现数组和字符串访问的越界，最后，Java提供了异常处理机制，程序员可以把一组错误代码放在一个地方，这样可以简化错误处理任务便于恢复。 <br><br>  由于Java主要用于网络应用程序开发，因此对安全性有较高的要求。如果没有安全保证，用户从网络下载程序执行就非常危险。Java通过自己的安全机制防止了病毒程序的产生和下载程序对本地系统的威胁破坏。当Java字节码进入解释器时，首先必须经过字节码校验器的检查，然后，Java解释器将决定程序中类的内存布局，随后，类装载器负责把来自网络的类装载到单独的内存区域，避免应用程序之间相互干扰破坏。最后，客户端用户还可以限制从网络上装载的类只能访问某些文件系统。 <br><br>  上述几种机制结合起来，使得Java成为安全的编程语言。 <br><br>  5多线程 <br><br>  线程是操作系统的一种新概念，它又被称作轻量进程，是比传统进程更小的可并发执行的单位。 <br><br>  C和C++采用单线程体系结构，而Java却提供了多线程支持。 <br><br>  Java在两方面支持多线程。一方面，Java环境本身就是多线程的。若干个系统线程运行负责必要的无用单元回收，系统维护等系统级操作；另一方面，Java语言内置多线程控制，可以大大简化多线程应用程序开发。Java提供了一个类Thread，由它负责启动运行，终止线程，并可检查线程状态。Java的线程还包括一组同步原语。这些原语负责对线程实行并发控制。利用Java的多线程编程接口，开发人员可以方便得写出支持多线程的应用程序，提高程序执行效率。必须注意地是，Java的多线程支持在一定程度上受运行时支持平台的限制。例如，如果操作系统本身不支持多线程，Java的多线程特性可能就表现不出来。</pre>', '19', '1', 'java', 'sliver', '0', '2018-05-08 14:48:34', null, '10');
INSERT INTO `post` VALUES ('E127F3F5324C49D696EB30E222BF2E61', '13', '我想问问if(ch==\'\\r\') continue;该语句的作用', '<p><span>public&nbsp;class&nbsp;fan&nbsp;{</span><br><br><span>public&nbsp;static&nbsp;void&nbsp;main(String[]&nbsp;args)&nbsp;throws&nbsp;IOException&nbsp;{</span><br><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;InputStream&nbsp;in_2=System.in;</span><br><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;StringBuffer&nbsp;***=new&nbsp;StringBuffer();</span><br><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;int&nbsp;ch=0;</span><br><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;while((ch=in_2.read())!=-1)</span><br><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{</span><br><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;&nbsp;if(ch==\'\\r\')</span><br><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;&nbsp;&nbsp;continue;</span><br><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;&nbsp;&nbsp;if(ch==\'\\n\')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;&nbsp;&nbsp;</span><br><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;&nbsp;&nbsp;{</span><br><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;&nbsp;&nbsp;String&nbsp;temp=***.toString();</span><br><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;&nbsp;&nbsp;if(\"over\".equals(temp))&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;&nbsp;&nbsp;{</span><br><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;&nbsp;&nbsp;break;</span><br><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;&nbsp;&nbsp;}</span><br><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;&nbsp;&nbsp;System.out.println(temp.toUpperCase());</span><br><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;&nbsp;&nbsp;***.delete(0,***.length())&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;&nbsp;&nbsp;}</span><br><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;&nbsp;&nbsp;else&nbsp;{</span><br><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;&nbsp;&nbsp;***.append((char)ch);</span><br><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;&nbsp;&nbsp;}</span><br><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}</span><br><span>}</span></p>', '19', '0', 'java', 'sliver', '0', '2018-05-14 20:28:42', null, '4');

-- ----------------------------
-- Table structure for `post_reply`
-- ----------------------------
DROP TABLE IF EXISTS `post_reply`;
CREATE TABLE `post_reply` (
  `post_id` varchar(32) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `content` varchar(15000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `username` varchar(32) DEFAULT NULL,
  `id` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_reply_post` (`post_id`),
  KEY `FK_reply_user` (`user_id`),
  CONSTRAINT `FK_post_reply` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`),
  CONSTRAINT `FK_reply_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of post_reply
-- ----------------------------
INSERT INTO `post_reply` VALUES ('E127F3F5324C49D696EB30E222BF2E61', '13', '<p><span>是输入了回车键的意思</span></p>', '2018-05-14 20:56:40', '0', 'sliver', '2EF5976EE3B84C63AEF2E994B8B5F28F');
INSERT INTO `post_reply` VALUES ('E127F3F5324C49D696EB30E222BF2E61', '13', '<p><span>\\r\\n是windows下的回车换行，读进来是两个char,所以要干掉一个，判断你按了回车了。</span></p>', '2018-05-14 20:38:02', '0', 'sliver', '5A04CD9EA2D74E2EB57D32F81B4E0D9E');
INSERT INTO `post_reply` VALUES ('AE9DACE73A5B4CB49500EE79EFEEEDBB', '14', 'php是最好的语言', '2018-05-18 18:36:27', '0', 'test', '5E85C0379DF94676A99BF7BB98C5A246');
INSERT INTO `post_reply` VALUES ('AE9DACE73A5B4CB49500EE79EFEEEDBB', '14', '666', '2018-05-08 15:05:45', '0', 'test', '856D29BFC46945309A1DD200271E5F0A');
INSERT INTO `post_reply` VALUES ('2C15035ECAFB4812B6130DADAB1AD114', '13', '<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"357\" class=\"layui-table\"><tbody><tr height=\"38\">\n  <td height=\"38\" class=\"xl65\" width=\"357\">貌似用变量直接接收就可以了啊，和返回到bean里是一样的&nbsp;int&nbsp;id&nbsp;=&nbsp;save(bean);</td></tr></tbody></table>', '2018-05-19 11:18:33', '0', 'sliver', '97AC998D9E5A4F56B3B832BFE43D0285');
INSERT INTO `post_reply` VALUES ('AE9DACE73A5B4CB49500EE79EFEEEDBB', '13', '666', '2018-05-08 14:55:08', '0', 'sliver', 'F3655750E4D34E509C879C07C69EE517');
INSERT INTO `post_reply` VALUES ('E127F3F5324C49D696EB30E222BF2E61', '14', '<p><span>\\r\\n是windows下的回车换行，读进来是两个char,所以要干掉一个，判断你按了回车了。</span></p>', '2018-05-14 21:10:08', '0', 'test', 'FC2E20844B7A46FB9E2452BBFEC76D1B');
INSERT INTO `post_reply` VALUES ('E127F3F5324C49D696EB30E222BF2E61', '13', '<p><span>换行的意思，有换行的话，继续读</span></p>', '2018-05-14 20:37:51', '0', 'sliver', 'FF7B1FD26D9B4FD7893D777B41BA86BA');

-- ----------------------------
-- Table structure for `public_info`
-- ----------------------------
DROP TABLE IF EXISTS `public_info`;
CREATE TABLE `public_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `content` varchar(4096) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `altertime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of public_info
-- ----------------------------
INSERT INTO `public_info` VALUES ('8', '更新日志', '<ul><li>新增 table 的数据请求时的 headers 参数支持，用于添加请求头</li><li>新增 nav 垂直导航菜单的无限级子菜单功能（注意：水平导航菜单暂不支持无限极）</li><li>新增 nav 导航菜单基础属性 lay-shrink=\"all\"，用于开启：展开子菜单时，收缩兄弟节点已展开的子菜单</li><li>新增 upload 的数据请求时的 headers 参数支持，用于添加请求头</li><li>优化 upload 组件的 data 参数，支持方法写法，用于传递动态值。<a href=\"http://www.layui.com/doc/modules/upload.html#data\" target=\"_blank\">#详见文档</a></li><li>优化 element 的 nav 事件，并解决了之前存在的父菜单无法触发事件的问题</li><li>新增 upload 组件的 acceptMime 参数，规定打开文件选择框时，筛选显示的文件类型&nbsp;<a href=\"https://github.com/sentsin/layui/pull/91\" target=\"_blank\">#91</a></li><li>layedit.build() 第一个参数支持 html 原始对象&nbsp;<a href=\"https://github.com/sentsin/layui/pull/146\" target=\"_blank\">#146</a></li><li>Support post+json for table module&nbsp;<a href=\"https://github.com/sentsin/layui/pull/194\" target=\"_blank\">#194</a></li></ul>', '2018-05-08 15:11:43', null);

-- ----------------------------
-- Table structure for `question`
-- ----------------------------
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question` (
  `id` varchar(32) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `title` varchar(32) DEFAULT NULL,
  `content` varchar(12345) DEFAULT NULL,
  `pay_score` int(11) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `useful_answer_id` varchar(32) DEFAULT NULL,
  `username` varchar(32) DEFAULT NULL,
  `ack_answer_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_question_user` (`user_id`),
  CONSTRAINT `FK_question_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of question
-- ----------------------------
INSERT INTO `question` VALUES ('2250B44ACB434814A8B971B76E67DF44', '13', '这两个if else是一样的吗?', '<pre><code class=\"prettyprint\">if(表达式1)\n{\n    ....;\n}\nelse\n{\n    if(表达式2)\n    { \n      ....;\n    }\n    else\n    {\n      ....;\n    }\n}\n----------\nif(表达式1)\n{\n    ....;\n}\nelse if(表达式2)\n      {\n         ....;\n      }\n      else\n      {\n        ....;\n      }</code></pre>', '3', '2018-05-14 21:18:53', '0', null, 'sliver', null);
INSERT INTO `question` VALUES ('88A10677A6F1444DB1456EF4587C8DC7', '13', '关于SQLdistinct和order by的问题', '<div class=\"questions_detail_con\"><dl><dd><p>想实现以下功能<a href=\"http://img-ask.csdn.net/upload/201805/14/1526298924_197850.png\" target=\"_blank\"><img src=\"http://img-ask.csdn.net/upload/201805/14/1526298924_197850.png\" alt=\"将数据进行去重、排列、映射、wm_concat、和替换逗号\"></a></p><p>目前SQL如下<br>create table test0514<br>(<br>name varchar2(500),<br>score varchar2(500)<br>)</p><p>insert into test0514 values(\'张三\');<br>insert into test0514 values(\'张三\');<br>insert into test0514 values(\'张三\');<br>insert into test0514 values(\'张三\');<br>insert into test0514 values(\'李四\');<br>insert into test0514 values(\'王五\');<br>insert into test0514 values(\'赵六\');<br>insert into test0514 values(\'戴七\');<br>insert into test0514 values(\'鬼八\');</p><p>select replace(wm_concat(distinct decode(name,\'张三\',\'钢铁侠\',\'李四\',\'美国队长\',\'王五\',\'绿巨人\',\'赵六\',\'蜘蛛侠\',\'戴七\',\'黑寡妇\',\'鬼八\',\'猩红女巫\',\'老十\',\'sb\')),\',\',\'+\') from test0514 order by rownum</p><p>无法实现排序功能，请教各位大神如何实现！！在线等！！！</p></dd></dl></div><div class=\"share_bar_con share_bar_con_01\" id=\"question_689057\"></div>', '3', '2018-05-14 21:11:49', '0', null, 'sliver', null);
INSERT INTO `question` VALUES ('A23E6EDD5DA245E78B51834262018807', '13', 'cs', 'cs', '3', '2018-05-19 08:28:53', '1', null, 'sliver', null);
INSERT INTO `question` VALUES ('AB844C17B2DE4E39951954BB79AA39E3', '13', 'java异常', 'javac常见异常有哪些', '3', '2018-05-08 14:50:55', '0', null, 'sliver', null);
INSERT INTO `question` VALUES ('C9C0DFF8348E4BB2B7D209660EE9C0B1', '13', '如何从jsp页面向mysql按条件更新数据', '<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"288\" class=\"layui-table\"><tbody><tr height=\"66\">\n  <td height=\"66\" class=\"xl65\" width=\"288\">代码如下<br>\n    <br>\n    &nbsp;&lt;% <br>\n    &nbsp;&nbsp;&nbsp; String ID = new\n  String(request.getParameter(\"dId\").getBytes(\"ISO8859_1\"),\"UTF-8\");<br>\n    &nbsp;&nbsp;&nbsp; String AIS = new\n  String(request.getParameter(\"AIS\").getBytes(\"ISO8859_1\"),\"UTF-8\");<br>\n    &nbsp;&nbsp;&nbsp; try{<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n  Class.forName(\"com.mysql.jdbc.Driver\");<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; String url =\n  \"XXXXXXXXX\";<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; String username =\n  \"XXXXXXX\";<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; String password =\n  \"XXXXXXX\";<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection conn =\n  DriverManager.getConnection(url,username,password);<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; String isExist =\n  \"select * from newshipinfo where newshipinfo.AIS =\n  \'\"+AIS+\"\'\";<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PreparedStatement\n  pstmt = conn.prepareStatement(isExist);<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ResultSet rs =\n  pstmt.executeQuery();<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(rs.next()){<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n  out.print(\"该数据已存在,请不要重复添加!\");<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }else{&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; String sql =\n  \"insert into newshipinfo(AIS) values (?) where ID =\n  \'\"+ID+\"\'\";<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PreparedStatement ps\n  = conn.prepareStatement(sql);<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ps.setString(1,AIS);<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int row =\n  ps.executeUpdate();<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(row &gt;0){<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; out.print(\"数据添加成功\");<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ps.close();<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conn.close();<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>\n    &nbsp;&nbsp;&nbsp; }catch(Exception e){<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n  out.print(\"数据添加失败!\");<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; e.printStackTrace();<br>\n    &nbsp;&nbsp;&nbsp; }<br>\n    %&gt;<br>\n   \n  这个页面的目的是将前一个页面所提交的数据（ID号与AIS的值）填写到数据库里进行数据更新，数据库里AIS的初始值均为0，现在把页面的值传进去变成1或者2。传之前会判断数据库里AIS的值是不是1或者2，若是则提示不要重复输入。<br>\n    现在值可以传到这个页面没有问题，就是无法传入数据库，老是报这个错<br>\n    <br>\n    &nbsp;You have an error in your SQL\n  syntax; check the manual that corresponds to your MySQL server version for\n  the right syntax to use near \'where ID = \'12259\'\' at line 1<br>\n    是sql语句的错误吗，想请教下怎么修改代码。</td></tr></tbody></table>', '3', '2018-05-19 11:21:48', '0', null, 'sliver', null);

-- ----------------------------
-- Table structure for `score_log`
-- ----------------------------
DROP TABLE IF EXISTS `score_log`;
CREATE TABLE `score_log` (
  `id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `content` varchar(520) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `score` int(11) DEFAULT '0',
  `createtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_score_log` (`user_id`),
  CONSTRAINT `FK_score_log` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of score_log
-- ----------------------------
INSERT INTO `score_log` VALUES ('00981D10B2FC4597831C8A3413F359CE', '13', '发布问题：这两个if else是一样的吗?', '-3', '2018-05-14 21:18:53');
INSERT INTO `score_log` VALUES ('064E0D531D5440F0B39BA5DB46A272B0', '13', '发布问题：java异常', '-3', '2018-05-08 14:50:55');
INSERT INTO `score_log` VALUES ('1C902D7EF52C4057ACE0EE522E697898', '14', '下载文件Socket_WebSocket客户端程序v120.zip', '-1', '2018-05-19 08:00:59');
INSERT INTO `score_log` VALUES ('1D0478A8EEB443748A093F8D9A583BA7', '4', '下载文件Socket_WebSocket客户端程序v120.zip', '-1', '2018-05-08 15:15:38');
INSERT INTO `score_log` VALUES ('3CE52694ABD2480EB6DF25F16D5AD8D4', '13', '充值积分', '50', '2018-05-19 11:22:41');
INSERT INTO `score_log` VALUES ('42D9BEBEEE5F45A0A972DB118A950380', '13', '下载文件WebSocket压力并发测试v106.zip', '-1', '2018-05-18 22:13:24');
INSERT INTO `score_log` VALUES ('63C73BAB05D0491DBA92EB02CAA32A40', '13', 'sliver下载文件Socket_WebSocket客户端程序v120.zip', '1', '2018-05-19 08:00:59');
INSERT INTO `score_log` VALUES ('6DF3744F398F441BBBD7F4EC1798AC89', '14', 'test下载文件WebSocket压力并发测试v106.zip', '1', '2018-05-18 19:00:10');
INSERT INTO `score_log` VALUES ('73F075B01A3142D0B441BE91C7B95AA7', '13', 'sliver下载文件Socket_WebSocket客户端程序v120.zip', '1', '2018-05-19 08:00:59');
INSERT INTO `score_log` VALUES ('906A4CEA50A74EC2A2AD0C7D93BE5143', '13', '发布问题：如何从jsp页面向mysql按条件更新数据', '3', '2018-05-19 11:21:48');
INSERT INTO `score_log` VALUES ('99B3F4542A174706AE35A87FE506A32E', '13', 'sliver下载文件Socket_WebSocket客户端程序v120.zip', '1', '2018-05-08 15:15:38');
INSERT INTO `score_log` VALUES ('C3148D1567B048A78422285E5AA054D1', '14', '下载文件Socket_WebSocket客户端程序v120.zip', '-1', '2018-05-19 08:00:59');
INSERT INTO `score_log` VALUES ('CDA5223443494B2689BAEB97875F189A', '13', '下载文件WebSocket压力并发测试v106.zip', '-1', '2018-05-18 19:00:10');
INSERT INTO `score_log` VALUES ('D9B385D2E3954DA290A74C618CC3777A', '13', '发布问题：关于SQLdistinct和order by的问题', '-3', '2018-05-14 21:11:49');
INSERT INTO `score_log` VALUES ('DC99B0CC0D344236B24E0CCF6F5BFDD3', '14', 'test下载文件WebSocket压力并发测试v106.zip', '1', '2018-05-18 22:13:24');
INSERT INTO `score_log` VALUES ('EC89A5A506744FA399031FB9560AD864', '13', '发布问题：cs', '-3', '2018-05-19 08:28:53');

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL,
  `level` int(1) DEFAULT '0' COMMENT '1.普通用户，2.版主，3.管理员',
  `password` varchar(32) NOT NULL,
  `mail` varchar(255) NOT NULL,
  `name` varchar(32) DEFAULT '未填写姓名',
  `gender` char(2) DEFAULT '男',
  `birthday` char(25) DEFAULT '未填写生日',
  `pic` varchar(1024) DEFAULT NULL,
  `qq` char(12) DEFAULT NULL,
  `wechat` varchar(255) DEFAULT NULL,
  `note` varchar(1024) DEFAULT NULL,
  `post_num` int(11) DEFAULT '0',
  `question_num` int(11) DEFAULT '0',
  `score` int(11) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  `secrecy` tinyint(1) DEFAULT '0' COMMENT '0 公开， 1 保密',
  `createtime` datetime DEFAULT NULL,
  `alterime` datetime DEFAULT NULL,
  `last_login_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('4', 'admin', '2', 'CDD1D1B0447671CC2A246043687FE23B', 'admin@sliver.com', null, null, null, '/ITbbs_web\\\\upload/img/36B\\\\1523802759394427.jpg', null, null, null, '10', '0', '1005', '0', '0', '2018-03-15 00:00:00', '2018-05-18 10:33:26', '2018-05-19 11:20:05');
INSERT INTO `user` VALUES ('13', 'sliver', '0', '6D3BA6352BC70A0A84F8D2486DDDE2A9', 'sliver@sliver.com', '渣渣辉', '男', '2018-05-24', '/ITbbs_web\\\\upload/img/5FA\\\\1526300696378369.jpg', '908323739', '', '', '58', '5', '56', '0', '0', '2018-05-08 14:04:29', '2018-05-19 11:22:41', '2018-05-19 11:10:26');
INSERT INTO `user` VALUES ('14', 'test', '0', 'C586D05489DF86B5D3279BE2938FDDAE', 'test@sliver.com', '未填写姓名', '男', '未填写生日', '/ITbbs_web\\\\upload/img/71D\\\\1526636127994827.jpg', null, null, null, '0', '0', '0', '0', '0', '2018-05-08 14:54:04', '2018-05-19 08:00:59', '2018-05-19 08:00:39');
INSERT INTO `user` VALUES ('15', 'board01', '1', 'test', 'test', '未填写姓名', '男', '未填写生日', null, null, null, null, '56', '0', '0', '0', '0', null, '2018-05-18 17:27:44', null);
INSERT INTO `user` VALUES ('16', 'board02', '1', 'test', 'test', '未填写姓名', '男', '未填写生日', null, null, null, null, '56', '0', '0', '0', '0', null, '2018-05-18 17:28:25', null);
INSERT INTO `user` VALUES ('17', 'board03', '1', 'test', 'test', '未填写姓名', '男', '未填写生日', null, null, null, null, '56', '0', '0', '0', '0', null, '2018-05-18 17:27:55', null);
INSERT INTO `user` VALUES ('18', 'test2', '0', 'D168FAC3F66ED9DFD221F647AF256878', 'test2@sliver.com', '未填写姓名', '男', '未填写生日', '/ITbbs_web/images/defaultHeadPic.jpg', null, null, null, '0', '0', '0', '1', '0', '2018-05-19 11:18:01', '2018-05-19 11:18:01', '2018-05-19 11:20:26');

-- ----------------------------
-- View structure for `answer_vo`
-- ----------------------------
DROP VIEW IF EXISTS `answer_vo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `answer_vo` AS select `user`.`username` AS `username`,`answer`.`id` AS `id`,`answer`.`user_id` AS `user_id`,`answer`.`question_id` AS `question_id`,`answer`.`content` AS `content`,`answer`.`createtime` AS `createtime`,`user`.`pic` AS `pic` from (`answer` join `user`) where (`answer`.`user_id` = `user`.`id`) ;

-- ----------------------------
-- View structure for `favorite_vo`
-- ----------------------------
DROP VIEW IF EXISTS `favorite_vo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `favorite_vo` AS select `favorite`.`id` AS `id`,`post`.`createtime` AS `createtime`,`post`.`user_name` AS `user_name`,`post`.`board_name` AS `board_name`,`post`.`title` AS `title`,`post`.`user_id` AS `post_user_id`,`favorite`.`createtime` AS `favorite_time`,`favorite`.`post_id` AS `post_id`,`post`.`altertime` AS `altertime`,`post`.`view_num` AS `view_num`,`favorite`.`user_id` AS `favorite_user_id` from (`post` join `favorite`) where (`post`.`id` = `favorite`.`post_id`) order by `favorite`.`createtime` desc ;

-- ----------------------------
-- View structure for `post_reply_vo`
-- ----------------------------
DROP VIEW IF EXISTS `post_reply_vo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `post_reply_vo` AS select `post_reply`.`createtime` AS `createtime`,`post_reply`.`id` AS `id`,`post_reply`.`user_id` AS `user_id`,`post_reply`.`content` AS `content`,`post_reply`.`post_id` AS `post_id`,`user`.`username` AS `username`,`user`.`post_num` AS `post_num`,`user`.`pic` AS `pic` from (`post_reply` join `user`) where ((`user`.`id` = `post_reply`.`user_id`) and (`post_reply`.`deleted` = 0)) ;

-- ----------------------------
-- View structure for `question_vo`
-- ----------------------------
DROP VIEW IF EXISTS `question_vo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `question_vo` AS select `question`.`id` AS `id`,`question`.`user_id` AS `question_user_id`,`question`.`title` AS `title`,`question`.`content` AS `question`,`question`.`pay_score` AS `pay_score`,`question`.`createtime` AS `createtime`,`question`.`deleted` AS `deleted`,`question`.`useful_answer_id` AS `useful_answer_id`,`question`.`ack_answer_time` AS `ack_answer_time`,`user`.`username` AS `username`,`user`.`pic` AS `pic` from (`question` join `user`) where (`question`.`user_id` = `user`.`id`) ;
