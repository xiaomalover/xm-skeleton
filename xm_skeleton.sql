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
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) NOT NULL DEFAULT '',
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

/*Data for the table `article_category` */

insert  into `article_category`(`id`,`is_parent`,`parent_id`,`sort_no`,`title`,`short_title`,`relations`,`status`,`created_at`,`created_by`,`updated_at`,`updated_by`) values 
('126487778832683008',NULL,'126487652370223104',1.00,'最新动态','最新动态','126487652370223104,126487778832683008',0,'2019-04-05 15:09:37','admin','2019-04-05 23:50:57','admin'),
('126487628886315008','','0',1.00,'公司动态','asfdas','126487628886315008',0,'2019-04-05 15:09:01','admin','2019-04-06 00:45:19','admin'),
('126487652370223104','','0',1.00,'行业动态','行业动态','126487652370223104',0,'2019-04-05 15:09:07','admin','2019-04-05 23:50:14','admin'),
('126487695848378368','','126487628886315008',1.00,'生日会','dddd','126487628886315008,126487695848378368',0,'2019-04-05 15:09:17','admin','2019-04-05 15:12:41','admin'),
('126487731625791488',NULL,'126487695848378368',1.00,'员工生日会','员工生日会','126487695848378368,126487731625791488',0,'2019-04-05 15:09:26','admin','2019-04-05 23:51:20','admin');

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
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态（0启用;1禁用）',
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) NOT NULL DEFAULT '',
  `updated_at` datetime DEFAULT NULL,
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
('quartzScheduler','com.xm.admin.quartz.jobs.JobWithoutParam','DEFAULT','*/5 * * * * ?','Asia/Shanghai'),
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
  `id` varchar(32) NOT NULL,
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
('119642809568333824','2019-03-17 17:50:09','admin','2019-04-06 00:48:14','admin','*/5 * * * * ?','无参数定时任务','com.xm.admin.quartz.jobs.JobWithoutParam','null',-1),
('95632048328282112','2019-01-10 11:39:58','null','2019-04-06 00:48:18','null','*/5 * * * * ?','有参测试任务','com.xm.admin.quartz.jobs.JobWithParam','Test Job',-1);

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
('quartzScheduler','com.xm.admin.quartz.jobs.JobWithoutParam','DEFAULT','com.xm.admin.quartz.jobs.JobWithoutParam','DEFAULT',NULL,1554482892225,1554478735000,5,'PAUSED','CRON',1554443034000,0,NULL,0,''),
('quartzScheduler','com.xm.admin.quartz.jobs.JobWithParam','DEFAULT','com.xm.admin.quartz.jobs.JobWithParam','DEFAULT',NULL,1554482896648,1554478740000,5,'PAUSED','CRON',1554443039000,0,NULL,0,'');

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
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `type` tinyint(1) NOT NULL DEFAULT '1',
  `username` varchar(32) DEFAULT NULL,
  `department_id` varchar(32) NOT NULL DEFAULT '',
  `street` varchar(255) NOT NULL DEFAULT '',
  `pass_strength` varchar(2) NOT NULL DEFAULT '',
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) NOT NULL DEFAULT '',
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `sys_admin` */

insert  into `sys_admin`(`id`,`address`,`avatar`,`description`,`email`,`mobile`,`nick_name`,`password`,`sex`,`status`,`type`,`username`,`department_id`,`street`,`pass_strength`,`created_at`,`created_by`,`updated_at`,`updated_by`) values 
('47599079840026624','[\"440000\",\"440300\",\"440305\"]','','','xiaomalover@gmail.com','13888888888','','$2a$10$zXdiP.pMKunw8CmWdahPFunxnjfuXjcEvJdzFAcp79UazQTxb78P2',1,0,1,'admin','87335940934078464','','','2018-08-30 22:34:06','admin','2019-04-05 23:39:42','admin'),
('87338083204206592','[\"440000\",\"440300\",\"440305\"]','','','a@b.com','13333333333','','$2a$10$zXdiP.pMKunw8CmWdahPFunxnjfuXjcEvJdzFAcp79UazQTxb78P2',1,0,1,'test','87336063856545792','','','2018-12-18 14:22:43','admin','2019-04-05 23:35:54','admin');

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
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) NOT NULL DEFAULT '',
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `sys_admin_log` */

