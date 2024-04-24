/*
SQLyog Ultimate v11.33 (64 bit)
MySQL - 5.7.18-log : Database - db_hospital
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db_hospital` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `db_hospital`;

/*Table structure for table `admini` */

DROP TABLE IF EXISTS `admin`;

CREATE TABLE admin (
  `a_id` int(11) NOT NULL,
  `a_password` varchar(255) DEFAULT NULL,
  `a_name` varchar(255) DEFAULT NULL,
  `a_gender` varchar(255) DEFAULT NULL,
  `a_card` varchar(255) DEFAULT NULL,
  `a_phone` varchar(255) DEFAULT NULL,
  `a_email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`a_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `admini` */

insert  into admin(`a_id`,`a_password`,`a_name`,`a_gender`,`a_card`,`a_phone`,`a_email`) values (666,'123456','java1234','男','440111111111111111','13544444444','123@qq.com');

/*Table structure for table `arrange` */

DROP TABLE IF EXISTS `arrange`;

CREATE TABLE `arrange` (
  `ar_id` varchar(255) NOT NULL,
  `ar_time` varchar(255) DEFAULT NULL,
  `d_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`ar_id`) USING BTREE,
  KEY `arTOd` (`d_id`) USING BTREE,
  CONSTRAINT `arTOd` FOREIGN KEY (`d_id`) REFERENCES `doctor` (`d_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `arrange` */

insert  into `arrange`(`ar_id`,`ar_time`,`d_id`) values ('10002023-11-06','2023-11-06',1000),('10002023-11-07','2023-11-07',1000),('10002023-11-08','2023-11-08',1000);

/*Table structure for table `bed` */

DROP TABLE IF EXISTS `bed`;

CREATE TABLE `bed` (
  `b_id` int(11) NOT NULL,
  `p_id` int(11) DEFAULT NULL,
  `b_state` int(11) DEFAULT NULL,
  `b_start` varchar(255) DEFAULT NULL,
  `d_id` int(11) DEFAULT NULL,
  `b_reason` varchar(255) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`b_id`) USING BTREE,
  KEY `bTOp` (`p_id`) USING BTREE,
  KEY `bTOd` (`d_id`) USING BTREE,
  CONSTRAINT `bTOd` FOREIGN KEY (`d_id`) REFERENCES `doctor` (`d_id`),
  CONSTRAINT `bTOp` FOREIGN KEY (`p_id`) REFERENCES `patient` (`p_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `bed` */

insert  into `bed`(`b_id`,`p_id`,`b_state`,`b_start`,`d_id`,`b_reason`,`version`) values (10,2000,1,'2023-11-08',1000,'病情严重',NULL);

/*Table structure for table `checks` */

DROP TABLE IF EXISTS `checks`;

CREATE TABLE `checks` (
  `ch_id` int(11) NOT NULL AUTO_INCREMENT,
  `ch_name` varchar(255) DEFAULT NULL,
  `ch_price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`ch_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `checks` */

insert  into `checks`(`ch_id`,`ch_name`,`ch_price`) values (1,'B超','201.00'),(2,'CT','435.00'),(3,'核磁共振','653.00'),(4,'MRI','534.00'),(5,'心电图','634.00'),(6,'彩超','213.00'),(7,'血常规','434.00'),(8,'肝功能','543.00'),(9,'血糖','434.00'),(10,'甲状腺','434.00'),(11,'视力','50.00');

/*Table structure for table `doctor` */

DROP TABLE IF EXISTS `doctor`;

CREATE TABLE `doctor` (
  `d_id` int(11) NOT NULL,
  `d_password` varchar(255) DEFAULT NULL,
  `d_name` varchar(255) DEFAULT NULL,
  `d_gender` varchar(255) DEFAULT NULL,
  `d_phone` varchar(255) DEFAULT NULL,
  `d_card` varchar(255) DEFAULT NULL,
  `d_email` varchar(255) DEFAULT NULL,
  `d_post` varchar(255) DEFAULT NULL,
  `d_introduction` varchar(255) DEFAULT NULL,
  `d_section` varchar(255) DEFAULT NULL,
  `d_state` int(11) NOT NULL,
  `d_price` decimal(10,2) DEFAULT NULL,
  `d_people` int(11) DEFAULT NULL,
  `d_star` decimal(10,2) DEFAULT NULL,
  `d_avg_star` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`d_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `doctor` */

insert  into `doctor`(`d_id`,`d_password`,`d_name`,`d_gender`,`d_phone`,`d_card`,`d_email`,`d_post`,`d_introduction`,`d_section`,`d_state`,`d_price`,`d_people`,`d_star`,`d_avg_star`) values (-1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL),(1000,'3d7dd7b26500bd0595573b651d0080fd','张三','男','13899999999','444111199901011111','456@qq.com','主任医师','专职神经内科医生','神经内科',1,'10.00',1,'5.00','5.00');

/*Table structure for table `drug` */

DROP TABLE IF EXISTS `drug`;

CREATE TABLE `drug` (
  `dr_id` int(11) NOT NULL AUTO_INCREMENT,
  `dr_name` varchar(255) DEFAULT NULL,
  `dr_price` decimal(10,2) DEFAULT NULL,
  `dr_number` int(11) DEFAULT NULL,
  `dr_publisher` varchar(255) DEFAULT NULL,
  `dr_unit` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`dr_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `drug` */

insert  into `drug`(`dr_id`,`dr_name`,`dr_price`,`dr_number`,`dr_publisher`,`dr_unit`) values (1,'青霉素','23.00',22,'国家医药局','袋'),(2,'苯唑西林','11.00',35,'国家医药局','盒'),(3,'氨苄西林','13.00',51,'国家医药局','盒'),(4,'哌拉西林','2.00',7,'国家医药局','盒'),(5,'阿莫西林','13.00',20,'国家医药局','盒'),(6,'头孢唑林','3.00',32,'国家医药局','盒'),(7,'头孢氨苄','4.00',43,'国家医药局','盒'),(8,'头孢呋辛','8.00',54,'国家医药局','盒'),(9,'阿米卡星','5.00',54,'国家医药局','袋'),(10,'庆大霉素','7.00',64,'国家医药局','袋'),(11,'红霉素','6.00',76,'国家医药局','袋'),(12,'阿奇霉素','54.00',52,'国家医药局','袋'),(13,'克林霉素','65.00',21,'国家医药局','袋'),(14,'复方磺胺甲噁唑','76.00',54,'国家医药局','袋'),(15,'诺氟沙星','65.00',33,'国家医药局','袋'),(16,'左氧氟沙星','76.00',43,'国家医药局','袋'),(17,'感康','15.00',10,'感康集团','盒');

/*Table structure for table `orders` */

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `o_id` int(11) NOT NULL AUTO_INCREMENT,
  `p_id` int(11) DEFAULT NULL,
  `d_id` int(11) DEFAULT NULL,
  `o_record` varchar(255) DEFAULT NULL,
  `o_start` varchar(255) DEFAULT NULL,
  `o_end` varchar(255) DEFAULT NULL,
  `o_state` int(11) DEFAULT NULL,
  `o_drug` varchar(255) DEFAULT NULL,
  `o_check` varchar(255) DEFAULT NULL,
  `o_total_price` decimal(10,2) DEFAULT NULL,
  `o_price_state` int(11) DEFAULT NULL,
  `o_advice` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`o_id`) USING BTREE,
  KEY `oTOp` (`p_id`) USING BTREE,
  KEY `0TOd` (`d_id`) USING BTREE,
  CONSTRAINT `0TOd` FOREIGN KEY (`d_id`) REFERENCES `doctor` (`d_id`),
  CONSTRAINT `oTOp` FOREIGN KEY (`p_id`) REFERENCES `patient` (`p_id`)
) ENGINE=InnoDB AUTO_INCREMENT=211209 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `orders` */

insert  into `orders`(`o_id`,`p_id`,`d_id`,`o_record`,`o_start`,`o_end`,`o_state`,`o_drug`,`o_check`,`o_total_price`,`o_price_state`,`o_advice`) values (3989,2000,1000,'重感冒','2023-11-06 16:30-17:30','2023-11-06 16:30-17:30',1,'青霉素*23(元)*1 苯唑西林*11(元)*1  药物总价34元 ','CT*435(元)  项目总价435元 ','469.00',0,NULL),(5918,2000,1000,'cccc','2023-11-08 16:30-17:30','2023-11-08 16:38:39',1,'青霉素*23(元)*1 氨苄西林*13(元)*1  药物总价36元 ','B超*201(元) 核磁共振*653(元)  项目总价854元 ','0.00',1,NULL);

/*Table structure for table `patient` */

DROP TABLE IF EXISTS `patient`;

CREATE TABLE `patient` (
  `p_id` int(11) NOT NULL,
  `p_password` varchar(255) DEFAULT NULL,
  `p_name` varchar(255) DEFAULT NULL,
  `p_gender` varchar(255) DEFAULT NULL,
  `p_phone` varchar(255) DEFAULT NULL,
  `p_card` varchar(255) DEFAULT NULL,
  `p_email` varchar(255) DEFAULT NULL,
  `p_state` int(11) DEFAULT NULL,
  `p_birthday` varchar(255) DEFAULT NULL,
  `p_age` int(11) DEFAULT NULL,
  PRIMARY KEY (`p_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `patient` */

insert  into `patient`(`p_id`,`p_password`,`p_name`,`p_gender`,`p_phone`,`p_card`,`p_email`,`p_state`,`p_birthday`,`p_age`) values (-1,NULL,NULL,NULL,NULL,NULL,NULL,1,'1997-01-20',1),(2000,'3d7dd7b26500bd0595573b651d0080fd','病人小徐','男','15977777777','551222200201013333','789@qq.com',1,'2023-07-27',21);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
