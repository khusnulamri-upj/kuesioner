-- phpMyAdmin SQL Dump
-- version 4.0.9
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Mar 21, 2014 at 10:27 AM
-- Server version: 5.6.14
-- PHP Version: 5.5.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `kuesioner`
--

DELIMITER $$
--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `INITCAP`(`x` VARCHAR(255)) RETURNS varchar(255) CHARSET latin1
    DETERMINISTIC
begin
set @out_str='';
set @l_str='';
set @r_str='';

set @pos=LOCATE(' ',x);
SELECT x into @r_str;
while (@pos > 0) DO
SELECT SUBSTRING(@r_str,1,@pos-1) into @l_str;
SELECT SUBSTRING(@r_str,@pos+1) into @r_str;
SELECT concat(@out_str,upper(substring(@l_str,1,1)),lower(substring(@l_str,2)),' ') into @out_str;
set @pos=LOCATE(' ',@r_str);
END WHILE;
SELECT concat(@out_str,upper(substring(@r_str,1,1)),lower(substring(@r_str,2))) into @out_str;
return trim(@out_str);
end$$

CREATE DEFINER=`root`@`localhost` FUNCTION `SPLIT_STRING`(`str` VARCHAR(255), `delim` VARCHAR(12), `pos` INT) RETURNS varchar(255) CHARSET latin1
RETURN REPLACE(SUBSTRING(SUBSTRING_INDEX(str, delim, pos),
       LENGTH(SUBSTRING_INDEX(str, delim, pos-1)) + 1),
       delim, '')$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ci_sessions`
--

CREATE TABLE IF NOT EXISTS `ci_sessions` (
  `session_id` varchar(40) NOT NULL DEFAULT '0',
  `ip_address` varchar(16) NOT NULL DEFAULT '0',
  `user_agent` varchar(120) DEFAULT NULL,
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `user_data` text NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `last_activity` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ci_sessions`
--

INSERT INTO `ci_sessions` (`session_id`, `ip_address`, `user_agent`, `last_activity`, `user_data`) VALUES
('20ebc26bbc8e5173e8d63eb58fd8b03a', '::1', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:28.0) Gecko/20100101 Firefox/28.0', 1395393469, '');

-- --------------------------------------------------------

--
-- Table structure for table `grup_pilihan`
--

