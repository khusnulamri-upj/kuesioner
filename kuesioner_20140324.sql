-- phpMyAdmin SQL Dump
-- version 4.0.9
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Mar 24, 2014 at 10:23 AM
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
('04a48438cd83550002aeb987130c38c3', '::1', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:28.0) Gecko/20100101 Firefox/28.0', 1395652797, 'a:2:{s:9:"user_data";s:0:"";s:12:"edom_0_tahun";a:1:{i:0;s:5:"20131";}}');

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
  `custom_data2` text,
  PRIMARY KEY (`id_jawaban`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=481 ;

--
-- Dumping data for table `jawaban`
--

INSERT INTO `jawaban` (`created_at`, `id_jawaban`, `id_periode`, `id_kuesioner`, `id_pertanyaan`, `respondent_id`, `respon_ke`, `jawaban_pilihan`, `jawaban_pilihan2`, `jawaban_isian`, `custom_data`, `custom_data2`) VALUES
('2014-03-24 07:05:47', 1, 7, 1, 1, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:05:47', 2, 7, 1, 2, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:05:47', 3, 7, 1, 3, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:05:47', 4, 7, 1, 4, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:05:47', 5, 7, 1, 5, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:05:47', 6, 7, 1, 6, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:05:47', 7, 7, 1, 7, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:05:47', 8, 7, 1, 8, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:05:47', 9, 7, 1, 9, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:05:47', 10, 7, 1, 10, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:05:47', 11, 7, 1, 11, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:05:47', 12, 7, 1, 12, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:05:47', 13, 7, 1, 13, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:05:47', 14, 7, 1, 14, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:05:47', 15, 7, 1, 15, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:05:47', 16, 7, 1, 16, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:05:47', 17, 7, 1, 17, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:05:47', 18, 7, 1, 18, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:05:47', 19, 7, 1, 19, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:05:47', 20, 7, 1, 20, '2013011001', 1, NULL, NULL, '', 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:06:00', 21, 7, 1, 1, '2013011001', 2, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:06:00', 22, 7, 1, 2, '2013011001', 2, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:06:00', 23, 7, 1, 3, '2013011001', 2, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:06:00', 24, 7, 1, 4, '2013011001', 2, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:06:00', 25, 7, 1, 5, '2013011001', 2, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:06:00', 26, 7, 1, 6, '2013011001', 2, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:06:00', 27, 7, 1, 7, '2013011001', 2, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:06:00', 28, 7, 1, 8, '2013011001', 2, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:06:00', 29, 7, 1, 9, '2013011001', 2, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:06:00', 30, 7, 1, 10, '2013011001', 2, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:06:00', 31, 7, 1, 11, '2013011001', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:06:00', 32, 7, 1, 12, '2013011001', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:06:00', 33, 7, 1, 13, '2013011001', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:06:00', 34, 7, 1, 14, '2013011001', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:06:00', 35, 7, 1, 15, '2013011001', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:06:00', 36, 7, 1, 16, '2013011001', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:06:00', 37, 7, 1, 17, '2013011001', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:06:00', 38, 7, 1, 18, '2013011001', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:06:00', 39, 7, 1, 19, '2013011001', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:06:00', 40, 7, 1, 20, '2013011001', 2, NULL, NULL, '', 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:06:08', 41, 7, 1, 1, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5493&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:06:08', 42, 7, 1, 2, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5493&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:06:08', 43, 7, 1, 3, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5493&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:06:08', 44, 7, 1, 4, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5493&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:06:08', 45, 7, 1, 5, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5493&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:06:08', 46, 7, 1, 6, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5493&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:06:08', 47, 7, 1, 7, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5493&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:06:08', 48, 7, 1, 8, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5493&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:06:08', 49, 7, 1, 9, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5493&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:06:08', 50, 7, 1, 10, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5493&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:06:08', 51, 7, 1, 11, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5493&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:06:08', 52, 7, 1, 12, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5493&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:06:08', 53, 7, 1, 13, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5493&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:06:08', 54, 7, 1, 14, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5493&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:06:08', 55, 7, 1, 15, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5493&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:06:08', 56, 7, 1, 16, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5493&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:06:08', 57, 7, 1, 17, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5493&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:06:08', 58, 7, 1, 18, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5493&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:06:08', 59, 7, 1, 19, '2013011001', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5493&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:06:08', 60, 7, 1, 20, '2013011001', 1, NULL, NULL, 'oke', 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5493&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:07:25', 61, 7, 1, 1, '2013011002', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:07:25', 62, 7, 1, 2, '2013011002', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:07:25', 63, 7, 1, 3, '2013011002', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:07:25', 64, 7, 1, 4, '2013011002', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:07:25', 65, 7, 1, 5, '2013011002', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:07:25', 66, 7, 1, 6, '2013011002', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:07:25', 67, 7, 1, 7, '2013011002', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:07:25', 68, 7, 1, 8, '2013011002', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:07:25', 69, 7, 1, 9, '2013011002', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:07:25', 70, 7, 1, 10, '2013011002', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:07:25', 71, 7, 1, 11, '2013011002', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:07:25', 72, 7, 1, 12, '2013011002', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:07:25', 73, 7, 1, 13, '2013011002', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:07:25', 74, 7, 1, 14, '2013011002', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:07:25', 75, 7, 1, 15, '2013011002', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:07:25', 76, 7, 1, 16, '2013011002', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:07:25', 77, 7, 1, 17, '2013011002', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:07:25', 78, 7, 1, 18, '2013011002', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:07:25', 79, 7, 1, 19, '2013011002', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:07:25', 80, 7, 1, 20, '2013011002', 1, NULL, NULL, 'sip', 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:07:51', 81, 7, 1, 1, '2013011002', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:07:51', 82, 7, 1, 2, '2013011002', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:07:51', 83, 7, 1, 3, '2013011002', 2, 3, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:07:51', 84, 7, 1, 4, '2013011002', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:07:51', 85, 7, 1, 5, '2013011002', 2, 3, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:07:51', 86, 7, 1, 6, '2013011002', 2, 3, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:07:51', 87, 7, 1, 7, '2013011002', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:07:51', 88, 7, 1, 8, '2013011002', 2, 3, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:07:51', 89, 7, 1, 9, '2013011002', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:07:51', 90, 7, 1, 10, '2013011002', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:07:51', 91, 7, 1, 11, '2013011002', 2, 3, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:07:51', 92, 7, 1, 12, '2013011002', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:07:51', 93, 7, 1, 13, '2013011002', 2, 3, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:07:51', 94, 7, 1, 14, '2013011002', 2, 3, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:07:51', 95, 7, 1, 15, '2013011002', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:07:51', 96, 7, 1, 16, '2013011002', 2, 3, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:07:51', 97, 7, 1, 17, '2013011002', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:07:51', 98, 7, 1, 18, '2013011002', 2, 3, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:07:51', 99, 7, 1, 19, '2013011002', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:07:51', 100, 7, 1, 20, '2013011002', 2, NULL, NULL, '', 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:08:12', 101, 7, 1, 1, '2013011002', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7382&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:08:12', 102, 7, 1, 2, '2013011002', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7382&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:08:12', 103, 7, 1, 3, '2013011002', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7382&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:08:12', 104, 7, 1, 4, '2013011002', 1, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7382&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:08:12', 105, 7, 1, 5, '2013011002', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7382&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:08:12', 106, 7, 1, 6, '2013011002', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7382&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:08:12', 107, 7, 1, 7, '2013011002', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7382&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:08:12', 108, 7, 1, 8, '2013011002', 1, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7382&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:08:12', 109, 7, 1, 9, '2013011002', 1, 3, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7382&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:08:12', 110, 7, 1, 10, '2013011002', 1, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7382&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:08:12', 111, 7, 1, 11, '2013011002', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7382&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:08:12', 112, 7, 1, 12, '2013011002', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7382&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:08:12', 113, 7, 1, 13, '2013011002', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7382&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:08:12', 114, 7, 1, 14, '2013011002', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7382&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:08:12', 115, 7, 1, 15, '2013011002', 1, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7382&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:08:12', 116, 7, 1, 16, '2013011002', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7382&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:08:12', 117, 7, 1, 17, '2013011002', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7382&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:08:12', 118, 7, 1, 18, '2013011002', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7382&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:08:12', 119, 7, 1, 19, '2013011002', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7382&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:08:12', 120, 7, 1, 20, '2013011002', 1, NULL, NULL, '', 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7382&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:09:08', 121, 7, 1, 1, '2013011003', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:09:08', 122, 7, 1, 2, '2013011003', 1, 3, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:09:08', 123, 7, 1, 3, '2013011003', 1, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:09:08', 124, 7, 1, 4, '2013011003', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:09:08', 125, 7, 1, 5, '2013011003', 1, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:09:08', 126, 7, 1, 6, '2013011003', 1, 3, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:09:08', 127, 7, 1, 7, '2013011003', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:09:08', 128, 7, 1, 8, '2013011003', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:09:08', 129, 7, 1, 9, '2013011003', 1, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:09:08', 130, 7, 1, 10, '2013011003', 1, 3, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:09:08', 131, 7, 1, 11, '2013011003', 1, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:09:09', 132, 7, 1, 12, '2013011003', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:09:09', 133, 7, 1, 13, '2013011003', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:09:09', 134, 7, 1, 14, '2013011003', 1, 3, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:09:09', 135, 7, 1, 15, '2013011003', 1, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:09:09', 136, 7, 1, 16, '2013011003', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:09:09', 137, 7, 1, 17, '2013011003', 1, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:09:09', 138, 7, 1, 18, '2013011003', 1, 3, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:09:09', 139, 7, 1, 19, '2013011003', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:09:09', 140, 7, 1, 20, '2013011003', 1, NULL, NULL, '', 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:09:13', 141, 7, 1, 1, '2013011003', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:09:13', 142, 7, 1, 2, '2013011003', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:09:13', 143, 7, 1, 3, '2013011003', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:09:13', 144, 7, 1, 4, '2013011003', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:09:13', 145, 7, 1, 5, '2013011003', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:09:13', 146, 7, 1, 6, '2013011003', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:09:13', 147, 7, 1, 7, '2013011003', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:09:13', 148, 7, 1, 8, '2013011003', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:09:13', 149, 7, 1, 9, '2013011003', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:09:13', 150, 7, 1, 10, '2013011003', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:09:13', 151, 7, 1, 11, '2013011003', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:09:13', 152, 7, 1, 12, '2013011003', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:09:13', 153, 7, 1, 13, '2013011003', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:09:13', 154, 7, 1, 14, '2013011003', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:09:13', 155, 7, 1, 15, '2013011003', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:09:13', 156, 7, 1, 16, '2013011003', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:09:13', 157, 7, 1, 17, '2013011003', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:09:13', 158, 7, 1, 18, '2013011003', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:09:13', 159, 7, 1, 19, '2013011003', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:09:13', 160, 7, 1, 20, '2013011003', 2, NULL, NULL, '', 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:09:40', 161, 7, 1, 1, '2013011003', 1, 3, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5530&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:09:40', 162, 7, 1, 2, '2013011003', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5530&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:09:40', 163, 7, 1, 3, '2013011003', 1, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5530&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:09:40', 164, 7, 1, 4, '2013011003', 1, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5530&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:09:40', 165, 7, 1, 5, '2013011003', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5530&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:09:40', 166, 7, 1, 6, '2013011003', 1, 3, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5530&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:09:40', 167, 7, 1, 7, '2013011003', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5530&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:09:40', 168, 7, 1, 8, '2013011003', 1, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5530&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:09:40', 169, 7, 1, 9, '2013011003', 1, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5530&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:09:40', 170, 7, 1, 10, '2013011003', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5530&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:09:40', 171, 7, 1, 11, '2013011003', 1, 3, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5530&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:09:40', 172, 7, 1, 12, '2013011003', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5530&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:09:40', 173, 7, 1, 13, '2013011003', 1, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5530&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1');
INSERT INTO `jawaban` (`created_at`, `id_jawaban`, `id_periode`, `id_kuesioner`, `id_pertanyaan`, `respondent_id`, `respon_ke`, `jawaban_pilihan`, `jawaban_pilihan2`, `jawaban_isian`, `custom_data`, `custom_data2`) VALUES
('2014-03-24 07:09:40', 174, 7, 1, 14, '2013011003', 1, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5530&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:09:40', 175, 7, 1, 15, '2013011003', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5530&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:09:40', 176, 7, 1, 16, '2013011003', 1, 3, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5530&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:09:40', 177, 7, 1, 17, '2013011003', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5530&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:09:40', 178, 7, 1, 18, '2013011003', 1, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5530&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:09:40', 179, 7, 1, 19, '2013011003', 1, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5530&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:09:40', 180, 7, 1, 20, '2013011003', 1, NULL, NULL, '', 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5530&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:11:12', 181, 7, 1, 1, '2013011005', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:11:12', 182, 7, 1, 2, '2013011005', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:11:12', 183, 7, 1, 3, '2013011005', 1, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:11:12', 184, 7, 1, 4, '2013011005', 1, 3, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:11:12', 185, 7, 1, 5, '2013011005', 1, 2, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:11:12', 186, 7, 1, 6, '2013011005', 1, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:11:12', 187, 7, 1, 7, '2013011005', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:11:12', 188, 7, 1, 8, '2013011005', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:11:12', 189, 7, 1, 9, '2013011005', 1, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:11:12', 190, 7, 1, 10, '2013011005', 1, 3, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:11:12', 191, 7, 1, 11, '2013011005', 1, 2, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:11:12', 192, 7, 1, 12, '2013011005', 1, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:11:12', 193, 7, 1, 13, '2013011005', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:11:12', 194, 7, 1, 14, '2013011005', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:11:12', 195, 7, 1, 15, '2013011005', 1, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:11:12', 196, 7, 1, 16, '2013011005', 1, 3, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:11:12', 197, 7, 1, 17, '2013011005', 1, 2, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:11:12', 198, 7, 1, 18, '2013011005', 1, 1, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:11:12', 199, 7, 1, 19, '2013011005', 1, 2, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:11:12', 200, 7, 1, 20, '2013011005', 1, NULL, NULL, 'ha2 top bgt', 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:11:30', 201, 7, 1, 1, '2013011005', 2, 3, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:11:30', 202, 7, 1, 2, '2013011005', 2, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:11:30', 203, 7, 1, 3, '2013011005', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:11:30', 204, 7, 1, 4, '2013011005', 2, 3, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:11:30', 205, 7, 1, 5, '2013011005', 2, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:11:30', 206, 7, 1, 6, '2013011005', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:11:30', 207, 7, 1, 7, '2013011005', 2, 3, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:11:30', 208, 7, 1, 8, '2013011005', 2, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:11:30', 209, 7, 1, 9, '2013011005', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:11:30', 210, 7, 1, 10, '2013011005', 2, 3, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:11:30', 211, 7, 1, 11, '2013011005', 2, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:11:30', 212, 7, 1, 12, '2013011005', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:11:30', 213, 7, 1, 13, '2013011005', 2, 3, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:11:30', 214, 7, 1, 14, '2013011005', 2, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:11:30', 215, 7, 1, 15, '2013011005', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:11:30', 216, 7, 1, 16, '2013011005', 2, 3, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:11:30', 217, 7, 1, 17, '2013011005', 2, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:11:30', 218, 7, 1, 18, '2013011005', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:11:30', 219, 7, 1, 19, '2013011005', 2, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:11:30', 220, 7, 1, 20, '2013011005', 2, NULL, NULL, '', 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:11:50', 221, 7, 1, 1, '2013011005', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8055&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:11:50', 222, 7, 1, 2, '2013011005', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8055&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:11:50', 223, 7, 1, 3, '2013011005', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8055&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:11:50', 224, 7, 1, 4, '2013011005', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8055&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:11:50', 225, 7, 1, 5, '2013011005', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8055&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:11:50', 226, 7, 1, 6, '2013011005', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8055&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:11:50', 227, 7, 1, 7, '2013011005', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8055&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:11:50', 228, 7, 1, 8, '2013011005', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8055&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:11:50', 229, 7, 1, 9, '2013011005', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8055&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:11:50', 230, 7, 1, 10, '2013011005', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8055&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:11:50', 231, 7, 1, 11, '2013011005', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8055&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:11:50', 232, 7, 1, 12, '2013011005', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8055&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:11:50', 233, 7, 1, 13, '2013011005', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8055&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:11:50', 234, 7, 1, 14, '2013011005', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8055&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:11:50', 235, 7, 1, 15, '2013011005', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8055&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:11:50', 236, 7, 1, 16, '2013011005', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8055&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:11:50', 237, 7, 1, 17, '2013011005', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8055&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:11:50', 238, 7, 1, 18, '2013011005', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8055&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:11:50', 239, 7, 1, 19, '2013011005', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8055&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:11:50', 240, 7, 1, 20, '2013011005', 1, NULL, NULL, '', 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8055&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:19:44', 241, 7, 1, 1, '2013021001', 1, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5556&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:19:44', 242, 7, 1, 2, '2013021001', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5556&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:19:44', 243, 7, 1, 3, '2013021001', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5556&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:19:44', 244, 7, 1, 4, '2013021001', 1, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5556&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:19:44', 245, 7, 1, 5, '2013021001', 1, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5556&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:19:44', 246, 7, 1, 6, '2013021001', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5556&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:19:44', 247, 7, 1, 7, '2013021001', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5556&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:19:44', 248, 7, 1, 8, '2013021001', 1, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5556&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:19:44', 249, 7, 1, 9, '2013021001', 1, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5556&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:19:44', 250, 7, 1, 10, '2013021001', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5556&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:19:44', 251, 7, 1, 11, '2013021001', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5556&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:19:44', 252, 7, 1, 12, '2013021001', 1, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5556&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:19:44', 253, 7, 1, 13, '2013021001', 1, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5556&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:19:44', 254, 7, 1, 14, '2013021001', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5556&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:19:44', 255, 7, 1, 15, '2013021001', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5556&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:19:44', 256, 7, 1, 16, '2013021001', 1, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5556&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:19:44', 257, 7, 1, 17, '2013021001', 1, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5556&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:19:44', 258, 7, 1, 18, '2013021001', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5556&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:19:44', 259, 7, 1, 19, '2013021001', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5556&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:19:44', 260, 7, 1, 20, '2013021001', 1, NULL, NULL, '', 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5556&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:19:59', 261, 7, 1, 1, '2013021001', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5555&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:19:59', 262, 7, 1, 2, '2013021001', 1, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5555&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:19:59', 263, 7, 1, 3, '2013021001', 1, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5555&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:19:59', 264, 7, 1, 4, '2013021001', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5555&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:19:59', 265, 7, 1, 5, '2013021001', 1, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5555&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:19:59', 266, 7, 1, 6, '2013021001', 1, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5555&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:19:59', 267, 7, 1, 7, '2013021001', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5555&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:19:59', 268, 7, 1, 8, '2013021001', 1, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5555&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:19:59', 269, 7, 1, 9, '2013021001', 1, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5555&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:19:59', 270, 7, 1, 10, '2013021001', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5555&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:19:59', 271, 7, 1, 11, '2013021001', 1, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5555&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:19:59', 272, 7, 1, 12, '2013021001', 1, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5555&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:19:59', 273, 7, 1, 13, '2013021001', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5555&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:19:59', 274, 7, 1, 14, '2013021001', 1, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5555&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:19:59', 275, 7, 1, 15, '2013021001', 1, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5555&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:19:59', 276, 7, 1, 16, '2013021001', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5555&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:19:59', 277, 7, 1, 17, '2013021001', 1, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5555&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:19:59', 278, 7, 1, 18, '2013021001', 1, 6, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5555&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:19:59', 279, 7, 1, 19, '2013021001', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5555&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:19:59', 280, 7, 1, 20, '2013021001', 1, NULL, NULL, '', 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5555&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:20:50', 281, 7, 1, 1, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5458&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:20:50', 282, 7, 1, 2, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5458&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:20:50', 283, 7, 1, 3, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5458&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:20:50', 284, 7, 1, 4, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5458&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:20:50', 285, 7, 1, 5, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5458&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:20:50', 286, 7, 1, 6, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5458&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:20:50', 287, 7, 1, 7, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5458&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:20:50', 288, 7, 1, 8, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5458&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:20:50', 289, 7, 1, 9, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5458&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:20:50', 290, 7, 1, 10, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5458&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:20:50', 291, 7, 1, 11, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5458&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:20:50', 292, 7, 1, 12, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5458&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:20:50', 293, 7, 1, 13, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5458&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:20:50', 294, 7, 1, 14, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5458&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:20:50', 295, 7, 1, 15, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5458&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:20:50', 296, 7, 1, 16, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5458&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:20:50', 297, 7, 1, 17, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5458&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:20:50', 298, 7, 1, 18, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5458&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:20:50', 299, 7, 1, 19, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5458&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:20:50', 300, 7, 1, 20, '2013021002', 1, NULL, NULL, '', 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5458&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:20:55', 301, 7, 1, 1, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5457&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:20:55', 302, 7, 1, 2, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5457&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:20:55', 303, 7, 1, 3, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5457&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:20:55', 304, 7, 1, 4, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5457&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:20:55', 305, 7, 1, 5, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5457&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:20:55', 306, 7, 1, 6, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5457&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:20:55', 307, 7, 1, 7, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5457&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:20:55', 308, 7, 1, 8, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5457&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:20:55', 309, 7, 1, 9, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5457&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:20:55', 310, 7, 1, 10, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5457&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:20:55', 311, 7, 1, 11, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5457&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:20:55', 312, 7, 1, 12, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5457&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:20:55', 313, 7, 1, 13, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5457&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:20:55', 314, 7, 1, 14, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5457&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:20:55', 315, 7, 1, 15, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5457&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:20:55', 316, 7, 1, 16, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5457&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:20:55', 317, 7, 1, 17, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5457&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:20:55', 318, 7, 1, 18, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5457&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:20:55', 319, 7, 1, 19, '2013021002', 1, 5, NULL, NULL, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5457&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:20:55', 320, 7, 1, 20, '2013021002', 1, NULL, NULL, '', 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5457&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:22:07', 321, 7, 1, 1, '2013031001', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5744&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:22:07', 322, 7, 1, 2, '2013031001', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5744&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:22:07', 323, 7, 1, 3, '2013031001', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5744&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:22:07', 324, 7, 1, 4, '2013031001', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5744&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:22:07', 325, 7, 1, 5, '2013031001', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5744&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:22:07', 326, 7, 1, 6, '2013031001', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5744&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:22:07', 327, 7, 1, 7, '2013031001', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5744&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:22:07', 328, 7, 1, 8, '2013031001', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5744&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:22:07', 329, 7, 1, 9, '2013031001', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5744&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:22:07', 330, 7, 1, 10, '2013031001', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5744&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:22:07', 331, 7, 1, 11, '2013031001', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5744&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:22:07', 332, 7, 1, 12, '2013031001', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5744&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:22:07', 333, 7, 1, 13, '2013031001', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5744&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:22:07', 334, 7, 1, 14, '2013031001', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5744&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:22:07', 335, 7, 1, 15, '2013031001', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5744&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:22:07', 336, 7, 1, 16, '2013031001', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5744&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:22:07', 337, 7, 1, 17, '2013031001', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5744&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:22:07', 338, 7, 1, 18, '2013031001', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5744&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:22:07', 339, 7, 1, 19, '2013031001', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5744&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:22:07', 340, 7, 1, 20, '2013031001', 1, NULL, NULL, '', 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5744&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:22:20', 341, 7, 1, 1, '2013031001', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5743&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:22:20', 342, 7, 1, 2, '2013031001', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5743&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:22:20', 343, 7, 1, 3, '2013031001', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5743&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:22:20', 344, 7, 1, 4, '2013031001', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5743&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1');
INSERT INTO `jawaban` (`created_at`, `id_jawaban`, `id_periode`, `id_kuesioner`, `id_pertanyaan`, `respondent_id`, `respon_ke`, `jawaban_pilihan`, `jawaban_pilihan2`, `jawaban_isian`, `custom_data`, `custom_data2`) VALUES
('2014-03-24 07:22:20', 345, 7, 1, 5, '2013031001', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5743&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:22:20', 346, 7, 1, 6, '2013031001', 1, 3, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5743&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:22:20', 347, 7, 1, 7, '2013031001', 1, 3, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5743&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:22:20', 348, 7, 1, 8, '2013031001', 1, 3, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5743&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:22:20', 349, 7, 1, 9, '2013031001', 1, 4, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5743&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:22:20', 350, 7, 1, 10, '2013031001', 1, 4, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5743&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:22:20', 351, 7, 1, 11, '2013031001', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5743&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:22:20', 352, 7, 1, 12, '2013031001', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5743&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:22:20', 353, 7, 1, 13, '2013031001', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5743&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:22:20', 354, 7, 1, 14, '2013031001', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5743&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:22:20', 355, 7, 1, 15, '2013031001', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5743&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:22:20', 356, 7, 1, 16, '2013031001', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5743&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:22:20', 357, 7, 1, 17, '2013031001', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5743&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:22:20', 358, 7, 1, 18, '2013031001', 1, 3, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5743&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:22:20', 359, 7, 1, 19, '2013031001', 1, 3, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5743&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:22:20', 360, 7, 1, 20, '2013031001', 1, NULL, NULL, '', 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5743&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:23:48', 361, 7, 1, 1, '2013031003', 1, 1, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5440&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:23:48', 362, 7, 1, 2, '2013031003', 1, 1, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5440&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:23:48', 363, 7, 1, 3, '2013031003', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5440&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:23:48', 364, 7, 1, 4, '2013031003', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5440&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:23:48', 365, 7, 1, 5, '2013031003', 1, 6, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5440&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:23:48', 366, 7, 1, 6, '2013031003', 1, 6, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5440&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:23:48', 367, 7, 1, 7, '2013031003', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5440&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:23:48', 368, 7, 1, 8, '2013031003', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5440&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:23:48', 369, 7, 1, 9, '2013031003', 1, 1, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5440&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:23:48', 370, 7, 1, 10, '2013031003', 1, 1, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5440&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:23:48', 371, 7, 1, 11, '2013031003', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5440&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:23:48', 372, 7, 1, 12, '2013031003', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5440&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:23:48', 373, 7, 1, 13, '2013031003', 1, 6, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5440&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:23:48', 374, 7, 1, 14, '2013031003', 1, 6, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5440&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:23:48', 375, 7, 1, 15, '2013031003', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5440&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:23:48', 376, 7, 1, 16, '2013031003', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5440&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:23:48', 377, 7, 1, 17, '2013031003', 1, 1, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5440&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:23:48', 378, 7, 1, 18, '2013031003', 1, 1, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5440&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:23:48', 379, 7, 1, 19, '2013031003', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5440&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:23:48', 380, 7, 1, 20, '2013031003', 1, NULL, NULL, 'haha', 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5440&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:24:10', 381, 7, 1, 1, '2013031003', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5439&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:24:10', 382, 7, 1, 2, '2013031003', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5439&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:24:10', 383, 7, 1, 3, '2013031003', 1, 6, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5439&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:24:10', 384, 7, 1, 4, '2013031003', 1, 6, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5439&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:24:10', 385, 7, 1, 5, '2013031003', 1, 6, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5439&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:24:10', 386, 7, 1, 6, '2013031003', 1, 6, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5439&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:24:10', 387, 7, 1, 7, '2013031003', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5439&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:24:10', 388, 7, 1, 8, '2013031003', 1, 6, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5439&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:24:10', 389, 7, 1, 9, '2013031003', 1, 6, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5439&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:24:10', 390, 7, 1, 10, '2013031003', 1, 3, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5439&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:24:10', 391, 7, 1, 11, '2013031003', 1, 3, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5439&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:24:10', 392, 7, 1, 12, '2013031003', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5439&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:24:10', 393, 7, 1, 13, '2013031003', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5439&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:24:10', 394, 7, 1, 14, '2013031003', 1, 4, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5439&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:24:10', 395, 7, 1, 15, '2013031003', 1, 4, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5439&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:24:10', 396, 7, 1, 16, '2013031003', 1, 4, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5439&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:24:10', 397, 7, 1, 17, '2013031003', 1, 4, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5439&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:24:10', 398, 7, 1, 18, '2013031003', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5439&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:24:10', 399, 7, 1, 19, '2013031003', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5439&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:24:10', 400, 7, 1, 20, '2013031003', 1, NULL, NULL, '', 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5439&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:25:57', 401, 7, 1, 1, '2013031006', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6064&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&625&&5&&Jumat&&Friday&&13:00:00&&15:30:00&&A-307&&20131', '1'),
('2014-03-24 07:25:57', 402, 7, 1, 2, '2013031006', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6064&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&625&&5&&Jumat&&Friday&&13:00:00&&15:30:00&&A-307&&20131', '1'),
('2014-03-24 07:25:57', 403, 7, 1, 3, '2013031006', 1, 6, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6064&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&625&&5&&Jumat&&Friday&&13:00:00&&15:30:00&&A-307&&20131', '1'),
('2014-03-24 07:25:57', 404, 7, 1, 4, '2013031006', 1, 6, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6064&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&625&&5&&Jumat&&Friday&&13:00:00&&15:30:00&&A-307&&20131', '1'),
('2014-03-24 07:25:57', 405, 7, 1, 5, '2013031006', 1, 6, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6064&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&625&&5&&Jumat&&Friday&&13:00:00&&15:30:00&&A-307&&20131', '1'),
('2014-03-24 07:25:57', 406, 7, 1, 6, '2013031006', 1, 6, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6064&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&625&&5&&Jumat&&Friday&&13:00:00&&15:30:00&&A-307&&20131', '1'),
('2014-03-24 07:25:57', 407, 7, 1, 7, '2013031006', 1, 6, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6064&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&625&&5&&Jumat&&Friday&&13:00:00&&15:30:00&&A-307&&20131', '1'),
('2014-03-24 07:25:57', 408, 7, 1, 8, '2013031006', 1, 6, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6064&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&625&&5&&Jumat&&Friday&&13:00:00&&15:30:00&&A-307&&20131', '1'),
('2014-03-24 07:25:57', 409, 7, 1, 9, '2013031006', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6064&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&625&&5&&Jumat&&Friday&&13:00:00&&15:30:00&&A-307&&20131', '1'),
('2014-03-24 07:25:57', 410, 7, 1, 10, '2013031006', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6064&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&625&&5&&Jumat&&Friday&&13:00:00&&15:30:00&&A-307&&20131', '1'),
('2014-03-24 07:25:57', 411, 7, 1, 11, '2013031006', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6064&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&625&&5&&Jumat&&Friday&&13:00:00&&15:30:00&&A-307&&20131', '1'),
('2014-03-24 07:25:57', 412, 7, 1, 12, '2013031006', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6064&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&625&&5&&Jumat&&Friday&&13:00:00&&15:30:00&&A-307&&20131', '1'),
('2014-03-24 07:25:57', 413, 7, 1, 13, '2013031006', 1, 6, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6064&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&625&&5&&Jumat&&Friday&&13:00:00&&15:30:00&&A-307&&20131', '1'),
('2014-03-24 07:25:57', 414, 7, 1, 14, '2013031006', 1, 6, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6064&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&625&&5&&Jumat&&Friday&&13:00:00&&15:30:00&&A-307&&20131', '1'),
('2014-03-24 07:25:57', 415, 7, 1, 15, '2013031006', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6064&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&625&&5&&Jumat&&Friday&&13:00:00&&15:30:00&&A-307&&20131', '1'),
('2014-03-24 07:25:57', 416, 7, 1, 16, '2013031006', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6064&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&625&&5&&Jumat&&Friday&&13:00:00&&15:30:00&&A-307&&20131', '1'),
('2014-03-24 07:25:57', 417, 7, 1, 17, '2013031006', 1, 6, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6064&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&625&&5&&Jumat&&Friday&&13:00:00&&15:30:00&&A-307&&20131', '1'),
('2014-03-24 07:25:57', 418, 7, 1, 18, '2013031006', 1, 6, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6064&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&625&&5&&Jumat&&Friday&&13:00:00&&15:30:00&&A-307&&20131', '1'),
('2014-03-24 07:25:57', 419, 7, 1, 19, '2013031006', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6064&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&625&&5&&Jumat&&Friday&&13:00:00&&15:30:00&&A-307&&20131', '1'),
('2014-03-24 07:25:57', 420, 7, 1, 20, '2013031006', 1, NULL, NULL, '', 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6064&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&625&&5&&Jumat&&Friday&&13:00:00&&15:30:00&&A-307&&20131', '1'),
('2014-03-24 07:26:02', 421, 7, 1, 1, '2013031006', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6062&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&618&&4&&Kamis&&Thursday&&11:00:00&&13:30:00&&B-307&&20131', '1'),
('2014-03-24 07:26:02', 422, 7, 1, 2, '2013031006', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6062&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&618&&4&&Kamis&&Thursday&&11:00:00&&13:30:00&&B-307&&20131', '1'),
('2014-03-24 07:26:02', 423, 7, 1, 3, '2013031006', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6062&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&618&&4&&Kamis&&Thursday&&11:00:00&&13:30:00&&B-307&&20131', '1'),
('2014-03-24 07:26:02', 424, 7, 1, 4, '2013031006', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6062&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&618&&4&&Kamis&&Thursday&&11:00:00&&13:30:00&&B-307&&20131', '1'),
('2014-03-24 07:26:02', 425, 7, 1, 5, '2013031006', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6062&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&618&&4&&Kamis&&Thursday&&11:00:00&&13:30:00&&B-307&&20131', '1'),
('2014-03-24 07:26:02', 426, 7, 1, 6, '2013031006', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6062&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&618&&4&&Kamis&&Thursday&&11:00:00&&13:30:00&&B-307&&20131', '1'),
('2014-03-24 07:26:02', 427, 7, 1, 7, '2013031006', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6062&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&618&&4&&Kamis&&Thursday&&11:00:00&&13:30:00&&B-307&&20131', '1'),
('2014-03-24 07:26:02', 428, 7, 1, 8, '2013031006', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6062&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&618&&4&&Kamis&&Thursday&&11:00:00&&13:30:00&&B-307&&20131', '1'),
('2014-03-24 07:26:02', 429, 7, 1, 9, '2013031006', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6062&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&618&&4&&Kamis&&Thursday&&11:00:00&&13:30:00&&B-307&&20131', '1'),
('2014-03-24 07:26:02', 430, 7, 1, 10, '2013031006', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6062&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&618&&4&&Kamis&&Thursday&&11:00:00&&13:30:00&&B-307&&20131', '1'),
('2014-03-24 07:26:02', 431, 7, 1, 11, '2013031006', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6062&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&618&&4&&Kamis&&Thursday&&11:00:00&&13:30:00&&B-307&&20131', '1'),
('2014-03-24 07:26:02', 432, 7, 1, 12, '2013031006', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6062&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&618&&4&&Kamis&&Thursday&&11:00:00&&13:30:00&&B-307&&20131', '1'),
('2014-03-24 07:26:02', 433, 7, 1, 13, '2013031006', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6062&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&618&&4&&Kamis&&Thursday&&11:00:00&&13:30:00&&B-307&&20131', '1'),
('2014-03-24 07:26:02', 434, 7, 1, 14, '2013031006', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6062&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&618&&4&&Kamis&&Thursday&&11:00:00&&13:30:00&&B-307&&20131', '1'),
('2014-03-24 07:26:02', 435, 7, 1, 15, '2013031006', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6062&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&618&&4&&Kamis&&Thursday&&11:00:00&&13:30:00&&B-307&&20131', '1'),
('2014-03-24 07:26:02', 436, 7, 1, 16, '2013031006', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6062&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&618&&4&&Kamis&&Thursday&&11:00:00&&13:30:00&&B-307&&20131', '1'),
('2014-03-24 07:26:02', 437, 7, 1, 17, '2013031006', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6062&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&618&&4&&Kamis&&Thursday&&11:00:00&&13:30:00&&B-307&&20131', '1'),
('2014-03-24 07:26:02', 438, 7, 1, 18, '2013031006', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6062&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&618&&4&&Kamis&&Thursday&&11:00:00&&13:30:00&&B-307&&20131', '1'),
('2014-03-24 07:26:02', 439, 7, 1, 19, '2013031006', 1, 5, NULL, NULL, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6062&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&618&&4&&Kamis&&Thursday&&11:00:00&&13:30:00&&B-307&&20131', '1'),
('2014-03-24 07:26:02', 440, 7, 1, 20, '2013031006', 1, NULL, NULL, '', 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6062&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&618&&4&&Kamis&&Thursday&&11:00:00&&13:30:00&&B-307&&20131', '1'),
('2014-03-24 07:31:34', 441, 7, 1, 1, '2013011008', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5377&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&335&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-307&&20131', '1'),
('2014-03-24 07:31:34', 442, 7, 1, 2, '2013011008', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5377&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&335&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-307&&20131', '1'),
('2014-03-24 07:31:34', 443, 7, 1, 3, '2013011008', 1, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5377&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&335&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-307&&20131', '1'),
('2014-03-24 07:31:34', 444, 7, 1, 4, '2013011008', 1, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5377&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&335&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-307&&20131', '1'),
('2014-03-24 07:31:34', 445, 7, 1, 5, '2013011008', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5377&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&335&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-307&&20131', '1'),
('2014-03-24 07:31:34', 446, 7, 1, 6, '2013011008', 1, 3, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5377&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&335&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-307&&20131', '1'),
('2014-03-24 07:31:34', 447, 7, 1, 7, '2013011008', 1, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5377&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&335&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-307&&20131', '1'),
('2014-03-24 07:31:34', 448, 7, 1, 8, '2013011008', 1, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5377&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&335&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-307&&20131', '1'),
('2014-03-24 07:31:34', 449, 7, 1, 9, '2013011008', 1, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5377&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&335&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-307&&20131', '1'),
('2014-03-24 07:31:34', 450, 7, 1, 10, '2013011008', 1, 3, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5377&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&335&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-307&&20131', '1'),
('2014-03-24 07:31:34', 451, 7, 1, 11, '2013011008', 1, 3, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5377&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&335&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-307&&20131', '1'),
('2014-03-24 07:31:34', 452, 7, 1, 12, '2013011008', 1, 3, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5377&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&335&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-307&&20131', '1'),
('2014-03-24 07:31:34', 453, 7, 1, 13, '2013011008', 1, 3, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5377&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&335&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-307&&20131', '1'),
('2014-03-24 07:31:34', 454, 7, 1, 14, '2013011008', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5377&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&335&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-307&&20131', '1'),
('2014-03-24 07:31:34', 455, 7, 1, 15, '2013011008', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5377&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&335&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-307&&20131', '1'),
('2014-03-24 07:31:34', 456, 7, 1, 16, '2013011008', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5377&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&335&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-307&&20131', '1'),
('2014-03-24 07:31:34', 457, 7, 1, 17, '2013011008', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5377&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&335&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-307&&20131', '1'),
('2014-03-24 07:31:34', 458, 7, 1, 18, '2013011008', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5377&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&335&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-307&&20131', '1'),
('2014-03-24 07:31:34', 459, 7, 1, 19, '2013011008', 1, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5377&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&335&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-307&&20131', '1'),
('2014-03-24 07:31:34', 460, 7, 1, 20, '2013011008', 1, NULL, NULL, '', 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5377&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&335&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-307&&20131', '1'),
('2014-03-24 07:31:46', 461, 7, 1, 1, '2013011008', 1, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5376&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131', '1'),
('2014-03-24 07:31:46', 462, 7, 1, 2, '2013011008', 1, 6, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5376&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131', '1'),
('2014-03-24 07:31:46', 463, 7, 1, 3, '2013011008', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5376&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131', '1'),
('2014-03-24 07:31:46', 464, 7, 1, 4, '2013011008', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5376&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131', '1'),
('2014-03-24 07:31:46', 465, 7, 1, 5, '2013011008', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5376&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131', '1'),
('2014-03-24 07:31:46', 466, 7, 1, 6, '2013011008', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5376&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131', '1'),
('2014-03-24 07:31:46', 467, 7, 1, 7, '2013011008', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5376&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131', '1'),
('2014-03-24 07:31:46', 468, 7, 1, 8, '2013011008', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5376&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131', '1'),
('2014-03-24 07:31:46', 469, 7, 1, 9, '2013011008', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5376&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131', '1'),
('2014-03-24 07:31:46', 470, 7, 1, 10, '2013011008', 1, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5376&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131', '1'),
('2014-03-24 07:31:46', 471, 7, 1, 11, '2013011008', 1, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5376&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131', '1'),
('2014-03-24 07:31:46', 472, 7, 1, 12, '2013011008', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5376&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131', '1'),
('2014-03-24 07:31:46', 473, 7, 1, 13, '2013011008', 1, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5376&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131', '1'),
('2014-03-24 07:31:46', 474, 7, 1, 14, '2013011008', 1, 4, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5376&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131', '1'),
('2014-03-24 07:31:46', 475, 7, 1, 15, '2013011008', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5376&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131', '1'),
('2014-03-24 07:31:46', 476, 7, 1, 16, '2013011008', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5376&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131', '1'),
('2014-03-24 07:31:46', 477, 7, 1, 17, '2013011008', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5376&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131', '1'),
('2014-03-24 07:31:46', 478, 7, 1, 18, '2013011008', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5376&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131', '1'),
('2014-03-24 07:31:46', 479, 7, 1, 19, '2013011008', 1, 5, NULL, NULL, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5376&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131', '1'),
('2014-03-24 07:31:46', 480, 7, 1, 20, '2013011008', 1, NULL, NULL, '', 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5376&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131', '1');

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
  `custom_data2` text NOT NULL,
  PRIMARY KEY (`id_jawaban_header`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=25 ;

--
-- Dumping data for table `jawaban_header`
--

INSERT INTO `jawaban_header` (`created_at`, `id_jawaban_header`, `id_periode`, `id_kuesioner`, `respondent_id`, `respon_ke`, `custom_data`, `custom_data2`) VALUES
('2014-03-24 07:05:47', 1, 7, 1, '2013011001', 1, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:06:00', 2, 7, 1, '2013011001', 2, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5494&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:06:08', 3, 7, 1, '2013011001', 1, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5493&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:07:25', 4, 7, 1, '2013011002', 1, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:07:51', 5, 7, 1, '2013011002', 2, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7350&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:08:12', 6, 7, 1, '2013011002', 1, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&7382&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:09:08', 7, 7, 1, '2013011003', 1, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '1'),
('2014-03-24 07:09:13', 8, 7, 1, '2013011003', 2, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5532&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&346&&4&&Kamis&&Thursday&&08:00:00&&10:30:00&&B-307&&20131', '2'),
('2014-03-24 07:09:40', 9, 7, 1, '2013011003', 1, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5530&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&334&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-304&&20131', '1'),
('2014-03-24 07:11:12', 10, 7, 1, '2013011005', 1, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:11:30', 11, 7, 1, '2013011005', 2, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8056&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&331&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '2'),
('2014-03-24 07:11:50', 12, 7, 1, '2013011005', 1, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&8055&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&321&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:19:44', 13, 7, 1, '2013021001', 1, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5556&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:19:59', 14, 7, 1, '2013021001', 1, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5555&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:20:50', 15, 7, 1, '2013021002', 1, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5458&&1524&&MGT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&448&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:20:55', 16, 7, 1, '2013021002', 1, 'MGT&&Manajemen&&Management&&REG&&Reguler&&SISFO&&5457&&1525&&MGT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&442&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:22:07', 17, 7, 1, '2013031001', 1, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5744&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:22:20', 18, 7, 1, '2013031001', 1, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5743&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:23:48', 19, 7, 1, '2013031003', 1, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5440&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&592&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-307&&20131', '1'),
('2014-03-24 07:24:10', 20, 7, 1, '2013031003', 1, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&5439&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&569&&2&&Selasa&&Tuesday&&08:00:00&&10:30:00&&A-308&&20131', '1'),
('2014-03-24 07:25:57', 21, 7, 1, '2013031006', 1, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6064&&1588&&PSI&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT009&&Frinadiniarta Nur S&&&&625&&5&&Jumat&&Friday&&13:00:00&&15:30:00&&A-307&&20131', '1'),
('2014-03-24 07:26:02', 22, 7, 1, '2013031006', 1, 'PSI&&Psikologi&&Psychology&&REG&&Reguler&&SISFO&&6062&&1587&&PSI&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT007&&Fristian Hadinata&&&&618&&4&&Kamis&&Thursday&&11:00:00&&13:30:00&&B-307&&20131', '1'),
('2014-03-24 07:31:34', 23, 7, 1, '2013011008', 1, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5377&&1204&&AKT&&1&&LSE101&&BAHASA INDONESIA 1 (KECAKAPAN BERPIKIR)&&DTT022&&Fransiscus Asisi Datang&&&&335&&2&&Selasa&&Tuesday&&13:50:00&&16:20:00&&A-307&&20131', '1'),
('2014-03-24 07:31:46', 24, 7, 1, '2013011008', 1, 'AKT&&Akuntansi&&Accounting&&REG&&Reguler&&SISFO&&5376&&1205&&AKT&&1&&LSE103&&BAHASA INGGRIS 1 (ENGLISH AS A FOREIGN LANGUAGE)&&DTT008&&Andi Dagmarbumi Batasuri&&&&328&&2&&Selasa&&Tuesday&&11:00:00&&13:30:00&&A-304&&20131', '1');

-- --------------------------------------------------------

--
-- Stand-in structure for view `jawaban_header_edom`
--
CREATE TABLE IF NOT EXISTS `jawaban_header_edom` (
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
(1, 'dflt_pilihan=5', 'Evaluasi Dosen Oleh Mahasiswa (EDOM) versi Jan-2014', 'EDOM', '<table>\n<tr><td class="width-set4" style="font-size:150%; text-align: center; padding-bottom:.5em;"><b>LEMBAR EVALUASI DOSEN OLEH MAHASISWA</b></td></tr>\n<tr><td style="text-align:justify;">Untuk meningkatkan kualitas pengajaran dan kualitas akademik, harap melengkapi lembar evaluasi ini secara jujur, obyektif dan penuh tanggung jawab. Informasi yang Saudara berikan hanya digunakan dalam proses evaluasi dosen dan tidak akan berpengaruh terhadap status Saudara sebagai mahasiswa.</td></tr>\n<tr><td style="padding-top:.5em;"><span style="width:115px; display:inline-block;">Nama Dosen</span>: {Nama_Dosen}</td></tr>\n<tr><td><span style="width:115px; display:inline-block;">Mata Kuliah</span>: {Nama_MK}</td>\n<tr><td style="padding-bottom:.5em;"><span style="width:115px; display:inline-block;">Tahun Akademik</span>: {TahunID}</td></tr>\n<tr><td style="font-size:90%; text-align:justify; padding-bottom:1em;">Skor Penilaian : 1 = Sangat tidak baik, 2 = Tidak baik, 3 = Agak baik, 4 = Cukup baik, 5 = Baik, 6 = Sangat baik.</td></tr>\n</table>\n\n<table class="bordered">\n<tr class="centered"><td class="width-set2" rowspan="2"></td><td rowspan="2"><b>Aspek Yang Dinilai</b></td><td colspan="6"><b>Skor Penilaian</b></td></tr>\n<tr class="centered"><td><b>1</b></td><td><b>2</b></td><td><b>3</b></td><td><b>4</b></td><td><b>5</b></td><td><b>6</b></td></tr>\n<!--</table>-->'),
(2, 'dflt_pilihan=5;dflt_pilihan2=5', 'Kepuasan Mahasiswa versi Jan-2014', 'KM', '');

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
  `custom_data2_format` text NOT NULL,
  `data_helper` varchar(255) NOT NULL COMMENT 'data yang dapat digunakan dalam koding',
  `separator` varchar(5) NOT NULL COMMENT 'separator di custom_data & throwed_data',
  PRIMARY KEY (`id_periode`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `periode`
--

INSERT INTO `periode` (`id_periode`, `id_kuesioner`, `deskripsi`, `deskripsi_detail`, `waktu_min`, `waktu_maks`, `respondent_id`, `generator_config`, `custom_data_format`, `custom_data2_format`, `data_helper`, `separator`) VALUES
(1, 1, 'EDOM 2013/2014 Mata Kuliah {Nama_MK}', 'EDOM 2013/2014 Ganjil (UTS) Mata Kuliah {Nama_MK}', '2014-02-24 17:00:00', '2014-03-01 17:00:00', 'sisfo_get_username()', 'db="sisfo";sql="SELECT k.MKID AS MKID, k.MKKode AS MKKode, k.Nama AS Nama_MK, j.DosenID AS DosenID, d.Nama AS Nama_Dosen, mk.Sesi AS Sesi\nFROM krs k\nLEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID\nLEFT OUTER JOIN dosen d ON j.DosenID = d.Login\nLEFT OUTER JOIN mk mk ON k.MKID = mk.MKID\nWHERE k.MhswID = ''{respondent_id}'' AND k.TahunID = ''20131''"', '{MKID};{MKKode};{Nama_MK};{Sesi};{DosenID};{Nama_Dosen};20132', '', '', ''),
(2, 2, 'Survey Kepuasan Mahasiswa 2013/2014', 'Survey Kepuasan Mahasiswa 2013/2014 Genap', '2014-02-24 17:00:00', '2014-03-02 17:00:00', 'sisfo_get_username()', 'db="sisfo";sql="SELECT m.MhswID FROM mhsw m WHERE m.Login = ''{respondent_id}''"', '', '', '', ''),
(3, 2, 'Survey Kepuasan Mahasiswa 2014/2015</td><td>', 'Survey Kepuasan Mahasiswa 2014/2015 Ganjil', '2014-02-24 17:00:00', '2014-03-07 17:00:00', 'sisfo_get_username()', 'db="sisfo";sql="SELECT m.MhswID FROM mhsw m WHERE m.Login = ''{respondent_id}''"', '', '', '', ''),
(4, 1, '{Nama_MK}</td><td>{Nama_Dosen}', 'EDOM 2013/2014 Genap (UTS) Mata Kuliah {Nama_MK} Oleh {Nama_Dosen}', '2014-03-03 17:00:00', '2014-03-18 17:00:00', 'sisfo_get_username()', 'db="sisfo";sql="SELECT *\nFROM (\nSELECT m.ProdiID AS mhsw_ProdiID, p.Nama AS mhsw_Nama_Prodi, p.Nama_en AS mhsw_Nama_Prodi_en, m.ProgramID AS mhsw_ProgramID, pr.Nama AS mhsw_Nama_Program, k.KRSID,\nk.MKID AS MKID, mk.Sesi AS Sesi, k.MKKode AS MKKode, k.Nama AS Nama_MK, j.DosenID AS DosenID, d.Nama AS Nama_Dosen, d.Homebase AS Homebase,\n1 AS order_no, -1 AS is_same, 20131 AS tahun, k.JadwalID AS JadwalID\nFROM krs k\nLEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID\nLEFT OUTER JOIN dosen d ON j.DosenID = d.Login\nLEFT OUTER JOIN mk mk ON k.MKID = mk.MKID\nLEFT OUTER JOIN mhsw m ON k.MhswID = m.MhswID\nLEFT OUTER JOIN prodi p ON m.ProdiID = p.ProdiID\nLEFT OUTER JOIN program pr ON m.ProgramID = pr.ProgramID\nWHERE k.MhswID = ''{respondent_id}'' AND k.TahunID = ''20131'' AND j.NA = ''N''\nUNION\nSELECT m.ProdiID AS mhsw_ProdiID, p.Nama AS mhsw_Nama_Prodi, p.Nama_en AS mhsw_Nama_Prodi_en, m.ProgramID AS mhsw_ProgramID, pr.Nama AS mhsw_Nama_Program, k.KRSID,\nk.MKID AS MKID, mk.Sesi AS Sesi, k.MKKode AS MKKode, k.Nama AS Nama_MK, IF(ISNULL(jd.DosenID), j.DosenID, jd.DosenID) AS DosenID, IF(ISNULL(jd.DosenID), d.Nama, dsn.Nama) AS Nama_Dosen, IF(ISNULL(jd.DosenID), d.Homebase, dsn.Homebase) AS Homebase,\n2 AS order_no, IF(ISNULL(jd.DosenID), 1, 0) AS is_same, 20131 AS tahun, k.JadwalID AS JadwalID\nFROM krs k\nLEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID\nLEFT OUTER JOIN dosen d ON j.DosenID = d.Login\nLEFT OUTER JOIN mk mk ON k.MKID = mk.MKID\nLEFT OUTER JOIN jadwaldosen jd ON k.JadwalID = jd.JadwalID\nLEFT OUTER JOIN dosen dsn ON jd.DosenID = dsn.Login\nLEFT OUTER JOIN mhsw m ON k.MhswID = m.MhswID\nLEFT OUTER JOIN prodi p ON m.ProdiID = p.ProdiID\nLEFT OUTER JOIN program pr ON m.ProgramID = pr.ProgramID\nWHERE k.MhswID = ''{respondent_id}'' AND k.TahunID = ''20131'' AND j.NA = ''N''\n) aa\nORDER BY aa.MKKode, aa.Nama_MK, aa.order_no, aa.Nama_Dosen;"', '{mhsw_ProdiID};{mhsw_Nama_Prodi};{mhsw_Nama_Prodi_en};{mhsw_ProgramID};{mhsw_Nama_Program};{KRSID};{MKID};{Sesi};{MKKode};{Nama_MK};{DosenID};{Nama_Dosen};{Homebase};{order_no};{tahun};{JadwalID}', '', '{is_same}', ''),
(5, 1, '{Nama_MK}</td><td>{Nama_Dosen}', 'EDOM BARU SEPARATOR LAMA', '2014-03-18 17:00:00', '2014-03-19 16:59:59', 'sisfo_get_username()', 'db="sisfo";sql="SELECT *\nFROM (\nSELECT 1 AS order_no, -1 AS is_same, m.ProdiID AS mhsw_ProdiID, p.Nama AS mhsw_Nama_Prodi, p.Nama_en AS mhsw_Nama_Prodi_en, m.ProgramID AS mhsw_ProgramID, pr.Nama AS mhsw_Nama_Program, j.KodeID, k.KRSID,\nj.MKID AS MKID, j.ProdiID, mk.Sesi AS Sesi, j.MKKode AS MKKode, j.Nama AS Nama_MK, j.DosenID AS DosenID, d.Nama AS Nama_Dosen, d.Homebase AS Homebase,\nj.JadwalID AS JadwalID, j.HariID, h.Nama AS Hari, h.Nama_en AS Hari_en, j.JamMulai, j.JamSelesai, j.RuangID, k.TahunID\nFROM krs k\nLEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID\nLEFT OUTER JOIN dosen d ON j.DosenID = d.Login\nLEFT OUTER JOIN mk mk ON k.MKID = mk.MKID\nLEFT OUTER JOIN mhsw m ON k.MhswID = m.MhswID\nLEFT OUTER JOIN prodi p ON m.ProdiID = p.ProdiID\nLEFT OUTER JOIN program pr ON m.ProgramID = pr.ProgramID\nLEFT OUTER JOIN hari h ON j.HariID = h.HariID\nWHERE k.MhswID = ''{respondent_id}'' AND k.TahunID = ''20131'' AND k.NA = ''N''\nUNION\nSELECT 2 AS order_no, IF(ISNULL(jd.DosenID), 1, 0) AS is_same, m.ProdiID AS mhsw_ProdiID, p.Nama AS mhsw_Nama_Prodi, p.Nama_en AS mhsw_Nama_Prodi_en, m.ProgramID AS mhsw_ProgramID, pr.Nama AS mhsw_Nama_Program, j.KodeID, k.KRSID,\nj.MKID AS MKID, j.ProdiID, mk.Sesi AS Sesi, j.MKKode AS MKKode, j.Nama AS Nama_MK, IF(ISNULL(jd.DosenID), j.DosenID, jd.DosenID) AS DosenID, IF(ISNULL(jd.DosenID), d.Nama, dsn.Nama) AS Nama_Dosen, IF(ISNULL(jd.DosenID), d.Homebase, dsn.Homebase) AS Homebase,\nj.JadwalID AS JadwalID, j.HariID, h.Nama AS Hari, h.Nama_en AS Hari_en, j.JamMulai, j.JamSelesai, j.RuangID, k.TahunID\nFROM krs k\nLEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID\nLEFT OUTER JOIN dosen d ON j.DosenID = d.Login\nLEFT OUTER JOIN mk mk ON k.MKID = mk.MKID\nLEFT OUTER JOIN jadwaldosen jd ON k.JadwalID = jd.JadwalID\nLEFT OUTER JOIN dosen dsn ON jd.DosenID = dsn.Login\nLEFT OUTER JOIN mhsw m ON k.MhswID = m.MhswID\nLEFT OUTER JOIN prodi p ON m.ProdiID = p.ProdiID\nLEFT OUTER JOIN program pr ON m.ProgramID = pr.ProgramID\nLEFT OUTER JOIN hari h ON j.HariID = h.HariID\nWHERE k.MhswID = ''{respondent_id}'' AND k.TahunID = ''20131'' AND k.NA = ''N''\n) aa\nORDER BY aa.MKKode, aa.Nama_MK, aa.order_no, aa.Nama_Dosen"', '{mhsw_ProdiID};{mhsw_Nama_Prodi};{mhsw_Nama_Prodi_en};{mhsw_ProgramID};{mhsw_Nama_Program};{KodeID};{KRSID};{MKID};{ProdiID};{Sesi};{MKKode};{Nama_MK};{DosenID};{Nama_Dosen};{Homebase};{order_no};{JadwalID};{HariID};{Hari};{Hari_en};{JamMulai};{JamSelesai};{RuangID};{TahunID}', '', '{is_same}', ';'),
(6, 1, '{Nama_MK}</td><td>{Nama_Dosen}', 'EDOM BARU', '2014-03-18 17:00:00', '2014-03-23 16:59:59', 'sisfo_get_username()', 'db="sisfo";sql="SELECT *\nFROM (\nSELECT 1 AS order_no, -1 AS is_same, m.ProdiID AS mhsw_ProdiID, p.Nama AS mhsw_Nama_Prodi, p.Nama_en AS mhsw_Nama_Prodi_en, m.ProgramID AS mhsw_ProgramID, pr.Nama AS mhsw_Nama_Program, j.KodeID, k.KRSID,\nj.MKID AS MKID, j.ProdiID, mk.Sesi AS Sesi, j.MKKode AS MKKode, j.Nama AS Nama_MK, j.DosenID AS DosenID, d.Nama AS Nama_Dosen, d.Homebase AS Homebase,\nj.JadwalID AS JadwalID, j.HariID, h.Nama AS Hari, h.Nama_en AS Hari_en, j.JamMulai, j.JamSelesai, j.RuangID, k.TahunID\nFROM krs k\nLEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID\nLEFT OUTER JOIN dosen d ON j.DosenID = d.Login\nLEFT OUTER JOIN mk mk ON k.MKID = mk.MKID\nLEFT OUTER JOIN mhsw m ON k.MhswID = m.MhswID\nLEFT OUTER JOIN prodi p ON m.ProdiID = p.ProdiID\nLEFT OUTER JOIN program pr ON m.ProgramID = pr.ProgramID\nLEFT OUTER JOIN hari h ON j.HariID = h.HariID\nWHERE k.MhswID = ''{respondent_id}'' AND k.TahunID = ''20131'' AND k.NA = ''N'' AND k.JadwalID <> 0\nUNION\nSELECT 2 AS order_no, IF(ISNULL(jd.DosenID), 1, 0) AS is_same, m.ProdiID AS mhsw_ProdiID, p.Nama AS mhsw_Nama_Prodi, p.Nama_en AS mhsw_Nama_Prodi_en, m.ProgramID AS mhsw_ProgramID, pr.Nama AS mhsw_Nama_Program, j.KodeID, k.KRSID,\nj.MKID AS MKID, j.ProdiID, mk.Sesi AS Sesi, j.MKKode AS MKKode, j.Nama AS Nama_MK, IF(ISNULL(jd.DosenID), j.DosenID, jd.DosenID) AS DosenID, IF(ISNULL(jd.DosenID), d.Nama, dsn.Nama) AS Nama_Dosen, IF(ISNULL(jd.DosenID), d.Homebase, dsn.Homebase) AS Homebase,\nj.JadwalID AS JadwalID, j.HariID, h.Nama AS Hari, h.Nama_en AS Hari_en, j.JamMulai, j.JamSelesai, j.RuangID, k.TahunID\nFROM krs k\nLEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID\nLEFT OUTER JOIN dosen d ON j.DosenID = d.Login\nLEFT OUTER JOIN mk mk ON k.MKID = mk.MKID\nLEFT OUTER JOIN jadwaldosen jd ON k.JadwalID = jd.JadwalID\nLEFT OUTER JOIN dosen dsn ON jd.DosenID = dsn.Login\nLEFT OUTER JOIN mhsw m ON k.MhswID = m.MhswID\nLEFT OUTER JOIN prodi p ON m.ProdiID = p.ProdiID\nLEFT OUTER JOIN program pr ON m.ProgramID = pr.ProgramID\nLEFT OUTER JOIN hari h ON j.HariID = h.HariID\nWHERE k.MhswID = ''{respondent_id}'' AND k.TahunID = ''20131'' AND k.NA = ''N'' AND k.JadwalID <> 0\n) aa\nORDER BY aa.MKKode, aa.Nama_MK, aa.order_no, aa.Nama_Dosen"', '{mhsw_ProdiID}&&{mhsw_Nama_Prodi}&&{mhsw_Nama_Prodi_en}&&{mhsw_ProgramID}&&{mhsw_Nama_Program}&&{KodeID}&&{KRSID}&&{MKID}&&{ProdiID}&&{Sesi}&&{MKKode}&&{Nama_MK}&&{DosenID}&&{Nama_Dosen}&&{Homebase}&&{order_no}&&{JadwalID}&&{HariID}&&{Hari}&&{Hari_en}&&{JamMulai}&&{JamSelesai}&&{RuangID}&&{TahunID}', '', '{is_same}', '&&'),
(7, 1, '{Nama_MK}<sup>{MKKode}</sup></td><td>{Nama_Dosen}', 'EDOM BARU LAGI', '2014-03-18 17:00:00', '2014-03-25 16:59:59', 'sisfo_get_username()', 'db="sisfo";sql="SELECT *\nFROM (\nSELECT 1 AS order_no, -1 AS is_same, m.ProdiID AS mhsw_ProdiID, p.Nama AS mhsw_Nama_Prodi, p.Nama_en AS mhsw_Nama_Prodi_en, m.ProgramID AS mhsw_ProgramID, pr.Nama AS mhsw_Nama_Program, j.KodeID, k.KRSID,\nj.MKID AS MKID, j.ProdiID, mk.Sesi AS Sesi, j.MKKode AS MKKode, j.Nama AS Nama_MK, j.DosenID AS DosenID, d.Nama AS Nama_Dosen, d.Homebase AS Homebase,\nj.JadwalID AS JadwalID, j.HariID, h.Nama AS Hari, h.Nama_en AS Hari_en, j.JamMulai, j.JamSelesai, j.RuangID, k.TahunID\nFROM krs k\nLEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID\nLEFT OUTER JOIN dosen d ON j.DosenID = d.Login\nLEFT OUTER JOIN mk mk ON k.MKID = mk.MKID\nLEFT OUTER JOIN mhsw m ON k.MhswID = m.MhswID\nLEFT OUTER JOIN prodi p ON m.ProdiID = p.ProdiID\nLEFT OUTER JOIN program pr ON m.ProgramID = pr.ProgramID\nLEFT OUTER JOIN hari h ON j.HariID = h.HariID\nWHERE k.MhswID = ''{respondent_id}'' AND k.TahunID = ''20131'' AND k.NA = ''N'' AND k.JadwalID <> 0\nUNION\nSELECT 2 AS order_no, IF(ISNULL(jd.DosenID), 1, 0) AS is_same, m.ProdiID AS mhsw_ProdiID, p.Nama AS mhsw_Nama_Prodi, p.Nama_en AS mhsw_Nama_Prodi_en, m.ProgramID AS mhsw_ProgramID, pr.Nama AS mhsw_Nama_Program, j.KodeID, k.KRSID,\nj.MKID AS MKID, j.ProdiID, mk.Sesi AS Sesi, j.MKKode AS MKKode, j.Nama AS Nama_MK, IF(ISNULL(jd.DosenID), j.DosenID, jd.DosenID) AS DosenID, IF(ISNULL(jd.DosenID), d.Nama, dsn.Nama) AS Nama_Dosen, IF(ISNULL(jd.DosenID), d.Homebase, dsn.Homebase) AS Homebase,\nj.JadwalID AS JadwalID, j.HariID, h.Nama AS Hari, h.Nama_en AS Hari_en, j.JamMulai, j.JamSelesai, j.RuangID, k.TahunID\nFROM krs k\nLEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID\nLEFT OUTER JOIN dosen d ON j.DosenID = d.Login\nLEFT OUTER JOIN mk mk ON k.MKID = mk.MKID\nLEFT OUTER JOIN jadwaldosen jd ON k.JadwalID = jd.JadwalID\nLEFT OUTER JOIN dosen dsn ON jd.DosenID = dsn.Login\nLEFT OUTER JOIN mhsw m ON k.MhswID = m.MhswID\nLEFT OUTER JOIN prodi p ON m.ProdiID = p.ProdiID\nLEFT OUTER JOIN program pr ON m.ProgramID = pr.ProgramID\nLEFT OUTER JOIN hari h ON j.HariID = h.HariID\nWHERE k.MhswID = ''{respondent_id}'' AND k.TahunID = ''20131'' AND k.NA = ''N'' AND k.JadwalID <> 0\n) aa\nORDER BY aa.MKKode, aa.Nama_MK, aa.order_no, aa.Nama_Dosen"', '{mhsw_ProdiID}&&{mhsw_Nama_Prodi}&&{mhsw_Nama_Prodi_en}&&{mhsw_ProgramID}&&{mhsw_Nama_Program}&&{KodeID}&&{KRSID}&&{MKID}&&{ProdiID}&&{Sesi}&&{MKKode}&&{Nama_MK}&&{DosenID}&&{Nama_Dosen}&&{Homebase}&&{JadwalID}&&{HariID}&&{Hari}&&{Hari_en}&&{JamMulai}&&{JamSelesai}&&{RuangID}&&{TahunID}', '{order_no}', '{is_same}', '&&');

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

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `jawaban_edom` AS select `SPLIT_STRING`(`j`.`custom_data`,'&&',1) AS `mhsw_ProdiID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',2) AS `mhsw_Nama_Prodi`,`SPLIT_STRING`(`j`.`custom_data`,'&&',4) AS `mhsw_ProgramID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',5) AS `mhsw_Nama_Program`,`SPLIT_STRING`(`j`.`custom_data`,'&&',6) AS `KodeID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',7) AS `KRSID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',8) AS `MKID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',9) AS `ProdiID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',10) AS `Sesi`,`SPLIT_STRING`(`j`.`custom_data`,'&&',11) AS `MKKode`,`SPLIT_STRING`(`j`.`custom_data`,'&&',12) AS `Nama_MK`,`SPLIT_STRING`(`j`.`custom_data`,'&&',13) AS `DosenID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',14) AS `Nama_Dosen`,`SPLIT_STRING`(`j`.`custom_data`,'&&',15) AS `Homebase`,`SPLIT_STRING`(`j`.`custom_data`,'&&',16) AS `JadwalID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',17) AS `HariID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',19) AS `Hari`,`SPLIT_STRING`(`j`.`custom_data`,'&&',20) AS `JamMulai`,`SPLIT_STRING`(`j`.`custom_data`,'&&',21) AS `JamSelesai`,`SPLIT_STRING`(`j`.`custom_data`,'&&',22) AS `RuangID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',23) AS `TahunID`,`j`.`id_periode` AS `id_periode`,`j`.`id_kuesioner` AS `id_kuesioner`,`j`.`id_pertanyaan` AS `id_pertanyaan`,`j`.`respondent_id` AS `respondent_id`,`j`.`respon_ke` AS `respon_ke`,`p`.`nilai` AS `jawaban_pilihan`,`p2`.`nilai` AS `jawaban_pilihan2`,`j`.`jawaban_isian` AS `jawaban_isian`,`j`.`created_at` AS `created_at` from (((`jawaban` `j` left join `master_kuesioner` `mk` on((`mk`.`id_kuesioner` = `j`.`id_kuesioner`))) left join `pilihan` `p` on((`p`.`id_pilihan` = `j`.`jawaban_pilihan`))) left join `pilihan` `p2` on((`p`.`id_pilihan` = `j`.`jawaban_pilihan2`))) where ((`mk`.`shortname` = 'EDOM') and if((`SPLIT_STRING`(`j`.`custom_data`,'&&',2) = ''),0,1));

-- --------------------------------------------------------

--
-- Structure for view `jawaban_header_edom`
--
DROP TABLE IF EXISTS `jawaban_header_edom`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `jawaban_header_edom` AS select `SPLIT_STRING`(`j`.`custom_data`,'&&',1) AS `mhsw_ProdiID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',2) AS `mhsw_Nama_Prodi`,`SPLIT_STRING`(`j`.`custom_data`,'&&',4) AS `mhsw_ProgramID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',5) AS `mhsw_Nama_Program`,`SPLIT_STRING`(`j`.`custom_data`,'&&',6) AS `KodeID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',7) AS `KRSID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',8) AS `MKID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',9) AS `ProdiID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',10) AS `Sesi`,`SPLIT_STRING`(`j`.`custom_data`,'&&',11) AS `MKKode`,`SPLIT_STRING`(`j`.`custom_data`,'&&',12) AS `Nama_MK`,`SPLIT_STRING`(`j`.`custom_data`,'&&',13) AS `DosenID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',14) AS `Nama_Dosen`,`SPLIT_STRING`(`j`.`custom_data`,'&&',15) AS `Homebase`,`SPLIT_STRING`(`j`.`custom_data`,'&&',16) AS `JadwalID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',17) AS `HariID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',19) AS `Hari`,`SPLIT_STRING`(`j`.`custom_data`,'&&',20) AS `JamMulai`,`SPLIT_STRING`(`j`.`custom_data`,'&&',21) AS `JamSelesai`,`SPLIT_STRING`(`j`.`custom_data`,'&&',22) AS `RuangID`,`SPLIT_STRING`(`j`.`custom_data`,'&&',23) AS `TahunID`,`j`.`id_periode` AS `id_periode`,`j`.`id_kuesioner` AS `id_kuesioner`,`j`.`respondent_id` AS `respondent_id`,`j`.`respon_ke` AS `respon_ke`,`j`.`created_at` AS `created_at` from (`jawaban_header` `j` left join `master_kuesioner` `mk` on((`mk`.`id_kuesioner` = `j`.`id_kuesioner`))) where ((`mk`.`shortname` = 'EDOM') and if((`SPLIT_STRING`(`j`.`custom_data`,'&&',2) = ''),0,1));

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
