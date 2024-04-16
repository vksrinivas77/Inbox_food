-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 23, 2024 at 01:41 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `inbox`
--

-- --------------------------------------------------------

--
-- Table structure for table `address_details`
--

CREATE TABLE `address_details` (
  `address_details` int(255) NOT NULL,
  `phone` varchar(25) NOT NULL,
  `Landmark` varchar(400) NOT NULL,
  `address` varchar(400) NOT NULL,
  `user_id` int(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `address_details`
--

INSERT INTO `address_details` (`address_details`, `phone`, `Landmark`, `address`, `user_id`) VALUES
(1, 'Pradeep RS', 'A205, 2nd main road, 9th cross', 'Upkhar solitaire, Attibele, bengaluru-562107', NULL),
(2, 'Pradeep RS', 'A205, 2nd main road, 9th cross', 'Upkhar solitaire, Attibele, bengaluru-562107', NULL),
(3, 'Pradeep RS', 'Upkhar solitaire, Attibele, bengaluru-562107', '100001', 0),
(4, 'Pradeep RS', 'A205, 2nd main road, 9th cross', 'Upkhar solitaire, Attibele, bengaluru-562107', 100001),
(5, 'Pradeep RS', 'A205, 2nd main road, 9th cross', 'Upkhar solitaire, Attibele, bengaluru-562107', 100001),
(6, 'Pradeep RS', 'A205, 2nd main road, 9th cross', 'Upkhar solitaire, Attibele, bengaluru-562107', 100001),
(7, '09035376766', 'near konnapna agrahara bus stop', '1234rf', 131);

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` bigint(20) NOT NULL,
  `admin_password` varchar(300) NOT NULL,
  `admin_name` varchar(20) NOT NULL,
  `admin_phone` bigint(50) NOT NULL,
  `admin_status` tinyint(1) NOT NULL,
  `admin_delete` tinyint(1) NOT NULL,
  `admin_added_date` varchar(20) NOT NULL,
  `admin_updated_date` varchar(20) NOT NULL,
  `admin_address` varchar(100) NOT NULL,
  `admin_type` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `admin_password`, `admin_name`, `admin_phone`, `admin_status`, `admin_delete`, `admin_added_date`, `admin_updated_date`, `admin_address`, `admin_type`) VALUES
(1, '$2y$10$7YkAFIRC.TIzrEoB6M3gM.Gly95mF4xcUSis8RtL5b9Mep84WsCYq', 'Balaji', 9696969696, 1, 0, '2021-01-04', '2024-01-22 04:55:51 ', 'Ballari', 0),
(100000, '$2y$10$uCHfmFGE1ruXqVnzhiI9XuPeqwGjjFCYpb8Ofxlv5fo7A0c2972Ba', 'Pradeep', 7619321936, 1, 1, '2023-10-05 05:27:01 ', '2024-01-22 02:56:53 ', 'qqqqqqqqqqqqqqqqqqqqqqqqde sd', 2),
(100001, '$2y$10$48QsuwQc6A0BstwktVSdFu9gddp7LlWlL5aseBdliJwnDENi.GLWq', 'sandhya', 9876543210, 1, 1, '2023-10-05 05:28:30 ', '2024-01-22 02:56:51 ', 'vdxfbcngvhg esde sd', 2),
(100002, '$2y$10$v8eu1Di152IXPHJf6BUs3.MkHWB.zZ5zcKXzkh8U4ffY6f05Sqyr6', 'BALAJI', 8123112359, 1, 0, '2024-01-22 02:42:57 ', '2024-01-22 04:57:30 ', 'qqqqqqqqqqqqqqqqqqqqqqqqde sd', 3),
(100003, '$2y$10$7YkAFIRC.TIzrEoB6M3gM.Gly95mF4xcUSis8RtL5b9Mep84WsCYq', 'Roopashree', 8792041412, 1, 0, '2024-01-22 05:44:29 ', '2024-01-22 05:44:29 ', 'qqqqqqqqqqqqqqqqqqqqqqqqde sd', 2);

--
-- Triggers `admin`
--
DELIMITER $$
CREATE TRIGGER `active_admin` BEFORE UPDATE ON `admin` FOR EACH ROW UPDATE logs SET logs.logs_inactive_admin=logs.logs_inactive_admin+1 WHERE OLD.admin_status=1 AND NEW.admin_status=0
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `deleted_admin` AFTER UPDATE ON `admin` FOR EACH ROW UPDATE logs SET logs_active_admin=logs.logs_active_admin-1 WHERE NEW.admin_delete = 1
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `inactive_admin` BEFORE UPDATE ON `admin` FOR EACH ROW UPDATE logs SET logs.logs_inactive_admin=logs.logs_inactive_admin-1 WHERE OLD.admin_status=0 AND NEW.admin_status=1
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `inactive_admin_on_delete` BEFORE UPDATE ON `admin` FOR EACH ROW UPDATE logs SET logs_inactive_admin=logs.logs_inactive_admin-1 WHERE NEW.admin_status = 0 AND NEW.admin_delete = 1
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_admin` AFTER INSERT ON `admin` FOR EACH ROW UPDATE logs SET logs_active_admin=logs.logs_active_admin+1
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `cart_id` bigint(20) NOT NULL,
  `cart_items_id` bigint(20) NOT NULL,
  `cart_qty` int(11) NOT NULL,
  `cart_user_id` bigint(20) NOT NULL,
  `cart_added_date` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`cart_id`, `cart_items_id`, `cart_qty`, `cart_user_id`, `cart_added_date`) VALUES
(100221, 3, 2, 100003, '2023-11-24 02:09:00 '),
(100222, 5, 1, 100003, '2023-11-24 02:09:08 '),
(100229, 4, 3, 131, '2024-01-23 10:48:53 '),
(100231, 2, 1, 131, '2024-01-23 11:34:28 '),
(100232, 1, 1, 131, '2024-01-23 04:31:49 '),
(100233, 100002, 1, 131, '2024-01-23 04:31:54 '),
(100234, 100001, 1, 131, '2024-01-23 04:32:39 ');

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `contact_id` bigint(20) NOT NULL,
  `contact_name` varchar(20) NOT NULL,
  `contact_email` varchar(35) NOT NULL,
  `contact_phone` varchar(30) NOT NULL,
  `contact_subject` varchar(2000) NOT NULL,
  `contact_view` tinyint(1) NOT NULL,
  `contact_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`contact_id`, `contact_name`, `contact_email`, `contact_phone`, `contact_subject`, `contact_view`, `contact_date`) VALUES
(32, 'Pradeep RS', 'pradeeprs176@gmail.com', '07619321936', 'dffgxcz', 1, '2022-07-27 00:00:00'),
(33, 'Pradeep RS', 'pradeeprs176@gmail.com', '07619321936', 'sadds', 1, '2022-07-26 00:00:00'),
(34, 'Wedding Photography', 'admin@admin.com', '23424242424', 'gedsfdsg', 1, '2022-07-27 11:24:53'),
(100000, 'roopashree', 'sroopashree28@gmail.com', '9880559606', 'hii', 0, '2023-11-09 04:13:17'),
(100001, 'mr kane', 'Balaji@gmail.com', '7349647783', 'aFSDGFHG', 1, '2023-11-23 01:54:18');

-- --------------------------------------------------------

--
-- Table structure for table `history`
--

CREATE TABLE `history` (
  `history_id` varchar(25) NOT NULL,
  `history_qty` varchar(100) NOT NULL,
  `history_cost` varchar(100) NOT NULL,
  `history_item` varchar(100) NOT NULL,
  `history_date` datetime NOT NULL,
  `history_delivered` int(11) NOT NULL DEFAULT 0,
  `history_user_id` bigint(20) NOT NULL,
  `history_chef_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `history`
--

INSERT INTO `history` (`history_id`, `history_qty`, `history_cost`, `history_item`, `history_date`, `history_delivered`, `history_user_id`, `history_chef_id`) VALUES
('1', '1', '30', '4', '2024-01-22 03:45:27', 1, 131, 0),
('10', '1', '50', '3', '2023-11-18 11:12:06', 0, 131, 0),
('11', '1', '30', '4', '2023-11-21 11:13:38', 0, 100003, 0),
('12', '1,1', '30,20', '4,5', '2023-11-21 11:14:43', 0, 100003, 0),
('13', '1', '20', '100001', '2023-11-21 11:25:58', 0, 100003, 0),
('14', '1', '50', '3', '2023-11-21 11:39:53', 0, 100003, 0),
('15', '1', '50', '3', '2023-11-21 02:43:27', 0, 100003, 0),
('16', '1', '30', '4', '2023-11-21 02:45:25', 0, 100003, 0),
('17', '1', '50', '3', '2023-11-21 02:50:25', 0, 100003, 0),
('18', '2', '30', '4', '2023-11-21 03:12:58', 0, 100003, 0),
('19', '1', '10', '1', '2023-11-21 03:15:27', 0, 100003, 0),
('2', '1', '20', '100001', '2023-11-17 03:45:49', 1, 131, 0),
('20', '1', '30', '4', '2023-11-21 03:17:24', 0, 100003, 0),
('21', '1', '30', '4', '2023-11-21 03:21:23', 0, 100003, 0),
('22', '3', '30', '4', '2023-11-21 03:21:53', 0, 100003, 0),
('23', '2', '30', '4', '2023-11-22 09:26:30', 0, 100003, 0),
('24', '1', '30', '4', '2023-11-22 09:36:33', 0, 100003, 0),
('25', '2', '30', '4', '2023-11-22 09:47:05', 0, 100003, 0),
('26', '1', '30', '4', '2023-11-22 09:56:21', 0, 100003, 0),
('27', '1', '30', '4', '2023-11-22 10:05:37', 0, 100003, 0),
('28', '1', '30', '4', '2023-11-22 10:46:52', 0, 100003, 0),
('29', '1', '30', '4', '2023-11-22 11:18:40', 0, 100003, 0),
('3', '1', '30', '4', '2023-11-17 03:46:44', 1, 131, 0),
('30', '1', '30', '4', '2023-11-23 12:15:17', 0, 100003, 0),
('31', '1', '30', '4', '2023-11-23 12:23:10', 0, 100003, 0),
('32', '1', '30', '4', '2023-11-23 12:26:53', 0, 100003, 0),
('33', '1', '30', '4', '2023-11-23 12:28:15', 0, 100003, 0),
('34', '1', '30', '4', '2023-11-23 12:28:50', 0, 100003, 0),
('35', '1', '30', '4', '2023-11-23 12:32:16', 0, 100003, 0),
('36', '1', '30', '4', '2023-11-23 12:41:14', 0, 100003, 0),
('37', '1', '30', '4', '2023-11-23 12:44:59', 0, 100003, 0),
('38', '1', '30', '4', '2023-11-23 12:03:29', 0, 100003, 0),
('39', '1', '30', '4', '2023-11-23 12:07:46', 0, 100003, 0),
('4', '1,6', '50,30', '3,4', '2023-11-17 04:33:47', 1, 131, 0),
('40', '1,1', '10,30', '1,4', '2023-11-23 02:22:25', 0, 100003, 0),
('41', '1', '20', '100004', '2023-11-24 01:48:38', 0, 131, 0),
('42', '4,2', '20,20', '100004,100005', '2023-11-24 02:05:10', 0, 100003, 0),
('5', '2,1', '50,20', '3,100001', '2024-01-22 11:49:48', 0, 131, 0),
('6', '1', '50', '3', '2023-11-18 03:14:59', 0, 131, 0),
('7', '1,1', '30,20', '4,100001', '2023-11-18 03:19:24', 0, 131, 0),
('8', '1', '50', '3', '2023-11-18 03:20:17', 0, 131, 0),
('9', '1', '30', '4', '2023-11-18 11:09:38', 0, 131, 0);

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `items_id` bigint(20) NOT NULL,
  `items_name` varchar(20) NOT NULL,
  `items_image` varchar(150) NOT NULL,
  `items_cost` bigint(20) NOT NULL,
  `items_delete` tinyint(1) NOT NULL,
  `items_add_date` varchar(20) NOT NULL,
  `items_count` int(11) NOT NULL,
  `item_chef_id` int(11) NOT NULL,
  `item_category` tinyint(1) NOT NULL,
  `item_meal_type` int(11) NOT NULL,
  `item_status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`items_id`, `items_name`, `items_image`, `items_cost`, `items_delete`, `items_add_date`, `items_count`, `item_chef_id`, `item_category`, `item_meal_type`, `item_status`) VALUES
(1, 'brike', '2022-03-02_1646238597.jpg', 20, 0, '2022-03-02 21:59:57', 0, 100003, 0, 1, 1),
(2, 'Green Lays', '2023-10-14_1697304972.jpg', 30, 0, '2022-03-02 22:08:54', 84, 100003, 0, 3, 1),
(3, 'Butter Biscuits', '2022-07-25_1658765093.jpeg', 50, 0, '25-07-2022 09:28:32 ', 49, 100001, 0, 2, 1),
(4, 'lays', '', 10, 0, '2023-10-05 05:46:06 ', 2, 100001, 0, 3, 1),
(100001, 'Dairy Milk', '2023-10-14_1697304773.jpg', 20, 0, '2023-10-14 11:02:53 ', 36, 100003, 0, 2, 1),
(100002, 'diry', '2023-11-23_1700729724.png', 20, 0, '2023-11-23 02:25:24 ', 2, 100000, 0, 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `logs_id` int(11) NOT NULL,
  `logs_order` int(11) NOT NULL,
  `logs_active_users` int(11) NOT NULL,
  `logs_inactive_users` int(11) NOT NULL,
  `logs_active_admin` int(11) NOT NULL,
  `logs_inactive_admin` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `logs`
--

INSERT INTO `logs` (`logs_id`, `logs_order`, `logs_active_users`, `logs_inactive_users`, `logs_active_admin`, `logs_inactive_admin`) VALUES
(1, 0, -13, 0, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `message`
--

CREATE TABLE `message` (
  `message_id` int(20) NOT NULL,
  `message` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `message`
--

INSERT INTO `message` (`message_id`, `message`) VALUES
(1, ' '),
(2, ''),
(3, 'hey!!, join us www.pesuvend.com');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `orders_id` int(11) NOT NULL,
  `orders_qty` varchar(100) NOT NULL,
  `orders_cost` varchar(100) NOT NULL,
  `orders_items` varchar(100) NOT NULL,
  `orders_user_id` bigint(20) NOT NULL,
  `orders_date` datetime NOT NULL,
  `orders_delivered` tinyint(1) NOT NULL,
  `orders_chef_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Triggers `orders`
--
DELIMITER $$
CREATE TRIGGER `deleted_order` AFTER DELETE ON `orders` FOR EACH ROW UPDATE logs SET logs_order=logs.logs_order-1
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `deleted_order_insert_history` BEFORE DELETE ON `orders` FOR EACH ROW INSERT INTO history (`history_id`,`history_qty`,`history_cost`,`history_item`,`history_date`,`history_delivered`,`history_user_id`,`history_chef_id`) VALUES (OLD.orders_id,OLD.orders_qty,OLD.orders_cost,OLD.orders_items,OLD.orders_date,OLD.orders_delivered,OLD.orders_user_id, OLD.orders_chef_id)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_order` AFTER INSERT ON `orders` FOR EACH ROW UPDATE logs SET logs_order=logs.logs_order+1
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `sessionss`
--

CREATE TABLE `sessionss` (
  `sessionss_id` bigint(20) NOT NULL,
  `sessionss_user_id` bigint(20) NOT NULL,
  `sessionss_cookies_id` varchar(40) NOT NULL,
  `sessionss_created_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `sessionss`
--

INSERT INTO `sessionss` (`sessionss_id`, `sessionss_user_id`, `sessionss_cookies_id`, `sessionss_created_date`) VALUES
(1, 131, '03581d2d71171c051311660844107', '2022-08-18 11:05:07'),
(2, 100000, '6ed86dba70f5b8b51000001660750414', '2022-08-17 09:03:34'),
(3, 132, 'b555e7d40694f6b11321660749714', '2022-08-17 08:51:54'),
(4, 100001, 'c4f0c4addd985c6e1000011705990862', '2024-01-23 11:51:02'),
(5, 100003, 'bfcc53180a5842dd1000031700545291', '2023-11-21 11:11:31');

-- --------------------------------------------------------

--
-- Table structure for table `slogan`
--

CREATE TABLE `slogan` (
  `slogan_id` int(11) NOT NULL,
  `slogan_sentance` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `slogan`
--

INSERT INTO `slogan` (`slogan_id`, `slogan_sentance`) VALUES
(2, 'Your stomach is not a dustbin;fill it with some healthy stuff.'),
(3, 'Your stomach shouldn\'t be a waist basket.'),
(4, 'No development with an empty stomach'),
(5, 'Don\'t let your hungry stomach quake, come along and buy some snack!'),
(6, 'Your stomach needs me'),
(7, 'Listen to your stomach, it\'s calling for Magnesium'),
(8, 'It will fill your stomach as well as your heart.'),
(9, 'Don\'t make your stomach a dustbin, eat right and healthy.'),
(10, 'Don\'t use your stomach as a trash can!'),
(11, 'Junk belongs in the trash, not in your stomach! '),
(12, 'Makes your stomach feel good.'),
(13, 'Take your stomach on a joy ride with yummy.'),
(14, 'Give your stomach the taste of love.'),
(15, 'The urge to fill your hungry stomach.'),
(16, 'A Trendy snack means Hungry Stomach.'),
(17, 'We are for your hungry stomach'),
(18, 'You cant live a full life on an empty stomach.'),
(19, 'Good Stomach Good Digest'),
(20, 'We cant stomach this find a cure.'),
(21, 'A day is best started on a full stomach.'),
(22, 'A full stomach means a happy heart. Happy Day.'),
(23, 'Your Stomach Is Empty.');

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `transaction_id` bigint(20) NOT NULL,
  `transaction_user_id` bigint(20) NOT NULL,
  `transaction_send_to` varchar(100) NOT NULL,
  `transaction_amount` varchar(10) NOT NULL,
  `transaction_order` varchar(25) NOT NULL,
  `transaction_date` datetime NOT NULL,
  `transaction_added_by` bigint(20) NOT NULL,
  `transaction_type` int(11) NOT NULL,
  `transaction_status` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`transaction_id`, `transaction_user_id`, `transaction_send_to`, `transaction_amount`, `transaction_order`, `transaction_date`, `transaction_added_by`, `transaction_type`, `transaction_status`) VALUES
(201, 131, '', '500.00', 'NB', '2022-07-25 18:20:01', 131, 5, 'TXN_SUCCES'),
(202, 131, '', '100.00', 'NB', '2022-07-25 18:20:33', 131, 0, 'TXN_SUCCES'),
(203, 131, '', '900.00', 'NB', '2022-07-25 21:59:15', 131, 0, 'TXN_SUCCES'),
(204, 131, '', '200.00', 'NB', '2022-07-25 21:59:36', 131, 5, 'TXN_SUCCES'),
(205, 131, '', '300.00', 'NB', '2022-07-25 22:00:03', 131, 5, 'TXN_SUCCES'),
(206, 131, '', '500.00', 'NB', '2022-07-25 22:01:12', 131, 5, 'TXN_SUCCES'),
(207, 131, '12345675342', '-1000', 'pay friend', '2022-07-25 10:29:05', 131, 2, ''),
(208, 132, '9108667341', '1000', 'pay friend', '2022-07-25 10:29:05', 131, 2, ''),
(209, 132, '9108667341', '-1010', 'pay friend', '2022-07-25 10:37:11', 132, 2, ''),
(210, 131, '12345675342', '1010', 'pay friend', '2022-07-25 10:37:11', 132, 2, ''),
(211, 131, '', '200.00', 'NB', '2022-07-26 15:29:59', 131, 5, 'TXN_SUCCES'),
(212, 131, 'Recharged', '100.00', 'NB', '2022-07-26 15:36:19', 131, 0, 'TXN_SUCCES'),
(213, 131, 'Order', '130', 'Ordered', '0000-00-00 00:00:00', 131, 1, ''),
(214, 131, 'Order', '30', 'Ordered', '0000-00-00 00:00:00', 131, 1, ''),
(215, 131, 'Order', '30', 'Ordered', '2022-07-27 03:06:48', 131, 1, ''),
(216, 131, 'Order', '30', 'Ordered', '2022-07-27 15:07:59', 131, 1, ''),
(217, 131, 'Order', '30', 'Ordered', '2022-07-27 03:09:17', 131, 1, ''),
(218, 134, '0', '43', 'login', '0000-00-00 00:00:00', 1, 0, ''),
(219, 132, 'Added Manually', '100', 'add amount', '0000-00-00 00:00:00', 1, 0, ''),
(220, 132, 'Added Manually', '-10', 'add amount', '0000-00-00 00:00:00', 1, 0, ''),
(221, 132, 'Added Manually', '10', 'add amount', '0000-00-00 00:00:00', 1, 0, ''),
(222, 131, 'Added Manually', '-30', 'add amount', '0000-00-00 00:00:00', 1, 0, ''),
(223, 132, 'Added Manually', '-100', 'add amount', '0000-00-00 00:00:00', 1, 0, ''),
(224, 131, 'Order', '50', 'Ordered', '2022-07-27 04:49:59', 131, 1, ''),
(225, 132, 'Added Manually', '10', 'add amount', '0000-00-00 00:00:00', 1, 0, ''),
(226, 131, 'Recharged', '100.00', 'NB', '2022-07-27 23:18:09', 131, 0, 'TXN_SUCCES'),
(227, 131, '12345675342', '-1000', 'pay friend', '2022-07-27 11:18:46', 131, 2, ''),
(228, 132, '9108667341', '1000', 'pay friend', '2022-07-27 11:18:46', 131, 2, ''),
(229, 131, 'Recharged', '100.00', 'NB', '2022-07-28 21:02:31', 131, 0, 'TXN_SUCCES'),
(230, 131, 'Recharged', '100.00', 'NB', '2022-07-28 21:03:04', 131, 0, 'TXN_SUCCES'),
(231, 131, 'Recharged', '100.00', 'NB', '2022-07-28 21:03:21', 131, 0, 'TXN_SUCCES'),
(232, 131, 'Recharged', '100.00', 'NB', '2022-07-28 21:03:38', 131, 0, 'TXN_SUCCES'),
(233, 131, 'Recharged', '100', 'ORDS85163882', '2022-07-28 10:22:17', 131, 5, 'TXN_INIT'),
(234, 131, 'Recharged', '100', 'ORDS89951854', '2022-07-28 10:29:00', 131, 5, 'TXN_INIT'),
(235, 131, 'Recharged', '50', 'ORDS99899930', '2022-07-28 10:32:02', 131, 5, 'TXN_SUCCES'),
(236, 131, 'Recharged', '100', 'ORDS38341480', '2022-07-28 10:32:22', 131, 5, 'TXN_INIT'),
(237, 131, 'Recharged', '50', 'ORDS90064865', '2022-07-28 10:34:21', 131, 5, 'TXN_INIT'),
(238, 131, 'Recharged', '100', 'ORDS9474214', '2022-07-28 10:34:43', 131, 5, 'TXN_INIT'),
(239, 131, 'Recharged', '100', 'ORDS12783727', '2022-07-28 10:37:54', 131, 5, 'TXN_SUCCES'),
(240, 131, 'Recharged', '100', 'ORDS73871561', '2022-07-28 10:43:21', 131, 5, 'TXN_INIT'),
(241, 131, 'Recharged', '100', 'ORDS86072762', '2022-07-28 10:48:21', 131, 5, 'TXN_SUCCES'),
(242, 131, 'Recharged', '100', 'ORDS12440641', '2022-07-28 10:52:07', 131, 5, 'TXN_FAILUR'),
(243, 131, 'Recharged', '100', 'ORDS47401475', '2022-07-28 10:53:42', 131, 5, 'TXN_FAILUR'),
(244, 131, 'Recharged', '100', '131741541659029455', '2022-07-28 11:00:55', 131, 5, 'TXN_SUCCES'),
(245, 131, 'Recharged', '100', '131261531659029777', '2022-07-28 23:06:20', 131, 5, 'TXN_SUCCES'),
(246, 131, 'Recharged', '100', '131761051659029829', '2022-07-28 23:07:13', 131, 5, 'TXN_SUCCES'),
(247, 131, 'Recharged', '100', '131449171659030665', '2022-07-28 11:21:05', 131, 5, 'TXN_INIT'),
(248, 131, 'Recharged', '100', '131812131659030787', '0000-00-00 00:00:00', 131, 5, 'TXN_SUCCES'),
(249, 131, 'Recharged', '500', '131725381659030870', '2022-07-28 23:24:33', 131, 5, 'TXN_SUCCES'),
(100000, 131, 'Order', '50', '', '2022-07-30 07:49:51', 131, 1, ''),
(100001, 131, 'Order', '50', '', '2022-07-30 07:52:26', 131, 1, ''),
(100002, 131, 'Order', '100', '', '2022-07-30 09:37:17', 131, 1, ''),
(100003, 131, 'Order', '50', '', '2022-07-30 10:45:32', 131, 1, ''),
(100004, 131, 'Order', '50', '', '2022-07-30 11:54:06', 131, 1, ''),
(100005, 131, 'Order', '50', '', '2022-07-31 12:44:59', 131, 1, ''),
(100006, 131, 'Order', '220', '', '2022-07-31 12:48:38', 131, 1, ''),
(100007, 131, 'Order', '50', '', '2022-07-31 12:53:41', 131, 1, ''),
(100008, 131, 'Order', '-100', '', '2022-07-31 01:24:43', 131, 1, ''),
(100009, 131, 'Refunded', '100', '', '2022-07-31 01:27:13', 131, 1, ''),
(100010, 131, 'Refunded', '100', '', '2022-07-31 01:27:15', 131, 1, ''),
(100011, 131, 'Refunded', '100', '', '2022-07-31 01:27:53', 131, 1, ''),
(100012, 131, 'Order', '-50', '', '2022-07-31 01:29:33', 131, 1, ''),
(100013, 131, 'Refunded', '50', '', '2022-07-31 01:30:33', 131, 1, ''),
(100014, 131, 'Order', '-50', '', '2022-07-31 01:31:28', 131, 1, ''),
(100015, 131, 'Refunded', '50', '', '2022-07-31 01:32:03', 131, 1, ''),
(100016, 131, 'Order', '-50', '', '2022-07-31 01:32:30', 131, 1, ''),
(100017, 131, 'Refunded', '50', '', '2022-07-31 01:33:32', 131, 1, ''),
(100018, 131, 'Order', '-50', '', '2022-07-31 01:35:27', 131, 1, ''),
(100019, 131, 'Refunded', '50', '', '2022-07-31 01:36:27', 131, 1, ''),
(100020, 131, 'Order', '-50', '', '2022-07-31 01:40:15', 131, 1, ''),
(100021, 131, 'Refunded', '50', '', '2022-07-31 01:55:15', 131, 1, ''),
(100022, 131, 'Order', '-50', '', '2022-07-31 03:47:51', 131, 1, ''),
(100023, 131, 'Order', '-50', '', '2022-07-31 04:11:21', 131, 1, ''),
(100024, 131, 'Refunded', '50', '', '2022-07-31 04:12:19', 131, 1, ''),
(100025, 131, 'Order', '-50', '', '2022-07-31 04:14:41', 131, 1, ''),
(100026, 131, 'Refunded', '50', '', '2022-07-31 04:14:43', 131, 1, ''),
(100027, 131, 'Order', '-80', '', '2022-07-31 04:15:19', 131, 1, ''),
(100028, 131, 'Refunded', '80', '', '2022-07-31 04:21:16', 131, 1, ''),
(100029, 131, 'Order', '-30', '', '2022-07-31 04:21:32', 131, 1, ''),
(100030, 131, 'Refunded', '30', '', '2022-07-31 04:21:45', 131, 1, ''),
(100031, 131, 'Order', '-50', '', '2022-07-31 08:13:02', 131, 1, ''),
(100032, 131, 'Refunded', '50', '', '2022-07-31 08:13:15', 131, 1, ''),
(100033, 131, 'Order', '-120', '', '2022-07-31 08:16:04', 131, 1, ''),
(100034, 131, 'Refunded', '120', '', '2022-07-31 08:16:17', 131, 1, ''),
(100035, 131, 'Order', '-90', '', '2022-07-31 08:17:12', 131, 1, ''),
(100036, 131, 'Order', '-30', '', '2022-07-31 08:21:57', 131, 1, ''),
(100037, 131, 'Refunded', '30', '', '2022-07-31 08:23:23', 131, 1, ''),
(100038, 131, 'Order', '-30', '', '2022-07-31 08:23:32', 131, 1, ''),
(100039, 131, 'Ordered', '-50', 'I66f4pLV4d7fx2I', '2022-08-02 09:56:43', 131, 1, ''),
(100040, 131, 'Refunded', '50', '', '2022-08-02 09:59:18', 131, 3, ''),
(100041, 131, 'Ordered', '-50', '93KUAPnxYJhawFu', '2022-08-02 09:59:31', 131, 1, ''),
(100042, 131, 'Refunded', '50', '', '2022-08-02 10:52:43', 131, 3, ''),
(100043, 131, 'Ordered', '-50', 'WNSPJyBl3q8TQb2', '2022-08-02 10:52:48', 131, 1, ''),
(100044, 131, 'Refunded', '50', '', '2022-08-02 10:54:24', 131, 3, ''),
(100045, 131, 'Ordered', '-50', 'Tql3HOadwKgK9yU', '2022-08-03 01:51:51', 131, 1, ''),
(100046, 131, 'Refunded', '50', '', '2022-08-03 01:52:00', 131, 3, ''),
(100047, 131, 'Ordered', '-100', 'Up5ibHfBSRnMMjb', '2022-08-03 01:52:08', 131, 1, ''),
(100048, 131, 'Refunded', '100', '', '2022-08-03 05:36:43', 131, 3, ''),
(100049, 100000, 'Recharged', '100', '931291000001660749293', '2022-08-17 08:44:53', 100000, 4, 'TXN_INIT'),
(100050, 100000, 'Recharged', '100', '902451000001660749299', '2022-08-17 08:44:59', 100000, 4, 'TXN_INIT'),
(100051, 100000, 'Recharged', '100', '279091000001660749420', '2022-08-17 08:47:00', 100000, 4, 'TXN_INIT'),
(100052, 100000, 'Recharged', '100', '338461000001660749658', '2022-08-17 08:50:58', 100000, 4, 'TXN_INIT'),
(100053, 132, '9035376766', '-500', '', '2022-08-17 08:52:19', 132, 2, ''),
(100054, 100000, '9876543210', '500', '', '2022-08-17 08:52:19', 132, 2, ''),
(100055, 132, '9035376766', '-100', '', '2022-08-17 08:58:48', 132, 2, ''),
(100056, 100000, '9876543210', '100', '', '2022-08-17 08:58:48', 132, 2, ''),
(100057, 100001, 'Added Manually', '100000', '', '2023-10-05 01:03:39', 1, 4, ''),
(100058, 100001, 'Recharged', '100', '589341000011696506295', '2023-10-05 05:14:55', 100001, 4, 'TXN_INIT'),
(100059, 100002, 'Added Manually', '100000', '', '2023-10-05 05:29:42', 1, 4, ''),
(100060, 100001, 'Ordered', '-110', 'unaJjUPSjVvVLME', '2023-10-05 05:50:08', 100001, 1, ''),
(100061, 100001, 'Refunded', '110', '', '2023-10-05 06:21:05', 100001, 3, ''),
(100062, 100001, 'Ordered', '-30', '3hGawX5QjJgNtU7', '2023-10-05 06:21:10', 100001, 1, ''),
(100063, 100001, 'Refunded', '30', '', '2023-10-05 06:21:51', 100001, 3, ''),
(100064, 100001, 'Ordered', '-30', 'olAYNyWbR8gw9MX', '2023-10-05 06:22:57', 100001, 1, ''),
(100065, 100001, 'Refunded', '30', '', '2023-10-05 06:23:24', 100001, 3, ''),
(100066, 100001, 'Ordered', '-30', 'XXz3bcDM2kU3PX2', '2023-10-05 06:23:41', 100001, 1, ''),
(100067, 100001, 'Refunded', '30', '', '2023-10-05 06:26:17', 100001, 3, ''),
(100068, 100001, 'Ordered', '-30', 'yVn5ldPkElNi5aA', '2023-10-05 06:32:36', 100001, 1, ''),
(100069, 100001, 'Refunded', '30', '', '2023-10-05 06:33:29', 100001, 3, ''),
(100070, 100001, 'Ordered', '-30', '2FVekqZt4PHW0kt', '2023-10-05 06:33:52', 100001, 1, ''),
(100071, 100002, 'Ordered', '-30', '4HMQQ4uXG911CFl', '2023-10-05 07:02:16', 100002, 1, ''),
(100072, 100001, 'Ordered', '-30', 'MpCIrYV1XeGbWex', '2023-10-05 07:26:51', 100001, 1, ''),
(100073, 100001, 'Refunded', '30', '', '2023-10-05 07:45:42', 100001, 3, ''),
(100074, 100001, 'Ordered', '-30', '2GCD9zSqU4zktWi', '2023-10-05 07:46:55', 100001, 1, ''),
(100075, 100001, 'Ordered', '-30', '1tHcpmBgDpgaKSB', '2023-10-05 07:57:50', 100001, 1, ''),
(100076, 100001, 'Ordered', '-30', 'zt3uTRS03PSeBaG', '2023-10-05 08:00:15', 100001, 1, ''),
(100077, 100001, 'Ordered', '-110', 'OuzIv3hy2sGWunX', '2023-10-10 12:17:16', 100001, 1, ''),
(100078, 100001, 'Ordered', '-80', 'jPt1Ayddl1hLgE0', '2023-10-11 02:18:43', 100001, 1, ''),
(100079, 100001, 'Ordered', '-130', 'amtK8rDkRJqWn0p', '2023-10-11 02:58:44', 100001, 1, ''),
(100080, 100001, 'Recharged', '100', '498341000011697021811', '2023-10-11 04:26:51', 100001, 4, 'TXN_INIT'),
(100081, 100001, 'Ordered', '-30', '3s7pcVXkSPSJrye', '2023-10-11 06:11:42', 100001, 1, ''),
(100082, 100001, 'Ordered', '-30', 'nsSHKSG4pzxozEc', '2023-10-11 06:13:49', 100001, 1, ''),
(100083, 100001, 'Ordered', '-30', 'JhdnBHqyCKQBMuD', '2023-10-12 12:40:32', 100001, 1, ''),
(100084, 100001, 'Ordered', '-30', 'DoLbeXSy70BfFMA', '2023-10-12 12:41:09', 100001, 1, ''),
(100085, 100001, 'Ordered', '-50', '4UKq7qLmiK0YnJy', '2023-10-12 02:03:41', 100001, 1, ''),
(100086, 100001, 'Ordered', '-180', '9p9UqgJPs3mKlyI', '2023-10-12 02:10:12', 100001, 1, ''),
(100087, 100001, 'Ordered', '-80', 'cj0d7F0qaQsRVBJ', '2023-10-14 11:08:33', 100001, 1, ''),
(100088, 100001, 'Ordered', '-30', '1DJbwYfKLyn9BI2', '2023-10-30 12:14:14', 100001, 1, ''),
(100089, 100001, 'Ordered', '-20', '08VvCCoX6YSyWHQ', '2023-10-30 12:20:37', 100001, 1, ''),
(100090, 100001, 'Ordered', '-280', 'PYba8kRikhMI6Go', '2023-10-30 12:53:13', 100001, 1, ''),
(100091, 100001, 'Ordered', '-120', 'eHTYWrRq6pkrdWt', '2023-10-30 12:55:25', 100001, 1, ''),
(100092, 100001, 'Ordered', '-430', 'sLmEgqDAaLFwggC', '2023-10-30 12:56:25', 100001, 1, ''),
(100093, 100001, 'Ordered', '-50', 'XRIvBXMO6pZdzGd', '2023-10-31 11:24:31', 100001, 1, ''),
(100094, 100001, 'Ordered', '-50', 'rrOfTEsgoWywGKU', '2023-10-31 12:16:33', 100001, 1, ''),
(100095, 100001, 'Ordered', '-50', 'w9CKPb97XaHa8fS', '2023-10-31 12:29:02', 100001, 1, ''),
(100096, 100001, 'Ordered', '-50', 'cGHV2OFZzqmabcI', '2023-10-31 02:47:22', 100001, 1, ''),
(100097, 100001, 'Ordered', '-30', 'AFYbvkOfHSCX8C0', '2023-10-31 03:31:15', 100001, 1, ''),
(100098, 100001, 'Ordered', '-30', 'jXEb8kAKVtM3TcT', '2023-11-02 10:38:43', 100001, 1, ''),
(100099, 100001, 'Ordered', '-50', 'od2F7cDgeuZnVUM', '2023-11-02 11:30:21', 100001, 1, ''),
(100100, 100001, 'Ordered', '-30', 'V3YpTJjn6rTLgqL', '2023-11-02 11:31:30', 100001, 1, ''),
(100101, 100001, 'Ordered', '-30', 'Y5rH8vVRi0hejlK', '2023-11-02 11:32:33', 100001, 1, ''),
(100102, 100001, 'Ordered', '-30', 'tZPyc4RE1gYo6yj', '2023-11-02 11:34:23', 100001, 1, ''),
(100103, 100001, 'Ordered', '-50', 'H7f5EJRceJ4M8zn', '2023-11-02 11:36:30', 100001, 1, ''),
(100104, 100001, 'Ordered', '-20', 'v1Bwcih4OGpmduC', '2023-11-02 11:37:28', 100001, 1, ''),
(100105, 100001, 'Ordered', '-70', 'sM98e18euuE0QLp', '2023-11-03 08:25:28', 100001, 1, ''),
(100106, 100001, 'Refunded', '20', '', '2023-11-03 08:28:54', 100001, 3, ''),
(100107, 100001, 'Refunded', '30', '', '2023-11-03 08:28:58', 100001, 3, ''),
(100108, 100001, 'Ordered', '-30', 'qcLH78R2LjiuOee', '2023-11-09 03:19:49', 100001, 1, ''),
(100109, 100001, 'Ordered', '-130', '7p2zFn84lTywOYt', '2023-11-09 03:24:48', 100001, 1, ''),
(100110, 100001, 'Ordered', '-30', 'EyB7LirQ7xZE1uj', '2023-11-09 03:28:21', 100001, 1, ''),
(100111, 100001, 'Ordered', '-20', 'YoDgQPARpLKG8G6', '2023-11-09 03:30:38', 100001, 1, ''),
(100112, 100001, 'Ordered', '-30', 'CcIbWugbEWynEIg', '2023-11-09 03:32:57', 100001, 1, ''),
(100113, 100001, 'Ordered', '-50', 'lCCm8nOQbudWKm3', '2023-11-09 03:33:57', 100001, 1, ''),
(100114, 100001, 'Ordered', '-30', 'ioolHoX315mdHmr', '2023-11-09 03:39:30', 100001, 1, ''),
(100115, 131, 'Ordered', '-50', '', '2023-11-17 11:29:47', 131, 1, ''),
(100116, 131, 'Ordered', '-30', '', '2023-11-17 11:32:02', 131, 1, ''),
(100117, 131, 'Ordered', '-100', '', '2023-11-17 11:39:50', 131, 1, ''),
(100118, 131, 'Ordered', '-20', '', '2023-11-17 12:19:47', 131, 1, ''),
(100119, 131, 'Ordered', '-50', '', '2023-11-17 12:32:43', 131, 1, ''),
(100120, 131, 'Ordered', '-20', '', '2023-11-17 12:39:44', 131, 1, ''),
(100121, 131, 'Ordered', '-50', '', '2023-11-17 12:43:05', 131, 1, ''),
(100122, 131, 'Ordered', '-90', '', '2023-11-17 12:45:19', 131, 1, ''),
(100123, 131, 'Ordered', '-40', '', '2023-11-17 12:50:29', 131, 1, ''),
(100124, 131, 'Ordered', '-120', '', '2023-11-17 12:54:37', 131, 1, ''),
(100125, 131, 'Ordered', '-110', '', '2023-11-17 12:57:04', 131, 1, ''),
(100126, 131, 'Ordered', '-80', '', '2023-11-17 12:58:06', 131, 1, ''),
(100127, 131, 'Ordered', '-80', '', '2023-11-17 01:13:15', 131, 1, ''),
(100128, 131, 'Ordered', '-80', '', '2023-11-17 01:14:41', 131, 1, ''),
(100129, 131, 'Ordered', '-50', '', '2023-11-17 01:19:24', 131, 1, ''),
(100130, 131, 'Ordered', '-80', '', '2023-11-17 01:38:46', 131, 1, ''),
(100131, 131, 'Ordered', '-60', '', '2023-11-17 02:47:46', 131, 1, ''),
(100132, 131, 'Ordered', '-70', '', '2023-11-17 02:51:05', 131, 1, ''),
(100133, 131, 'Ordered', '-80', '', '2023-11-17 03:23:51', 131, 1, ''),
(100134, 131, 'Ordered', '-70', '', '2023-11-17 03:26:38', 131, 1, ''),
(100135, 131, 'Ordered', '-20', '', '2023-11-17 03:30:50', 131, 1, ''),
(100136, 131, 'Ordered', '-20', '', '2023-11-17 03:32:09', 131, 1, ''),
(100137, 131, 'Ordered', '-130', '', '2023-11-17 03:40:00', 131, 1, ''),
(100138, 131, 'Ordered', '-30', '', '2023-11-17 03:45:27', 131, 1, ''),
(100139, 131, 'Ordered', '-20', '', '2023-11-17 03:45:49', 131, 1, ''),
(100140, 131, 'Ordered', '-30', '', '2023-11-17 03:46:44', 131, 1, ''),
(100141, 131, 'Ordered', '-230', '', '2023-11-17 04:33:47', 131, 1, ''),
(100142, 131, 'Ordered', '-120', '', '2023-11-17 11:49:48', 131, 1, ''),
(100143, 131, 'Ordered', '-50', '', '2023-11-18 03:14:59', 131, 1, ''),
(100144, 131, 'Ordered', '-50', '', '2023-11-18 03:19:24', 131, 1, ''),
(100145, 131, 'Ordered', '-50', '', '2023-11-18 03:20:17', 131, 1, ''),
(100146, 131, 'Ordered', '-30', '', '2023-11-18 11:09:38', 131, 1, ''),
(100147, 131, 'Ordered', '-50', '', '2023-11-18 11:12:06', 131, 1, ''),
(100148, 100003, 'Ordered', '-30', '', '2023-11-21 11:13:38', 100003, 1, ''),
(100149, 100003, 'Ordered', '-50', '', '2023-11-21 11:14:43', 100003, 1, ''),
(100150, 100003, 'Ordered', '-20', '', '2023-11-21 11:25:58', 100003, 1, ''),
(100151, 100003, 'Ordered', '-50', '', '2023-11-21 11:39:53', 100003, 1, ''),
(100152, 100003, 'Ordered', '-50', '', '2023-11-21 02:43:27', 100003, 1, ''),
(100153, 100003, 'Ordered', '-30', '', '2023-11-21 02:45:25', 100003, 1, ''),
(100154, 100003, 'Ordered', '-50', '', '2023-11-21 02:50:25', 100003, 1, ''),
(100155, 100003, 'Ordered', '-60', '', '2023-11-21 03:12:58', 100003, 1, ''),
(100156, 100003, 'Ordered', '-10', '', '2023-11-21 03:15:27', 100003, 1, ''),
(100157, 100003, 'Ordered', '-30', '', '2023-11-21 03:17:24', 100003, 1, ''),
(100158, 100003, 'Ordered', '-30', '', '2023-11-21 03:21:23', 100003, 1, ''),
(100159, 100003, 'Ordered', '-90', '', '2023-11-21 03:21:53', 100003, 1, ''),
(100160, 100003, 'Ordered', '-60', '', '2023-11-22 09:26:30', 100003, 1, ''),
(100161, 100003, 'Ordered', '-30', '', '2023-11-22 09:36:33', 100003, 1, ''),
(100162, 100003, 'Ordered', '-60', '', '2023-11-22 09:47:05', 100003, 1, ''),
(100163, 100003, 'Ordered', '-30', '', '2023-11-22 09:56:21', 100003, 1, ''),
(100164, 100003, 'Ordered', '-30', '', '2023-11-22 10:46:52', 100003, 1, ''),
(100165, 100003, 'Ordered', '-30', '', '2023-11-22 11:18:40', 100003, 1, ''),
(100166, 100003, 'Ordered', '-30', '', '2023-11-23 12:15:17', 100003, 1, ''),
(100167, 100003, 'Ordered', '-30', '', '2023-11-23 12:23:10', 100003, 1, ''),
(100168, 100003, 'Ordered', '-30', '', '2023-11-23 12:26:53', 100003, 1, ''),
(100169, 100003, 'Ordered', '-30', '', '2023-11-23 12:28:15', 100003, 1, ''),
(100170, 100003, 'Ordered', '-30', '', '2023-11-23 12:28:50', 100003, 1, ''),
(100171, 100003, 'Ordered', '-30', '', '2023-11-23 12:32:16', 100003, 1, ''),
(100172, 100003, 'Ordered', '-30', '', '2023-11-23 12:41:14', 100003, 1, ''),
(100173, 100003, 'Ordered', '-30', '', '2023-11-23 12:44:59', 100003, 1, ''),
(100174, 100003, 'Ordered', '-30', '', '2023-11-23 12:03:29', 100003, 1, ''),
(100175, 100003, 'Ordered', '-30', '', '2023-11-23 12:07:46', 100003, 1, ''),
(100176, 100004, 'Added Manually', '20', '', '2023-11-23 01:58:41', 1, 4, ''),
(100177, 100003, 'Ordered', '-40', '', '2023-11-23 02:22:25', 100003, 1, ''),
(100178, 131, 'Ordered', '-20', '', '2023-11-24 01:48:38', 131, 1, ''),
(100179, 100003, 'Ordered', '-120', '', '2023-11-24 02:05:10', 100003, 1, ''),
(100180, 100003, 'order_N5S6MjxJHKFz5y', '100', '', '2023-11-27 03:29:38', 100003, 3, 'TXN_Succes'),
(100181, 100003, 'order_N5SQWV0P68eUax', '200', '', '2023-11-27 03:34:08', 100003, 3, 'TXN_Succes'),
(100182, 100003, 'order_N5SVt61UqjjW2m', '200', '', '2023-11-27 03:35:43', 100003, 3, 'TXN_Succes');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` bigint(20) NOT NULL,
  `user_password` varchar(300) NOT NULL,
  `name` varchar(20) NOT NULL,
  `user_phone` varchar(30) NOT NULL,
  `user_status` tinyint(1) NOT NULL,
  `user_delete` tinyint(1) NOT NULL,
  `user_added_date` varchar(20) NOT NULL,
  `user_updated_date` varchar(20) NOT NULL,
  `updated_by_id` bigint(20) NOT NULL,
  `user_token` varchar(255) NOT NULL,
  `user_semaphore` tinyint(1) NOT NULL DEFAULT 0,
  `user_attempts` int(11) NOT NULL,
  `user_login_time` varchar(15) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `user_password`, `name`, `user_phone`, `user_status`, `user_delete`, `user_added_date`, `user_updated_date`, `updated_by_id`, `user_token`, `user_semaphore`, `user_attempts`, `user_login_time`) VALUES
(131, '$2y$10$7YkAFIRC.TIzrEoB6M3gM.Gly95mF4xcUSis8RtL5b9Mep84WsCYq', 'Balaji1', '9108667341', 1, 0, '2022-08-17 01:23:34 ', '2024-01-23 01:18:53 ', 1, '0', 0, 0, '0'),
(132, '$2y$10$/ZmEF2fQz0JS5PihVlQC5OMsFNrajmEKZdW161jsqcA3OlZUfBBf2', 'srinivas', '9876543210', 1, 1, '2022-08-17 01:25:55 ', '2022-08-17 08:53:39 ', 1, '420f09387d2bd22b06d2d189928f04', 0, 0, '0'),
(134, '$2y$10$Xr/7cZHgoU/GePK5.WcNSeyO0mK7Shdvu0aBR6KHNDDQXtsLlx47O', 'Pradeep RS', '8660901237', 0, 1, '27-07-2022 04:00:51 ', '27-07-2022 04:00:51 ', 0, '', 0, 0, '0'),
(100000, '$2y$10$/ZmEF2fQz0JS5PihVlQC5OMsFNrajmEKZdW161jsqcA3OlZUfBBf2', 'balaji', '9035376766', 1, 1, '2022-08-17 08:41:59 ', '2022-08-17 08:41:59 ', 0, '0', 0, 0, '0'),
(100001, '$2y$10$ipf8fePZGxWhMIxQOpStI.jwqLdCSiyAbesr7ZEAXyLv4DNGcMfIS', 'pradeep', '7619321936', 1, 1, '2023-10-05 05:46:59 ', '2023-10-05 05:46:59 ', 0, '', 0, 0, '1696508287'),
(100002, '$2y$10$aUjtKb7yowPLNI9HwB.zRudL2W5vily32AQtT2wTZ3gqkmU4habFu', 'sandhya', '1234567899', 1, 1, '2024-01-22 01:21:16 ', '2024-01-22 01:21:16 ', 0, '', 0, 0, '0'),
(100003, '$2y$10$xpNmInpNjXibQxxlnw75teB5yODa1.I2wjYRMkwab6XaMZJo3VFPK', 'BALAJI', '9380840098', 1, 0, '2024-01-22 01:22:40 ', '2024-01-22 01:22:40 ', 0, 'b877e6ad6aec1254799c9b62379aa9', 0, 0, '0'),
(100004, '$2y$10$GOYnkAevCq3HTjbWbCZK8OUcHMqILEhScjMHboxzXM/7kMfU2qgk2', 'mr kane', '9458675856', 1, 1, '2023-11-23 01:58:41 ', '2023-11-23 01:58:41 ', 0, '', 0, 0, '0'),
(100005, '$2y$10$LVL7YHuATYRZFlzv87Ip3uV7DfbmUuyuH7/38IPN9AEvGCnzdWm0W', 'Balaji1', '8123112351', 1, 1, '2024-01-22 01:21:42 ', '2024-01-22 01:21:42 ', 0, '', 0, 0, '0'),
(100006, '$2y$10$PaJ1LxQs2rriUZqFrsxIh.1MQ79ltsQOrrBXdni.JYdFuIGYeYAPq', 'demo12', '8123112359', 1, 0, '2024-01-22 04:51:32 ', '2024-01-22 04:51:32 ', 0, '', 0, 0, '0');

--
-- Triggers `users`
--
DELIMITER $$
CREATE TRIGGER `active_users` BEFORE UPDATE ON `users` FOR EACH ROW UPDATE logs SET logs.logs_inactive_users=logs.logs_inactive_users+1 WHERE OLD.user_status=1 AND NEW.user_status=0
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `deleted_users` AFTER UPDATE ON `users` FOR EACH ROW UPDATE logs SET logs_active_users=logs.logs_active_users-1 WHERE NEW.user_delete = 1
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `inactive_users` BEFORE UPDATE ON `users` FOR EACH ROW UPDATE logs SET logs.logs_inactive_users=logs.logs_inactive_users-1 WHERE OLD.user_status=0 AND NEW.user_status=1
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `inactive_users_on_delete` BEFORE UPDATE ON `users` FOR EACH ROW UPDATE logs SET logs_inactive_users=logs.logs_inactive_users-1 WHERE NEW.user_status = 0 AND NEW.user_delete = 1
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_user` AFTER INSERT ON `users` FOR EACH ROW UPDATE logs SET logs_active_users=logs.logs_active_users+1
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address_details`
--
ALTER TABLE `address_details`
  ADD PRIMARY KEY (`address_details`);

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `cart_user_id` (`cart_user_id`);

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`contact_id`);

--
-- Indexes for table `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`history_id`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`items_id`);

