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

insert  into `qrtz_fired_triggers`(`SCHED_NAME`,`ENTRY_ID`,`TRIGGER_NAME`,`TRIGGER_GROUP`,`INSTANCE_NAME`,`FIRED_TIME`,`SCHED_TIME`,`PRIORITY`,`STATE`,`JOB_NAME`,`JOB_GROUP`,`IS_NONCONCURRENT`,`REQUESTS_RECOVERY`) values 
('quartzScheduler','NON_CLUSTERED1546423679087','com.xm.admin.quartz.jobs.JobWithoutParam','DEFAULT','NON_CLUSTERED',1546426295138,1546426300000,5,'ACQUIRED',NULL,NULL,'0','0');

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
('quartzScheduler','com.xm.admin.quartz.jobs.JobWithoutParam','DEFAULT',NULL,'com.xm.admin.quartz.jobs.JobWithoutParam','0','0','0','0','��\0sr\0org.quartz.JobDataMap���迩��\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�����](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap�.�(v\n�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap���`�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0	parametert\0\0x\0'),
('quartzScheduler','com.xm.admin.quartz.jobs.JobWithParam','DEFAULT',NULL,'com.xm.admin.quartz.jobs.JobWithParam','0','0','0','0','��\0sr\0org.quartz.JobDataMap���迩��\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�����](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap�.�(v\n�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap���`�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0	parametert\0Testx\0');

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
('92832657997565952','2019-01-02 18:16:11','','2019-01-02 18:17:40','','*/5 * * * * ?','无参测试任务','com.xm.admin.quartz.jobs.JobWithoutParam','',0),
('92833003532718080','2019-01-02 18:17:33','','2019-01-02 18:17:48','','*/5 * * * * ?','带参定时任务','com.xm.admin.quartz.jobs.JobWithParam','Test',0);

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
('quartzScheduler','com.xm.admin.quartz.jobs.JobWithoutParam','DEFAULT','com.xm.admin.quartz.jobs.JobWithoutParam','DEFAULT',NULL,1546426300000,1546426295000,5,'ACQUIRED','CRON',1546424260000,0,NULL,0,''),
('quartzScheduler','com.xm.admin.quartz.jobs.JobWithParam','DEFAULT','com.xm.admin.quartz.jobs.JobWithParam','DEFAULT',NULL,1546426300000,1546426295000,5,'WAITING','CRON',1546424268000,0,NULL,0,'');

/*Table structure for table `st_admin` */

DROP TABLE IF EXISTS `st_admin`;

