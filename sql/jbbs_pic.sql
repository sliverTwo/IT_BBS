/*
Navicat MySQL Data Transfer

Source Server         : Lin
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : bbs

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2018-03-14 11:33:49
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `jbbs_pic`
-- ----------------------------
DROP TABLE IF EXISTS `jbbs_pic`;
CREATE TABLE `jbbs_pic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `path` varchar(1000) DEFAULT NULL,
  `tieziid` int(11) DEFAULT NULL,
  `bankuaiid` int(11) DEFAULT NULL,
  `pictype` varchar(2) DEFAULT NULL,
  `createuserid` int(11) DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `isdel` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jbbs_pic
-- ----------------------------