insert  into `sys_admin_log`(`id`,`cost_time`,`ip`,`ip_info`,`name`,`request_param`,`request_type`,`request_url`,`username`,`created_at`,`created_by`,`updated_at`,`updated_by`) values 
('119645227853025280',6,'127.0.0.1','','暂停定时任务','{\"cronExpression\":\"*/5 * * * * ?\",\"createdAt\":\"2019-03-17 17:50:09.0\",\"updatedBy\":\"admin\",\"_index\":\"0\",\"createdBy\":\"admin\",\"jobClassName\":\"com.xm.admin.quartz.jobs.JobWithoutParam\",\"parameter\":\"null\",\"description\":\"无参数定时任务\",\"id\":\"119642809568333824\",\"updatedAt\":\"2019-03-17 17:50:25.0\",\"status\":\"0\",\"_rowKey\":\"25\"}','POST','/skeleton/quartzJob/pause','admin','2019-03-17 17:59:46','admin','2019-03-17 17:59:46','admin'),
('119645579809656832',2,'127.0.0.1','','登录系统','{\"password\":\"你是看不见我的\",\"captcha\":\"qhuh\",\"saveLogin\":\"true\",\"captchaId\":\"5728a6ed40f34b5fb53e9ccf0c45ae9e\",\"username\":\"admin\"}','POST','/skeleton/login','admin','2019-03-17 18:01:10','admin','2019-03-17 18:01:10','admin'),
('119649717624770560',14,'127.0.0.1','','登录系统','{\"password\":\"你是看不见我的\",\"captcha\":\"tfoz\",\"saveLogin\":\"true\",\"captchaId\":\"18414be1b2684471a154223d2346b41a\",\"username\":\"test\"}','POST','/skeleton/login','admin','2019-03-17 18:17:36','admin','2019-03-17 18:17:36','admin'),
('119649827846885376',2,'127.0.0.1','','登录系统','{\"password\":\"你是看不见我的\",\"captcha\":\"dbls\",\"saveLogin\":\"true\",\"captchaId\":\"f42664a9f4aa4faf90f2667f01bef757\",\"username\":\"admin\"}','POST','/skeleton/login','admin','2019-03-17 18:18:02','admin','2019-03-17 18:18:02','admin'),
('126466195078516736',6,'127.0.0.1','','恢复定时任务','{\"cronExpression\":\"*/5 * * * * ?\",\"createdAt\":\"2019-03-17 17:50:09.0\",\"updatedBy\":\"admin\",\"_index\":\"0\",\"createdBy\":\"admin\",\"jobClassName\":\"com.xm.admin.quartz.jobs.JobWithoutParam\",\"parameter\":\"null\",\"description\":\"无参数定时任务\",\"id\":\"119642809568333824\",\"updatedAt\":\"2019-03-17 17:59:46.0\",\"status\":\"-1\",\"_rowKey\":\"11\"}','POST','/skeleton/quartzJob/resume','admin','2019-04-05 13:43:51','admin','2019-04-05 13:43:51','admin'),
('126466214217125888',6,'127.0.0.1','','暂停定时任务','{\"cronExpression\":\"*/5 * * * * ?\",\"createdAt\":\"2019-03-17 17:50:09.0\",\"updatedBy\":\"admin\",\"_index\":\"0\",\"createdBy\":\"admin\",\"jobClassName\":\"com.xm.admin.quartz.jobs.JobWithoutParam\",\"parameter\":\"null\",\"description\":\"无参数定时任务\",\"id\":\"119642809568333824\",\"updatedAt\":\"2019-04-05 13:43:54.0\",\"status\":\"0\",\"_rowKey\":\"13\"}','POST','/skeleton/quartzJob/pause','admin','2019-04-05 13:43:56','admin','2019-04-05 13:43:56','admin'),
('126466219883630592',7,'127.0.0.1','','恢复定时任务','{\"cronExpression\":\"*/5 * * * * ?\",\"createdAt\":\"2019-03-17 17:50:09.0\",\"updatedBy\":\"admin\",\"_index\":\"0\",\"createdBy\":\"admin\",\"jobClassName\":\"com.xm.admin.quartz.jobs.JobWithoutParam\",\"parameter\":\"null\",\"description\":\"无参数定时任务\",\"id\":\"119642809568333824\",\"updatedAt\":\"2019-04-05 13:43:56.0\",\"status\":\"-1\",\"_rowKey\":\"15\"}','POST','/skeleton/quartzJob/resume','admin','2019-04-05 13:43:57','admin','2019-04-05 13:43:57','admin'),
('126466237076082688',5,'127.0.0.1','','暂停定时任务','{\"cronExpression\":\"*/5 * * * * ?\",\"createdAt\":\"2019-01-10 11:39:58.0\",\"updatedBy\":\"null\",\"_index\":\"1\",\"createdBy\":\"null\",\"jobClassName\":\"com.xm.admin.quartz.jobs.JobWithParam\",\"parameter\":\"Test Job\",\"description\":\"有参测试任务\",\"id\":\"95632048328282112\",\"updatedAt\":\"2019-04-05 13:43:59.0\",\"status\":\"0\",\"_rowKey\":\"20\"}','POST','/skeleton/quartzJob/pause','admin','2019-04-05 13:44:01','admin','2019-04-05 13:44:01','admin'),
('126466244101541888',5,'127.0.0.1','','恢复定时任务','{\"cronExpression\":\"*/5 * * * * ?\",\"createdAt\":\"2019-01-10 11:39:58.0\",\"updatedBy\":\"null\",\"_index\":\"1\",\"createdBy\":\"null\",\"jobClassName\":\"com.xm.admin.quartz.jobs.JobWithParam\",\"parameter\":\"Test Job\",\"description\":\"有参测试任务\",\"id\":\"95632048328282112\",\"updatedAt\":\"2019-04-05 13:44:01.0\",\"status\":\"-1\",\"_rowKey\":\"22\"}','POST','/skeleton/quartzJob/resume','admin','2019-04-05 13:44:03','admin','2019-04-05 13:44:03','admin'),
('126479222037286912',42,'127.0.0.1','','登录系统','{\"password\":\"你是看不见我的\",\"captcha\":\"nots\",\"saveLogin\":\"true\",\"captchaId\":\"201b3585aef44001bb629e7ac64334ea\",\"username\":\"admin\"}','POST','/skeleton/login','admin','2019-04-05 14:35:37','admin','2019-04-05 14:35:37','admin'),
('126495308304617472',224,'127.0.0.1','','登录系统','{\"password\":\"你是看不见我的\",\"captcha\":\"oioj\",\"saveLogin\":\"true\",\"captchaId\":\"2456b37bfbf04fcfbe27a56f1885b6b1\",\"username\":\"admin\"}','POST','/skeleton/login','admin','2019-04-05 15:39:32','admin','2019-04-05 15:39:32','admin'),
('126615966955081728',38,'127.0.0.1','','暂停定时任务','{\"cronExpression\":\"*/5 * * * * ?\",\"createdAt\":\"2019-03-17 17:50:09.0\",\"updatedBy\":\"admin\",\"_index\":\"0\",\"createdBy\":\"admin\",\"jobClassName\":\"com.xm.admin.quartz.jobs.JobWithoutParam\",\"parameter\":\"null\",\"description\":\"无参数定时任务\",\"id\":\"119642809568333824\",\"updatedAt\":\"2019-04-05 13:43:57.0\",\"status\":\"0\",\"_rowKey\":\"9\"}','POST','/skeleton/quartzJob/pause','admin','2019-04-05 23:38:59','admin','2019-04-05 23:38:59','admin'),
('126615974664212480',6,'127.0.0.1','','暂停定时任务','{\"cronExpression\":\"*/5 * * * * ?\",\"createdAt\":\"2019-01-10 11:39:58.0\",\"updatedBy\":\"null\",\"_index\":\"1\",\"createdBy\":\"null\",\"jobClassName\":\"com.xm.admin.quartz.jobs.JobWithParam\",\"parameter\":\"Test Job\",\"description\":\"有参测试任务\",\"id\":\"95632048328282112\",\"updatedAt\":\"2019-04-05 13:44:03.0\",\"status\":\"0\",\"_rowKey\":\"12\"}','POST','/skeleton/quartzJob/pause','admin','2019-04-05 23:39:01','admin','2019-04-05 23:39:01','admin'),
('126617128156532736',20,'127.0.0.1','','登录系统','{\"password\":\"你是看不见我的\",\"captcha\":\"zkgq\",\"saveLogin\":\"true\",\"captchaId\":\"61782457a2ff4c298b36ca378bfb98d6\",\"username\":\"admin\"}','POST','/skeleton/login','admin','2019-04-05 23:43:36','admin','2019-04-05 23:43:36','admin'),
('126618659585003520',2,'127.0.0.1','','登录系统','{\"password\":\"你是看不见我的\",\"captcha\":\"lxxn\",\"saveLogin\":\"true\",\"captchaId\":\"2aca978c53e4470593e5f74319668ce7\",\"username\":\"admin\"}','POST','/skeleton/login','admin','2019-04-05 23:49:41','admin','2019-04-05 23:49:41','admin'),
('126631989586432000',26,'127.0.0.1','','登录系统','{\"password\":\"你是看不见我的\",\"captcha\":\"zgml\",\"saveLogin\":\"true\",\"captchaId\":\"43f839e75d9846d3a50809645697f3a1\",\"username\":\"admin\"}','POST','/skeleton/login','admin','2019-04-06 00:42:40','admin','2019-04-06 00:42:40','admin'),
('126632101914087424',2,'127.0.0.1','','登录系统','{\"password\":\"你是看不见我的\",\"captcha\":\"yirb\",\"saveLogin\":\"true\",\"captchaId\":\"4487eaf81b0a4b1aa23cbb501bdaf93c\",\"username\":\"test\"}','POST','/skeleton/login','admin','2019-04-06 00:43:06','admin','2019-04-06 00:43:06','admin'),
('126632637161803776',1,'127.0.0.1','','登录系统','{\"password\":\"你是看不见我的\",\"captcha\":\"fnyl\",\"saveLogin\":\"true\",\"captchaId\":\"42c27eedac5c4e768fef97c41e47befb\",\"username\":\"admin\"}','POST','/skeleton/login','admin','2019-04-06 00:45:14','admin','2019-04-06 00:45:14','admin'),
('126633383043272704',76,'127.0.0.1','','恢复定时任务','{\"cronExpression\":\"*/5 * * * * ?\",\"createdAt\":\"2019-03-17 17:50:09.0\",\"updatedBy\":\"admin\",\"_index\":\"0\",\"createdBy\":\"admin\",\"jobClassName\":\"com.xm.admin.quartz.jobs.JobWithoutParam\",\"parameter\":\"null\",\"description\":\"无参数定时任务\",\"id\":\"119642809568333824\",\"updatedAt\":\"2019-04-05 23:38:59.0\",\"status\":\"-1\",\"_rowKey\":\"41\"}','POST','/skeleton/quartzJob/resume','admin','2019-04-06 00:48:12','admin','2019-04-06 00:48:12','admin'),
('126633393168322560',8,'127.0.0.1','','暂停定时任务','{\"cronExpression\":\"*/5 * * * * ?\",\"createdAt\":\"2019-03-17 17:50:09.0\",\"updatedBy\":\"admin\",\"_index\":\"0\",\"createdBy\":\"admin\",\"jobClassName\":\"com.xm.admin.quartz.jobs.JobWithoutParam\",\"parameter\":\"null\",\"description\":\"无参数定时任务\",\"id\":\"119642809568333824\",\"updatedAt\":\"2019-04-06 00:48:12.0\",\"status\":\"0\",\"_rowKey\":\"43\"}','POST','/skeleton/quartzJob/pause','admin','2019-04-06 00:48:14','admin','2019-04-06 00:48:14','admin'),
('126633401473044480',19,'127.0.0.1','','恢复定时任务','{\"cronExpression\":\"*/5 * * * * ?\",\"createdAt\":\"2019-01-10 11:39:58.0\",\"updatedBy\":\"null\",\"_index\":\"1\",\"createdBy\":\"null\",\"jobClassName\":\"com.xm.admin.quartz.jobs.JobWithParam\",\"parameter\":\"Test Job\",\"description\":\"有参测试任务\",\"id\":\"95632048328282112\",\"updatedAt\":\"2019-04-05 23:39:01.0\",\"status\":\"-1\",\"_rowKey\":\"46\"}','POST','/skeleton/quartzJob/resume','admin','2019-04-06 00:48:16','admin','2019-04-06 00:48:16','admin'),
('126633408297177088',11,'127.0.0.1','','暂停定时任务','{\"cronExpression\":\"*/5 * * * * ?\",\"createdAt\":\"2019-01-10 11:39:58.0\",\"updatedBy\":\"null\",\"_index\":\"1\",\"createdBy\":\"null\",\"jobClassName\":\"com.xm.admin.quartz.jobs.JobWithParam\",\"parameter\":\"Test Job\",\"description\":\"有参测试任务\",\"id\":\"95632048328282112\",\"updatedAt\":\"2019-04-06 00:48:16.0\",\"status\":\"0\",\"_rowKey\":\"48\"}','POST','/skeleton/quartzJob/pause','admin','2019-04-06 00:48:18','admin','2019-04-06 00:48:18','admin');

