/*
Navicat MySQL Data Transfer

Source Server         : localhost_MySQL
Source Server Version : 50153
Source Host           : localhost:3306
Source Database       : lwxmltodoc

Target Server Type    : MYSQL
Target Server Version : 50153
File Encoding         : 65001

Date: 2018-06-27 11:37:52
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for accounts
-- ----------------------------
DROP TABLE IF EXISTS `accounts`;
CREATE TABLE `accounts` (
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

-- ----------------------------
-- Records of accounts
-- ----------------------------
INSERT INTO `accounts` VALUES ('Лицевой счет');
INSERT INTO `accounts` VALUES ('Счет международной банковской карты');

-- ----------------------------
-- Table structure for banks
-- ----------------------------
DROP TABLE IF EXISTS `banks`;
CREATE TABLE `banks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `bik` varchar(255) DEFAULT NULL,
  `ks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=cp1251;

-- ----------------------------
-- Records of banks
-- ----------------------------
INSERT INTO `banks` VALUES ('1', 'ОАО \"Сбербанк России\"', '044525225', '30101810400000000225');
INSERT INTO `banks` VALUES ('2', 'тестовый банк', '343434343', '23423423423423423423');
INSERT INTO `banks` VALUES ('4', 'банк тест', '000000', '111111111111');

-- ----------------------------
-- Table structure for ifns
-- ----------------------------
DROP TABLE IF EXISTS `ifns`;
CREATE TABLE `ifns` (
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

-- ----------------------------
-- Records of ifns
-- ----------------------------
INSERT INTO `ifns` VALUES ('ИФНС тестовый');
INSERT INTO `ifns` VALUES ('ИФНС в городе Иваново');
INSERT INTO `ifns` VALUES ('еще один ИФНС');

-- ----------------------------
-- Table structure for nalog
-- ----------------------------
DROP TABLE IF EXISTS `nalog`;
CREATE TABLE `nalog` (
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

-- ----------------------------
-- Records of nalog
-- ----------------------------
INSERT INTO `nalog` VALUES ('социального');
INSERT INTO `nalog` VALUES ('имущественного');

-- ----------------------------
-- Table structure for user_roles
-- ----------------------------
DROP TABLE IF EXISTS `user_roles`;
CREATE TABLE `user_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=cp1251;

-- ----------------------------
-- Records of user_roles
-- ----------------------------
INSERT INTO `user_roles` VALUES ('1', 'urAdmin', 'Администратор');
INSERT INTO `user_roles` VALUES ('2', 'urUser', 'Пользователь');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_role` int(11) NOT NULL,
  `login` varchar(255) NOT NULL,
  `pass` varchar(255) NOT NULL,
  `user_name` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `id_role` (`id_role`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`id_role`) REFERENCES `user_roles` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=cp1251;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('1', '1', 'admin2', 'admin2', 'Администратор');
INSERT INTO `users` VALUES ('2', '2', 'user', 'user', 'Тестовый юзер');
