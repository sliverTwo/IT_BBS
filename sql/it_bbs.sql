/*
Navicat MySQL Data Transfer

Source Server         : Lin
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : it_bbs

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2018-04-09 18:35:28
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
INSERT INTO `answer` VALUES ('10086', '5', '68BF56C9A1AF497CA927A25E44F81AE9', 'hhh', '2018-04-03 11:33:03');
INSERT INTO `answer` VALUES ('366B8DBE19D246BE89B52CB0548B1F62', '5', 'A2B772F104C74DA9B3C962A3851363BD', '测试', '2018-04-03 15:25:41');
INSERT INTO `answer` VALUES ('368CC225E9E34668A938F6285C00F2A3', '5', 'A2B772F104C74DA9B3C962A3851363BD', '测试', '2018-04-03 15:22:55');
INSERT INTO `answer` VALUES ('5C94619A5A4E4D2789845B7D218119EF', '5', '68BF56C9A1AF497CA927A25E44F81AE9', '1', '2018-04-08 08:53:14');
INSERT INTO `answer` VALUES ('8482BCFAC0E242C9B33854EDB35482F5', '5', '68BF56C9A1AF497CA927A25E44F81AE9', '测试', '2018-04-08 08:42:56');
INSERT INTO `answer` VALUES ('AD4CB5020903431D84346CEC91762F59', '5', '68BF56C9A1AF497CA927A25E44F81AE9', '1', '2018-04-08 08:51:37');
INSERT INTO `answer` VALUES ('B2DDF06AF94B457F8B03CAD6ED466461', '5', '68BF56C9A1AF497CA927A25E44F81AE9', '再来', '2018-04-08 08:45:53');
INSERT INTO `answer` VALUES ('BF2565D41E6248DEADA7A122EB8E63D6', '5', 'A2B772F104C74DA9B3C962A3851363BD', '测试', '2018-04-03 15:22:29');
INSERT INTO `answer` VALUES ('D0F099F3E8224D7C966A7BA1833F782F', '5', 'A2B772F104C74DA9B3C962A3851363BD', '测试', '2018-04-03 15:20:13');
INSERT INTO `answer` VALUES ('FD74CA017F164E4E8598DDBAF8BFE989', '5', '68BF56C9A1AF497CA927A25E44F81AE9', 'test', '2018-04-08 08:48:03');

-- ----------------------------
-- Table structure for `apply_border`
-- ----------------------------
DROP TABLE IF EXISTS `apply_border`;
CREATE TABLE `apply_border` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(55) COLLATE utf8mb4_unicode_ci NOT NULL,
  `board_id` int(11) NOT NULL,
  `board_name` varchar(55) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apply_reason` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deal` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of apply_border
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
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `board_name` varchar(32) NOT NULL,
  `introduce` varchar(1024) DEFAULT NULL,
  `pic` varchar(1024) DEFAULT NULL,
  `user_id` int(11) DEFAULT '-1',
  `createtime` datetime DEFAULT NULL,
  `altertime` datetime DEFAULT NULL,
  `alter_user_id` int(11) DEFAULT NULL,
  `order_num` int(11) DEFAULT '0',
  `username` varchar(32) DEFAULT NULL,
  `owner_time` datetime DEFAULT NULL COMMENT '成为版主的时间',
  `score` int(11) DEFAULT '10',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of board
-- ----------------------------
INSERT INTO `board` VALUES ('6', 'java', 'java', '/ITbbs_web/upload/img/7B1/1522290568550891.jpg', '4', '2018-03-29 10:30:15', '2018-03-29 10:30:15', null, '6', 'admin', '2018-03-29 10:30:15', '20');
INSERT INTO `board` VALUES ('11', '贪玩蓝月', '是一款集经典与创新的传奇游戏，采用2.5D图像技术，通过即时的光影成像技术，营造亦真亦幻的游戏世界。突破以往传奇游戏的桎梏，再度重现英雄合击的经典版本。', '/ITbbs_web/upload/img/CA4/1522307114620765.jpg', '8', '2018-03-29 15:06:30', '2018-03-29 15:06:30', null, '11', 't2', '2018-03-29 15:06:30', '20');
INSERT INTO `board` VALUES ('13', 'pyhton', 'python', '/ITbbs_web/upload/img/B6F/1522397078780840.jpg', '10', '2018-03-29 21:42:08', '2018-03-29 21:42:08', null, '11', 't4', '2018-03-29 21:42:08', '20');
INSERT INTO `board` VALUES ('14', 'php', 'php是世界上最好的语言', '/ITbbs_web/upload/img/12C/1522378844401704.jpg', '9', '2018-03-30 11:01:13', '2018-03-30 11:01:13', null, '12', 't3', '2018-03-30 11:01:13', '20');
INSERT INTO `board` VALUES ('15', '11', '哈哈，我又回来了', '/ITbbs_web/upload/img/9DC/1522392433950343.jpg', '7', '2018-03-30 14:47:32', '2018-03-30 14:47:32', null, '0', 't1', '2018-03-30 14:47:32', '20');
INSERT INTO `board` VALUES ('16', 'dd', 'dd', '/ITbbs_web/upload/img/4EC/1522395495689853.jpg', '5', '2018-03-30 15:38:24', '2018-03-30 15:38:24', null, '11', 'sliver', '2018-03-30 15:38:24', '20');
INSERT INTO `board` VALUES ('18', '5', '5', '/ITbbs_web/images/boardDefaultPic.jpg', '11', '2018-03-30 15:45:22', '2018-03-30 15:45:22', null, '5', 't5', '2018-03-30 15:45:22', '20');

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of file
-- ----------------------------
INSERT INTO `file` VALUES ('cf9649223a4b704498826f79cb529ae7', '111.zip', 'upload\\upload\\upload\\file\\\\\\BE1\\1523157872309052.zip', '1', '1', '3', '2018-04-08 11:24:32', '5', 'sliver');
INSERT INTO `file` VALUES ('d042356be221bae7e93d36f786065cad', 'tt.zip', 'upload\\file\\E80\\1523157521526202.zip', 'tt', '5', '4', '2018-04-08 11:18:42', '5', 'sliver');

-- ----------------------------
-- Table structure for `log`
-- ----------------------------
DROP TABLE IF EXISTS `log`;
CREATE TABLE `log` (
  `id` varchar(32) NOT NULL,
  `content` varchar(4096) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of log
-- ----------------------------
INSERT INTO `log` VALUES ('05FB4EC8854C4528B660B91CEFC871F6', 'sliver成为dd版主 userInfoUser{id=5, username=\'sliver\', password=\'6D3BA6352BC70A0A84F8D2486DDDE2A9\', mail=\'t2@sliver.com\', name=\'渣渣辉\', gender=\'男\', birthday=\'1993-08-02\', age=19, pic=\'/ITbbs_web/upload/img/906/1522027977802204.jpg\', phone=\'10086\', qq=\'1234565478\', wechat=\'m12346789\', note=\'大扎好，我四渣渣辉，XXXX，介四里没有挽过的船新版本，挤需体验三番钟，里造会干我一样，爱象节款游戏！\', postNum=556, questionNum=556, answerNum=555, level=1, score=505, deleted=false, createtime=Fri Mar 16 00:00:00 CST 2018, alterime=Fri Mar 30 15:38:24 CST 2018, secrecy=true, isBoardOwer=false}', null, null, '2018-03-30 15:38:24');
INSERT INTO `log` VALUES ('08C60EA5BD6345FCABCBA5FD18EC9769', '取消User{id=10, username=\'t4\', password=\'1\', mail=\'12\', name=\'未填写姓名\', gender=\'男\', birthday=\'未填写生日\', age=null, pic=\'null\', phone=\'null\', qq=\'null\', wechat=\'null\', note=\'null\', postNum=666, questionNum=0, answerNum=0, level=0, score=0, deleted=false, createtime=Thu Mar 29 08:28:50 CST 2018, alterime=Fri Mar 30 15:39:16 CST 2018, secrecy=false, isBoardOwer=false}版主权限', null, null, '2018-03-30 15:40:27');
INSERT INTO `log` VALUES ('239D69C5BF9147A791764E3198CEA3D8', '新增版块：Board{id=null, boardName=\'11\', introduce=\'哈哈，我又回来了\', pic=\'/ITbbs_web/upload/img/9DC/1522392433950343.jpg\', userId=7, createtime=Fri Mar 30 14:47:31 CST 2018, altertime=Fri Mar 30 14:47:31 CST 2018, alterUserId=null, orderNum=122, username=\'t1\', ownerTime=Fri Mar 30 14:47:31 CST 2018, score=20}', null, null, '2018-03-30 14:47:32');
INSERT INTO `log` VALUES ('279191BFDC7E4BD4ACFBAD1669F408D3', 't3成为php版主 userInfocom.sliver.pojo.User@12ad72fd', null, null, '2018-03-30 11:01:13');
INSERT INTO `log` VALUES ('2EE00773494F4565A546DA6F7B72633F', 't1成为11版主 userInfoUser{id=7, username=\'t1\', password=\'0\', mail=\'1\', name=\'未填写姓名\', gender=\'男\', birthday=\'未填写生日\', age=null, pic=\'null\', phone=\'null\', qq=\'null\', wechat=\'null\', note=\'null\', postNum=666, questionNum=0, answerNum=0, level=1, score=0, deleted=false, createtime=Thu Mar 29 08:28:40 CST 2018, alterime=Fri Mar 30 14:47:31 CST 2018, secrecy=false, isBoardOwer=false}', null, null, '2018-03-30 14:47:32');
INSERT INTO `log` VALUES ('4384E8F6B657491DA5F535B1A23030DE', '取消User{id=7, username=\'t1\', password=\'1\', mail=\'1\', name=\'未填写姓名\', gender=\'男\', birthday=\'未填写生日\', age=null, pic=\'null\', phone=\'null\', qq=\'null\', wechat=\'null\', note=\'null\', postNum=666, questionNum=0, answerNum=0, level=0, score=0, deleted=false, createtime=Thu Mar 29 08:28:40 CST 2018, alterime=Fri Mar 30 15:43:11 CST 2018, secrecy=false, isBoardOwer=false}版主权限', null, null, '2018-03-30 15:43:11');
INSERT INTO `log` VALUES ('533EFDB798BD43C0AF273624D2096BD1', '取消User{id=11, username=\'t5\', password=\'0\', mail=\'12\', name=\'未填写姓名\', gender=\'男\', birthday=\'未填写生日\', age=null, pic=\'null\', phone=\'null\', qq=\'null\', wechat=\'null\', note=\'null\', postNum=666, questionNum=0, answerNum=0, level=0, score=0, deleted=false, createtime=Thu Mar 29 08:28:52 CST 2018, alterime=Fri Mar 30 15:45:30 CST 2018, secrecy=false, isBoardOwer=false}版主权限', null, null, '2018-03-30 15:45:30');
INSERT INTO `log` VALUES ('56A4696FF29543CEB3EE3B26AFACB5BC', 't5成为5版主 userInfoUser{id=11, username=\'t5\', password=\'0\', mail=\'12\', name=\'未填写姓名\', gender=\'男\', birthday=\'未填写生日\', age=null, pic=\'null\', phone=\'null\', qq=\'null\', wechat=\'null\', note=\'null\', postNum=666, questionNum=0, answerNum=0, level=1, score=0, deleted=false, createtime=Thu Mar 29 08:28:52 CST 2018, alterime=Fri Mar 30 15:45:21 CST 2018, secrecy=false, isBoardOwer=false}', null, null, '2018-03-30 15:45:22');
INSERT INTO `log` VALUES ('639D3FA8DDC44F38B9499CDB24095A57', '新增版块：Board{id=null, boardName=\'dd\', introduce=\'dd\', pic=\'/ITbbs_web/upload/img/4EC/1522395495689853.jpg\', userId=5, createtime=Fri Mar 30 15:38:24 CST 2018, altertime=Fri Mar 30 15:38:24 CST 2018, alterUserId=null, orderNum=11, username=\'sliver\', ownerTime=Fri Mar 30 15:38:24 CST 2018, score=20}', null, null, '2018-03-30 15:38:24');
INSERT INTO `log` VALUES ('7ADF3D99046F46C3AC260330630299AC', '新增版块：Board{id=null, boardName=\'5\', introduce=\'5\', pic=\'/ITbbs_web/images/boardDefaultPic.jpg\', userId=11, createtime=Fri Mar 30 15:45:21 CST 2018, altertime=Fri Mar 30 15:45:21 CST 2018, alterUserId=null, orderNum=5, username=\'t5\', ownerTime=Fri Mar 30 15:45:21 CST 2018, score=20}', null, null, '2018-03-30 15:45:22');
INSERT INTO `log` VALUES ('7E1C978C466A4560B0CEC4EC6F292C06', '取消User{id=11, username=\'t5\', password=\'0\', mail=\'12\', name=\'未填写姓名\', gender=\'男\', birthday=\'未填写生日\', age=null, pic=\'null\', phone=\'null\', qq=\'null\', wechat=\'null\', note=\'null\', postNum=666, questionNum=0, answerNum=0, level=0, score=0, deleted=false, createtime=Thu Mar 29 08:28:52 CST 2018, alterime=Fri Mar 30 15:43:00 CST 2018, secrecy=false, isBoardOwer=false}版主权限', null, null, '2018-03-30 15:43:25');
INSERT INTO `log` VALUES ('7F0066594B704365BE5E8E587A95E06A', 't5成为22版主 userInfoUser{id=11, username=\'t5\', password=\'0\', mail=\'12\', name=\'未填写姓名\', gender=\'男\', birthday=\'未填写生日\', age=null, pic=\'null\', phone=\'null\', qq=\'null\', wechat=\'null\', note=\'null\', postNum=666, questionNum=0, answerNum=0, level=1, score=0, deleted=false, createtime=Thu Mar 29 08:28:52 CST 2018, alterime=Fri Mar 30 15:42:59 CST 2018, secrecy=false, isBoardOwer=false}', null, null, '2018-03-30 15:43:00');
INSERT INTO `log` VALUES ('82B09F2B591A400AA5854F4A72FC0513', '取消User{id=7, username=\'t1\', password=\'0\', mail=\'1\', name=\'未填写姓名\', gender=\'男\', birthday=\'未填写生日\', age=null, pic=\'null\', phone=\'null\', qq=\'null\', wechat=\'null\', note=\'null\', postNum=666, questionNum=0, answerNum=0, level=0, score=0, deleted=false, createtime=Thu Mar 29 08:28:40 CST 2018, alterime=Fri Mar 30 15:40:26 CST 2018, secrecy=false, isBoardOwer=false}版主权限', null, null, '2018-03-30 15:40:51');
INSERT INTO `log` VALUES ('8AFFC597D70E4CA897805DC10620B10A', '新增版块：Board{id=null, boardName=\'贪玩蓝月\', introduce=\'是一款集经典与创新的传奇游戏，采用2.5D图像技术，通过即时的光影成像技术，营造亦真亦幻的游戏世界。突破以往传奇游戏的桎梏，再度重现英雄合击的经典版本。\', pic=\'/ITbbs_web/upload/img/CA4/1522307114620765.jpg\', userId=11, createtime=Thu Mar 29 15:06:29 CST 2018, altertime=Thu Mar 29 15:06:29 CST 2018, alterUserId=null, orderNum=null, username=\'null\', ownerTime=Thu Mar 29 15:06:29 CST 2018, score=20}', null, null, '2018-03-29 15:06:30');
INSERT INTO `log` VALUES ('9D98E38E51A34568838B8E2E10E0F74B', '回答问题：Question [Hash = 2035313463, id=68BF56C9A1AF497CA927A25E44F81AE9, userId=5, title=12, content=sadasd, payScore=50, createtime=Sat Mar 24 00:00:00 CST 2018, deleted=false, usefulAnswerId=5C94619A5A4E4D2789845B7D218119EF, username=sliver, ackAnswerTime=Sun Apr 08 09:18:51 CST 2018]答案：Answer [Hash = 246359578, id=5C94619A5A4E4D2789845B7D218119EF, userId=5, questionId=68BF56C9A1AF497CA927A25E44F81AE9, content=1, createtime=Sun Apr 08 08:53:14 CST 2018]', '50', '5', '2018-04-08 09:18:52');
INSERT INTO `log` VALUES ('9F1AFE233046486A99724D24E9706D49', '取消User{id=7, username=\'t1\', password=\'0\', mail=\'1\', name=\'未填写姓名\', gender=\'男\', birthday=\'未填写生日\', age=null, pic=\'null\', phone=\'null\', qq=\'null\', wechat=\'null\', note=\'null\', postNum=666, questionNum=0, answerNum=0, level=0, score=0, deleted=false, createtime=Thu Mar 29 08:28:40 CST 2018, alterime=Fri Mar 30 15:39:00 CST 2018, secrecy=false, isBoardOwer=false}版主权限', null, null, '2018-03-30 15:39:00');
INSERT INTO `log` VALUES ('A0B6AB5240B9403B9BF593A4D94B0EEE', 't5成为11版主 userInfocom.sliver.pojo.User@1e5e27fa', null, null, '2018-03-29 21:41:21');
INSERT INTO `log` VALUES ('A4B0AB424E3D4DBC91CDCDA4154AE783', '取消User{id=10, username=\'t4\', password=\'1\', mail=\'12\', name=\'未填写姓名\', gender=\'男\', birthday=\'未填写生日\', age=null, pic=\'null\', phone=\'null\', qq=\'null\', wechat=\'null\', note=\'null\', postNum=666, questionNum=0, answerNum=0, level=0, score=0, deleted=false, createtime=Thu Mar 29 08:28:50 CST 2018, alterime=Thu Mar 29 21:42:08 CST 2018, secrecy=false, isBoardOwer=false}版主权限', null, null, '2018-03-30 15:39:08');
INSERT INTO `log` VALUES ('B68A0221F21140248C3055BC972F9677', '新增版块：Board{id=null, boardName=\'php\', introduce=\'php是世界上最好的语言\', pic=\'/ITbbs_web/upload/img/12C/1522378844401704.jpg\', userId=9, createtime=Fri Mar 30 11:01:12 CST 2018, altertime=Fri Mar 30 11:01:12 CST 2018, alterUserId=null, orderNum=12, username=\'t3\', ownerTime=Fri Mar 30 11:01:12 CST 2018, score=20}', null, null, '2018-03-30 11:01:13');
INSERT INTO `log` VALUES ('B7C37FA47D56477C81E1C7DB01D18A9F', '新增版块：Board{id=null, boardName=\'pyhton\', introduce=\'python\', pic=\'/ITbbs_web/images/boardDefaultPic.jpg\', userId=10, createtime=Thu Mar 29 21:42:08 CST 2018, altertime=Thu Mar 29 21:42:08 CST 2018, alterUserId=null, orderNum=11, username=\'t4\', ownerTime=Thu Mar 29 21:42:08 CST 2018, score=20}', null, null, '2018-03-29 21:42:08');
INSERT INTO `log` VALUES ('C3C2238B808E454594158C19606BC91F', '新增版块：Board{id=null, boardName=\'11\', introduce=\'python\', pic=\'/ITbbs_web/images/boardDefaultPic.jpg\', userId=11, createtime=Thu Mar 29 21:41:20 CST 2018, altertime=Thu Mar 29 21:41:20 CST 2018, alterUserId=null, orderNum=0, username=\'t5\', ownerTime=Thu Mar 29 21:41:20 CST 2018, score=20}', null, null, '2018-03-29 21:41:21');
INSERT INTO `log` VALUES ('C8D1DFBD4BE04F2395A5B14AB2BEF477', '取消User{id=7, username=\'t1\', password=\'0\', mail=\'1\', name=\'未填写姓名\', gender=\'男\', birthday=\'未填写生日\', age=null, pic=\'null\', phone=\'null\', qq=\'null\', wechat=\'null\', note=\'null\', postNum=666, questionNum=0, answerNum=0, level=0, score=0, deleted=false, createtime=Thu Mar 29 08:28:40 CST 2018, alterime=Fri Mar 30 15:39:08 CST 2018, secrecy=false, isBoardOwer=false}版主权限', null, null, '2018-03-30 15:39:16');
INSERT INTO `log` VALUES ('D2EAD6DBB8E84B0397F373A2ADE07609', '取消User{id=4, username=\'admin\', password=\'9C9214835AECA0864B367C193E9C3C13\', mail=\'admin@sliver.com\', name=\'null\', gender=\'null\', birthday=\'null\', age=null, pic=\'images/touxiang.jpg\', phone=\'null\', qq=\'null\', wechat=\'null\', note=\'null\', postNum=0, questionNum=0, answerNum=0, level=0, score=0, deleted=false, createtime=Thu Mar 15 00:00:00 CST 2018, alterime=Fri Mar 30 15:38:47 CST 2018, secrecy=false, isBoardOwer=false}版主权限', null, null, '2018-03-30 15:38:47');
INSERT INTO `log` VALUES ('DB31223308DE45C5A5B7548903392C8D', '新增版块：Board{id=null, boardName=\'22\', introduce=\'22\', pic=\'/ITbbs_web/upload/img/D58/1522395773898397.jpg\', userId=11, createtime=Fri Mar 30 15:42:59 CST 2018, altertime=Fri Mar 30 15:42:59 CST 2018, alterUserId=null, orderNum=22, username=\'t5\', ownerTime=Fri Mar 30 15:42:59 CST 2018, score=20}', null, null, '2018-03-30 15:43:00');
INSERT INTO `log` VALUES ('F4D311987B4F49F185415DD8B55F4EC2', '取消User{id=4, username=\'admin\', password=\'9C9214835AECA0864B367C193E9C3C13\', mail=\'admin@sliver.com\', name=\'null\', gender=\'null\', birthday=\'null\', age=null, pic=\'images/touxiang.jpg\', phone=\'null\', qq=\'null\', wechat=\'null\', note=\'null\', postNum=0, questionNum=0, answerNum=0, level=0, score=0, deleted=false, createtime=Thu Mar 15 00:00:00 CST 2018, alterime=Thu Mar 15 00:00:00 CST 2018, secrecy=false, isBoardOwer=false}版主权限', null, null, '2018-03-30 15:38:42');
INSERT INTO `log` VALUES ('F57D2FB47677446CA032D739ED0F41CE', '删除了版块Board{id=17, boardName=\'22\', introduce=\'22\', pic=\'/ITbbs_web/upload/img/D58/1522395773898397.jpg\', userId=11, createtime=Fri Mar 30 15:43:00 CST 2018, altertime=Fri Mar 30 15:43:00 CST 2018, alterUserId=null, orderNum=22, username=\'t5\', ownerTime=Fri Mar 30 15:43:00 CST 2018, score=20} 原因为：删除无罪', null, null, '2018-03-30 15:43:25');
INSERT INTO `log` VALUES ('F80EAE10EDE7446295322289B6A2258C', 't4成为pyhton版主 userInfocom.sliver.pojo.User@5b8aed79', null, null, '2018-03-29 21:42:08');
INSERT INTO `log` VALUES ('FFD7BF45474749FFBB65AAD68B9683EE', '取消User{id=10, username=\'t4\', password=\'1\', mail=\'12\', name=\'未填写姓名\', gender=\'男\', birthday=\'未填写生日\', age=null, pic=\'null\', phone=\'null\', qq=\'null\', wechat=\'null\', note=\'null\', postNum=666, questionNum=0, answerNum=0, level=0, score=0, deleted=false, createtime=Thu Mar 29 08:28:50 CST 2018, alterime=Fri Mar 30 16:04:40 CST 2018, secrecy=false, isBoardOwer=false}版主权限', null, null, '2018-03-30 16:04:40');

-- ----------------------------
-- Table structure for `message`
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` varchar(32) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `receiver_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` varchar(4096) DEFAULT NULL,
  `sender_id` int(11) NOT NULL,
  `send_time` datetime DEFAULT NULL,
  `readed` tinyint(1) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `receive_time` datetime DEFAULT NULL,
  `username` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_message_user` (`user_id`),
  CONSTRAINT `FK_message_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of message
-- ----------------------------

-- ----------------------------
-- Table structure for `orders`
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `order_id` varchar(255) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `money` float DEFAULT NULL,
  `finished` tinyint(1) DEFAULT NULL,
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
  `reply_num` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_post_user` (`user_id`),
  CONSTRAINT `FK_post_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of post
-- ----------------------------
INSERT INTO `post` VALUES ('065D2514ED3944D594402559B397CA14', '5', '8', '8', '6', '0', 'java', 'sliver', '1', '2018-03-23 00:00:00', null, '555', '666');
INSERT INTO `post` VALUES ('0DF0421DA38D48458C0818866E843A1E', '5', '3', '3', '6', '0', 'java', 'sliver', '1', '2018-03-24 00:00:00', null, '555', '666');
INSERT INTO `post` VALUES ('0E6AB3DBC34A414AA5EE36EC6C57A532', '5', '4', '4', '6', '0', 'java', 'sliver', '1', '2018-03-23 00:00:00', null, '555', '666');
INSERT INTO `post` VALUES ('1FBD8B5AC1F74CC1B4E63CE2467B75B0', '5', '5', '5', '6', '0', 'java', 'sliver', '0', '2018-03-23 00:00:00', null, '555', '666');
INSERT INTO `post` VALUES ('3DCE5239384244C4B1054D26017D12C9', '5', 'hello java', '<img src=\"http://localhost:8080/ITbbs_web/js/layui/images/face/0.gif\" alt=\"[微笑]\">', '6', '0', 'java', 'sliver', '0', '2018-03-16 00:00:00', null, '556', '666');
INSERT INTO `post` VALUES ('3DD689416DB045F5B7149252700DC41D', '5', '9', '89', '6', '0', 'java', 'sliver', '0', '2018-03-23 00:00:00', null, '555', '666');
INSERT INTO `post` VALUES ('7762BC0770174B5C91B4B3941726F1EC', '5', '我是渣渣辉', '快来和我一起玩好玩的贪玩蓝月<img src=\"http://localhost:8080/ITbbs_web/js/layui/images/face/0.gif\" alt=\"[微笑]\">', '11', '0', '贪玩蓝月', 'sliver', '0', '2018-03-30 16:31:16', '2018-04-03 09:18:29', '79', '666');
INSERT INTO `post` VALUES ('7A8E6044B1F04E44AC0BA540CB4A72F7', '5', 'java多线程 一个线程怎么监听另一个线程的变量', '<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" id=\"post-403125230\" class=\"post topic layui-table\" data-post-id=\"403125230\" data-is-topic-locked=\"false\"><tbody><tr><td valign=\"top\" class=\"post_info topic\" data-username=\"sinat_32487535\" data-floor=\"\"><div class=\"post_body\">&nbsp;我想设计一个基于socket的一对多的服务器，一方面，客户端定期的向服务端发送数据，另一方面，还需要在相应客户端对应的数据库中的数据发生了变化的时候让服务器对他们进行一个反向的通信（这个数据的变化与客户端本身无关，而是用户下达操作造成的数据变化）。<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;由此，我设想，建立三个线程，建立一个全局的变量，用于线程间的沟通。<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>&nbsp;&nbsp;&nbsp;线程一：实时得去检测数据库的变化，如果变化则改变全局变量.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;线程二：接收客户端的数据。<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;线程三：定时检测全局变量，如果全局变量的值变化了，再去查询数据库，根据实际情况去发送数据给客户端。</span><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;设想得很美，可是实际编写得时候我发现好像找不到在线程之间沟通得方法。<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;以下是我有关这个的代码，希望各位能帮我想想，该怎么写。<br>&nbsp;&nbsp;&nbsp;&nbsp;<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;如果用匿名类的方式去写线程，则能够传这个status进去，但是这样status就变成final了，如果照下面写，写类去实现线程，那参数status又不能实时得去传了。</span><br>怎么写啊？？？<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>public&nbsp;class&nbsp;Main&nbsp;{<br>//希望另外两个线程能够监测到status的变化<br>static&nbsp;int&nbsp;status;<br>public&nbsp;static&nbsp;void&nbsp;main(String[]&nbsp;args)&nbsp;throws&nbsp;IOException{<br>//匿名类的线程写法<br>Thread&nbsp;checkThread&nbsp;=&nbsp;new&nbsp;Thread(new&nbsp;Runnable()&nbsp;{<br>&nbsp;&nbsp;public&nbsp;void&nbsp;run()&nbsp;{<br>&nbsp;&nbsp;Connection&nbsp;conn&nbsp;=&nbsp;DBUtil.open();<br>&nbsp;&nbsp;String&nbsp;sql&nbsp;=&nbsp;\"select&nbsp;mac_id&nbsp;from&nbsp;machines&nbsp;where&nbsp;dataStatus=1\";<br>&nbsp;&nbsp;while(true)&nbsp;{<br>//查数据库,可以考虑封装<br>&nbsp;&nbsp;try&nbsp;{<br>PreparedStatement&nbsp;pstmt&nbsp;=&nbsp;conn.prepareStatement(sql);<br>ResultSet&nbsp;rs&nbsp;=&nbsp;pstmt.executeQuery();<br>//判断一次就够了&nbsp;不要用while<br>if(rs.next())&nbsp;{<br>status&nbsp;=&nbsp;1;<br>}<br><br>}&nbsp;catch&nbsp;(SQLException&nbsp;e)&nbsp;{<br>//&nbsp;TODO&nbsp;Auto-generated&nbsp;catch&nbsp;block<br>e.printStackTrace();<br>}<br>&nbsp;&nbsp;//两秒查一次<br>&nbsp;&nbsp;try&nbsp;{<br>Thread.sleep(2000);<br>}&nbsp;catch&nbsp;(InterruptedException&nbsp;e)&nbsp;{<br>//&nbsp;TODO&nbsp;Auto-generated&nbsp;catch&nbsp;block<br>e.printStackTrace();<br>}<br>&nbsp;&nbsp;}<br>&nbsp;&nbsp;}<br>});<br>checkThread.start();<br>//设置端口&nbsp;启动ServerSocket等待连接,初始化Socket<br>final&nbsp;int&nbsp;PORT&nbsp;=&nbsp;60000;<br>ServerSocket&nbsp;serverSocket&nbsp;=&nbsp;new&nbsp;ServerSocket(PORT);<br>Socket&nbsp;client&nbsp;=&nbsp;null;<br>/*一个定期检查数据库状态变量的线程+n对(每队两个)Socket收发线程*/<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;while(((client=serverSocket.accept())&nbsp;!=&nbsp;null))&nbsp;{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	System.out.println(client);<br>new&nbsp;Thread(new&nbsp;SendCmd(client,status)).start();&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	new&nbsp;Thread(new&nbsp;GetData(client)).start();<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>}<br><br>}<br><br>//接收数据线程&nbsp;<br>class&nbsp;GetData&nbsp;implements&nbsp;Runnable{<br>private&nbsp;Socket&nbsp;client;<br>&nbsp;&nbsp;&nbsp;&nbsp;public&nbsp;GetData()&nbsp;{<br><br>}<br>&nbsp;&nbsp;&nbsp;&nbsp;public&nbsp;GetData(Socket&nbsp;client){<br>&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;this.client=client;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//指定client<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br>@Override<br>public&nbsp;void&nbsp;run()&nbsp;{<br>//&nbsp;TODO&nbsp;Auto-generated&nbsp;method&nbsp;stub<br>&nbsp;InputStream&nbsp;iStream&nbsp;=&nbsp;null;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//初始化输入流<br>&nbsp;PrintWriter&nbsp;pw&nbsp;=null;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//初始化输出流<br>&nbsp;try&nbsp;{<br>iStream&nbsp;=&nbsp;client.getInputStream();&nbsp;&nbsp;//获取相应socket的输入流<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pw=new&nbsp;PrintWriter(client.getOutputStream(),true);<br>System.out.println(\"====开始接受客户端数据\");<br>&nbsp;&nbsp;&nbsp;&nbsp;//读取客户端输入的内容<br>int&nbsp;leng=0;<br>byte[]&nbsp;buf=new&nbsp;byte[1024];&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//1024长度的byte数组&nbsp;&nbsp;&nbsp;注意这个长度<br>String&nbsp;str=null;<br>/*String&nbsp;dly=\"\";*/<br>//循环读取客户端发送的数据<br>while((leng=iStream.read(buf))!=-1){&nbsp;&nbsp;&nbsp;//&nbsp;读取一定数量的字节，并将其存在buf[]中<br>&nbsp;&nbsp;Date&nbsp;now&nbsp;=&nbsp;new&nbsp;Date();<br>&nbsp;&nbsp;str=new&nbsp;String(buf);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//将buf转为字符串<br>&nbsp;&nbsp;System.out.println(\"client\");<br>&nbsp;&nbsp;System.out.println(str);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//检查接收到的内容<br>}<br>&nbsp;}catch&nbsp;(Exception&nbsp;e)&nbsp;{<br>//&nbsp;TODO&nbsp;Auto-generated&nbsp;catch&nbsp;block<br>e.printStackTrace();<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>}<br>}<br><br>class&nbsp;SendCmd&nbsp;implements&nbsp;Runnable{<br>private&nbsp;Socket&nbsp;client;<br><br>private&nbsp;int&nbsp;ppp;<br>&nbsp;&nbsp;&nbsp;&nbsp;public&nbsp;SendCmd()&nbsp;{<br><br>}<br>&nbsp;&nbsp;&nbsp;&nbsp;public&nbsp;SendCmd(Socket&nbsp;client,int&nbsp;ppp){<br>&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;this.client=client;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//指定client<br>&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;this.ppp&nbsp;=&nbsp;ppp;<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br>@Override<br>public&nbsp;void&nbsp;run()&nbsp;{<br>//&nbsp;TODO&nbsp;Auto-generated&nbsp;method&nbsp;stub<br>PrintWriter&nbsp;pw&nbsp;=&nbsp;null;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;try&nbsp;{<br>&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;while(true)&nbsp;{<br>&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;pw=new&nbsp;PrintWriter(client.getOutputStream(),true);<br>&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;pw.println(\"003153F7706F706A\");<br>/*	&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;if(ppp==1)&nbsp;{<br>&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;pw.println(\"003153F7706F706A\");<br>&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;ppp=0;<br>&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;}*/<br>&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;try&nbsp;{<br>Thread.sleep(3000);<br>}&nbsp;catch&nbsp;(InterruptedException&nbsp;e)&nbsp;{<br>//&nbsp;TODO&nbsp;Auto-generated&nbsp;catch&nbsp;block<br>e.printStackTrace();<br>}<br>&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;}<br>&nbsp;&nbsp;&nbsp;&nbsp;	<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}&nbsp;catch&nbsp;(IOException&nbsp;e)&nbsp;{<br>//&nbsp;TODO&nbsp;Auto-generated&nbsp;catch&nbsp;block<br>e.printStackTrace();<br>}<br>}<br>}<br><div marginwidth=\"0\" marginheight=\"0\" scrolling=\"no\" width=\"100%\"><div id=\"bd_ad_2\" style=\"text-align: center;\"><div id=\"_34kirvw4zfh\"></div></div></div></div></td></tr><tr><td valign=\"bottom\"><div><ul><li data-mod=\"popu_592\" class=\"csdn-tracking-statistics\"><a href=\"https://blog.csdn.net/yy304935305/article/details/52456771\" target=\"_blank\" title=\"Java多线程中static变量的使用\">Java多线程中static变量的使用</a></li></ul></div></td></tr></tbody></table>', '6', '0', 'java', 'sliver', '0', '2018-03-26 00:00:00', null, '111', '666');
INSERT INTO `post` VALUES ('809C332CE3C14684B0A7A27062DE4AC4', '5', '大家好，我是渣渣辉', '快来和我一起玩好玩的贪玩蓝月<img src=\"http://localhost:8080/ITbbs_web/js/layui/images/face/0.gif\" alt=\"[微笑]\">', '11', '0', '贪玩蓝月', 'sliver', '1', '2018-04-03 08:52:39', null, '0', '0');
INSERT INTO `post` VALUES ('8492755CEB1B4E5387CE54B46D669D95', '5', '9', '9', '6', '0', 'java', 'sliver', '0', '2018-03-23 00:00:00', null, '555', '666');
INSERT INTO `post` VALUES ('901084CB2EDC4B60A1B57185401D272D', '5', '7', '7', '6', '0', 'java', 'sliver', '1', '2018-03-07 00:00:00', null, '555', '666');
INSERT INTO `post` VALUES ('BE6D00D01E794FF9871434FE72CD56CC', '5', '2', '2', '6', '0', 'java', 'sliver', '0', '2018-03-23 00:00:00', null, '555', '666');
INSERT INTO `post` VALUES ('E6FA2F54EAA64CBF9CF7C0BC1F1AF39B', '5', '6', '6', '6', '0', 'java', 'sliver', '0', '2018-03-23 00:00:00', null, '555', '666');
INSERT INTO `post` VALUES ('F14DA88FF3204DA4AF0C4E17172AE7B4', '5', '1', '1', '6', '0', 'java', 'sliver', '1', '2018-03-23 00:00:00', null, '555', '666');
INSERT INTO `post` VALUES ('F3526C07ABE24ACAAA578C155A91B805', '5', 'java多线程 一个线程怎么监听另一个线程的变量', '<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" id=\"post-403125230\" class=\"post topic layui-table\" data-post-id=\"403125230\" data-is-topic-locked=\"false\"><tbody><tr><td valign=\"top\" class=\"post_info topic\" data-username=\"sinat_32487535\" data-floor=\"\"><div class=\"post_body\">&nbsp;我想设计一个基于socket的一对多的服务器，一方面，客户端定期的向服务端发送数据，另一方面，还需要在相应客户端对应的数据库中的数据发生了变化的时候让服务器对他们进行一个反向的通信（这个数据的变化与客户端本身无关，而是用户下达操作造成的数据变化）。<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;由此，我设想，建立三个线程，建立一个全局的变量，用于线程间的沟通。<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>&nbsp;&nbsp;&nbsp;线程一：实时得去检测数据库的变化，如果变化则改变全局变量.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;线程二：接收客户端的数据。<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;线程三：定时检测全局变量，如果全局变量的值变化了，再去查询数据库，根据实际情况去发送数据给客户端。</span><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;设想得很美，可是实际编写得时候我发现好像找不到在线程之间沟通得方法。<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;以下是我有关这个的代码，希望各位能帮我想想，该怎么写。<br>&nbsp;&nbsp;&nbsp;&nbsp;<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;如果用匿名类的方式去写线程，则能够传这个status进去，但是这样status就变成final了，如果照下面写，写类去实现线程，那参数status又不能实时得去传了。</span><br>怎么写啊？？？<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>public&nbsp;class&nbsp;Main&nbsp;{<br>//希望另外两个线程能够监测到status的变化<br>static&nbsp;int&nbsp;status;<br>public&nbsp;static&nbsp;void&nbsp;main(String[]&nbsp;args)&nbsp;throws&nbsp;IOException{<br>//匿名类的线程写法<br>Thread&nbsp;checkThread&nbsp;=&nbsp;new&nbsp;Thread(new&nbsp;Runnable()&nbsp;{<br>&nbsp;&nbsp;public&nbsp;void&nbsp;run()&nbsp;{<br>&nbsp;&nbsp;Connection&nbsp;conn&nbsp;=&nbsp;DBUtil.open();<br>&nbsp;&nbsp;String&nbsp;sql&nbsp;=&nbsp;\"select&nbsp;mac_id&nbsp;from&nbsp;machines&nbsp;where&nbsp;dataStatus=1\";<br>&nbsp;&nbsp;while(true)&nbsp;{<br>//查数据库,可以考虑封装<br>&nbsp;&nbsp;try&nbsp;{<br>PreparedStatement&nbsp;pstmt&nbsp;=&nbsp;conn.prepareStatement(sql);<br>ResultSet&nbsp;rs&nbsp;=&nbsp;pstmt.executeQuery();<br>//判断一次就够了&nbsp;不要用while<br>if(rs.next())&nbsp;{<br>status&nbsp;=&nbsp;1;<br>}<br><br>}&nbsp;catch&nbsp;(SQLException&nbsp;e)&nbsp;{<br>//&nbsp;TODO&nbsp;Auto-generated&nbsp;catch&nbsp;block<br>e.printStackTrace();<br>}<br>&nbsp;&nbsp;//两秒查一次<br>&nbsp;&nbsp;try&nbsp;{<br>Thread.sleep(2000);<br>}&nbsp;catch&nbsp;(InterruptedException&nbsp;e)&nbsp;{<br>//&nbsp;TODO&nbsp;Auto-generated&nbsp;catch&nbsp;block<br>e.printStackTrace();<br>}<br>&nbsp;&nbsp;}<br>&nbsp;&nbsp;}<br>});<br>checkThread.start();<br>//设置端口&nbsp;启动ServerSocket等待连接,初始化Socket<br>final&nbsp;int&nbsp;PORT&nbsp;=&nbsp;60000;<br>ServerSocket&nbsp;serverSocket&nbsp;=&nbsp;new&nbsp;ServerSocket(PORT);<br>Socket&nbsp;client&nbsp;=&nbsp;null;<br>/*一个定期检查数据库状态变量的线程+n对(每队两个)Socket收发线程*/<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;while(((client=serverSocket.accept())&nbsp;!=&nbsp;null))&nbsp;{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	System.out.println(client);<br>new&nbsp;Thread(new&nbsp;SendCmd(client,status)).start();&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	new&nbsp;Thread(new&nbsp;GetData(client)).start();<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>}<br><br>}<br><br>//接收数据线程&nbsp;<br>class&nbsp;GetData&nbsp;implements&nbsp;Runnable{<br>private&nbsp;Socket&nbsp;client;<br>&nbsp;&nbsp;&nbsp;&nbsp;public&nbsp;GetData()&nbsp;{<br><br>}<br>&nbsp;&nbsp;&nbsp;&nbsp;public&nbsp;GetData(Socket&nbsp;client){<br>&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;this.client=client;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//指定client<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br>@Override<br>public&nbsp;void&nbsp;run()&nbsp;{<br>//&nbsp;TODO&nbsp;Auto-generated&nbsp;method&nbsp;stub<br>&nbsp;InputStream&nbsp;iStream&nbsp;=&nbsp;null;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//初始化输入流<br>&nbsp;PrintWriter&nbsp;pw&nbsp;=null;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//初始化输出流<br>&nbsp;try&nbsp;{<br>iStream&nbsp;=&nbsp;client.getInputStream();&nbsp;&nbsp;//获取相应socket的输入流<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pw=new&nbsp;PrintWriter(client.getOutputStream(),true);<br>System.out.println(\"====开始接受客户端数据\");<br>&nbsp;&nbsp;&nbsp;&nbsp;//读取客户端输入的内容<br>int&nbsp;leng=0;<br>byte[]&nbsp;buf=new&nbsp;byte[1024];&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//1024长度的byte数组&nbsp;&nbsp;&nbsp;注意这个长度<br>String&nbsp;str=null;<br>/*String&nbsp;dly=\"\";*/<br>//循环读取客户端发送的数据<br>while((leng=iStream.read(buf))!=-1){&nbsp;&nbsp;&nbsp;//&nbsp;读取一定数量的字节，并将其存在buf[]中<br>&nbsp;&nbsp;Date&nbsp;now&nbsp;=&nbsp;new&nbsp;Date();<br>&nbsp;&nbsp;str=new&nbsp;String(buf);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//将buf转为字符串<br>&nbsp;&nbsp;System.out.println(\"client\");<br>&nbsp;&nbsp;System.out.println(str);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//检查接收到的内容<br>}<br>&nbsp;}catch&nbsp;(Exception&nbsp;e)&nbsp;{<br>//&nbsp;TODO&nbsp;Auto-generated&nbsp;catch&nbsp;block<br>e.printStackTrace();<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>}<br>}<br><br>class&nbsp;SendCmd&nbsp;implements&nbsp;Runnable{<br>private&nbsp;Socket&nbsp;client;<br><br>private&nbsp;int&nbsp;ppp;<br>&nbsp;&nbsp;&nbsp;&nbsp;public&nbsp;SendCmd()&nbsp;{<br><br>}<br>&nbsp;&nbsp;&nbsp;&nbsp;public&nbsp;SendCmd(Socket&nbsp;client,int&nbsp;ppp){<br>&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;this.client=client;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//指定client<br>&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;this.ppp&nbsp;=&nbsp;ppp;<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br>@Override<br>public&nbsp;void&nbsp;run()&nbsp;{<br>//&nbsp;TODO&nbsp;Auto-generated&nbsp;method&nbsp;stub<br>PrintWriter&nbsp;pw&nbsp;=&nbsp;null;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;try&nbsp;{<br>&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;while(true)&nbsp;{<br>&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;pw=new&nbsp;PrintWriter(client.getOutputStream(),true);<br>&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;pw.println(\"003153F7706F706A\");<br>/*	&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;if(ppp==1)&nbsp;{<br>&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;pw.println(\"003153F7706F706A\");<br>&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;ppp=0;<br>&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;}*/<br>&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;try&nbsp;{<br>Thread.sleep(3000);<br>}&nbsp;catch&nbsp;(InterruptedException&nbsp;e)&nbsp;{<br>//&nbsp;TODO&nbsp;Auto-generated&nbsp;catch&nbsp;block<br>e.printStackTrace();<br>}<br>&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;}<br>&nbsp;&nbsp;&nbsp;&nbsp;	<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}&nbsp;catch&nbsp;(IOException&nbsp;e)&nbsp;{<br>//&nbsp;TODO&nbsp;Auto-generated&nbsp;catch&nbsp;block<br>e.printStackTrace();<br>}<br>}<br>}<br><div marginwidth=\"0\" marginheight=\"0\" scrolling=\"no\" width=\"100%\"><div id=\"bd_ad_2\" style=\"text-align: center;\"><div id=\"_34kirvw4zfh\"></div></div></div></div></td></tr><tr><td valign=\"bottom\"><div><ul><li data-mod=\"popu_592\" class=\"csdn-tracking-statistics\"><a href=\"https://blog.csdn.net/yy304935305/article/details/52456771\" target=\"_blank\" title=\"Java多线程中static变量的使用\">Java多线程中static变量的使用</a></li></ul></div></td></tr></tbody></table>', '6', '0', 'java', 'sliver', '0', '2018-03-26 00:00:00', null, '3', '666');
INSERT INTO `post` VALUES ('F8924271FE64436EA95A963DCB529DFF', '5', '流下了不学无术的泪水——今天你刷题了吗（一）', '<p class=\"p1\" style=\"text-align: justify;\"><span>工作以后，你有多久没有做算法题了，反正班克我是工作一年了，然后一年没做算法题了。</span></p><p class=\"p1\" style=\"text-align: justify;\"><span><br></span></p><p style=\"text-align: center;\"><img class=\"__bg_gif\" src=\"http://ss.csdn.net/p?http://mmbiz.qpic.cn/mmbiz_gif/1hReHaqafadTHak57Yy3h87FN6gwyZRTEmzQmqubWA3o55aQAUICEBhYKyNIR429O3HB1tPEd4yribHL2djVw4w/640?wx_fmt=gif&amp;wxfrom=5&amp;wx_lazy=1\" alt=\"640?wx_fmt=gif&amp;wxfrom=5&amp;wx_lazy=1\"></p><p style=\"text-align: center;\"><br></p><p class=\"p1\" style=\"text-align: justify;\"><span>但是班克我是一个积极向上、热爱学习的程序员啊！作为一个标杆一般的人物，怎么能停止学习的脚步呢！！！</span></p><p class=\"p1\" style=\"text-align: justify;\"><span></span></p><p style=\"text-align: center;\"><img class=\"__bg_gif\" src=\"http://ss.csdn.net/p?http://mmbiz.qpic.cn/mmbiz_gif/1hReHaqafadTHak57Yy3h87FN6gwyZRTkERXvKa1DTlhoRc8OrdrKxODOKVoiaGE46L4giczxTSTNncql5UFZPgw/640?wx_fmt=gif&amp;wxfrom=5&amp;wx_lazy=1\" alt=\"640?wx_fmt=gif&amp;wxfrom=5&amp;wx_lazy=1\"></p><p class=\"p1\" style=\"text-align: justify;\"><span></span><br></p><p class=\"p1\" style=\"text-align: justify;\"><span>本来帅气的班克童鞋是准备一个人关起房门来偷偷学习的。然鹅，没有本来，你以为小班克和那些自私的小婊砸一样吗？不，我们不一样！！</span></p><p class=\"p2\" style=\"text-align: justify;\"><span>&nbsp;</span></p><p class=\"p1\" style=\"text-align: justify;\"><span>所以今天小班克来到了这里，想必任何在座的各位牛逼的程序员，一定都知道LeetCode这个网站，但我还是得和某些不知道的同学普及下知识。LeetCode是一款在线刷题的网站，在LeetCode上有很多程序相关的面试题，如果每一道题都能做出来，对大家面试大公司会很有帮助，如果你已经进入了大公司，那对你程序思维的锻炼也很有帮助。总之，就是对我们很有帮助！</span></p><p class=\"p2\" style=\"text-align: justify;\"><br></p><p class=\"p3\" style=\"text-align: justify;\"><span>以后小班克会在每一期的结尾，公布一道LeetCode上面的题目，嫌小班克公布慢的也可以自己登陆LeetCode网站自行刷题。然后在下一期的时候，小班克会给出题目的解题过程。小班克给出的解题过程仅是自己的解题过程，如果有什么不对的地方，欢迎大家来指正交流（撕逼）~</span></p><p class=\"p3\" style=\"text-align: justify;\"><span><br></span></p><p style=\"text-align: center;\"><img class=\"img_loading __bg_gif\" src=\"http://ss.csdn.net/p?https://mmbiz.qpic.cn/mmbiz_gif/1hReHaqafadTHak57Yy3h87FN6gwyZRTNqBGfjseMnd5hibyC8qQUJUF7ftAMA6smia1nMtjWry4ibHfO58wDXVMg/640?wx_fmt=gif\" alt=\"640?wx_fmt=gif\"></p><p style=\"text-align: center;\"><br></p><p class=\"p5\" style=\"text-align: justify;\"><span>今天第一期，正好LeetCode第一道题目比较简单，我相信在座的各位大佬应该不用浪费时间做这道题，我就直接给出答案了。</span></p><p class=\"p6\" style=\"text-align: justify;\"><span><br></span></p><p class=\"p7\" style=\"text-align: justify;\"><span><span>题目如下：</span></span></p><p style=\"text-align: justify;\"><img class=\"img_loading\" src=\"http://ss.csdn.net/p?https://mmbiz.qpic.cn/mmbiz_png/1hReHaqafadTHak57Yy3h87FN6gwyZRTOJLnbvshXP1GXRDugdEYDdB7KOrmMeTQStgrbeDMibdOh0TH5B3M42A/640?wx_fmt=png\" alt=\"640?wx_fmt=png\"></p><p class=\"p8\" style=\"text-align: justify;\"><span><br></span></p><p class=\"p9\" style=\"text-align: justify;\"><span><span>翻译过来就是：</span>给你一个整型数组，需要你返回两个数，这两个数相加等于一个指定的数。</span></p><p class=\"p9\" style=\"text-align: justify;\"><span>你必须保证每一个输入的数组都有且只有一个确定的解。</span></p><p class=\"p10\" style=\"text-align: justify;\"><span><br></span></p><p class=\"p7\" style=\"text-align: justify;\"><span><span>解题过程：</span></span></p><p class=\"p9\" style=\"text-align: justify;\"><span>解题思路如下：使用最笨的方法（小班克算法比较薄弱，暂时只能想到这个蠢方法），用两个循环嵌套，将这个数组中所有的组合都测试一遍，直到最后得到正确的答案为止。代码比较简单，就不作过多的解释了，直接贴出班克的代码：</span></p><p class=\"p9\" style=\"text-align: justify;\"><span><br></span></p><pre><code class=\"hljs-default\"><span class=\"hljs-default-keyword\">public</span>&nbsp;<span class=\"hljs-default-keyword\">class</span>&nbsp;<span class=\"hljs-default-title\">Solution</span>&nbsp;<br>{<br>&nbsp; &nbsp;<span class=\"hljs-default-function\"><span class=\"hljs-default-keyword\">public</span>&nbsp;<span class=\"hljs-default-keyword\">int</span>[]&nbsp;<span class=\"hljs-default-title\">TwoSum</span>(<span class=\"hljs-default-params\"><span class=\"hljs-default-keyword\">int</span>[] nums,&nbsp;<span class=\"hljs-default-keyword\">int</span>&nbsp;target</span>)&nbsp;<br>&nbsp; &nbsp;</span>{<br>&nbsp; &nbsp; &nbsp; &nbsp;<span class=\"hljs-default-keyword\">for</span>(<span class=\"hljs-default-keyword\">int</span>&nbsp;i =&nbsp;<span class=\"hljs-default-number\">0</span>; i &lt; nums.Length; i++)<br>&nbsp; &nbsp; &nbsp; &nbsp;{<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<span class=\"hljs-default-keyword\">for</span>(<span class=\"hljs-default-keyword\">int</span>&nbsp;j = i +&nbsp;<span class=\"hljs-default-number\">1</span>; j &lt; nums.Length; j ++)<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;{<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<span class=\"hljs-default-keyword\">if</span>(nums[i] + nums[j] == target)<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;{<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<span class=\"hljs-default-keyword\">int</span>[] returnValue =&nbsp;<span class=\"hljs-default-keyword\">new</span>&nbsp;<span class=\"hljs-default-keyword\">int</span>[<span class=\"hljs-default-number\">2</span>]{i, j};<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<span class=\"hljs-default-keyword\">return</span>&nbsp;returnValue;<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>&nbsp; &nbsp; &nbsp; &nbsp;}<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<span class=\"hljs-default-keyword\">return</span>&nbsp;<span class=\"hljs-default-literal\">null</span>;<br>&nbsp; &nbsp;}<br>}</code></pre><p class=\"p8\" style=\"text-align: justify;\"><span><br></span></p><p class=\"p12\" style=\"text-align: justify;\"><span><span>时间复杂度：</span>O(n^2)。这个应该不用解释了吧= =</span></p><p class=\"p13\" style=\"text-align: justify;\"><span><span>空间复杂度：</span>O(1)。</span></p><p class=\"p14\" style=\"text-align: justify;\"><span><br></span></p><p class=\"p15\" style=\"text-align: justify;\"><span>什么是空间复杂度呢？鉴于可能很多小朋友都忘了这些基础知识（其实是小班克我忘了）。让我们来看看百度的解答：</span></p><p class=\"p15\" style=\"text-align: justify;\"><span><br></span></p><p style=\"text-align: justify;\"><img class=\"img_loading\" src=\"http://ss.csdn.net/p?https://mmbiz.qpic.cn/mmbiz_png/1hReHaqafadTHak57Yy3h87FN6gwyZRTbWQJ04YEyMia5MdLNoEtiaT3xPWTsZmnU3ibZMgmouDRVAq7WiaEicBpYrA/640?wx_fmt=png\" alt=\"640?wx_fmt=png\"></p><p class=\"p1\" style=\"text-align: justify;\"><span><br></span></p><p class=\"p1\" style=\"text-align: justify;\"><span>看完之后我的表情如下图（强调一下，小班克没有他黑）：</span></p><p class=\"p16\" style=\"text-align: justify;\"><span>&nbsp;</span></p><p class=\"p1\" style=\"text-align: justify;\"><span>小班克我在仔(bai)细(du)思(yi)考(xia)之后，做出了如下的解释：它是对一个算法在运行过程中临时占用存储空间大小的量度。所以它强调的是使用的辅助空间的的大小，而不是指所有的数据所占用的空间。我觉得简单来解释，就是所要创建的临时变量的个数。我们这里就创建了一个临时变量（int[] returnValue），所以是O（1）。下面我再举一个O(N)的例子，我们看如下代码。</span></p><p class=\"p1\" style=\"text-align: justify;\"><span></span></p><p style=\"text-align: justify;\"><img class=\"img_loading\" src=\"http://ss.csdn.net/p?https://mmbiz.qpic.cn/mmbiz_png/1hReHaqafadTHak57Yy3h87FN6gwyZRTI0ejGrXJds1icBAnHSMRxZe7foMaAjc6r6jMLwibv9qsEflEhJ2ZamUA/640?wx_fmt=png\" alt=\"640?wx_fmt=png\"></p><p class=\"p1\" style=\"text-align: justify;\"><span>&nbsp;</span><span></span></p><p class=\"p1\" style=\"text-align: justify;\"><span>很明显，这是斐波那契数列，针对这种递归的算法，我们可以看出来每一次递归都会创建一个ptr，这个函数一共执行n-1次，因此开辟了n-1个临时变量，去掉常量，所以这个函数的时间复杂度为O(n)，这回大家应该明白了吧。</span></p><p class=\"p8\" style=\"text-align: justify;\"><span><br></span></p><p class=\"p9\" style=\"text-align: justify;\"><span>那么我们再回到这个问题，这个问题除了我这种笨笨的解决方案还有没有其他高大上的解决方案呢？那当然是有的啦！</span></p><p class=\"p8\" style=\"text-align: justify;\"><span><br></span></p><p class=\"p9\" style=\"text-align: justify;\"><span>官方还给出了另外两种解决方案。</span></p><p class=\"p8\" style=\"text-align: justify;\"><span><br></span></p><p class=\"p17\" style=\"text-align: justify;\"><span><span>附加方案一：</span></span></p><p class=\"p17\" style=\"text-align: justify;\"><span><span><br></span></span></p><pre><code class=\"hljs-default\"><span class=\"hljs-default-keyword\">public</span>&nbsp;<span class=\"hljs-default-keyword\">int</span>[] twoSum(<span class=\"hljs-default-keyword\">int</span>[] nums,&nbsp;<span class=\"hljs-default-keyword\">int</span>&nbsp;target) {<br>&nbsp; &nbsp;Map&lt;Integer, Integer&gt;&nbsp;<span class=\"hljs-default-built_in\">map</span>&nbsp;=&nbsp;<span class=\"hljs-default-keyword\">new</span>&nbsp;HashMap&lt;&gt;();<br>&nbsp; &nbsp;<span class=\"hljs-default-keyword\">for</span>&nbsp;(<span class=\"hljs-default-keyword\">int</span>&nbsp;i =&nbsp;<span class=\"hljs-default-number\">0</span>; i &lt; nums.length; i++) {<br>&nbsp; &nbsp; &nbsp; &nbsp;<span class=\"hljs-default-built_in\">map</span>.put(nums[i], i);<br>&nbsp; &nbsp;}<br>&nbsp; &nbsp;<span class=\"hljs-default-keyword\">for</span>&nbsp;(<span class=\"hljs-default-keyword\">int</span>&nbsp;i =&nbsp;<span class=\"hljs-default-number\">0</span>; i &lt; nums.length; i++) {<br>&nbsp; &nbsp; &nbsp; &nbsp;<span class=\"hljs-default-keyword\">int</span>&nbsp;complement = target - nums[i];<br>&nbsp; &nbsp; &nbsp; &nbsp;<span class=\"hljs-default-keyword\">if</span>&nbsp;(<span class=\"hljs-default-built_in\">map</span>.containsKey(complement) &amp;&amp;&nbsp;<span class=\"hljs-default-built_in\">map</span>.get(complement) != i) {<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<span class=\"hljs-default-keyword\">return</span>&nbsp;<span class=\"hljs-default-keyword\">new</span>&nbsp;<span class=\"hljs-default-keyword\">int</span>[] { i,&nbsp;<span class=\"hljs-default-built_in\">map</span>.get(complement) };<br>&nbsp; &nbsp; &nbsp; &nbsp;}<br>&nbsp; &nbsp;}<br><span class=\"hljs-default-keyword\">throw</span>&nbsp;<span class=\"hljs-default-keyword\">new</span>&nbsp;IllegalArgumentException(<span class=\"hljs-default-string\">\"No two sum solution\"</span>);}</code></pre><p class=\"p20\" style=\"text-align: justify;\"><span><span><br></span></span></p><p class=\"p20\" style=\"text-align: justify;\"><span><span>解题思路：</span>这个方案通过增加临时空间复杂度的方式，来降低时间复杂度，先将数组存入哈希表中，然后用哈希表代替了原来的For循环的查找方式，将查找的时间复杂度由O(n)降低到了O(1)。别问我为什么哈希表的查找的时间复杂度是O(1)，不知道的请自行百度。</span></p><p class=\"p21\" style=\"text-align: justify;\"><span><span>时间复杂度：</span>O(n)。</span></p><p class=\"p20\" style=\"text-align: justify;\"><span><span>空间复杂度：</span>O(n)。从算法中我们可以看到开辟了n临时空间。</span></p><p class=\"p8\" style=\"text-align: justify;\"><span><br></span></p><p class=\"p17\" style=\"text-align: justify;\"><span><span>附加方案二：</span></span></p><p class=\"p17\" style=\"text-align: justify;\"><span><span><br></span></span></p><pre><code class=\"hljs-default\"><span class=\"hljs-default-keyword\">public</span>&nbsp;<span class=\"hljs-default-keyword\">int</span>[] twoSum(<span class=\"hljs-default-keyword\">int</span>[] nums,&nbsp;<span class=\"hljs-default-keyword\">int</span>&nbsp;target) {<br>&nbsp; &nbsp;Map&lt;Integer, Integer&gt;&nbsp;<span class=\"hljs-default-built_in\">map</span>&nbsp;=&nbsp;<span class=\"hljs-default-keyword\">new</span>&nbsp;HashMap&lt;&gt;();<br>&nbsp; &nbsp;<span class=\"hljs-default-keyword\">for</span>&nbsp;(<span class=\"hljs-default-keyword\">int</span>&nbsp;i =&nbsp;<span class=\"hljs-default-number\">0</span>; i &lt; nums.length; i++) {<br>&nbsp; &nbsp; &nbsp; &nbsp;<span class=\"hljs-default-keyword\">int</span>&nbsp;complement = target - nums[i];<br>&nbsp; &nbsp; &nbsp; &nbsp;<span class=\"hljs-default-keyword\">if</span>&nbsp;(<span class=\"hljs-default-built_in\">map</span>.containsKey(complement)) {<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<span class=\"hljs-default-keyword\">return</span>&nbsp;<span class=\"hljs-default-keyword\">new</span>&nbsp;<span class=\"hljs-default-keyword\">int</span>[] {&nbsp;<span class=\"hljs-default-built_in\">map</span>.get(complement), i };<br>&nbsp; &nbsp; &nbsp; &nbsp;}<br>&nbsp; &nbsp; &nbsp; &nbsp;<span class=\"hljs-default-built_in\">map</span>.put(nums[i], i);<br>&nbsp; &nbsp;}<br>&nbsp; &nbsp;<span class=\"hljs-default-keyword\">throw</span>&nbsp;<span class=\"hljs-default-keyword\">new</span>&nbsp;IllegalArgumentException(<span class=\"hljs-default-string\">\"No two sum solution\"</span>);}</code></pre><p class=\"p8\" style=\"text-align: justify;\"><span><br></span></p><p class=\"p9\" style=\"text-align: justify;\"><span><span>解题思路：</span>这个解题方案和上一个很向，差别在于，他没有一开始就将数组中所有的数都存入哈希表中，而是通过遍历数组，将数组中不满足条件的整数按照遍历顺序依次存入哈希表中。具体过程如下图：</span></p><p class=\"p9\" style=\"text-align: justify;\"><span></span></p><p style=\"text-align: justify;\"><img class=\"img_loading\" src=\"http://ss.csdn.net/p?https://mmbiz.qpic.cn/mmbiz_png/1hReHaqafadTHak57Yy3h87FN6gwyZRTcuKzaDWM7icKec3oxG45iaygkAYjKibgl7EibJD4HAc4LkGibX6G7MCIh9w/640?wx_fmt=png\" alt=\"640?wx_fmt=png\"></p><p class=\"p9\" style=\"text-align: justify;\"><span></span><br></p><p class=\"p9\" style=\"text-align: justify;\"><span>第一轮检查，发现哈希表中没有数和2相加等于9，所以将2存入哈希表中。</span></p><p class=\"p9\" style=\"text-align: justify;\"><span>第二轮检查，得出答案。</span></p><p class=\"p17\" style=\"text-align: justify;\"><span><span>时间复杂度：</span>O(n)。</span></p><p class=\"p9\" style=\"text-align: justify;\"><span><span>空间复杂度：</span>O(n)。从程序中，我们可以看出最多创建n个临时空间。</span></p><p class=\"p8\" style=\"text-align: justify;\"><span><br></span></p><p class=\"p1\" style=\"text-align: justify;\"><span>没想到第一题这么简单的一道题，就写了这么多，想来可能是小班克我有点啰嗦了（也有可能是我太菜了哈哈~）。</span></p><div><span><br></span></div>', '6', '0', 'java', 'sliver', '0', '2018-03-25 00:00:00', null, '3', '666');

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
  CONSTRAINT `FK_reply_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of post_reply
-- ----------------------------
INSERT INTO `post_reply` VALUES ('7762BC0770174B5C91B4B3941726F1EC', '5', '我是李大狗<img src=\"/ITbbs_web/upload/img/625/1522628190129411.jpg\" alt=\"1522628190129411\">', '2018-04-02 08:18:18', '0', 'sliver', '047521BEC9BD46D2A3EE0EC0E7DBCF32');
INSERT INTO `post_reply` VALUES ('7762BC0770174B5C91B4B3941726F1EC', '5', '测试清空富文本框', '2018-04-02 08:26:11', '0', 'sliver', '31E2FD63E892496996050E137F047E77');
INSERT INTO `post_reply` VALUES ('7762BC0770174B5C91B4B3941726F1EC', '5', 'test', '2018-04-02 08:18:29', '0', 'sliver', '322B9405953A4E05A0EED7257053F981');
INSERT INTO `post_reply` VALUES ('7762BC0770174B5C91B4B3941726F1EC', '5', '你好，渣渣辉，我是秦始皇<img src=\"http://localhost:8080/ITbbs_web/js/layui/images/face/20.gif\" alt=\"[嘘]\">', '2018-04-02 08:15:28', '0', 'sliver', '522C50D8BD8549F5A188E04F68C5FB2A');
INSERT INTO `post_reply` VALUES ('7762BC0770174B5C91B4B3941726F1EC', '5', '我是李大狗<img src=\"/ITbbs_web/upload/img/625/1522628190129411.jpg\" alt=\"1522628190129411\">', '2018-04-02 08:16:32', '0', 'sliver', '69D98824990C4E69B50C4B3E145C95AD');
INSERT INTO `post_reply` VALUES ('7762BC0770174B5C91B4B3941726F1EC', '5', '哈哈', '2018-04-02 08:20:01', '0', 'sliver', '9E1C13BAD7E645E89033A20225F2392B');
INSERT INTO `post_reply` VALUES ('7762BC0770174B5C91B4B3941726F1EC', '5', '我是张无忌<img src=\"http://localhost:8080/ITbbs_web/js/layui/images/face/36.gif\" alt=\"[酷]\">', '2018-04-02 08:12:07', '0', 'sliver', 'C533F07EB4C741CBBB80867535EEE5CF');
INSERT INTO `post_reply` VALUES ('7762BC0770174B5C91B4B3941726F1EC', '5', '我是王大锤<img src=\"http://localhost:8080/ITbbs_web/js/layui/images/face/5.gif\" alt=\"[挖鼻]\">', '2018-03-31 20:23:03', '0', 'sliver', 'C8CF82462DC846218EB49EAD1D7CF466');
INSERT INTO `post_reply` VALUES ('7762BC0770174B5C91B4B3941726F1EC', '5', '你好，我是你大爷<img src=\"http://localhost:8080/ITbbs_web/js/layui/images/face/0.gif\" alt=\"[微笑]\">', '2018-03-31 20:30:44', '0', 'sliver', 'D061227528C5467D8975BDE2E10EAEBB');
INSERT INTO `post_reply` VALUES ('7762BC0770174B5C91B4B3941726F1EC', '5', '再来一次', '2018-04-02 08:20:24', '0', 'sliver', 'F1C331B59D774FBEBEABDC62F89C4A93');

-- ----------------------------
-- Table structure for `public_info`
-- ----------------------------
DROP TABLE IF EXISTS `public_info`;
CREATE TABLE `public_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `content` varchar(1024) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `altertime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of public_info
-- ----------------------------
INSERT INTO `public_info` VALUES ('1', '公共信息发布测试', '发布公共信息', '2018-04-08 17:15:44', null);
INSERT INTO `public_info` VALUES ('2', '阿萨德', '<b><i><strike>阿萨德</strike></i></b>', '2018-04-08 17:19:39', null);

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
INSERT INTO `question` VALUES ('68BF56C9A1AF497CA927A25E44F81AE9', '5', '12', 'sadasd', '50', '2018-03-24 00:00:00', '0', '5C94619A5A4E4D2789845B7D218119EF', 'sliver', '2018-04-08 00:00:00');
INSERT INTO `question` VALUES ('A2B772F104C74DA9B3C962A3851363BD', '5', '问题测试', '提问', '3', '2018-04-03 09:28:47', '1', '366B8DBE19D246BE89B52CB0548B1F62', 'sliver', null);

-- ----------------------------
-- Table structure for `score_log`
-- ----------------------------
DROP TABLE IF EXISTS `score_log`;
CREATE TABLE `score_log` (
  `id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `content` varchar(520) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `score` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of score_log
