-- phpMyAdmin SQL Dump
-- version 5.1.4
-- https://www.phpmyadmin.net/
--
-- Host: mysql-busin.alwaysdata.net
-- Generation Time: May 29, 2022 at 08:23 PM
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
  `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `Announcement`
--

INSERT INTO `Announcement` (`announcement_id`, `announcement_title`, `announcement_body`, `sender_id`, `time`) VALUES
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
(44, 'New Clothing Policies.', 'Dear Employees,\n\nStarting Monday there is a new clothing policy were flip flops are strictly prohibited. ', 5, '2022-05-28 18:00:46'),
(49, 'Testing time', '.....', 5, '2022-05-29 15:27:50'),
(50, 'Testetestest', 'Test', 5, '2022-05-29 15:32:47'),
(51, 'Testando horario mais uma vez', '...........', 5, '2022-05-29 15:38:56');

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
(44, 5, '2022-05-28 18:00:46', 0),
(44, 6, '2022-05-28 18:00:46', 0),
(44, 7, '2022-05-28 18:00:46', 0),
(44, 8, '2022-05-28 18:00:46', 0),
(44, 9, '2022-05-28 18:00:46', 0),
(44, 11, '2022-05-28 18:00:46', 0),
(44, 13, '2022-05-28 18:00:46', 0),
(44, 14, '2022-05-28 18:00:46', 0),
(44, 16, '2022-05-28 18:00:46', 0),
(44, 17, '2022-05-28 18:00:46', 0),
(44, 18, '2022-05-28 18:00:46', 0),
(49, 5, '2022-05-29 17:27:51', 0),
(49, 6, '2022-05-29 17:27:51', 0),
(49, 7, '2022-05-29 17:27:51', 0),
(49, 8, '2022-05-29 17:27:51', 0),
(49, 9, '2022-05-29 17:27:51', 0),
(49, 11, '2022-05-29 17:27:51', 0),
(49, 13, '2022-05-29 17:27:51', 0),
(49, 14, '2022-05-29 17:27:51', 0),
(49, 16, '2022-05-29 17:27:51', 0),
(49, 17, '2022-05-29 17:27:51', 0),
(49, 18, '2022-05-29 17:27:51', 0),
(49, 20, '2022-05-29 17:27:51', 0),
(49, 21, '2022-05-29 17:27:51', 0),
(49, 22, '2022-05-29 17:27:51', 0),
(49, 23, '2022-05-29 17:27:51', 0),
(49, 24, '2022-05-29 17:27:51', 0),
(51, 5, '2022-05-29 17:38:57', 0),
(51, 6, '2022-05-29 17:38:57', 0),
(51, 7, '2022-05-29 17:38:57', 0),
(51, 8, '2022-05-29 17:38:57', 0),
(51, 9, '2022-05-29 17:38:57', 0),
(51, 11, '2022-05-29 17:38:57', 0),
(51, 13, '2022-05-29 17:38:57', 0),
(51, 14, '2022-05-29 17:38:57', 0),
(51, 16, '2022-05-29 17:38:57', 0),
(51, 17, '2022-05-29 17:38:57', 0),
(51, 18, '2022-05-29 17:38:57', 0),
(51, 20, '2022-05-29 17:38:57', 0),
(51, 21, '2022-05-29 17:38:57', 0),
(51, 22, '2022-05-29 17:38:57', 0),
(51, 23, '2022-05-29 17:38:57', 0),
(51, 24, '2022-05-29 17:38:57', 0);

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
-- Table structure for table `GroupMessage`
--

CREATE TABLE `GroupMessage` (
  `group_message_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `message_body` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `GroupMessage`
--

