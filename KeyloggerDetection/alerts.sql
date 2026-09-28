-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 28, 2026 at 03:01 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `keylogger_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `alerts`
--

CREATE TABLE `alerts` (
  `id` bigint(20) NOT NULL,
  `anomaly_score` double DEFAULT NULL,
  `device_id` varchar(255) NOT NULL,
  `event_type` varchar(255) NOT NULL,
  `process_name` varchar(255) NOT NULL,
  `raw_detail` varchar(1000) DEFAULT NULL,
  `severity` varchar(255) NOT NULL,
  `timestamp` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `alerts`
--

INSERT INTO `alerts` (`id`, `anomaly_score`, `device_id`, `event_type`, `process_name`, `raw_detail`, `severity`, `timestamp`) VALUES
(1, 0.1, 'device_48', 'Normal', 'notepad.exe', 'Action: Registry Modification | Path: C:\\Program Files\\normal_83.txt', 'LOW', '2026-09-27 14:04:07'),
(2, 0.1, 'device_3', 'Normal', 'notepad.exe', 'Action: DLL Injection | Path: C:\\Windows\\System32\\normal_43.txt', 'LOW', '2026-09-27 14:05:07'),
(3, 0.95, 'device_8', 'rare_extensions', 'notepad.exe', 'Action: Unexpected Process Creation | Path: C:\\Windows\\System32\\malicious_79.exe', 'HIGH', '2026-09-27 14:06:07'),
(4, 0.1, 'device_62', 'Normal', 'powershell.exe', 'Action: DLL Injection | Path: C:\\Windows\\System32\\normal_54.txt', 'LOW', '2026-09-27 14:07:07'),
(5, 0.1, 'device_60', 'Normal', 'explorer.exe', 'Action: API Hooking | Path: C:\\Program Files\\normal_96.txt', 'LOW', '2026-09-27 14:08:07'),
(6, 0.1, 'device_67', 'Normal', 'python.exe', 'Action: API Hooking | Path: C:\\Program Files\\normal_13.txt', 'LOW', '2026-09-27 14:09:07'),
(7, 0.95, 'device_51', 'rare_extensions', 'python.exe', 'Action: Suspicious File Write | Path: C:\\Users\\Public\\malicious_19.exe', 'HIGH', '2026-09-27 14:10:07'),
(8, 0.1, 'device_97', 'Normal', 'explorer.exe', 'Action: Registry Modification | Path: C:\\Windows\\System32\\normal_38.txt', 'LOW', '2026-09-27 14:11:07'),
(9, 0.1, 'device_23', 'Normal', 'powershell.exe', 'Action: Process   Creation | Path: C:\\Users\\Public\\normal_57.txt', 'LOW', '2026-09-27 14:12:07'),
(10, 0.1, 'device_88', 'Normal', 'explorer.exe', 'Action: API Hooking | Path: C:\\Users\\Public\\normal_12.txt', 'LOW', '2026-09-27 14:13:07'),
(11, 0.1, 'device_87', 'Normal', 'cmd.exe', 'Action: Registry Modification | Path: C:\\Windows\\System32\\normal_44.txt', 'LOW', '2026-09-27 14:14:07'),
(12, 0.1, 'device_65', 'Normal', 'chrome.exe', 'Action: DLL Injection | Path: C:\\Windows\\System32\\normal_13.txt', 'LOW', '2026-09-27 14:15:07'),
(13, 0.1, 'device_72', 'Normal', 'explorer.exe', 'Action: API Hooking | Path: C:\\Windows\\System32\\normal_23.txt', 'LOW', '2026-09-27 14:16:07'),
(14, 0.95, 'device_17', 'rare_extensions', 'python.exe', 'Action: Unauthorized Registry Modification | Path: C:\\Program Files\\malicious_50.exe', 'HIGH', '2026-09-27 14:17:07'),
(15, 0.95, 'device_89', 'rare_extensions', 'explorer.exe', 'Action: Unauthorized Registry Modification | Path: C:\\Windows\\System32\\malicious_96.exe', 'HIGH', '2026-09-27 14:18:07'),
(16, 0.1, 'device_58', 'Normal', 'python.exe', 'Action: HTTPS outbound Request | Path: C:\\Users\\Public\\normal_47.txt', 'LOW', '2026-09-27 14:19:07'),
(17, 0.1, 'device_80', 'Normal', 'cmd.exe', 'Action: DLL Injection | Path: C:\\Windows\\System32\\normal_72.txt', 'LOW', '2026-09-27 14:20:07'),
(18, 0.95, 'device_11', 'rare_extensions', 'explorer.exe', 'Action: Suspicious File Write | Path: C:\\Users\\Public\\malicious_32.exe', 'HIGH', '2026-09-27 14:21:07'),
(19, 0.1, 'device_61', 'Normal', 'python.exe', 'Action: Registry Modification | Path: C:\\Users\\Public\\normal_16.txt', 'LOW', '2026-09-27 14:22:07'),
(20, 0.1, 'device_58', 'Normal', 'notepad.exe', 'Action: DLL Injection | Path: C:\\Program Files\\normal_53.txt', 'LOW', '2026-09-27 14:23:07'),
(21, 0.1, 'device_15', 'Normal', 'python.exe', 'Action: Registry Modification | Path: C:\\Users\\Public\\normal_5.txt', 'LOW', '2026-09-27 14:24:07'),
(22, 0.1, 'device_4', 'Normal', 'explorer.exe', 'Action: File Write | Path: C:\\Users\\Public\\normal_41.txt', 'LOW', '2026-09-27 14:25:07'),
(23, 0.1, 'device_36', 'Normal', 'explorer.exe', 'Action: Process   Creation | Path: C:\\Program Files\\normal_25.txt', 'LOW', '2026-09-27 14:26:07'),
(24, 0.1, 'device_73', 'Normal', 'explorer.exe', 'Action: Process   Creation | Path: C:\\Windows\\System32\\normal_42.txt', 'LOW', '2026-09-27 14:27:07'),
(25, 0.1, 'device_6', 'Normal', 'powershell.exe', 'Action: API Hooking | Path: C:\\Program Files\\normal_61.txt', 'LOW', '2026-09-27 14:28:07'),
(26, 0.1, 'device_45', 'Normal', 'explorer.exe', 'Action: File Write | Path: C:\\Users\\Public\\normal_54.txt', 'LOW', '2026-09-27 14:29:07'),
(27, 0.1, 'device_56', 'Normal', 'powershell.exe', 'Action: DLL Injection | Path: C:\\Users\\Public\\normal_13.txt', 'LOW', '2026-09-27 14:30:07'),
(28, 0.1, 'device_78', 'Normal', 'python.exe', 'Action: DLL Injection | Path: C:\\Users\\Public\\normal_16.txt', 'LOW', '2026-09-27 14:31:07'),
(29, 0.1, 'device_7', 'Normal', 'python.exe', 'Action: Process   Creation | Path: C:\\Users\\Public\\normal_38.txt', 'LOW', '2026-09-27 14:32:07'),
(30, 0.1, 'device_21', 'Normal', 'powershell.exe', 'Action: Process   Creation | Path: C:\\Windows\\System32\\normal_94.txt', 'LOW', '2026-09-27 14:33:07'),
(31, 0.1, 'device_11', 'Normal', 'python.exe', 'Action: File Write | Path: C:\\Program Files\\normal_46.txt', 'LOW', '2026-09-27 14:34:07'),
(32, 0.1, 'device_54', 'Normal', 'chrome.exe', 'Action: HTTPS outbound Request | Path: C:\\Windows\\System32\\normal_55.txt', 'LOW', '2026-09-27 14:35:07'),
(33, 0.95, 'device_50', 'rare_extensions', 'cmd.exe', 'Action: Unauthorized Registry Modification | Path: C:\\Users\\Public\\malicious_51.exe', 'HIGH', '2026-09-27 14:36:07'),
(34, 0.95, 'device_41', 'rare_extensions', 'cmd.exe', 'Action: Unusual Network Activity | Path: C:\\Program Files\\malicious_43.exe', 'HIGH', '2026-09-27 14:37:07'),
(35, 0.95, 'device_5', 'rare_extensions', 'cmd.exe', 'Action: Unauthorized Registry Modification | Path: C:\\Users\\Public\\malicious_2.exe', 'HIGH', '2026-09-27 14:38:07'),
(36, 0.1, 'device_88', 'Normal', 'chrome.exe', 'Action: Process   Creation | Path: C:\\Windows\\System32\\normal_97.txt', 'LOW', '2026-09-27 14:39:07'),
(37, 0.1, 'device_100', 'Normal', 'cmd.exe', 'Action: Process   Creation | Path: C:\\Program Files\\normal_65.txt', 'LOW', '2026-09-27 14:40:07'),
(38, 0.1, 'device_90', 'Normal', 'python.exe', 'Action: Process   Creation | Path: C:\\Program Files\\normal_15.txt', 'LOW', '2026-09-27 14:41:07'),
(39, 0.95, 'device_4', 'rare_extensions', 'chrome.exe', 'Action: Unusual Network Activity | Path: C:\\Program Files\\malicious_91.exe', 'HIGH', '2026-09-27 14:42:07'),
(40, 0.1, 'device_22', 'Normal', 'notepad.exe', 'Action: File Write | Path: C:\\Windows\\System32\\normal_91.txt', 'LOW', '2026-09-27 14:43:07'),
(41, 0.1, 'device_27', 'Normal', 'powershell.exe', 'Action: API Hooking | Path: C:\\Windows\\System32\\normal_47.txt', 'LOW', '2026-09-27 14:44:07'),
(42, 0.1, 'device_93', 'Normal', 'cmd.exe', 'Action: DLL Injection | Path: C:\\Windows\\System32\\normal_49.txt', 'LOW', '2026-09-27 14:45:07'),
(43, 0.1, 'device_59', 'Normal', 'notepad.exe', 'Action: File Write | Path: C:\\Users\\Public\\normal_70.txt', 'LOW', '2026-09-27 14:46:07'),
(44, 0.1, 'device_23', 'Normal', 'python.exe', 'Action: HTTPS outbound Request | Path: C:\\Program Files\\normal_20.txt', 'LOW', '2026-09-27 14:47:07'),
(45, 0.1, 'device_32', 'Normal', 'powershell.exe', 'Action: File Write | Path: C:\\Program Files\\normal_70.txt', 'LOW', '2026-09-27 14:48:07'),
(46, 0.1, 'device_41', 'Normal', 'explorer.exe', 'Action: File Write | Path: C:\\Windows\\System32\\normal_22.txt', 'LOW', '2026-09-27 14:49:07'),
(47, 0.95, 'device_62', 'rare_extensions', 'powershell.exe', 'Action: Unexpected Process Creation | Path: C:\\Windows\\System32\\malicious_5.exe', 'HIGH', '2026-09-27 14:50:07'),
(48, 0.95, 'device_67', 'rare_extensions', 'chrome.exe', 'Action: Suspicious File Write | Path: C:\\Program Files\\malicious_56.exe', 'HIGH', '2026-09-27 14:51:07'),
(49, 0.1, 'device_31', 'Normal', 'chrome.exe', 'Action: Process   Creation | Path: C:\\Windows\\System32\\normal_40.txt', 'LOW', '2026-09-27 14:52:07'),
(50, 0.95, 'device_1', 'rare_extensions', 'chrome.exe', 'Action: Unusual Network Activity | Path: C:\\Users\\Public\\malicious_100.exe', 'HIGH', '2026-09-27 14:53:07'),
(51, 0.1, 'device_54', 'Normal', 'cmd.exe', 'Action: HTTPS outbound Request | Path: C:\\Program Files\\normal_96.txt', 'LOW', '2026-09-27 14:54:07'),
(52, 0.1, 'device_64', 'Normal', 'chrome.exe', 'Action: HTTPS outbound Request | Path: C:\\Program Files\\normal_95.txt', 'LOW', '2026-09-27 14:55:07'),
(53, 0.95, 'device_29', 'rare_extensions', 'chrome.exe', 'Action: Unexpected Process Creation | Path: C:\\Users\\Public\\malicious_96.exe', 'HIGH', '2026-09-27 14:56:07'),
(54, 0.95, 'device_61', 'rare_extensions', 'cmd.exe', 'Action: Unusual Network Activity | Path: C:\\Program Files\\malicious_24.exe', 'HIGH', '2026-09-27 14:57:07'),
(55, 0.95, 'device_86', 'rare_extensions', 'python.exe', 'Action: Suspicious File Write | Path: C:\\Windows\\System32\\malicious_71.exe', 'HIGH', '2026-09-27 14:58:07'),
(56, 0.1, 'device_73', 'Normal', 'explorer.exe', 'Action: File Write | Path: C:\\Users\\Public\\normal_75.txt', 'LOW', '2026-09-27 14:59:07'),
(57, 0.1, 'device_22', 'Normal', 'explorer.exe', 'Action: File Write | Path: C:\\Windows\\System32\\normal_60.txt', 'LOW', '2026-09-27 15:00:07'),
(58, 0.95, 'device_50', 'rare_extensions', 'python.exe', 'Action: Unexpected Process Creation | Path: C:\\Program Files\\malicious_51.exe', 'HIGH', '2026-09-27 15:01:07'),
(59, 0.1, 'device_70', 'Normal', 'chrome.exe', 'Action: Registry Modification | Path: C:\\Users\\Public\\normal_36.txt', 'LOW', '2026-09-27 15:02:07'),
(60, 0.1, 'device_60', 'Normal', 'explorer.exe', 'Action: HTTPS outbound Request | Path: C:\\Users\\Public\\normal_51.txt', 'LOW', '2026-09-27 15:03:07'),
(61, 0.1, 'device_97', 'Normal', 'notepad.exe', 'Action: HTTPS outbound Request | Path: C:\\Users\\Public\\normal_2.txt', 'LOW', '2026-09-27 15:04:07'),
(62, 0.1, 'device_60', 'Normal', 'explorer.exe', 'Action: File Write | Path: C:\\Users\\Public\\normal_29.txt', 'LOW', '2026-09-27 15:05:07'),
(63, 0.1, 'device_30', 'Normal', 'notepad.exe', 'Action: File Write | Path: C:\\Program Files\\normal_48.txt', 'LOW', '2026-09-27 15:06:07'),
(64, 0.95, 'device_80', 'rare_extensions', 'powershell.exe', 'Action: Unusual Network Activity | Path: C:\\Windows\\System32\\malicious_55.exe', 'HIGH', '2026-09-27 15:07:07'),
(65, 0.1, 'device_30', 'Normal', 'python.exe', 'Action: DLL Injection | Path: C:\\Windows\\System32\\normal_83.txt', 'LOW', '2026-09-27 15:08:07'),
(66, 0.1, 'device_51', 'Normal', 'notepad.exe', 'Action: File Write | Path: C:\\Program Files\\normal_82.txt', 'LOW', '2026-09-27 15:09:07'),
(67, 0.1, 'device_20', 'Normal', 'notepad.exe', 'Action: HTTPS outbound Request | Path: C:\\Users\\Public\\normal_70.txt', 'LOW', '2026-09-27 15:10:07'),
(68, 0.1, 'device_43', 'Normal', 'chrome.exe', 'Action: File Write | Path: C:\\Windows\\System32\\normal_58.txt', 'LOW', '2026-09-27 15:11:07'),
(69, 0.1, 'device_8', 'Normal', 'chrome.exe', 'Action: File Write | Path: C:\\Program Files\\normal_5.txt', 'LOW', '2026-09-27 15:12:07'),
(70, 0.1, 'device_11', 'Normal', 'explorer.exe', 'Action: File Write | Path: C:\\Program Files\\normal_96.txt', 'LOW', '2026-09-27 15:13:07'),
(71, 0.1, 'device_76', 'Normal', 'powershell.exe', 'Action: Registry Modification | Path: C:\\Windows\\System32\\normal_66.txt', 'LOW', '2026-09-27 15:14:07'),
(72, 0.1, 'device_45', 'Normal', 'powershell.exe', 'Action: DLL Injection | Path: C:\\Windows\\System32\\normal_68.txt', 'LOW', '2026-09-27 15:15:07'),
(73, 0.1, 'device_10', 'Normal', 'chrome.exe', 'Action: HTTPS outbound Request | Path: C:\\Program Files\\normal_14.txt', 'LOW', '2026-09-27 15:16:07'),
(74, 0.1, 'device_98', 'Normal', 'chrome.exe', 'Action: API Hooking | Path: C:\\Program Files\\normal_95.txt', 'LOW', '2026-09-27 15:17:07'),
(75, 0.95, 'device_63', 'rare_extensions', 'cmd.exe', 'Action: Unusual Network Activity | Path: C:\\Windows\\System32\\malicious_36.exe', 'HIGH', '2026-09-27 15:18:07'),
(76, 0.1, 'device_22', 'Normal', 'python.exe', 'Action: Registry Modification | Path: C:\\Program Files\\normal_29.txt', 'LOW', '2026-09-27 15:19:07'),
(77, 0.95, 'device_9', 'rare_extensions', 'explorer.exe', 'Action: Unauthorized Registry Modification | Path: C:\\Windows\\System32\\malicious_79.exe', 'HIGH', '2026-09-27 15:20:07'),
(78, 0.95, 'device_47', 'rare_extensions', 'python.exe', 'Action: Unauthorized Registry Modification | Path: C:\\Windows\\System32\\malicious_87.exe', 'HIGH', '2026-09-27 15:21:07'),
(79, 0.95, 'device_66', 'rare_extensions', 'python.exe', 'Action: Unusual Network Activity | Path: C:\\Users\\Public\\malicious_94.exe', 'HIGH', '2026-09-27 15:22:07'),
(80, 0.1, 'device_67', 'Normal', 'cmd.exe', 'Action: Registry Modification | Path: C:\\Windows\\System32\\normal_62.txt', 'LOW', '2026-09-27 15:23:07'),
(81, 0.95, 'device_89', 'rare_extensions', 'notepad.exe', 'Action: Unusual Network Activity | Path: C:\\Windows\\System32\\malicious_38.exe', 'HIGH', '2026-09-27 15:24:07'),
(82, 0.1, 'device_82', 'Normal', 'cmd.exe', 'Action: File Write | Path: C:\\Windows\\System32\\normal_69.txt', 'LOW', '2026-09-27 15:25:07'),
(83, 0.95, 'device_72', 'rare_extensions', 'explorer.exe', 'Action: Unexpected Process Creation | Path: C:\\Program Files\\malicious_30.exe', 'HIGH', '2026-09-27 15:26:07'),
(84, 0.1, 'device_96', 'Normal', 'powershell.exe', 'Action: Registry Modification | Path: C:\\Users\\Public\\normal_1.txt', 'LOW', '2026-09-27 15:27:07'),
(85, 0.1, 'device_35', 'Normal', 'python.exe', 'Action: Registry Modification | Path: C:\\Users\\Public\\normal_37.txt', 'LOW', '2026-09-27 15:28:07'),
(86, 0.1, 'device_32', 'Normal', 'cmd.exe', 'Action: HTTPS outbound Request | Path: C:\\Windows\\System32\\normal_51.txt', 'LOW', '2026-09-27 15:29:07'),
(87, 0.95, 'device_62', 'rare_extensions', 'cmd.exe', 'Action: Suspicious File Write | Path: C:\\Users\\Public\\malicious_75.exe', 'HIGH', '2026-09-27 15:30:07'),
(88, 0.95, 'device_71', 'rare_extensions', 'cmd.exe', 'Action: Unauthorized Registry Modification | Path: C:\\Users\\Public\\malicious_58.exe', 'HIGH', '2026-09-27 15:31:07'),
(89, 0.1, 'device_38', 'Normal', 'notepad.exe', 'Action: API Hooking | Path: C:\\Program Files\\normal_30.txt', 'LOW', '2026-09-27 15:32:07'),
(90, 0.1, 'device_93', 'Normal', 'powershell.exe', 'Action: Process   Creation | Path: C:\\Windows\\System32\\normal_94.txt', 'LOW', '2026-09-27 15:33:07'),
(91, 0.95, 'device_58', 'rare_extensions', 'explorer.exe', 'Action: Suspicious File Write | Path: C:\\Users\\Public\\malicious_64.exe', 'HIGH', '2026-09-27 15:34:07'),
(92, 0.1, 'device_21', 'Normal', 'cmd.exe', 'Action: DLL Injection | Path: C:\\Users\\Public\\normal_76.txt', 'LOW', '2026-09-27 15:35:07'),
(93, 0.95, 'device_90', 'rare_extensions', 'notepad.exe', 'Action: Unauthorized Registry Modification | Path: C:\\Program Files\\malicious_68.exe', 'HIGH', '2026-09-27 15:36:07'),
(94, 0.95, 'device_68', 'rare_extensions', 'explorer.exe', 'Action: Unexpected Process Creation | Path: C:\\Windows\\System32\\malicious_40.exe', 'HIGH', '2026-09-27 15:37:07'),
(95, 0.1, 'device_63', 'Normal', 'notepad.exe', 'Action: HTTPS outbound Request | Path: C:\\Program Files\\normal_81.txt', 'LOW', '2026-09-27 15:38:07'),
(96, 0.1, 'device_45', 'Normal', 'explorer.exe', 'Action: DLL Injection | Path: C:\\Windows\\System32\\normal_91.txt', 'LOW', '2026-09-27 15:39:07'),
(97, 0.95, 'device_11', 'rare_extensions', 'explorer.exe', 'Action: Unauthorized Registry Modification | Path: C:\\Windows\\System32\\malicious_45.exe', 'HIGH', '2026-09-27 15:40:07'),
(98, 0.1, 'device_11', 'Normal', 'cmd.exe', 'Action: Registry Modification | Path: C:\\Windows\\System32\\normal_51.txt', 'LOW', '2026-09-27 15:41:07'),
(99, 0.1, 'device_38', 'Normal', 'notepad.exe', 'Action: Registry Modification | Path: C:\\Windows\\System32\\normal_24.txt', 'LOW', '2026-09-27 15:42:07'),
(100, 0.1, 'device_73', 'Normal', 'powershell.exe', 'Action: Process   Creation | Path: C:\\Program Files\\normal_82.txt', 'LOW', '2026-09-27 15:43:07');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `alerts`
--
ALTER TABLE `alerts`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `alerts`
--
ALTER TABLE `alerts`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
