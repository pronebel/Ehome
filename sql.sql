/*
Navicat MySQL Data Transfer

Source Server         : docker-mysql
Source Server Version : 50718
Source Host           : 10.100.19.101:3306
Source Database       : ehome

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2018-04-27 14:42:26
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `alembic_version`
-- ----------------------------
DROP TABLE IF EXISTS `alembic_version`;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of alembic_version
-- ----------------------------
INSERT INTO `alembic_version` VALUES ('4127ebe4c488');

-- ----------------------------
-- Table structure for `ih_area_info`
-- ----------------------------
DROP TABLE IF EXISTS `ih_area_info`;
CREATE TABLE `ih_area_info` (
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ih_area_info
-- ----------------------------
INSERT INTO `ih_area_info` VALUES (null, null, '1', '上海');
INSERT INTO `ih_area_info` VALUES (null, null, '2', '南京');

-- ----------------------------
-- Table structure for `ih_facility_info`
-- ----------------------------
DROP TABLE IF EXISTS `ih_facility_info`;
CREATE TABLE `ih_facility_info` (
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ih_facility_info
-- ----------------------------

-- ----------------------------
-- Table structure for `ih_house_facility`
-- ----------------------------
DROP TABLE IF EXISTS `ih_house_facility`;
CREATE TABLE `ih_house_facility` (
  `house_id` int(11) NOT NULL,
  `facility_id` int(11) NOT NULL,
  PRIMARY KEY (`house_id`,`facility_id`),
  KEY `facility_id` (`facility_id`),
  CONSTRAINT `ih_house_facility_ibfk_1` FOREIGN KEY (`facility_id`) REFERENCES `ih_facility_info` (`id`),
  CONSTRAINT `ih_house_facility_ibfk_2` FOREIGN KEY (`house_id`) REFERENCES `ih_house_info` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ih_house_facility
-- ----------------------------

-- ----------------------------
-- Table structure for `ih_house_image`
-- ----------------------------
DROP TABLE IF EXISTS `ih_house_image`;
CREATE TABLE `ih_house_image` (
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `house_id` int(11) NOT NULL,
  `url` varchar(256) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `house_id` (`house_id`),
  CONSTRAINT `ih_house_image_ibfk_1` FOREIGN KEY (`house_id`) REFERENCES `ih_house_info` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ih_house_image
-- ----------------------------
INSERT INTO `ih_house_image` VALUES ('2018-04-27 13:52:02', '2018-04-27 13:52:02', '1', '1', 'Fv20HB1adWNtCLgvoAAcNFB1Agbd');

-- ----------------------------
-- Table structure for `ih_house_info`
-- ----------------------------
DROP TABLE IF EXISTS `ih_house_info`;
CREATE TABLE `ih_house_info` (
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `area_id` int(11) NOT NULL,
  `title` varchar(64) NOT NULL,
  `price` int(11) DEFAULT NULL,
  `address` varchar(512) DEFAULT NULL,
  `room_count` int(11) DEFAULT NULL,
  `acreage` int(11) DEFAULT NULL,
  `unit` varchar(32) DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  `beds` varchar(64) DEFAULT NULL,
  `deposit` int(11) DEFAULT NULL,
  `min_days` int(11) DEFAULT NULL,
  `max_days` int(11) DEFAULT NULL,
  `order_count` int(11) DEFAULT NULL,
  `index_image_url` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `area_id` (`area_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `ih_house_info_ibfk_1` FOREIGN KEY (`area_id`) REFERENCES `ih_area_info` (`id`),
  CONSTRAINT `ih_house_info_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `ih_user_profile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ih_house_info
-- ----------------------------
INSERT INTO `ih_house_info` VALUES ('2018-04-27 13:51:45', '2018-04-27 13:52:02', '1', '2', '1', '上海别墅', '1000000', '特色她', '2', '111', '五十把听', '3', '2张', '11100', '1', '0', '0', 'Fv20HB1adWNtCLgvoAAcNFB1Agbd');

-- ----------------------------
-- Table structure for `ih_order_info`
-- ----------------------------
DROP TABLE IF EXISTS `ih_order_info`;
CREATE TABLE `ih_order_info` (
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `house_id` int(11) NOT NULL,
  `begin_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `days` int(11) NOT NULL,
  `house_price` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `status` enum('WAIT_ACCEPT','WAIT_PAYMENT','PAID','WAIT_COMMENT','COMPLETE','CANCELED','REJECTED') DEFAULT NULL,
  `comment` text,
  PRIMARY KEY (`id`),
  KEY `house_id` (`house_id`),
  KEY `user_id` (`user_id`),
  KEY `ix_ih_order_info_status` (`status`),
  CONSTRAINT `ih_order_info_ibfk_1` FOREIGN KEY (`house_id`) REFERENCES `ih_house_info` (`id`),
  CONSTRAINT `ih_order_info_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `ih_user_profile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ih_order_info
-- ----------------------------

-- ----------------------------
-- Table structure for `ih_user_profile`
-- ----------------------------
DROP TABLE IF EXISTS `ih_user_profile`;
CREATE TABLE `ih_user_profile` (
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `password_hash` varchar(128) NOT NULL,
  `mobile` varchar(11) NOT NULL,
  `real_name` varchar(32) DEFAULT NULL,
  `id_card` varchar(20) DEFAULT NULL,
  `avatar_url` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mobile` (`mobile`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ih_user_profile
-- ----------------------------
INSERT INTO `ih_user_profile` VALUES (null, null, '1', 'nebel', 'e10adc3949ba59abbe56e057f20f883e', '13916642365', 'nebel', null, null);
INSERT INTO `ih_user_profile` VALUES ('2018-04-27 13:48:54', '2018-04-27 13:48:54', '2', '13916642364', 'pbkdf2:sha256:50000$WSXHX6B6$c7e8e0559a15f405f3eaae4aa7eaec21a5024b476fd3939ce786554821dcc485', '13916642364', '大大大', '321023199310143285', null);
