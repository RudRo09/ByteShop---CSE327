-- File name: C:\Users\Itachi\Desktop\project\project.sql
-- Created by Ζ쬼Ε抠Ζ抸Ζ揔ΖΖΖo 


--
-- Table structure for table `carts_cart`
--

CREATE TABLE `carts_cart` (
  `id` INT NOT NULL  AUTO_INCREMENT,
  `cart_id` VARCHAR(100) NOT NULL,
  `date_added` DATE NOT NULL,
  PRIMARY KEY (`id` ASC)
) DEFAULT CHARSET=utf8 ENGINE=InnoDB;

--
-- Table structure for table `accounts_account`
--

CREATE TABLE `accounts_account` (
  `id` INT NOT NULL  AUTO_INCREMENT,
  `password` VARCHAR(128) NOT NULL,
  `first_name` VARCHAR(25) NOT NULL,
  `last_name` VARCHAR(25) NOT NULL,
  `username` VARCHAR(25) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `phone_number` VARCHAR(11) NOT NULL,
  `date_joined` DATETIME NOT NULL,
  `last_login` DATETIME NOT NULL,
  `is_admin` TEXT NOT NULL,
  `is_staff` TEXT NOT NULL,
  `is_active` TEXT NOT NULL,
  `is_superadmin` TEXT NOT NULL,
  PRIMARY KEY (`id` ASC)
) DEFAULT CHARSET=utf8 ENGINE=InnoDB;

--
-- Table structure for table `category_category`
--

CREATE TABLE `category_category` (
  `id` INT NOT NULL  AUTO_INCREMENT,
  `category_name` VARCHAR(50) NOT NULL,
  `slug` VARCHAR(100) NOT NULL,
  `description` TEXT NOT NULL,
  `category_image` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id` ASC)
) DEFAULT CHARSET=utf8 ENGINE=InnoDB;

--
-- Table structure for table `byteshop_product`
--

CREATE TABLE `byteshop_product` (
  `id` INT NOT NULL  AUTO_INCREMENT,
  `product_name` VARCHAR(200) NOT NULL,
  `slug` VARCHAR(200) NOT NULL,
  `description` TEXT NOT NULL,
  `price` INT NOT NULL DEFAULT 0,
  `product_image` VARCHAR(100) NOT NULL,
  `stock` INT NOT NULL DEFAULT 0,
  `is_available` TEXT NOT NULL,
  `created_date` DATETIME NOT NULL,
  `modified_date` DATETIME NOT NULL,
  `category_id` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id` ASC),
  KEY `byteshop_product_category_id_e2c1ba44` (`category_id` ASC),
  CONSTRAINT `category_id_category_category_id` FOREIGN KEY (`category_id`) REFERENCES `category_category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) DEFAULT CHARSET=utf8 ENGINE=InnoDB;

--
-- Table structure for table `orders_payment`
--

CREATE TABLE `orders_payment` (
  `id` INT NOT NULL  AUTO_INCREMENT,
  `amount_paid` VARCHAR(100) NOT NULL,
  `status` VARCHAR(100) NOT NULL,
  `crated_at` DATETIME NOT NULL,
  `user_id` TEXT NOT NULL,
  `payment_id` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id` ASC),
  KEY `orders_payment_user_id_cfa9f321` (`user_id` ASC),
  CONSTRAINT `user_id_accounts_account_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_account` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) DEFAULT CHARSET=utf8 ENGINE=InnoDB;

--
-- Table structure for table `carts_cartitem`
--

CREATE TABLE `carts_cartitem` (
  `id` INT NOT NULL  AUTO_INCREMENT,
  `quantity` INT NOT NULL DEFAULT 0,
  `is_active` TEXT NOT NULL,
  `product_id` TEXT NOT NULL,
  `user_id` TEXT NULL,
  `cart_id` TEXT NULL,
  PRIMARY KEY (`id` ASC),
  KEY `carts_cartitem_product_id_acd010e4` (`product_id` ASC),
  KEY `carts_cartitem_user_id_4d21e0d9` (`user_id` ASC),
  KEY `carts_cartitem_cart_id_9cb0a756` (`cart_id` ASC),
  CONSTRAINT `cart_id_carts_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `carts_cart` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_id_accounts_account_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_account` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `product_id_byteshop_product_id` FOREIGN KEY (`product_id`) REFERENCES `byteshop_product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) DEFAULT CHARSET=utf8 ENGINE=InnoDB;

--
-- Table structure for table `orders_order`
--

CREATE TABLE `orders_order` (
  `id` INT NOT NULL  AUTO_INCREMENT,
  `order_number` VARCHAR(100) NOT NULL,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `phone_number` VARCHAR(25) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `city` VARCHAR(100) NOT NULL,
  `area` VARCHAR(100) NOT NULL,
  `order_note` VARCHAR(100) NOT NULL,
  `status` VARCHAR(10) NOT NULL,
  `ip_address` VARCHAR(20) NOT NULL,
  `is_ordered` TEXT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `payment_id` TEXT NULL,
  `user_id` TEXT NULL,
  `order_total` DOUBLE NOT NULL DEFAULT 0,
  PRIMARY KEY (`id` ASC),
  KEY `orders_order_payment_id_46928ccc` (`payment_id` ASC),
  KEY `orders_order_user_id_e9b59eb1` (`user_id` ASC),
  CONSTRAINT `user_id_accounts_account_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_account` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `payment_id_orders_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `orders_payment` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) DEFAULT CHARSET=utf8 ENGINE=InnoDB;