/*Table structure for table `sys_admin_role` */

DROP TABLE IF EXISTS `sys_admin_role`;

CREATE TABLE `sys_admin_role` (
  `id` varchar(32) NOT NULL,
  `role_id` varchar(32) NOT NULL DEFAULT '',
  `user_id` varchar(32) NOT NULL DEFAULT '',
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) NOT NULL DEFAULT '',
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `sys_admin_role` */

insert  into `sys_admin_role`(`id`,`role_id`,`user_id`,`created_at`,`created_by`,`updated_at`,`updated_by`) values 
('51919463095734273','496138616573953','51919414177566720','2018-09-11 20:41:46','admin','2018-09-11 20:41:46','admin'),
('126616146991386624','496138616573952','47599079840026624','2019-04-05 23:39:42','admin','2019-04-05 23:39:42','admin'),
('126477266149445632','496138616573953','87338083204206592','2019-04-05 14:27:51','admin','2019-04-05 14:27:51','admin'),
('116844842029420544','496138616573952','116844841647738880','2019-03-10 00:32:02','admin','2019-03-10 00:32:02','admin'),
('116847350214823936','496138616573952','116846552936353792','2019-03-10 00:42:00','admin','2019-03-10 00:42:00','admin'),
('116851632993472512','116849032776650752','116847659427303424','2019-03-10 00:59:01','admin','2019-03-10 00:59:01','admin'),
('116850548648448000','496138616573952','116848891118227456','2019-03-10 00:54:42','admin','2019-03-10 00:54:42','admin'),
('117180303184760832','496138616573953','117180302777913344','2019-03-10 22:45:02','admin','2019-03-10 22:45:02','admin');

