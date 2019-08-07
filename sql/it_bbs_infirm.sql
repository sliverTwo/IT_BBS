/*
Navicat MySQL Data Transfer

Source Server         : Lin
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : it_bbs

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2018-03-14 11:09:13
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `answer`
-- ----------------------------
DROP TABLE IF EXISTS `answer`;
CREATE TABLE `answer` (
  `id` varchar(32) NOT NULL,
  `use_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `question_id` varchar(32) DEFAULT NULL,
  `content` varchar(4096) DEFAULT NULL,
  `createtime` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_answer_question` (`question_id`),
  KEY `FK_user_answer` (`use_id`),
  CONSTRAINT `FK_answer_question` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`),
  CONSTRAINT `FK_user_answer` FOREIGN KEY (`use_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of answer
-- ----------------------------

-- ----------------------------
-- Table structure for `basic_set`
-- ----------------------------
DROP TABLE IF EXISTS `basic_set`;
CREATE TABLE `basic_set` (
  `id` int(11) NOT NULL,
  `set_name` varchar(255) DEFAULT NULL,
  `set_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of basic_set
-- ----------------------------

-- ----------------------------
-- Table structure for `board`
-- ----------------------------
DROP TABLE IF EXISTS `board`;
CREATE TABLE `board` (
  `id` int(11) NOT NULL,
  `board_name` varchar(32) DEFAULT NULL,
  `introduce` varchar(1024) DEFAULT NULL,
  `user_id` varchar(32) DEFAULT NULL,
  `createtime` date DEFAULT NULL,
  `altertime` date DEFAULT NULL,
  `creater` varchar(32) DEFAULT NULL,
  `alter_user_id` int(11) DEFAULT NULL,
  `order_num` int(11) DEFAULT NULL,
  `username` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of board
-- ----------------------------

-- ----------------------------
-- Table structure for `dingdan`
-- ----------------------------
DROP TABLE IF EXISTS `dingdan`;
CREATE TABLE `dingdan` (
  `order_id` varchar(255) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `money` float DEFAULT NULL,
  `funished` tinyint(4) DEFAULT NULL,
  `createtime` char(10) DEFAULT NULL,
  `finished_time` char(10) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `FK_order_user` (`user_id`),
  CONSTRAINT `FK_order_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dingdan
-- ----------------------------

-- ----------------------------
-- Table structure for `favorite`
-- ----------------------------
DROP TABLE IF EXISTS `favorite`;
CREATE TABLE `favorite` (
  `id` varchar(32) NOT NULL,
  `use_id` int(11) DEFAULT NULL,
  `post_id` varchar(32) DEFAULT NULL,
  `post_title` varchar(255) DEFAULT NULL,
  `createtime` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_favorite_post` (`post_id`),
  KEY `FK_favorite_user` (`use_id`),
  CONSTRAINT `FK_favorite_post` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`),
  CONSTRAINT `FK_favorite_user` FOREIGN KEY (`use_id`) REFERENCES `user` (`id`)
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
  `use_id` int(11) DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `path` varchar(1024) DEFAULT NULL,
  `downlown_num` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `user_username` varchar(32) NOT NULL,
  `createtime` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_file_user` (`use_id`),
  CONSTRAINT `FK_file_user` FOREIGN KEY (`use_id`) REFERENCES `user` (`id`)
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
  `create_time` date DEFAULT NULL,
  `content` varchar(4096) DEFAULT NULL,
  `rel_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of log
-- ----------------------------

-- ----------------------------
-- Table structure for `news`
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news` (
  `id` varchar(32) NOT NULL,
  `use_id` int(11) DEFAULT NULL,
  `receiver_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` varchar(4096) DEFAULT NULL,
  `sender_id` int(11) NOT NULL,
  `send_time` date DEFAULT NULL,
  `readed` tinyint(4) DEFAULT NULL,
  `deleted` tinyint(4) DEFAULT NULL,
  `receive_time` date DEFAULT NULL,
  `username` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_message_user` (`use_id`),
  CONSTRAINT `FK_message_user` FOREIGN KEY (`use_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of news
-- ----------------------------

-- ----------------------------
-- Table structure for `post`
-- ----------------------------
DROP TABLE IF EXISTS `post`;
CREATE TABLE `post` (
  `id` varchar(32) NOT NULL,
  `use_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `content` text,
  `board_id` int(11) DEFAULT NULL,
  `is_top` tinyint(4) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `board_name` varchar(255) DEFAULT NULL,
  `user_name` varchar(32) DEFAULT NULL,
  `deleted` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_post_user` (`use_id`),
  CONSTRAINT `FK_post_user` FOREIGN KEY (`use_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `content` varchar(4096) DEFAULT NULL,
  `create_time` date DEFAULT NULL,
  `deleted` tinyint(4) DEFAULT NULL,
  `username` varchar(32) DEFAULT NULL,
  `id` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_reply_post` (`post_id`),
  KEY `FK_reply_user` (`user_id`),
  CONSTRAINT `FK_reply_post` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`),
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
  `id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `content` varchar(1024) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `altertime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `content` text,
  `pay_score` int(11) DEFAULT NULL,
  `createtime` date DEFAULT NULL,
  `deleted` tinyint(4) DEFAULT NULL,
  `userful_answer_id` varchar(32) DEFAULT NULL,
  `username` varchar(32) DEFAULT NULL,
  `ack_answer_time` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_question_user` (`user_id`),
  CONSTRAINT `FK_question_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of question
-- ----------------------------

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL,
  `name` varchar(32) DEFAULT NULL,
  `gender` tinyint(4) DEFAULT NULL,
  `phone` char(11) DEFAULT NULL,
  `mail` varchar(255) NOT NULL,
  `qq` char(12) DEFAULT NULL,
  `wechat` varchar(255) DEFAULT NULL,
  `note` varchar(1024) DEFAULT NULL,
  `post_num` int(11) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `deleted` char(1) DEFAULT NULL,
  `createtime` date DEFAULT NULL,
  `alterime` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
