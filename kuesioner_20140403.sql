-- phpMyAdmin SQL Dump
-- version 4.0.9
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 03, 2014 at 11:27 AM
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
('445310b7319f0c8fcb9c1fb5e4010ee0', '::1', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:28.0) Gecko/20100101 Firefox/28.0', 1396516905, '');

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
  `custom_data` text NOT NULL,
  `custom_data2` text,
  `custom_data3` text,
  PRIMARY KEY (`id_jawaban`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=25 ;

--
-- Dumping data for table `jawaban`
--

INSERT INTO `jawaban` (`created_at`, `id_jawaban`, `id_periode`, `id_kuesioner`, `id_pertanyaan`, `respondent_id`, `respon_ke`, `jawaban_pilihan`, `jawaban_pilihan2`, `jawaban_isian`, `custom_data`, `custom_data2`, `custom_data3`) VALUES
('2014-04-02 07:22:43', 1, 3, 2, 21, '2012021017', 1, 11, 17, NULL, '2012021017', NULL, NULL),
('2014-04-02 07:22:43', 2, 3, 2, 22, '2012021017', 1, 11, 17, NULL, '2012021017', NULL, NULL),
('2014-04-02 07:22:43', 3, 3, 2, 23, '2012021017', 1, 11, 17, NULL, '2012021017', NULL, NULL),
('2014-04-02 07:22:43', 4, 3, 2, 24, '2012021017', 1, 11, 17, NULL, '2012021017', NULL, NULL),
('2014-04-02 07:22:43', 5, 3, 2, 25, '2012021017', 1, 11, 17, NULL, '2012021017', NULL, NULL),
('2014-04-02 07:22:43', 6, 3, 2, 26, '2012021017', 1, 11, 17, NULL, '2012021017', NULL, NULL),
('2014-04-02 07:22:43', 7, 3, 2, 27, '2012021017', 1, 11, 17, NULL, '2012021017', NULL, NULL),
('2014-04-02 07:22:43', 8, 3, 2, 28, '2012021017', 1, 11, 17, NULL, '2012021017', NULL, NULL),
('2014-04-02 07:22:43', 9, 3, 2, 29, '2012021017', 1, 11, 17, NULL, '2012021017', NULL, NULL),
('2014-04-02 07:22:43', 10, 3, 2, 30, '2012021017', 1, 11, 17, NULL, '2012021017', NULL, NULL),
('2014-04-02 07:22:43', 11, 3, 2, 31, '2012021017', 1, 11, 17, NULL, '2012021017', NULL, NULL),
('2014-04-02 07:22:43', 12, 3, 2, 32, '2012021017', 1, 11, 17, NULL, '2012021017', NULL, NULL),
('2014-04-02 07:22:43', 13, 3, 2, 33, '2012021017', 1, 11, 17, NULL, '2012021017', NULL, NULL),
('2014-04-02 07:22:43', 14, 3, 2, 34, '2012021017', 1, 11, 17, NULL, '2012021017', NULL, NULL),
('2014-04-02 07:22:43', 15, 3, 2, 35, '2012021017', 1, 11, 17, NULL, '2012021017', NULL, NULL),
('2014-04-02 07:22:43', 16, 3, 2, 36, '2012021017', 1, 11, 17, NULL, '2012021017', NULL, NULL),
('2014-04-02 07:22:43', 17, 3, 2, 37, '2012021017', 1, 11, 17, NULL, '2012021017', NULL, NULL),
('2014-04-02 07:22:43', 18, 3, 2, 38, '2012021017', 1, 11, 17, NULL, '2012021017', NULL, NULL),
('2014-04-02 07:22:43', 19, 3, 2, 39, '2012021017', 1, 11, 17, NULL, '2012021017', NULL, NULL),
('2014-04-02 07:22:43', 20, 3, 2, 40, '2012021017', 1, 11, 17, NULL, '2012021017', NULL, NULL),
('2014-04-02 07:22:43', 21, 3, 2, 41, '2012021017', 1, 11, 17, NULL, '2012021017', NULL, NULL),
('2014-04-02 07:22:43', 22, 3, 2, 42, '2012021017', 1, 11, 17, NULL, '2012021017', NULL, NULL),
('2014-04-02 07:22:43', 23, 3, 2, 43, '2012021017', 1, NULL, NULL, 'sdfsdf', '2012021017', NULL, NULL),
('2014-04-02 07:22:43', 24, 3, 2, 44, '2012021017', 1, NULL, NULL, 'dsfsdf', '2012021017', NULL, NULL);

-- --------------------------------------------------------

--
-- Stand-in structure for view `jawaban_edom`
--
CREATE TABLE IF NOT EXISTS `jawaban_edom` (
`TahunID` varchar(255)
,`KRSID` varchar(255)
,`KodeID` varchar(255)
,`KHSID` varchar(255)
,`JadwalID` varchar(255)
,`DosenID` varchar(255)
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
-- Stand-in structure for view `jawaban_edom2`
--
CREATE TABLE IF NOT EXISTS `jawaban_edom2` (
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
-- Stand-in structure for view `jawaban_edom3`
--
CREATE TABLE IF NOT EXISTS `jawaban_edom3` (
`TahunID` varchar(255)
,`KRSID` varchar(255)
,`KodeID` varchar(255)
,`KHSID` varchar(255)
,`JadwalID` varchar(255)
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
-- Table structure for table `jawaban_edom_20131`
--

CREATE TABLE IF NOT EXISTS `jawaban_edom_20131` (
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
  `custom_data` text NOT NULL,
  `custom_data2` text,
  `custom_data3` text,
  PRIMARY KEY (`id_jawaban`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=59 ;

--
-- Dumping data for table `jawaban_edom_20131`
--

INSERT INTO `jawaban_edom_20131` (`created_at`, `id_jawaban`, `id_periode`, `id_kuesioner`, `id_pertanyaan`, `respondent_id`, `respon_ke`, `jawaban_pilihan`, `jawaban_pilihan2`, `jawaban_isian`, `custom_data`, `custom_data2`, `custom_data3`) VALUES
('2014-04-03 09:22:04', 1, 9, 1, 1, '2012021017', 1, 5, NULL, NULL, '20131&&4704&&SISFO&&782&&224&&08.1110.007', '1', 'UAS'),
('2014-04-03 09:22:04', 2, 9, 1, 2, '2012021017', 1, 5, NULL, NULL, '20131&&4704&&SISFO&&782&&224&&08.1110.007', '1', 'UAS'),
('2014-04-03 09:22:04', 3, 9, 1, 3, '2012021017', 1, 5, NULL, NULL, '20131&&4704&&SISFO&&782&&224&&08.1110.007', '1', 'UAS'),
('2014-04-03 09:22:04', 4, 9, 1, 4, '2012021017', 1, 5, NULL, NULL, '20131&&4704&&SISFO&&782&&224&&08.1110.007', '1', 'UAS'),
('2014-04-03 09:22:04', 5, 9, 1, 5, '2012021017', 1, 5, NULL, NULL, '20131&&4704&&SISFO&&782&&224&&08.1110.007', '1', 'UAS'),
('2014-04-03 09:22:04', 6, 9, 1, 6, '2012021017', 1, 5, NULL, NULL, '20131&&4704&&SISFO&&782&&224&&08.1110.007', '1', 'UAS'),
('2014-04-03 09:22:04', 7, 9, 1, 7, '2012021017', 1, 5, NULL, NULL, '20131&&4704&&SISFO&&782&&224&&08.1110.007', '1', 'UAS'),
('2014-04-03 09:22:04', 8, 9, 1, 8, '2012021017', 1, 5, NULL, NULL, '20131&&4704&&SISFO&&782&&224&&08.1110.007', '1', 'UAS'),
('2014-04-03 09:22:04', 9, 9, 1, 9, '2012021017', 1, 5, NULL, NULL, '20131&&4704&&SISFO&&782&&224&&08.1110.007', '1', 'UAS'),
('2014-04-03 09:22:04', 10, 9, 1, 10, '2012021017', 1, 5, NULL, NULL, '20131&&4704&&SISFO&&782&&224&&08.1110.007', '1', 'UAS'),
('2014-04-03 09:22:04', 11, 9, 1, 11, '2012021017', 1, 5, NULL, NULL, '20131&&4704&&SISFO&&782&&224&&08.1110.007', '1', 'UAS'),
('2014-04-03 09:22:04', 12, 9, 1, 12, '2012021017', 1, 5, NULL, NULL, '20131&&4704&&SISFO&&782&&224&&08.1110.007', '1', 'UAS'),
('2014-04-03 09:22:04', 13, 9, 1, 13, '2012021017', 1, 5, NULL, NULL, '20131&&4704&&SISFO&&782&&224&&08.1110.007', '1', 'UAS'),
('2014-04-03 09:22:04', 14, 9, 1, 14, '2012021017', 1, 5, NULL, NULL, '20131&&4704&&SISFO&&782&&224&&08.1110.007', '1', 'UAS'),
('2014-04-03 09:22:04', 15, 9, 1, 15, '2012021017', 1, 5, NULL, NULL, '20131&&4704&&SISFO&&782&&224&&08.1110.007', '1', 'UAS'),
('2014-04-03 09:22:04', 16, 9, 1, 16, '2012021017', 1, 5, NULL, NULL, '20131&&4704&&SISFO&&782&&224&&08.1110.007', '1', 'UAS'),
('2014-04-03 09:22:04', 17, 9, 1, 17, '2012021017', 1, 5, NULL, NULL, '20131&&4704&&SISFO&&782&&224&&08.1110.007', '1', 'UAS'),
('2014-04-03 09:22:04', 18, 9, 1, 18, '2012021017', 1, 5, NULL, NULL, '20131&&4704&&SISFO&&782&&224&&08.1110.007', '1', 'UAS'),
('2014-04-03 09:22:04', 19, 9, 1, 19, '2012021017', 1, 5, NULL, NULL, '20131&&4704&&SISFO&&782&&224&&08.1110.007', '1', 'UAS'),
('2014-04-03 09:22:04', 20, 9, 1, 20, '2012021017', 1, NULL, NULL, 'teruskan saja', '20131&&4704&&SISFO&&782&&224&&08.1110.007', '1', 'UAS'),
('2014-04-03 09:24:18', 21, 9, 1, 1, '2012021017', 1, 5, NULL, NULL, '20131&&4707&&SISFO&&782&&227&&08.0711.022', '1', 'UAS'),
('2014-04-03 09:24:18', 22, 9, 1, 2, '2012021017', 1, 5, NULL, NULL, '20131&&4707&&SISFO&&782&&227&&08.0711.022', '1', 'UAS'),
('2014-04-03 09:24:18', 23, 9, 1, 3, '2012021017', 1, 5, NULL, NULL, '20131&&4707&&SISFO&&782&&227&&08.0711.022', '1', 'UAS'),
('2014-04-03 09:24:18', 24, 9, 1, 4, '2012021017', 1, 5, NULL, NULL, '20131&&4707&&SISFO&&782&&227&&08.0711.022', '1', 'UAS'),
('2014-04-03 09:24:18', 25, 9, 1, 5, '2012021017', 1, 5, NULL, NULL, '20131&&4707&&SISFO&&782&&227&&08.0711.022', '1', 'UAS'),
('2014-04-03 09:24:18', 26, 9, 1, 6, '2012021017', 1, 5, NULL, NULL, '20131&&4707&&SISFO&&782&&227&&08.0711.022', '1', 'UAS'),
('2014-04-03 09:24:18', 27, 9, 1, 7, '2012021017', 1, 5, NULL, NULL, '20131&&4707&&SISFO&&782&&227&&08.0711.022', '1', 'UAS'),
('2014-04-03 09:24:18', 28, 9, 1, 8, '2012021017', 1, 5, NULL, NULL, '20131&&4707&&SISFO&&782&&227&&08.0711.022', '1', 'UAS'),
('2014-04-03 09:24:18', 29, 9, 1, 9, '2012021017', 1, 5, NULL, NULL, '20131&&4707&&SISFO&&782&&227&&08.0711.022', '1', 'UAS'),
('2014-04-03 09:24:18', 30, 9, 1, 10, '2012021017', 1, 5, NULL, NULL, '20131&&4707&&SISFO&&782&&227&&08.0711.022', '1', 'UAS'),
('2014-04-03 09:24:18', 31, 9, 1, 11, '2012021017', 1, 5, NULL, NULL, '20131&&4707&&SISFO&&782&&227&&08.0711.022', '1', 'UAS'),
('2014-04-03 09:24:18', 32, 9, 1, 12, '2012021017', 1, 5, NULL, NULL, '20131&&4707&&SISFO&&782&&227&&08.0711.022', '1', 'UAS'),
('2014-04-03 09:24:18', 33, 9, 1, 13, '2012021017', 1, 5, NULL, NULL, '20131&&4707&&SISFO&&782&&227&&08.0711.022', '1', 'UAS'),
('2014-04-03 09:24:18', 34, 9, 1, 14, '2012021017', 1, 5, NULL, NULL, '20131&&4707&&SISFO&&782&&227&&08.0711.022', '1', 'UAS'),
('2014-04-03 09:24:18', 35, 9, 1, 15, '2012021017', 1, 5, NULL, NULL, '20131&&4707&&SISFO&&782&&227&&08.0711.022', '1', 'UAS'),
('2014-04-03 09:24:18', 36, 9, 1, 16, '2012021017', 1, 5, NULL, NULL, '20131&&4707&&SISFO&&782&&227&&08.0711.022', '1', 'UAS'),
('2014-04-03 09:24:18', 37, 9, 1, 17, '2012021017', 1, 5, NULL, NULL, '20131&&4707&&SISFO&&782&&227&&08.0711.022', '1', 'UAS'),
('2014-04-03 09:24:18', 38, 9, 1, 18, '2012021017', 1, 5, NULL, NULL, '20131&&4707&&SISFO&&782&&227&&08.0711.022', '1', 'UAS'),
('2014-04-03 09:24:18', 39, 9, 1, 19, '2012021017', 1, 5, NULL, NULL, '20131&&4707&&SISFO&&782&&227&&08.0711.022', '1', 'UAS'),
('2014-04-03 09:24:31', 40, 9, 1, 1, '2012021017', 1, 5, NULL, NULL, '20131&&4708&&SISFO&&782&&228&&DTT038', '1', 'UAS'),
('2014-04-03 09:24:31', 41, 9, 1, 2, '2012021017', 1, 5, NULL, NULL, '20131&&4708&&SISFO&&782&&228&&DTT038', '1', 'UAS'),
('2014-04-03 09:24:31', 42, 9, 1, 3, '2012021017', 1, 5, NULL, NULL, '20131&&4708&&SISFO&&782&&228&&DTT038', '1', 'UAS'),
('2014-04-03 09:24:31', 43, 9, 1, 4, '2012021017', 1, 5, NULL, NULL, '20131&&4708&&SISFO&&782&&228&&DTT038', '1', 'UAS'),
('2014-04-03 09:24:31', 44, 9, 1, 5, '2012021017', 1, 5, NULL, NULL, '20131&&4708&&SISFO&&782&&228&&DTT038', '1', 'UAS'),
('2014-04-03 09:24:31', 45, 9, 1, 6, '2012021017', 1, 5, NULL, NULL, '20131&&4708&&SISFO&&782&&228&&DTT038', '1', 'UAS'),
('2014-04-03 09:24:31', 46, 9, 1, 7, '2012021017', 1, 5, NULL, NULL, '20131&&4708&&SISFO&&782&&228&&DTT038', '1', 'UAS'),
('2014-04-03 09:24:31', 47, 9, 1, 8, '2012021017', 1, 5, NULL, NULL, '20131&&4708&&SISFO&&782&&228&&DTT038', '1', 'UAS'),
('2014-04-03 09:24:31', 48, 9, 1, 9, '2012021017', 1, 5, NULL, NULL, '20131&&4708&&SISFO&&782&&228&&DTT038', '1', 'UAS'),
('2014-04-03 09:24:31', 49, 9, 1, 10, '2012021017', 1, 5, NULL, NULL, '20131&&4708&&SISFO&&782&&228&&DTT038', '1', 'UAS'),
('2014-04-03 09:24:31', 50, 9, 1, 11, '2012021017', 1, 5, NULL, NULL, '20131&&4708&&SISFO&&782&&228&&DTT038', '1', 'UAS'),
('2014-04-03 09:24:31', 51, 9, 1, 12, '2012021017', 1, 5, NULL, NULL, '20131&&4708&&SISFO&&782&&228&&DTT038', '1', 'UAS'),
('2014-04-03 09:24:31', 52, 9, 1, 13, '2012021017', 1, 5, NULL, NULL, '20131&&4708&&SISFO&&782&&228&&DTT038', '1', 'UAS'),
('2014-04-03 09:24:31', 53, 9, 1, 14, '2012021017', 1, 5, NULL, NULL, '20131&&4708&&SISFO&&782&&228&&DTT038', '1', 'UAS'),
('2014-04-03 09:24:31', 54, 9, 1, 15, '2012021017', 1, 5, NULL, NULL, '20131&&4708&&SISFO&&782&&228&&DTT038', '1', 'UAS'),
('2014-04-03 09:24:31', 55, 9, 1, 16, '2012021017', 1, 5, NULL, NULL, '20131&&4708&&SISFO&&782&&228&&DTT038', '1', 'UAS'),
('2014-04-03 09:24:31', 56, 9, 1, 17, '2012021017', 1, 5, NULL, NULL, '20131&&4708&&SISFO&&782&&228&&DTT038', '1', 'UAS'),
('2014-04-03 09:24:31', 57, 9, 1, 18, '2012021017', 1, 5, NULL, NULL, '20131&&4708&&SISFO&&782&&228&&DTT038', '1', 'UAS'),
('2014-04-03 09:24:31', 58, 9, 1, 19, '2012021017', 1, 5, NULL, NULL, '20131&&4708&&SISFO&&782&&228&&DTT038', '1', 'UAS');

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
  `custom_data` text NOT NULL,
  `custom_data2` text,
  `custom_data3` text,
  PRIMARY KEY (`id_jawaban_header`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=17 ;

--
-- Dumping data for table `jawaban_header`
--

INSERT INTO `jawaban_header` (`created_at`, `id_jawaban_header`, `id_periode`, `id_kuesioner`, `respondent_id`, `respon_ke`, `custom_data`, `custom_data2`, `custom_data3`) VALUES
('2014-04-02 07:54:22', 16, 3, 2, '2012021017', 1, '2012021017', NULL, NULL);

-- --------------------------------------------------------

--
-- Stand-in structure for view `jawaban_header_edom`
--
CREATE TABLE IF NOT EXISTS `jawaban_header_edom` (
`TahunID` varchar(255)
,`KRSID` varchar(255)
,`KodeID` varchar(255)
,`KHSID` varchar(255)
,`JadwalID` varchar(255)
,`DosenID` varchar(255)
,`id_periode` bigint(20) unsigned
,`id_kuesioner` bigint(20) unsigned
,`respondent_id` varchar(100)
,`respon_ke` tinyint(4)
,`created_at` timestamp
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `jawaban_header_edom2`
--
CREATE TABLE IF NOT EXISTS `jawaban_header_edom2` (
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
,`JadwalID` varchar(255)
,`HariID` varchar(255)
,`Hari` varchar(255)
,`JamMulai` varchar(255)
,`JamSelesai` varchar(255)
,`RuangID` varchar(255)
,`TahunID` varchar(255)
,`id_periode` bigint(20) unsigned
,`id_kuesioner` bigint(20) unsigned
,`respondent_id` varchar(100)
,`respon_ke` tinyint(4)
,`created_at` timestamp
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `jawaban_header_edom3`
--
CREATE TABLE IF NOT EXISTS `jawaban_header_edom3` (
`TahunID` varchar(255)
,`KRSID` varchar(255)
,`KodeID` varchar(255)
,`KHSID` varchar(255)
,`JadwalID` varchar(255)
,`id_periode` bigint(20) unsigned
,`id_kuesioner` bigint(20) unsigned
,`respondent_id` varchar(100)
,`respon_ke` tinyint(4)
,`created_at` timestamp
);
-- --------------------------------------------------------

--
-- Table structure for table `jawaban_header_edom_20131`
--

CREATE TABLE IF NOT EXISTS `jawaban_header_edom_20131` (
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_jawaban_header` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_periode` bigint(20) unsigned NOT NULL,
  `id_kuesioner` bigint(20) unsigned NOT NULL,
  `respondent_id` varchar(100) NOT NULL,
  `respon_ke` tinyint(4) NOT NULL,
  `custom_data` text NOT NULL,
  `custom_data2` text,
  `custom_data3` text,
  PRIMARY KEY (`id_jawaban_header`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `jawaban_header_edom_20131`
--

INSERT INTO `jawaban_header_edom_20131` (`created_at`, `id_jawaban_header`, `id_periode`, `id_kuesioner`, `respondent_id`, `respon_ke`, `custom_data`, `custom_data2`, `custom_data3`) VALUES
('2014-04-03 09:22:04', 1, 9, 1, '2012021017', 1, '20131&&4704&&SISFO&&782&&224&&08.1110.007', '1', 'UAS'),
('2014-04-03 09:24:18', 2, 9, 1, '2012021017', 1, '20131&&4707&&SISFO&&782&&227&&08.0711.022', '1', 'UAS'),
('2014-04-03 09:24:31', 3, 9, 1, '2012021017', 1, '20131&&4708&&SISFO&&782&&228&&DTT038', '1', 'UAS');

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
(1, 'dflt_pilihan=5', 'Evaluasi Dosen Oleh Mahasiswa (EDOM) versi Jan-2014', 'EDOM', '<table>\n<tr><td class="width-set4" style="font-size:150%; text-align: center; padding-bottom:.5em;"><b>LEMBAR EVALUASI DOSEN OLEH MAHASISWA</b></td></tr>\n<tr><td style="text-align:justify;">Untuk meningkatkan kualitas pengajaran dan kualitas akademik, harap melengkapi lembar evaluasi ini secara jujur, obyektif dan penuh tanggung jawab. Informasi yang Saudara berikan hanya digunakan dalam proses evaluasi dosen dan tidak akan berpengaruh terhadap status Saudara sebagai mahasiswa.</td></tr>\n<tr><td style="padding-top:.5em;"><span style="width:115px; display:inline-block;">Nama Dosen</span>: {DosenNama}</td></tr>\n<tr><td><span style="width:115px; display:inline-block;">Mata Kuliah</span>: {MKNama}</td>\n<tr><td style="padding-bottom:.5em;"><span style="width:115px; display:inline-block;">Tahun Akademik</span>: {TahunID}</td></tr>\n<tr><td style="font-size:90%; text-align:justify; padding-bottom:1em;">Skor Penilaian : 1 = Sangat tidak baik, 2 = Tidak baik, 3 = Agak baik, 4 = Cukup baik, 5 = Baik, 6 = Sangat baik.</td></tr>\n</table>\n\n<table class="bordered">\n<tr class="centered"><td class="width-set2" rowspan="2"></td><td rowspan="2"><b>Aspek Yang Dinilai</b></td><td colspan="6"><b>Skor Penilaian</b></td></tr>\n<tr class="centered"><td><b>1</b></td><td><b>2</b></td><td><b>3</b></td><td><b>4</b></td><td><b>5</b></td><td><b>6</b></td></tr>\n<!--</table>-->'),
(2, 'dflt_pilihan=5;dflt_pilihan2=5', 'Kepuasan Mahasiswa versi Jan-2014', 'EDOM', '');

-- --------------------------------------------------------

--
-- Table structure for table `master_pertanyaan`
--

CREATE TABLE IF NOT EXISTS `master_pertanyaan` (
  `id_pertanyaan` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order` int(11) NOT NULL DEFAULT '1',
  `id_kuesioner` bigint(20) unsigned NOT NULL,
  `isi` text NOT NULL,
  `tipe` enum('pilihan','isian') NOT NULL,
  `is_mandatory` tinyint(1) NOT NULL DEFAULT '0',
  `id_kategori` bigint(20) unsigned DEFAULT NULL,
  `id_grup_pilihan` bigint(20) unsigned DEFAULT NULL,
  `id_grup_pilihan2` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_pertanyaan`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=45 ;

--
-- Dumping data for table `master_pertanyaan`
--

INSERT INTO `master_pertanyaan` (`id_pertanyaan`, `order`, `id_kuesioner`, `isi`, `tipe`, `is_mandatory`, `id_kategori`, `id_grup_pilihan`, `id_grup_pilihan2`) VALUES
(1, 1, 1, 'Kesiapan dosen dalam memberi perkuliahan/praktikum/praktek', 'pilihan', 1, NULL, 1, NULL),
(2, 1, 1, 'Kemampuan dosen menyampaikan materi', 'pilihan', 1, NULL, 1, NULL),
(3, 1, 1, 'Kemampuan dosen membangkitkan minat terhadap materi', 'pilihan', 1, NULL, 1, NULL),
(4, 1, 1, 'Pemanfaatan media dan teknologi pembelajaran dalam menjelaskan materi', 'pilihan', 1, NULL, 1, NULL),
(5, 1, 1, 'Keadilan penilaian terhadap mahasiswa', 'pilihan', 1, NULL, 1, NULL),
(6, 1, 1, 'Kemampuan dosen membimbing mahasiswa', 'pilihan', 1, NULL, 1, NULL),
(7, 1, 1, 'Kesesuaian materi yang disampaikan di kelas dengan silabus', 'pilihan', 1, NULL, 1, NULL),
(8, 1, 1, 'Keluasan wawasan keilmuan dosen pada bidang yang diajarkan', 'pilihan', 1, NULL, 1, NULL),
(9, 1, 1, 'Kemampuan menunjukkan keterkaitan antara bidang keahlian yang diajarkan', 'pilihan', 1, NULL, 1, NULL),
(10, 1, 1, 'Penguasaan akan isu-isu mutakhir dalam bidang yang diajarkan', 'pilihan', 1, NULL, 1, NULL),
(11, 1, 1, 'Keteraturan dan ketertiban dosen dalam mempersiapkan perkuliahan', 'pilihan', 1, NULL, 1, NULL),
(12, 1, 1, 'Bersikap santun dan menghargai orang lain', 'pilihan', 1, NULL, 1, NULL),
(13, 1, 1, 'Bersikap dan berperilaku yang positif', 'pilihan', 1, NULL, 1, NULL),
(14, 1, 1, 'Satunya kata dan tindakan', 'pilihan', 1, NULL, 1, NULL),
(15, 1, 1, 'Kemampuan dosen mengendalikan diri dalam berbagai situasi dan kondisi', 'pilihan', 1, NULL, 1, NULL),
(16, 1, 1, 'Semangat dan antusiasme dosen dalam mendidik', 'pilihan', 1, NULL, 1, NULL),
(17, 1, 1, 'Kemampuan dosen dalam menyampaikan pendapat', 'pilihan', 1, NULL, 1, NULL),
(18, 1, 1, 'Kemampuan dosen dalam menerima kritik, saran, dan pendapat mahasiswa', 'pilihan', 1, NULL, 1, NULL),
(19, 1, 1, 'Kemampuan dosen untuk bergaul di kalangan mahasiswa', 'pilihan', 1, NULL, 1, NULL),
(20, 1, 1, 'Saran untuk perbaikan', 'isian', 0, NULL, NULL, NULL),
(21, 1, 2, 'Kebersihan dan kerapian ruang kuliah', 'pilihan', 1, 2, 2, 3),
(22, 1, 2, 'Kelengkapan koleksi dan kenyamanan perpustakaan', 'pilihan', 1, 2, 2, 3),
(23, 1, 2, 'Ketersediaan laboratorium sesuai dengan keilmuan', 'pilihan', 1, 2, 2, 3),
(24, 1, 2, 'Laboratorium komputer yang memadai dan mudah diakses', 'pilihan', 1, 2, 2, 3),
(25, 1, 2, 'Kebersihan toilet', 'pilihan', 1, 2, 2, 3),
(26, 1, 2, 'Kebersihan fasilitas ibadah', 'pilihan', 1, 2, 2, 3),
(27, 1, 2, 'Tempat Parkir yang memadai, teratur, dan aman', 'pilihan', 1, 2, 2, 3),
(28, 1, 2, 'Kantin yang memadai dan aman', 'pilihan', 1, 2, 2, 3),
(29, 1, 2, 'Kemudahan akses kampus dengan kendaraan umum', 'pilihan', 1, 2, 2, 3),
(30, 1, 2, 'Staf akademik santun dalam melakukan pelayanan akademik', 'pilihan', 1, 3, 2, 3),
(31, 1, 2, 'Staf akademik mempunyai kemampuan untuk melayani kepentingan mahasiswa', 'pilihan', 1, 3, 2, 3),
(32, 1, 2, 'Staf akademik dapat menyelesaikan tugas/ pekerjaan sesuai janji', 'pilihan', 1, 3, 2, 3),
(33, 1, 2, 'Pelaksanaan ujian dilakukan tepat waktu', 'pilihan', 1, 4, 2, 3),
(34, 1, 2, 'Perkuliahan yang terjadwal baik dan sesuai dengan jadwal', 'pilihan', 1, 4, 2, 3),
(35, 1, 2, 'UPJ menyediakan bantuan (keringanan) bagi mahasiswa tidak mampu', 'pilihan', 1, 4, 2, 3),
(36, 1, 2, 'UPJ selalu membantu mahasiswa apabila menghadapi masalah akademik', 'pilihan', 1, 4, 2, 3),
(37, 1, 2, 'UPJ menyediakan waktu bagi orang tua mahasiswa', 'pilihan', 1, 4, 2, 3),
(38, 1, 2, 'Permasalahan/keluhan mahasiswa selalu ditangani UPJ melalui dosen pembimbing', 'pilihan', 1, 5, 2, 3),
(39, 1, 2, 'Waktu digunakan efektif oleh dosen dalam mengajar', 'pilihan', 1, 5, 2, 3),
(40, 1, 2, 'Adanya sanksi bagi mahasiswa yang melangar peraturan yang ditetapkan', 'pilihan', 1, 5, 2, 3),
(41, 1, 2, 'UPJ selalu berusaha untuk memahami kepentingan dan kesulitan mahasiswa', 'pilihan', 1, 5, 2, 3),
(42, 1, 2, 'UPJ berusaha memahami minat dan bakat mahasiswa dan berusaha  untuk mengembangkannya', 'pilihan', 1, 5, 2, 3),
(43, 1, 2, 'Respon terbuka kepuasan mahasiswa terhadap pelayanan akademik UPJ', 'isian', 1, 0, NULL, NULL),
(44, 1, 2, 'Harapan mahasiswa terhadap pelayanan dan fasilitas kampus UPJ di masa mendatang', 'isian', 1, 0, NULL, NULL);

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
  `deskripsi_detail` text NOT NULL COMMENT 'deskripsi tambahan (hanya di database)',
  `waktu_min` timestamp NULL DEFAULT NULL,
  `waktu_maks` timestamp NULL DEFAULT NULL,
  `respondent_id` varchar(25) NOT NULL COMMENT 'nama fungsi untuk mendapatkan respondent_id',
  `generator_config` text NOT NULL COMMENT 'database dan query untuk membuat list kuesioner yang harus diisi',
  `separator` varchar(5) NOT NULL DEFAULT '&&' COMMENT 'separator data pada custom_data & data_helper',
  `custom_data_format` text NOT NULL COMMENT 'digunakan untuk membandingkan apakah kuesioner sudah diisi atau tidak dan untuk perhitungan respon_ke',
  `custom_data2_format` text COMMENT 'digunakan untuk membandingkan apakah kuesioner sudah diisi atau tidak, tapi tidak untuk perhitungan respon_ke',
  `custom_data3_format` text COMMENT 'tidak digunakan untuk membandingkan apakah kuesioner sudah diisi atau tidak, serta untuk data dari koding bisa diset dengan field {[config(kuesioner_ftisfc)][nama]} (awalnya {_CODE_SET_[nama]}) dengan nama variable yang sama',
  `data_helper` varchar(255) DEFAULT NULL COMMENT 'data yang dapat digunakan dalam koding (nama variable sama dengan nama fieldnya)',
  `tabel_jawaban` varchar(50) NOT NULL DEFAULT 'jawaban' COMMENT 'nama tabel untuk menyimpan jawaban',
  `tabel_jawaban_header` varchar(100) NOT NULL DEFAULT 'jawaban_header',
  PRIMARY KEY (`id_periode`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `periode`
--

INSERT INTO `periode` (`id_periode`, `id_kuesioner`, `deskripsi`, `deskripsi_detail`, `waktu_min`, `waktu_maks`, `respondent_id`, `generator_config`, `separator`, `custom_data_format`, `custom_data2_format`, `custom_data3_format`, `data_helper`, `tabel_jawaban`, `tabel_jawaban_header`) VALUES
(1, 1, 'EDOM 2013/2014 Mata Kuliah {Nama_MK}', 'EDOM 2013/2014 Ganjil (UTS) Mata Kuliah {Nama_MK}', '2014-02-24 17:00:00', '2014-03-01 17:00:00', 'sisfo_get_username()', 'db="sisfo";sql="SELECT k.MKID AS MKID, k.MKKode AS MKKode, k.Nama AS Nama_MK, j.DosenID AS DosenID, d.Nama AS Nama_Dosen, mk.Sesi AS Sesi\nFROM krs k\nLEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID\nLEFT OUTER JOIN dosen d ON j.DosenID = d.Login\nLEFT OUTER JOIN mk mk ON k.MKID = mk.MKID\nWHERE k.MhswID = ''{respondent_id}'' AND k.TahunID = ''20131''"', '&&', '{MKID};{MKKode};{Nama_MK};{Sesi};{DosenID};{Nama_Dosen};20132', '', NULL, '', 'jawaban', 'jawaban_header'),
(2, 2, 'Survey Kepuasan Mahasiswa 2013/2014', 'Survey Kepuasan Mahasiswa 2013/2014 Genap', '2014-02-24 17:00:00', '2014-04-01 17:00:00', 'sisfo_get_username()', 'db="sisfo";sql="SELECT m.MhswID FROM mhsw m WHERE m.Login = ''{respondent_id}''"', '&&', '', '', NULL, '', 'jawaban', 'jawaban_header'),
(3, 2, 'Survey Kepuasan Mahasiswa 2014/2015</td><td>', 'Survey Kepuasan Mahasiswa 2014/2015 Ganjil', '2014-02-24 17:00:00', '2014-04-02 17:00:00', 'sisfo_get_username()', 'db="sisfo";sql="SELECT m.MhswID FROM mhsw m WHERE m.Login = ''{respondent_id}''"', '&&', '{MhswID}', NULL, NULL, NULL, 'jawaban_edom_20131', 'jawaban_header_edom_20131'),
(4, 1, '{Nama_MK}</td><td>{Nama_Dosen}', 'EDOM 2013/2014 Genap (UTS) Mata Kuliah {Nama_MK} Oleh {Nama_Dosen}', '2014-03-03 17:00:00', '2014-03-18 17:00:00', 'sisfo_get_username()', 'db="sisfo";sql="SELECT *\nFROM (\nSELECT m.ProdiID AS mhsw_ProdiID, p.Nama AS mhsw_Nama_Prodi, p.Nama_en AS mhsw_Nama_Prodi_en, m.ProgramID AS mhsw_ProgramID, pr.Nama AS mhsw_Nama_Program, k.KRSID,\nk.MKID AS MKID, mk.Sesi AS Sesi, k.MKKode AS MKKode, k.Nama AS Nama_MK, j.DosenID AS DosenID, d.Nama AS Nama_Dosen, d.Homebase AS Homebase,\n1 AS order_no, -1 AS is_same, 20131 AS tahun, k.JadwalID AS JadwalID\nFROM krs k\nLEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID\nLEFT OUTER JOIN dosen d ON j.DosenID = d.Login\nLEFT OUTER JOIN mk mk ON k.MKID = mk.MKID\nLEFT OUTER JOIN mhsw m ON k.MhswID = m.MhswID\nLEFT OUTER JOIN prodi p ON m.ProdiID = p.ProdiID\nLEFT OUTER JOIN program pr ON m.ProgramID = pr.ProgramID\nWHERE k.MhswID = ''{respondent_id}'' AND k.TahunID = ''20131'' AND j.NA = ''N''\nUNION\nSELECT m.ProdiID AS mhsw_ProdiID, p.Nama AS mhsw_Nama_Prodi, p.Nama_en AS mhsw_Nama_Prodi_en, m.ProgramID AS mhsw_ProgramID, pr.Nama AS mhsw_Nama_Program, k.KRSID,\nk.MKID AS MKID, mk.Sesi AS Sesi, k.MKKode AS MKKode, k.Nama AS Nama_MK, IF(ISNULL(jd.DosenID), j.DosenID, jd.DosenID) AS DosenID, IF(ISNULL(jd.DosenID), d.Nama, dsn.Nama) AS Nama_Dosen, IF(ISNULL(jd.DosenID), d.Homebase, dsn.Homebase) AS Homebase,\n2 AS order_no, IF(ISNULL(jd.DosenID), 1, 0) AS is_same, 20131 AS tahun, k.JadwalID AS JadwalID\nFROM krs k\nLEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID\nLEFT OUTER JOIN dosen d ON j.DosenID = d.Login\nLEFT OUTER JOIN mk mk ON k.MKID = mk.MKID\nLEFT OUTER JOIN jadwaldosen jd ON k.JadwalID = jd.JadwalID\nLEFT OUTER JOIN dosen dsn ON jd.DosenID = dsn.Login\nLEFT OUTER JOIN mhsw m ON k.MhswID = m.MhswID\nLEFT OUTER JOIN prodi p ON m.ProdiID = p.ProdiID\nLEFT OUTER JOIN program pr ON m.ProgramID = pr.ProgramID\nWHERE k.MhswID = ''{respondent_id}'' AND k.TahunID = ''20131'' AND j.NA = ''N''\n) aa\nORDER BY aa.MKKode, aa.Nama_MK, aa.order_no, aa.Nama_Dosen;"', '&&', '{mhsw_ProdiID};{mhsw_Nama_Prodi};{mhsw_Nama_Prodi_en};{mhsw_ProgramID};{mhsw_Nama_Program};{KRSID};{MKID};{Sesi};{MKKode};{Nama_MK};{DosenID};{Nama_Dosen};{Homebase};{order_no};{tahun};{JadwalID}', '', NULL, '{is_same}', 'jawaban', 'jawaban_header'),
(5, 1, '{Nama_MK}</td><td>{Nama_Dosen}', 'EDOM BARU SEPARATOR LAMA', '2014-03-18 17:00:00', '2014-03-19 16:59:59', 'sisfo_get_username()', 'db="sisfo";sql="SELECT *\nFROM (\nSELECT 1 AS order_no, -1 AS is_same, m.ProdiID AS mhsw_ProdiID, p.Nama AS mhsw_Nama_Prodi, p.Nama_en AS mhsw_Nama_Prodi_en, m.ProgramID AS mhsw_ProgramID, pr.Nama AS mhsw_Nama_Program, j.KodeID, k.KRSID,\nj.MKID AS MKID, j.ProdiID, mk.Sesi AS Sesi, j.MKKode AS MKKode, j.Nama AS Nama_MK, j.DosenID AS DosenID, d.Nama AS Nama_Dosen, d.Homebase AS Homebase,\nj.JadwalID AS JadwalID, j.HariID, h.Nama AS Hari, h.Nama_en AS Hari_en, j.JamMulai, j.JamSelesai, j.RuangID, k.TahunID\nFROM krs k\nLEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID\nLEFT OUTER JOIN dosen d ON j.DosenID = d.Login\nLEFT OUTER JOIN mk mk ON k.MKID = mk.MKID\nLEFT OUTER JOIN mhsw m ON k.MhswID = m.MhswID\nLEFT OUTER JOIN prodi p ON m.ProdiID = p.ProdiID\nLEFT OUTER JOIN program pr ON m.ProgramID = pr.ProgramID\nLEFT OUTER JOIN hari h ON j.HariID = h.HariID\nWHERE k.MhswID = ''{respondent_id}'' AND k.TahunID = ''20131'' AND k.NA = ''N''\nUNION\nSELECT 2 AS order_no, IF(ISNULL(jd.DosenID), 1, 0) AS is_same, m.ProdiID AS mhsw_ProdiID, p.Nama AS mhsw_Nama_Prodi, p.Nama_en AS mhsw_Nama_Prodi_en, m.ProgramID AS mhsw_ProgramID, pr.Nama AS mhsw_Nama_Program, j.KodeID, k.KRSID,\nj.MKID AS MKID, j.ProdiID, mk.Sesi AS Sesi, j.MKKode AS MKKode, j.Nama AS Nama_MK, IF(ISNULL(jd.DosenID), j.DosenID, jd.DosenID) AS DosenID, IF(ISNULL(jd.DosenID), d.Nama, dsn.Nama) AS Nama_Dosen, IF(ISNULL(jd.DosenID), d.Homebase, dsn.Homebase) AS Homebase,\nj.JadwalID AS JadwalID, j.HariID, h.Nama AS Hari, h.Nama_en AS Hari_en, j.JamMulai, j.JamSelesai, j.RuangID, k.TahunID\nFROM krs k\nLEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID\nLEFT OUTER JOIN dosen d ON j.DosenID = d.Login\nLEFT OUTER JOIN mk mk ON k.MKID = mk.MKID\nLEFT OUTER JOIN jadwaldosen jd ON k.JadwalID = jd.JadwalID\nLEFT OUTER JOIN dosen dsn ON jd.DosenID = dsn.Login\nLEFT OUTER JOIN mhsw m ON k.MhswID = m.MhswID\nLEFT OUTER JOIN prodi p ON m.ProdiID = p.ProdiID\nLEFT OUTER JOIN program pr ON m.ProgramID = pr.ProgramID\nLEFT OUTER JOIN hari h ON j.HariID = h.HariID\nWHERE k.MhswID = ''{respondent_id}'' AND k.TahunID = ''20131'' AND k.NA = ''N''\n) aa\nORDER BY aa.MKKode, aa.Nama_MK, aa.order_no, aa.Nama_Dosen"', '&&', '{mhsw_ProdiID};{mhsw_Nama_Prodi};{mhsw_Nama_Prodi_en};{mhsw_ProgramID};{mhsw_Nama_Program};{KodeID};{KRSID};{MKID};{ProdiID};{Sesi};{MKKode};{Nama_MK};{DosenID};{Nama_Dosen};{Homebase};{order_no};{JadwalID};{HariID};{Hari};{Hari_en};{JamMulai};{JamSelesai};{RuangID};{TahunID}', '', NULL, '{is_same}', 'jawaban', 'jawaban_header'),
(6, 1, '{Nama_MK}</td><td>{Nama_Dosen}', 'EDOM BARU', '2014-03-18 17:00:00', '2014-03-23 16:59:59', 'sisfo_get_username()', 'db="sisfo";sql="SELECT *\nFROM (\nSELECT 1 AS order_no, -1 AS is_same, m.ProdiID AS mhsw_ProdiID, p.Nama AS mhsw_Nama_Prodi, p.Nama_en AS mhsw_Nama_Prodi_en, m.ProgramID AS mhsw_ProgramID, pr.Nama AS mhsw_Nama_Program, j.KodeID, k.KRSID,\nj.MKID AS MKID, j.ProdiID, mk.Sesi AS Sesi, j.MKKode AS MKKode, j.Nama AS Nama_MK, j.DosenID AS DosenID, d.Nama AS Nama_Dosen, d.Homebase AS Homebase,\nj.JadwalID AS JadwalID, j.HariID, h.Nama AS Hari, h.Nama_en AS Hari_en, j.JamMulai, j.JamSelesai, j.RuangID, k.TahunID\nFROM krs k\nLEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID\nLEFT OUTER JOIN dosen d ON j.DosenID = d.Login\nLEFT OUTER JOIN mk mk ON k.MKID = mk.MKID\nLEFT OUTER JOIN mhsw m ON k.MhswID = m.MhswID\nLEFT OUTER JOIN prodi p ON m.ProdiID = p.ProdiID\nLEFT OUTER JOIN program pr ON m.ProgramID = pr.ProgramID\nLEFT OUTER JOIN hari h ON j.HariID = h.HariID\nWHERE k.MhswID = ''{respondent_id}'' AND k.TahunID = ''20131'' AND k.NA = ''N'' AND k.JadwalID <> 0\nUNION\nSELECT 2 AS order_no, IF(ISNULL(jd.DosenID), 1, 0) AS is_same, m.ProdiID AS mhsw_ProdiID, p.Nama AS mhsw_Nama_Prodi, p.Nama_en AS mhsw_Nama_Prodi_en, m.ProgramID AS mhsw_ProgramID, pr.Nama AS mhsw_Nama_Program, j.KodeID, k.KRSID,\nj.MKID AS MKID, j.ProdiID, mk.Sesi AS Sesi, j.MKKode AS MKKode, j.Nama AS Nama_MK, IF(ISNULL(jd.DosenID), j.DosenID, jd.DosenID) AS DosenID, IF(ISNULL(jd.DosenID), d.Nama, dsn.Nama) AS Nama_Dosen, IF(ISNULL(jd.DosenID), d.Homebase, dsn.Homebase) AS Homebase,\nj.JadwalID AS JadwalID, j.HariID, h.Nama AS Hari, h.Nama_en AS Hari_en, j.JamMulai, j.JamSelesai, j.RuangID, k.TahunID\nFROM krs k\nLEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID\nLEFT OUTER JOIN dosen d ON j.DosenID = d.Login\nLEFT OUTER JOIN mk mk ON k.MKID = mk.MKID\nLEFT OUTER JOIN jadwaldosen jd ON k.JadwalID = jd.JadwalID\nLEFT OUTER JOIN dosen dsn ON jd.DosenID = dsn.Login\nLEFT OUTER JOIN mhsw m ON k.MhswID = m.MhswID\nLEFT OUTER JOIN prodi p ON m.ProdiID = p.ProdiID\nLEFT OUTER JOIN program pr ON m.ProgramID = pr.ProgramID\nLEFT OUTER JOIN hari h ON j.HariID = h.HariID\nWHERE k.MhswID = ''{respondent_id}'' AND k.TahunID = ''20131'' AND k.NA = ''N'' AND k.JadwalID <> 0\n) aa\nORDER BY aa.MKKode, aa.Nama_MK, aa.order_no, aa.Nama_Dosen"', '&&', '{mhsw_ProdiID}&&{mhsw_Nama_Prodi}&&{mhsw_Nama_Prodi_en}&&{mhsw_ProgramID}&&{mhsw_Nama_Program}&&{KodeID}&&{KRSID}&&{MKID}&&{ProdiID}&&{Sesi}&&{MKKode}&&{Nama_MK}&&{DosenID}&&{Nama_Dosen}&&{Homebase}&&{order_no}&&{JadwalID}&&{HariID}&&{Hari}&&{Hari_en}&&{JamMulai}&&{JamSelesai}&&{RuangID}&&{TahunID}', '', NULL, '{is_same}', 'jawaban', 'jawaban_header'),
(7, 1, '{Nama_MK}<sup>{MKKode}</sup></td><td>{Nama_Dosen}', 'EDOM BARU LAGI', '2014-03-18 17:00:00', '2014-03-25 16:59:59', 'sisfo_get_username()', 'db="sisfo";sql="SELECT *\nFROM (\nSELECT 1 AS order_no, -1 AS is_same, m.ProdiID AS mhsw_ProdiID, p.Nama AS mhsw_Nama_Prodi, p.Nama_en AS mhsw_Nama_Prodi_en, m.ProgramID AS mhsw_ProgramID, pr.Nama AS mhsw_Nama_Program, j.KodeID, k.KRSID,\nj.MKID AS MKID, j.ProdiID, mk.Sesi AS Sesi, j.MKKode AS MKKode, j.Nama AS Nama_MK, j.DosenID AS DosenID, d.Nama AS Nama_Dosen, d.Homebase AS Homebase,\nj.JadwalID AS JadwalID, j.HariID, h.Nama AS Hari, h.Nama_en AS Hari_en, j.JamMulai, j.JamSelesai, j.RuangID, k.TahunID\nFROM krs k\nLEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID\nLEFT OUTER JOIN dosen d ON j.DosenID = d.Login\nLEFT OUTER JOIN mk mk ON k.MKID = mk.MKID\nLEFT OUTER JOIN mhsw m ON k.MhswID = m.MhswID\nLEFT OUTER JOIN prodi p ON m.ProdiID = p.ProdiID\nLEFT OUTER JOIN program pr ON m.ProgramID = pr.ProgramID\nLEFT OUTER JOIN hari h ON j.HariID = h.HariID\nWHERE k.MhswID = ''{respondent_id}'' AND k.TahunID = ''20131'' AND k.NA = ''N'' AND k.JadwalID <> 0\nUNION\nSELECT 2 AS order_no, IF(ISNULL(jd.DosenID), 1, 0) AS is_same, m.ProdiID AS mhsw_ProdiID, p.Nama AS mhsw_Nama_Prodi, p.Nama_en AS mhsw_Nama_Prodi_en, m.ProgramID AS mhsw_ProgramID, pr.Nama AS mhsw_Nama_Program, j.KodeID, k.KRSID,\nj.MKID AS MKID, j.ProdiID, mk.Sesi AS Sesi, j.MKKode AS MKKode, j.Nama AS Nama_MK, IF(ISNULL(jd.DosenID), j.DosenID, jd.DosenID) AS DosenID, IF(ISNULL(jd.DosenID), d.Nama, dsn.Nama) AS Nama_Dosen, IF(ISNULL(jd.DosenID), d.Homebase, dsn.Homebase) AS Homebase,\nj.JadwalID AS JadwalID, j.HariID, h.Nama AS Hari, h.Nama_en AS Hari_en, j.JamMulai, j.JamSelesai, j.RuangID, k.TahunID\nFROM krs k\nLEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID\nLEFT OUTER JOIN dosen d ON j.DosenID = d.Login\nLEFT OUTER JOIN mk mk ON k.MKID = mk.MKID\nLEFT OUTER JOIN jadwaldosen jd ON k.JadwalID = jd.JadwalID\nLEFT OUTER JOIN dosen dsn ON jd.DosenID = dsn.Login\nLEFT OUTER JOIN mhsw m ON k.MhswID = m.MhswID\nLEFT OUTER JOIN prodi p ON m.ProdiID = p.ProdiID\nLEFT OUTER JOIN program pr ON m.ProgramID = pr.ProgramID\nLEFT OUTER JOIN hari h ON j.HariID = h.HariID\nWHERE k.MhswID = ''{respondent_id}'' AND k.TahunID = ''20131'' AND k.NA = ''N'' AND k.JadwalID <> 0\n) aa\nORDER BY aa.MKKode, aa.Nama_MK, aa.order_no, aa.Nama_Dosen"', '&&', '{mhsw_ProdiID}&&{mhsw_Nama_Prodi}&&{mhsw_Nama_Prodi_en}&&{mhsw_ProgramID}&&{mhsw_Nama_Program}&&{KodeID}&&{KRSID}&&{MKID}&&{ProdiID}&&{Sesi}&&{MKKode}&&{Nama_MK}&&{DosenID}&&{Nama_Dosen}&&{Homebase}&&{JadwalID}&&{HariID}&&{Hari}&&{Hari_en}&&{JamMulai}&&{JamSelesai}&&{RuangID}&&{TahunID}', '{order_no}', NULL, '{is_same}', 'jawaban', 'jawaban_header'),
(8, 1, '{Nama_MK}<sup>{MKKode}</sup></td><td>{Nama_Dosen}', '20132', '2014-03-18 17:00:00', '2014-04-01 16:59:59', 'sisfo_get_username()', 'db="sisfo";sql="SELECT *\nFROM (\nSELECT 1 AS order_no, -1 AS is_same, m.ProdiID AS mhsw_ProdiID, p.Nama AS mhsw_Nama_Prodi, p.Nama_en AS mhsw_Nama_Prodi_en, m.ProgramID AS mhsw_ProgramID, pr.Nama AS mhsw_Nama_Program, j.KodeID, k.KRSID,\nj.MKID AS MKID, j.ProdiID, mk.Sesi AS Sesi, UPPER(mk.MKKode) AS MKKode, UPPER(mk.Nama) AS Nama_MK, j.DosenID AS DosenID, d.Nama AS Nama_Dosen, d.Homebase AS Homebase,\nj.JadwalID AS JadwalID, j.HariID, h.Nama AS Hari, h.Nama_en AS Hari_en, j.JamMulai, j.JamSelesai, j.RuangID, k.TahunID\nFROM krs k\nLEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID\nLEFT OUTER JOIN dosen d ON j.DosenID = d.Login\nLEFT OUTER JOIN mk mk ON k.MKID = mk.MKID\nLEFT OUTER JOIN mhsw m ON k.MhswID = m.MhswID\nLEFT OUTER JOIN prodi p ON m.ProdiID = p.ProdiID\nLEFT OUTER JOIN program pr ON m.ProgramID = pr.ProgramID\nLEFT OUTER JOIN hari h ON j.HariID = h.HariID\nWHERE k.MhswID = ''{respondent_id}'' AND k.TahunID = ''20132'' AND k.NA = ''N'' AND k.JadwalID <> 0\nUNION\nSELECT 2 AS order_no, IF(ISNULL(jd.DosenID), 1, 0) AS is_same, m.ProdiID AS mhsw_ProdiID, p.Nama AS mhsw_Nama_Prodi, p.Nama_en AS mhsw_Nama_Prodi_en, m.ProgramID AS mhsw_ProgramID, pr.Nama AS mhsw_Nama_Program, j.KodeID, k.KRSID,\nj.MKID AS MKID, j.ProdiID, mk.Sesi AS Sesi, UPPER(mk.MKKode) AS MKKode, UPPER(mk.Nama) AS Nama_MK, IF(ISNULL(jd.DosenID), j.DosenID, jd.DosenID) AS DosenID, IF(ISNULL(jd.DosenID), d.Nama, dsn.Nama) AS Nama_Dosen, IF(ISNULL(jd.DosenID), d.Homebase, dsn.Homebase) AS Homebase,\nj.JadwalID AS JadwalID, j.HariID, h.Nama AS Hari, h.Nama_en AS Hari_en, j.JamMulai, j.JamSelesai, j.RuangID, k.TahunID\nFROM krs k\nLEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID\nLEFT OUTER JOIN dosen d ON j.DosenID = d.Login\nLEFT OUTER JOIN mk mk ON k.MKID = mk.MKID\nLEFT OUTER JOIN jadwaldosen jd ON k.JadwalID = jd.JadwalID\nLEFT OUTER JOIN dosen dsn ON jd.DosenID = dsn.Login\nLEFT OUTER JOIN mhsw m ON k.MhswID = m.MhswID\nLEFT OUTER JOIN prodi p ON m.ProdiID = p.ProdiID\nLEFT OUTER JOIN program pr ON m.ProgramID = pr.ProgramID\nLEFT OUTER JOIN hari h ON j.HariID = h.HariID\nWHERE k.MhswID = ''{respondent_id}'' AND k.TahunID = ''20132'' AND k.NA = ''N'' AND k.JadwalID <> 0\n) aa\nORDER BY aa.MKKode, aa.Nama_MK, aa.order_no, aa.Nama_Dosen"', '&&', '{mhsw_ProdiID}&&{mhsw_Nama_Prodi}&&{mhsw_Nama_Prodi_en}&&{mhsw_ProgramID}&&{mhsw_Nama_Program}&&{KodeID}&&{KRSID}&&{MKID}&&{ProdiID}&&{Sesi}&&{MKKode}&&{Nama_MK}&&{DosenID}&&{Nama_Dosen}&&{Homebase}&&{JadwalID}&&{HariID}&&{Hari}&&{Hari_en}&&{JamMulai}&&{JamSelesai}&&{RuangID}&&{TahunID}', '{order_no}', NULL, '{is_same}', 'jawaban', 'jawaban_header'),
(9, 1, '{MKNama}<sup>{MKKode}</sup></td><td>{DosenNama}', '20131', '2014-01-31 17:00:00', '2014-04-04 16:59:59', 'sisfo_get_username()', 'db="sisfo";sql="SELECT a.KRSID, a.KodeID, a.KHSID, a.MhswID, a.TahunID, a.JadwalID,\na.MKID,\na.DosenID, a.DosenNama AS DosenNama,\na.MKKode AS MKKode, a.MKNama AS MKNama, a.order_no, a.is_same\nFROM (\nSELECT k.KRSID, k.KodeID, k.KHSID, k.MhswID, k.TahunID, k.JadwalID,\nj.MKID,\nd.Login AS DosenID, d.Nama AS DosenNama,\nUPPER(mk.MKKode) AS MKKode, UPPER(mk.Nama) AS MKNama, 1 AS order_no, -1 AS is_same\nFROM krs k\nLEFT OUTER JOIN jadwal j ON (k.JadwalID = j.JadwalID AND k.KodeID = j.KodeID)\nLEFT OUTER JOIN dosen d ON (j.DosenID = d.Login AND k.KodeID = j.KodeID)\nLEFT OUTER JOIN mk mk ON (j.MKID = mk.MKID AND k.KodeID = j.KodeID)\nWHERE k.NA = ''N''\nAND k.JadwalID <> 0\nAND k.TahunID = ''20131''\nAND k.MhswID = ''{respondent_id}''\nUNION\nSELECT k.KRSID, k.KodeID, k.KHSID, k.MhswID, k.TahunID, k.JadwalID,\nj.MKID,\nIF(ISNULL(jd.DosenID), d.Login, jd.DosenID) AS DosenID, IF(ISNULL(jd.DosenID), d.Nama, dd.Nama) AS DosenNama,\nUPPER(mk.MKKode) AS MKKode, UPPER(mk.Nama) AS MKNama, 2 AS order_no, IF(ISNULL(jd.DosenID), 1, 0) AS is_same\nFROM krs k\nLEFT OUTER JOIN jadwal j ON (k.JadwalID = j.JadwalID AND k.KodeID = j.KodeID)\nLEFT OUTER JOIN dosen d ON (j.DosenID = d.Login AND k.KodeID = j.KodeID)\nLEFT OUTER JOIN mk mk ON (j.MKID = mk.MKID AND k.KodeID = j.KodeID)\nLEFT OUTER JOIN jadwaldosen jd ON k.JadwalID = jd.JadwalID\nLEFT OUTER JOIN dosen dd ON (jd.DosenID = dd.Login AND k.KodeID = dd.KodeID)\nWHERE k.NA = ''N''\nAND k.JadwalID <> 0\nAND k.TahunID = ''20131''\nAND k.MhswID = ''{respondent_id}''\n) a\nORDER BY a.MKNama, a.order_no, a.DosenNama"', '&&', '{TahunID}&&{KRSID}&&{KodeID}&&{KHSID}&&{JadwalID}&&{DosenID}', '{order_no}', '{_CODE_SET_utsatauuas}', '{is_same}&&{MKNama}&&{DosenNama}', 'jawaban_edom_20131', 'jawaban_header_edom_20131'),
(10, 1, '{Nama_MK}<sup>{MKKode}</sup></td><td>{Nama_Dosen}', '20132', '2014-03-18 17:00:00', '2014-04-02 16:59:59', 'sisfo_get_username()', 'db="sisfo";sql="SELECT *\nFROM (\nSELECT 1 AS order_no, -1 AS is_same, m.ProdiID AS mhsw_ProdiID, p.Nama AS mhsw_Nama_Prodi, p.Nama_en AS mhsw_Nama_Prodi_en, m.ProgramID AS mhsw_ProgramID, pr.Nama AS mhsw_Nama_Program, j.KodeID, k.KRSID,\nj.MKID AS MKID, j.ProdiID, mk.Sesi AS Sesi, UPPER(mk.MKKode) AS MKKode, UPPER(mk.Nama) AS Nama_MK, j.DosenID AS DosenID, d.Nama AS Nama_Dosen, d.Homebase AS Homebase,\nj.JadwalID AS JadwalID, j.HariID, h.Nama AS Hari, h.Nama_en AS Hari_en, j.JamMulai, j.JamSelesai, j.RuangID, k.TahunID, UPPER(mk.Nama) AS MKNama, d.Nama AS DosenNama\nFROM krs k\nLEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID\nLEFT OUTER JOIN dosen d ON j.DosenID = d.Login\nLEFT OUTER JOIN mk mk ON k.MKID = mk.MKID\nLEFT OUTER JOIN mhsw m ON k.MhswID = m.MhswID\nLEFT OUTER JOIN prodi p ON m.ProdiID = p.ProdiID\nLEFT OUTER JOIN program pr ON m.ProgramID = pr.ProgramID\nLEFT OUTER JOIN hari h ON j.HariID = h.HariID\nWHERE k.MhswID = ''{respondent_id}'' AND k.TahunID = ''20132'' AND k.NA = ''N'' AND k.JadwalID <> 0\nUNION\nSELECT 2 AS order_no, IF(ISNULL(jd.DosenID), 1, 0) AS is_same, m.ProdiID AS mhsw_ProdiID, p.Nama AS mhsw_Nama_Prodi, p.Nama_en AS mhsw_Nama_Prodi_en, m.ProgramID AS mhsw_ProgramID, pr.Nama AS mhsw_Nama_Program, j.KodeID, k.KRSID,\nj.MKID AS MKID, j.ProdiID, mk.Sesi AS Sesi, UPPER(mk.MKKode) AS MKKode, UPPER(mk.Nama) AS Nama_MK, IF(ISNULL(jd.DosenID), j.DosenID, jd.DosenID) AS DosenID, IF(ISNULL(jd.DosenID), d.Nama, dsn.Nama) AS Nama_Dosen, IF(ISNULL(jd.DosenID), d.Homebase, dsn.Homebase) AS Homebase,\nj.JadwalID AS JadwalID, j.HariID, h.Nama AS Hari, h.Nama_en AS Hari_en, j.JamMulai, j.JamSelesai, j.RuangID, k.TahunID, UPPER(mk.Nama) AS MKNama, IF(ISNULL(jd.DosenID), d.Nama, dsn.Nama) AS DosenNama\nFROM krs k\nLEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID\nLEFT OUTER JOIN dosen d ON j.DosenID = d.Login\nLEFT OUTER JOIN mk mk ON k.MKID = mk.MKID\nLEFT OUTER JOIN jadwaldosen jd ON k.JadwalID = jd.JadwalID\nLEFT OUTER JOIN dosen dsn ON jd.DosenID = dsn.Login\nLEFT OUTER JOIN mhsw m ON k.MhswID = m.MhswID\nLEFT OUTER JOIN prodi p ON m.ProdiID = p.ProdiID\nLEFT OUTER JOIN program pr ON m.ProgramID = pr.ProgramID\nLEFT OUTER JOIN hari h ON j.HariID = h.HariID\nWHERE k.MhswID = ''{respondent_id}'' AND k.TahunID = ''20132'' AND k.NA = ''N'' AND k.JadwalID <> 0\n) aa\nORDER BY aa.MKKode, aa.Nama_MK, aa.order_no, aa.Nama_Dosen"', '&&', '{mhsw_ProdiID}&&{mhsw_Nama_Prodi}&&{mhsw_Nama_Prodi_en}&&{mhsw_ProgramID}&&{mhsw_Nama_Program}&&{KodeID}&&{KRSID}&&{MKID}&&{ProdiID}&&{Sesi}&&{MKKode}&&{Nama_MK}&&{DosenID}&&{Nama_Dosen}&&{Homebase}&&{JadwalID}&&{HariID}&&{Hari}&&{Hari_en}&&{JamMulai}&&{JamSelesai}&&{RuangID}&&{TahunID}', '{mhsw_ProdiID}&&{mhsw_Nama_Prodi}&&{mhsw_Nama_Prodi_en}&&{mhsw_ProgramID}&&{mhsw_Nama_Program}&&{KodeID}&&{KRSID}&&{MKID}&&{ProdiID}&&{Sesi}&&{MKKode}&&{Nama_MK}&&{DosenID}&&{Nama_Dosen}&&{Homebase}&&{JadwalID}&&{HariID}&&{Hari}&&{Hari_en}&&{JamMulai}&&{JamSelesai}&&{RuangID}&&{TahunID}&&{order_no}', '{mhsw_ProdiID}&&{mhsw_Nama_Prodi}&&{mhsw_Nama_Prodi_en}&&{mhsw_ProgramID}&&{mhsw_Nama_Program}&&{KodeID}&&{KRSID}&&{MKID}&&{ProdiID}&&{Sesi}&&{MKKode}&&{Nama_MK}&&{DosenID}&&{Nama_Dosen}&&{Homebase}&&{JadwalID}&&{HariID}&&{Hari}&&{Hari_en}&&{JamMulai}&&{JamSelesai}&&{RuangID}&&{TahunID}&&{_CODE_SET_utsatauuas}', '{is_same}&&{MKNama}&&{DosenNama}', 'jawaban_edom_20131', 'jawaban_header_edom_20131');

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

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `jawaban_edom` AS select `SPLIT_STRING`(`j`.`custom_data`,'&&',1) AS `TahunID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',2) AS `KRSID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',3) AS `KodeID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',4) AS `KHSID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',5) AS `JadwalID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',6) AS `DosenID`,`j`.`id_periode` AS `id_periode`,`j`.`id_kuesioner` AS `id_kuesioner`,`j`.`id_pertanyaan` AS `id_pertanyaan`,`j`.`respondent_id` AS `respondent_id`,`j`.`respon_ke` AS `respon_ke`,`p`.`nilai` AS `jawaban_pilihan`,`p2`.`nilai` AS `jawaban_pilihan2`,`j`.`jawaban_isian` AS `jawaban_isian`,`j`.`created_at` AS `created_at` from (((`jawaban` `j` left join `master_kuesioner` `mk` on((`mk`.`id_kuesioner` = `j`.`id_kuesioner`))) left join `pilihan` `p` on((`p`.`id_pilihan` = `j`.`jawaban_pilihan`))) left join `pilihan` `p2` on((`p`.`id_pilihan` = `j`.`jawaban_pilihan2`))) where ((`mk`.`shortname` = 'EDOM') and if((`SPLIT_STRING`(`j`.`custom_data`,'&&',6) <> ''),1,0) and if((`SPLIT_STRING`(`j`.`custom_data`,'&&',7) = ''),1,0));

-- --------------------------------------------------------

--
-- Structure for view `jawaban_edom2`
--
DROP TABLE IF EXISTS `jawaban_edom2`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `jawaban_edom2` AS select `SPLIT_STRING`(`j`.`custom_data`,'&&',1) AS `mhsw_ProdiID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',2) AS `mhsw_Nama_Prodi`,`SPLIT_STRING`(`j`.`custom_data`,'&&',4) AS `mhsw_ProgramID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',5) AS `mhsw_Nama_Program`,`SPLIT_STRING`(`j`.`custom_data`,'&&',6) AS `KodeID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',7) AS `KRSID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',8) AS `MKID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',9) AS `ProdiID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',10) AS `Sesi`,`SPLIT_STRING`(`j`.`custom_data`,'&&',11) AS `MKKode`,`SPLIT_STRING`(`j`.`custom_data`,'&&',12) AS `Nama_MK`,`SPLIT_STRING`(`j`.`custom_data`,'&&',13) AS `DosenID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',14) AS `Nama_Dosen`,`SPLIT_STRING`(`j`.`custom_data`,'&&',15) AS `Homebase`,`SPLIT_STRING`(`j`.`custom_data`,'&&',16) AS `JadwalID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',17) AS `HariID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',19) AS `Hari`,`SPLIT_STRING`(`j`.`custom_data`,'&&',20) AS `JamMulai`,`SPLIT_STRING`(`j`.`custom_data`,'&&',21) AS `JamSelesai`,`SPLIT_STRING`(`j`.`custom_data`,'&&',22) AS `RuangID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',23) AS `TahunID`,`j`.`id_periode` AS `id_periode`,`j`.`id_kuesioner` AS `id_kuesioner`,`j`.`id_pertanyaan` AS `id_pertanyaan`,`j`.`respondent_id` AS `respondent_id`,`j`.`respon_ke` AS `respon_ke`,`p`.`nilai` AS `jawaban_pilihan`,`p2`.`nilai` AS `jawaban_pilihan2`,`j`.`jawaban_isian` AS `jawaban_isian`,`j`.`created_at` AS `created_at` from (((`jawaban` `j` left join `master_kuesioner` `mk` on((`mk`.`id_kuesioner` = `j`.`id_kuesioner`))) left join `pilihan` `p` on((`p`.`id_pilihan` = `j`.`jawaban_pilihan`))) left join `pilihan` `p2` on((`p`.`id_pilihan` = `j`.`jawaban_pilihan2`))) where ((`mk`.`shortname` = 'EDOM') and if((`SPLIT_STRING`(`j`.`custom_data`,'&&',23) <> ''),1,0) and if((`SPLIT_STRING`(`j`.`custom_data`,'&&',24) = ''),1,0));

-- --------------------------------------------------------

--
-- Structure for view `jawaban_edom3`
--
DROP TABLE IF EXISTS `jawaban_edom3`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `jawaban_edom3` AS select `SPLIT_STRING`(`j`.`custom_data`,'&&',1) AS `TahunID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',2) AS `KRSID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',3) AS `KodeID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',4) AS `KHSID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',5) AS `JadwalID`,`j`.`id_periode` AS `id_periode`,`j`.`id_kuesioner` AS `id_kuesioner`,`j`.`id_pertanyaan` AS `id_pertanyaan`,`j`.`respondent_id` AS `respondent_id`,`j`.`respon_ke` AS `respon_ke`,`p`.`nilai` AS `jawaban_pilihan`,`p2`.`nilai` AS `jawaban_pilihan2`,`j`.`jawaban_isian` AS `jawaban_isian`,`j`.`created_at` AS `created_at` from (((`jawaban` `j` left join `master_kuesioner` `mk` on((`mk`.`id_kuesioner` = `j`.`id_kuesioner`))) left join `pilihan` `p` on((`p`.`id_pilihan` = `j`.`jawaban_pilihan`))) left join `pilihan` `p2` on((`p`.`id_pilihan` = `j`.`jawaban_pilihan2`))) where ((`mk`.`shortname` = 'EDOM') and if((`SPLIT_STRING`(`j`.`custom_data`,'&&',5) <> ''),1,0) and if((`SPLIT_STRING`(`j`.`custom_data`,'&&',6) = ''),1,0));

-- --------------------------------------------------------

--
-- Structure for view `jawaban_header_edom`
--
DROP TABLE IF EXISTS `jawaban_header_edom`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `jawaban_header_edom` AS select `SPLIT_STRING`(`j`.`custom_data`,'&&',1) AS `TahunID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',2) AS `KRSID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',3) AS `KodeID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',4) AS `KHSID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',5) AS `JadwalID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',6) AS `DosenID`,`j`.`id_periode` AS `id_periode`,`j`.`id_kuesioner` AS `id_kuesioner`,`j`.`respondent_id` AS `respondent_id`,`j`.`respon_ke` AS `respon_ke`,`j`.`created_at` AS `created_at` from (`jawaban_header` `j` left join `master_kuesioner` `mk` on((`mk`.`id_kuesioner` = `j`.`id_kuesioner`))) where ((`mk`.`shortname` = 'EDOM') and if((`SPLIT_STRING`(`j`.`custom_data`,'&&',6) <> ''),1,0) and if((`SPLIT_STRING`(`j`.`custom_data`,'&&',7) = ''),1,0));

-- --------------------------------------------------------

--
-- Structure for view `jawaban_header_edom2`
--
DROP TABLE IF EXISTS `jawaban_header_edom2`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `jawaban_header_edom2` AS select `SPLIT_STRING`(`j`.`custom_data`,'&&',1) AS `mhsw_ProdiID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',2) AS `mhsw_Nama_Prodi`,`SPLIT_STRING`(`j`.`custom_data`,'&&',4) AS `mhsw_ProgramID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',5) AS `mhsw_Nama_Program`,`SPLIT_STRING`(`j`.`custom_data`,'&&',6) AS `KodeID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',7) AS `KRSID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',8) AS `MKID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',9) AS `ProdiID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',10) AS `Sesi`,`SPLIT_STRING`(`j`.`custom_data`,'&&',11) AS `MKKode`,`SPLIT_STRING`(`j`.`custom_data`,'&&',12) AS `Nama_MK`,`SPLIT_STRING`(`j`.`custom_data`,'&&',13) AS `DosenID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',14) AS `Nama_Dosen`,`SPLIT_STRING`(`j`.`custom_data`,'&&',15) AS `Homebase`,`SPLIT_STRING`(`j`.`custom_data`,'&&',16) AS `JadwalID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',17) AS `HariID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',19) AS `Hari`,`SPLIT_STRING`(`j`.`custom_data`,'&&',20) AS `JamMulai`,`SPLIT_STRING`(`j`.`custom_data`,'&&',21) AS `JamSelesai`,`SPLIT_STRING`(`j`.`custom_data`,'&&',22) AS `RuangID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',23) AS `TahunID`,`j`.`id_periode` AS `id_periode`,`j`.`id_kuesioner` AS `id_kuesioner`,`j`.`respondent_id` AS `respondent_id`,`j`.`respon_ke` AS `respon_ke`,`j`.`created_at` AS `created_at` from (`jawaban_header` `j` left join `master_kuesioner` `mk` on((`mk`.`id_kuesioner` = `j`.`id_kuesioner`))) where ((`mk`.`shortname` = 'EDOM') and if((`SPLIT_STRING`(`j`.`custom_data`,'&&',23) <> ''),1,0) and if((`SPLIT_STRING`(`j`.`custom_data`,'&&',24) = ''),1,0));

-- --------------------------------------------------------

--
-- Structure for view `jawaban_header_edom3`
--
DROP TABLE IF EXISTS `jawaban_header_edom3`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `jawaban_header_edom3` AS select `SPLIT_STRING`(`j`.`custom_data`,'&&',1) AS `TahunID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',2) AS `KRSID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',3) AS `KodeID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',4) AS `KHSID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',5) AS `JadwalID`,`j`.`id_periode` AS `id_periode`,`j`.`id_kuesioner` AS `id_kuesioner`,`j`.`respondent_id` AS `respondent_id`,`j`.`respon_ke` AS `respon_ke`,`j`.`created_at` AS `created_at` from (`jawaban_header` `j` left join `master_kuesioner` `mk` on((`mk`.`id_kuesioner` = `j`.`id_kuesioner`))) where ((`mk`.`shortname` = 'EDOM') and if((`SPLIT_STRING`(`j`.`custom_data`,'&&',5) <> ''),1,0) and if((`SPLIT_STRING`(`j`.`custom_data`,'&&',6) = ''),1,0));

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