--
-- Table structure for table `orders_orderproduct`
--

CREATE TABLE `orders_orderproduct` (
  `id` INT NOT NULL  AUTO_INCREMENT,
  `quantity` INT NOT NULL DEFAULT 0,
  `product_price` DOUBLE NOT NULL DEFAULT 0,
  `ordered` TEXT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `order_id` TEXT NOT NULL,
  `payment_id` TEXT NULL,
  `product_id` TEXT NOT NULL,
  `user_id` TEXT NOT NULL,
  PRIMARY KEY (`id` ASC),
  KEY `orders_orderproduct_order_id_5022a3e2` (`order_id` ASC),
  KEY `orders_orderproduct_payment_id_492ed997` (`payment_id` ASC),
  KEY `orders_orderproduct_product_id_4d6ac024` (`product_id` ASC),
  KEY `orders_orderproduct_user_id_1e7a7ab7` (`user_id` ASC),
  CONSTRAINT `user_id_accounts_account_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_account` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `product_id_byteshop_product_id` FOREIGN KEY (`product_id`) REFERENCES `byteshop_product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `payment_id_orders_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `orders_payment` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_id_orders_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders_order` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) DEFAULT CHARSET=utf8 ENGINE=InnoDB;

--
-- Table structure for table `byteshop_reviewrating`
--

CREATE TABLE `byteshop_reviewrating` (
  `id` INT NOT NULL  AUTO_INCREMENT,
  `subject` VARCHAR(100) NOT NULL,
  `review` TEXT NOT NULL,
  `rating` DOUBLE NOT NULL DEFAULT 0,
  `ip` VARCHAR(20) NOT NULL,
  `status` TEXT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `product_id` TEXT NOT NULL,
  `user_id` TEXT NOT NULL,
  PRIMARY KEY (`id` ASC),
  KEY `byteshop_reviewrating_product_id_dbbb4356` (`product_id` ASC),
  KEY `byteshop_reviewrating_user_id_b0d82e81` (`user_id` ASC),
  CONSTRAINT `user_id_accounts_account_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_account` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `product_id_byteshop_product_id` FOREIGN KEY (`product_id`) REFERENCES `byteshop_product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) DEFAULT CHARSET=utf8 ENGINE=InnoDB;

--
-- Table structure for table `admin_honeypot_loginattempt`
--

CREATE TABLE `admin_honeypot_loginattempt` (
  `id` INT NOT NULL  AUTO_INCREMENT,
  `username` VARCHAR(255) NULL DEFAULT NULL,
  `ip_address` VARCHAR(39) NULL DEFAULT NULL,
  `session_key` VARCHAR(50) NULL DEFAULT NULL,
  `user_agent` TEXT NULL,
  `timestamp` DATETIME NOT NULL,
  `path` TEXT NULL,
  PRIMARY KEY (`id` ASC)
) DEFAULT CHARSET=utf8 ENGINE=InnoDB;

--
-- Dumping data for table `carts_cart`
--

INSERT INTO `carts_cart` (`id`,`cart_id`,`date_added`) VALUES (34,'b3t7mm1msisookq2mm4rkth1h3vviat9','2021-09-11');

--
-- Dumping data for table `accounts_account`
--

INSERT INTO `accounts_account` (`id`,`password`,`first_name`,`last_name`,`username`,`email`,`phone_number`,`date_joined`,`last_login`,`is_admin`,`is_staff`,`is_active`,`is_superadmin`) VALUES (1,'pbkdf2_sha256$260000$wIJjvNjQxEllm1BUWxjhhk$28NJFd3CkN9ns4dhH3XD+D6hZTTWlaGpK899S/ZHW9w=','Shafin','Islam','byteshop','shafin.rudro@northsouth.edu','','2021-07-11 16:24:08.369361','2021-09-10 18:06:36.209137','1','1','1','1'),(14,'pbkdf2_sha256$260000$Bdey8VzpwSPseegj82vJup$0XaZydfi/jJah2w27nNgSpcQOCypAxIL6zGGNAFxx/c=','Shad','Man','islamrudro09','islamrudro09@gmail.com','01784493271','2021-08-12 15:12:43.839486','2021-08-12 15:13:12.542545','0','0','1','0'),(15,'pbkdf2_sha256$260000$iDfWuqheaNZkOkFSpqYhQd$eWvjz2kO2zWu0N8MTFA2ZSHgyxmVMNwSt1wYQVnGOzY=','Satoru','Gojo','shadmanulislam222','shadmanulislam222@gmail.com','01','2021-09-06 17:13:14.564076','2021-09-06 17:13:14.564076','0','0','0','0');