--
-- Indexes for table `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`message_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`orders_id`),
  ADD KEY `order_user_id` (`orders_user_id`);

--
-- Indexes for table `sessionss`
--
ALTER TABLE `sessionss`
  ADD PRIMARY KEY (`sessionss_id`),
  ADD KEY `session_user_id` (`sessionss_user_id`);

--
-- Indexes for table `slogan`
--
ALTER TABLE `slogan`
  ADD PRIMARY KEY (`slogan_id`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`transaction_id`),
  ADD KEY `transaction_user_id` (`transaction_user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `address_details`
--
ALTER TABLE `address_details`
  MODIFY `address_details` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `admin_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100004;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `cart_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100235;

--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
  MODIFY `contact_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100002;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `items_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100003;

--
-- AUTO_INCREMENT for table `message`
--
ALTER TABLE `message`
  MODIFY `message_id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `orders_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `sessionss`
--
ALTER TABLE `sessionss`
  MODIFY `sessionss_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `slogan`
--
ALTER TABLE `slogan`
  MODIFY `slogan_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100000;

--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `transaction_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100183;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100007;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_user_id` FOREIGN KEY (`cart_user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `order_user_id` FOREIGN KEY (`orders_user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `sessionss`
--
ALTER TABLE `sessionss`
  ADD CONSTRAINT `session_user_id` FOREIGN KEY (`sessionss_user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `transaction_user_id` FOREIGN KEY (`transaction_user_id`) REFERENCES `users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