-- ----------------------------
INSERT INTO `score_log` VALUES ('245371E33AA54F1E95C4F65F16E72634', '4', '下载文件tt.zip', '-5');
INSERT INTO `score_log` VALUES ('370B65D929C546FBAC30A821B7E6CB28', '5', '其他用户下载文件111.zip', '1');
INSERT INTO `score_log` VALUES ('6255C6C47DD54A90A5181117B6F0BCED', '5', '其他用户下载文件111.zip', '1');
INSERT INTO `score_log` VALUES ('6B4CF9BA0DE9409C9C66674E4B74A559', '4', '下载文件111.zip', '-1');
INSERT INTO `score_log` VALUES ('75176EEFBA014A0980BCA850AE8F7030', '4', '下载文件111.zip', '-1');
INSERT INTO `score_log` VALUES ('FBE509F486E44EFFB6AC12CB538BAF25', '5', '其他用户下载文件tt.zip', '5');

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
  `age` int(11) DEFAULT NULL,
  `pic` varchar(1024) DEFAULT NULL,
  `phone` char(11) DEFAULT NULL,
  `qq` char(12) DEFAULT NULL,
  `wechat` varchar(255) DEFAULT NULL,
  `note` varchar(1024) DEFAULT NULL,
  `post_num` int(11) DEFAULT '0',
  `question_num` int(11) DEFAULT '0',
  `answer_num` int(11) DEFAULT '0',
  `score` int(11) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  `createtime` datetime DEFAULT NULL,
  `alterime` datetime DEFAULT NULL,
  `secrecy` tinyint(1) DEFAULT '0' COMMENT '0 公开， 1 保密',
  `is_board_ower` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('4', 'admin', '2', '9C9214835AECA0864B367C193E9C3C13', 'admin@sliver.com', null, null, null, null, 'images/touxiang.jpg', null, null, null, null, '10', '0', '0', '3', '0', '2018-03-15 00:00:00', '2018-04-08 15:25:46', '0', '0');