--
-- Dumping data for table `category_category`
--

INSERT INTO `category_category` (`id`,`category_name`,`slug`,`description`,`category_image`) VALUES (1,'Desktop','desktop','Test desktop category.','category/images/okk.jpg'),(2,'Laptop','laptop','Demo laptop description','category/images/okkk.jpg'),(3,'Component','component','Demo component descripstion.','category/images/comp.webp'),(4,'Monitor','monitor','Demo monitor description.','category/images/images.jpg'),(5,'UPS','ups','Demo UPS description.','category/images/ups.jpg'),(6,'Tablet','tablet','Demo tablet description.','category/images/tab.jpg');

--
-- Dumping data for table `byteshop_product`
--

INSERT INTO `byteshop_product` (`id`,`product_name`,`slug`,`description`,`price`,`product_image`,`stock`,`is_available`,`created_date`,`modified_date`,`category_id`) VALUES (1,'Asus Vivobook X515MA Celeron N4020 15.6\" FHD Laptop Asus Vivobook X515MA Celeron N4020 15.6\" FHD Laptop','asus-vivobook-x515ma-celeron-n4020-156-fhd-laptop-asus-vivobook-x515ma-celeron-n4020-156-fhd-laptop','A demo description!',35500,'product/images/ai.jpg',0,'1','2021-07-15 19:43:02.984103','2021-08-01 15:46:07.406644',2),(2,'AMD Ryzen 5 3500X Gaming PC','amd-ryzen-5-3500x-gaming-pc','Some demo description! Gaming!!',64500,'product/images/ai2.jpg',23,'1','2021-07-15 19:46:08.126122','2021-09-10 14:52:17.378122',1),(3,'Antec NX230 NX Series-Mid Tower Gaming Case','antec-nx230-nx-series-mid-tower-gaming-case','Demo text!',3250,'product/images/casin.jpg',20,'1','2021-07-15 19:47:19.306814','2021-09-10 17:02:25.031570',3),(4,'Gigabyte G27QC 27\" 165Hz QHD Curved Gaming Monitor','gigabyte-g27qc-27-165hz-qhd-curved-gaming-monitor','Demo text',3700,'product/images/mntr.jpg',18,'1','2021-07-15 19:48:27.272441','2021-09-10 14:36:04.964126',4),(5,'Leoch LP12-18 (12V 18Ah) Sealed Lead Acid Battery','leoch-lp12-18-12v-18ah-sealed-lead-acid-battery','Demo ups description!',3700,'product/images/ups.jpg',14,'1','2021-07-15 19:49:18.889004','2021-09-10 16:43:14.531203',5),(6,'Huion H430P Graphics Tablet','huion-h430p-graphics-tablet','Demo description for Tablet!',4300,'product/images/tas.jpg',8,'1','2021-07-15 19:50:02.767800','2021-09-10 13:38:04.228451',6);

--
-- Dumping data for table `carts_cartitem`
--

INSERT INTO `carts_cartitem` (`id`,`quantity`,`is_active`,`product_id`,`user_id`,`cart_id`) VALUES (49,1,'1','2','1','34');

--
-- Dumping data for table `byteshop_reviewrating`
--

INSERT INTO `byteshop_reviewrating` (`id`,`subject`,`review`,`rating`,`ip`,`status`,`created_at`,`updated_at`,`product_id`,`user_id`) VALUES (4,'Star check','Okay',0.500000,'127.0.0.1','1','2021-09-10 17:29:37.026108','2021-09-10 17:29:47.531905','3','1');

--
-- Dumping data for table `admin_honeypot_loginattempt`
--

INSERT INTO `admin_honeypot_loginattempt` (`id`,`username`,`ip_address`,`session_key`,`user_agent`,`timestamp`,`path`) VALUES (1,'shafin.rudro@northsouth.edu','127.0.0.1','y9xrp6asmo7uplfjnulhvr1vmd0q4fpp','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.63 Safari/537.36','2021-09-10 17:58:45.515496','/admin/login/?next=/admin/'),(2,'shafin.rudro@northsouth.edu','127.0.0.1','b3t7mm1msisookq2mm4rkth1h3vviat9','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.63 Safari/537.36','2021-09-10 18:07:22.480064','/admin/login/?next=/admin/'),(3,'shafin.rudro@northsouth.edu','127.0.0.1','b3t7mm1msisookq2mm4rkth1h3vviat9','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.63 Safari/537.36','2021-09-10 18:46:09.205177','/admin/login/?next=/admin/');
