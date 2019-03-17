/*
SQLyog Ultimate v12.5.0 (64 bit)
MySQL - 5.5.53 : Database - xm_skeleton
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

/*Table structure for table `qrtz_blob_triggers` */

DROP TABLE IF EXISTS `qrtz_blob_triggers`;

CREATE TABLE `qrtz_blob_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `BLOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_BLOB_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
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
  CONSTRAINT `QRTZ_CRON_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `qrtz_cron_triggers` */

insert  into `qrtz_cron_triggers`(`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`,`CRON_EXPRESSION`,`TIME_ZONE_ID`) values 
('quartzScheduler','com.xm.admin.quartz.jobs.JobWithoutParam','DEFAULT','*/1 * * * * ?','Asia/Shanghai'),
('quartzScheduler','com.xm.admin.quartz.jobs.JobWithParam','DEFAULT','*/5 * * * * ?','Asia/Shanghai');

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

insert  into `qrtz_job_details`(`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`,`DESCRIPTION`,`JOB_CLASS_NAME`,`IS_DURABLE`,`IS_NONCONCURRENT`,`IS_UPDATE_DATA`,`REQUESTS_RECOVERY`,`JOB_DATA`) values 
('quartzScheduler','com.xm.admin.quartz.jobs.JobWithoutParam','DEFAULT',NULL,'com.xm.admin.quartz.jobs.JobWithoutParam','0','0','0','0','��\0sr\0org.quartz.JobDataMap���迩��\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�����](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap�.�(v\n�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap���`�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0	parametert\0nullx\0'),
('quartzScheduler','com.xm.admin.quartz.jobs.JobWithParam','DEFAULT',NULL,'com.xm.admin.quartz.jobs.JobWithParam','0','0','0','0','��\0sr\0org.quartz.JobDataMap���迩��\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�����](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap�.�(v\n�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap���`�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0	parametert\0Test Jobx\0');

/*Table structure for table `qrtz_locks` */

DROP TABLE IF EXISTS `qrtz_locks`;

CREATE TABLE `qrtz_locks` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `LOCK_NAME` varchar(40) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `qrtz_locks` */

insert  into `qrtz_locks`(`SCHED_NAME`,`LOCK_NAME`) values 
('quartzScheduler','TRIGGER_ACCESS');

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
  `id` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(255) DEFAULT NULL,
  `cron_expression` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `job_class_name` varchar(255) DEFAULT NULL,
  `parameter` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `qrtz_quartz_job` */

insert  into `qrtz_quartz_job`(`id`,`created_at`,`created_by`,`updated_at`,`updated_by`,`cron_expression`,`description`,`job_class_name`,`parameter`,`status`) values 
('119642809568333824','2019-03-17 17:50:09','admin','2019-03-17 17:59:46','admin','*/5 * * * * ?','无参数定时任务','com.xm.admin.quartz.jobs.JobWithoutParam','null',-1),
('95632048328282112','2019-01-10 11:39:58','null','2019-03-10 01:57:44','null','*/5 * * * * ?','有参测试任务','com.xm.admin.quartz.jobs.JobWithParam','Test Job',-1);

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
  CONSTRAINT `QRTZ_SIMPLE_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
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
  CONSTRAINT `QRTZ_SIMPROP_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
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
  CONSTRAINT `QRTZ_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `qrtz_triggers` */

insert  into `qrtz_triggers`(`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`,`JOB_NAME`,`JOB_GROUP`,`DESCRIPTION`,`NEXT_FIRE_TIME`,`PREV_FIRE_TIME`,`PRIORITY`,`TRIGGER_STATE`,`TRIGGER_TYPE`,`START_TIME`,`END_TIME`,`CALENDAR_NAME`,`MISFIRE_INSTR`,`JOB_DATA`) values 
('quartzScheduler','com.xm.admin.quartz.jobs.JobWithoutParam','DEFAULT','com.xm.admin.quartz.jobs.JobWithoutParam','DEFAULT',NULL,1552816787000,1552816786000,5,'PAUSED','CRON',1552816216000,0,NULL,0,''),
('quartzScheduler','com.xm.admin.quartz.jobs.JobWithParam','DEFAULT','com.xm.admin.quartz.jobs.JobWithParam','DEFAULT',NULL,1552154265000,1552154260000,5,'PAUSED','CRON',1547091598000,0,NULL,0,'');

/*Table structure for table `sys_admin` */

DROP TABLE IF EXISTS `sys_admin`;

CREATE TABLE `sys_admin` (
  `id` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `avatar` varchar(1000) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `nick_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `sex` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `department_id` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `pass_strength` varchar(2) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `sys_admin` */

