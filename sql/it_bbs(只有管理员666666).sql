/*
Navicat MySQL Data Transfer

Source Server         : Lin
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : it_bbs

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2018-05-08 14:00:34
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of board
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of public_info
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('4', 'admin', '2', '9C9214835AECA0864B367C193E9C3C13', 'admin@sliver.com', null, null, null, '/ITbbs_web\\\\upload/img/36B\\\\1523802759394427.jpg', null, null, null, '10', '0', '1006', '0', '0', '2018-03-15 00:00:00', '2018-05-03 18:25:20', '2018-05-08 13:44:46');

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