INSERT INTO `GroupMessage` (`group_message_id`, `sender_id`, `department_id`, `time`, `message_body`) VALUES
(1, 3, 2, '2022-05-27 23:30:08', 'teste'),
(2, 2, 2, '2022-05-27 23:46:02', 'blablabla'),
(3, 19, 2, '2022-05-28 00:13:32', 'no soy blanco mariana'),
(4, 3, 2, '2022-05-28 00:34:13', 'oi mariana'),
(5, 3, 5, '2022-05-28 00:36:13', 'iai'),
(6, 11, 10, '2022-05-28 06:36:16', 'Ola'),
(7, 11, 10, '2022-05-28 09:57:24', 'Tudo bom?'),
(8, 11, 10, '2022-05-28 10:12:55', 'Ola'),
(9, 9, 10, '2022-05-28 10:44:03', 'eae'),
(10, 9, 10, '2022-05-28 11:47:27', 'aa'),
(11, 9, 10, '2022-05-28 12:01:19', 'Teste'),
(12, 11, 10, '2022-05-28 12:01:24', 'Teste'),
(13, 11, 10, '2022-05-28 12:15:58', 'teste'),
(14, 9, 10, '2022-05-28 12:16:57', 'teste'),
(15, 11, 10, '2022-05-28 12:18:00', 'teste'),
(16, 11, 10, '2022-05-28 12:18:24', 'teste'),
(17, 11, 10, '2022-05-28 12:20:25', 'teste'),
(18, 9, 10, '2022-05-28 12:20:33', 'teste'),
(19, 9, 10, '2022-05-28 12:20:40', 'teste?'),
(20, 9, 10, '2022-05-28 12:21:20', 'teste'),
(21, 9, 10, '2022-05-28 12:26:07', 'teste'),
(22, 11, 10, '2022-05-28 12:27:23', 'teste'),
(23, 9, 10, '2022-05-28 12:27:32', 'eaee'),
(24, 9, 10, '2022-05-28 12:27:40', 'pq n foi'),
(25, 11, 10, '2022-05-28 12:45:18', 'teste'),
(26, 11, 10, '2022-05-28 12:45:20', 'eae'),
(27, 9, 10, '2022-05-28 12:45:26', 'eae trouxa ksksksks'),
(28, 9, 10, '2022-05-28 12:46:20', 'eae'),
(29, 9, 10, '2022-05-28 12:46:24', 'tudo bom?'),
(30, 11, 10, '2022-05-28 12:46:57', 'eae trouxa'),
(31, 11, 10, '2022-05-28 12:47:01', 'tudo bom?'),
(32, 9, 10, '2022-05-28 12:47:07', 'tudo bom'),
(33, 11, 9, '2022-05-28 15:55:26', 'Eae'),
(34, 11, 9, '2022-05-28 15:55:55', 'que'),
(35, 19, 2, '2022-05-28 16:25:27', 'quem?'),
(36, 19, 2, '2022-05-28 16:44:24', 'Vao se foderem'),
(37, 3, 2, '2022-05-28 16:44:28', 'funcionou'),
(38, 19, 11, '2022-05-28 17:07:36', 'as vezes as mensagens cortam no meio aaaa'),
(39, 19, 11, '2022-05-28 17:08:23', 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'),
(40, 3, 2, '2022-05-28 17:53:00', 'FUNCIONOU O CARALHO'),
(41, 3, 2, '2022-05-28 17:53:02', 'FILHOS DA PUTA'),
(42, 3, 2, '2022-05-28 20:23:19', 'aaaaaaaaaaaaaaa'),
(43, 3, 2, '2022-05-28 20:23:21', 'aaaaaaaaaaaaa'),
(44, 3, 2, '2022-05-28 20:23:31', 'carrega :('),
(45, 3, 2, '2022-05-28 20:29:56', 'teste 1'),
(46, 3, 2, '2022-05-28 20:29:57', 'teste 2'),
(47, 3, 2, '2022-05-28 20:29:59', 'teste 3'),
(48, 3, 2, '2022-05-28 20:30:00', 'teste 4'),
(49, 3, 2, '2022-05-28 20:30:01', 'teste 5'),
(50, 3, 2, '2022-05-28 20:30:11', 'teste 6'),
(51, 3, 2, '2022-05-28 20:30:13', 'teste 7'),
(52, 3, 2, '2022-05-28 20:30:14', 'teste 8'),
(53, 3, 2, '2022-05-28 20:30:17', 'teste 9'),
(54, 3, 2, '2022-05-28 20:30:20', 'teste 10'),
(55, 3, 2, '2022-05-28 22:56:51', 'teste 11'),
(56, 3, 2, '2022-05-28 22:57:33', 'QUE?'),
(57, 3, 2, '2022-05-28 22:58:18', 'que'),
(58, 2, 2, '2022-05-28 22:59:07', 'ta foda esses horario'),
(59, 3, 2, '2022-05-28 23:00:29', 'aa'),
(60, 3, 2, '2022-05-28 23:12:25', 'que'),
(61, 3, 2, '2022-05-28 23:15:00', 'teste'),
(62, 3, 2, '2022-05-29 00:01:36', 'que'),
(63, 3, 2, '2022-05-29 06:06:51', 'aaaaaaaaaaaaaaaaaaaaaaaaaaaa');

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
(327, 16, 5, '2022-05-27 19:55:17', 'Amiga o alexandre queria comer meu cu', NULL, 1),
(328, 11, 5, '2022-05-27 21:40:51', 'eae gay', 326, 1),
(329, 5, 11, '2022-05-27 21:41:05', 'eae', 328, 1),
(330, 11, 5, '2022-05-27 21:41:16', 'kkkkkk', 329, 1),
(331, 5, 11, '2022-05-27 21:41:29', 'mostra o cacetão ai', 330, 1),
(332, 11, 5, '2022-05-27 21:41:36', '8==========+D', 331, 1),
(333, 11, 5, '2022-05-28 02:20:43', 'eae \'-\'', 332, 1),
(334, 5, 16, '2022-05-28 02:32:43', 'kkkkkkk', 327, 1),
(335, 5, 16, '2022-05-28 02:34:04', 'viva bolsonaro', 334, 1),
(336, 5, 16, '2022-05-28 02:34:10', 'bolsonaro 2022', 335, 1),
(337, 5, 16, '2022-05-28 02:34:13', 'bolsonaro 2026', 336, 1),
(338, 5, 16, '2022-05-28 02:34:16', 'bolsonaro 2030', 337, 1),
(339, 5, 16, '2022-05-28 02:34:20', 'bolsonaro 2034', 338, 1),
(340, 5, 16, '2022-05-28 02:34:25', 'bolsonaro 2038', 339, 1),
(341, 5, 16, '2022-05-28 02:34:28', 'bolsonaro 2042', 340, 1),
(342, 5, 16, '2022-05-28 02:34:35', 'bolsonaro 2046', 341, 1),
(343, 5, 16, '2022-05-28 02:34:39', 'bolsonaro 2050', 342, 1),
(344, 5, 16, '2022-05-28 02:34:42', 'bolsonaro 2054', 343, 1),
(345, 5, 16, '2022-05-28 02:34:45', 'bolsonaro 2058', 344, 1),
(346, 5, 16, '2022-05-28 02:34:51', 'bolsonaro 2062', 345, 1),
(347, 5, 16, '2022-05-28 02:34:58', 'bolsonaro 2066', 346, 1),
(348, 5, 16, '2022-05-28 02:35:04', 'bolsonaro 2070', 347, 1),
(349, 5, 16, '2022-05-28 02:35:09', 'bolsonaro 2074', 348, 1),
(350, 5, 16, '2022-05-28 02:35:13', 'bolsonaro 2078', 349, 1),
(351, 5, 16, '2022-05-28 02:35:19', 'bolsonaro 2082', 350, 1),
(352, 5, 16, '2022-05-28 02:35:24', 'bolsonaro 2086', 351, 1),
(353, 5, 16, '2022-05-28 02:35:29', 'bolsonaro 2090', 352, 1),
(354, 5, 16, '2022-05-28 02:35:32', 'bolsonaro 2094', 353, 1),
(355, 5, 16, '2022-05-28 02:35:40', 'bolsonaro 2098', 354, 1),
(356, 5, 16, '2022-05-28 02:35:46', 'bolsonaro 2102', 355, 1),
(357, 5, 16, '2022-05-28 02:35:59', 'bolsonaro 2106', 356, 1),
(358, 16, 5, '2022-05-28 02:38:24', 'VSF MACHO ESCROTO GADO', 357, 1),
(359, 16, 5, '2022-05-28 02:38:27', 'LULA 2022', 358, 1),
(360, 16, 5, '2022-05-28 02:38:30', 'LULA 2026', 359, 1),
(361, 16, 5, '2022-05-28 02:38:34', 'LULA 2030', 360, 1),
(362, 16, 5, '2022-05-28 02:38:38', 'LULA 2034', 361, 1),
(363, 16, 5, '2022-05-28 02:38:43', 'LULA 2038', 362, 1),
(364, 16, 5, '2022-05-28 02:38:45', 'LULA 2042', 363, 1),
(365, 16, 5, '2022-05-28 02:38:53', 'LULA 2046', 364, 1),
(366, 16, 5, '2022-05-28 02:39:04', 'LULA 2050', 365, 1),
(367, 16, 5, '2022-05-28 02:39:10', 'LULA 2054', 366, 1),
(368, 16, 5, '2022-05-28 02:39:13', 'LULA 2058', 367, 1),
(369, 16, 5, '2022-05-28 02:39:17', 'LULA 2062', 368, 1),
(370, 16, 5, '2022-05-28 02:39:23', 'LULA 2066', 369, 1),
(371, 16, 5, '2022-05-28 02:39:27', 'LULA 2070', 370, 1),
(372, 16, 5, '2022-05-28 02:39:38', 'LULA 2074', 371, 1),
(373, 16, 5, '2022-05-28 02:39:43', 'CYBERPUNK 2077', 372, 1),
(374, 16, 5, '2022-05-28 02:39:46', 'LULA 2078', 373, 1),
(375, 16, 5, '2022-05-28 02:39:53', 'LULA 2082', 374, 1),
(376, 16, 5, '2022-05-28 02:40:01', 'LULA 2086', 375, 1),
(377, 16, 5, '2022-05-28 02:40:10', 'LULA 2090', 376, 1),
(378, 16, 5, '2022-05-28 02:47:18', 'ADM CUCK, O N VISTO N TA FUNCIONANDO POR ALGUM MOTIVO MAS COMO VAI TER UM CONTADOR NEM VOU MEXER NISSO DPS ARRUMA ISSO AI OK EU TIREI O ORDER BY DATE PQ DEI UM REVERSE LA NO BACK OK APARENTEMENTE TA T', 377, 1),
(379, 11, 5, '2022-05-28 10:02:39', 'Testando quebrando palavra no meio da mensagem', 333, 1),
(380, 9, 5, '2022-05-28 10:59:32', 'ola', NULL, 1),
(381, 9, 5, '2022-05-28 11:01:10', 'ta', 380, 1),
(382, 9, 5, '2022-05-28 11:01:17', 'ta bom entao', 381, 1),
(383, 9, 5, '2022-05-28 11:01:45', 'ta', 382, 1),
(384, 9, 11, '2022-05-28 11:02:21', 'oi', NULL, 1),
(385, 11, 9, '2022-05-28 11:03:44', 'Oi gata', 384, 1),
(386, 9, 11, '2022-05-28 11:03:48', 'tudo bom?', 385, 1),
(387, 9, 11, '2022-05-28 11:03:49', 'sim', 386, 1),
(388, 9, 11, '2022-05-28 11:03:50', 'e vc?', 387, 1),
(389, 11, 9, '2022-05-28 11:03:54', 'ta tudo bom entao', 388, 1),
(390, 11, 9, '2022-05-28 11:03:59', 'CARALHO', 389, 1),
(391, 11, 9, '2022-05-28 11:04:01', 'FINALMENTE', 390, 1),
(392, 11, 9, '2022-05-28 11:04:03', 'FUNCIONOU', 391, 1),
(393, 11, 9, '2022-05-28 11:04:07', 'ESSA BOSTA', 392, 1),
(394, 11, 9, '2022-05-28 11:04:09', 'FILHO DA MAE', 393, 1),
(395, 9, 11, '2022-05-28 11:04:26', 'e vc?', 394, 1),
(396, 9, 11, '2022-05-28 11:04:38', 'hmmmmmm', 394, 1),
(397, 11, 9, '2022-05-28 11:08:01', 'teste', 396, 1),
(398, 11, 9, '2022-05-28 11:08:10', 'aaaaaa', 397, 1),
(399, 9, 11, '2022-05-28 11:08:13', 'aaaaaaaaa', 398, 1),
(400, 11, 9, '2022-05-28 11:08:36', 'aaaaaaaaaaaa', 399, 1),
(401, 9, 11, '2022-05-28 11:08:38', 'aaaaaaaaaaaaaaa', 400, 1),
(402, 9, 11, '2022-05-28 11:08:44', 'teste 1', 401, 1),
(403, 11, 9, '2022-05-28 11:08:46', 'teste 2', 402, 1),
(404, 9, 11, '2022-05-28 11:08:48', 'teste 3', 403, 1),
(405, 11, 9, '2022-05-28 11:47:07', 'teste 4', 404, 1),
(406, 11, 9, '2022-05-28 14:10:58', 'teste 5', 405, 1),
(407, 11, 5, '2022-05-28 14:11:06', 'teste 6', 379, 1),
(408, 11, 13, '2022-05-28 15:58:19', 'Oi', NULL, 0),
(409, 19, 2, '2022-05-28 17:08:11', 'as vezes as palavras cortam no meio', NULL, 1),
(410, 3, 2, '2022-05-28 17:09:54', 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', NULL, 1),
(411, 3, 2, '2022-05-28 17:10:02', 'as vezes as mensagens quebram no meio', 410, 1),
(412, 3, 19, '2022-05-28 17:17:35', 'Hola guapa', NULL, 1),
(413, 3, 19, '2022-05-28 17:17:41', 'Yo soy blanco', 412, 1),
(414, 5, 6, '2022-05-28 17:55:07', 'aaaa', NULL, 0),
(415, 5, 7, '2022-05-28 17:55:11', 'teste 2', NULL, 1),
(416, 5, 13, '2022-05-28 17:55:16', 'teste 3', NULL, 1),
(417, 5, 14, '2022-05-28 17:55:22', 'teste 4', NULL, 1),
(418, 5, 16, '2022-05-28 17:55:30', 'teste 5', 378, 1),
(419, 5, 9, '2022-05-28 17:55:36', 'teste 6', 383, 1),
(420, 5, 11, '2022-05-28 17:55:41', 'teste', 407, 1),
(421, 5, 22, '2022-05-28 20:17:21', 'eae gostose', NULL, 0),
(422, 5, 21, '2022-05-28 20:17:41', 'kkkkkk gei', NULL, 1),
(423, 5, 23, '2022-05-28 20:23:45', 'teste teste', NULL, 1),
(424, 24, 5, '2022-05-28 20:24:25', 'td culpa do stf ta ok', NULL, 1),
(425, 5, 24, '2022-05-28 20:31:58', 'Vc use pronome neutre sua pute?', 424, 1),
(426, 5, 24, '2022-05-28 20:32:07', 'para esclarecer e escurecer, me mam', 425, 1),
(427, 5, 24, '2022-05-28 21:10:44', 'me mame bolsonere', 426, 1),
(428, 5, 24, '2022-05-28 21:11:22', 'pute', 427, 1),
(429, 5, 24, '2022-05-28 21:11:23', 'pute 2', 428, 1),
(430, 5, 24, '2022-05-28 21:11:41', 'vadie', 429, 1),
(431, 5, 24, '2022-05-28 21:14:00', 'ne', 430, 1),
(432, 24, 5, '2022-05-28 21:14:32', 'vc e comunista ta ok', 431, 1),
(433, 24, 5, '2022-05-28 21:32:28', 'adasdad', 432, 1),
(434, 24, 5, '2022-05-28 22:14:55', 'fdsfsfsdf', 433, 1),
(435, 3, 19, '2022-05-28 22:21:34', 'que', 413, 1),
(436, 2, 3, '2022-05-29 00:00:35', 'fsdfsdf', 411, 1),
(437, 3, 19, '2022-05-29 00:01:09', 'foi', 435, 1),
(438, 3, 19, '2022-05-29 00:04:46', 'eu n to doido', 437, 1),
(439, 2, 3, '2022-05-29 00:55:19', 'hjfhfghfghfhfhfhfhf', 436, 1),
(440, 5, 11, '2022-05-29 01:10:41', 'ae', 420, 1),
(441, 5, 24, '2022-05-29 01:11:15', 'kk', 434, 1),
(442, 5, 11, '2022-05-29 01:11:22', 'xxxxxx', 440, 1),
(443, 5, 11, '2022-05-29 04:33:19', 'c', 442, 0),
(444, 3, 2, '2022-05-29 06:06:37', 'aaaaaaaaaaa', 439, 1),
(445, 19, 3, '2022-05-29 17:27:11', 'mariana', 438, 1),
(446, 3, 19, '2022-05-29 17:27:51', 'teste?', 445, 1),
(447, 19, 3, '2022-05-29 17:35:25', 'cansei mariana', 446, 1),
(448, 3, 19, '2022-05-29 17:35:30', 'foda-se meu irmao', 447, 1),
(449, 19, 3, '2022-05-29 17:43:28', 'seu pai', 448, 1),
(450, 19, 3, '2022-05-29 17:43:30', 'quele corno', 449, 1),
(451, 19, 3, '2022-05-29 17:43:32', '1', 450, 1),
(452, 19, 3, '2022-05-29 17:43:33', '2', 451, 1),
(453, 19, 3, '2022-05-29 17:43:34', '3', 452, 1),
(454, 19, 3, '2022-05-29 17:43:35', '4', 453, 1),
(455, 19, 3, '2022-05-29 17:43:36', '5', 454, 1),
(456, 19, 3, '2022-05-29 17:43:37', '6', 455, 1),
(457, 19, 3, '2022-05-29 17:44:48', '7', 456, 1);

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
(5, 'The', 'Owner', 'Singer', 'mickey@gmail.com', '$2b$10$iic.Ibc6nOmqhodZU9mObuJYLBKAPvDfDxcVGKy2N4BfMhC3KwXeG', NULL, 8, 1, 1, NULL),
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
(18, 'Terry', 'Yates', 'DevOps', NULL, NULL, NULL, 9, 0, 0, 'A9htZ'),
(19, 'Mariana', 'Nosoy Blanco', 'Tester', 'mariana@gmail.com', '$2b$10$rLo/QOf0tLVqyMZWj37RUOs31qFyftaB1hCZDNT3jdHlgiXtAw6By', NULL, 11, 0, 0, 'WVuuC'),
(20, 'Jacinto', 'Pinto', 'Recruiter', NULL, NULL, NULL, 10, 0, 0, 'FhHWZ'),
(21, 'Jacinto', 'Pinto 2', 'Tester', 'jacinto@gmail.com', '$2b$10$/7z/PYexQ708Mi7MOKfR0uk9KDm86hlVCek3P0BwBSnhJ.eWXD/BS', NULL, 13, 0, 0, '1KIaw'),
(22, 'Omara', 'Chaara', 'Desenvolvedore', 'omara@gmail.com', '$2b$10$y1O6erPhgadSBSXPR5I4aeynQ3fq0hA99ZLUwRoZBww4fZ.sj9gi.', NULL, 9, 0, 0, 'vPgGG'),
(23, 'Pedre', 'Silve', 'Recrutadore', 'pedre@gmail.com', '$2b$10$diw.V5N63GTJTLTpGQ2fjedNC4.inKxONFZU92L8rTfivy8QU69kG', NULL, 10, 0, 0, '5xcSy'),
(24, 'Jair', 'Bolsonaro', 'Capitão', 'bolsonaro@gmail.com', '$2b$10$br7kbw5Ynp4.aDzMHxDTTewA5X7xI2n1jfAAIdGxlpa8UG7i7IcLK', NULL, 13, 0, 0, 'gIAqK');

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
-- Indexes for table `GroupMessage`
--
ALTER TABLE `GroupMessage`
  ADD PRIMARY KEY (`group_message_id`),
  ADD UNIQUE KEY `chat_message_id_UNIQUE` (`group_message_id`),
  ADD KEY `user_id_idx` (`sender_id`),
  ADD KEY `fk_GroupMessage_department_id_idx` (`department_id`);

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
  MODIFY `announcement_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `AnnouncementReceiver`
--
ALTER TABLE `AnnouncementReceiver`
  MODIFY `announcement_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

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
-- AUTO_INCREMENT for table `GroupMessage`
--
ALTER TABLE `GroupMessage`
  MODIFY `group_message_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `Message`
--
ALTER TABLE `Message`
  MODIFY `message_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=458;

--
-- AUTO_INCREMENT for table `User`
--
ALTER TABLE `User`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

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
  ADD CONSTRAINT `fk_GroupMessage_department_id` FOREIGN KEY (`department_id`) REFERENCES `Department` (`department_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_GroupMessage_parent_message` FOREIGN KEY (`group_message_id`) REFERENCES `GroupMessage` (`group_message_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_GroupMessage_user_id` FOREIGN KEY (`sender_id`) REFERENCES `User` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Message`
--
ALTER TABLE `Message`
  ADD CONSTRAINT `fk_Message_Message1` FOREIGN KEY (`parent_message_id`) REFERENCES `Message` (`message_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Message_User_Receiver` FOREIGN KEY (`receiver_id`) REFERENCES `User` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Message_User_Sender` FOREIGN KEY (`sender_id`) REFERENCES `User` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `User`
--
ALTER TABLE `User`
  ADD CONSTRAINT `fk_User_department_id` FOREIGN KEY (`department_id`) REFERENCES `Department` (`department_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