CREATE TABLE `st_admin` (
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

/*Data for the table `st_admin` */

insert  into `st_admin`(`id`,`address`,`avatar`,`description`,`email`,`mobile`,`nick_name`,`password`,`sex`,`status`,`type`,`username`,`department_id`,`street`,`pass_strength`,`created_at`,`created_by`,`updated_at`,`updated_by`) values 
('47599079840026624','[\"440000\",\"440300\",\"440305\"]','','','admin@iwallet.com','13888888888','','$2a$10$SCsBTmdrdN0Wvmsvx8xPtuyQ6uh05RlZgE4NZuX4VedxhUYHtTHTK',1,0,1,'admin','87336440425353216',NULL,NULL,'2018-08-30 22:34:06','','2019-01-02 18:11:39',''),
('87338083204206592','[\"440000\",\"440300\",\"440305\"]','','','a@b.com','13888888888','','$2a$10$rO5zHxTKJZI4iWEp9f6cLOgwZDoteB29Ba03farLwioAfdFxNOUQa',1,0,1,'skeleton','87336063856545792',NULL,NULL,'2018-12-18 14:22:43','','2019-01-02 18:11:24','');

/*Table structure for table `st_admin_log` */

DROP TABLE IF EXISTS `st_admin_log`;

CREATE TABLE `st_admin_log` (
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

/*Data for the table `st_admin_log` */

insert  into `st_admin_log`(`id`,`cost_time`,`ip`,`ip_info`,`name`,`request_param`,`request_type`,`request_url`,`username`,`created_at`,`created_by`,`updated_at`,`updated_by`) values 
('91268275308072960',1,'14.20.90.63',NULL,'登录系统','{\"password\":\"你是看不见我的\",\"captcha\":\"cww7\",\"saveLogin\":\"true\",\"captchaId\":\"60b05a1900eb4381a991cdf17774b310\",\"username\":\"mozi\"}','POST','/mozi/login','mozi','2018-12-29 10:39:54',NULL,'2018-12-29 10:39:54',NULL),
('91269185807585280',4,'14.20.90.63',NULL,'修改手机号','{\"address\":\"110000,110100,110105\",\"_index\":\"0\",\"level\":\"4\",\"mobile\":\"13503689667\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"12\",\"recommendNickname\":\"笪思颖\",\"recommendMobile\":\"18532518655\",\"areaNames\":\"北京/北京市/朝阳区\",\"nickname\":\"金湛泓\",\"name\":\"金湛泓\",\"selectAreaFlag\":\"true\",\"ctime\":\"1544554998\",\"id\":\"12011\",\"addressArray\":\"110000,110100,110105\",\"email\":\"\"}','POST','/mozi/agent/changeMobile','mozi','2018-12-29 10:43:31',NULL,'2018-12-29 10:43:31',NULL),
('91249984782995456',1,'116.30.221.148',NULL,'登录系统','{\"password\":\"你是看不见我的\",\"captcha\":\"wqkg\",\"saveLogin\":\"true\",\"captchaId\":\"715c3e6c73a74d2c912c231cb85e146c\",\"username\":\"admin\"}','POST','/mozi/login','admin','2018-12-29 09:27:13',NULL,'2018-12-29 09:27:13',NULL),
('91250342037032960',0,'116.30.221.148',NULL,'登录系统','{\"password\":\"你是看不见我的\",\"captcha\":\"7p3x\",\"saveLogin\":\"true\",\"captchaId\":\"c49087792b17466a8e6009d291de7763\",\"username\":\"shihaikun\"}','POST','/mozi/login','shihaikun','2018-12-29 09:28:38',NULL,'2018-12-29 09:28:38',NULL),
('91250867449106432',1,'116.30.221.148',NULL,'登录系统','{\"password\":\"你是看不见我的\",\"captcha\":\"5xyr\",\"saveLogin\":\"true\",\"captchaId\":\"0371124f325e4df5ab67e1e4eda71ce3\",\"username\":\"admin\"}','POST','/mozi/login','admin','2018-12-29 09:30:43',NULL,'2018-12-29 09:30:43',NULL),
('90950629119234048',1,'113.89.97.31',NULL,'登录系统','{\"password\":\"你是看不见我的\",\"captcha\":\"8ykl\",\"saveLogin\":\"true\",\"captchaId\":\"3e6501fbbfcc4c0b9d82585253c8870a\",\"username\":\"admin\"}','POST','/mozi/login','admin','2018-12-28 13:37:41',NULL,'2018-12-28 13:37:41',NULL),
('90886003102846976',9,'116.30.221.119',NULL,'修改推荐关系','{\"address\":\"320000,320100,320117\",\"_index\":\"0\",\"level\":\"4\",\"mobile\":\"17361977157\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"50\",\"recommendNickname\":\"墨子\",\"recommendMobile\":\"18751962873\",\"areaNames\":\"江苏省/南京市/溧水区\",\"nickname\":\"刘建娥\",\"name\":\"刘建娥\",\"selectAreaFlag\":\"true\",\"ctime\":\"1544898113\",\"id\":\"12342\",\"addressArray\":\"320000,320100,320117\",\"email\":\"\"}','POST','/mozi/agent/changeRelation','mozi','2018-12-28 09:20:53',NULL,'2018-12-28 09:20:53',NULL),
('90885874383851520',8,'116.30.221.119',NULL,'添加代理','{\"recommendNickname\":\"胡丹\",\"recommendMobile\":\"18751962873\",\"address\":\"[\\\"320000\\\",\\\"320100\\\",\\\"320117\\\"]\",\"_index\":\"0\",\"level\":\"4\",\"mobile\":\"17361977157\",\"name\":\"刘建娥\",\"addressArray\":\"320000,320100,320117\",\"selectLevel\":\"2\",\"_rowKey\":\"38\"}','POST','/mozi/agent/add','mozi','2018-12-28 09:20:22',NULL,'2018-12-28 09:20:22',NULL),
('90885263839989760',11,'116.30.221.119',NULL,'添加代理','{\"recommendNickname\":\"胡丹\",\"recommendMobile\":\"18261056567\",\"address\":\"[\\\"340000\\\",\\\"340300\\\",\\\"340304\\\"]\",\"_index\":\"0\",\"level\":\"4\",\"mobile\":\"13956398025\",\"name\":\"李传侠\",\"addressArray\":\"340000,340300,340304\",\"selectLevel\":\"2\",\"_rowKey\":\"38\"}','POST','/mozi/agent/add','mozi','2018-12-28 09:17:56',NULL,'2018-12-28 09:17:56',NULL),
('90882719965253632',2,'116.30.221.119',NULL,'修改等级','{\"address\":\"[\\\"320000\\\",\\\"320100\\\",\\\"320102\\\"]\",\"_index\":\"0\",\"level\":\"4\",\"mobile\":\"18662727091\",\"selectLevel\":\"2\",\"_rowKey\":\"38\",\"recommendNickname\":\"胡丹\",\"recommendMobile\":\"18751962873\",\"nickname\":\"陈萍\",\"name\":\"陈萍\",\"ctime\":\"1545220994\",\"id\":\"12564\",\"addressArray\":\"320000,320100,320102\"}','POST','/mozi/agent/changeLevel','mozi','2018-12-28 09:07:50',NULL,'2018-12-28 09:07:50',NULL),
('90882718530801664',1,'116.30.221.119',NULL,'修改等级','{\"address\":\"[\\\"320000\\\",\\\"320100\\\",\\\"320102\\\"]\",\"_index\":\"0\",\"level\":\"4\",\"mobile\":\"18662727091\",\"selectLevel\":\"2\",\"_rowKey\":\"38\",\"recommendNickname\":\"胡丹\",\"recommendMobile\":\"18751962873\",\"nickname\":\"陈萍\",\"name\":\"陈萍\",\"ctime\":\"1545220994\",\"id\":\"12564\",\"addressArray\":\"320000,320100,320102\"}','POST','/mozi/agent/changeLevel','mozi','2018-12-28 09:07:50',NULL,'2018-12-28 09:07:50',NULL),
('90882716882440192',1,'116.30.221.119',NULL,'修改等级','{\"address\":\"[\\\"320000\\\",\\\"320100\\\",\\\"320102\\\"]\",\"_index\":\"0\",\"level\":\"4\",\"mobile\":\"18662727091\",\"selectLevel\":\"2\",\"_rowKey\":\"38\",\"recommendNickname\":\"胡丹\",\"recommendMobile\":\"18751962873\",\"nickname\":\"陈萍\",\"name\":\"陈萍\",\"ctime\":\"1545220994\",\"id\":\"12564\",\"addressArray\":\"320000,320100,320102\"}','POST','/mozi/agent/changeLevel','mozi','2018-12-28 09:07:49',NULL,'2018-12-28 09:07:49',NULL),
('90881762556645376',2,'116.30.221.119',NULL,'添加代理','{\"recommendMobile\":\"胡丹\",\"address\":\"[\\\"320000\\\",\\\"320100\\\",\\\"320117\\\"]\",\"level\":\"4\",\"mobile\":\"17361977157\",\"name\":\"刘建娥\",\"addressArray\":\"320000,320100,320117\",\"selectLevel\":\"2\"}','POST','/mozi/agent/add','mozi','2018-12-28 09:04:02',NULL,'2018-12-28 09:04:02',NULL),
('90882715380879360',2,'116.30.221.119',NULL,'修改等级','{\"address\":\"[\\\"320000\\\",\\\"320100\\\",\\\"320102\\\"]\",\"_index\":\"0\",\"level\":\"4\",\"mobile\":\"18662727091\",\"selectLevel\":\"2\",\"_rowKey\":\"38\",\"recommendNickname\":\"胡丹\",\"recommendMobile\":\"18751962873\",\"nickname\":\"陈萍\",\"name\":\"陈萍\",\"ctime\":\"1545220994\",\"id\":\"12564\",\"addressArray\":\"320000,320100,320102\"}','POST','/mozi/agent/changeLevel','mozi','2018-12-28 09:07:49',NULL,'2018-12-28 09:07:49',NULL),
('90882626562297856',10,'116.30.221.119',NULL,'修改推荐关系','{\"recommendNickname\":\"庐山\",\"recommendMobile\":\"18751962873\",\"address\":\"\",\"_index\":\"0\",\"level\":\"3\",\"mobile\":\"18662727091\",\"nickname\":\"陈萍\",\"name\":\"陈萍\",\"ctime\":\"1545220994\",\"id\":\"12564\",\"addressArray\":\"\",\"_rowKey\":\"37\"}','POST','/mozi/agent/changeRelation','mozi','2018-12-28 09:07:28',NULL,'2018-12-28 09:07:28',NULL),
('90882706430234624',1,'116.30.221.119',NULL,'修改等级','{\"address\":\"[\\\"320000\\\",\\\"320100\\\",\\\"320102\\\"]\",\"_index\":\"0\",\"level\":\"4\",\"mobile\":\"18662727091\",\"selectLevel\":\"2\",\"_rowKey\":\"38\",\"recommendNickname\":\"胡丹\",\"recommendMobile\":\"18751962873\",\"nickname\":\"陈萍\",\"name\":\"陈萍\",\"ctime\":\"1545220994\",\"id\":\"12564\",\"addressArray\":\"320000,320100,320102\"}','POST','/mozi/agent/changeLevel','mozi','2018-12-28 09:07:47',NULL,'2018-12-28 09:07:47',NULL),
('90881761642287104',2,'116.30.221.119',NULL,'添加代理','{\"recommendMobile\":\"胡丹\",\"address\":\"[\\\"320000\\\",\\\"320100\\\",\\\"320117\\\"]\",\"level\":\"4\",\"mobile\":\"17361977157\",\"name\":\"刘建娥\",\"addressArray\":\"320000,320100,320117\",\"selectLevel\":\"2\"}','POST','/mozi/agent/add','mozi','2018-12-28 09:04:01',NULL,'2018-12-28 09:04:01',NULL),
('90881760778260480',2,'116.30.221.119',NULL,'添加代理','{\"recommendMobile\":\"胡丹\",\"address\":\"[\\\"320000\\\",\\\"320100\\\",\\\"320117\\\"]\",\"level\":\"4\",\"mobile\":\"17361977157\",\"name\":\"刘建娥\",\"addressArray\":\"320000,320100,320117\",\"selectLevel\":\"2\"}','POST','/mozi/agent/add','mozi','2018-12-28 09:04:01',NULL,'2018-12-28 09:04:01',NULL),
('90881759872290816',3,'116.30.221.119',NULL,'添加代理','{\"recommendMobile\":\"胡丹\",\"address\":\"[\\\"320000\\\",\\\"320100\\\",\\\"320117\\\"]\",\"level\":\"4\",\"mobile\":\"17361977157\",\"name\":\"刘建娥\",\"addressArray\":\"320000,320100,320117\",\"selectLevel\":\"2\"}','POST','/mozi/agent/add','mozi','2018-12-28 09:04:01',NULL,'2018-12-28 09:04:01',NULL),
('90881758991486976',3,'116.30.221.119',NULL,'添加代理','{\"recommendMobile\":\"胡丹\",\"address\":\"[\\\"320000\\\",\\\"320100\\\",\\\"320117\\\"]\",\"level\":\"4\",\"mobile\":\"17361977157\",\"name\":\"刘建娥\",\"addressArray\":\"320000,320100,320117\",\"selectLevel\":\"2\"}','POST','/mozi/agent/add','mozi','2018-12-28 09:04:01',NULL,'2018-12-28 09:04:01',NULL),
('90881757213102080',3,'116.30.221.119',NULL,'添加代理','{\"recommendMobile\":\"胡丹\",\"address\":\"[\\\"320000\\\",\\\"320100\\\",\\\"320117\\\"]\",\"level\":\"4\",\"mobile\":\"17361977157\",\"name\":\"刘建娥\",\"addressArray\":\"320000,320100,320117\",\"selectLevel\":\"2\"}','POST','/mozi/agent/add','mozi','2018-12-28 09:04:00',NULL,'2018-12-28 09:04:00',NULL),
('90881758152626176',2,'116.30.221.119',NULL,'添加代理','{\"recommendMobile\":\"胡丹\",\"address\":\"[\\\"320000\\\",\\\"320100\\\",\\\"320117\\\"]\",\"level\":\"4\",\"mobile\":\"17361977157\",\"name\":\"刘建娥\",\"addressArray\":\"320000,320100,320117\",\"selectLevel\":\"2\"}','POST','/mozi/agent/add','mozi','2018-12-28 09:04:01',NULL,'2018-12-28 09:04:01',NULL),
('90881755606683648',4,'116.30.221.119',NULL,'添加代理','{\"recommendMobile\":\"胡丹\",\"address\":\"[\\\"320000\\\",\\\"320100\\\",\\\"320117\\\"]\",\"level\":\"4\",\"mobile\":\"17361977157\",\"name\":\"刘建娥\",\"addressArray\":\"320000,320100,320117\",\"selectLevel\":\"2\"}','POST','/mozi/agent/add','mozi','2018-12-28 09:04:00',NULL,'2018-12-28 09:04:00',NULL),
('90881753815715840',3,'116.30.221.119',NULL,'添加代理','{\"recommendMobile\":\"胡丹\",\"address\":\"[\\\"320000\\\",\\\"320100\\\",\\\"320117\\\"]\",\"level\":\"4\",\"mobile\":\"17361977157\",\"name\":\"刘建娥\",\"addressArray\":\"320000,320100,320117\",\"selectLevel\":\"2\"}','POST','/mozi/agent/add','mozi','2018-12-28 09:04:00',NULL,'2018-12-28 09:04:00',NULL),
('90881754721685504',3,'116.30.221.119',NULL,'添加代理','{\"recommendMobile\":\"胡丹\",\"address\":\"[\\\"320000\\\",\\\"320100\\\",\\\"320117\\\"]\",\"level\":\"4\",\"mobile\":\"17361977157\",\"name\":\"刘建娥\",\"addressArray\":\"320000,320100,320117\",\"selectLevel\":\"2\"}','POST','/mozi/agent/add','mozi','2018-12-28 09:04:00',NULL,'2018-12-28 09:04:00',NULL),
('90881753056546816',3,'116.30.221.119',NULL,'添加代理','{\"recommendMobile\":\"胡丹\",\"address\":\"[\\\"320000\\\",\\\"320100\\\",\\\"320117\\\"]\",\"level\":\"4\",\"mobile\":\"17361977157\",\"name\":\"刘建娥\",\"addressArray\":\"320000,320100,320117\",\"selectLevel\":\"2\"}','POST','/mozi/agent/add','mozi','2018-12-28 09:03:59',NULL,'2018-12-28 09:03:59',NULL),
('90881752213491712',3,'116.30.221.119',NULL,'添加代理','{\"recommendMobile\":\"胡丹\",\"address\":\"[\\\"320000\\\",\\\"320100\\\",\\\"320117\\\"]\",\"level\":\"4\",\"mobile\":\"17361977157\",\"name\":\"刘建娥\",\"addressArray\":\"320000,320100,320117\",\"selectLevel\":\"2\"}','POST','/mozi/agent/add','mozi','2018-12-28 09:03:59',NULL,'2018-12-28 09:03:59',NULL),
('90881746375020544',3,'116.30.221.119',NULL,'添加代理','{\"recommendMobile\":\"胡丹\",\"address\":\"[\\\"320000\\\",\\\"320100\\\",\\\"320117\\\"]\",\"level\":\"4\",\"mobile\":\"17361977157\",\"name\":\"刘建娥\",\"addressArray\":\"320000,320100,320117\",\"selectLevel\":\"2\"}','POST','/mozi/agent/add','mozi','2018-12-28 09:03:58',NULL,'2018-12-28 09:03:58',NULL),
('90881751391408128',3,'116.30.221.119',NULL,'添加代理','{\"recommendMobile\":\"胡丹\",\"address\":\"[\\\"320000\\\",\\\"320100\\\",\\\"320117\\\"]\",\"level\":\"4\",\"mobile\":\"17361977157\",\"name\":\"刘建娥\",\"addressArray\":\"320000,320100,320117\",\"selectLevel\":\"2\"}','POST','/mozi/agent/add','mozi','2018-12-28 09:03:59',NULL,'2018-12-28 09:03:59',NULL),
('90656016202469376',10,'116.30.221.148',NULL,'修改推荐关系','{\"address\":\"430000,430100\",\"_index\":\"0\",\"level\":\"5\",\"sex\":\"0\",\"mobile\":\"13907826876\",\"areaStatus\":\"1\",\"selectLevel\":\"1\",\"_rowKey\":\"291\",\"recommendNickname\":\"郑燕美\",\"recommendMobile\":\"10812\",\"areaNames\":\"湖南省/长沙市\",\"nickname\":\"黄新惠\",\"name\":\"黄芳梅\",\"selectAreaFlag\":\"true\",\"ctime\":\"1544150733\",\"id\":\"10524\",\"addressArray\":\"430000,430100\",\"email\":\"\"}','POST','/mozi/agent/changeRelation','admin','2018-12-27 18:07:00',NULL,'2018-12-27 18:07:00',NULL),
('90655772530184192',5,'116.30.221.148',NULL,'修改推荐关系','{\"address\":\"430000,430100\",\"_index\":\"0\",\"level\":\"5\",\"sex\":\"0\",\"mobile\":\"13907826876\",\"areaStatus\":\"1\",\"selectLevel\":\"1\",\"_rowKey\":\"291\",\"recommendNickname\":\"郑燕美\",\"recommendMobile\":\"10812\",\"areaNames\":\"湖南省/长沙市\",\"nickname\":\"黄新惠\",\"name\":\"黄芳梅\",\"selectAreaFlag\":\"true\",\"ctime\":\"1544150733\",\"id\":\"10524\",\"addressArray\":\"430000,430100\",\"email\":\"\"}','POST','/mozi/agent/changeRelation','admin','2018-12-27 18:06:01',NULL,'2018-12-27 18:06:01',NULL),
('90655892025905152',5,'116.30.221.148',NULL,'修改推荐关系','{\"address\":\"430000,430100\",\"_index\":\"0\",\"level\":\"5\",\"sex\":\"0\",\"mobile\":\"13907826876\",\"areaStatus\":\"1\",\"selectLevel\":\"1\",\"_rowKey\":\"291\",\"recommendNickname\":\"郑燕美\",\"recommendMobile\":\"10812\",\"areaNames\":\"湖南省/长沙市\",\"nickname\":\"黄新惠\",\"name\":\"黄芳梅\",\"selectAreaFlag\":\"true\",\"ctime\":\"1544150733\",\"id\":\"10524\",\"addressArray\":\"430000,430100\",\"email\":\"\"}','POST','/mozi/agent/changeRelation','admin','2018-12-27 18:06:30',NULL,'2018-12-27 18:06:30',NULL),
('90624265346355200',3,'116.30.221.148',NULL,'修改等级','{\"address\":\"440000,441900,441915\",\"_index\":\"0\",\"level\":\"3\",\"mobile\":\"18219376668\",\"areaStatus\":\"0\",\"_rowKey\":\"54\",\"recommendNickname\":\"江国环\",\"recommendMobile\":\"15976185687\",\"areaNames\":\"广东省/东莞市/茶山镇\",\"nickname\":\"李贤辉\",\"name\":\"李贤辉\",\"selectAreaFlag\":\"true\",\"ctime\":\"1544175734\",\"id\":\"10822\",\"addressArray\":\"440000,441900,441915\",\"email\":\"\"}','POST','/mozi/agent/changeLevel','mozi','2018-12-27 16:00:50',NULL,'2018-12-27 16:00:50',NULL),
('90624168520847360',3,'116.30.221.148',NULL,'修改等级','{\"address\":\"440000,441900,441915\",\"_index\":\"0\",\"level\":\"3\",\"mobile\":\"18219376668\",\"areaStatus\":\"0\",\"_rowKey\":\"52\",\"recommendNickname\":\"江国环\",\"recommendMobile\":\"15976185687\",\"areaNames\":\"广东省/东莞市/茶山镇\",\"nickname\":\"李贤辉\",\"name\":\"李贤辉\",\"selectAreaFlag\":\"true\",\"ctime\":\"1544175734\",\"id\":\"10822\",\"addressArray\":\"440000,441900,441915\",\"email\":\"\"}','POST','/mozi/agent/changeLevel','mozi','2018-12-27 16:00:27',NULL,'2018-12-27 16:00:27',NULL),
('90621527128543232',9,'116.30.221.119',NULL,'修改推荐关系','{\"address\":\"230000,230300,230302\",\"_index\":\"0\",\"level\":\"4\",\"mobile\":\"13904437111\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"12\",\"recommendNickname\":\"李海春\",\"recommendMobile\":\"13624337535\",\"areaNames\":\"黑龙江省/鸡西市/鸡冠区\",\"nickname\":\"徐强\",\"name\":\"徐强\",\"selectAreaFlag\":\"true\",\"ctime\":\"1545673991\",\"id\":\"12845\",\"addressArray\":\"230000,230300,230302\",\"email\":\"\"}','POST','/mozi/agent/changeRelation','mozi','2018-12-27 15:49:57',NULL,'2018-12-27 15:49:57',NULL),
('90623904585879552',10,'116.30.221.119',NULL,'修改推荐关系','{\"address\":\"440000,441900,441915\",\"_index\":\"0\",\"level\":\"3\",\"mobile\":\"18219376668\",\"areaStatus\":\"0\",\"_rowKey\":\"32\",\"recommendNickname\":\"李万城\",\"recommendMobile\":\"15976185687\",\"areaNames\":\"广东省/东莞市/茶山镇\",\"nickname\":\"李贤辉\",\"name\":\"李贤辉\",\"selectAreaFlag\":\"true\",\"ctime\":\"1544175734\",\"id\":\"10822\",\"addressArray\":\"440000,441900,441915\",\"email\":\"\"}','POST','/mozi/agent/changeRelation','mozi','2018-12-27 15:59:24',NULL,'2018-12-27 15:59:24',NULL),
('90621247930503168',9,'116.30.221.119',NULL,'修改推荐关系','{\"address\":\"220000,222400,222426\",\"_index\":\"0\",\"level\":\"4\",\"mobile\":\"13624337535\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"52\",\"recommendNickname\":\"徐强\",\"recommendMobile\":\"15304333356\",\"areaNames\":\"吉林省/延边朝鲜族自治州/安图县\",\"nickname\":\"王忠宝\",\"name\":\"王忠宝\",\"selectAreaFlag\":\"true\",\"ctime\":\"1545673991\",\"id\":\"12846\",\"addressArray\":\"220000,222400,222426\",\"email\":\"\"}','POST','/mozi/agent/changeRelation','mozi','2018-12-27 15:48:50',NULL,'2018-12-27 15:48:50',NULL),
('90619146634530816',4,'116.30.221.119',NULL,'修改推荐关系','{\"address\":\"230000,230300,230302\",\"_index\":\"0\",\"level\":\"4\",\"mobile\":\"13904437111\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"48\",\"recommendNickname\":\"李海春\",\"recommendMobile\":\" 13624337535\",\"areaNames\":\"黑龙江省/鸡西市/鸡冠区\",\"nickname\":\"徐强\",\"name\":\"徐强\",\"selectAreaFlag\":\"true\",\"ctime\":\"1545673991\",\"id\":\"12845\",\"addressArray\":\"230000,230300,230302\",\"email\":\"\"}','POST','/mozi/agent/changeRelation','mozi','2018-12-27 15:40:29',NULL,'2018-12-27 15:40:29',NULL),
('90619144084393984',5,'116.30.221.119',NULL,'修改推荐关系','{\"address\":\"230000,230300,230302\",\"_index\":\"0\",\"level\":\"4\",\"mobile\":\"13904437111\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"48\",\"recommendNickname\":\"李海春\",\"recommendMobile\":\" 13624337535\",\"areaNames\":\"黑龙江省/鸡西市/鸡冠区\",\"nickname\":\"徐强\",\"name\":\"徐强\",\"selectAreaFlag\":\"true\",\"ctime\":\"1545673991\",\"id\":\"12845\",\"addressArray\":\"230000,230300,230302\",\"email\":\"\"}','POST','/mozi/agent/changeRelation','mozi','2018-12-27 15:40:29',NULL,'2018-12-27 15:40:29',NULL),
('90618982435917824',5,'116.30.221.119',NULL,'修改推荐关系','{\"address\":\"230000,230300,230302\",\"_index\":\"0\",\"level\":\"4\",\"mobile\":\"13904437111\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"48\",\"recommendNickname\":\"李海春\",\"recommendMobile\":\" 13624337535\",\"areaNames\":\"黑龙江省/鸡西市/鸡冠区\",\"nickname\":\"徐强\",\"name\":\"徐强\",\"selectAreaFlag\":\"true\",\"ctime\":\"1545673991\",\"id\":\"12845\",\"addressArray\":\"230000,230300,230302\",\"email\":\"\"}','POST','/mozi/agent/changeRelation','mozi','2018-12-27 15:39:50',NULL,'2018-12-27 15:39:50',NULL),
('90618962378756096',5,'116.30.221.119',NULL,'修改推荐关系','{\"address\":\"230000,230300,230302\",\"_index\":\"0\",\"level\":\"4\",\"mobile\":\"13904437111\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"48\",\"recommendNickname\":\"李海春\",\"recommendMobile\":\" 13624337535\",\"areaNames\":\"黑龙江省/鸡西市/鸡冠区\",\"nickname\":\"徐强\",\"name\":\"徐强\",\"selectAreaFlag\":\"true\",\"ctime\":\"1545673991\",\"id\":\"12845\",\"addressArray\":\"230000,230300,230302\",\"email\":\"\"}','POST','/mozi/agent/changeRelation','mozi','2018-12-27 15:39:45',NULL,'2018-12-27 15:39:45',NULL),
('90618961506340864',4,'116.30.221.119',NULL,'修改推荐关系','{\"address\":\"230000,230300,230302\",\"_index\":\"0\",\"level\":\"4\",\"mobile\":\"13904437111\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"48\",\"recommendNickname\":\"李海春\",\"recommendMobile\":\" 13624337535\",\"areaNames\":\"黑龙江省/鸡西市/鸡冠区\",\"nickname\":\"徐强\",\"name\":\"徐强\",\"selectAreaFlag\":\"true\",\"ctime\":\"1545673991\",\"id\":\"12845\",\"addressArray\":\"230000,230300,230302\",\"email\":\"\"}','POST','/mozi/agent/changeRelation','mozi','2018-12-27 15:39:45',NULL,'2018-12-27 15:39:45',NULL),
('90618960646508544',4,'116.30.221.119',NULL,'修改推荐关系','{\"address\":\"230000,230300,230302\",\"_index\":\"0\",\"level\":\"4\",\"mobile\":\"13904437111\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"48\",\"recommendNickname\":\"李海春\",\"recommendMobile\":\" 13624337535\",\"areaNames\":\"黑龙江省/鸡西市/鸡冠区\",\"nickname\":\"徐强\",\"name\":\"徐强\",\"selectAreaFlag\":\"true\",\"ctime\":\"1545673991\",\"id\":\"12845\",\"addressArray\":\"230000,230300,230302\",\"email\":\"\"}','POST','/mozi/agent/changeRelation','mozi','2018-12-27 15:39:45',NULL,'2018-12-27 15:39:45',NULL),
('90618959761510400',5,'116.30.221.119',NULL,'修改推荐关系','{\"address\":\"230000,230300,230302\",\"_index\":\"0\",\"level\":\"4\",\"mobile\":\"13904437111\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"48\",\"recommendNickname\":\"李海春\",\"recommendMobile\":\" 13624337535\",\"areaNames\":\"黑龙江省/鸡西市/鸡冠区\",\"nickname\":\"徐强\",\"name\":\"徐强\",\"selectAreaFlag\":\"true\",\"ctime\":\"1545673991\",\"id\":\"12845\",\"addressArray\":\"230000,230300,230302\",\"email\":\"\"}','POST','/mozi/agent/changeRelation','mozi','2018-12-27 15:39:45',NULL,'2018-12-27 15:39:45',NULL),
('90618958784237568',5,'116.30.221.119',NULL,'修改推荐关系','{\"address\":\"230000,230300,230302\",\"_index\":\"0\",\"level\":\"4\",\"mobile\":\"13904437111\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"48\",\"recommendNickname\":\"李海春\",\"recommendMobile\":\" 13624337535\",\"areaNames\":\"黑龙江省/鸡西市/鸡冠区\",\"nickname\":\"徐强\",\"name\":\"徐强\",\"selectAreaFlag\":\"true\",\"ctime\":\"1545673991\",\"id\":\"12845\",\"addressArray\":\"230000,230300,230302\",\"email\":\"\"}','POST','/mozi/agent/changeRelation','mozi','2018-12-27 15:39:44',NULL,'2018-12-27 15:39:44',NULL),
('90618355051925504',1,'113.89.97.31',NULL,'登录系统','{\"password\":\"你是看不见我的\",\"captcha\":\"OD4H\",\"saveLogin\":\"true\",\"captchaId\":\"84be1a940a3d48ddbb1f49d725a9a0a5\",\"username\":\"mozi\"}','POST','/mozi/login','mozi','2018-12-27 15:37:20',NULL,'2018-12-27 15:37:20',NULL),
('90618954426355712',5,'116.30.221.119',NULL,'修改推荐关系','{\"address\":\"230000,230300,230302\",\"_index\":\"0\",\"level\":\"4\",\"mobile\":\"13904437111\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"48\",\"recommendNickname\":\"李海春\",\"recommendMobile\":\" 13624337535\",\"areaNames\":\"黑龙江省/鸡西市/鸡冠区\",\"nickname\":\"徐强\",\"name\":\"徐强\",\"selectAreaFlag\":\"true\",\"ctime\":\"1545673991\",\"id\":\"12845\",\"addressArray\":\"230000,230300,230302\",\"email\":\"\"}','POST','/mozi/agent/changeRelation','mozi','2018-12-27 15:39:43',NULL,'2018-12-27 15:39:43',NULL),
('90610269813739520',5,'116.30.221.148',NULL,'修改等级','{\"address\":\"[\\\"130000\\\",\\\"130500\\\",\\\"130528\\\"]\",\"_index\":\"0\",\"level\":\"4\",\"sex\":\"1\",\"mobile\":\"18630103126\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"130\",\"recommendNickname\":\"廉振森\",\"recommendMobile\":\"18063414919\",\"areaNames\":\"河北省/邢台市/巨鹿县\",\"nickname\":\"德行天下\",\"name\":\"邢辉\",\"selectAreaFlag\":\"true\",\"ctime\":\"1544150740\",\"id\":\"10562\",\"addressArray\":\"130000,130500,130528\",\"email\":\"\"}','POST','/mozi/agent/changeLevel','admin','2018-12-27 15:05:13',NULL,'2018-12-27 15:05:13',NULL),
('90610110388244480',1,'116.30.221.148',NULL,'修改等级','{\"address\":\"[\\\"130000\\\",\\\"130500\\\",\\\"130528\\\"]\",\"_index\":\"0\",\"level\":\"4\",\"sex\":\"1\",\"mobile\":\"18630103126\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"129\",\"recommendNickname\":\"廉振森\",\"recommendMobile\":\"18063414919\",\"areaNames\":\"河北省/邢台市/宁晋县\",\"nickname\":\"德行天下\",\"name\":\"邢辉\",\"selectAreaFlag\":\"true\",\"ctime\":\"1544150740\",\"id\":\"10562\",\"addressArray\":\"130000,130500,130528\",\"email\":\"\"}','POST','/mozi/agent/changeLevel','admin','2018-12-27 15:04:35',NULL,'2018-12-27 15:04:35',NULL),
('90610219222044672',6,'116.30.221.148',NULL,'修改等级','{\"address\":\"[\\\"130000\\\",\\\"130500\\\",\\\"130529\\\"]\",\"_index\":\"0\",\"level\":\"4\",\"sex\":\"1\",\"mobile\":\"18630103126\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"129\",\"recommendNickname\":\"廉振森\",\"recommendMobile\":\"18063414919\",\"areaNames\":\"河北省/邢台市/宁晋县\",\"nickname\":\"德行天下\",\"name\":\"邢辉\",\"selectAreaFlag\":\"true\",\"ctime\":\"1544150740\",\"id\":\"10562\",\"addressArray\":\"130000,130500,130529\",\"email\":\"\"}','POST','/mozi/agent/changeLevel','admin','2018-12-27 15:05:01',NULL,'2018-12-27 15:05:01',NULL),
('90610106466570240',1,'116.30.221.148',NULL,'修改等级','{\"address\":\"[\\\"130000\\\",\\\"130500\\\",\\\"130528\\\"]\",\"_index\":\"0\",\"level\":\"4\",\"sex\":\"1\",\"mobile\":\"18630103126\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"129\",\"recommendNickname\":\"廉振森\",\"recommendMobile\":\"18063414919\",\"areaNames\":\"河北省/邢台市/宁晋县\",\"nickname\":\"德行天下\",\"name\":\"邢辉\",\"selectAreaFlag\":\"true\",\"ctime\":\"1544150740\",\"id\":\"10562\",\"addressArray\":\"130000,130500,130528\",\"email\":\"\"}','POST','/mozi/agent/changeLevel','admin','2018-12-27 15:04:34',NULL,'2018-12-27 15:04:34',NULL),
('90609407351590912',1,'116.30.221.148',NULL,'修改等级','{\"address\":\"[\\\"130000\\\",\\\"130500\\\",\\\"130528\\\"]\",\"_index\":\"0\",\"level\":\"4\",\"sex\":\"1\",\"mobile\":\"18630103126\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"36\",\"recommendNickname\":\"廉振森\",\"recommendMobile\":\"18063414919\",\"areaNames\":\"河北省/邢台市/宁晋县\",\"nickname\":\"德行天下\",\"name\":\"邢辉\",\"selectAreaFlag\":\"true\",\"ctime\":\"1544150740\",\"id\":\"10562\",\"addressArray\":\"130000,130500,130528\",\"email\":\"\"}','POST','/mozi/agent/changeLevel','mozi','2018-12-27 15:01:47',NULL,'2018-12-27 15:01:47',NULL),
('90609408572133376',1,'116.30.221.148',NULL,'修改等级','{\"address\":\"[\\\"130000\\\",\\\"130500\\\",\\\"130528\\\"]\",\"_index\":\"0\",\"level\":\"4\",\"sex\":\"1\",\"mobile\":\"18630103126\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"36\",\"recommendNickname\":\"廉振森\",\"recommendMobile\":\"18063414919\",\"areaNames\":\"河北省/邢台市/宁晋县\",\"nickname\":\"德行天下\",\"name\":\"邢辉\",\"selectAreaFlag\":\"true\",\"ctime\":\"1544150740\",\"id\":\"10562\",\"addressArray\":\"130000,130500,130528\",\"email\":\"\"}','POST','/mozi/agent/changeLevel','mozi','2018-12-27 15:01:47',NULL,'2018-12-27 15:01:47',NULL),
('90609405451571200',1,'116.30.221.148',NULL,'修改等级','{\"address\":\"[\\\"130000\\\",\\\"130500\\\",\\\"130528\\\"]\",\"_index\":\"0\",\"level\":\"4\",\"sex\":\"1\",\"mobile\":\"18630103126\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"36\",\"recommendNickname\":\"廉振森\",\"recommendMobile\":\"18063414919\",\"areaNames\":\"河北省/邢台市/宁晋县\",\"nickname\":\"德行天下\",\"name\":\"邢辉\",\"selectAreaFlag\":\"true\",\"ctime\":\"1544150740\",\"id\":\"10562\",\"addressArray\":\"130000,130500,130528\",\"email\":\"\"}','POST','/mozi/agent/changeLevel','mozi','2018-12-27 15:01:47',NULL,'2018-12-27 15:01:47',NULL),
('90609404512047104',1,'116.30.221.148',NULL,'修改等级','{\"address\":\"[\\\"130000\\\",\\\"130500\\\",\\\"130528\\\"]\",\"_index\":\"0\",\"level\":\"4\",\"sex\":\"1\",\"mobile\":\"18630103126\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"36\",\"recommendNickname\":\"廉振森\",\"recommendMobile\":\"18063414919\",\"areaNames\":\"河北省/邢台市/宁晋县\",\"nickname\":\"德行天下\",\"name\":\"邢辉\",\"selectAreaFlag\":\"true\",\"ctime\":\"1544150740\",\"id\":\"10562\",\"addressArray\":\"130000,130500,130528\",\"email\":\"\"}','POST','/mozi/agent/changeLevel','mozi','2018-12-27 15:01:46',NULL,'2018-12-27 15:01:46',NULL),
('90609403610271744',1,'116.30.221.148',NULL,'修改等级','{\"address\":\"[\\\"130000\\\",\\\"130500\\\",\\\"130528\\\"]\",\"_index\":\"0\",\"level\":\"4\",\"sex\":\"1\",\"mobile\":\"18630103126\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"36\",\"recommendNickname\":\"廉振森\",\"recommendMobile\":\"18063414919\",\"areaNames\":\"河北省/邢台市/宁晋县\",\"nickname\":\"德行天下\",\"name\":\"邢辉\",\"selectAreaFlag\":\"true\",\"ctime\":\"1544150740\",\"id\":\"10562\",\"addressArray\":\"130000,130500,130528\",\"email\":\"\"}','POST','/mozi/agent/changeLevel','mozi','2018-12-27 15:01:46',NULL,'2018-12-27 15:01:46',NULL),
('90609402498781184',1,'116.30.221.148',NULL,'修改等级','{\"address\":\"[\\\"130000\\\",\\\"130500\\\",\\\"130528\\\"]\",\"_index\":\"0\",\"level\":\"4\",\"sex\":\"1\",\"mobile\":\"18630103126\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"36\",\"recommendNickname\":\"廉振森\",\"recommendMobile\":\"18063414919\",\"areaNames\":\"河北省/邢台市/宁晋县\",\"nickname\":\"德行天下\",\"name\":\"邢辉\",\"selectAreaFlag\":\"true\",\"ctime\":\"1544150740\",\"id\":\"10562\",\"addressArray\":\"130000,130500,130528\",\"email\":\"\"}','POST','/mozi/agent/changeLevel','mozi','2018-12-27 15:01:46',NULL,'2018-12-27 15:01:46',NULL),
('90609401198546944',1,'116.30.221.148',NULL,'修改等级','{\"address\":\"[\\\"130000\\\",\\\"130500\\\",\\\"130528\\\"]\",\"_index\":\"0\",\"level\":\"4\",\"sex\":\"1\",\"mobile\":\"18630103126\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"36\",\"recommendNickname\":\"廉振森\",\"recommendMobile\":\"18063414919\",\"areaNames\":\"河北省/邢台市/宁晋县\",\"nickname\":\"德行天下\",\"name\":\"邢辉\",\"selectAreaFlag\":\"true\",\"ctime\":\"1544150740\",\"id\":\"10562\",\"addressArray\":\"130000,130500,130528\",\"email\":\"\"}','POST','/mozi/agent/changeLevel','mozi','2018-12-27 15:01:46',NULL,'2018-12-27 15:01:46',NULL),
('90609380990390272',1,'116.30.221.148',NULL,'修改等级','{\"address\":\"[\\\"130000\\\",\\\"130500\\\",\\\"130528\\\"]\",\"_index\":\"0\",\"level\":\"4\",\"sex\":\"1\",\"mobile\":\"18630103126\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"36\",\"recommendNickname\":\"廉振森\",\"recommendMobile\":\"18063414919\",\"areaNames\":\"河北省/邢台市/宁晋县\",\"nickname\":\"德行天下\",\"name\":\"邢辉\",\"selectAreaFlag\":\"true\",\"ctime\":\"1544150740\",\"id\":\"10562\",\"addressArray\":\"130000,130500,130528\",\"email\":\"\"}','POST','/mozi/agent/changeLevel','mozi','2018-12-27 15:01:41',NULL,'2018-12-27 15:01:41',NULL),
('90609350887870464',1,'116.30.221.148',NULL,'修改等级','{\"address\":\"[\\\"130000\\\",\\\"130500\\\",\\\"130528\\\"]\",\"_index\":\"0\",\"level\":\"4\",\"sex\":\"1\",\"mobile\":\"18630103126\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"36\",\"recommendNickname\":\"廉振森\",\"recommendMobile\":\"18063414919\",\"areaNames\":\"河北省/邢台市/宁晋县\",\"nickname\":\"德行天下\",\"name\":\"邢辉\",\"selectAreaFlag\":\"true\",\"ctime\":\"1544150740\",\"id\":\"10562\",\"addressArray\":\"130000,130500,130528\",\"email\":\"\"}','POST','/mozi/agent/changeLevel','mozi','2018-12-27 15:01:34',NULL,'2018-12-27 15:01:34',NULL),
('90609350086758400',1,'116.30.221.148',NULL,'修改等级','{\"address\":\"[\\\"130000\\\",\\\"130500\\\",\\\"130528\\\"]\",\"_index\":\"0\",\"level\":\"4\",\"sex\":\"1\",\"mobile\":\"18630103126\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"36\",\"recommendNickname\":\"廉振森\",\"recommendMobile\":\"18063414919\",\"areaNames\":\"河北省/邢台市/宁晋县\",\"nickname\":\"德行天下\",\"name\":\"邢辉\",\"selectAreaFlag\":\"true\",\"ctime\":\"1544150740\",\"id\":\"10562\",\"addressArray\":\"130000,130500,130528\",\"email\":\"\"}','POST','/mozi/agent/changeLevel','mozi','2018-12-27 15:01:34',NULL,'2018-12-27 15:01:34',NULL),
('90609349738631168',1,'116.30.221.148',NULL,'修改等级','{\"address\":\"[\\\"130000\\\",\\\"130500\\\",\\\"130528\\\"]\",\"_index\":\"0\",\"level\":\"4\",\"sex\":\"1\",\"mobile\":\"18630103126\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"36\",\"recommendNickname\":\"廉振森\",\"recommendMobile\":\"18063414919\",\"areaNames\":\"河北省/邢台市/宁晋县\",\"nickname\":\"德行天下\",\"name\":\"邢辉\",\"selectAreaFlag\":\"true\",\"ctime\":\"1544150740\",\"id\":\"10562\",\"addressArray\":\"130000,130500,130528\",\"email\":\"\"}','POST','/mozi/agent/changeLevel','mozi','2018-12-27 15:01:33',NULL,'2018-12-27 15:01:33',NULL),
('90609348459368448',2,'116.30.221.148',NULL,'修改等级','{\"address\":\"[\\\"130000\\\",\\\"130500\\\",\\\"130528\\\"]\",\"_index\":\"0\",\"level\":\"4\",\"sex\":\"1\",\"mobile\":\"18630103126\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"36\",\"recommendNickname\":\"廉振森\",\"recommendMobile\":\"18063414919\",\"areaNames\":\"河北省/邢台市/宁晋县\",\"nickname\":\"德行天下\",\"name\":\"邢辉\",\"selectAreaFlag\":\"true\",\"ctime\":\"1544150740\",\"id\":\"10562\",\"addressArray\":\"130000,130500,130528\",\"email\":\"\"}','POST','/mozi/agent/changeLevel','mozi','2018-12-27 15:01:33',NULL,'2018-12-27 15:01:33',NULL),
('90609347477901312',1,'116.30.221.148',NULL,'修改等级','{\"address\":\"[\\\"130000\\\",\\\"130500\\\",\\\"130528\\\"]\",\"_index\":\"0\",\"level\":\"4\",\"sex\":\"1\",\"mobile\":\"18630103126\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"36\",\"recommendNickname\":\"廉振森\",\"recommendMobile\":\"18063414919\",\"areaNames\":\"河北省/邢台市/宁晋县\",\"nickname\":\"德行天下\",\"name\":\"邢辉\",\"selectAreaFlag\":\"true\",\"ctime\":\"1544150740\",\"id\":\"10562\",\"addressArray\":\"130000,130500,130528\",\"email\":\"\"}','POST','/mozi/agent/changeLevel','mozi','2018-12-27 15:01:33',NULL,'2018-12-27 15:01:33',NULL),
('90609343442980864',1,'116.30.221.148',NULL,'修改等级','{\"address\":\"[\\\"130000\\\",\\\"130500\\\",\\\"130528\\\"]\",\"_index\":\"0\",\"level\":\"4\",\"sex\":\"1\",\"mobile\":\"18630103126\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"36\",\"recommendNickname\":\"廉振森\",\"recommendMobile\":\"18063414919\",\"areaNames\":\"河北省/邢台市/宁晋县\",\"nickname\":\"德行天下\",\"name\":\"邢辉\",\"selectAreaFlag\":\"true\",\"ctime\":\"1544150740\",\"id\":\"10562\",\"addressArray\":\"130000,130500,130528\",\"email\":\"\"}','POST','/mozi/agent/changeLevel','mozi','2018-12-27 15:01:32',NULL,'2018-12-27 15:01:32',NULL),
('90609344340561920',1,'116.30.221.148',NULL,'修改等级','{\"address\":\"[\\\"130000\\\",\\\"130500\\\",\\\"130528\\\"]\",\"_index\":\"0\",\"level\":\"4\",\"sex\":\"1\",\"mobile\":\"18630103126\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"36\",\"recommendNickname\":\"廉振森\",\"recommendMobile\":\"18063414919\",\"areaNames\":\"河北省/邢台市/宁晋县\",\"nickname\":\"德行天下\",\"name\":\"邢辉\",\"selectAreaFlag\":\"true\",\"ctime\":\"1544150740\",\"id\":\"10562\",\"addressArray\":\"130000,130500,130528\",\"email\":\"\"}','POST','/mozi/agent/changeLevel','mozi','2018-12-27 15:01:32',NULL,'2018-12-27 15:01:32',NULL),
('90609342692200448',1,'116.30.221.148',NULL,'修改等级','{\"address\":\"[\\\"130000\\\",\\\"130500\\\",\\\"130528\\\"]\",\"_index\":\"0\",\"level\":\"4\",\"sex\":\"1\",\"mobile\":\"18630103126\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"36\",\"recommendNickname\":\"廉振森\",\"recommendMobile\":\"18063414919\",\"areaNames\":\"河北省/邢台市/宁晋县\",\"nickname\":\"德行天下\",\"name\":\"邢辉\",\"selectAreaFlag\":\"true\",\"ctime\":\"1544150740\",\"id\":\"10562\",\"addressArray\":\"130000,130500,130528\",\"email\":\"\"}','POST','/mozi/agent/changeLevel','mozi','2018-12-27 15:01:32',NULL,'2018-12-27 15:01:32',NULL),
('90609341865922560',1,'116.30.221.148',NULL,'修改等级','{\"address\":\"[\\\"130000\\\",\\\"130500\\\",\\\"130528\\\"]\",\"_index\":\"0\",\"level\":\"4\",\"sex\":\"1\",\"mobile\":\"18630103126\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"36\",\"recommendNickname\":\"廉振森\",\"recommendMobile\":\"18063414919\",\"areaNames\":\"河北省/邢台市/宁晋县\",\"nickname\":\"德行天下\",\"name\":\"邢辉\",\"selectAreaFlag\":\"true\",\"ctime\":\"1544150740\",\"id\":\"10562\",\"addressArray\":\"130000,130500,130528\",\"email\":\"\"}','POST','/mozi/agent/changeLevel','mozi','2018-12-27 15:01:32',NULL,'2018-12-27 15:01:32',NULL),
('90609341022867456',1,'116.30.221.148',NULL,'修改等级','{\"address\":\"[\\\"130000\\\",\\\"130500\\\",\\\"130528\\\"]\",\"_index\":\"0\",\"level\":\"4\",\"sex\":\"1\",\"mobile\":\"18630103126\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"36\",\"recommendNickname\":\"廉振森\",\"recommendMobile\":\"18063414919\",\"areaNames\":\"河北省/邢台市/宁晋县\",\"nickname\":\"德行天下\",\"name\":\"邢辉\",\"selectAreaFlag\":\"true\",\"ctime\":\"1544150740\",\"id\":\"10562\",\"addressArray\":\"130000,130500,130528\",\"email\":\"\"}','POST','/mozi/agent/changeLevel','mozi','2018-12-27 15:01:31',NULL,'2018-12-27 15:01:31',NULL),
('90609338145574912',1,'116.30.221.148',NULL,'修改等级','{\"address\":\"[\\\"130000\\\",\\\"130500\\\",\\\"130528\\\"]\",\"_index\":\"0\",\"level\":\"4\",\"sex\":\"1\",\"mobile\":\"18630103126\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"36\",\"recommendNickname\":\"廉振森\",\"recommendMobile\":\"18063414919\",\"areaNames\":\"河北省/邢台市/宁晋县\",\"nickname\":\"德行天下\",\"name\":\"邢辉\",\"selectAreaFlag\":\"true\",\"ctime\":\"1544150740\",\"id\":\"10562\",\"addressArray\":\"130000,130500,130528\",\"email\":\"\"}','POST','/mozi/agent/changeLevel','mozi','2018-12-27 15:01:31',NULL,'2018-12-27 15:01:31',NULL),
('90609340188200960',1,'116.30.221.148',NULL,'修改等级','{\"address\":\"[\\\"130000\\\",\\\"130500\\\",\\\"130528\\\"]\",\"_index\":\"0\",\"level\":\"4\",\"sex\":\"1\",\"mobile\":\"18630103126\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"36\",\"recommendNickname\":\"廉振森\",\"recommendMobile\":\"18063414919\",\"areaNames\":\"河北省/邢台市/宁晋县\",\"nickname\":\"德行天下\",\"name\":\"邢辉\",\"selectAreaFlag\":\"true\",\"ctime\":\"1544150740\",\"id\":\"10562\",\"addressArray\":\"130000,130500,130528\",\"email\":\"\"}','POST','/mozi/agent/changeLevel','mozi','2018-12-27 15:01:31',NULL,'2018-12-27 15:01:31',NULL),
('90609337004724224',1,'116.30.221.148',NULL,'修改等级','{\"address\":\"[\\\"130000\\\",\\\"130500\\\",\\\"130528\\\"]\",\"_index\":\"0\",\"level\":\"4\",\"sex\":\"1\",\"mobile\":\"18630103126\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"36\",\"recommendNickname\":\"廉振森\",\"recommendMobile\":\"18063414919\",\"areaNames\":\"河北省/邢台市/宁晋县\",\"nickname\":\"德行天下\",\"name\":\"邢辉\",\"selectAreaFlag\":\"true\",\"ctime\":\"1544150740\",\"id\":\"10562\",\"addressArray\":\"130000,130500,130528\",\"email\":\"\"}','POST','/mozi/agent/changeLevel','mozi','2018-12-27 15:01:30',NULL,'2018-12-27 15:01:30',NULL),
('90609330788765696',2,'116.30.221.148',NULL,'修改等级','{\"address\":\"[\\\"130000\\\",\\\"130500\\\",\\\"130528\\\"]\",\"_index\":\"0\",\"level\":\"4\",\"sex\":\"1\",\"mobile\":\"18630103126\",\"areaStatus\":\"1\",\"selectLevel\":\"2\",\"_rowKey\":\"36\",\"recommendNickname\":\"廉振森\",\"recommendMobile\":\"18063414919\",\"areaNames\":\"河北省/邢台市/宁晋县\",\"nickname\":\"德行天下\",\"name\":\"邢辉\",\"selectAreaFlag\":\"true\",\"ctime\":\"1544150740\",\"id\":\"10562\",\"addressArray\":\"130000,130500,130528\",\"email\":\"\"}','POST','/mozi/agent/changeLevel','mozi','2018-12-27 15:01:29',NULL,'2018-12-27 15:01:29',NULL),
('90607595252879360',0,'116.30.221.148',NULL,'登录系统','{\"password\":\"你是看不见我的\",\"captcha\":\"wwip\",\"saveLogin\":\"true\",\"captchaId\":\"1ead8c158a644287aa3ec53f5635dded\",\"username\":\"mozi\"}','POST','/mozi/login','mozi','2018-12-27 14:54:35',NULL,'2018-12-27 14:54:35',NULL),
('90608792349184000',11,'116.30.221.148',NULL,'修改推荐关系','{\"address\":\"130000,130500,130528\",\"_index\":\"0\",\"level\":\"3\",\"sex\":\"1\",\"mobile\":\"18630103126\",\"areaStatus\":\"1\",\"_rowKey\":\"33\",\"recommendNickname\":\"墨子\",\"recommendMobile\":\"18063414919\",\"areaNames\":\"河北省/邢台市/宁晋县\",\"nickname\":\"德行天下\",\"name\":\"邢辉\",\"selectAreaFlag\":\"true\",\"ctime\":\"1544150740\",\"id\":\"10562\",\"addressArray\":\"130000,130500,130528\",\"email\":\"\"}','POST','/mozi/agent/changeRelation','mozi','2018-12-27 14:59:21',NULL,'2018-12-27 14:59:21',NULL),
('90603737088790528',0,'116.30.221.148',NULL,'修改等级','{\"address\":\"\",\"_index\":\"6\",\"level\":\"4\",\"sex\":\"2\",\"mobile\":\"13292077891\",\"selectLevel\":\"2\",\"_rowKey\":\"25\",\"recommendNickname\":\"裴英\",\"recommendMobile\":\"13784237226\",\"nickname\":\"张娟\",\"ctime\":\"1545861085\",\"id\":\"12926\",\"addressArray\":\"\"}','POST','/mozi/agent/changeLevel','admin','2018-12-27 14:39:15',NULL,'2018-12-27 14:39:15',NULL),
('90603736480616448',0,'116.30.221.148',NULL,'修改等级','{\"address\":\"\",\"_index\":\"6\",\"level\":\"4\",\"sex\":\"2\",\"mobile\":\"13292077891\",\"selectLevel\":\"2\",\"_rowKey\":\"25\",\"recommendNickname\":\"裴英\",\"recommendMobile\":\"13784237226\",\"nickname\":\"张娟\",\"ctime\":\"1545861085\",\"id\":\"12926\",\"addressArray\":\"\"}','POST','/mozi/agent/changeLevel','admin','2018-12-27 14:39:15',NULL,'2018-12-27 14:39:15',NULL),
('90603735008415744',0,'116.30.221.148',NULL,'修改等级','{\"address\":\"\",\"_index\":\"6\",\"level\":\"4\",\"sex\":\"2\",\"mobile\":\"13292077891\",\"selectLevel\":\"2\",\"_rowKey\":\"25\",\"recommendNickname\":\"裴英\",\"recommendMobile\":\"13784237226\",\"nickname\":\"张娟\",\"ctime\":\"1545861085\",\"id\":\"12926\",\"addressArray\":\"\"}','POST','/mozi/agent/changeLevel','admin','2018-12-27 14:39:15',NULL,'2018-12-27 14:39:15',NULL),
('90603735713058816',0,'116.30.221.148',NULL,'修改等级','{\"address\":\"\",\"_index\":\"6\",\"level\":\"4\",\"sex\":\"2\",\"mobile\":\"13292077891\",\"selectLevel\":\"2\",\"_rowKey\":\"25\",\"recommendNickname\":\"裴英\",\"recommendMobile\":\"13784237226\",\"nickname\":\"张娟\",\"ctime\":\"1545861085\",\"id\":\"12926\",\"addressArray\":\"\"}','POST','/mozi/agent/changeLevel','admin','2018-12-27 14:39:15',NULL,'2018-12-27 14:39:15',NULL),
('90603734232469504',0,'116.30.221.148',NULL,'修改等级','{\"address\":\"\",\"_index\":\"6\",\"level\":\"4\",\"sex\":\"2\",\"mobile\":\"13292077891\",\"selectLevel\":\"2\",\"_rowKey\":\"25\",\"recommendNickname\":\"裴英\",\"recommendMobile\":\"13784237226\",\"nickname\":\"张娟\",\"ctime\":\"1545861085\",\"id\":\"12926\",\"addressArray\":\"\"}','POST','/mozi/agent/changeLevel','admin','2018-12-27 14:39:15',NULL,'2018-12-27 14:39:15',NULL),
('90603733506854912',0,'116.30.221.148',NULL,'修改等级','{\"address\":\"\",\"_index\":\"6\",\"level\":\"4\",\"sex\":\"2\",\"mobile\":\"13292077891\",\"selectLevel\":\"2\",\"_rowKey\":\"25\",\"recommendNickname\":\"裴英\",\"recommendMobile\":\"13784237226\",\"nickname\":\"张娟\",\"ctime\":\"1545861085\",\"id\":\"12926\",\"addressArray\":\"\"}','POST','/mozi/agent/changeLevel','admin','2018-12-27 14:39:14',NULL,'2018-12-27 14:39:14',NULL),
('90603732760268800',0,'116.30.221.148',NULL,'修改等级','{\"address\":\"\",\"_index\":\"6\",\"level\":\"4\",\"sex\":\"2\",\"mobile\":\"13292077891\",\"selectLevel\":\"2\",\"_rowKey\":\"25\",\"recommendNickname\":\"裴英\",\"recommendMobile\":\"13784237226\",\"nickname\":\"张娟\",\"ctime\":\"1545861085\",\"id\":\"12926\",\"addressArray\":\"\"}','POST','/mozi/agent/changeLevel','admin','2018-12-27 14:39:14',NULL,'2018-12-27 14:39:14',NULL),
('90603731913019392',0,'116.30.221.148',NULL,'修改等级','{\"address\":\"\",\"_index\":\"6\",\"level\":\"4\",\"sex\":\"2\",\"mobile\":\"13292077891\",\"selectLevel\":\"2\",\"_rowKey\":\"25\",\"recommendNickname\":\"裴英\",\"recommendMobile\":\"13784237226\",\"nickname\":\"张娟\",\"ctime\":\"1545861085\",\"id\":\"12926\",\"addressArray\":\"\"}','POST','/mozi/agent/changeLevel','admin','2018-12-27 14:39:14',NULL,'2018-12-27 14:39:14',NULL),
('90603731476811776',1,'116.30.221.148',NULL,'修改等级','{\"address\":\"\",\"_index\":\"6\",\"level\":\"4\",\"sex\":\"2\",\"mobile\":\"13292077891\",\"selectLevel\":\"2\",\"_rowKey\":\"25\",\"recommendNickname\":\"裴英\",\"recommendMobile\":\"13784237226\",\"nickname\":\"张娟\",\"ctime\":\"1545861085\",\"id\":\"12926\",\"addressArray\":\"\"}','POST','/mozi/agent/changeLevel','admin','2018-12-27 14:39:14',NULL,'2018-12-27 14:39:14',NULL),
('90603711658725376',0,'116.30.221.148',NULL,'修改等级','{\"address\":\"\",\"_index\":\"4\",\"level\":\"4\",\"sex\":\"2\",\"mobile\":\"13304863789\",\"selectLevel\":\"2\",\"_rowKey\":\"23\",\"recommendNickname\":\"牛忠新\",\"recommendMobile\":\"18045933006\",\"nickname\":\"悟净\",\"ctime\":\"1545879597\",\"id\":\"12988\",\"addressArray\":\"\"}','POST','/mozi/agent/changeLevel','admin','2018-12-27 14:39:09',NULL,'2018-12-27 14:39:09',NULL),
('90603710878584832',0,'116.30.221.148',NULL,'修改等级','{\"address\":\"\",\"_index\":\"4\",\"level\":\"4\",\"sex\":\"2\",\"mobile\":\"13304863789\",\"selectLevel\":\"2\",\"_rowKey\":\"23\",\"recommendNickname\":\"牛忠新\",\"recommendMobile\":\"18045933006\",\"nickname\":\"悟净\",\"ctime\":\"1545879597\",\"id\":\"12988\",\"addressArray\":\"\"}','POST','/mozi/agent/changeLevel','admin','2018-12-27 14:39:09',NULL,'2018-12-27 14:39:09',NULL),
('90603710144581632',0,'116.30.221.148',NULL,'修改等级','{\"address\":\"\",\"_index\":\"4\",\"level\":\"4\",\"sex\":\"2\",\"mobile\":\"13304863789\",\"selectLevel\":\"2\",\"_rowKey\":\"23\",\"recommendNickname\":\"牛忠新\",\"recommendMobile\":\"18045933006\",\"nickname\":\"悟净\",\"ctime\":\"1545879597\",\"id\":\"12988\",\"addressArray\":\"\"}','POST','/mozi/agent/changeLevel','admin','2018-12-27 14:39:09',NULL,'2018-12-27 14:39:09',NULL),
('90603709406384128',0,'116.30.221.148',NULL,'修改等级','{\"address\":\"\",\"_index\":\"4\",\"level\":\"4\",\"sex\":\"2\",\"mobile\":\"13304863789\",\"selectLevel\":\"2\",\"_rowKey\":\"23\",\"recommendNickname\":\"牛忠新\",\"recommendMobile\":\"18045933006\",\"nickname\":\"悟净\",\"ctime\":\"1545879597\",\"id\":\"12988\",\"addressArray\":\"\"}','POST','/mozi/agent/changeLevel','admin','2018-12-27 14:39:09',NULL,'2018-12-27 14:39:09',NULL),
('90603708668186624',0,'116.30.221.148',NULL,'修改等级','{\"address\":\"\",\"_index\":\"4\",\"level\":\"4\",\"sex\":\"2\",\"mobile\":\"13304863789\",\"selectLevel\":\"2\",\"_rowKey\":\"23\",\"recommendNickname\":\"牛忠新\",\"recommendMobile\":\"18045933006\",\"nickname\":\"悟净\",\"ctime\":\"1545879597\",\"id\":\"12988\",\"addressArray\":\"\"}','POST','/mozi/agent/changeLevel','admin','2018-12-27 14:39:08',NULL,'2018-12-27 14:39:08',NULL),
('90603707120488448',0,'116.30.221.148',NULL,'修改等级','{\"address\":\"\",\"_index\":\"4\",\"level\":\"4\",\"sex\":\"2\",\"mobile\":\"13304863789\",\"selectLevel\":\"2\",\"_rowKey\":\"23\",\"recommendNickname\":\"牛忠新\",\"recommendMobile\":\"18045933006\",\"nickname\":\"悟净\",\"ctime\":\"1545879597\",\"id\":\"12988\",\"addressArray\":\"\"}','POST','/mozi/agent/changeLevel','admin','2018-12-27 14:39:08',NULL,'2018-12-27 14:39:08',NULL),
('90603707896434688',0,'116.30.221.148',NULL,'修改等级','{\"address\":\"\",\"_index\":\"4\",\"level\":\"4\",\"sex\":\"2\",\"mobile\":\"13304863789\",\"selectLevel\":\"2\",\"_rowKey\":\"23\",\"recommendNickname\":\"牛忠新\",\"recommendMobile\":\"18045933006\",\"nickname\":\"悟净\",\"ctime\":\"1545879597\",\"id\":\"12988\",\"addressArray\":\"\"}','POST','/mozi/agent/changeLevel','admin','2018-12-27 14:39:08',NULL,'2018-12-27 14:39:08',NULL),
('90603706352930816',0,'116.30.221.148',NULL,'修改等级','{\"address\":\"\",\"_index\":\"4\",\"level\":\"4\",\"sex\":\"2\",\"mobile\":\"13304863789\",\"selectLevel\":\"2\",\"_rowKey\":\"23\",\"recommendNickname\":\"牛忠新\",\"recommendMobile\":\"18045933006\",\"nickname\":\"悟净\",\"ctime\":\"1545879597\",\"id\":\"12988\",\"addressArray\":\"\"}','POST','/mozi/agent/changeLevel','admin','2018-12-27 14:39:08',NULL,'2018-12-27 14:39:08',NULL),
('90603704784261120',0,'116.30.221.148',NULL,'修改等级','{\"address\":\"\",\"_index\":\"4\",\"level\":\"4\",\"sex\":\"2\",\"mobile\":\"13304863789\",\"selectLevel\":\"2\",\"_rowKey\":\"23\",\"recommendNickname\":\"牛忠新\",\"recommendMobile\":\"18045933006\",\"nickname\":\"悟净\",\"ctime\":\"1545879597\",\"id\":\"12988\",\"addressArray\":\"\"}','POST','/mozi/agent/changeLevel','admin','2018-12-27 14:39:08',NULL,'2018-12-27 14:39:08',NULL),
('90603705581178880',0,'116.30.221.148',NULL,'修改等级','{\"address\":\"\",\"_index\":\"4\",\"level\":\"4\",\"sex\":\"2\",\"mobile\":\"13304863789\",\"selectLevel\":\"2\",\"_rowKey\":\"23\",\"recommendNickname\":\"牛忠新\",\"recommendMobile\":\"18045933006\",\"nickname\":\"悟净\",\"ctime\":\"1545879597\",\"id\":\"12988\",\"addressArray\":\"\"}','POST','/mozi/agent/changeLevel','admin','2018-12-27 14:39:08',NULL,'2018-12-27 14:39:08',NULL),
('90603695313522688',0,'116.30.221.148',NULL,'修改等级','{\"address\":\"\",\"_index\":\"4\",\"level\":\"4\",\"sex\":\"2\",\"mobile\":\"13304863789\",\"selectLevel\":\"2\",\"_rowKey\":\"23\",\"recommendNickname\":\"牛忠新\",\"recommendMobile\":\"18045933006\",\"nickname\":\"悟净\",\"ctime\":\"1545879597\",\"id\":\"12988\",\"addressArray\":\"\"}','POST','/mozi/agent/changeLevel','admin','2018-12-27 14:39:05',NULL,'2018-12-27 14:39:05',NULL),
('90603694600491008',0,'116.30.221.148',NULL,'修改等级','{\"address\":\"\",\"_index\":\"4\",\"level\":\"4\",\"sex\":\"2\",\"mobile\":\"13304863789\",\"selectLevel\":\"2\",\"_rowKey\":\"23\",\"recommendNickname\":\"牛忠新\",\"recommendMobile\":\"18045933006\",\"nickname\":\"悟净\",\"ctime\":\"1545879597\",\"id\":\"12988\",\"addressArray\":\"\"}','POST','/mozi/agent/changeLevel','admin','2018-12-27 14:39:05',NULL,'2018-12-27 14:39:05',NULL),
('90603693874876416',0,'116.30.221.148',NULL,'修改等级','{\"address\":\"\",\"_index\":\"4\",\"level\":\"4\",\"sex\":\"2\",\"mobile\":\"13304863789\",\"selectLevel\":\"2\",\"_rowKey\":\"23\",\"recommendNickname\":\"牛忠新\",\"recommendMobile\":\"18045933006\",\"nickname\":\"悟净\",\"ctime\":\"1545879597\",\"id\":\"12988\",\"addressArray\":\"\"}','POST','/mozi/agent/changeLevel','admin','2018-12-27 14:39:05',NULL,'2018-12-27 14:39:05',NULL),
('90603693174427648',0,'116.30.221.148',NULL,'修改等级','{\"address\":\"\",\"_index\":\"4\",\"level\":\"4\",\"sex\":\"2\",\"mobile\":\"13304863789\",\"selectLevel\":\"2\",\"_rowKey\":\"23\",\"recommendNickname\":\"牛忠新\",\"recommendMobile\":\"18045933006\",\"nickname\":\"悟净\",\"ctime\":\"1545879597\",\"id\":\"12988\",\"addressArray\":\"\"}','POST','/mozi/agent/changeLevel','admin','2018-12-27 14:39:05',NULL,'2018-12-27 14:39:05',NULL),
('90603692335566848',0,'116.30.221.148',NULL,'修改等级','{\"address\":\"\",\"_index\":\"4\",\"level\":\"4\",\"sex\":\"2\",\"mobile\":\"13304863789\",\"selectLevel\":\"2\",\"_rowKey\":\"23\",\"recommendNickname\":\"牛忠新\",\"recommendMobile\":\"18045933006\",\"nickname\":\"悟净\",\"ctime\":\"1545879597\",\"id\":\"12988\",\"addressArray\":\"\"}','POST','/mozi/agent/changeLevel','admin','2018-12-27 14:39:05',NULL,'2018-12-27 14:39:05',NULL),
('90603691496706048',0,'116.30.221.148',NULL,'修改等级','{\"address\":\"\",\"_index\":\"4\",\"level\":\"4\",\"sex\":\"2\",\"mobile\":\"13304863789\",\"selectLevel\":\"2\",\"_rowKey\":\"23\",\"recommendNickname\":\"牛忠新\",\"recommendMobile\":\"18045933006\",\"nickname\":\"悟净\",\"ctime\":\"1545879597\",\"id\":\"12988\",\"addressArray\":\"\"}','POST','/mozi/agent/changeLevel','admin','2018-12-27 14:39:04',NULL,'2018-12-27 14:39:04',NULL),
('90603689194033152',1,'116.30.221.148',NULL,'修改等级','{\"address\":\"\",\"_index\":\"4\",\"level\":\"4\",\"sex\":\"2\",\"mobile\":\"13304863789\",\"selectLevel\":\"2\",\"_rowKey\":\"23\",\"recommendNickname\":\"牛忠新\",\"recommendMobile\":\"18045933006\",\"nickname\":\"悟净\",\"ctime\":\"1545879597\",\"id\":\"12988\",\"addressArray\":\"\"}','POST','/mozi/agent/changeLevel','admin','2018-12-27 14:39:04',NULL,'2018-12-27 14:39:04',NULL),
('90603684072787968',0,'116.30.221.148',NULL,'修改等级','{\"address\":\"\",\"_index\":\"4\",\"level\":\"4\",\"sex\":\"2\",\"mobile\":\"13304863789\",\"selectLevel\":\"2\",\"_rowKey\":\"23\",\"recommendNickname\":\"牛忠新\",\"recommendMobile\":\"18045933006\",\"nickname\":\"悟净\",\"ctime\":\"1545879597\",\"id\":\"12988\",\"addressArray\":\"\"}','POST','/mozi/agent/changeLevel','admin','2018-12-27 14:39:03',NULL,'2018-12-27 14:39:03',NULL),
('90601923870199808',1,'116.30.221.119',NULL,'登录系统','{\"password\":\"你是看不见我的\",\"captcha\":\"o2jo\",\"saveLogin\":\"true\",\"captchaId\":\"af4266ca0c1b487d8ac36ffda1091dde\",\"username\":\"mozi \"}','POST','/mozi/login','mozi','2018-12-27 14:32:03',NULL,'2018-12-27 14:32:03',NULL),
('90602349407506432',1,'116.30.221.148',NULL,'登录系统','{\"password\":\"你是看不见我的\",\"captcha\":\"lsaq\",\"saveLogin\":\"true\",\"captchaId\":\"b55338eb0a6642c6a155b171817d3d06\",\"username\":\"admin\"}','POST','/mozi/login','admin','2018-12-27 14:33:44',NULL,'2018-12-27 14:33:44',NULL),
('90600985684086784',1,'113.89.97.31',NULL,'登录系统','{\"password\":\"你是看不见我的\",\"captcha\":\"ERQZ\",\"saveLogin\":\"true\",\"captchaId\":\"22bff7abaae842a0bd16a32db825372e\",\"username\":\"mozi\"}','POST','/mozi/login','mozi','2018-12-27 14:28:19',NULL,'2018-12-27 14:28:19',NULL),
('90601610132066304',0,'116.30.221.148',NULL,'登录系统','{\"password\":\"你是看不见我的\",\"captcha\":\"t5bz\",\"saveLogin\":\"true\",\"captchaId\":\"8715a4f6e1e54e06ae831eea1dd2b569\",\"username\":\"mozi\"}','POST','/mozi/login','mozi','2018-12-27 14:30:48',NULL,'2018-12-27 14:30:48',NULL),
('90600807493275648',1,'116.30.221.148',NULL,'登录系统','{\"password\":\"你是看不见我的\",\"captcha\":\"yd3s\",\"saveLogin\":\"true\",\"captchaId\":\"4a3692777ca54fe4a38d566e538f92e4\",\"username\":\"mozi\"}','POST','/mozi/login','mozi','2018-12-27 14:27:37',NULL,'2018-12-27 14:27:37',NULL),
('90590946076397568',1,'116.30.221.148',NULL,'登录系统','{\"password\":\"你是看不见我的\",\"captcha\":\"yads\",\"saveLogin\":\"true\",\"captchaId\":\"111670574c0c479196089d421bbb2d07\",\"username\":\"mozi\"}','POST','/mozi/login','mozi','2018-12-27 13:48:26',NULL,'2018-12-27 13:48:26',NULL),
('90365000815742976',14,'116.30.221.119',NULL,'暂停定时任务','{\"cronExpression\":\"* * */1 * * ?\",\"createdAt\":\"2018-12-20 13:16:34\",\"updatedBy\":\"\",\"_index\":\"0\",\"createdBy\":\"\",\"jobClassName\":\"com.mozi.settle.quartz.jobs.CompleteOrderJob\",\"parameter\":\"\",\"description\":\"订单自动收货脚本\",\"id\":\"88046213697376256\",\"updatedAt\":\"2018-12-26 18:58:35\",\"status\":\"0\",\"_rowKey\":\"462\"}','POST','/mozi/quartzJob/pause','admin','2018-12-26 22:50:36',NULL,'2018-12-26 22:50:36',NULL),
('90374996077056000',13,'116.30.221.119',NULL,'恢复定时任务','{\"cronExpression\":\"* * */1 * * ?\",\"createdAt\":\"2018-12-20 13:16:34\",\"updatedBy\":\"\",\"_index\":\"0\",\"createdBy\":\"\",\"jobClassName\":\"com.mozi.settle.quartz.jobs.CompleteOrderJob\",\"parameter\":\"\",\"description\":\"订单自动收货脚本\",\"id\":\"88046213697376256\",\"updatedAt\":\"2018-12-26 22:50:36\",\"status\":\"-1\",\"_rowKey\":\"161\"}','POST','/mozi/quartzJob/resume','admin','2018-12-26 23:30:19',NULL,'2018-12-26 23:30:19',NULL),
('92824705416826880',144,'127.0.0.1',NULL,'登录系统','{\"password\":\"你是看不见我的\",\"captcha\":\"v616\",\"saveLogin\":\"true\",\"captchaId\":\"5c142028a49c4478a98b060a3714f755\",\"username\":\"admin\"}','POST','/skeleton/login','admin','2019-01-02 17:44:35',NULL,'2019-01-02 17:44:35',NULL),
('92830899158126592',172,'127.0.0.1',NULL,'登录系统','{\"password\":\"你是看不见我的\",\"captcha\":\"jyse\",\"saveLogin\":\"true\",\"captchaId\":\"54caabd5c744474d8c87696a7c1c7fc7\",\"username\":\"admin\"}','POST','/skeleton/login','admin','2019-01-02 18:09:12',NULL,'2019-01-02 18:09:12',NULL),
('92831564320215040',1,'127.0.0.1',NULL,'登录系统','{\"password\":\"你是看不见我的\",\"captcha\":\"hbak\",\"saveLogin\":\"true\",\"captchaId\":\"e41159dac5fa49b3820b09a59e4aaaa6\",\"username\":\"admin\"}','POST','/skeleton/login','admin','2019-01-02 18:11:50',NULL,'2019-01-02 18:11:50',NULL),
('92832551378358272',13,'127.0.0.1',NULL,'添加定时任务','{\"cronExpression\":\"*/5 * * * * ?\",\"paramter\":\"\",\"jobClassName\":\"com.xm.skeleton.quartz.jobs.JobWithoutParam\",\"parameter\":\"Test\",\"description\":\"带参测试任务\"}','POST','/skeleton/quartzJob/add','admin','2019-01-02 18:15:46',NULL,'2019-01-02 18:15:46',NULL),
('92832658324721664',77,'127.0.0.1',NULL,'添加定时任务','{\"cronExpression\":\"*/5 * * * * ?\",\"paramter\":\"\",\"jobClassName\":\"com.xm.admin.quartz.jobs.JobWithoutParam\",\"parameter\":\"Test\",\"description\":\"带参测试任务\"}','POST','/skeleton/quartzJob/add','admin','2019-01-02 18:16:11',NULL,'2019-01-02 18:16:11',NULL),
('92832893042167808',5,'127.0.0.1',NULL,'添加定时任务','{\"cronExpression\":\"*/5 * * * * ?\",\"paramter\":\"\",\"jobClassName\":\"com.xm.admin.quartz.jobs.WithoutParam\",\"description\":\"无参定时任务\"}','POST','/skeleton/quartzJob/add','admin','2019-01-02 18:17:07',NULL,'2019-01-02 18:17:07',NULL),
('92832972473896960',4,'127.0.0.1',NULL,'添加定时任务','{\"cronExpression\":\"*/5 * * * * ?\",\"paramter\":\"\",\"jobClassName\":\"com.xm.admin.quartz.jobs.JobWithoutParam\",\"description\":\"无参定时任务\"}','POST','/skeleton/quartzJob/add','admin','2019-01-02 18:17:26',NULL,'2019-01-02 18:17:26',NULL),
('92833003562078208',6,'127.0.0.1',NULL,'添加定时任务','{\"cronExpression\":\"*/5 * * * * ?\",\"paramter\":\"\",\"jobClassName\":\"com.xm.admin.quartz.jobs.JobWithParam\",\"description\":\"无参定时任务\"}','POST','/skeleton/quartzJob/add','admin','2019-01-02 18:17:33',NULL,'2019-01-02 18:17:33',NULL);

/*Table structure for table `st_admin_role` */

DROP TABLE IF EXISTS `st_admin_role`;

CREATE TABLE `st_admin_role` (
  `id` varchar(255) NOT NULL,
  `role_id` varchar(255) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `st_admin_role` */

insert  into `st_admin_role`(`id`,`role_id`,`user_id`,`created_at`,`created_by`,`updated_at`,`updated_by`) values 
('51919463095734273','496138616573953','51919414177566720','2018-09-11 20:41:46',NULL,'2018-09-11 20:41:46',NULL),
('87336531408195585','496138616573952','47599079840026624','2018-12-18 14:16:33',NULL,'2018-12-18 14:16:33',NULL),
('92831454303621121','496138616573953','87338083204206592','2019-01-02 18:11:24',NULL,'2019-01-02 18:11:24',NULL);

/*Table structure for table `st_department` */

DROP TABLE IF EXISTS `st_department`;

CREATE TABLE `st_department` (
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

/*Data for the table `st_department` */

insert  into `st_department`(`id`,`is_parent`,`parent_id`,`sort_order`,`status`,`title`,`created_at`,`created_by`,`updated_at`,`updated_by`) values 
('87336063856545792','\0','87335940934078464',1.00,0,'数据维护','2018-12-18 14:14:41','','2018-12-18 14:15:02',''),
('87335940934078464','','0',1.00,0,'运营中心','2018-12-18 14:14:12',NULL,'2018-12-18 14:14:41',NULL),
('40681289119961088','\0','40652270295060480',2.00,0,'VIP','2018-08-11 20:25:16','','2018-08-11 22:47:48',''),
('87336376579657728','','0',1.00,0,'产品中心','2018-12-18 14:15:56',NULL,'2018-12-18 14:16:11',NULL),
('87336440425353216','\0','87336376579657728',1.00,0,'研发一部','2018-12-18 14:16:11',NULL,'2018-12-18 14:16:11',NULL),
('40652338142121984','\0','40652270295060480',1.00,0,'游客','2018-08-11 18:30:13',NULL,'2018-08-11 18:30:13',NULL);

/*Table structure for table `st_permission` */

DROP TABLE IF EXISTS `st_permission`;

CREATE TABLE `st_permission` (
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

/*Data for the table `st_permission` */

insert  into `st_permission`(`id`,`description`,`name`,`parent_id`,`type`,`sort_order`,`component`,`path`,`title`,`icon`,`level`,`button_type`,`status`,`url`,`created_at`,`created_by`,`updated_at`,`updated_by`) values 
('5129710648430592','','sys','',0,3.00,'Main','/form','系统管理','ios-settings',1,'',0,'','2018-06-04 19:02:29','','2018-09-04 22:50:52',''),
('5129710648430593','','user-manage','5129710648430592',0,1.10,'sys/user-manage/userManage','user-manage','管理员管理','md-person',2,'',0,'','2018-06-04 19:02:32','','2018-09-03 16:06:57',''),
('5129710648430594','','role-manage','5129710648430592',0,1.50,'sys/role-manage/roleManage','role-manage','角色管理','md-contacts',2,'',0,'','2018-06-04 19:02:35','','2018-08-23 17:31:27',''),
('5129710648430595','','menu-manage','5129710648430592',0,1.60,'sys/menu-manage/menuManage','menu-manage','菜单权限管理','md-menu',2,'',0,'','2018-06-04 19:02:37','','2018-08-23 17:31:33',''),
('15701400130424832','','','5129710648430593',1,1.11,'','/iwallet/user/admin/add','添加用户','',3,'add',0,'','2018-06-03 22:04:06','','2018-08-31 17:24:08',''),
('15701915807518720','','','5129710648430593',1,1.13,'','/iwallet/user/admin/disable/**','禁用用户','',3,'disable',0,'','2018-06-03 22:06:09','','2018-08-31 17:24:39',''),
('15708892205944832','','','5129710648430593',1,1.14,'','/iwallet/user/admin/enable/**','启用用户','',3,'enable',0,'','2018-06-03 22:33:52','','2018-08-31 17:24:52',''),
('16678126574637056','','','5129710648430593',1,1.12,'','/iwallet/user/admin/edit','编辑用户','',3,'edit',0,'','2018-06-06 14:45:16','','2018-08-31 17:24:23',''),
('16678447719911424','','','5129710648430593',1,1.15,'','/iwallet/user/delByIds/**','删除用户','',3,'delete',0,'','2018-06-06 14:46:32','','2018-08-31 17:25:07',''),
('16687383932047360','','','5129710648430594',1,1.21,'','/iwallet/role/save','添加角色','',3,'add',0,'','2018-06-06 15:22:03','','2018-08-31 17:26:02',''),
('16689632049631232','','','5129710648430594',1,1.22,'','/iwallet/role/edit','编辑角色','',3,'edit',0,'','2018-06-06 15:30:59','','2018-08-31 17:26:13',''),
('16689745006432256','','','5129710648430594',1,1.23,'','/iwallet/role/delAllByIds/**','删除角色','',3,'delete',0,'','2018-06-06 15:31:26','','2018-08-31 17:26:23',''),
('16689883993083904','','','5129710648430594',1,1.24,'','/iwallet/role/editRolePerm/**','分配权限','',3,'editPerm',0,'','2018-06-06 15:31:59','','2018-08-31 17:26:45',''),
('16690313745666048','','','5129710648430594',1,1.25,'','/iwallet/role/setDefault','设为默认角色','',3,'setDefault',0,'','2018-06-06 15:33:41','','2018-08-31 17:27:00',''),
('16694861252005888','','','5129710648430595',1,1.31,'','/iwallet/permission/add','添加菜单','',3,'add',0,'','2018-06-06 15:51:46','','2018-08-31 17:27:14',''),
('16695107491205120','','','5129710648430595',1,1.32,'','/iwallet/permission/edit','编辑菜单','',3,'edit',0,'','2018-06-06 15:52:44','','2018-08-31 17:27:21',''),
('16695243126607872','','','5129710648430595',1,1.33,'','/iwallet/permission/delByIds/**','删除菜单','',3,'delete',0,'','2018-06-06 15:53:17','','2018-08-31 17:27:31',''),
('25014528525733888',NULL,NULL,'5129710648430593',1,1.16,NULL,'upload','上传图片',NULL,3,'upload',0,NULL,'2018-06-29 14:51:09',NULL,'2018-06-29 14:51:09',NULL),
('39915540965232640','','monitor','',0,4.00,'Main','/monitor','系统监控','ios-analytics',1,'',0,'','2018-08-09 17:42:28','','2018-09-04 22:50:47',''),
('39916171171991552','','druid','39915540965232640',0,2.40,'sys/monitor/monitor','druid','SQL监控','md-analytics',2,'',0,'https://channel-admin.mozi.top/druid/login.html','2018-08-09 17:44:57','','2018-12-18 14:29:26',''),
('39918482854252544','','swagger','39915540965232640',0,2.50,'sys/monitor/monitor','swagger','接口文档','md-document',2,'',0,'https://channel-admin.mozi.top/swagger-ui.html','2018-08-09 17:54:08','','2018-12-18 14:29:15',''),
('40238597734928384',NULL,'department-manage','5129710648430592',0,1.20,'sys/department-manage/departmentManage','department-manage','部门管理','md-git-branch',2,'',0,NULL,'2018-08-10 15:06:10',NULL,'2018-08-10 15:06:10',NULL),
('41363147411427328','','log-manage','39915540965232640',0,2.20,'sys/log-manage/logManage','log-manage','操作日志管理','md-list-box',2,'',0,'','2018-08-13 17:34:43','','2018-08-20 20:05:21',''),
('41363537456533504','','','41363147411427328',1,2.11,'','/iwallet/log/delByIds/**','删除日志','',3,'delete',0,'','2018-08-13 17:36:16','','2018-08-31 17:28:04',''),
('41364927394353152','','','41363147411427328',1,2.12,'','/iwallet/log/delAll','清空日志','',3,'undefined',0,'','2018-08-13 17:41:48','','2018-08-31 17:28:13',''),
('45235621697949696','','','40238597734928384',1,1.21,'','/iwallet/department/add','添加部门','',3,'add',0,'','2018-08-24 10:02:33','','2018-08-31 17:25:26',''),
('45235787867885568','','','40238597734928384',1,1.22,'','/iwallet/department/edit','编辑部门','',3,'edit',0,'','2018-08-24 10:03:13','','2018-08-31 17:25:36',''),
('45235939278065664','','','40238597734928384',1,1.23,'','/iwallet/department/delByIds/*','删除部门','',3,'delete',0,'','2018-08-24 10:03:49','','2018-08-31 17:25:46',''),
('47909031632703488','','config-manage','5129710648430592',0,1.00,'sys/config-manage/configManage','config-manage','系统配置项','md-funnel',2,'',0,'','2018-08-31 19:05:44','','2018-09-01 18:01:26',''),
('84907582589767680',NULL,'quartz-job','39915540965232640',0,2.10,'sys/quartz-manage/quartzManage','quartz-job','定时任务','md-time',2,'',0,NULL,'2018-12-11 21:24:46',NULL,'2018-12-11 21:24:46',NULL),
('84907899767230464',NULL,'','84907582589767680',1,2.11,'','/mozi/quartzJob/add*','添加定时任务','',3,'add',0,NULL,'2018-12-11 21:26:02',NULL,'2018-12-11 21:26:02',NULL),
('84908172535402496',NULL,'','84907582589767680',1,2.12,'','/mozi/quartzJob/edit*','编辑定时任务','',3,'edit',0,NULL,'2018-12-11 21:27:07',NULL,'2018-12-11 21:27:07',NULL),
('84908391842975744',NULL,'','84907582589767680',1,2.13,'','/mozi/quartzJob/pause*','暂停定时任务','',3,'disable',0,NULL,'2018-12-11 21:27:59',NULL,'2018-12-11 21:27:59',NULL),
('84908678297161728',NULL,'','84907582589767680',1,2.14,'','/mozi/quartzJob/resume*','恢复定时任务','',3,'enable',0,NULL,'2018-12-11 21:29:07',NULL,'2018-12-11 21:29:07',NULL),
('84908899202764800',NULL,'','84907582589767680',1,2.15,'','/mozi/quartzJob/delByIds/*','删除定时任务','',3,'delete',0,NULL,'2018-12-11 21:30:00',NULL,'2018-12-11 21:30:00',NULL);

/*Table structure for table `st_role` */

DROP TABLE IF EXISTS `st_role`;

CREATE TABLE `st_role` (
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

/*Data for the table `st_role` */

insert  into `st_role`(`id`,`name`,`default_role`,`description`,`data_type`,`created_at`,`created_by`,`updated_at`,`updated_by`) values 
('496138616573952','ROLE_ADMIN',NULL,'超级管理员 拥有所有权限',NULL,'2018-04-22 23:03:49','','2018-08-12 16:14:31',''),
('496138616573953','ROLE_USER','','分润查询',NULL,'2018-05-02 21:40:03','','2018-12-14 17:21:59','');

/*Table structure for table `st_role_permission` */

DROP TABLE IF EXISTS `st_role_permission`;

CREATE TABLE `st_role_permission` (
  `id` varchar(255) NOT NULL,
  `permission_id` varchar(255) DEFAULT NULL,
  `role_id` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `st_role_permission` */

insert  into `st_role_permission`(`id`,`permission_id`,`role_id`,`created_at`,`created_by`,`updated_at`,`updated_by`) values 
('92831080616300544','16678126574637056','496138616573952','2019-01-02 18:09:55',NULL,'2019-01-02 18:09:55',NULL),
('92831080603717632','15701400130424832','496138616573952','2019-01-02 18:09:55',NULL,'2019-01-02 18:09:55',NULL),
('92831080586940416','5129710648430593','496138616573952','2019-01-02 18:09:55',NULL,'2019-01-02 18:09:55',NULL),
('92831080544997376','5129710648430592','496138616573952','2019-01-02 18:09:55',NULL,'2019-01-02 18:09:55',NULL),
('92831080628883456','15701915807518720','496138616573952','2019-01-02 18:09:55',NULL,'2019-01-02 18:09:55',NULL),
('92831080641466368','15708892205944832','496138616573952','2019-01-02 18:09:55',NULL,'2019-01-02 18:09:55',NULL),
('92831080658243584','16678447719911424','496138616573952','2019-01-02 18:09:55',NULL,'2019-01-02 18:09:55',NULL),
('92831080675020800','25014528525733888','496138616573952','2019-01-02 18:09:55',NULL,'2019-01-02 18:09:55',NULL),
('92831080683409408','40238597734928384','496138616573952','2019-01-02 18:09:55',NULL,'2019-01-02 18:09:55',NULL),
('92831080687603713','45235621697949696','496138616573952','2019-01-02 18:09:55',NULL,'2019-01-02 18:09:55',NULL),
('92831080695992320','45235787867885568','496138616573952','2019-01-02 18:09:55',NULL,'2019-01-02 18:09:55',NULL),
('92831080700186625','45235939278065664','496138616573952','2019-01-02 18:09:55',NULL,'2019-01-02 18:09:55',NULL),
('92831080708575232','5129710648430594','496138616573952','2019-01-02 18:09:55',NULL,'2019-01-02 18:09:55',NULL),
('92831080716963840','16687383932047360','496138616573952','2019-01-02 18:09:55',NULL,'2019-01-02 18:09:55',NULL),
('92831080721158144','16689632049631232','496138616573952','2019-01-02 18:09:55',NULL,'2019-01-02 18:09:55',NULL),
('92831080733741056','16689745006432256','496138616573952','2019-01-02 18:09:55',NULL,'2019-01-02 18:09:55',NULL),
('92831080746323968','16689883993083904','496138616573952','2019-01-02 18:09:55',NULL,'2019-01-02 18:09:55',NULL),
('92831080750518272','16690313745666048','496138616573952','2019-01-02 18:09:55',NULL,'2019-01-02 18:09:55',NULL),
('92831080758906880','5129710648430595','496138616573952','2019-01-02 18:09:55',NULL,'2019-01-02 18:09:55',NULL),
('92831080763101184','16694861252005888','496138616573952','2019-01-02 18:09:55',NULL,'2019-01-02 18:09:55',NULL),
('92831080771489792','16695107491205120','496138616573952','2019-01-02 18:09:55',NULL,'2019-01-02 18:09:55',NULL),
('92831080779878400','16695243126607872','496138616573952','2019-01-02 18:09:55',NULL,'2019-01-02 18:09:55',NULL),
('92831080784072704','39915540965232640','496138616573952','2019-01-02 18:09:55',NULL,'2019-01-02 18:09:55',NULL),
('92831080788267009','84907582589767680','496138616573952','2019-01-02 18:09:55',NULL,'2019-01-02 18:09:55',NULL),
('92831080796655616','84907899767230464','496138616573952','2019-01-02 18:09:55',NULL,'2019-01-02 18:09:55',NULL),
('92831080805044224','84908172535402496','496138616573952','2019-01-02 18:09:55',NULL,'2019-01-02 18:09:55',NULL),
('92831080813432832','84908391842975744','496138616573952','2019-01-02 18:09:55',NULL,'2019-01-02 18:09:55',NULL),
('92831080821821440','84908678297161728','496138616573952','2019-01-02 18:09:55',NULL,'2019-01-02 18:09:55',NULL),
('92831080826015744','84908899202764800','496138616573952','2019-01-02 18:09:55',NULL,'2019-01-02 18:09:55',NULL),
('92831080830210048','41363147411427328','496138616573952','2019-01-02 18:09:55',NULL,'2019-01-02 18:09:55',NULL),
('92831080834404353','41363537456533504','496138616573952','2019-01-02 18:09:55',NULL,'2019-01-02 18:09:55',NULL),
('92831080838598657','41364927394353152','496138616573952','2019-01-02 18:09:55',NULL,'2019-01-02 18:09:55',NULL),
('92831080846987264','39916171171991552','496138616573952','2019-01-02 18:09:55',NULL,'2019-01-02 18:09:55',NULL),
('92831080851181568','39918482854252544','496138616573952','2019-01-02 18:09:55',NULL,'2019-01-02 18:09:55',NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