INSERT INTO `user` VALUES ('5', 'sliver', '1', '6D3BA6352BC70A0A84F8D2486DDDE2A9', 't2@sliver.com', '渣渣辉2号', '男', '1993-08-02', '19', '/ITbbs_web/upload/img/906/1522027977802204.jpg', '10086', '1234565478', 'm12346789', '大扎好，我四渣渣辉，XXXX，介四里没有挽过的船新版本，挤需体验三番钟，里造会干我一样，爱象节款游戏！', '557', '556', '555', '559', '0', '2018-03-16 00:00:00', '2018-04-08 15:25:46', '0', '0');
INSERT INTO `user` VALUES ('6', 'test', '0', 'F99980C0C0275DF135F57E21FDFAEDF0', 't2@sliver.com', null, null, null, null, 'touxiang.jpg', null, null, null, null, '0', '0', '0', '0', '0', '2018-03-28 09:48:56', '2018-03-28 09:48:56', null, null);
INSERT INTO `user` VALUES ('7', 't1', '1', '1', '1', '未填写姓名', '男', '未填写生日', null, null, null, null, null, null, '666', '0', '0', '0', '0', '2018-03-29 08:28:40', '2018-03-30 15:43:11', '0', '0');
INSERT INTO `user` VALUES ('8', 't2', '1', '1', '2', '未填写姓名', '男', '未填写生日', null, null, null, null, null, null, '666', '0', '0', '0', '0', '2018-03-29 08:28:43', '2018-03-30 15:38:42', '0', '0');
INSERT INTO `user` VALUES ('9', 't3', '1', '1', '2', '未填写姓名', '男', '未填写生日', null, null, null, null, null, null, '666', '0', '0', '0', '0', '2018-03-29 08:28:47', '2018-03-30 11:01:13', '0', '0');
INSERT INTO `user` VALUES ('10', 't4', '0', '1', '12', '未填写姓名', '男', '未填写生日', null, null, null, null, null, null, '666', '0', '0', '0', '0', '2018-03-29 08:28:50', '2018-03-30 16:04:40', '0', '0');
INSERT INTO `user` VALUES ('11', 't5', '0', '0', '12', '未填写姓名', '男', '未填写生日', null, null, null, null, null, null, '666', '0', '0', '0', '0', '2018-03-29 08:28:52', '2018-03-30 15:45:30', '0', '0');

