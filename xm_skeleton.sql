/*
SQLyog Ultimate v12.2.6 (64 bit)
MySQL - 8.0.12 : Database - xm_skeleton
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`xm_skeleton` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `xm_skeleton`;

/*Table structure for table `article_category` */

DROP TABLE IF EXISTS `article_category`;

CREATE TABLE `article_category` (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `is_parent` bit(1) DEFAULT NULL COMMENT '是否父类',
  `parent_id` varchar(32) NOT NULL DEFAULT '' COMMENT '父类ID',
  `sort_no` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '排序',
  `title` varchar(64) NOT NULL DEFAULT '' COMMENT '标题',
  `short_title` varchar(32) NOT NULL DEFAULT '' COMMENT '短标题',
  `relations` varchar(255) NOT NULL DEFAULT '' COMMENT '完整关系',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态(0无效;1有效)',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by` varchar(32) NOT NULL DEFAULT '',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_by` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `article_category` */

insert  into `article_category`(`id`,`is_parent`,`parent_id`,`sort_no`,`title`,`short_title`,`relations`,`status`,`created_at`,`created_by`,`updated_at`,`updated_by`) values
('246051614496919552',NULL,'0',1.00,'公司动态','动态','246051614496919552',1,1582954417,'admin',1585042792,'test'),
('246084721493151744','','0',1.00,'行业新闻','新闻','246084721493151744',1,1582962310,'admin',1585042806,'test'),
('246084745308409856',NULL,'246084721493151744',1.00,'化工类','化工','246084721493151744,246084745308409856',1,1582962316,'admin',1585042821,'test'),
('246511182632980480',NULL,'246084721493151744',1.00,'原材料','原材料','246084721493151744,246511182632980480',1,1583063986,'admin',1585042833,'test');

/*Table structure for table `article_info` */

DROP TABLE IF EXISTS `article_info`;

CREATE TABLE `article_info` (
  `id` varchar(32) NOT NULL,
  `category_id` varchar(32) NOT NULL DEFAULT '' COMMENT '文章分类ID',
  `title` varchar(128) NOT NULL DEFAULT '' COMMENT '文章标题',
  `thumb` varchar(255) NOT NULL DEFAULT '' COMMENT '文章封面图',
  `summary` text COMMENT '文章简介',
  `content` text COMMENT '文章内容',
  `author` varchar(32) DEFAULT NULL COMMENT '作者',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态(0无效;1有效)',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by` varchar(32) NOT NULL DEFAULT '',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_by` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文章表';

/*Data for the table `article_info` */

/*Table structure for table `qrtz_blob_triggers` */

DROP TABLE IF EXISTS `qrtz_blob_triggers`;

CREATE TABLE `qrtz_blob_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `BLOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_BLOB_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `qrtz_blob_triggers` */

/*Table structure for table `qrtz_calendars` */

DROP TABLE IF EXISTS `qrtz_calendars`;

CREATE TABLE `qrtz_calendars` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `CALENDAR_NAME` varchar(200) NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `qrtz_calendars` */

/*Table structure for table `qrtz_cron_triggers` */

DROP TABLE IF EXISTS `qrtz_cron_triggers`;

CREATE TABLE `qrtz_cron_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `CRON_EXPRESSION` varchar(200) NOT NULL,
  `TIME_ZONE_ID` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_CRON_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `qrtz_cron_triggers` */

/*Table structure for table `qrtz_fired_triggers` */

DROP TABLE IF EXISTS `qrtz_fired_triggers`;

CREATE TABLE `qrtz_fired_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `ENTRY_ID` varchar(95) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `SCHED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) NOT NULL,
  `JOB_NAME` varchar(200) DEFAULT NULL,
  `JOB_GROUP` varchar(200) DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `qrtz_fired_triggers` */

/*Table structure for table `qrtz_job_details` */

DROP TABLE IF EXISTS `qrtz_job_details`;

CREATE TABLE `qrtz_job_details` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) NOT NULL,
  `IS_DURABLE` varchar(1) NOT NULL,
  `IS_NONCONCURRENT` varchar(1) NOT NULL,
  `IS_UPDATE_DATA` varchar(1) NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) NOT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `qrtz_job_details` */

/*Table structure for table `qrtz_locks` */

DROP TABLE IF EXISTS `qrtz_locks`;

CREATE TABLE `qrtz_locks` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `LOCK_NAME` varchar(40) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `qrtz_locks` */

/*Table structure for table `qrtz_paused_trigger_grps` */

DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;

CREATE TABLE `qrtz_paused_trigger_grps` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `qrtz_paused_trigger_grps` */

/*Table structure for table `qrtz_quartz_job` */

DROP TABLE IF EXISTS `qrtz_quartz_job`;

CREATE TABLE `qrtz_quartz_job` (
  `id` varchar(32) NOT NULL,
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by` varchar(255) DEFAULT NULL,
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_by` varchar(255) DEFAULT NULL,
  `cron_expression` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `job_class_name` varchar(255) DEFAULT NULL,
  `parameter` varchar(255) DEFAULT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态(0无效;1有效)',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `qrtz_quartz_job` */

/*Table structure for table `qrtz_scheduler_state` */

DROP TABLE IF EXISTS `qrtz_scheduler_state`;

CREATE TABLE `qrtz_scheduler_state` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `qrtz_scheduler_state` */

/*Table structure for table `qrtz_simple_triggers` */

DROP TABLE IF EXISTS `qrtz_simple_triggers`;

CREATE TABLE `qrtz_simple_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_SIMPLE_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `qrtz_simple_triggers` */

/*Table structure for table `qrtz_simprop_triggers` */

DROP TABLE IF EXISTS `qrtz_simprop_triggers`;

CREATE TABLE `qrtz_simprop_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `STR_PROP_1` varchar(512) DEFAULT NULL,
  `STR_PROP_2` varchar(512) DEFAULT NULL,
  `STR_PROP_3` varchar(512) DEFAULT NULL,
  `INT_PROP_1` int(11) DEFAULT NULL,
  `INT_PROP_2` int(11) DEFAULT NULL,
  `LONG_PROP_1` bigint(20) DEFAULT NULL,
  `LONG_PROP_2` bigint(20) DEFAULT NULL,
  `DEC_PROP_1` decimal(13,4) DEFAULT NULL,
  `DEC_PROP_2` decimal(13,4) DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_SIMPROP_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `qrtz_simprop_triggers` */

/*Table structure for table `qrtz_triggers` */

DROP TABLE IF EXISTS `qrtz_triggers`;

CREATE TABLE `qrtz_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) NOT NULL,
  `TRIGGER_TYPE` varchar(8) NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `SCHED_NAME` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  CONSTRAINT `QRTZ_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `qrtz_triggers` */

/*Table structure for table `sys_admin` */

DROP TABLE IF EXISTS `sys_admin`;

CREATE TABLE `sys_admin` (
  `id` varchar(32) NOT NULL,
  `address` varchar(128) NOT NULL DEFAULT '',
  `avatar` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(64) DEFAULT NULL,
  `mobile` varchar(32) DEFAULT NULL,
  `nick_name` varchar(64) NOT NULL DEFAULT '',
  `password` varchar(64) NOT NULL DEFAULT '',
  `sex` tinyint(1) DEFAULT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态(0无效;1有效)',
  `type` tinyint(1) NOT NULL DEFAULT '1',
  `username` varchar(32) DEFAULT NULL,
  `department_id` varchar(32) NOT NULL DEFAULT '',
  `street` varchar(255) NOT NULL DEFAULT '',
  `pass_strength` varchar(2) NOT NULL DEFAULT '',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by` varchar(32) NOT NULL DEFAULT '',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_by` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `sys_admin` */

insert  into `sys_admin`(`id`,`address`,`avatar`,`description`,`email`,`mobile`,`nick_name`,`password`,`sex`,`status`,`type`,`username`,`department_id`,`street`,`pass_strength`,`created_at`,`created_by`,`updated_at`,`updated_by`) values
('47599079840026624','[\"440000\",\"440300\",\"440305\"]','','','DM@gmail.com','13888888888','','$2a$10$zXdiP.pMKunw8CmWdahPFunxnjfuXjcEvJdzFAcp79UazQTxb78P2',1,1,1,'admin','87335940934078464','','',1582959143,'admin',1585039068,'admin'),
('87338083204206592','[\"440000\",\"440300\",\"440305\"]','','','a@b.com','13333333333','','$2a$10$zXdiP.pMKunw8CmWdahPFunxnjfuXjcEvJdzFAcp79UazQTxb78P2',0,1,1,'test','117179715390803968','','',1582959143,'admin',1585042854,'test');

/*Table structure for table `sys_admin_log` */

DROP TABLE IF EXISTS `sys_admin_log`;

CREATE TABLE `sys_admin_log` (
  `id` varchar(32) NOT NULL,
  `cost_time` int(11) NOT NULL DEFAULT '0',
  `ip` varchar(64) NOT NULL DEFAULT '',
  `ip_info` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(64) NOT NULL DEFAULT '',
  `request_param` varchar(512) NOT NULL DEFAULT '',
  `request_type` varchar(16) NOT NULL DEFAULT '',
  `request_url` varchar(255) NOT NULL DEFAULT '',
  `username` varchar(32) NOT NULL DEFAULT '',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by` varchar(32) NOT NULL DEFAULT '',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_by` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `sys_admin_log` */

/*Table structure for table `sys_admin_role` */

DROP TABLE IF EXISTS `sys_admin_role`;

CREATE TABLE `sys_admin_role` (
  `id` varchar(32) NOT NULL,
  `role_id` varchar(32) NOT NULL DEFAULT '',
  `user_id` varchar(32) NOT NULL DEFAULT '',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by` varchar(32) NOT NULL DEFAULT '',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_by` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `sys_admin_role` */

insert  into `sys_admin_role`(`id`,`role_id`,`user_id`,`created_at`,`created_by`,`updated_at`,`updated_by`) values
('51919463095734273','496138616573953','51919414177566720',1582959143,'admin',1582959143,'admin'),
('126616146991386624','496138616573952','47599079840026624',1582959143,'admin',1582959143,'admin'),
('254811154226876416','496138616573953','87338083204206592',1585042854,'test',1585042854,'test'),
('116844842029420544','496138616573952','116844841647738880',1582959143,'admin',1582959143,'admin'),
('116847350214823936','496138616573952','116846552936353792',1582959143,'admin',1582959143,'admin'),
('116851632993472512','116849032776650752','116847659427303424',1582959143,'admin',1582959143,'admin'),
('116850548648448000','496138616573952','116848891118227456',1582959143,'admin',1582959143,'admin'),
('117180303184760832','496138616573953','117180302777913344',1582959143,'admin',1582959143,'admin');

/*Table structure for table `sys_department` */

DROP TABLE IF EXISTS `sys_department`;

CREATE TABLE `sys_department` (
  `id` varchar(32) NOT NULL,
  `is_parent` bit(1) DEFAULT NULL,
  `parent_id` varchar(32) NOT NULL DEFAULT '',
  `sort_order` decimal(10,2) NOT NULL DEFAULT '0.00',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态(0无效;1有效)',
  `title` varchar(64) NOT NULL DEFAULT '',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by` varchar(32) NOT NULL DEFAULT '',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_by` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `sys_department` */

insert  into `sys_department`(`id`,`is_parent`,`parent_id`,`sort_order`,`status`,`title`,`created_at`,`created_by`,`updated_at`,`updated_by`) values
('87336063856545792','\0','87335940934078464',1.00,1,'数据维护',1582959143,'admin',1582959143,'admin'),
('87335940934078464','','0',1.00,1,'运营中心',1582959143,'admin',1583916928,'admin'),
('117179715390803968','','0',1.00,1,'研发中心',1582959143,'admin',1583067226,'admin'),
('117179754469134336',NULL,'117179715390803968',1.00,1,'研发一部',1582959143,'admin',1583065065,'admin');

/*Table structure for table `sys_permission` */

DROP TABLE IF EXISTS `sys_permission`;

CREATE TABLE `sys_permission` (
  `id` varchar(32) NOT NULL,
  `description` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(64) NOT NULL DEFAULT '',
  `parent_id` varchar(32) NOT NULL DEFAULT '',
  `type` tinyint(1) NOT NULL DEFAULT '1',
  `sort_order` decimal(10,2) NOT NULL DEFAULT '0.00',
  `component` varchar(255) NOT NULL DEFAULT '',
  `path` varchar(128) NOT NULL DEFAULT '',
  `title` varchar(32) NOT NULL DEFAULT '',
  `icon` varchar(32) NOT NULL DEFAULT '',
  `level` tinyint(1) NOT NULL DEFAULT '0',
  `button_type` varchar(32) NOT NULL DEFAULT '',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态(0无效;1有效)',
  `url` varchar(255) NOT NULL DEFAULT '',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by` varchar(32) NOT NULL DEFAULT '',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_by` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `sys_permission` */

insert  into `sys_permission`(`id`,`description`,`name`,`parent_id`,`type`,`sort_order`,`component`,`path`,`title`,`icon`,`level`,`button_type`,`status`,`url`,`created_at`,`created_by`,`updated_at`,`updated_by`) values
('5129710648430592','','sys','',0,3.00,'Main','/form','系统管理','ios-settings',1,'',1,'',1582959143,'admin',1582959143,'admin'),
('5129710648430593','','user-manage','5129710648430592',0,1.10,'module/sys/user-manage/userManage','user-manage','管理员管理','md-person',2,'',1,'',1582959143,'admin',1582959143,'admin'),
('5129710648430594','','role-manage','5129710648430592',0,1.50,'module/sys/role-manage/roleManage','role-manage','角色管理','md-contacts',2,'',1,'',1582959143,'admin',1582959143,'admin'),
('5129710648430595','','menu-manage','5129710648430592',0,1.60,'module/sys/menu-manage/menuManage','menu-manage','菜单权限管理','md-menu',2,'',1,'',1582959143,'admin',1582959143,'admin'),
('15701400130424832','','','5129710648430593',1,1.11,'','/skeleton/user/admin/add','添加用户','',3,'add',1,'',1582959143,'admin',1583065326,'admin'),
('15701915807518720','','','5129710648430593',1,1.13,'','/skeleton/user/admin/disable/**','禁用用户','',3,'disable',1,'',1582959143,'admin',1582959143,'admin'),
('15708892205944832','','','5129710648430593',1,1.14,'','/skeleton/user/admin/enable/**','启用用户','',3,'enable',1,'',1582959143,'admin',1582959143,'admin'),
('16678126574637056','','','5129710648430593',1,1.12,'','/skeleton/user/admin/edit','编辑用户','',3,'edit',1,'',1582959143,'admin',1582959143,'admin'),
('16678447719911424','','','5129710648430593',1,1.15,'','/skeleton/user/delByIds/**','删除用户','',3,'delete',1,'',1582959143,'admin',1582959143,'admin'),
('16687383932047360','','','5129710648430594',1,1.21,'','/skeleton/role/save','添加角色','',3,'add',1,'',1582959143,'admin',1582959143,'admin'),
('16689632049631232','','','5129710648430594',1,1.22,'','/skeleton/role/edit','编辑角色','',3,'edit',1,'',1582959143,'admin',1582959143,'admin'),
('16689745006432256','','','5129710648430594',1,1.23,'','/skeleton/role/delAllByIds/**','删除角色','',3,'delete',1,'',1582959143,'admin',1582959143,'admin'),
('16689883993083904','','','5129710648430594',1,1.24,'','/skeleton/role/editRolePerm/**','分配权限','',3,'editPerm',1,'',1582959143,'admin',1582959143,'admin'),
('16690313745666048','','','5129710648430594',1,1.25,'','/skeleton/role/setDefault','设为默认角色','',3,'setDefault',1,'',1582959143,'admin',1582959143,'admin'),
('16694861252005888','','','5129710648430595',1,1.31,'','/skeleton/permission/add','添加菜单','',3,'add',1,'',1582959143,'admin',1582959143,'admin'),
('16695107491205120','','','5129710648430595',1,1.32,'','/skeleton/permission/edit','编辑菜单','',3,'edit',1,'',1582959143,'admin',1582959143,'admin'),
('16695243126607872','','','5129710648430595',1,1.33,'','/skeleton/permission/delByIds/**','删除菜单','',3,'delete',1,'',1582959143,'admin',1582959143,'admin'),
('39915540965232640','','monitor','',0,4.00,'Main','/monitor','系统监控','ios-analytics',1,'',1,'',1582959143,'admin',1582959143,'admin'),
('40238597734928384','','department-manage','5129710648430592',0,1.20,'module/sys/department-manage/departmentManage','department-manage','部门管理','md-git-branch',2,'',1,'',1582959143,'admin',1582959143,'admin'),
('41363147411427328','','log-manage','39915540965232640',0,2.20,'module/sys/log-manage/logManage','log-manage','操作日志管理','md-list-box',2,'',1,'',1582959143,'admin',1582959143,'admin'),
('41363537456533504','','','41363147411427328',1,2.11,'','/skeleton/log/delByIds/**','删除日志','',3,'delete',1,'',1582959143,'admin',1582959143,'admin'),
('41364927394353152','','','41363147411427328',1,2.12,'','/skeleton/log/delAll','清空日志','',3,'undefined',1,'',1582959143,'admin',1582959143,'admin'),
('45235621697949696','','','40238597734928384',1,1.21,'','/skeleton/department/add','添加部门','',3,'add',1,'',1582959143,'admin',1582959143,'admin'),
('45235787867885568','','','40238597734928384',1,1.22,'','/skeleton/department/edit','编辑部门','',3,'edit',1,'',1582959143,'admin',1582959143,'admin'),
('45235939278065664','','','40238597734928384',1,1.23,'','/skeleton/department/delByIds/*','删除部门','',3,'delete',1,'',1582959143,'admin',1582959143,'admin'),
('84907582589767680','','quartz-job','39915540965232640',0,2.10,'module/sys/quartz-manage/quartzManage','quartz-job','定时任务','md-time',2,'',1,'',1582959143,'admin',1582959143,'admin'),
('84907899767230464','','','84907582589767680',1,2.11,'','/skeleton/quartzJob/add*','添加定时任务','',3,'add',1,'',1582959143,'admin',1582959143,'admin'),
('84908172535402496','','','84907582589767680',1,2.12,'','/skeleton/quartzJob/edit*','编辑定时任务','',3,'edit',1,'',1582959143,'admin',1582959143,'admin'),
('84908391842975744','','','84907582589767680',1,2.13,'','/skeleton/quartzJob/pause*','暂停定时任务','',3,'disable',1,'',1582959143,'admin',1582959143,'admin'),
('84908678297161728','','','84907582589767680',1,2.14,'','/skeleton/quartzJob/resume*','恢复定时任务','',3,'enable',1,'',1582959143,'admin',1582959143,'admin'),
('84908899202764800','','','84907582589767680',1,2.15,'','/skeleton/quartzJob/delByIds/*','删除定时任务','',3,'delete',1,'',1582959143,'admin',1582959143,'admin'),
('126477677677776896','','article','',0,1.00,'Main','/article','文章管理','ios-book',1,'',1,'',1582959143,'admin',1583065321,'admin'),
('126478074127585280','','articleCategory','126477677677776896',0,1.00,'module/article/category/categoryManage','module/article/category','分类管理','md-bookmarks',2,'',1,'',1582959143,'admin',1583126496,'admin'),
('126495528849510400','','articleInfo','126477677677776896',0,1.00,'module/article/info/articleManage','module/article/info','文章管理','ios-book-outline',2,'',1,'',1582959143,'admin',1582959143,'admin'),
('126612524110974976','','','126478074127585280',1,1.00,'','/skeleton/article/category/add','添加分类','',3,'add',1,'',1582959143,'admin',1583060238,'admin'),
('126612730214879232','','','126478074127585280',1,1.00,'','/skeleton/article/category/edit','修改分类','',3,'edit',1,'',1582959143,'admin',1582959143,'admin'),
('126613271254929408','','','126478074127585280',1,1.00,'','/skeleton/article/category/delByIds/**','删除分类','',3,'delete',1,'',1582959143,'admin',1582959143,'admin'),
('126613728463425536','','','126495528849510400',1,1.00,'','/skeleton/article/add','添加文章','',3,'add',1,'',1582959143,'admin',1582959143,'admin'),
('126613843764842496','','','126495528849510400',1,1.00,'','/skeleton/article/delByIds/**','删除文章','',3,'delete',1,'',1582959143,'admin',1582959143,'admin'),
('126613956428042240','','','126495528849510400',1,1.00,'','/skeleton/article/edit','修改文章','',3,'edit',1,'',1582959143,'admin',1582959143,'admin'),
('126614281000062976','','','126495528849510400',1,1.00,'','/skeleton/article/enable/**','启用文章','',3,'enable',1,'',1582959143,'admin',1582959143,'admin'),
('126614454480670720','','','126495528849510400',1,1.00,'','/skeleton/article/disable/**','禁用文章','',3,'disable',1,'',1582959143,'admin',1582959143,'admin'),
('246775405099356160','','userInfo','246774896938455040',0,1.00,'module/user/info/userManage','module/user/info','用户列表','ios-list',2,'',1,'',1583126982,'admin',1583127273,'admin'),
('246774896938455040','','user','',0,1.00,'Main','/user','用户管理','ios-contacts',1,'',1,'',1583126861,'admin',1583126861,'admin'),
('246788837722820608','','','246775405099356160',1,1.00,'','/skeleton/userInfo/add','添加前台用户','',3,'add',1,'',1583130185,'admin',1583130476,'admin'),
('246789186294648832','','','246775405099356160',1,1.00,'','/skeleton/userInfo/delByIds/**','删除前台用户','',3,'delete',1,'',1583130268,'admin',1583130483,'admin'),
('246789506617839616','','','246775405099356160',1,1.00,'','/skeleton/userInfo/edit','修改前台用户','',3,'edit',1,'',1583130344,'admin',1583130492,'admin'),
('246789757718237184','','','246775405099356160',1,1.00,'','/skeleton/userInfo/enable/**','启动前台用户','',3,'enable',1,'',1583130404,'admin',1583130504,'admin'),
('246789946898124800','','','246775405099356160',1,1.00,'','/skeleton/userInfo/disable/**','禁用前台用户','',3,'disable',1,'',1583130449,'admin',1583130449,'admin'),
('254767356545339392','','','5129710648430593',1,6.00,'','/skeleton/user/admin/updatePassword','修改密码','',3,'updatePassword',1,'',1585032412,'admin',1585032430,'admin'),
('254796861188083712','','','246775405099356160',1,6.00,'','/skeleton/userInfo/updatePassword','修改前台用户密码','',3,'updatePassword',1,'',1585039446,'admin',1585039446,'admin');

/*Table structure for table `sys_role` */

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
  `id` varchar(32) NOT NULL,
  `name` varchar(32) NOT NULL DEFAULT '',
  `default_role` bit(1) DEFAULT NULL,
  `description` varchar(255) NOT NULL DEFAULT '',
  `data_type` int(11) DEFAULT NULL,
  `created_at` int(11) unsigned NOT NULL DEFAULT '0',
  `created_by` varchar(32) NOT NULL DEFAULT '',
  `updated_at` int(11) unsigned NOT NULL DEFAULT '0',
  `updated_by` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `sys_role` */

insert  into `sys_role`(`id`,`name`,`default_role`,`description`,`data_type`,`created_at`,`created_by`,`updated_at`,`updated_by`) values
('496138616573952','ROLE_ADMIN','','超级管理员 拥有所有权限',NULL,1582959143,'admin',1582963317,'admin'),
('496138616573953','ROLE_USER','\0','普通浏览',NULL,1582959143,'admin',1582963315,'admin');

/*Table structure for table `sys_role_permission` */

DROP TABLE IF EXISTS `sys_role_permission`;

CREATE TABLE `sys_role_permission` (
  `id` varchar(32) NOT NULL,
  `permission_id` varchar(32) NOT NULL DEFAULT '',
  `role_id` varchar(32) NOT NULL DEFAULT '',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by` varchar(32) NOT NULL DEFAULT '',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_by` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `sys_role_permission` */

insert  into `sys_role_permission`(`id`,`permission_id`,`role_id`,`created_at`,`created_by`,`updated_at`,`updated_by`) values
('254796943367081984','41363147411427328','496138616573952',1585039466,'admin',1585039466,'admin'),
('254796943287390208','84908899202764800','496138616573952',1585039466,'admin',1585039466,'admin'),
('254796943228669952','84908678297161728','496138616573952',1585039466,'admin',1585039466,'admin'),
('254796943144783872','84908391842975744','496138616573952',1585039466,'admin',1585039466,'admin'),
('254796943090257920','84908172535402496','496138616573952',1585039466,'admin',1585039466,'admin'),
('254796943010566144','84907899767230464','496138616573952',1585039466,'admin',1585039466,'admin'),
('254796942951845888','84907582589767680','496138616573952',1585039466,'admin',1585039466,'admin'),
('254796942872154112','39915540965232640','496138616573952',1585039466,'admin',1585039466,'admin'),
('254796942729547776','16695107491205120','496138616573952',1585039466,'admin',1585039466,'admin'),
('254796942532415488','16690313745666048','496138616573952',1585039466,'admin',1585039466,'admin'),
('254796942813433856','16695243126607872','496138616573952',1585039466,'admin',1585039466,'admin'),
('254796942670827520','16694861252005888','496138616573952',1585039466,'admin',1585039466,'admin'),
('254796942591135744','5129710648430595','496138616573952',1585039466,'admin',1585039466,'admin'),
('254796942251397120','16687383932047360','496138616573952',1585039465,'admin',1585039465,'admin'),
('254796942448529408','16689883993083904','496138616573952',1585039465,'admin',1585039465,'admin'),
('254796942389809152','16689745006432256','496138616573952',1585039465,'admin',1585039465,'admin'),
('254796942310117376','16689632049631232','496138616573952',1585039465,'admin',1585039465,'admin'),
('254796942171705344','5129710648430594','496138616573952',1585039465,'admin',1585039465,'admin'),
('254796942108790784','45235939278065664','496138616573952',1585039465,'admin',1585039465,'admin'),
('254796942029099008','45235787867885568','496138616573952',1585039465,'admin',1585039465,'admin'),
('254796941970378752','45235621697949696','496138616573952',1585039465,'admin',1585039465,'admin'),
('254796941890686976','40238597734928384','496138616573952',1585039465,'admin',1585039465,'admin'),
('254796941831966720','254767356545339392','496138616573952',1585039465,'admin',1585039465,'admin'),
('254796941748080640','16678447719911424','496138616573952',1585039465,'admin',1585039465,'admin'),
('254796941689360384','15708892205944832','496138616573952',1585039465,'admin',1585039465,'admin'),
('254796941471256576','15701400130424832','496138616573952',1585039465,'admin',1585039465,'admin'),
('254796941550948352','16678126574637056','496138616573952',1585039465,'admin',1585039465,'admin'),
('254796941605474304','15701915807518720','496138616573952',1585039465,'admin',1585039465,'admin'),
('254796941412536320','5129710648430593','496138616573952',1585039465,'admin',1585039465,'admin'),
('254796941332844544','5129710648430592','496138616573952',1585039465,'admin',1585039465,'admin'),
('254796941274124288','254796861188083712','496138616573952',1585039465,'admin',1585039465,'admin'),
('254796941190238208','246789946898124800','496138616573952',1585039465,'admin',1585039465,'admin'),
('254796941131517952','246789757718237184','496138616573952',1585039465,'admin',1585039465,'admin'),
('254796941051826176','246789506617839616','496138616573952',1585039465,'admin',1585039465,'admin'),
('254796940993105920','246789186294648832','496138616573952',1585039465,'admin',1585039465,'admin'),
('254796940909219840','246788837722820608','496138616573952',1585039465,'admin',1585039465,'admin'),
('254796940850499584','246775405099356160','496138616573952',1585039465,'admin',1585039465,'admin'),
('254796940770807808','246774896938455040','496138616573952',1585039465,'admin',1585039465,'admin'),
('254796940712087552','126614454480670720','496138616573952',1585039465,'admin',1585039465,'admin'),
('250118042103582720','15701400130424832','496138616573953',1583923929,'admin',1583923929,'admin'),
('250118041931616256','5129710648430592','496138616573953',1583923929,'admin',1583923929,'admin'),
('250118042028085248','5129710648430593','496138616573953',1583923929,'admin',1583923929,'admin'),
('254796940628201472','126614281000062976','496138616573952',1585039465,'admin',1585039465,'admin'),
('254796940569481216','126613956428042240','496138616573952',1585039465,'admin',1585039465,'admin'),
('254796940489789440','126613843764842496','496138616573952',1585039465,'admin',1585039465,'admin'),
('254796940431069184','126613728463425536','496138616573952',1585039465,'admin',1585039465,'admin'),
('254796940351377408','126495528849510400','496138616573952',1585039465,'admin',1585039465,'admin'),
('254796940292657152','126613271254929408','496138616573952',1585039465,'admin',1585039465,'admin'),
('250118041755455488','246789757718237184','496138616573953',1583923929,'admin',1583923929,'admin'),
('250118041851924480','246789946898124800','496138616573953',1583923929,'admin',1583923929,'admin'),
('250118041679958016','246789506617839616','496138616573953',1583923929,'admin',1583923929,'admin'),
('250118041579294720','246789186294648832','496138616573953',1583923929,'admin',1583923929,'admin'),
('250118041503797248','246788837722820608','496138616573953',1583923929,'admin',1583923929,'admin'),
('250118041407328256','246775405099356160','496138616573953',1583923929,'admin',1583923929,'admin'),
('250118041327636480','246774896938455040','496138616573953',1583923929,'admin',1583923929,'admin'),
('250118041231167488','126614454480670720','496138616573953',1583923929,'admin',1583923929,'admin'),
('250118041155670016','126614281000062976','496138616573953',1583923928,'admin',1583923928,'admin'),
('250118041055006720','126613956428042240','496138616573953',1583923928,'admin',1583923928,'admin'),
('250118040979509248','126613843764842496','496138616573953',1583923928,'admin',1583923928,'admin'),
('250118040883040256','126613728463425536','496138616573953',1583923928,'admin',1583923928,'admin'),
('250118040803348480','126495528849510400','496138616573953',1583923928,'admin',1583923928,'admin'),
('250118040706879488','126613271254929408','496138616573953',1583923928,'admin',1583923928,'admin'),
('250118040627187712','126612730214879232','496138616573953',1583923928,'admin',1583923928,'admin'),
('250118040530718720','126612524110974976','496138616573953',1583923928,'admin',1583923928,'admin'),
('250118040455221248','126478074127585280','496138616573953',1583923928,'admin',1583923928,'admin'),
('250118040354557952','126477677677776896','496138616573953',1583923928,'admin',1583923928,'admin'),
('250118042204246016','16678126574637056','496138616573953',1583923929,'admin',1583923929,'admin'),
('250118042279743488','15701915807518720','496138616573953',1583923929,'admin',1583923929,'admin'),
('250118042376212480','15708892205944832','496138616573953',1583923929,'admin',1583923929,'admin'),
('250118042451709952','16678447719911424','496138616573953',1583923929,'admin',1583923929,'admin'),
('250118042552373248','40238597734928384','496138616573953',1583923929,'admin',1583923929,'admin'),
('250118042627870720','45235621697949696','496138616573953',1583923929,'admin',1583923929,'admin'),
('250118042728534016','45235787867885568','496138616573953',1583923929,'admin',1583923929,'admin'),
('250118042804031488','45235939278065664','496138616573953',1583923929,'admin',1583923929,'admin'),
('250118042900500480','5129710648430594','496138616573953',1583923929,'admin',1583923929,'admin'),
('250118042975997952','16687383932047360','496138616573953',1583923929,'admin',1583923929,'admin'),
('250118043076661248','16689632049631232','496138616573953',1583923929,'admin',1583923929,'admin'),
('250118043156353024','16689745006432256','496138616573953',1583923929,'admin',1583923929,'admin'),
('250118043252822016','16689883993083904','496138616573953',1583923929,'admin',1583923929,'admin'),
('250118043328319488','16690313745666048','496138616573953',1583923929,'admin',1583923929,'admin'),
('250118043428982784','5129710648430595','496138616573953',1583923929,'admin',1583923929,'admin'),
('250118043504480256','16694861252005888','496138616573953',1583923929,'admin',1583923929,'admin'),
('250118043600949248','16695107491205120','496138616573953',1583923929,'admin',1583923929,'admin'),
('250118043676446720','16695243126607872','496138616573953',1583923929,'admin',1583923929,'admin'),
('250118043781304320','39915540965232640','496138616573953',1583923929,'admin',1583923929,'admin'),
('250118043890356224','84907582589767680','496138616573953',1583923929,'admin',1583923929,'admin'),
('250118043986825216','84907899767230464','496138616573953',1583923929,'admin',1583923929,'admin'),
('250118044062322688','84908172535402496','496138616573953',1583923929,'admin',1583923929,'admin'),
('250118044158791680','84908391842975744','496138616573953',1583923929,'admin',1583923929,'admin'),
('250118044238483456','84908678297161728','496138616573953',1583923929,'admin',1583923929,'admin'),
('250118044334952448','84908899202764800','496138616573953',1583923929,'admin',1583923929,'admin'),
('250118044414644224','41363147411427328','496138616573953',1583923929,'admin',1583923929,'admin'),
('250118044506918912','41363537456533504','496138616573953',1583923929,'admin',1583923929,'admin'),
('250118044582416384','41364927394353152','496138616573953',1583923929,'admin',1583923929,'admin'),
('254796940208771072','126612730214879232','496138616573952',1585039465,'admin',1585039465,'admin'),
('254796940150050816','126612524110974976','496138616573952',1585039465,'admin',1585039465,'admin'),
('254796940070359040','126478074127585280','496138616573952',1585039465,'admin',1585039465,'admin'),
('254796940011638784','126477677677776896','496138616573952',1585039465,'admin',1585039465,'admin'),
('254796943543242752','41363537456533504','496138616573952',1585039466,'admin',1585039466,'admin'),
('254796943601963008','41364927394353152','496138616573952',1585039466,'admin',1585039466,'admin');

/*Table structure for table `user_info` */

DROP TABLE IF EXISTS `user_info`;

CREATE TABLE `user_info` (
  `id` varchar(32) NOT NULL,
  `username` varchar(32) NOT NULL DEFAULT '' COMMENT '用户名',
  `mobile` varchar(32) NOT NULL DEFAULT '' COMMENT '手机号',
  `password` varchar(64) DEFAULT '' COMMENT '密码',
  `email` varchar(32) DEFAULT '' COMMENT '邮箱',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态(0无效;1有效;2删除)',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `user_info` */

insert  into `user_info`(`id`,`username`,`mobile`,`password`,`email`,`status`,`created_at`,`updated_at`) values
('245742660202008576','xiaoma','13888888888','cdb1759974089944308d9d67871cfbc0','xiaomalover@gmail.com',1,1582880756,1585042744),
('246807679731765248','xiaomage','13333333333','5209c4c4de005adebb733f08d773f48c','aa111@bb.com',1,1583134677,1585042523);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
