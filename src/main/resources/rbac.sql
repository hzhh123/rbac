/*
SQLyog Ultimate v11.33 (64 bit)
MySQL - 5.1.49-community : Database - db_rbac
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db_rbac` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `db_rbac`;

/*Table structure for table `menu` */

DROP TABLE IF EXISTS `menu`;

CREATE TABLE `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `icon` varchar(60) DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  `_order` varchar(4) DEFAULT NULL,
  `isHeader` varchar(1) DEFAULT NULL,
  `statue` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `menu` */

insert  into `menu`(`id`,`name`,`url`,`icon`,`parentId`,`_order`,`isHeader`,`statue`) values (1,'主菜单',NULL,NULL,0,'1','1',NULL),(2,'权限管理系统','','',1,'2','0',NULL),(3,'用户管理','/user','',2,'3','0',NULL),(4,'角色管理','/role','',2,'4','0',NULL),(5,'菜单管理','/menu/menu?id0=common&id1=menu&id2=menu','',2,'5','0',NULL),(6,'个人',NULL,NULL,0,'6','1',NULL),(7,'测试1',NULL,NULL,6,'7','0',NULL),(8,'组织',NULL,NULL,0,'8','1',NULL),(9,'测试2',NULL,NULL,8,'9','0',NULL);

/*Table structure for table `operationlog` */

DROP TABLE IF EXISTS `operationlog`;

CREATE TABLE `operationlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(20) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `operator` varchar(25) DEFAULT NULL,
  `operationtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `operationlog` */

/*Table structure for table `role` */

DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rolename` varchar(25) DEFAULT NULL,
  `desc` varchar(255) DEFAULT NULL,
  `statue` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;

/*Data for the table `role` */

insert  into `role`(`id`,`rolename`,`desc`,`statue`) values (25,'超级管理员','超级管理员','1'),(26,'管理员','管理员','1'),(27,'234','1233','1'),(28,'ww','12','1'),(30,'err','ee','1'),(31,'ee55','55','1'),(36,'555','55','0'),(40,'123','123','1'),(42,'122','1','1'),(47,'e','e','1'),(49,'33','33','1');

/*Table structure for table `role_menu` */

DROP TABLE IF EXISTS `role_menu`;

CREATE TABLE `role_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleid` int(11) DEFAULT NULL,
  `menuid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `roleid` (`roleid`),
  KEY `menuid` (`menuid`),
  CONSTRAINT `role_menu_ibfk_1` FOREIGN KEY (`roleid`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `role_menu_ibfk_2` FOREIGN KEY (`menuid`) REFERENCES `menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `role_menu` */

/*Table structure for table `role_operationlog` */

DROP TABLE IF EXISTS `role_operationlog`;

CREATE TABLE `role_operationlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleid` int(11) DEFAULT NULL,
  `operationid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `roleid` (`roleid`),
  KEY `operationid` (`operationid`),
  CONSTRAINT `role_operationlog_ibfk_1` FOREIGN KEY (`roleid`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `role_operationlog_ibfk_2` FOREIGN KEY (`operationid`) REFERENCES `operationlog` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `role_operationlog` */

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(25) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `statue` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

/*Data for the table `user` */

insert  into `user`(`id`,`username`,`password`,`statue`) values (1,'admin123','123456','1'),(2,'admin124','123456',NULL),(3,'admin1234','123456','0'),(6,'admin1231','123456','1'),(7,'admin1231','123456','1'),(10,'xxx','xxx33334','1'),(11,'455d','55eeeeeeee','1'),(12,'555r','333yu888899','1'),(13,'556y','yyyyyyy78','1'),(14,'dff','123456','1'),(15,NULL,NULL,'1'),(16,'asd','111',NULL);

/*Table structure for table `user_role` */

DROP TABLE IF EXISTS `user_role`;

CREATE TABLE `user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL,
  `roleid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `roleid` (`roleid`),
  CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`roleid`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

/*Data for the table `user_role` */

insert  into `user_role`(`id`,`userid`,`roleid`) values (33,10,27),(34,1,25),(35,2,25),(38,3,27),(39,6,28),(40,7,27);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