/*Table structure for table `sys_department` */

DROP TABLE IF EXISTS `sys_department`;

CREATE TABLE `sys_department` (
  `id` varchar(32) NOT NULL,
  `is_parent` bit(1) DEFAULT NULL,
  `parent_id` varchar(32) NOT NULL DEFAULT '',
  `sort_order` decimal(10,2) NOT NULL DEFAULT '0.00',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `title` varchar(64) NOT NULL DEFAULT '',
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) NOT NULL DEFAULT '',
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) NOT NULL DEFAULT '',
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
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `url` varchar(255) NOT NULL DEFAULT '',
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) NOT NULL DEFAULT '',
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `sys_permission` */

insert  into `sys_permission`(`id`,`description`,`name`,`parent_id`,`type`,`sort_order`,`component`,`path`,`title`,`icon`,`level`,`button_type`,`status`,`url`,`created_at`,`created_by`,`updated_at`,`updated_by`) values 
('5129710648430592','','sys','',0,3.00,'Main','/form','系统管理','ios-settings',1,'',0,'','2018-06-04 19:02:29','admin','2018-09-04 22:50:52','admin'),
('5129710648430593','','user-manage','5129710648430592',0,1.10,'module/sys/user-manage/userManage','user-manage','管理员管理','md-person',2,'',0,'','2018-06-04 19:02:32','admin','2018-09-03 16:06:57','admin'),
('5129710648430594','','role-manage','5129710648430592',0,1.50,'module/sys/role-manage/roleManage','role-manage','角色管理','md-contacts',2,'',0,'','2018-06-04 19:02:35','admin','2018-08-23 17:31:27','admin'),
('5129710648430595','','menu-manage','5129710648430592',0,1.60,'module/sys/menu-manage/menuManage','menu-manage','菜单权限管理','md-menu',2,'',0,'','2018-06-04 19:02:37','admin','2018-08-23 17:31:33','admin'),
('15701400130424832','','','5129710648430593',1,1.11,'','/skeleton/user/admin/add','添加用户','',3,'add',0,'','2018-06-03 22:04:06','admin','2018-08-31 17:24:08','admin'),
('15701915807518720','','','5129710648430593',1,1.13,'','/skeleton/user/admin/disable/**','禁用用户','',3,'disable',0,'','2018-06-03 22:06:09','admin','2018-08-31 17:24:39','admin'),
('15708892205944832','','','5129710648430593',1,1.14,'','/skeleton/user/admin/enable/**','启用用户','',3,'enable',0,'','2018-06-03 22:33:52','admin','2018-08-31 17:24:52','admin'),
('16678126574637056','','','5129710648430593',1,1.12,'','/skeleton/user/admin/edit','编辑用户','',3,'edit',0,'','2018-06-06 14:45:16','admin','2018-08-31 17:24:23','admin'),
('16678447719911424','','','5129710648430593',1,1.15,'','/skeleton/user/delByIds/**','删除用户','',3,'delete',0,'','2018-06-06 14:46:32','admin','2018-08-31 17:25:07','admin'),
('16687383932047360','','','5129710648430594',1,1.21,'','/skeleton/role/save','添加角色','',3,'add',0,'','2018-06-06 15:22:03','admin','2018-08-31 17:26:02','admin'),
('16689632049631232','','','5129710648430594',1,1.22,'','/skeleton/role/edit','编辑角色','',3,'edit',0,'','2018-06-06 15:30:59','admin','2018-08-31 17:26:13','admin'),
('16689745006432256','','','5129710648430594',1,1.23,'','/skeleton/role/delAllByIds/**','删除角色','',3,'delete',0,'','2018-06-06 15:31:26','admin','2018-08-31 17:26:23','admin'),
('16689883993083904','','','5129710648430594',1,1.24,'','/skeleton/role/editRolePerm/**','分配权限','',3,'editPerm',0,'','2018-06-06 15:31:59','admin','2018-08-31 17:26:45','admin'),
('16690313745666048','','','5129710648430594',1,1.25,'','/skeleton/role/setDefault','设为默认角色','',3,'setDefault',0,'','2018-06-06 15:33:41','admin','2018-08-31 17:27:00','admin'),
('16694861252005888','','','5129710648430595',1,1.31,'','/skeleton/permission/add','添加菜单','',3,'add',0,'','2018-06-06 15:51:46','admin','2018-08-31 17:27:14','admin'),
('16695107491205120','','','5129710648430595',1,1.32,'','/skeleton/permission/edit','编辑菜单','',3,'edit',0,'','2018-06-06 15:52:44','admin','2018-08-31 17:27:21','admin'),
('16695243126607872','','','5129710648430595',1,1.33,'','/skeleton/permission/delByIds/**','删除菜单','',3,'delete',0,'','2018-06-06 15:53:17','admin','2018-08-31 17:27:31','admin'),
('39915540965232640','','monitor','',0,4.00,'Main','/monitor','系统监控','ios-analytics',1,'',0,'','2018-08-09 17:42:28','admin','2018-09-04 22:50:47','admin'),
('40238597734928384','','department-manage','5129710648430592',0,1.20,'module/sys/department-manage/departmentManage','department-manage','部门管理','md-git-branch',2,'',0,'','2018-08-10 15:06:10','admin','2018-08-10 15:06:10','admin'),
('41363147411427328','','log-manage','39915540965232640',0,2.20,'module/sys/log-manage/logManage','log-manage','操作日志管理','md-list-box',2,'',0,'','2018-08-13 17:34:43','admin','2018-08-20 20:05:21','admin'),
('41363537456533504','','','41363147411427328',1,2.11,'','/skeleton/log/delByIds/**','删除日志','',3,'delete',0,'','2018-08-13 17:36:16','admin','2018-08-31 17:28:04','admin'),
('41364927394353152','','','41363147411427328',1,2.12,'','/skeleton/log/delAll','清空日志','',3,'undefined',0,'','2018-08-13 17:41:48','admin','2018-08-31 17:28:13','admin'),
('45235621697949696','','','40238597734928384',1,1.21,'','/skeleton/department/add','添加部门','',3,'add',0,'','2018-08-24 10:02:33','admin','2018-08-31 17:25:26','admin'),
('45235787867885568','','','40238597734928384',1,1.22,'','/skeleton/department/edit','编辑部门','',3,'edit',0,'','2018-08-24 10:03:13','admin','2018-08-31 17:25:36','admin'),
('45235939278065664','','','40238597734928384',1,1.23,'','/skeleton/department/delByIds/*','删除部门','',3,'delete',0,'','2018-08-24 10:03:49','admin','2018-08-31 17:25:46','admin'),
('84907582589767680','','quartz-job','39915540965232640',0,2.10,'module/sys/quartz-manage/quartzManage','quartz-job','定时任务','md-time',2,'',0,'','2018-12-11 21:24:46','admin','2018-12-11 21:24:46','admin'),
('84907899767230464','','','84907582589767680',1,2.11,'','/skeleton/quartzJob/add*','添加定时任务','',3,'add',0,'','2018-12-11 21:26:02','admin','2018-12-11 21:26:02','admin'),
('84908172535402496','','','84907582589767680',1,2.12,'','/skeleton/quartzJob/edit*','编辑定时任务','',3,'edit',0,'','2018-12-11 21:27:07','admin','2018-12-11 21:27:07','admin'),
('84908391842975744','','','84907582589767680',1,2.13,'','/skeleton/quartzJob/pause*','暂停定时任务','',3,'disable',0,'','2018-12-11 21:27:59','admin','2018-12-11 21:27:59','admin'),
('84908678297161728','','','84907582589767680',1,2.14,'','/skeleton/quartzJob/resume*','恢复定时任务','',3,'enable',0,'','2018-12-11 21:29:07','admin','2018-12-11 21:29:07','admin'),
('84908899202764800','','','84907582589767680',1,2.15,'','/skeleton/quartzJob/delByIds/*','删除定时任务','',3,'delete',0,'','2018-12-11 21:30:00','admin','2018-12-11 21:30:00','admin'),
('126477677677776896','','article','',0,1.00,'Main','/article','文章管理','ios-book',1,'',0,'','2019-04-05 14:29:29','admin','2019-04-05 14:29:29','admin'),
('126478074127585280','','articleCategory','126477677677776896',0,1.00,'module/article/category/categoryManage','module/article/category','分类管理','md-bookmarks',2,'',0,'','2019-04-05 14:31:03','admin','2019-04-05 14:31:03','admin'),
('126495528849510400','','articleInfo','126477677677776896',0,1.00,'module/article/info/articleManage','module/article/info','文章管理','ios-book-outline',2,'',0,'','2019-04-05 15:40:25','admin','2019-04-05 16:49:37','admin'),
('126612524110974976','','','126478074127585280',1,1.00,'','/skeleton/article/category/add','添加分类','',3,'add',0,'','2019-04-05 23:25:19','admin','2019-04-05 23:28:31','admin'),
('126612730214879232','','','126478074127585280',1,1.00,'','/skeleton/article/category/edit','修改分类','',3,'edit',0,'','2019-04-05 23:26:08','admin','2019-04-05 23:28:40','admin'),
('126613271254929408','','','126478074127585280',1,1.00,'','/skeleton/article/category/delByIds/**','删除分类','',3,'delete',0,'','2019-04-05 23:28:17','admin','2019-04-05 23:49:19','admin'),
('126613728463425536','','','126495528849510400',1,1.00,'','/skeleton/article/add','添加文章','',3,'add',0,'','2019-04-05 23:30:06','admin','2019-04-05 23:30:06','admin'),
('126613843764842496','','','126495528849510400',1,1.00,'','/skeleton/article/delByIds/**','删除文章','',3,'delete',0,'','2019-04-05 23:30:33','admin','2019-04-05 23:31:16','admin'),
('126613956428042240','','','126495528849510400',1,1.00,'','/skeleton/article/edit','修改文章','',3,'edit',0,'','2019-04-05 23:31:00','admin','2019-04-05 23:31:00','admin'),
('126614281000062976','','','126495528849510400',1,1.00,'','/skeleton/article/enable/**','启用文章','',3,'enable',0,'','2019-04-05 23:32:17','admin','2019-04-05 23:32:17','admin'),
('126614454480670720','','','126495528849510400',1,1.00,'','/skeleton/article/disable/**','禁用文章','',3,'disable',0,'','2019-04-05 23:32:59','admin','2019-04-05 23:32:59','admin');