-- ----------------------------
-- View structure for `answer_vo`
-- ----------------------------
DROP VIEW IF EXISTS `answer_vo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `answer_vo` AS select `user`.`username` AS `username`,`answer`.`id` AS `id`,`answer`.`user_id` AS `user_id`,`answer`.`question_id` AS `question_id`,`answer`.`content` AS `content`,`answer`.`createtime` AS `createtime`,`user`.`pic` AS `pic` from (`answer` join `user`) where (`answer`.`user_id` = `user`.`id`) ;

-- ----------------------------
-- View structure for `favorite_vo`
-- ----------------------------
DROP VIEW IF EXISTS `favorite_vo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `favorite_vo` AS select `favorite`.`id` AS `id`,`post`.`createtime` AS `createtime`,`post`.`view_num` AS `view_num`,`post`.`reply_num` AS `reply_num`,`post`.`user_name` AS `user_name`,`post`.`board_name` AS `board_name`,`post`.`title` AS `title`,`post`.`user_id` AS `user_id`,`favorite`.`createtime` AS `favorite_time`,`favorite`.`post_id` AS `post_id` from (`post` join `favorite`) where (`post`.`id` = `favorite`.`post_id`) order by `favorite`.`createtime` desc ;

-- ----------------------------
-- View structure for `post_reply_vo`
-- ----------------------------
DROP VIEW IF EXISTS `post_reply_vo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `post_reply_vo` AS select `post_reply`.`createtime` AS `createtime`,`post_reply`.`id` AS `id`,`post_reply`.`user_id` AS `user_id`,`post_reply`.`content` AS `content`,`post_reply`.`post_id` AS `post_id`,`user`.`username` AS `username`,`user`.`post_num` AS `post_num`,`user`.`pic` AS `pic` from (`post_reply` join `user`) where (`user`.`id` = `post_reply`.`user_id`) ;

-- ----------------------------
-- View structure for `question_vo`
-- ----------------------------
DROP VIEW IF EXISTS `question_vo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `question_vo` AS select `question`.`id` AS `id`,`question`.`user_id` AS `question_user_id`,`question`.`title` AS `title`,`question`.`content` AS `question`,`question`.`pay_score` AS `pay_score`,`question`.`createtime` AS `createtime`,`question`.`deleted` AS `deleted`,`question`.`useful_answer_id` AS `useful_answer_id`,`question`.`ack_answer_time` AS `ack_answer_time`,`user`.`username` AS `username`,`user`.`pic` AS `pic` from (`question` join `user`) where (`question`.`user_id` = `user`.`id`) ;
