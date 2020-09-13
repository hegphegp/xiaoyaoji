/*
Navicat MySQL Data Transfer

Source Server         : 47.94.211.245-xyj
Source Server Version : 50716
Source Host           : 47.94.211.245:3306
Source Database       : xiaoyaoji

Target Server Type    : MYSQL
Target Server Version : 50716
File Encoding         : 65001

Date: 2017-09-07 11:16:31
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for attach
-- ----------------------------
DROP TABLE IF EXISTS `attach`;
CREATE TABLE `attach` (
  `id` char(12) NOT NULL,
  `url` varchar(1000) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `related_id` char(12) DEFAULT NULL,
  `file_name` varchar(1000) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `project_id` char(12) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `attach_related_id_index` (`related_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for doc
-- ----------------------------
DROP TABLE IF EXISTS `doc`;
CREATE TABLE `doc` (
  `id` char(12) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `sort` int(11) DEFAULT '100',
  `type` varchar(100) DEFAULT NULL,
  `content` longtext,
  `create_time` datetime DEFAULT NULL,
  `last_update_time` datetime DEFAULT NULL,
  `parent_id` char(12) DEFAULT NULL,
  `project_id` char(12) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `doc_parent_id_index` (`parent_id`) USING BTREE,
  KEY `doc_project_id_index` (`project_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for doc_history
-- ----------------------------
DROP TABLE IF EXISTS `doc_history`;
CREATE TABLE `doc_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `sort` int(11) DEFAULT '100',
  `type` varchar(100) DEFAULT NULL,
  `content` longtext,
  `create_time` datetime DEFAULT NULL,
  `parent_id` char(12) DEFAULT NULL,
  `project_id` char(12) DEFAULT NULL,
  `comment` varchar(1000) DEFAULT NULL,
  `user_id` char(12) DEFAULT NULL,
  `doc_id` char(12) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51473 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for email_token
-- ----------------------------
DROP TABLE IF EXISTS `email_token`;
CREATE TABLE `email_token` (
  `id` char(12) NOT NULL,
  `email` varchar(45) NOT NULL,
  `is_used` tinyint(1) NOT NULL DEFAULT '0',
  `create_time` datetime NOT NULL,
  `token` char(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for find_password
-- ----------------------------
DROP TABLE IF EXISTS `find_password`;
CREATE TABLE `find_password` (
  `id` char(12) NOT NULL DEFAULT '',
  `email` varchar(45) DEFAULT NULL,
  `is_used` tinyint(1) DEFAULT '0',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for interface
-- ----------------------------
DROP TABLE IF EXISTS `interface`;
CREATE TABLE `interface` (
  `id` char(14) NOT NULL DEFAULT '',
  `name` varchar(50) DEFAULT NULL,
  `description` text,
  `folder_id` char(14) DEFAULT NULL,
  `url` varchar(300) DEFAULT NULL,
  `request_method` varchar(50) DEFAULT NULL,
  `content_type` varchar(50) DEFAULT NULL,
  `request_headers` text,
  `request_args` text,
  `response_args` text,
  `example` mediumtext,
  `module_id` varchar(50) DEFAULT NULL,
  `project_id` char(14) DEFAULT NULL,
  `last_update_time` datetime DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `data_type` varchar(30) DEFAULT NULL,
  `protocol` varchar(30) DEFAULT NULL,
  `status` char(10) DEFAULT 'ENABLE',
  `sort` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `interface_project_id_index` (`project_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for interface_folder
-- ----------------------------
DROP TABLE IF EXISTS `interface_folder`;
CREATE TABLE `interface_folder` (
  `id` char(14) NOT NULL DEFAULT '',
  `name` varchar(50) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `module_id` char(14) DEFAULT NULL,
  `project_id` char(14) DEFAULT NULL,
  `sort` int(11) DEFAULT '100',
  PRIMARY KEY (`id`),
  KEY `interface_folder_project_id_index` (`project_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for module
-- ----------------------------
DROP TABLE IF EXISTS `module`;
CREATE TABLE `module` (
  `id` char(14) NOT NULL DEFAULT '',
  `name` varchar(50) DEFAULT NULL,
  `host` varchar(255) DEFAULT NULL,
  `description` mediumtext,
  `last_update_time` datetime DEFAULT NULL,
  `project_id` char(14) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `request_headers` text,
  `request_args` text,
  `sort` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `module_project_id_index` (`project_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for project
-- ----------------------------
DROP TABLE IF EXISTS `project`;
CREATE TABLE `project` (
  `id` char(14) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(300) DEFAULT NULL COMMENT 'test',
  `teamId` char(14) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `user_id` char(14) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'VALID',
  `permission` varchar(20) DEFAULT 'PRIVATE',
  `environments` text,
  `details` text,
  `last_update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for project_global
-- ----------------------------
DROP TABLE IF EXISTS `project_global`;
CREATE TABLE `project_global` (
  `id` char(12) NOT NULL DEFAULT '',
  `environment` mediumtext,
  `http` mediumtext,
  `project_id` char(12) NOT NULL DEFAULT '',
  `status` mediumtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for project_log
-- ----------------------------
DROP TABLE IF EXISTS `project_log`;
CREATE TABLE `project_log` (
  `id` char(14) NOT NULL DEFAULT '',
  `userId` char(14) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `log` text,
  `project_id` char(14) DEFAULT NULL,
  `action` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `project_log_project_id_index` (`project_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for project_user
-- ----------------------------
DROP TABLE IF EXISTS `project_user`;
CREATE TABLE `project_user` (
  `id` char(14) NOT NULL,
  `project_id` char(14) DEFAULT NULL,
  `user_id` char(14) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `status` char(255) DEFAULT 'PENDING',
  `editable` char(3) DEFAULT 'YES',
  `commonly_used` char(3) DEFAULT 'NO',
  PRIMARY KEY (`id`),
  KEY `project_user_user_index` (`project_id`,`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for share
-- ----------------------------
DROP TABLE IF EXISTS `share`;
CREATE TABLE `share` (
  `id` char(12) NOT NULL DEFAULT '',
  `name` varchar(50) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `user_id` char(12) DEFAULT NULL,
  `share_all` char(3) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `module_ids` varchar(2000) DEFAULT NULL,
  `project_id` char(12) DEFAULT NULL,
  `doc_ids` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for sys
-- ----------------------------
DROP TABLE IF EXISTS `sys`;
CREATE TABLE `sys` (
  `version` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for team
-- ----------------------------
DROP TABLE IF EXISTS `team`;
CREATE TABLE `team` (
  `id` char(14) NOT NULL DEFAULT '',
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(300) DEFAULT NULL,
  `userId` char(14) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `status` varchar(20) DEFAULT 'VALID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for team_user
-- ----------------------------
DROP TABLE IF EXISTS `team_user`;
CREATE TABLE `team_user` (
  `id` char(14) NOT NULL,
  `team_id` char(14) DEFAULT NULL,
  `user_id` char(14) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` char(12) NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `password` char(32) DEFAULT NULL,
  `type` varchar(5) DEFAULT 'USER',
  `nickname` varchar(30) DEFAULT NULL,
  `avatar` varchar(200) DEFAULT NULL,
  `status` char(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sys_user_id_unique_index` (`id`),
  UNIQUE KEY `sys_user_email_index` (`email`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for user_third
-- ----------------------------
DROP TABLE IF EXISTS `user_third`;
CREATE TABLE `user_third` (
  `id` varchar(60) NOT NULL,
  `user_id` char(12) NOT NULL,
  `type` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_third_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