/*Table structure for table `sys_role` */

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
  `id` varchar(32) NOT NULL,
  `name` varchar(32) NOT NULL DEFAULT '',
  `default_role` bit(1) DEFAULT NULL,
  `description` varchar(255) NOT NULL DEFAULT '',
  `data_type` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) NOT NULL DEFAULT '',
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `sys_role` */

insert  into `sys_role`(`id`,`name`,`default_role`,`description`,`data_type`,`created_at`,`created_by`,`updated_at`,`updated_by`) values 
('496138616573952','ROLE_ADMIN','','超级管理员 拥有所有权限',NULL,'2018-04-22 23:03:49','admin','2019-04-05 23:39:31','admin'),
('496138616573953','ROLE_USER','\0','普通浏览',NULL,'2018-05-02 21:40:03','admin','2019-04-05 23:39:25','admin');

/*Table structure for table `sys_role_permission` */

DROP TABLE IF EXISTS `sys_role_permission`;

CREATE TABLE `sys_role_permission` (
  `id` varchar(32) NOT NULL,
  `permission_id` varchar(32) NOT NULL DEFAULT '',
  `role_id` varchar(32) NOT NULL DEFAULT '',
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) NOT NULL DEFAULT '',
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `sys_role_permission` */

insert  into `sys_role_permission`(`id`,`permission_id`,`role_id`,`created_at`,`created_by`,`updated_at`,`updated_by`) values 
('126617812872466432','41364927394353152','496138616573952','2019-04-05 23:46:20','admin','2019-04-05 23:46:20','admin'),
('126617812864077824','41363537456533504','496138616573952','2019-04-05 23:46:20','admin','2019-04-05 23:46:20','admin'),
('126617812859883520','41363147411427328','496138616573952','2019-04-05 23:46:20','admin','2019-04-05 23:46:20','admin'),
('126617812851494912','84908899202764800','496138616573952','2019-04-05 23:46:20','admin','2019-04-05 23:46:20','admin'),
('126617812847300608','84908678297161728','496138616573952','2019-04-05 23:46:20','admin','2019-04-05 23:46:20','admin'),
('126617812843106304','84908391842975744','496138616573952','2019-04-05 23:46:20','admin','2019-04-05 23:46:20','admin'),
('126617812834717696','84908172535402496','496138616573952','2019-04-05 23:46:20','admin','2019-04-05 23:46:20','admin'),
('126617812830523392','84907899767230464','496138616573952','2019-04-05 23:46:20','admin','2019-04-05 23:46:20','admin'),
('126617812826329088','84907582589767680','496138616573952','2019-04-05 23:46:20','admin','2019-04-05 23:46:20','admin'),
('126617812822134784','39915540965232640','496138616573952','2019-04-05 23:46:20','admin','2019-04-05 23:46:20','admin'),
('126617812813746176','16695243126607872','496138616573952','2019-04-05 23:46:20','admin','2019-04-05 23:46:20','admin'),
('126617812809551872','16695107491205120','496138616573952','2019-04-05 23:46:20','admin','2019-04-05 23:46:20','admin'),
('126617812801163264','16694861252005888','496138616573952','2019-04-05 23:46:20','admin','2019-04-05 23:46:20','admin'),
('126617812792774656','5129710648430595','496138616573952','2019-04-05 23:46:20','admin','2019-04-05 23:46:20','admin'),
('126617812788580352','16690313745666048','496138616573952','2019-04-05 23:46:20','admin','2019-04-05 23:46:20','admin'),
('126617812784386048','16689883993083904','496138616573952','2019-04-05 23:46:20','admin','2019-04-05 23:46:20','admin'),
('126617812780191744','16689745006432256','496138616573952','2019-04-05 23:46:20','admin','2019-04-05 23:46:20','admin'),
('126617812775997440','16689632049631232','496138616573952','2019-04-05 23:46:20','admin','2019-04-05 23:46:20','admin'),
('126617812767608832','16687383932047360','496138616573952','2019-04-05 23:46:20','admin','2019-04-05 23:46:20','admin'),
('126617812763414528','5129710648430594','496138616573952','2019-04-05 23:46:20','admin','2019-04-05 23:46:20','admin'),
('126617812759220224','45235939278065664','496138616573952','2019-04-05 23:46:20','admin','2019-04-05 23:46:20','admin'),
('126617812755025920','45235787867885568','496138616573952','2019-04-05 23:46:20','admin','2019-04-05 23:46:20','admin'),
('126617812746637312','45235621697949696','496138616573952','2019-04-05 23:46:20','admin','2019-04-05 23:46:20','admin'),
('126617812742443008','40238597734928384','496138616573952','2019-04-05 23:46:20','admin','2019-04-05 23:46:20','admin'),
('126617812729860096','16678447719911424','496138616573952','2019-04-05 23:46:20','admin','2019-04-05 23:46:20','admin'),
('126617812725665792','15708892205944832','496138616573952','2019-04-05 23:46:20','admin','2019-04-05 23:46:20','admin'),
('126617812721471488','15701915807518720','496138616573952','2019-04-05 23:46:20','admin','2019-04-05 23:46:20','admin'),
('126617812713082880','16678126574637056','496138616573952','2019-04-05 23:46:20','admin','2019-04-05 23:46:20','admin'),
('126617812708888576','15701400130424832','496138616573952','2019-04-05 23:46:20','admin','2019-04-05 23:46:20','admin'),
('126617812700499968','5129710648430593','496138616573952','2019-04-05 23:46:20','admin','2019-04-05 23:46:20','admin'),
('126617812696305664','5129710648430592','496138616573952','2019-04-05 23:46:20','admin','2019-04-05 23:46:20','admin'),
('126632044707975168','5129710648430595','496138616573953','2019-04-06 00:42:53','admin','2019-04-06 00:42:53','admin'),
('126632044703780864','5129710648430594','496138616573953','2019-04-06 00:42:53','admin','2019-04-06 00:42:53','admin'),
('126632044691197952','40238597734928384','496138616573953','2019-04-06 00:42:53','admin','2019-04-06 00:42:53','admin'),
('126632044682809344','5129710648430593','496138616573953','2019-04-06 00:42:53','admin','2019-04-06 00:42:53','admin'),
('126632044678615040','5129710648430592','496138616573953','2019-04-06 00:42:53','admin','2019-04-06 00:42:53','admin'),
('126632044666032128','126495528849510400','496138616573953','2019-04-06 00:42:53','admin','2019-04-06 00:42:53','admin'),
('126632044661837824','126478074127585280','496138616573953','2019-04-06 00:42:53','admin','2019-04-06 00:42:53','admin'),
('126632044645060608','126477677677776896','496138616573953','2019-04-06 00:42:53','admin','2019-04-06 00:42:53','admin'),
('126617812692111360','126614454480670720','496138616573952','2019-04-05 23:46:20','admin','2019-04-05 23:46:20','admin'),
('126617812683722752','126614281000062976','496138616573952','2019-04-05 23:46:20','admin','2019-04-05 23:46:20','admin'),
('126617812679528448','126613956428042240','496138616573952','2019-04-05 23:46:19','admin','2019-04-05 23:46:19','admin'),
('126617812671139840','126613843764842496','496138616573952','2019-04-05 23:46:19','admin','2019-04-05 23:46:19','admin'),
('126617812662751232','126613728463425536','496138616573952','2019-04-05 23:46:19','admin','2019-04-05 23:46:19','admin'),
('126617812654362624','126495528849510400','496138616573952','2019-04-05 23:46:19','admin','2019-04-05 23:46:19','admin'),
('126617812645974016','126613271254929408','496138616573952','2019-04-05 23:46:19','admin','2019-04-05 23:46:19','admin'),
('126617812641779712','126612730214879232','496138616573952','2019-04-05 23:46:19','admin','2019-04-05 23:46:19','admin'),
('126617812633391104','126612524110974976','496138616573952','2019-04-05 23:46:19','admin','2019-04-05 23:46:19','admin'),
('126617812625002496','126478074127585280','496138616573952','2019-04-05 23:46:19','admin','2019-04-05 23:46:19','admin'),
('126617812616613888','126477677677776896','496138616573952','2019-04-05 23:46:19','admin','2019-04-05 23:46:19','admin'),
('126632044716363776','39915540965232640','496138616573953','2019-04-06 00:42:53','admin','2019-04-06 00:42:53','admin'),
('126632044720558080','84907582589767680','496138616573953','2019-04-06 00:42:53','admin','2019-04-06 00:42:53','admin'),
('126632044724752384','41363147411427328','496138616573953','2019-04-06 00:42:53','admin','2019-04-06 00:42:53','admin');

/*Table structure for table `user_info` */

DROP TABLE IF EXISTS `user_info`;

CREATE TABLE `user_info` (
  `id` varchar(32) NOT NULL,
  `username` varchar(32) NOT NULL DEFAULT '' COMMENT '用户名',
  `mobile` varchar(32) NOT NULL DEFAULT '' COMMENT '手机号',
  `password` varchar(64) DEFAULT '' COMMENT '密码',
  `email` varchar(32) DEFAULT '' COMMENT '邮箱',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `user_info` */

insert  into `user_info`(`id`,`username`,`mobile`,`password`,`email`,`status`,`created_at`,`created_by`,`updated_at`,`updated_by`) values 
('117411635341037568','test','13333333333','14e1b600b1fd579f47433b88e8d85291','',1,'0000-00-00 00:00:00','','0000-00-00 00:00:00','');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