insert  into `sys_admin`(`id`,`address`,`avatar`,`description`,`email`,`mobile`,`nick_name`,`password`,`sex`,`status`,`type`,`username`,`department_id`,`street`,`pass_strength`,`created_at`,`created_by`,`updated_at`,`updated_by`) values 
('47599079840026624','[\"440000\",\"440300\",\"440305\"]','','','xiaomalover@gmail.com','13888888888','','$2a$10$zXdiP.pMKunw8CmWdahPFunxnjfuXjcEvJdzFAcp79UazQTxb78P2',1,0,1,'admin','87335940934078464','','','2018-08-30 22:34:06','admin','2019-03-10 22:42:27','admin'),
('87338083204206592','[\"440000\",\"440300\",\"440305\"]','','','a@b.com','13333333333','','$2a$10$zXdiP.pMKunw8CmWdahPFunxnjfuXjcEvJdzFAcp79UazQTxb78P2',1,0,1,'test','87336063856545792','','','2018-12-18 14:22:43','admin','2019-03-17 18:15:29','admin');

/*Table structure for table `sys_admin_log` */

DROP TABLE IF EXISTS `sys_admin_log`;

CREATE TABLE `sys_admin_log` (
  `id` varchar(255) NOT NULL,
  `cost_time` int(11) DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `ip_info` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `request_param` varchar(512) DEFAULT NULL,
  `request_type` varchar(255) DEFAULT NULL,
  `request_url` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `sys_admin_log` */

insert  into `sys_admin_log`(`id`,`cost_time`,`ip`,`ip_info`,`name`,`request_param`,`request_type`,`request_url`,`username`,`created_at`,`created_by`,`updated_at`,`updated_by`) values 
('119645227853025280',6,'127.0.0.1',NULL,'暂停定时任务','{\"cronExpression\":\"*/5 * * * * ?\",\"createdAt\":\"2019-03-17 17:50:09.0\",\"updatedBy\":\"admin\",\"_index\":\"0\",\"createdBy\":\"admin\",\"jobClassName\":\"com.xm.admin.quartz.jobs.JobWithoutParam\",\"parameter\":\"null\",\"description\":\"无参数定时任务\",\"id\":\"119642809568333824\",\"updatedAt\":\"2019-03-17 17:50:25.0\",\"status\":\"0\",\"_rowKey\":\"25\"}','POST','/skeleton/quartzJob/pause','admin','2019-03-17 17:59:46','admin','2019-03-17 17:59:46','admin'),
('119645579809656832',2,'127.0.0.1',NULL,'登录系统','{\"password\":\"你是看不见我的\",\"captcha\":\"qhuh\",\"saveLogin\":\"true\",\"captchaId\":\"5728a6ed40f34b5fb53e9ccf0c45ae9e\",\"username\":\"admin\"}','POST','/skeleton/login','admin','2019-03-17 18:01:10','admin','2019-03-17 18:01:10','admin'),
('119649717624770560',14,'127.0.0.1',NULL,'登录系统','{\"password\":\"你是看不见我的\",\"captcha\":\"tfoz\",\"saveLogin\":\"true\",\"captchaId\":\"18414be1b2684471a154223d2346b41a\",\"username\":\"test\"}','POST','/skeleton/login','admin','2019-03-17 18:17:36','admin','2019-03-17 18:17:36','admin'),
('119649827846885376',2,'127.0.0.1',NULL,'登录系统','{\"password\":\"你是看不见我的\",\"captcha\":\"dbls\",\"saveLogin\":\"true\",\"captchaId\":\"f42664a9f4aa4faf90f2667f01bef757\",\"username\":\"admin\"}','POST','/skeleton/login','admin','2019-03-17 18:18:02','admin','2019-03-17 18:18:02','admin');

/*Table structure for table `sys_admin_role` */

DROP TABLE IF EXISTS `sys_admin_role`;

CREATE TABLE `sys_admin_role` (
  `id` varchar(255) NOT NULL,
  `role_id` varchar(255) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `sys_admin_role` */

insert  into `sys_admin_role`(`id`,`role_id`,`user_id`,`created_at`,`created_by`,`updated_at`,`updated_by`) values 
('51919463095734273','496138616573953','51919414177566720','2018-09-11 20:41:46','admin','2018-09-11 20:41:46','admin'),
('117179652136505344','496138616573952','47599079840026624','2019-03-10 22:42:27','admin','2019-03-10 22:42:27','admin'),
('119649182263808000','496138616573953','87338083204206592','2019-03-17 18:15:29','admin','2019-03-17 18:15:29','admin'),
('116844842029420544','496138616573952','116844841647738880','2019-03-10 00:32:02','admin','2019-03-10 00:32:02','admin'),
('116847350214823936','496138616573952','116846552936353792','2019-03-10 00:42:00','admin','2019-03-10 00:42:00','admin'),
('116851632993472512','116849032776650752','116847659427303424','2019-03-10 00:59:01','admin','2019-03-10 00:59:01','admin'),
('116850548648448000','496138616573952','116848891118227456','2019-03-10 00:54:42','admin','2019-03-10 00:54:42','admin'),
('117180303184760832','496138616573953','117180302777913344','2019-03-10 22:45:02','admin','2019-03-10 22:45:02','admin');

/*Table structure for table `sys_department` */

DROP TABLE IF EXISTS `sys_department`;

CREATE TABLE `sys_department` (
  `id` varchar(255) NOT NULL,
  `is_parent` bit(1) DEFAULT NULL,
  `parent_id` varchar(255) DEFAULT NULL,
  `sort_order` decimal(10,2) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `sys_department` */

insert  into `sys_department`(`id`,`is_parent`,`parent_id`,`sort_order`,`status`,`title`,`created_at`,`created_by`,`updated_at`,`updated_by`) values 
('87336063856545792','\0','87335940934078464',1.00,0,'数据维护','2018-12-18 14:14:41','admin','2019-03-11 12:57:32','admin'),
('87335940934078464','','0',1.00,0,'运营中心','2018-12-18 14:14:12','admin','2018-12-18 14:14:41','admin'),
('117179715390803968','','0',1.00,0,'研发中心','2019-03-10 22:42:42','admin','2019-03-10 22:42:51','admin'),
('117179754469134336',NULL,'117179715390803968',1.00,0,'研发一部','2019-03-10 22:42:51','admin','2019-03-10 22:43:30','admin');

/*Table structure for table `sys_permission` */

DROP TABLE IF EXISTS `sys_permission`;

CREATE TABLE `sys_permission` (
  `id` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `parent_id` varchar(255) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `sort_order` decimal(10,2) DEFAULT NULL,
  `component` varchar(255) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `button_type` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `sys_permission` */

insert  into `sys_permission`(`id`,`description`,`name`,`parent_id`,`type`,`sort_order`,`component`,`path`,`title`,`icon`,`level`,`button_type`,`status`,`url`,`created_at`,`created_by`,`updated_at`,`updated_by`) values 
('5129710648430592','','sys','',0,3.00,'Main','/form','系统管理','ios-settings',1,'',0,'','2018-06-04 19:02:29','admin','2018-09-04 22:50:52','admin'),
('5129710648430593','','user-manage','5129710648430592',0,1.10,'module/sys/user-manage/userManage','user-manage','管理员管理','md-person',2,'',0,'','2018-06-04 19:02:32','admin','2018-09-03 16:06:57','admin'),
('5129710648430594','','role-manage','5129710648430592',0,1.50,'module/sys/role-manage/roleManage','role-manage','角色管理','md-contacts',2,'',0,'','2018-06-04 19:02:35','admin','2018-08-23 17:31:27','admin'),
('5129710648430595','','menu-manage','5129710648430592',0,1.60,'module/sys/menu-manage/menuManage','menu-manage','菜单权限管理','md-menu',2,'',0,'','2018-06-04 19:02:37','admin','2018-08-23 17:31:33','admin'),
('15701400130424832','','','5129710648430593',1,1.11,'','/iwallet/user/admin/add','添加用户','',3,'add',0,'','2018-06-03 22:04:06','admin','2018-08-31 17:24:08','admin'),
('15701915807518720','','','5129710648430593',1,1.13,'','/iwallet/user/admin/disable/**','禁用用户','',3,'disable',0,'','2018-06-03 22:06:09','admin','2018-08-31 17:24:39','admin'),
('15708892205944832','','','5129710648430593',1,1.14,'','/iwallet/user/admin/enable/**','启用用户','',3,'enable',0,'','2018-06-03 22:33:52','admin','2018-08-31 17:24:52','admin'),
('16678126574637056','','','5129710648430593',1,1.12,'','/iwallet/user/admin/edit','编辑用户','',3,'edit',0,'','2018-06-06 14:45:16','admin','2018-08-31 17:24:23','admin'),
('16678447719911424','','','5129710648430593',1,1.15,'','/iwallet/user/delByIds/**','删除用户','',3,'delete',0,'','2018-06-06 14:46:32','admin','2018-08-31 17:25:07','admin'),
('16687383932047360','','','5129710648430594',1,1.21,'','/iwallet/role/save','添加角色','',3,'add',0,'','2018-06-06 15:22:03','admin','2018-08-31 17:26:02','admin'),
('16689632049631232','','','5129710648430594',1,1.22,'','/iwallet/role/edit','编辑角色','',3,'edit',0,'','2018-06-06 15:30:59','admin','2018-08-31 17:26:13','admin'),
('16689745006432256','','','5129710648430594',1,1.23,'','/iwallet/role/delAllByIds/**','删除角色','',3,'delete',0,'','2018-06-06 15:31:26','admin','2018-08-31 17:26:23','admin'),
('16689883993083904','','','5129710648430594',1,1.24,'','/iwallet/role/editRolePerm/**','分配权限','',3,'editPerm',0,'','2018-06-06 15:31:59','admin','2018-08-31 17:26:45','admin'),
('16690313745666048','','','5129710648430594',1,1.25,'','/iwallet/role/setDefault','设为默认角色','',3,'setDefault',0,'','2018-06-06 15:33:41','admin','2018-08-31 17:27:00','admin'),
('16694861252005888','','','5129710648430595',1,1.31,'','/iwallet/permission/add','添加菜单','',3,'add',0,'','2018-06-06 15:51:46','admin','2018-08-31 17:27:14','admin'),
('16695107491205120','','','5129710648430595',1,1.32,'','/iwallet/permission/edit','编辑菜单','',3,'edit',0,'','2018-06-06 15:52:44','admin','2018-08-31 17:27:21','admin'),
('16695243126607872','','','5129710648430595',1,1.33,'','/iwallet/permission/delByIds/**','删除菜单','',3,'delete',0,'','2018-06-06 15:53:17','admin','2018-08-31 17:27:31','admin'),
('39915540965232640','','monitor','',0,4.00,'Main','/monitor','系统监控','ios-analytics',1,'',0,'','2018-08-09 17:42:28','admin','2018-09-04 22:50:47','admin'),
('40238597734928384',NULL,'department-manage','5129710648430592',0,1.20,'module/sys/department-manage/departmentManage','department-manage','部门管理','md-git-branch',2,'',0,NULL,'2018-08-10 15:06:10','admin','2018-08-10 15:06:10','admin'),
('41363147411427328','','log-manage','39915540965232640',0,2.20,'module/sys/log-manage/logManage','log-manage','操作日志管理','md-list-box',2,'',0,'','2018-08-13 17:34:43','admin','2018-08-20 20:05:21','admin'),
('41363537456533504','','','41363147411427328',1,2.11,'','/iwallet/log/delByIds/**','删除日志','',3,'delete',0,'','2018-08-13 17:36:16','admin','2018-08-31 17:28:04','admin'),
('41364927394353152','','','41363147411427328',1,2.12,'','/iwallet/log/delAll','清空日志','',3,'undefined',0,'','2018-08-13 17:41:48','admin','2018-08-31 17:28:13','admin'),
('45235621697949696','','','40238597734928384',1,1.21,'','/iwallet/department/add','添加部门','',3,'add',0,'','2018-08-24 10:02:33','admin','2018-08-31 17:25:26','admin'),
('45235787867885568','','','40238597734928384',1,1.22,'','/iwallet/department/edit','编辑部门','',3,'edit',0,'','2018-08-24 10:03:13','admin','2018-08-31 17:25:36','admin'),
('45235939278065664','','','40238597734928384',1,1.23,'','/iwallet/department/delByIds/*','删除部门','',3,'delete',0,'','2018-08-24 10:03:49','admin','2018-08-31 17:25:46','admin'),
('84907582589767680',NULL,'quartz-job','39915540965232640',0,2.10,'module/sys/quartz-manage/quartzManage','quartz-job','定时任务','md-time',2,'',0,NULL,'2018-12-11 21:24:46','admin','2018-12-11 21:24:46','admin'),
('84907899767230464',NULL,'','84907582589767680',1,2.11,'','/mozi/quartzJob/add*','添加定时任务','',3,'add',0,NULL,'2018-12-11 21:26:02','admin','2018-12-11 21:26:02','admin'),
('84908172535402496',NULL,'','84907582589767680',1,2.12,'','/mozi/quartzJob/edit*','编辑定时任务','',3,'edit',0,NULL,'2018-12-11 21:27:07','admin','2018-12-11 21:27:07','admin'),
('84908391842975744',NULL,'','84907582589767680',1,2.13,'','/mozi/quartzJob/pause*','暂停定时任务','',3,'disable',0,NULL,'2018-12-11 21:27:59','admin','2018-12-11 21:27:59','admin'),
('84908678297161728',NULL,'','84907582589767680',1,2.14,'','/mozi/quartzJob/resume*','恢复定时任务','',3,'enable',0,NULL,'2018-12-11 21:29:07','admin','2018-12-11 21:29:07','admin'),
('84908899202764800',NULL,'','84907582589767680',1,2.15,'','/mozi/quartzJob/delByIds/*','删除定时任务','',3,'delete',0,NULL,'2018-12-11 21:30:00','admin','2018-12-11 21:30:00','admin');

/*Table structure for table `sys_role` */

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `default_role` bit(1) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `data_type` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `sys_role` */

insert  into `sys_role`(`id`,`name`,`default_role`,`description`,`data_type`,`created_at`,`created_by`,`updated_at`,`updated_by`) values 
('496138616573952','ROLE_ADMIN',NULL,'超级管理员 拥有所有权限',NULL,'2018-04-22 23:03:49','admin','2018-08-12 16:14:31','admin'),
('496138616573953','ROLE_USER','','普通浏览',NULL,'2018-05-02 21:40:03','admin','2019-03-17 18:05:54','admin');

/*Table structure for table `sys_role_permission` */

DROP TABLE IF EXISTS `sys_role_permission`;

CREATE TABLE `sys_role_permission` (
  `id` varchar(255) NOT NULL,
  `permission_id` varchar(255) DEFAULT NULL,
  `role_id` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `sys_role_permission` */

insert  into `sys_role_permission`(`id`,`permission_id`,`role_id`,`created_at`,`created_by`,`updated_at`,`updated_by`) values 
('119647025225535488','41364927394353152','496138616573952','2019-03-17 18:06:54','admin','2019-03-17 18:06:54','admin'),
('119647025221341184','41363537456533504','496138616573952','2019-03-17 18:06:54','admin','2019-03-17 18:06:54','admin'),
('119647025212952576','41363147411427328','496138616573952','2019-03-17 18:06:54','admin','2019-03-17 18:06:54','admin'),
('119647025208758272','84908899202764800','496138616573952','2019-03-17 18:06:54','admin','2019-03-17 18:06:54','admin'),
('119647025204563968','84908678297161728','496138616573952','2019-03-17 18:06:54','admin','2019-03-17 18:06:54','admin'),
('119647025196175360','84908391842975744','496138616573952','2019-03-17 18:06:54','admin','2019-03-17 18:06:54','admin'),
('119647025187786752','84908172535402496','496138616573952','2019-03-17 18:06:54','admin','2019-03-17 18:06:54','admin'),
('119647025183592448','84907899767230464','496138616573952','2019-03-17 18:06:54','admin','2019-03-17 18:06:54','admin'),
('119647025179398144','84907582589767680','496138616573952','2019-03-17 18:06:54','admin','2019-03-17 18:06:54','admin'),
('119647025175203840','39915540965232640','496138616573952','2019-03-17 18:06:54','admin','2019-03-17 18:06:54','admin'),
('119647025166815232','16695243126607872','496138616573952','2019-03-17 18:06:54','admin','2019-03-17 18:06:54','admin'),
('119647025162620928','16695107491205120','496138616573952','2019-03-17 18:06:54','admin','2019-03-17 18:06:54','admin'),
('119647025158426624','16694861252005888','496138616573952','2019-03-17 18:06:54','admin','2019-03-17 18:06:54','admin'),
('119647025150038016','5129710648430595','496138616573952','2019-03-17 18:06:54','admin','2019-03-17 18:06:54','admin'),
('119647025141649408','16690313745666048','496138616573952','2019-03-17 18:06:54','admin','2019-03-17 18:06:54','admin'),
('119647025137455104','16689883993083904','496138616573952','2019-03-17 18:06:54','admin','2019-03-17 18:06:54','admin'),
('119647025133260800','16689745006432256','496138616573952','2019-03-17 18:06:54','admin','2019-03-17 18:06:54','admin'),
('119647025124872192','16689632049631232','496138616573952','2019-03-17 18:06:54','admin','2019-03-17 18:06:54','admin'),
('119647025120677888','16687383932047360','496138616573952','2019-03-17 18:06:54','admin','2019-03-17 18:06:54','admin'),
('119647025116483584','5129710648430594','496138616573952','2019-03-17 18:06:54','admin','2019-03-17 18:06:54','admin'),
('119647025112289280','45235939278065664','496138616573952','2019-03-17 18:06:54','admin','2019-03-17 18:06:54','admin'),
('119647025103900672','45235787867885568','496138616573952','2019-03-17 18:06:54','admin','2019-03-17 18:06:54','admin'),
('119647025099706368','45235621697949696','496138616573952','2019-03-17 18:06:54','admin','2019-03-17 18:06:54','admin'),
('119647025095512064','40238597734928384','496138616573952','2019-03-17 18:06:54','admin','2019-03-17 18:06:54','admin'),
('119647025091317760','16678447719911424','496138616573952','2019-03-17 18:06:54','admin','2019-03-17 18:06:54','admin'),
('119647025082929152','15708892205944832','496138616573952','2019-03-17 18:06:54','admin','2019-03-17 18:06:54','admin'),
('119647025074540544','15701915807518720','496138616573952','2019-03-17 18:06:54','admin','2019-03-17 18:06:54','admin'),
('119647025070346240','16678126574637056','496138616573952','2019-03-17 18:06:54','admin','2019-03-17 18:06:54','admin'),
('119647025061957632','15701400130424832','496138616573952','2019-03-17 18:06:54','admin','2019-03-17 18:06:54','admin'),
('119647025049374720','5129710648430592','496138616573952','2019-03-17 18:06:54','admin','2019-03-17 18:06:54','admin'),
('119647025057763328','5129710648430593','496138616573952','2019-03-17 18:06:54','admin','2019-03-17 18:06:54','admin'),
('119646812435910656','41363147411427328','496138616573953','2019-03-17 18:06:04','admin','2019-03-17 18:06:04','admin'),
('119646812427522048','84907582589767680','496138616573953','2019-03-17 18:06:04','admin','2019-03-17 18:06:04','admin'),
('119646812419133440','39915540965232640','496138616573953','2019-03-17 18:06:04','admin','2019-03-17 18:06:04','admin'),
('119646812410744832','5129710648430595','496138616573953','2019-03-17 18:06:04','admin','2019-03-17 18:06:04','admin'),
('119646812402356224','5129710648430594','496138616573953','2019-03-17 18:06:04','admin','2019-03-17 18:06:04','admin'),
('119646812393967616','40238597734928384','496138616573953','2019-03-17 18:06:04','admin','2019-03-17 18:06:04','admin'),
('119646812385579008','5129710648430593','496138616573953','2019-03-17 18:06:04','admin','2019-03-17 18:06:04','admin'),
('119646812377190400','5129710648430592','496138616573953','2019-03-17 18:06:04','admin','2019-03-17 18:06:04','admin');

/*Table structure for table `user_info` */

DROP TABLE IF EXISTS `user_info`;

CREATE TABLE `user_info` (
  `id` varchar(255) NOT NULL,
  `username` varchar(32) NOT NULL DEFAULT '' COMMENT '用户名',
  `mobile` varchar(32) NOT NULL DEFAULT '' COMMENT '手机号',
  `password` varchar(64) DEFAULT '' COMMENT '密码',
  `email` varchar(32) DEFAULT '' COMMENT '邮箱',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `user_info` */

insert  into `user_info`(`id`,`username`,`mobile`,`password`,`email`,`status`,`created_at`,`created_by`,`updated_at`,`updated_by`) values 
('117411635341037568','test2','13555555555','14e1b600b1fd579f47433b88e8d85291','',1,NULL,NULL,NULL,NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