CREATE TABLE IF NOT EXISTS `grup_pilihan` (
  `id_grup_pilihan` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) NOT NULL,
  `deskripsi` text NOT NULL,
  PRIMARY KEY (`id_grup_pilihan`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `grup_pilihan`
--

INSERT INTO `grup_pilihan` (`id_grup_pilihan`, `nama`, `deskripsi`) VALUES
(1, 'Skor Penilaian', '1 = Sangat Tidak Baik, 2 = Tidak Baik, 3 = Agak Baik, 4 = Cukup Baik, 5 = Baik, 6 = Sangat Baik'),
(2, 'Tingkat Kepentingan', '1 = Sangat Tidak Penting, 2 = Tidak Penting, 3 = Kurang Penting, 4 = Cukup Penting, 5 = Penting, 6 = Sangat Penting'),
(3, 'Tingkat Kepuasan', '1 = Sangat Tidak Puas, 2 = Tidak Puas, 3 = Kurang Puas, 4 = Cukup Puas, 5 = Puas, 6 = Sangat Puas');

-- --------------------------------------------------------

--
-- Table structure for table `jawaban`
--

CREATE TABLE IF NOT EXISTS `jawaban` (
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_jawaban` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_periode` bigint(20) unsigned NOT NULL,
  `id_kuesioner` bigint(20) unsigned NOT NULL,
  `id_pertanyaan` bigint(20) unsigned NOT NULL,
  `respondent_id` varchar(100) NOT NULL,
  `respon_ke` tinyint(4) NOT NULL,
  `jawaban_pilihan` bigint(20) unsigned DEFAULT NULL,
  `jawaban_pilihan2` bigint(20) unsigned DEFAULT NULL,
  `jawaban_isian` text,
  `custom_data` text,
  PRIMARY KEY (`id_jawaban`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=401 ;

--
-- Dumping data for table `jawaban`
--

INSERT INTO `jawaban` (`created_at`, `id_jawaban`, `id_periode`, `id_kuesioner`, `id_pertanyaan`, `respondent_id`, `respon_ke`, `jawaban_pilihan`, `jawaban_pilihan2`, `jawaban_isian`, `custom_data`) VALUES
('2014-03-20 04:05:04', 1, 5, 1, 1, '2012021017', 0, 6, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;1;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:04', 2, 5, 1, 2, '2012021017', 0, 6, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;1;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:04', 3, 5, 1, 3, '2012021017', 0, 6, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;1;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:04', 4, 5, 1, 4, '2012021017', 0, 6, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;1;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:04', 5, 5, 1, 5, '2012021017', 0, 6, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;1;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:04', 6, 5, 1, 6, '2012021017', 0, 6, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;1;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:04', 7, 5, 1, 7, '2012021017', 0, 6, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;1;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:04', 8, 5, 1, 8, '2012021017', 0, 6, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;1;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:04', 9, 5, 1, 9, '2012021017', 0, 6, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;1;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:04', 10, 5, 1, 10, '2012021017', 0, 6, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;1;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:04', 11, 5, 1, 11, '2012021017', 0, 6, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;1;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:04', 12, 5, 1, 12, '2012021017', 0, 6, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;1;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:04', 13, 5, 1, 13, '2012021017', 0, 6, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;1;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:04', 14, 5, 1, 14, '2012021017', 0, 6, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;1;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:04', 15, 5, 1, 15, '2012021017', 0, 6, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;1;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:04', 16, 5, 1, 16, '2012021017', 0, 6, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;1;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:04', 17, 5, 1, 17, '2012021017', 0, 6, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;1;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:04', 18, 5, 1, 18, '2012021017', 0, 6, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;1;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:04', 19, 5, 1, 19, '2012021017', 0, 6, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;1;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:04', 20, 5, 1, 20, '2012021017', 0, NULL, NULL, '6', 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;1;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:21', 21, 5, 1, 1, '2012021017', 0, 1, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;2;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:21', 22, 5, 1, 2, '2012021017', 0, 1, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;2;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:21', 23, 5, 1, 3, '2012021017', 0, 1, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;2;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:21', 24, 5, 1, 4, '2012021017', 0, 1, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;2;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:21', 25, 5, 1, 5, '2012021017', 0, 1, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;2;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:21', 26, 5, 1, 6, '2012021017', 0, 1, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;2;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:21', 27, 5, 1, 7, '2012021017', 0, 1, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;2;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:21', 28, 5, 1, 8, '2012021017', 0, 1, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;2;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:21', 29, 5, 1, 9, '2012021017', 0, 1, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;2;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:21', 30, 5, 1, 10, '2012021017', 0, 1, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;2;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:21', 31, 5, 1, 11, '2012021017', 0, 1, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;2;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:21', 32, 5, 1, 12, '2012021017', 0, 1, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;2;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:21', 33, 5, 1, 13, '2012021017', 0, 1, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;2;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:21', 34, 5, 1, 14, '2012021017', 0, 1, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;2;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:21', 35, 5, 1, 15, '2012021017', 0, 1, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;2;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:21', 36, 5, 1, 16, '2012021017', 0, 1, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;2;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:21', 37, 5, 1, 17, '2012021017', 0, 1, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;2;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:21', 38, 5, 1, 18, '2012021017', 0, 1, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;2;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:21', 39, 5, 1, 19, '2012021017', 0, 1, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;2;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:21', 40, 5, 1, 20, '2012021017', 0, NULL, NULL, '1', 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;2;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:38', 41, 5, 1, 1, '2012021017', 0, 4, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;1;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:38', 42, 5, 1, 2, '2012021017', 0, 4, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;1;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:38', 43, 5, 1, 3, '2012021017', 0, 4, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;1;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:38', 44, 5, 1, 4, '2012021017', 0, 4, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;1;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:38', 45, 5, 1, 5, '2012021017', 0, 4, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;1;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:38', 46, 5, 1, 6, '2012021017', 0, 4, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;1;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:38', 47, 5, 1, 7, '2012021017', 0, 4, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;1;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:38', 48, 5, 1, 8, '2012021017', 0, 4, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;1;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:38', 49, 5, 1, 9, '2012021017', 0, 4, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;1;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:38', 50, 5, 1, 10, '2012021017', 0, 4, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;1;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:38', 51, 5, 1, 11, '2012021017', 0, 2, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;1;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:38', 52, 5, 1, 12, '2012021017', 0, 2, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;1;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:38', 53, 5, 1, 13, '2012021017', 0, 2, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;1;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:38', 54, 5, 1, 14, '2012021017', 0, 2, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;1;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:38', 55, 5, 1, 15, '2012021017', 0, 2, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;1;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:38', 56, 5, 1, 16, '2012021017', 0, 2, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;1;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:38', 57, 5, 1, 17, '2012021017', 0, 2, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;1;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:38', 58, 5, 1, 18, '2012021017', 0, 2, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;1;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:38', 59, 5, 1, 19, '2012021017', 0, 2, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;1;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:38', 60, 5, 1, 20, '2012021017', 0, NULL, NULL, '', 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;1;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:57', 61, 5, 1, 1, '2012021017', 0, 6, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;2;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:57', 62, 5, 1, 2, '2012021017', 0, 6, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;2;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:57', 63, 5, 1, 3, '2012021017', 0, 6, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;2;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:57', 64, 5, 1, 4, '2012021017', 0, 6, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;2;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:57', 65, 5, 1, 5, '2012021017', 0, 6, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;2;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:57', 66, 5, 1, 6, '2012021017', 0, 6, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;2;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:57', 67, 5, 1, 7, '2012021017', 0, 6, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;2;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:57', 68, 5, 1, 8, '2012021017', 0, 6, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;2;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:57', 69, 5, 1, 9, '2012021017', 0, 6, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;2;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:57', 70, 5, 1, 10, '2012021017', 0, 6, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;2;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:57', 71, 5, 1, 11, '2012021017', 0, 5, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;2;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:57', 72, 5, 1, 12, '2012021017', 0, 5, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;2;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:57', 73, 5, 1, 13, '2012021017', 0, 5, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;2;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:57', 74, 5, 1, 14, '2012021017', 0, 5, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;2;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:57', 75, 5, 1, 15, '2012021017', 0, 5, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;2;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:57', 76, 5, 1, 16, '2012021017', 0, 5, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;2;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:57', 77, 5, 1, 17, '2012021017', 0, 5, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;2;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:57', 78, 5, 1, 18, '2012021017', 0, 5, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;2;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:57', 79, 5, 1, 19, '2012021017', 0, 5, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;2;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:57', 80, 5, 1, 20, '2012021017', 0, NULL, NULL, '', 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;2;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 08:37:45', 81, 6, 1, 1, '2012021017', 0, 1, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&1&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:37:45', 82, 6, 1, 2, '2012021017', 0, 1, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&1&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:37:45', 83, 6, 1, 3, '2012021017', 0, 2, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&1&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:37:45', 84, 6, 1, 4, '2012021017', 0, 1, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&1&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:37:45', 85, 6, 1, 5, '2012021017', 0, 2, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&1&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:37:45', 86, 6, 1, 6, '2012021017', 0, 1, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&1&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:37:45', 87, 6, 1, 7, '2012021017', 0, 2, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&1&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:37:45', 88, 6, 1, 8, '2012021017', 0, 1, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&1&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:37:45', 89, 6, 1, 9, '2012021017', 0, 2, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&1&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:37:45', 90, 6, 1, 10, '2012021017', 0, 1, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&1&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:37:45', 91, 6, 1, 11, '2012021017', 0, 2, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&1&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:37:45', 92, 6, 1, 12, '2012021017', 0, 1, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&1&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:37:45', 93, 6, 1, 13, '2012021017', 0, 2, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&1&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:37:45', 94, 6, 1, 14, '2012021017', 0, 1, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&1&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:37:45', 95, 6, 1, 15, '2012021017', 0, 2, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&1&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:37:45', 96, 6, 1, 16, '2012021017', 0, 1, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&1&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:37:45', 97, 6, 1, 17, '2012021017', 0, 2, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&1&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:37:45', 98, 6, 1, 18, '2012021017', 0, 1, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&1&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:37:45', 99, 6, 1, 19, '2012021017', 0, 2, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&1&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:37:45', 100, 6, 1, 20, '2012021017', 0, NULL, NULL, '', 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&1&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:52:36', 101, 6, 1, 1, '2012021017', 0, 1, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&2&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:52:36', 102, 6, 1, 2, '2012021017', 0, 1, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&2&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:52:36', 103, 6, 1, 3, '2012021017', 0, 1, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&2&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:52:36', 104, 6, 1, 4, '2012021017', 0, 1, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&2&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:52:36', 105, 6, 1, 5, '2012021017', 0, 1, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&2&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:52:36', 106, 6, 1, 6, '2012021017', 0, 1, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&2&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:52:36', 107, 6, 1, 7, '2012021017', 0, 1, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&2&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:52:36', 108, 6, 1, 8, '2012021017', 0, 1, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&2&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:52:36', 109, 6, 1, 9, '2012021017', 0, 1, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&2&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:52:36', 110, 6, 1, 10, '2012021017', 0, 1, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&2&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:52:36', 111, 6, 1, 11, '2012021017', 0, 1, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&2&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:52:36', 112, 6, 1, 12, '2012021017', 0, 1, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&2&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:52:36', 113, 6, 1, 13, '2012021017', 0, 1, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&2&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:52:36', 114, 6, 1, 14, '2012021017', 0, 1, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&2&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:52:36', 115, 6, 1, 15, '2012021017', 0, 1, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&2&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:52:36', 116, 6, 1, 16, '2012021017', 0, 1, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&2&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:52:36', 117, 6, 1, 17, '2012021017', 0, 1, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&2&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:52:36', 118, 6, 1, 18, '2012021017', 0, 1, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&2&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:52:36', 119, 6, 1, 19, '2012021017', 0, 1, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&2&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:52:36', 120, 6, 1, 20, '2012021017', 0, NULL, NULL, '121212', 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&2&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 09:19:01', 121, 6, 1, 1, '2012021017', 0, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4709&&1549&&MGT&&3&&MGT209&&MANAJEMEN OPERASI DAN PRODUKSI&&08.0111.021&&Dohar P Marbun&&MGT&&1&&229&&4&&Kamis&&Thursday&&08:00:00&&10:29:00&&A-307&&20131'),
('2014-03-20 09:19:01', 122, 6, 1, 2, '2012021017', 0, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4709&&1549&&MGT&&3&&MGT209&&MANAJEMEN OPERASI DAN PRODUKSI&&08.0111.021&&Dohar P Marbun&&MGT&&1&&229&&4&&Kamis&&Thursday&&08:00:00&&10:29:00&&A-307&&20131'),
('2014-03-20 09:19:01', 123, 6, 1, 3, '2012021017', 0, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4709&&1549&&MGT&&3&&MGT209&&MANAJEMEN OPERASI DAN PRODUKSI&&08.0111.021&&Dohar P Marbun&&MGT&&1&&229&&4&&Kamis&&Thursday&&08:00:00&&10:29:00&&A-307&&20131'),
('2014-03-20 09:19:01', 124, 6, 1, 4, '2012021017', 0, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4709&&1549&&MGT&&3&&MGT209&&MANAJEMEN OPERASI DAN PRODUKSI&&08.0111.021&&Dohar P Marbun&&MGT&&1&&229&&4&&Kamis&&Thursday&&08:00:00&&10:29:00&&A-307&&20131'),
('2014-03-20 09:19:01', 125, 6, 1, 5, '2012021017', 0, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4709&&1549&&MGT&&3&&MGT209&&MANAJEMEN OPERASI DAN PRODUKSI&&08.0111.021&&Dohar P Marbun&&MGT&&1&&229&&4&&Kamis&&Thursday&&08:00:00&&10:29:00&&A-307&&20131'),
('2014-03-20 09:19:01', 126, 6, 1, 6, '2012021017', 0, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4709&&1549&&MGT&&3&&MGT209&&MANAJEMEN OPERASI DAN PRODUKSI&&08.0111.021&&Dohar P Marbun&&MGT&&1&&229&&4&&Kamis&&Thursday&&08:00:00&&10:29:00&&A-307&&20131'),
('2014-03-20 09:19:01', 127, 6, 1, 7, '2012021017', 0, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4709&&1549&&MGT&&3&&MGT209&&MANAJEMEN OPERASI DAN PRODUKSI&&08.0111.021&&Dohar P Marbun&&MGT&&1&&229&&4&&Kamis&&Thursday&&08:00:00&&10:29:00&&A-307&&20131'),
('2014-03-20 09:19:01', 128, 6, 1, 8, '2012021017', 0, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4709&&1549&&MGT&&3&&MGT209&&MANAJEMEN OPERASI DAN PRODUKSI&&08.0111.021&&Dohar P Marbun&&MGT&&1&&229&&4&&Kamis&&Thursday&&08:00:00&&10:29:00&&A-307&&20131'),
('2014-03-20 09:19:01', 129, 6, 1, 9, '2012021017', 0, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4709&&1549&&MGT&&3&&MGT209&&MANAJEMEN OPERASI DAN PRODUKSI&&08.0111.021&&Dohar P Marbun&&MGT&&1&&229&&4&&Kamis&&Thursday&&08:00:00&&10:29:00&&A-307&&20131'),
('2014-03-20 09:19:01', 130, 6, 1, 10, '2012021017', 0, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4709&&1549&&MGT&&3&&MGT209&&MANAJEMEN OPERASI DAN PRODUKSI&&08.0111.021&&Dohar P Marbun&&MGT&&1&&229&&4&&Kamis&&Thursday&&08:00:00&&10:29:00&&A-307&&20131'),
('2014-03-20 09:19:01', 131, 6, 1, 11, '2012021017', 0, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4709&&1549&&MGT&&3&&MGT209&&MANAJEMEN OPERASI DAN PRODUKSI&&08.0111.021&&Dohar P Marbun&&MGT&&1&&229&&4&&Kamis&&Thursday&&08:00:00&&10:29:00&&A-307&&20131'),
('2014-03-20 09:19:01', 132, 6, 1, 12, '2012021017', 0, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4709&&1549&&MGT&&3&&MGT209&&MANAJEMEN OPERASI DAN PRODUKSI&&08.0111.021&&Dohar P Marbun&&MGT&&1&&229&&4&&Kamis&&Thursday&&08:00:00&&10:29:00&&A-307&&20131'),
('2014-03-20 09:19:01', 133, 6, 1, 13, '2012021017', 0, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4709&&1549&&MGT&&3&&MGT209&&MANAJEMEN OPERASI DAN PRODUKSI&&08.0111.021&&Dohar P Marbun&&MGT&&1&&229&&4&&Kamis&&Thursday&&08:00:00&&10:29:00&&A-307&&20131'),
('2014-03-20 09:19:01', 134, 6, 1, 14, '2012021017', 0, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4709&&1549&&MGT&&3&&MGT209&&MANAJEMEN OPERASI DAN PRODUKSI&&08.0111.021&&Dohar P Marbun&&MGT&&1&&229&&4&&Kamis&&Thursday&&08:00:00&&10:29:00&&A-307&&20131'),
('2014-03-20 09:19:01', 135, 6, 1, 15, '2012021017', 0, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4709&&1549&&MGT&&3&&MGT209&&MANAJEMEN OPERASI DAN PRODUKSI&&08.0111.021&&Dohar P Marbun&&MGT&&1&&229&&4&&Kamis&&Thursday&&08:00:00&&10:29:00&&A-307&&20131'),
('2014-03-20 09:19:01', 136, 6, 1, 16, '2012021017', 0, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4709&&1549&&MGT&&3&&MGT209&&MANAJEMEN OPERASI DAN PRODUKSI&&08.0111.021&&Dohar P Marbun&&MGT&&1&&229&&4&&Kamis&&Thursday&&08:00:00&&10:29:00&&A-307&&20131'),
('2014-03-20 09:19:01', 137, 6, 1, 17, '2012021017', 0, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4709&&1549&&MGT&&3&&MGT209&&MANAJEMEN OPERASI DAN PRODUKSI&&08.0111.021&&Dohar P Marbun&&MGT&&1&&229&&4&&Kamis&&Thursday&&08:00:00&&10:29:00&&A-307&&20131'),
('2014-03-20 09:19:01', 138, 6, 1, 18, '2012021017', 0, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4709&&1549&&MGT&&3&&MGT209&&MANAJEMEN OPERASI DAN PRODUKSI&&08.0111.021&&Dohar P Marbun&&MGT&&1&&229&&4&&Kamis&&Thursday&&08:00:00&&10:29:00&&A-307&&20131'),
('2014-03-20 09:19:01', 139, 6, 1, 19, '2012021017', 0, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4709&&1549&&MGT&&3&&MGT209&&MANAJEMEN OPERASI DAN PRODUKSI&&08.0111.021&&Dohar P Marbun&&MGT&&1&&229&&4&&Kamis&&Thursday&&08:00:00&&10:29:00&&A-307&&20131'),
('2014-03-20 09:19:01', 140, 6, 1, 20, '2012021017', 0, NULL, NULL, '66666', 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4709&&1549&&MGT&&3&&MGT209&&MANAJEMEN OPERASI DAN PRODUKSI&&08.0111.021&&Dohar P Marbun&&MGT&&1&&229&&4&&Kamis&&Thursday&&08:00:00&&10:29:00&&A-307&&20131'),
('2014-03-20 09:19:17', 141, 6, 1, 1, '2012021017', 0, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4705&&886&&MGT&&3&&LSE201&&AGAMA&&DTT032&&ICRP&&&&1&&225&&2&&Selasa&&Tuesday&&10:31:00&&13:00:00&&A-311&&20131'),
('2014-03-20 09:19:17', 142, 6, 1, 2, '2012021017', 0, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4705&&886&&MGT&&3&&LSE201&&AGAMA&&DTT032&&ICRP&&&&1&&225&&2&&Selasa&&Tuesday&&10:31:00&&13:00:00&&A-311&&20131'),
('2014-03-20 09:19:17', 143, 6, 1, 3, '2012021017', 0, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4705&&886&&MGT&&3&&LSE201&&AGAMA&&DTT032&&ICRP&&&&1&&225&&2&&Selasa&&Tuesday&&10:31:00&&13:00:00&&A-311&&20131'),
('2014-03-20 09:19:17', 144, 6, 1, 4, '2012021017', 0, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4705&&886&&MGT&&3&&LSE201&&AGAMA&&DTT032&&ICRP&&&&1&&225&&2&&Selasa&&Tuesday&&10:31:00&&13:00:00&&A-311&&20131'),
('2014-03-20 09:19:17', 145, 6, 1, 5, '2012021017', 0, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4705&&886&&MGT&&3&&LSE201&&AGAMA&&DTT032&&ICRP&&&&1&&225&&2&&Selasa&&Tuesday&&10:31:00&&13:00:00&&A-311&&20131'),
('2014-03-20 09:19:17', 146, 6, 1, 6, '2012021017', 0, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4705&&886&&MGT&&3&&LSE201&&AGAMA&&DTT032&&ICRP&&&&1&&225&&2&&Selasa&&Tuesday&&10:31:00&&13:00:00&&A-311&&20131'),
('2014-03-20 09:19:17', 147, 6, 1, 7, '2012021017', 0, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4705&&886&&MGT&&3&&LSE201&&AGAMA&&DTT032&&ICRP&&&&1&&225&&2&&Selasa&&Tuesday&&10:31:00&&13:00:00&&A-311&&20131'),
('2014-03-20 09:19:17', 148, 6, 1, 8, '2012021017', 0, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4705&&886&&MGT&&3&&LSE201&&AGAMA&&DTT032&&ICRP&&&&1&&225&&2&&Selasa&&Tuesday&&10:31:00&&13:00:00&&A-311&&20131'),
('2014-03-20 09:19:17', 149, 6, 1, 9, '2012021017', 0, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4705&&886&&MGT&&3&&LSE201&&AGAMA&&DTT032&&ICRP&&&&1&&225&&2&&Selasa&&Tuesday&&10:31:00&&13:00:00&&A-311&&20131'),
('2014-03-20 09:19:17', 150, 6, 1, 10, '2012021017', 0, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4705&&886&&MGT&&3&&LSE201&&AGAMA&&DTT032&&ICRP&&&&1&&225&&2&&Selasa&&Tuesday&&10:31:00&&13:00:00&&A-311&&20131'),
('2014-03-20 09:19:17', 151, 6, 1, 11, '2012021017', 0, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4705&&886&&MGT&&3&&LSE201&&AGAMA&&DTT032&&ICRP&&&&1&&225&&2&&Selasa&&Tuesday&&10:31:00&&13:00:00&&A-311&&20131'),
('2014-03-20 09:19:17', 152, 6, 1, 12, '2012021017', 0, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4705&&886&&MGT&&3&&LSE201&&AGAMA&&DTT032&&ICRP&&&&1&&225&&2&&Selasa&&Tuesday&&10:31:00&&13:00:00&&A-311&&20131'),
('2014-03-20 09:19:17', 153, 6, 1, 13, '2012021017', 0, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4705&&886&&MGT&&3&&LSE201&&AGAMA&&DTT032&&ICRP&&&&1&&225&&2&&Selasa&&Tuesday&&10:31:00&&13:00:00&&A-311&&20131'),
('2014-03-20 09:19:17', 154, 6, 1, 14, '2012021017', 0, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4705&&886&&MGT&&3&&LSE201&&AGAMA&&DTT032&&ICRP&&&&1&&225&&2&&Selasa&&Tuesday&&10:31:00&&13:00:00&&A-311&&20131'),
('2014-03-20 09:19:17', 155, 6, 1, 15, '2012021017', 0, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4705&&886&&MGT&&3&&LSE201&&AGAMA&&DTT032&&ICRP&&&&1&&225&&2&&Selasa&&Tuesday&&10:31:00&&13:00:00&&A-311&&20131'),
('2014-03-20 09:19:18', 156, 6, 1, 16, '2012021017', 0, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4705&&886&&MGT&&3&&LSE201&&AGAMA&&DTT032&&ICRP&&&&1&&225&&2&&Selasa&&Tuesday&&10:31:00&&13:00:00&&A-311&&20131'),
('2014-03-20 09:19:18', 157, 6, 1, 17, '2012021017', 0, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4705&&886&&MGT&&3&&LSE201&&AGAMA&&DTT032&&ICRP&&&&1&&225&&2&&Selasa&&Tuesday&&10:31:00&&13:00:00&&A-311&&20131'),
('2014-03-20 09:19:18', 158, 6, 1, 18, '2012021017', 0, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4705&&886&&MGT&&3&&LSE201&&AGAMA&&DTT032&&ICRP&&&&1&&225&&2&&Selasa&&Tuesday&&10:31:00&&13:00:00&&A-311&&20131'),
('2014-03-20 09:19:18', 159, 6, 1, 19, '2012021017', 0, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4705&&886&&MGT&&3&&LSE201&&AGAMA&&DTT032&&ICRP&&&&1&&225&&2&&Selasa&&Tuesday&&10:31:00&&13:00:00&&A-311&&20131'),
('2014-03-20 09:19:18', 160, 6, 1, 20, '2012021017', 0, NULL, NULL, '555', 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4705&&886&&MGT&&3&&LSE201&&AGAMA&&DTT032&&ICRP&&&&1&&225&&2&&Selasa&&Tuesday&&10:31:00&&13:00:00&&A-311&&20131'),
('2014-03-20 09:20:45', 161, 6, 1, 1, '2013081001', 0, 2, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&6381&&1638&&SIF&&1&&LSE101&&BAHASA INDONESIA I ( KECAKAPAN BERPIKIR )&&DTT007&&Fristian Hadinata&&&&1&&517&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131'),
('2014-03-20 09:20:45', 162, 6, 1, 2, '2013081001', 0, 2, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&6381&&1638&&SIF&&1&&LSE101&&BAHASA INDONESIA I ( KECAKAPAN BERPIKIR )&&DTT007&&Fristian Hadinata&&&&1&&517&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131'),
('2014-03-20 09:20:45', 163, 6, 1, 3, '2013081001', 0, 2, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&6381&&1638&&SIF&&1&&LSE101&&BAHASA INDONESIA I ( KECAKAPAN BERPIKIR )&&DTT007&&Fristian Hadinata&&&&1&&517&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131'),
('2014-03-20 09:20:45', 164, 6, 1, 4, '2013081001', 0, 2, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&6381&&1638&&SIF&&1&&LSE101&&BAHASA INDONESIA I ( KECAKAPAN BERPIKIR )&&DTT007&&Fristian Hadinata&&&&1&&517&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131'),
('2014-03-20 09:20:45', 165, 6, 1, 5, '2013081001', 0, 2, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&6381&&1638&&SIF&&1&&LSE101&&BAHASA INDONESIA I ( KECAKAPAN BERPIKIR )&&DTT007&&Fristian Hadinata&&&&1&&517&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131'),
('2014-03-20 09:20:45', 166, 6, 1, 6, '2013081001', 0, 2, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&6381&&1638&&SIF&&1&&LSE101&&BAHASA INDONESIA I ( KECAKAPAN BERPIKIR )&&DTT007&&Fristian Hadinata&&&&1&&517&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131'),
('2014-03-20 09:20:45', 167, 6, 1, 7, '2013081001', 0, 2, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&6381&&1638&&SIF&&1&&LSE101&&BAHASA INDONESIA I ( KECAKAPAN BERPIKIR )&&DTT007&&Fristian Hadinata&&&&1&&517&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131'),
('2014-03-20 09:20:45', 168, 6, 1, 8, '2013081001', 0, 2, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&6381&&1638&&SIF&&1&&LSE101&&BAHASA INDONESIA I ( KECAKAPAN BERPIKIR )&&DTT007&&Fristian Hadinata&&&&1&&517&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131'),
('2014-03-20 09:20:45', 169, 6, 1, 9, '2013081001', 0, 2, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&6381&&1638&&SIF&&1&&LSE101&&BAHASA INDONESIA I ( KECAKAPAN BERPIKIR )&&DTT007&&Fristian Hadinata&&&&1&&517&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131'),
('2014-03-20 09:20:45', 170, 6, 1, 10, '2013081001', 0, 2, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&6381&&1638&&SIF&&1&&LSE101&&BAHASA INDONESIA I ( KECAKAPAN BERPIKIR )&&DTT007&&Fristian Hadinata&&&&1&&517&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131'),
('2014-03-20 09:20:45', 171, 6, 1, 11, '2013081001', 0, 2, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&6381&&1638&&SIF&&1&&LSE101&&BAHASA INDONESIA I ( KECAKAPAN BERPIKIR )&&DTT007&&Fristian Hadinata&&&&1&&517&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131'),
('2014-03-20 09:20:45', 172, 6, 1, 12, '2013081001', 0, 2, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&6381&&1638&&SIF&&1&&LSE101&&BAHASA INDONESIA I ( KECAKAPAN BERPIKIR )&&DTT007&&Fristian Hadinata&&&&1&&517&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131'),
('2014-03-20 09:20:45', 173, 6, 1, 13, '2013081001', 0, 2, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&6381&&1638&&SIF&&1&&LSE101&&BAHASA INDONESIA I ( KECAKAPAN BERPIKIR )&&DTT007&&Fristian Hadinata&&&&1&&517&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131'),
('2014-03-20 09:20:45', 174, 6, 1, 14, '2013081001', 0, 2, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&6381&&1638&&SIF&&1&&LSE101&&BAHASA INDONESIA I ( KECAKAPAN BERPIKIR )&&DTT007&&Fristian Hadinata&&&&1&&517&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131'),
('2014-03-20 09:20:45', 175, 6, 1, 15, '2013081001', 0, 2, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&6381&&1638&&SIF&&1&&LSE101&&BAHASA INDONESIA I ( KECAKAPAN BERPIKIR )&&DTT007&&Fristian Hadinata&&&&1&&517&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131'),
('2014-03-20 09:20:45', 176, 6, 1, 16, '2013081001', 0, 2, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&6381&&1638&&SIF&&1&&LSE101&&BAHASA INDONESIA I ( KECAKAPAN BERPIKIR )&&DTT007&&Fristian Hadinata&&&&1&&517&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131'),
('2014-03-20 09:20:45', 177, 6, 1, 17, '2013081001', 0, 2, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&6381&&1638&&SIF&&1&&LSE101&&BAHASA INDONESIA I ( KECAKAPAN BERPIKIR )&&DTT007&&Fristian Hadinata&&&&1&&517&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131'),
('2014-03-20 09:20:45', 178, 6, 1, 18, '2013081001', 0, 2, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&6381&&1638&&SIF&&1&&LSE101&&BAHASA INDONESIA I ( KECAKAPAN BERPIKIR )&&DTT007&&Fristian Hadinata&&&&1&&517&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131'),
('2014-03-20 09:20:45', 179, 6, 1, 19, '2013081001', 0, 2, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&6381&&1638&&SIF&&1&&LSE101&&BAHASA INDONESIA I ( KECAKAPAN BERPIKIR )&&DTT007&&Fristian Hadinata&&&&1&&517&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131'),
('2014-03-20 09:20:45', 180, 6, 1, 20, '2013081001', 0, NULL, NULL, '', 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&6381&&1638&&SIF&&1&&LSE101&&BAHASA INDONESIA I ( KECAKAPAN BERPIKIR )&&DTT007&&Fristian Hadinata&&&&1&&517&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131'),
('2014-03-20 09:21:09', 181, 6, 1, 1, '2013081001', 0, 4, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:21:09', 182, 6, 1, 2, '2013081001', 0, 4, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:21:09', 183, 6, 1, 3, '2013081001', 0, 4, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:21:09', 184, 6, 1, 4, '2013081001', 0, 4, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:21:09', 185, 6, 1, 5, '2013081001', 0, 4, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:21:09', 186, 6, 1, 6, '2013081001', 0, 5, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:21:09', 187, 6, 1, 7, '2013081001', 0, 5, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:21:09', 188, 6, 1, 8, '2013081001', 0, 5, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:21:09', 189, 6, 1, 9, '2013081001', 0, 5, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:21:09', 190, 6, 1, 10, '2013081001', 0, 5, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:21:09', 191, 6, 1, 11, '2013081001', 0, 4, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:21:09', 192, 6, 1, 12, '2013081001', 0, 4, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:21:09', 193, 6, 1, 13, '2013081001', 0, 4, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:21:09', 194, 6, 1, 14, '2013081001', 0, 4, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:21:09', 195, 6, 1, 15, '2013081001', 0, 4, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:21:09', 196, 6, 1, 16, '2013081001', 0, 5, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:21:09', 197, 6, 1, 17, '2013081001', 0, 5, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:21:09', 198, 6, 1, 18, '2013081001', 0, 5, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:21:09', 199, 6, 1, 19, '2013081001', 0, 5, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131');
INSERT INTO `jawaban` (`created_at`, `id_jawaban`, `id_periode`, `id_kuesioner`, `id_pertanyaan`, `respondent_id`, `respon_ke`, `jawaban_pilihan`, `jawaban_pilihan2`, `jawaban_isian`, `custom_data`) VALUES
('2014-03-20 09:21:09', 200, 6, 1, 20, '2013081001', 0, NULL, NULL, '', 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:22:38', 201, 6, 1, 1, '2013081001', 0, 6, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:22:38', 202, 6, 1, 2, '2013081001', 0, 6, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:22:38', 203, 6, 1, 3, '2013081001', 0, 6, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:22:38', 204, 6, 1, 4, '2013081001', 0, 6, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:22:38', 205, 6, 1, 5, '2013081001', 0, 6, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:22:38', 206, 6, 1, 6, '2013081001', 0, 6, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:22:38', 207, 6, 1, 7, '2013081001', 0, 6, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:22:38', 208, 6, 1, 8, '2013081001', 0, 6, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:22:38', 209, 6, 1, 9, '2013081001', 0, 6, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:22:38', 210, 6, 1, 10, '2013081001', 0, 6, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:22:38', 211, 6, 1, 11, '2013081001', 0, 6, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:22:38', 212, 6, 1, 12, '2013081001', 0, 6, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:22:38', 213, 6, 1, 13, '2013081001', 0, 6, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:22:38', 214, 6, 1, 14, '2013081001', 0, 6, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:22:38', 215, 6, 1, 15, '2013081001', 0, 6, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:22:38', 216, 6, 1, 16, '2013081001', 0, 6, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:22:38', 217, 6, 1, 17, '2013081001', 0, 6, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:22:38', 218, 6, 1, 18, '2013081001', 0, 6, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:22:38', 219, 6, 1, 19, '2013081001', 0, 6, NULL, NULL, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:22:38', 220, 6, 1, 20, '2013081001', 0, NULL, NULL, '', 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-21 07:27:03', 241, 6, 1, 1, '2013011018', 1, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&1&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:03', 242, 6, 1, 2, '2013011018', 2, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&1&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:03', 243, 6, 1, 3, '2013011018', 3, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&1&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:03', 244, 6, 1, 4, '2013011018', 4, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&1&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:03', 245, 6, 1, 5, '2013011018', 5, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&1&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:03', 246, 6, 1, 6, '2013011018', 6, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&1&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:03', 247, 6, 1, 7, '2013011018', 7, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&1&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:03', 248, 6, 1, 8, '2013011018', 8, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&1&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:03', 249, 6, 1, 9, '2013011018', 9, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&1&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:03', 250, 6, 1, 10, '2013011018', 10, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&1&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:03', 251, 6, 1, 11, '2013011018', 11, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&1&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:04', 252, 6, 1, 12, '2013011018', 12, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&1&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:04', 253, 6, 1, 13, '2013011018', 13, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&1&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:04', 254, 6, 1, 14, '2013011018', 14, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&1&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:04', 255, 6, 1, 15, '2013011018', 15, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&1&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:04', 256, 6, 1, 16, '2013011018', 16, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&1&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:04', 257, 6, 1, 17, '2013011018', 17, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&1&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:04', 258, 6, 1, 18, '2013011018', 18, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&1&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:04', 259, 6, 1, 19, '2013011018', 19, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&1&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:04', 260, 6, 1, 20, '2013011018', 20, NULL, NULL, '', 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&1&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:23', 261, 6, 1, 1, '2013011018', 1, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&1&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 07:27:23', 262, 6, 1, 2, '2013011018', 2, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&1&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 07:27:23', 263, 6, 1, 3, '2013011018', 3, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&1&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 07:27:23', 264, 6, 1, 4, '2013011018', 4, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&1&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 07:27:23', 265, 6, 1, 5, '2013011018', 5, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&1&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 07:27:23', 266, 6, 1, 6, '2013011018', 6, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&1&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 07:27:23', 267, 6, 1, 7, '2013011018', 7, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&1&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 07:27:23', 268, 6, 1, 8, '2013011018', 8, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&1&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 07:27:23', 269, 6, 1, 9, '2013011018', 9, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&1&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 07:27:23', 270, 6, 1, 10, '2013011018', 10, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&1&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 07:27:23', 271, 6, 1, 11, '2013011018', 11, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&1&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 07:27:23', 272, 6, 1, 12, '2013011018', 12, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&1&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 07:27:23', 273, 6, 1, 13, '2013011018', 13, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&1&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 07:27:23', 274, 6, 1, 14, '2013011018', 14, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&1&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 07:27:23', 275, 6, 1, 15, '2013011018', 15, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&1&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 07:27:23', 276, 6, 1, 16, '2013011018', 16, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&1&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 07:27:23', 277, 6, 1, 17, '2013011018', 17, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&1&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 07:27:23', 278, 6, 1, 18, '2013011018', 18, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&1&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 07:27:23', 279, 6, 1, 19, '2013011018', 19, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&1&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 07:27:23', 280, 6, 1, 20, '2013011018', 20, NULL, NULL, '', 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&1&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 07:27:41', 281, 6, 1, 1, '2013011018', 1, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&2&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:41', 282, 6, 1, 2, '2013011018', 2, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&2&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:41', 283, 6, 1, 3, '2013011018', 3, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&2&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:41', 284, 6, 1, 4, '2013011018', 4, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&2&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:41', 285, 6, 1, 5, '2013011018', 5, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&2&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:41', 286, 6, 1, 6, '2013011018', 6, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&2&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:41', 287, 6, 1, 7, '2013011018', 7, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&2&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:41', 288, 6, 1, 8, '2013011018', 8, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&2&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:41', 289, 6, 1, 9, '2013011018', 9, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&2&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:41', 290, 6, 1, 10, '2013011018', 10, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&2&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:41', 291, 6, 1, 11, '2013011018', 11, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&2&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:41', 292, 6, 1, 12, '2013011018', 12, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&2&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:41', 293, 6, 1, 13, '2013011018', 13, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&2&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:41', 294, 6, 1, 14, '2013011018', 14, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&2&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:41', 295, 6, 1, 15, '2013011018', 15, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&2&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:41', 296, 6, 1, 16, '2013011018', 16, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&2&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:41', 297, 6, 1, 17, '2013011018', 17, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&2&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:41', 298, 6, 1, 18, '2013011018', 18, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&2&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:41', 299, 6, 1, 19, '2013011018', 19, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&2&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:41', 300, 6, 1, 20, '2013011018', 20, NULL, NULL, '', 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&2&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:31:34', 301, 6, 1, 1, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:31:34', 302, 6, 1, 2, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:31:34', 303, 6, 1, 3, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:31:34', 304, 6, 1, 4, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:31:34', 305, 6, 1, 5, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:31:34', 306, 6, 1, 6, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:31:34', 307, 6, 1, 7, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:31:34', 308, 6, 1, 8, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:31:34', 309, 6, 1, 9, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:31:34', 310, 6, 1, 10, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:31:34', 311, 6, 1, 11, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:31:34', 312, 6, 1, 12, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:31:34', 313, 6, 1, 13, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:31:34', 314, 6, 1, 14, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:31:34', 315, 6, 1, 15, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:31:34', 316, 6, 1, 16, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:31:34', 317, 6, 1, 17, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:31:34', 318, 6, 1, 18, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:31:34', 319, 6, 1, 19, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:31:34', 320, 6, 1, 20, '2013011018', 1, NULL, NULL, '', 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:32:22', 321, 6, 1, 1, '2013011018', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:32:22', 322, 6, 1, 2, '2013011018', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:32:22', 323, 6, 1, 3, '2013011018', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:32:22', 324, 6, 1, 4, '2013011018', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:32:22', 325, 6, 1, 5, '2013011018', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:32:22', 326, 6, 1, 6, '2013011018', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:32:22', 327, 6, 1, 7, '2013011018', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:32:22', 328, 6, 1, 8, '2013011018', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:32:22', 329, 6, 1, 9, '2013011018', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:32:22', 330, 6, 1, 10, '2013011018', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:32:22', 331, 6, 1, 11, '2013011018', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:32:22', 332, 6, 1, 12, '2013011018', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:32:22', 333, 6, 1, 13, '2013011018', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:32:22', 334, 6, 1, 14, '2013011018', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:32:22', 335, 6, 1, 15, '2013011018', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:32:22', 336, 6, 1, 16, '2013011018', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:32:22', 337, 6, 1, 17, '2013011018', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:32:22', 338, 6, 1, 18, '2013011018', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:32:22', 339, 6, 1, 19, '2013011018', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:32:22', 340, 6, 1, 20, '2013011018', 1, NULL, NULL, 'dfsdfsdfsdfsw', 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 08:18:34', 341, 6, 1, 1, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&2&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 08:18:34', 342, 6, 1, 2, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&2&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 08:18:34', 343, 6, 1, 3, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&2&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 08:18:34', 344, 6, 1, 4, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&2&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 08:18:34', 345, 6, 1, 5, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&2&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 08:18:34', 346, 6, 1, 6, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&2&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 08:18:34', 347, 6, 1, 7, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&2&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 08:18:34', 348, 6, 1, 8, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&2&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 08:18:34', 349, 6, 1, 9, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&2&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 08:18:34', 350, 6, 1, 10, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&2&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 08:18:34', 351, 6, 1, 11, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&2&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 08:18:34', 352, 6, 1, 12, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&2&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 08:18:34', 353, 6, 1, 13, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&2&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 08:18:34', 354, 6, 1, 14, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&2&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 08:18:34', 355, 6, 1, 15, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&2&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 08:18:34', 356, 6, 1, 16, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&2&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 08:18:34', 357, 6, 1, 17, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&2&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 08:18:34', 358, 6, 1, 18, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&2&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 08:18:34', 359, 6, 1, 19, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&2&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 08:18:34', 360, 6, 1, 20, '2013011018', 1, NULL, NULL, 'aaaaa', 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&2&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 08:19:58', 361, 6, 1, 1, '2013011018', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&1&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:19:58', 362, 6, 1, 2, '2013011018', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&1&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:19:58', 363, 6, 1, 3, '2013011018', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&1&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:19:58', 364, 6, 1, 4, '2013011018', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&1&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:19:58', 365, 6, 1, 5, '2013011018', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&1&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:19:58', 366, 6, 1, 6, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&1&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:19:58', 367, 6, 1, 7, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&1&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:19:58', 368, 6, 1, 8, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&1&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:19:58', 369, 6, 1, 9, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&1&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:19:58', 370, 6, 1, 10, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&1&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:19:58', 371, 6, 1, 11, '2013011018', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&1&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:19:58', 372, 6, 1, 12, '2013011018', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&1&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:19:58', 373, 6, 1, 13, '2013011018', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&1&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:19:58', 374, 6, 1, 14, '2013011018', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&1&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:19:58', 375, 6, 1, 15, '2013011018', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&1&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:19:58', 376, 6, 1, 16, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&1&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:19:58', 377, 6, 1, 17, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&1&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:19:58', 378, 6, 1, 18, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&1&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:19:58', 379, 6, 1, 19, '2013011018', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&1&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:19:58', 380, 6, 1, 20, '2013011018', 1, NULL, NULL, 'aa', 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&1&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:20:33', 381, 6, 1, 1, '2013011018', 1, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&2&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:20:33', 382, 6, 1, 2, '2013011018', 1, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&2&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:20:33', 383, 6, 1, 3, '2013011018', 1, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&2&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:20:33', 384, 6, 1, 4, '2013011018', 1, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&2&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:20:33', 385, 6, 1, 5, '2013011018', 1, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&2&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:20:33', 386, 6, 1, 6, '2013011018', 1, 2, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&2&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:20:33', 387, 6, 1, 7, '2013011018', 1, 2, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&2&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:20:33', 388, 6, 1, 8, '2013011018', 1, 2, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&2&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:20:33', 389, 6, 1, 9, '2013011018', 1, 2, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&2&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:20:33', 390, 6, 1, 10, '2013011018', 1, 2, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&2&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:20:33', 391, 6, 1, 11, '2013011018', 1, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&2&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:20:33', 392, 6, 1, 12, '2013011018', 1, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&2&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:20:33', 393, 6, 1, 13, '2013011018', 1, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&2&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:20:33', 394, 6, 1, 14, '2013011018', 1, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&2&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:20:33', 395, 6, 1, 15, '2013011018', 1, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&2&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:20:33', 396, 6, 1, 16, '2013011018', 1, 2, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&2&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:20:33', 397, 6, 1, 17, '2013011018', 1, 2, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&2&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:20:33', 398, 6, 1, 18, '2013011018', 1, 2, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&2&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:20:33', 399, 6, 1, 19, '2013011018', 1, 2, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&2&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:20:33', 400, 6, 1, 20, '2013011018', 1, NULL, NULL, '', 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&2&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131');

-- --------------------------------------------------------

--
-- Stand-in structure for view `jawaban_edom`
--
CREATE TABLE IF NOT EXISTS `jawaban_edom` (
`mhsw_ProdiID` varchar(255)
,`mhsw_Nama_Prodi` varchar(255)
,`mhsw_ProgramID` varchar(255)
,`mhsw_Nama_Program` varchar(255)
,`KodeID` varchar(255)
,`KRSID` varchar(255)
,`MKID` varchar(255)
,`ProdiID` varchar(255)
,`Sesi` varchar(255)
,`MKKode` varchar(255)
,`Nama_MK` varchar(255)
,`DosenID` varchar(255)
,`Nama_Dosen` varchar(255)
,`Homebase` varchar(255)
,`order_no` varchar(255)
,`JadwalID` varchar(255)
,`HariID` varchar(255)
,`Hari` varchar(255)
,`JamMulai` varchar(255)
,`JamSelesai` varchar(255)
,`RuangID` varchar(255)
,`TahunID` varchar(255)
,`id_periode` bigint(20) unsigned
,`id_kuesioner` bigint(20) unsigned
,`id_pertanyaan` bigint(20) unsigned
,`respondent_id` varchar(100)
,`respon_ke` tinyint(4)
,`jawaban_pilihan` int(11)
,`jawaban_pilihan2` int(11)
,`jawaban_isian` text
,`created_at` timestamp
);
-- --------------------------------------------------------

--
-- Table structure for table `jawaban_header`
--

CREATE TABLE IF NOT EXISTS `jawaban_header` (
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_jawaban_header` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_periode` bigint(20) unsigned NOT NULL,
  `id_kuesioner` bigint(20) unsigned NOT NULL,
  `respondent_id` varchar(100) NOT NULL,
  `respon_ke` tinyint(4) NOT NULL,
  `custom_data` text,
  PRIMARY KEY (`id_jawaban_header`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=21 ;

--
-- Dumping data for table `jawaban_header`
--

INSERT INTO `jawaban_header` (`created_at`, `id_jawaban_header`, `id_periode`, `id_kuesioner`, `respondent_id`, `respon_ke`, `custom_data`) VALUES
('2014-03-20 04:05:04', 1, 5, 1, '2012021017', 0, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;1;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:21', 2, 5, 1, '2012021017', 0, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4705;886;MGT;3;LSE201;Agama;DTT032;ICRP;;2;225;2;Selasa;Tuesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:38', 3, 5, 1, '2012021017', 0, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;1;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 04:05:57', 4, 5, 1, '2012021017', 0, 'MGT;Manajemen;Management;REG;Reguler;SISFO;4708;889;MGT;3;LSE207;Etika;DTT038;Andhika Wirawan;;2;228;3;Rabu;Wednesday;10:31:00;13:00:00;A-311;20131'),
('2014-03-20 08:37:45', 5, 6, 1, '2012021017', 0, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&1&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 08:52:36', 6, 6, 1, '2012021017', 0, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4711&&895&&MGT&&5&&MGT301&&LEADERSHIP & TEAM DEVELOPMENT&&08.1110.006&& Willy Micco Seancho&&MGT&&2&&248&&5&&Jumat&&Friday&&09:00:00&&11:30:00&&A-305&&20131'),
('2014-03-20 09:19:01', 7, 6, 1, '2012021017', 0, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4709&&1549&&MGT&&3&&MGT209&&MANAJEMEN OPERASI DAN PRODUKSI&&08.0111.021&&Dohar P Marbun&&MGT&&1&&229&&4&&Kamis&&Thursday&&08:00:00&&10:29:00&&A-307&&20131'),
('2014-03-20 09:19:17', 8, 6, 1, '2012021017', 0, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&4705&&886&&MGT&&3&&LSE201&&AGAMA&&DTT032&&ICRP&&&&1&&225&&2&&Selasa&&Tuesday&&10:31:00&&13:00:00&&A-311&&20131'),
('2014-03-20 09:20:45', 9, 6, 1, '2013081001', 0, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&6381&&1638&&SIF&&1&&LSE101&&BAHASA INDONESIA I ( KECAKAPAN BERPIKIR )&&DTT007&&Fristian Hadinata&&&&1&&517&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131'),
('2014-03-20 09:21:09', 10, 6, 1, '2013081001', 0, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:22:38', 11, 6, 1, '2013081001', 0, 'SIF&&Sistem Informasi&&Information Systems&&REG&&Reguler&&SISFO&&7973&&1642&&SIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&498&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-305&&20131'),
('2014-03-20 09:23:36', 12, 6, 1, '2013071003', 0, 'TIF&&Teknik Informatika&&Informatics Engineering&&REG&&Reguler&&SISFO&&6200&&1696&&TIF&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT013&&Joko Santoso&&&&1&&583&&5&&Jumat&&Friday&&13:00:00&&15:30:00&&A-306&&20131'),
('2014-03-21 07:27:03', 13, 6, 1, '2013011018', 0, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&1&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:27:23', 14, 6, 1, '2013011018', 0, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&1&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 07:27:41', 15, 6, 1, '2013011018', 0, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7185&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT006&&Herdito Sandi Pratama&&&&2&&347&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&A-304&&20131'),
('2014-03-21 07:31:34', 16, 6, 1, '2013011018', 1, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&1&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 07:32:22', 17, 6, 1, '2013011018', 1, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7183&&1206&&AKT&&1&&LSE105&&DASAR LOGIKA DAN MATEMATIKA&&DTT015&&Rahmi Rusin&&&&2&&318&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-305&&20131'),
('2014-03-21 08:18:33', 18, 6, 1, '2013011018', 1, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7184&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&2&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131'),
('2014-03-21 08:19:58', 19, 6, 1, '2013011018', 1, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&1&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131'),
('2014-03-21 08:20:33', 20, 6, 1, '2013011018', 1, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7188&&621&&AKT&&1&&LSE111&&OLAH RAGA 1&&DTT019&&Akhmad Kosasih&&&&2&&68&&5&&Jumat&&Friday&&15:30:00&&17:30:00&&SPJ&&20131');

-- --------------------------------------------------------

--
-- Table structure for table `kategori_pertanyaan`
--

CREATE TABLE IF NOT EXISTS `kategori_pertanyaan` (
  `id_kategori` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) NOT NULL,
  PRIMARY KEY (`id_kategori`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `kategori_pertanyaan`
--

INSERT INTO `kategori_pertanyaan` (`id_kategori`, `nama`) VALUES
(0, ''),
(1, 'Tidak dikategorikan'),
(2, 'Aspek Sarana dan Prasarana'),
(3, 'Aspek Staf Akademik'),
(4, 'Aspek Sikap Tanggap'),
(5, 'Aspek Assurance');

-- --------------------------------------------------------

--
-- Table structure for table `master_kuesioner`
--

CREATE TABLE IF NOT EXISTS `master_kuesioner` (
  `id_kuesioner` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `config_kuesioner` text NOT NULL,
  `nama_kuesioner` varchar(100) NOT NULL,
  `shortname` varchar(5) NOT NULL,
  `custom_header` text NOT NULL,
  PRIMARY KEY (`id_kuesioner`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `master_kuesioner`
--

INSERT INTO `master_kuesioner` (`id_kuesioner`, `config_kuesioner`, `nama_kuesioner`, `shortname`, `custom_header`) VALUES
(1, 'dflt_pilihan=4', 'Evaluasi Dosen Oleh Mahasiswa (EDOM) versi Jan-2014', 'EDOM', '<table>\n<tr><td class="width-set4" style="font-size:150%; text-align: center; padding-bottom:.5em;"><b>LEMBAR EVALUASI DOSEN OLEH MAHASISWA</b></td></tr>\n<tr><td style="text-align:justify;">Untuk meningkatkan kualitas pengajaran dan kualitas akademik, harap melengkapi lembar evaluasi ini secara jujur, obyektif dan penuh tanggung jawab. Informasi yang Saudara berikan hanya digunakan dalam proses evaluasi dosen dan tidak akan berpengaruh terhadap status Saudara sebagai mahasiswa.</td></tr>\n<tr><td style="padding-top:.5em;"><span style="width:115px; display:inline-block;">Nama Dosen</span>: {Nama_Dosen}</td></tr>\n<tr><td><span style="width:115px; display:inline-block;">Mata Kuliah</span>: {Nama_MK}</td>\n<tr><td style="padding-bottom:.5em;"><span style="width:115px; display:inline-block;">Tahun Akademik</span>: {TahunID}</td></tr>\n<tr><td style="font-size:90%; text-align:justify; padding-bottom:1em;">Skor Penilaian : 1 = Sangat tidak baik, 2 = Tidak baik, 3 = Agak baik, 4 = Cukup baik, 5 = Baik, 6 = Sangat baik.</td></tr>\n</table>\n\n<table class="bordered">\n<tr class="centered"><td class="width-set2" rowspan="2"></td><td rowspan="2"><b>Aspek Yang Dinilai</b></td><td colspan="6"><b>Skor Penilaian</b></td></tr>\n<tr class="centered"><td><b>1</b></td><td><b>2</b></td><td><b>3</b></td><td><b>4</b></td><td><b>5</b></td><td><b>6</b></td></tr>\n<!--</table>-->'),
(2, 'dflt_pilihan=4;dflt_pilihan2=4', 'Kepuasan Mahasiswa versi Jan-2014', 'KM', '');

-- --------------------------------------------------------

--
-- Table structure for table `master_pertanyaan`
--

CREATE TABLE IF NOT EXISTS `master_pertanyaan` (
  `id_pertanyaan` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_kuesioner` bigint(20) unsigned NOT NULL,
  `isi` text NOT NULL,
  `tipe` enum('pilihan','isian') NOT NULL,
  `is_mandatory` tinyint(1) NOT NULL DEFAULT '1',
  `id_kategori` bigint(20) unsigned DEFAULT NULL,
  `id_grup_pilihan` bigint(20) unsigned DEFAULT NULL,
  `id_grup_pilihan2` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_pertanyaan`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=45 ;

--
-- Dumping data for table `master_pertanyaan`
--

INSERT INTO `master_pertanyaan` (`id_pertanyaan`, `id_kuesioner`, `isi`, `tipe`, `is_mandatory`, `id_kategori`, `id_grup_pilihan`, `id_grup_pilihan2`) VALUES
(1, 1, 'Kesiapan dosen dalam memberi perkuliahan/praktikum/praktek', 'pilihan', 1, NULL, 1, NULL),
(2, 1, 'Kemampuan dosen menyampaikan materi', 'pilihan', 1, NULL, 1, NULL),
(3, 1, 'Kemampuan dosen membangkitkan minat terhadap materi', 'pilihan', 1, NULL, 1, NULL),
(4, 1, 'Pemanfaatan media dan teknologi pembelajaran dalam menjelaskan materi', 'pilihan', 1, NULL, 1, NULL),
(5, 1, 'Keadilan penilaian terhadap mahasiswa', 'pilihan', 1, NULL, 1, NULL),
(6, 1, 'Kemampuan dosen membimbing mahasiswa', 'pilihan', 1, NULL, 1, NULL),
(7, 1, 'Kesesuaian materi yang disampaikan di kelas dengan silabus', 'pilihan', 1, NULL, 1, NULL),
(8, 1, 'Keluasan wawasan keilmuan dosen pada bidang yang diajarkan', 'pilihan', 1, NULL, 1, NULL),
(9, 1, 'Kemampuan menunjukkan keterkaitan antara bidang keahlian yang diajarkan', 'pilihan', 1, NULL, 1, NULL),
(10, 1, 'Penguasaan akan isu-isu mutakhir dalam bidang yang diajarkan', 'pilihan', 1, NULL, 1, NULL),
(11, 1, 'Keteraturan dan ketertiban dosen dalam mempersiapkan perkuliahan', 'pilihan', 1, NULL, 1, NULL),
(12, 1, 'Bersikap santun dan menghargai orang lain', 'pilihan', 1, NULL, 1, NULL),
(13, 1, 'Bersikap dan berperilaku yang positif', 'pilihan', 1, NULL, 1, NULL),
(14, 1, 'Satunya kata dan tindakan', 'pilihan', 1, NULL, 1, NULL),
(15, 1, 'Kemampuan dosen mengendalikan diri dalam berbagai situasi dan kondisi', 'pilihan', 1, NULL, 1, NULL),
(16, 1, 'Semangat dan antusiasme dosen dalam mendidik', 'pilihan', 1, NULL, 1, NULL),
(17, 1, 'Kemampuan dosen dalam menyampaikan pendapat', 'pilihan', 1, NULL, 1, NULL),
(18, 1, 'Kemampuan dosen dalam menerima kritik, saran, dan pendapat mahasiswa', 'pilihan', 1, NULL, 1, NULL),
(19, 1, 'Kemampuan dosen untuk bergaul di kalangan mahasiswa', 'pilihan', 1, NULL, 1, NULL),
(20, 1, 'Saran untuk perbaikan', 'isian', 0, NULL, NULL, NULL),
(21, 2, 'Kebersihan dan kerapian ruang kuliah', 'pilihan', 1, 2, 2, 3),
(22, 2, 'Kelengkapan koleksi dan kenyamanan perpustakaan', 'pilihan', 1, 2, 2, 3),
(23, 2, 'Ketersediaan laboratorium sesuai dengan keilmuan', 'pilihan', 1, 2, 2, 3),
(24, 2, 'Laboratorium komputer yang memadai dan mudah diakses', 'pilihan', 1, 2, 2, 3),
(25, 2, 'Kebersihan toilet', 'pilihan', 1, 2, 2, 3),
(26, 2, 'Kebersihan fasilitas ibadah', 'pilihan', 1, 2, 2, 3),
(27, 2, 'Tempat Parkir yang memadai, teratur, dan aman', 'pilihan', 1, 2, 2, 3),
(28, 2, 'Kantin yang memadai dan aman', 'pilihan', 1, 2, 2, 3),
(29, 2, 'Kemudahan akses kampus dengan kendaraan umum', 'pilihan', 1, 2, 2, 3),
(30, 2, 'Staf akademik santun dalam melakukan pelayanan akademik', 'pilihan', 1, 3, 2, 3),
(31, 2, 'Staf akademik mempunyai kemampuan untuk melayani kepentingan mahasiswa', 'pilihan', 1, 3, 2, 3),
(32, 2, 'Staf akademik dapat menyelesaikan tugas/ pekerjaan sesuai janji', 'pilihan', 1, 3, 2, 3),
(33, 2, 'Pelaksanaan ujian dilakukan tepat waktu', 'pilihan', 1, 4, 2, 3),
(34, 2, 'Perkuliahan yang terjadwal baik dan sesuai dengan jadwal', 'pilihan', 1, 4, 2, 3),
(35, 2, 'UPJ menyediakan bantuan (keringanan) bagi mahasiswa tidak mampu', 'pilihan', 1, 4, 2, 3),
(36, 2, 'UPJ selalu membantu mahasiswa apabila menghadapi masalah akademik', 'pilihan', 1, 4, 2, 3),
(37, 2, 'UPJ menyediakan waktu bagi orang tua mahasiswa', 'pilihan', 1, 4, 2, 3),
(38, 2, 'Permasalahan/keluhan mahasiswa selalu ditangani UPJ melalui dosen pembimbing', 'pilihan', 1, 5, 2, 3),
(39, 2, 'Waktu digunakan efektif oleh dosen dalam mengajar', 'pilihan', 1, 5, 2, 3),
(40, 2, 'Adanya sanksi bagi mahasiswa yang melangar peraturan yang ditetapkan', 'pilihan', 1, 5, 2, 3),
(41, 2, 'UPJ selalu berusaha untuk memahami kepentingan dan kesulitan mahasiswa', 'pilihan', 1, 5, 2, 3),
(42, 2, 'UPJ berusaha memahami minat dan bakat mahasiswa dan berusaha  untuk mengembangkannya', 'pilihan', 1, 5, 2, 3),
(43, 2, 'Respon terbuka kepuasan mahasiswa terhadap pelayanan akademik UPJ', 'isian', 1, 0, NULL, NULL),
(44, 2, 'Harapan mahasiswa terhadap pelayanan dan fasilitas kampus UPJ di masa mendatang', 'isian', 1, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `penilaian`
--

CREATE TABLE IF NOT EXISTS `penilaian` (
  `id_penilaian` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_grup_pilihan` bigint(20) unsigned NOT NULL,
  `deskripsi` varchar(100) NOT NULL,
  `min_nilai` float NOT NULL,
  `max_nilai` float NOT NULL,
  PRIMARY KEY (`id_penilaian`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `penilaian`
--

INSERT INTO `penilaian` (`id_penilaian`, `id_grup_pilihan`, `deskripsi`, `min_nilai`, `max_nilai`) VALUES
(1, 1, 'Sangat Tidak Baik', 1, 1.83),
(2, 1, 'Tidak Baik', 1.84, 2.67),
(3, 1, 'Kurang Baik', 2.68, 3.51),
(4, 1, 'Agak Baik', 3.52, 4.35),
(5, 1, 'Baik', 4.36, 5.19),
(6, 1, 'Sangat Baik', 5.2, 6);

-- --------------------------------------------------------

--
-- Table structure for table `periode`
--

CREATE TABLE IF NOT EXISTS `periode` (
  `id_periode` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_kuesioner` bigint(20) unsigned NOT NULL,
  `deskripsi` varchar(100) NOT NULL COMMENT 'deskripsi yang ditampilkan di list kuesioner',
  `deskripsi_detail` text NOT NULL,
  `waktu_min` timestamp NULL DEFAULT NULL,
  `waktu_maks` timestamp NULL DEFAULT NULL,
  `respondent_id` varchar(25) NOT NULL COMMENT 'nama fungsi untuk mendapatkan respondent_id',
  `generator_config` text,
  `custom_data_format` text,
  `data_helper` varchar(255) NOT NULL COMMENT 'data yang dapat digunakan dalam koding',
  `separator` varchar(5) NOT NULL COMMENT 'separator di custom_data & throwed_data',
  PRIMARY KEY (`id_periode`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `periode`
--

INSERT INTO `periode` (`id_periode`, `id_kuesioner`, `deskripsi`, `deskripsi_detail`, `waktu_min`, `waktu_maks`, `respondent_id`, `generator_config`, `custom_data_format`, `data_helper`, `separator`) VALUES
(1, 1, 'EDOM 2013/2014 Mata Kuliah {Nama_MK}', 'EDOM 2013/2014 Ganjil (UTS) Mata Kuliah {Nama_MK}', '2014-02-24 17:00:00', '2014-03-01 17:00:00', 'sisfo_get_username()', 'db="sisfo";sql="SELECT k.MKID AS MKID, k.MKKode AS MKKode, k.Nama AS Nama_MK, j.DosenID AS DosenID, d.Nama AS Nama_Dosen, mk.Sesi AS Sesi\nFROM krs k\nLEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID\nLEFT OUTER JOIN dosen d ON j.DosenID = d.Login\nLEFT OUTER JOIN mk mk ON k.MKID = mk.MKID\nWHERE k.MhswID = ''{respondent_id}'' AND k.TahunID = ''20131''"', '{MKID};{MKKode};{Nama_MK};{Sesi};{DosenID};{Nama_Dosen};20132', '', ''),
(2, 2, 'Survey Kepuasan Mahasiswa 2013/2014', 'Survey Kepuasan Mahasiswa 2013/2014 Genap', '2014-02-24 17:00:00', '2014-03-02 17:00:00', 'sisfo_get_username()', 'db="sisfo";sql="SELECT m.MhswID FROM mhsw m WHERE m.Login = ''{respondent_id}''"', '', '', ''),
(3, 2, 'Survey Kepuasan Mahasiswa 2014/2015</td><td>', 'Survey Kepuasan Mahasiswa 2014/2015 Ganjil', '2014-02-24 17:00:00', '2014-03-07 17:00:00', 'sisfo_get_username()', 'db="sisfo";sql="SELECT m.MhswID FROM mhsw m WHERE m.Login = ''{respondent_id}''"', '', '', ''),
(4, 1, '{Nama_MK}</td><td>{Nama_Dosen}', 'EDOM 2013/2014 Genap (UTS) Mata Kuliah {Nama_MK} Oleh {Nama_Dosen}', '2014-03-03 17:00:00', '2014-03-18 17:00:00', 'sisfo_get_username()', 'db="sisfo";sql="SELECT *\nFROM (\nSELECT m.ProdiID AS mhsw_ProdiID, p.Nama AS mhsw_Nama_Prodi, p.Nama_en AS mhsw_Nama_Prodi_en, m.ProgramID AS mhsw_ProgramID, pr.Nama AS mhsw_Nama_Program, k.KRSID,\nk.MKID AS MKID, mk.Sesi AS Sesi, k.MKKode AS MKKode, k.Nama AS Nama_MK, j.DosenID AS DosenID, d.Nama AS Nama_Dosen, d.Homebase AS Homebase,\n1 AS order_no, -1 AS is_same, 20131 AS tahun, k.JadwalID AS JadwalID\nFROM krs k\nLEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID\nLEFT OUTER JOIN dosen d ON j.DosenID = d.Login\nLEFT OUTER JOIN mk mk ON k.MKID = mk.MKID\nLEFT OUTER JOIN mhsw m ON k.MhswID = m.MhswID\nLEFT OUTER JOIN prodi p ON m.ProdiID = p.ProdiID\nLEFT OUTER JOIN program pr ON m.ProgramID = pr.ProgramID\nWHERE k.MhswID = ''{respondent_id}'' AND k.TahunID = ''20131'' AND j.NA = ''N''\nUNION\nSELECT m.ProdiID AS mhsw_ProdiID, p.Nama AS mhsw_Nama_Prodi, p.Nama_en AS mhsw_Nama_Prodi_en, m.ProgramID AS mhsw_ProgramID, pr.Nama AS mhsw_Nama_Program, k.KRSID,\nk.MKID AS MKID, mk.Sesi AS Sesi, k.MKKode AS MKKode, k.Nama AS Nama_MK, IF(ISNULL(jd.DosenID), j.DosenID, jd.DosenID) AS DosenID, IF(ISNULL(jd.DosenID), d.Nama, dsn.Nama) AS Nama_Dosen, IF(ISNULL(jd.DosenID), d.Homebase, dsn.Homebase) AS Homebase,\n2 AS order_no, IF(ISNULL(jd.DosenID), 1, 0) AS is_same, 20131 AS tahun, k.JadwalID AS JadwalID\nFROM krs k\nLEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID\nLEFT OUTER JOIN dosen d ON j.DosenID = d.Login\nLEFT OUTER JOIN mk mk ON k.MKID = mk.MKID\nLEFT OUTER JOIN jadwaldosen jd ON k.JadwalID = jd.JadwalID\nLEFT OUTER JOIN dosen dsn ON jd.DosenID = dsn.Login\nLEFT OUTER JOIN mhsw m ON k.MhswID = m.MhswID\nLEFT OUTER JOIN prodi p ON m.ProdiID = p.ProdiID\nLEFT OUTER JOIN program pr ON m.ProgramID = pr.ProgramID\nWHERE k.MhswID = ''{respondent_id}'' AND k.TahunID = ''20131'' AND j.NA = ''N''\n) aa\nORDER BY aa.MKKode, aa.Nama_MK, aa.order_no, aa.Nama_Dosen;"', '{mhsw_ProdiID};{mhsw_Nama_Prodi};{mhsw_Nama_Prodi_en};{mhsw_ProgramID};{mhsw_Nama_Program};{KRSID};{MKID};{Sesi};{MKKode};{Nama_MK};{DosenID};{Nama_Dosen};{Homebase};{order_no};{tahun};{JadwalID}', '{is_same}', ''),
(5, 1, '{Nama_MK}</td><td>{Nama_Dosen}', 'EDOM BARU SEPARATOR LAMA', '2014-03-18 17:00:00', '2014-03-19 16:59:59', 'sisfo_get_username()', 'db="sisfo";sql="SELECT *\nFROM (\nSELECT 1 AS order_no, -1 AS is_same, m.ProdiID AS mhsw_ProdiID, p.Nama AS mhsw_Nama_Prodi, p.Nama_en AS mhsw_Nama_Prodi_en, m.ProgramID AS mhsw_ProgramID, pr.Nama AS mhsw_Nama_Program, j.KodeID, k.KRSID,\nj.MKID AS MKID, j.ProdiID, mk.Sesi AS Sesi, j.MKKode AS MKKode, j.Nama AS Nama_MK, j.DosenID AS DosenID, d.Nama AS Nama_Dosen, d.Homebase AS Homebase,\nj.JadwalID AS JadwalID, j.HariID, h.Nama AS Hari, h.Nama_en AS Hari_en, j.JamMulai, j.JamSelesai, j.RuangID, k.TahunID\nFROM krs k\nLEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID\nLEFT OUTER JOIN dosen d ON j.DosenID = d.Login\nLEFT OUTER JOIN mk mk ON k.MKID = mk.MKID\nLEFT OUTER JOIN mhsw m ON k.MhswID = m.MhswID\nLEFT OUTER JOIN prodi p ON m.ProdiID = p.ProdiID\nLEFT OUTER JOIN program pr ON m.ProgramID = pr.ProgramID\nLEFT OUTER JOIN hari h ON j.HariID = h.HariID\nWHERE k.MhswID = ''{respondent_id}'' AND k.TahunID = ''20131'' AND k.NA = ''N''\nUNION\nSELECT 2 AS order_no, IF(ISNULL(jd.DosenID), 1, 0) AS is_same, m.ProdiID AS mhsw_ProdiID, p.Nama AS mhsw_Nama_Prodi, p.Nama_en AS mhsw_Nama_Prodi_en, m.ProgramID AS mhsw_ProgramID, pr.Nama AS mhsw_Nama_Program, j.KodeID, k.KRSID,\nj.MKID AS MKID, j.ProdiID, mk.Sesi AS Sesi, j.MKKode AS MKKode, j.Nama AS Nama_MK, IF(ISNULL(jd.DosenID), j.DosenID, jd.DosenID) AS DosenID, IF(ISNULL(jd.DosenID), d.Nama, dsn.Nama) AS Nama_Dosen, IF(ISNULL(jd.DosenID), d.Homebase, dsn.Homebase) AS Homebase,\nj.JadwalID AS JadwalID, j.HariID, h.Nama AS Hari, h.Nama_en AS Hari_en, j.JamMulai, j.JamSelesai, j.RuangID, k.TahunID\nFROM krs k\nLEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID\nLEFT OUTER JOIN dosen d ON j.DosenID = d.Login\nLEFT OUTER JOIN mk mk ON k.MKID = mk.MKID\nLEFT OUTER JOIN jadwaldosen jd ON k.JadwalID = jd.JadwalID\nLEFT OUTER JOIN dosen dsn ON jd.DosenID = dsn.Login\nLEFT OUTER JOIN mhsw m ON k.MhswID = m.MhswID\nLEFT OUTER JOIN prodi p ON m.ProdiID = p.ProdiID\nLEFT OUTER JOIN program pr ON m.ProgramID = pr.ProgramID\nLEFT OUTER JOIN hari h ON j.HariID = h.HariID\nWHERE k.MhswID = ''{respondent_id}'' AND k.TahunID = ''20131'' AND k.NA = ''N''\n) aa\nORDER BY aa.MKKode, aa.Nama_MK, aa.order_no, aa.Nama_Dosen"', '{mhsw_ProdiID};{mhsw_Nama_Prodi};{mhsw_Nama_Prodi_en};{mhsw_ProgramID};{mhsw_Nama_Program};{KodeID};{KRSID};{MKID};{ProdiID};{Sesi};{MKKode};{Nama_MK};{DosenID};{Nama_Dosen};{Homebase};{order_no};{JadwalID};{HariID};{Hari};{Hari_en};{JamMulai};{JamSelesai};{RuangID};{TahunID}', '{is_same}', ';'),
(6, 1, '{Nama_MK}</td><td>{Nama_Dosen}', 'EDOM BARU', '2014-03-18 17:00:00', '2014-03-21 16:59:59', 'sisfo_get_username()', 'db="sisfo";sql="SELECT *\nFROM (\nSELECT 1 AS order_no, -1 AS is_same, m.ProdiID AS mhsw_ProdiID, p.Nama AS mhsw_Nama_Prodi, p.Nama_en AS mhsw_Nama_Prodi_en, m.ProgramID AS mhsw_ProgramID, pr.Nama AS mhsw_Nama_Program, j.KodeID, k.KRSID,\nj.MKID AS MKID, j.ProdiID, mk.Sesi AS Sesi, j.MKKode AS MKKode, j.Nama AS Nama_MK, j.DosenID AS DosenID, d.Nama AS Nama_Dosen, d.Homebase AS Homebase,\nj.JadwalID AS JadwalID, j.HariID, h.Nama AS Hari, h.Nama_en AS Hari_en, j.JamMulai, j.JamSelesai, j.RuangID, k.TahunID\nFROM krs k\nLEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID\nLEFT OUTER JOIN dosen d ON j.DosenID = d.Login\nLEFT OUTER JOIN mk mk ON k.MKID = mk.MKID\nLEFT OUTER JOIN mhsw m ON k.MhswID = m.MhswID\nLEFT OUTER JOIN prodi p ON m.ProdiID = p.ProdiID\nLEFT OUTER JOIN program pr ON m.ProgramID = pr.ProgramID\nLEFT OUTER JOIN hari h ON j.HariID = h.HariID\nWHERE k.MhswID = ''{respondent_id}'' AND k.TahunID = ''20131'' AND k.NA = ''N'' AND k.JadwalID <> 0\nUNION\nSELECT 2 AS order_no, IF(ISNULL(jd.DosenID), 1, 0) AS is_same, m.ProdiID AS mhsw_ProdiID, p.Nama AS mhsw_Nama_Prodi, p.Nama_en AS mhsw_Nama_Prodi_en, m.ProgramID AS mhsw_ProgramID, pr.Nama AS mhsw_Nama_Program, j.KodeID, k.KRSID,\nj.MKID AS MKID, j.ProdiID, mk.Sesi AS Sesi, j.MKKode AS MKKode, j.Nama AS Nama_MK, IF(ISNULL(jd.DosenID), j.DosenID, jd.DosenID) AS DosenID, IF(ISNULL(jd.DosenID), d.Nama, dsn.Nama) AS Nama_Dosen, IF(ISNULL(jd.DosenID), d.Homebase, dsn.Homebase) AS Homebase,\nj.JadwalID AS JadwalID, j.HariID, h.Nama AS Hari, h.Nama_en AS Hari_en, j.JamMulai, j.JamSelesai, j.RuangID, k.TahunID\nFROM krs k\nLEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID\nLEFT OUTER JOIN dosen d ON j.DosenID = d.Login\nLEFT OUTER JOIN mk mk ON k.MKID = mk.MKID\nLEFT OUTER JOIN jadwaldosen jd ON k.JadwalID = jd.JadwalID\nLEFT OUTER JOIN dosen dsn ON jd.DosenID = dsn.Login\nLEFT OUTER JOIN mhsw m ON k.MhswID = m.MhswID\nLEFT OUTER JOIN prodi p ON m.ProdiID = p.ProdiID\nLEFT OUTER JOIN program pr ON m.ProgramID = pr.ProgramID\nLEFT OUTER JOIN hari h ON j.HariID = h.HariID\nWHERE k.MhswID = ''{respondent_id}'' AND k.TahunID = ''20131'' AND k.NA = ''N'' AND k.JadwalID <> 0\n) aa\nORDER BY aa.MKKode, aa.Nama_MK, aa.order_no, aa.Nama_Dosen"', '{mhsw_ProdiID}&&{mhsw_Nama_Prodi}&&{mhsw_Nama_Prodi_en}&&{mhsw_ProgramID}&&{mhsw_Nama_Program}&&{KodeID}&&{KRSID}&&{MKID}&&{ProdiID}&&{Sesi}&&{MKKode}&&{Nama_MK}&&{DosenID}&&{Nama_Dosen}&&{Homebase}&&{order_no}&&{JadwalID}&&{HariID}&&{Hari}&&{Hari_en}&&{JamMulai}&&{JamSelesai}&&{RuangID}&&{TahunID}', '{is_same}', '&&');

-- --------------------------------------------------------

--
-- Table structure for table `pilihan`
--

CREATE TABLE IF NOT EXISTS `pilihan` (
  `id_pilihan` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_grup_pilihan` bigint(20) unsigned NOT NULL,
  `order_no` int(11) NOT NULL,
  `deskripsi` varchar(100) NOT NULL,
  `nilai` int(11) NOT NULL,
  PRIMARY KEY (`id_pilihan`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=19 ;

--
-- Dumping data for table `pilihan`
--

INSERT INTO `pilihan` (`id_pilihan`, `id_grup_pilihan`, `order_no`, `deskripsi`, `nilai`) VALUES
(1, 1, 1, 'Sangat Tidak Baik', 1),
(2, 1, 2, 'Tidak Baik', 2),
(3, 1, 3, 'Agak Baik', 3),
(4, 1, 4, 'Cukup Baik', 4),
(5, 1, 5, 'Baik', 5),
(6, 1, 6, 'Sangat Baik', 6),
(7, 2, 1, 'Sangat Tidak Penting', 1),
(8, 2, 2, 'Tidak Penting', 2),
(9, 2, 3, 'Kurang Penting', 3),
(10, 2, 4, 'Cukup Penting', 4),
(11, 2, 5, 'Penting', 5),
(12, 2, 6, 'Sangat Penting', 6),
(13, 3, 1, 'Sangat Tidak Puas', 1),
(14, 3, 2, 'Tidak Puas', 2),
(15, 3, 3, 'Kurang Puas', 3),
(16, 3, 4, 'Cukup Puas', 4),
(17, 3, 5, 'Puas', 5),
(18, 3, 6, 'Sangat Puas', 6);

-- --------------------------------------------------------

--
-- Structure for view `jawaban_edom`
--
DROP TABLE IF EXISTS `jawaban_edom`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `jawaban_edom` AS select `SPLIT_STRING`(`j`.`custom_data`,'&&',1) AS `mhsw_ProdiID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',2) AS `mhsw_Nama_Prodi`,`SPLIT_STRING`(`j`.`custom_data`,'&&',4) AS `mhsw_ProgramID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',5) AS `mhsw_Nama_Program`,`SPLIT_STRING`(`j`.`custom_data`,'&&',6) AS `KodeID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',7) AS `KRSID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',8) AS `MKID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',9) AS `ProdiID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',10) AS `Sesi`,`SPLIT_STRING`(`j`.`custom_data`,'&&',11) AS `MKKode`,`SPLIT_STRING`(`j`.`custom_data`,'&&',12) AS `Nama_MK`,`SPLIT_STRING`(`j`.`custom_data`,'&&',13) AS `DosenID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',14) AS `Nama_Dosen`,`SPLIT_STRING`(`j`.`custom_data`,'&&',15) AS `Homebase`,`SPLIT_STRING`(`j`.`custom_data`,'&&',16) AS `order_no`,`SPLIT_STRING`(`j`.`custom_data`,'&&',17) AS `JadwalID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',18) AS `HariID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',19) AS `Hari`,`SPLIT_STRING`(`j`.`custom_data`,'&&',21) AS `JamMulai`,`SPLIT_STRING`(`j`.`custom_data`,'&&',22) AS `JamSelesai`,`SPLIT_STRING`(`j`.`custom_data`,'&&',23) AS `RuangID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',24) AS `TahunID`,`j`.`id_periode` AS `id_periode`,`j`.`id_kuesioner` AS `id_kuesioner`,`j`.`id_pertanyaan` AS `id_pertanyaan`,`j`.`respondent_id` AS `respondent_id`,`j`.`respon_ke` AS `respon_ke`,`p`.`nilai` AS `jawaban_pilihan`,`p2`.`nilai` AS `jawaban_pilihan2`,`j`.`jawaban_isian` AS `jawaban_isian`,`j`.`created_at` AS `created_at` from (((`jawaban` `j` left join `master_kuesioner` `mk` on((`mk`.`id_kuesioner` = `j`.`id_kuesioner`))) left join `pilihan` `p` on((`p`.`id_pilihan` = `j`.`jawaban_pilihan`))) left join `pilihan` `p2` on((`p`.`id_pilihan` = `j`.`jawaban_pilihan2`))) where ((`mk`.`shortname` = 'EDOM') and if((`SPLIT_STRING`(`j`.`custom_data`,'&&',2) = ''),0,1));

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
