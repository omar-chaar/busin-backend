-- phpMyAdmin SQL Dump
-- version 5.1.4
-- https://www.phpmyadmin.net/
--
-- Host: mysql-busin.alwaysdata.net
-- Generation Time: May 27, 2022 at 10:40 PM
-- Server version: 10.6.7-MariaDB
-- PHP Version: 7.4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `busin_main`
--
CREATE DATABASE IF NOT EXISTS `busin_main` DEFAULT CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci;
USE `busin_main`;

-- --------------------------------------------------------

--
-- Table structure for table `Announcement`
--

CREATE TABLE `Announcement` (
  `announcement_id` int(11) NOT NULL,
  `announcement_title` varchar(45) NOT NULL,
  `announcement_body` varchar(600) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `Announcement`
--

INSERT INTO `Announcement` (`announcement_id`, `announcement_title`, `announcement_body`, `sender_id`, `time`) VALUES
(1, '', 'POUCA FE', 2, '2022-05-19 19:27:10'),
(2, 'test', 'test', 5, '2022-05-21 19:59:05'),
(3, 'I came here to announce that we just bought a', 'New purchase', 5, '2022-05-21 20:08:03'),
(4, 'I came here to announce that we just bought a', 'New purchase', 5, '2022-05-21 20:09:08'),
(5, 'I came here to announce that we just bought a', 'New purchase', 5, '2022-05-21 20:09:47'),
(6, 'I came here to announce that we just bought a', 'New purchase', 5, '2022-05-21 20:10:25'),
(7, 'I came here to announce that we just bought a', 'New purchase', 5, '2022-05-21 20:11:00'),
(8, 'I came here to announce that we just bought a', 'New purchase', 5, '2022-05-21 20:11:13'),
(9, 'I came here to announce that we just bought a', 'New purchase', 5, '2022-05-21 20:12:36'),
(10, 'I came here to announce that we just bought a', 'New purchase', 5, '2022-05-21 20:12:52'),
(11, 'I came here to announce that we just bought a', 'New purchase', 5, '2022-05-21 20:13:21'),
(12, 'I came here to announce that we just bought a', 'New purchase', 5, '2022-05-21 20:14:55'),
(13, 'I came here to announce that we just bought a', 'New purchase', 5, '2022-05-21 20:16:21'),
(14, 'I came here to announce that we just bought a', 'New purchase', 5, '2022-05-21 20:22:52'),
(15, 'I came here to announce that we just bought a', 'New purchase', 5, '2022-05-21 20:23:47'),
(16, 'This is a announcement announcing that i\'m ab', 'Random Announcement', 5, '2022-05-21 20:30:07'),
(17, 'Announcing that i\'m tired of making announcem', 'Tired of announcements', 5, '2022-05-21 20:32:36'),
(18, 'Announcing that i\'m tired of making announcem', 'Tired of announcements', 5, '2022-05-21 20:33:26'),
(19, 'Testing authorization in the API', 'Testing authorization', 5, '2022-05-21 21:25:39'),
(20, 'testing api response', 'Testing response', 5, '2022-05-21 21:35:40'),
(21, 'testing...', 'Testing API response again', 5, '2022-05-21 21:36:39'),
(22, 'Isso eh um teste\n', 'Teste', 5, '2022-05-22 13:03:01'),
(23, 'this should be on the top\n', 'Testing order', 5, '2022-05-22 14:34:54'),
(24, 'IS THIS THE CONTENT?', 'IF THIS ISNT IN THE TOP', 5, '2022-05-22 14:38:06'),
(25, 'Conteudo', 'Titulo', 5, '2022-05-22 16:17:37'),
(26, 'Título Teste', 'conteudo teste', 5, '2022-05-22 16:24:45'),
(27, 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', 'Titulo', 5, '2022-05-22 16:53:17'),
(29, 'Teste 1', 'Testeeeeeeeeeeeeee', 3, '2022-05-26 09:04:59'),
(30, 'Teste 2', 'testeeeeeeeeeeee', 3, '2022-05-26 09:05:07'),
(31, 'Teste 3', 'testeeeeeee', 3, '2022-05-26 09:05:13'),
(32, 'Teste 4', 'testeeeeeeeeeeee', 3, '2022-05-26 09:05:19'),
(33, 'Teste 5', 'testeeeeeeeee', 3, '2022-05-26 09:05:27'),
(34, 'Teste 6', 'testeeeeeeeeee', 3, '2022-05-26 09:05:34'),
(35, 'Teste 7', 'testeeeeeeeeeeeeee', 3, '2022-05-26 09:05:39'),
(36, 'Teste 8', 'testeeeeeeeeeeeeeeeeeeee', 3, '2022-05-26 09:05:46'),
(38, 'Teste 10', 'testeeeeeeeeeee', 3, '2022-05-26 09:05:59'),
(39, 'TESTE 11', 'asdaawdawd', 3, '2022-05-26 10:46:24'),
(40, 'TESTE 12', 'AAAAAAAAAAA', 3, '2022-05-26 15:05:48');

-- --------------------------------------------------------

--
-- Table structure for table `AnnouncementReceiver`
--

CREATE TABLE `AnnouncementReceiver` (
  `announcement_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `time_saw` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `has_seen` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `AnnouncementReceiver`
--

INSERT INTO `AnnouncementReceiver` (`announcement_id`, `receiver_id`, `time_saw`, `has_seen`) VALUES
(1, 2, '2022-05-19 19:36:27', 0),
(1, 3, '2022-05-19 19:36:27', 0),
(2, 2, '2022-05-21 20:22:07', 0),
(2, 3, '2022-05-21 20:22:07', 0),
(18, 5, '2022-05-21 20:33:26', 0),
(19, 5, '2022-05-21 21:25:40', 0),
(20, 5, '2022-05-21 21:35:41', 0),
(21, 5, '2022-05-21 21:36:39', 0),
(22, 5, '2022-05-22 13:03:02', 0),
(22, 6, '2022-05-22 13:03:02', 0),
(22, 7, '2022-05-22 13:03:02', 0),
(23, 5, '2022-05-22 14:34:54', 0),
(23, 6, '2022-05-22 14:34:54', 0),
(23, 7, '2022-05-22 14:34:54', 0),
(24, 5, '2022-05-22 14:38:07', 0),
(24, 6, '2022-05-22 14:38:07', 0),
(24, 7, '2022-05-22 14:38:07', 0),
(25, 5, '2022-05-22 16:17:37', 0),
(25, 6, '2022-05-22 16:17:37', 0),
(25, 7, '2022-05-22 16:17:37', 0),
(26, 5, '2022-05-22 16:24:46', 0),
(26, 6, '2022-05-22 16:24:46', 0),
(26, 7, '2022-05-22 16:24:46', 0),
(27, 5, '2022-05-22 16:53:18', 0),
(27, 6, '2022-05-22 16:53:18', 0),
(27, 7, '2022-05-22 16:53:18', 0),
(29, 2, '2022-05-26 09:04:59', 0),
(29, 3, '2022-05-26 09:04:59', 0),
(30, 2, '2022-05-26 09:05:07', 0),
(30, 3, '2022-05-26 09:05:07', 0),
(31, 2, '2022-05-26 09:05:13', 0),
(31, 3, '2022-05-26 09:05:13', 0),
(32, 2, '2022-05-26 09:05:19', 0),
(32, 3, '2022-05-26 09:05:19', 0),
(33, 2, '2022-05-26 09:05:27', 0),
(33, 3, '2022-05-26 09:05:27', 0),
(34, 2, '2022-05-26 09:05:34', 0),
(34, 3, '2022-05-26 09:05:34', 0),
(35, 2, '2022-05-26 09:05:40', 0),
(35, 3, '2022-05-26 09:05:40', 0),
(36, 2, '2022-05-26 09:05:46', 0),
(36, 3, '2022-05-26 09:05:46', 0),
(38, 2, '2022-05-26 09:05:59', 0),
(38, 3, '2022-05-26 09:05:59', 0),
(39, 2, '2022-05-26 10:46:24', 0),
(39, 3, '2022-05-26 10:46:24', 0),
(40, 2, '2022-05-26 15:05:49', 0),
(40, 3, '2022-05-26 15:05:49', 0);

-- --------------------------------------------------------

--
-- Table structure for table `Company`
--

CREATE TABLE `Company` (
  `company_id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `Company`
--

INSERT INTO `Company` (`company_id`, `name`) VALUES
(1, 'Facebook'),
(2, 'Meta'),
(3, 'Bluezão Corps'),
(4, 'Disney');

-- --------------------------------------------------------

--
-- Table structure for table `Department`
--

CREATE TABLE `Department` (
  `department_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `company_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `Department`
--

INSERT INTO `Department` (`department_id`, `name`, `company_id`) VALUES
(2, 'Accounting', 1),
(4, 'Sales', 1),
(5, 'Human Resources', 1),
(6, 'Quality Insurance', 1),
(7, 'Owner', 3),
(8, 'Owner', 4),
(9, 'IT Department', 4),
(10, 'Human Resources', 4),
(11, 'Testers', 1),
(12, 'Warehouse', 1),
(13, 'Testers', 4);

-- --------------------------------------------------------

--
-- Table structure for table `Group`
--

CREATE TABLE `Group` (
  `group_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `group_creation_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `GroupMessage`
--

CREATE TABLE `GroupMessage` (
  `group_message_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `message_body` varchar(300) NOT NULL,
  `parent_message_id` int(11) DEFAULT NULL,
  `was_seen` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `GroupParticipant`
--

CREATE TABLE `GroupParticipant` (
  `group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `Message`
--

CREATE TABLE `Message` (
  `message_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `message_body` varchar(200) NOT NULL,
  `parent_message_id` int(11) DEFAULT NULL,
  `was_seen` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `Message`
--

INSERT INTO `Message` (`message_id`, `sender_id`, `receiver_id`, `time`, `message_body`, `parent_message_id`, `was_seen`) VALUES
(299, 11, 5, '2022-05-27 18:07:46', 'Oi clussy', NULL, 1),
(300, 5, 11, '2022-05-27 18:09:40', 'Test', 299, 1),
(301, 11, 5, '2022-05-27 18:09:59', 'uai', 300, 1),
(302, 11, 5, '2022-05-27 18:12:50', 'test', 301, 1),
(303, 5, 11, '2022-05-27 18:12:55', 'aaa', 302, 1),
(304, 5, 11, '2022-05-27 18:12:59', 'aaa', 303, 1),
(305, 11, 5, '2022-05-27 18:13:02', 'testt', 304, 1),
(306, 5, 11, '2022-05-27 19:08:00', 'test', 305, 1),
(307, 5, 11, '2022-05-27 19:11:55', 'test', 306, 1),
(308, 5, 11, '2022-05-27 19:40:31', 'test', 307, 1),
(309, 5, 11, '2022-05-27 19:42:02', 'test', 308, 1),
(310, 11, 5, '2022-05-27 19:42:58', 'sua puta', 309, 1),
(311, 5, 11, '2022-05-27 19:43:08', 'se fuder', 309, 1),
(312, 5, 11, '2022-05-27 19:43:46', 'test', 311, 1),
(313, 5, 11, '2022-05-27 19:43:59', 'test', 312, 1),
(314, 11, 5, '2022-05-27 19:44:05', 'test', 313, 1),
(315, 5, 11, '2022-05-27 19:46:16', 'test', 314, 1),
(316, 11, 5, '2022-05-27 19:47:26', 'cansei', 315, 1),
(317, 11, 5, '2022-05-27 19:51:57', 'test', 316, 1),
(318, 11, 5, '2022-05-27 19:52:12', 'aa', 317, 1),
(319, 11, 5, '2022-05-27 19:52:14', 'aaa', 318, 1),
(320, 11, 5, '2022-05-27 19:52:16', 'aaaaa', 319, 1),
(321, 5, 11, '2022-05-27 19:52:21', 'agora vc funciona', 320, 1),
(322, 5, 11, '2022-05-27 19:52:24', 'desgracado', 321, 1),
(323, 5, 11, '2022-05-27 19:52:28', 'filho da puta', 322, 1),
(324, 5, 11, '2022-05-27 19:52:43', 'obrigado deuses da programacao por fazer meu codigo funcionar', 323, 1),
(325, 5, 11, '2022-05-27 19:52:55', 'que esse codigo funcione no dia da apresentacao', 324, 1),
(326, 5, 11, '2022-05-27 19:53:04', 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', 325, 1),
(327, 16, 5, '2022-05-27 19:55:17', 'Amiga o alexandre queria comer meu cu', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `Schedule`
--

CREATE TABLE `Schedule` (
  `schedule_id` int(11) NOT NULL,
  `work_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `User`
--

CREATE TABLE `User` (
  `user_id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `surname` varchar(30) NOT NULL,
  `position` varchar(30) NOT NULL,
  `email` varchar(320) DEFAULT NULL,
  `password` varchar(225) DEFAULT NULL,
  `profile_picture` longblob DEFAULT NULL,
  `department_id` int(11) NOT NULL,
  `is_adm` tinyint(4) NOT NULL,
  `is_owner` tinyint(4) NOT NULL DEFAULT 0,
  `reg_code` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `User`
--

INSERT INTO `User` (`user_id`, `name`, `surname`, `position`, `email`, `password`, `profile_picture`, `department_id`, `is_adm`, `is_owner`, `reg_code`) VALUES
(2, 'Gabriel', 'Teste', 'Tester', 'teste2@gmail.com', '$2b$10$viGu2lUWsmUuoDP4RlZW/etV8h.NMW6MYljp0T.kNyVqdD0hMum4a', NULL, 2, 1, 0, 'UfMxz'),
(3, 'Omar', 'Cha', 'Backend Developer', 'teste1@gmail.com', '$2b$10$v/NPHEexcwA/KB4STre.8umkMZ8PBKjl.NEjSMbQywZ7BS1joVewy', NULL, 2, 1, 0, '00000'),
(4, 'Bluezão', 'Flausino', 'CEO', 'bluezao@gmail.com', '$2b$10$GQ42coIcXSFzQXGgWgvsVuuo8YL5p..XYWYGtqwK97G9nw1z6EMIG', NULL, 7, 0, 0, NULL),
(5, 'Fairuz', 'Haddad', 'Singer', 'mickey@gmail.com', '$2b$10$iic.Ibc6nOmqhodZU9mObuJYLBKAPvDfDxcVGKy2N4BfMhC3KwXeG', NULL, 8, 1, 1, NULL),
(6, 'Not', 'Musk', 'Web Dev', 'noleksum@gmail.com', '$2b$10$0GvZw3LTqLmo5OOiQLLO..lTSnIjoT79jJPiB5IOYlcdMADtN93JC', NULL, 9, 0, 0, 'uYCRj'),
(7, 'Omar', 'Chá', 'Programmer', 'omar@gmail.com', '$2b$10$cqDCOMDdEN.QLIoehahXDumcUHYWYWVb.VU.1bb/9thtnEzAEUL.G', NULL, 9, 0, 0, 'xoUCG'),
(8, 'Arnorld', 'Reeves', 'Tester', NULL, NULL, NULL, 9, 0, 0, 'E8NSa'),
(9, 'Letizia', 'Vilariça', 'Recruiter', 'leticia@gmail.com', '$2b$10$gPxf0S2nzZjxE6xKXohhuO0rDsARY8RhM98Fj.FRlnl/1KtU4/SLe', NULL, 10, 0, 0, '2XAbV'),
(11, 'Alexandru', 'Póvoas', 'Manager', 'alexandre@gmail.com', '$2b$10$g811RHNlk4Jvg0IYnDEN9uG.xMC2rQOwV1LqNzb18pTbuKK7SfVjO', NULL, 10, 0, 0, 'MmOvb'),
(12, 'Richard', 'Gomes', 'Therapist', NULL, NULL, NULL, 5, 0, 0, 'iure1'),
(13, 'Jan', 'Xisto', 'Tester', 'jan@gmail.com', '$2b$10$Udtf0Q71PUk/XYVFj8sd.uL0ttNtAhhNZB32w9v1FqrxUygA9Hfry', NULL, 9, 0, 0, 'XQCES'),
(14, 'Lena', 'Brásio', 'Senior Developer', 'lena@gmail.com', '$2b$10$AfH2fu7aHVkBsd7JBfG/qunYmFOjnuVHsyBjzc8FRJ8EI3rDcd4NG', NULL, 9, 0, 0, '7ua2l'),
(16, 'Vanessa', 'Marcondes', 'Designer', 'vanessa@gmail.com', '$2b$10$fURDUyHDtu70414wht3Mee8Pp4UtL2ppnerXv6xTvop9P8Z5hSj7O', NULL, 9, 0, 0, 'tWVUo'),
(17, 'Shelby', 'Nash', 'Support', NULL, NULL, NULL, 10, 0, 0, '97KYR'),
(18, 'Terry', 'Yates', 'DevOps', NULL, NULL, NULL, 9, 0, 0, 'A9htZ');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Announcement`
--
ALTER TABLE `Announcement`
  ADD PRIMARY KEY (`announcement_id`),
  ADD UNIQUE KEY `announcement_id_UNIQUE` (`announcement_id`),
  ADD KEY `sender_id_idx` (`sender_id`);

--
-- Indexes for table `AnnouncementReceiver`
--
ALTER TABLE `AnnouncementReceiver`
  ADD PRIMARY KEY (`announcement_id`,`receiver_id`),
  ADD KEY `receiver_id_idx` (`receiver_id`);

--
-- Indexes for table `Company`
--
ALTER TABLE `Company`
  ADD PRIMARY KEY (`company_id`),
  ADD UNIQUE KEY `idCompany_UNIQUE` (`company_id`);

--
-- Indexes for table `Department`
--
ALTER TABLE `Department`
  ADD PRIMARY KEY (`department_id`),
  ADD UNIQUE KEY `department_id_UNIQUE` (`department_id`),
  ADD KEY `company_id_idx` (`company_id`);

--
-- Indexes for table `Group`
--
ALTER TABLE `Group`
  ADD PRIMARY KEY (`group_id`),
  ADD UNIQUE KEY `group_id_UNIQUE` (`group_id`);

--
-- Indexes for table `GroupMessage`
--
ALTER TABLE `GroupMessage`
  ADD PRIMARY KEY (`group_message_id`),
  ADD UNIQUE KEY `chat_message_id_UNIQUE` (`group_message_id`),
  ADD KEY `user_id_idx` (`sender_id`),
  ADD KEY `group_id_idx` (`group_id`);

--
-- Indexes for table `GroupParticipant`
--
ALTER TABLE `GroupParticipant`
  ADD PRIMARY KEY (`group_id`,`user_id`),
  ADD KEY `user_id_idx` (`user_id`);

--
-- Indexes for table `Message`
--
ALTER TABLE `Message`
  ADD PRIMARY KEY (`message_id`),
  ADD UNIQUE KEY `message_id_UNIQUE` (`message_id`),
  ADD KEY `fk_Message_User1_idx` (`sender_id`),
  ADD KEY `fk_Message_User2_idx` (`receiver_id`),
  ADD KEY `fk_Message_Message1_idx` (`parent_message_id`);

--
-- Indexes for table `Schedule`
--
ALTER TABLE `Schedule`
  ADD PRIMARY KEY (`schedule_id`),
  ADD UNIQUE KEY `schedule_id_UNIQUE` (`schedule_id`),
  ADD KEY `user_id_idx` (`user_id`);

--
-- Indexes for table `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_id_UNIQUE` (`user_id`),
  ADD UNIQUE KEY `reg_code_UNIQUE` (`reg_code`),
  ADD KEY `department_id_idx` (`department_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Announcement`
--
ALTER TABLE `Announcement`
  MODIFY `announcement_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `AnnouncementReceiver`
--
ALTER TABLE `AnnouncementReceiver`
  MODIFY `announcement_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `Company`
--
ALTER TABLE `Company`
  MODIFY `company_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `Department`
--
ALTER TABLE `Department`
  MODIFY `department_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `Group`
--
ALTER TABLE `Group`
  MODIFY `group_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `GroupMessage`
--
ALTER TABLE `GroupMessage`
  MODIFY `group_message_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Message`
--
ALTER TABLE `Message`
  MODIFY `message_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=328;

--
-- AUTO_INCREMENT for table `Schedule`
--
ALTER TABLE `Schedule`
  MODIFY `schedule_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `User`
--
ALTER TABLE `User`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Announcement`
--
ALTER TABLE `Announcement`
  ADD CONSTRAINT `fk_Announcement_sender_id` FOREIGN KEY (`sender_id`) REFERENCES `User` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `AnnouncementReceiver`
--
ALTER TABLE `AnnouncementReceiver`
  ADD CONSTRAINT `fk_AnnouncementReceiver_announcement_id` FOREIGN KEY (`announcement_id`) REFERENCES `Announcement` (`announcement_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_AnnouncementReceiver_id` FOREIGN KEY (`receiver_id`) REFERENCES `User` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Department`
--
ALTER TABLE `Department`
  ADD CONSTRAINT `fk_Department_company_id` FOREIGN KEY (`company_id`) REFERENCES `Company` (`company_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `GroupMessage`
--
ALTER TABLE `GroupMessage`
  ADD CONSTRAINT `fk_GroupMessage_group_id` FOREIGN KEY (`group_id`) REFERENCES `Group` (`group_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_GroupMessage_parent_message` FOREIGN KEY (`group_message_id`) REFERENCES `GroupMessage` (`group_message_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_GroupMessage_user_id` FOREIGN KEY (`sender_id`) REFERENCES `User` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `GroupParticipant`
--
ALTER TABLE `GroupParticipant`
  ADD CONSTRAINT `fk_GroupParticipant_group_id` FOREIGN KEY (`group_id`) REFERENCES `Group` (`group_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_GroupParticipant_user_id` FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Message`
--
ALTER TABLE `Message`
  ADD CONSTRAINT `fk_Message_Message1` FOREIGN KEY (`parent_message_id`) REFERENCES `Message` (`message_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Message_User_Receiver` FOREIGN KEY (`receiver_id`) REFERENCES `User` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Message_User_Sender` FOREIGN KEY (`sender_id`) REFERENCES `User` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Schedule`
--
ALTER TABLE `Schedule`
  ADD CONSTRAINT `fk_Schedule_user_id` FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `User`
--
ALTER TABLE `User`
  ADD CONSTRAINT `fk_User_department_id` FOREIGN KEY (`department_id`) REFERENCES `Department` (`department_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
