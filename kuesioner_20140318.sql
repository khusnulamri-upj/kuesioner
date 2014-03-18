-- phpMyAdmin SQL Dump
-- version 4.0.9
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Mar 18, 2014 at 10:29 AM
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
('0cf8be72c81f6ba13daaf3db4ae7f3c0', '::1', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:27.0) Gecko/20100101 Firefox/27.0', 1394701785, ''),
('684a52235c4928d8ce9a2ce3bd01dcdf', '::1', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:27.0) Gecko/20100101 Firefox/27.0', 1394761662, ''),
('775bf3655d47a5fd3f5828fc29ec418d', '::1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 1394684995, ''),
('f06c493383ea12690d25f6c821ed0236', '::1', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:27.0) Gecko/20100101 Firefox/27.0', 1394761095, '');

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
  `jawaban_pilihan` bigint(20) unsigned DEFAULT NULL,
  `jawaban_pilihan2` bigint(20) unsigned DEFAULT NULL,
  `jawaban_isian` text,
  `custom_data` text,
  PRIMARY KEY (`id_jawaban`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=41 ;

--
-- Dumping data for table `jawaban`
--

INSERT INTO `jawaban` (`created_at`, `id_jawaban`, `id_periode`, `id_kuesioner`, `id_pertanyaan`, `respondent_id`, `jawaban_pilihan`, `jawaban_pilihan2`, `jawaban_isian`, `custom_data`) VALUES
('2014-03-13 02:55:04', 1, 4, 1, 1, '2012021017', 1, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.1110.007;Dalizanolo Hulu;MGT;1;20131;224'),
('2014-03-13 02:55:04', 2, 4, 1, 2, '2012021017', 1, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.1110.007;Dalizanolo Hulu;MGT;1;20131;224'),
('2014-03-13 02:55:04', 3, 4, 1, 3, '2012021017', 1, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.1110.007;Dalizanolo Hulu;MGT;1;20131;224'),
('2014-03-13 02:55:04', 4, 4, 1, 4, '2012021017', 2, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.1110.007;Dalizanolo Hulu;MGT;1;20131;224'),
('2014-03-13 02:55:04', 5, 4, 1, 5, '2012021017', 2, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.1110.007;Dalizanolo Hulu;MGT;1;20131;224'),
('2014-03-13 02:55:04', 6, 4, 1, 6, '2012021017', 2, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.1110.007;Dalizanolo Hulu;MGT;1;20131;224'),
('2014-03-13 02:55:04', 7, 4, 1, 7, '2012021017', 3, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.1110.007;Dalizanolo Hulu;MGT;1;20131;224'),
('2014-03-13 02:55:04', 8, 4, 1, 8, '2012021017', 3, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.1110.007;Dalizanolo Hulu;MGT;1;20131;224'),
('2014-03-13 02:55:04', 9, 4, 1, 9, '2012021017', 3, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.1110.007;Dalizanolo Hulu;MGT;1;20131;224'),
('2014-03-13 02:55:04', 10, 4, 1, 10, '2012021017', 4, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.1110.007;Dalizanolo Hulu;MGT;1;20131;224'),
('2014-03-13 02:55:04', 11, 4, 1, 11, '2012021017', 4, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.1110.007;Dalizanolo Hulu;MGT;1;20131;224'),
('2014-03-13 02:55:04', 12, 4, 1, 12, '2012021017', 4, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.1110.007;Dalizanolo Hulu;MGT;1;20131;224'),
('2014-03-13 02:55:04', 13, 4, 1, 13, '2012021017', 5, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.1110.007;Dalizanolo Hulu;MGT;1;20131;224'),
('2014-03-13 02:55:04', 14, 4, 1, 14, '2012021017', 5, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.1110.007;Dalizanolo Hulu;MGT;1;20131;224'),
('2014-03-13 02:55:04', 15, 4, 1, 15, '2012021017', 5, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.1110.007;Dalizanolo Hulu;MGT;1;20131;224'),
('2014-03-13 02:55:04', 16, 4, 1, 16, '2012021017', 6, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.1110.007;Dalizanolo Hulu;MGT;1;20131;224'),
('2014-03-13 02:55:04', 17, 4, 1, 17, '2012021017', 6, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.1110.007;Dalizanolo Hulu;MGT;1;20131;224'),
('2014-03-13 02:55:04', 18, 4, 1, 18, '2012021017', 6, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.1110.007;Dalizanolo Hulu;MGT;1;20131;224'),
('2014-03-13 02:55:04', 19, 4, 1, 19, '2012021017', 6, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.1110.007;Dalizanolo Hulu;MGT;1;20131;224'),
('2014-03-13 02:55:04', 20, 4, 1, 20, '2012021017', NULL, NULL, '', 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.1110.007;Dalizanolo Hulu;MGT;1;20131;224'),
('2014-03-13 04:04:06', 21, 4, 1, 1, '2012021017', 1, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.0211.037;Veronica Anastasia Melany Kaihatu;PSI;2;20131;224'),
('2014-03-13 04:04:06', 22, 4, 1, 2, '2012021017', 1, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.0211.037;Veronica Anastasia Melany Kaihatu;PSI;2;20131;224'),
('2014-03-13 04:04:06', 23, 4, 1, 3, '2012021017', 1, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.0211.037;Veronica Anastasia Melany Kaihatu;PSI;2;20131;224'),
('2014-03-13 04:04:06', 24, 4, 1, 4, '2012021017', 2, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.0211.037;Veronica Anastasia Melany Kaihatu;PSI;2;20131;224'),
('2014-03-13 04:04:06', 25, 4, 1, 5, '2012021017', 2, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.0211.037;Veronica Anastasia Melany Kaihatu;PSI;2;20131;224'),
('2014-03-13 04:04:06', 26, 4, 1, 6, '2012021017', 2, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.0211.037;Veronica Anastasia Melany Kaihatu;PSI;2;20131;224'),
('2014-03-13 04:04:06', 27, 4, 1, 7, '2012021017', 3, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.0211.037;Veronica Anastasia Melany Kaihatu;PSI;2;20131;224'),
('2014-03-13 04:04:06', 28, 4, 1, 8, '2012021017', 3, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.0211.037;Veronica Anastasia Melany Kaihatu;PSI;2;20131;224'),
('2014-03-13 04:04:06', 29, 4, 1, 9, '2012021017', 3, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.0211.037;Veronica Anastasia Melany Kaihatu;PSI;2;20131;224'),
('2014-03-13 04:04:06', 30, 4, 1, 10, '2012021017', 4, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.0211.037;Veronica Anastasia Melany Kaihatu;PSI;2;20131;224'),
('2014-03-13 04:04:06', 31, 4, 1, 11, '2012021017', 4, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.0211.037;Veronica Anastasia Melany Kaihatu;PSI;2;20131;224'),
('2014-03-13 04:04:06', 32, 4, 1, 12, '2012021017', 4, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.0211.037;Veronica Anastasia Melany Kaihatu;PSI;2;20131;224'),
('2014-03-13 04:04:06', 33, 4, 1, 13, '2012021017', 5, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.0211.037;Veronica Anastasia Melany Kaihatu;PSI;2;20131;224'),
('2014-03-13 04:04:06', 34, 4, 1, 14, '2012021017', 5, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.0211.037;Veronica Anastasia Melany Kaihatu;PSI;2;20131;224'),
('2014-03-13 04:04:06', 35, 4, 1, 15, '2012021017', 5, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.0211.037;Veronica Anastasia Melany Kaihatu;PSI;2;20131;224'),
('2014-03-13 04:04:06', 36, 4, 1, 16, '2012021017', 6, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.0211.037;Veronica Anastasia Melany Kaihatu;PSI;2;20131;224'),
('2014-03-13 04:04:06', 37, 4, 1, 17, '2012021017', 6, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.0211.037;Veronica Anastasia Melany Kaihatu;PSI;2;20131;224'),
('2014-03-13 04:04:06', 38, 4, 1, 18, '2012021017', 6, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.0211.037;Veronica Anastasia Melany Kaihatu;PSI;2;20131;224'),
('2014-03-13 04:04:06', 39, 4, 1, 19, '2012021017', 6, NULL, NULL, 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.0211.037;Veronica Anastasia Melany Kaihatu;PSI;2;20131;224'),
('2014-03-13 04:04:06', 40, 4, 1, 20, '2012021017', NULL, NULL, '', 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.0211.037;Veronica Anastasia Melany Kaihatu;PSI;2;20131;224');

-- --------------------------------------------------------

--
-- Stand-in structure for view `jawaban_edom`
--
CREATE TABLE IF NOT EXISTS `jawaban_edom` (
`mhsw_ProdiID` varchar(255)
,`mhsw_Nama_Prodi` varchar(255)
,`mhsw_ProgramID` varchar(255)
,`mhsw_Nama_Program` varchar(255)
,`KRSID` varchar(255)
,`MKID` varchar(255)
,`MKKode` varchar(255)
,`Nama_MK` varchar(255)
,`DosenID` varchar(255)
,`Nama_Dosen` varchar(255)
,`Homebase` varchar(255)
,`tahun` varchar(255)
,`JadwalID` varchar(255)
,`id_periode` bigint(20) unsigned
,`id_kuesioner` bigint(20) unsigned
,`id_pertanyaan` bigint(20) unsigned
,`respondent_id` varchar(100)
,`jawaban_pilihan` int(11)
,`jawaban_pilihan2` int(11)
,`jawaban_isian` text
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
  `custom_data` text,
  PRIMARY KEY (`id_jawaban_header`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `jawaban_header`
--

INSERT INTO `jawaban_header` (`created_at`, `id_jawaban_header`, `id_periode`, `id_kuesioner`, `respondent_id`, `custom_data`) VALUES
('2014-03-13 02:55:04', 1, 4, 1, '2012021017', 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.1110.007;Dalizanolo Hulu;MGT;1;20131;224'),
('2014-03-13 04:04:06', 2, 4, 1, '2012021017', 'MGT;Manajemen;Management;REG;Reguler;4704;930;3;MGT205;STATISTIKA BISNIS;08.0211.037;Veronica Anastasia Melany Kaihatu;PSI;2;20131;224');

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
  `nama_kuesioner` varchar(100) NOT NULL,
  `shortname` varchar(5) NOT NULL,
  `custom_header` text NOT NULL,
  PRIMARY KEY (`id_kuesioner`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `master_kuesioner`
--

INSERT INTO `master_kuesioner` (`id_kuesioner`, `nama_kuesioner`, `shortname`, `custom_header`) VALUES
(1, 'Evaluasi Dosen Oleh Mahasiswa (EDOM) versi Jan-2014', 'EDOM', '<table>\n<tr><td class="width-set4" style="font-size:150%; text-align: center; padding-bottom:.5em;"><b>LEMBAR EVALUASI DOSEN OLEH MAHASISWA</b></td></tr>\n<tr><td style="text-align:justify;">Untuk meningkatkan kualitas pengajaran dan kualitas akademik, harap melengkapi lembar evaluasi ini secara jujur, obyektif dan penuh tanggung jawab. Informasi yang Saudara berikan hanya digunakan dalam proses evaluasi dosen dan tidak akan berpengaruh terhadap status Saudara sebagai mahasiswa.</td></tr>\n<tr><td style="padding-top:.5em;"><span style="width:115px; display:inline-block;">Nama Dosen</span>: {Nama_Dosen}</td></tr>\n<tr><td><span style="width:115px; display:inline-block;">Mata Kuliah</span>: {Nama_MK}</td>\n<tr><td style="padding-bottom:.5em;"><span style="width:115px; display:inline-block;">Tahun Akademik</span>: {tahun}</td></tr>\n<tr><td style="font-size:90%; text-align:justify; padding-bottom:1em;">Skor Penilaian : 1 = Sangat tidak baik, 2 = Tidak baik, 3 = Agak baik, 4 = Cukup baik, 5 = Baik, 6 = Sangat baik.</td></tr>\n</table>\n\n<table class="bordered">\n<tr class="centered"><td class="width-set2" rowspan="2"></td><td rowspan="2"><b>Aspek Yang Dinilai</b></td><td colspan="6"><b>Skor Penilaian</b></td></tr>\n<tr class="centered"><td><b>1</b></td><td><b>2</b></td><td><b>3</b></td><td><b>4</b></td><td><b>5</b></td><td><b>6</b></td></tr>\n<!--</table>-->'),
(2, 'Kepuasan Mahasiswa versi Jan-2014', 'KM', '');

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
  `custom_data_format` varchar(255) DEFAULT NULL,
  `data_helper` varchar(255) NOT NULL COMMENT 'data yang dapat digunakan dalam koding',
  PRIMARY KEY (`id_periode`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `periode`
--

INSERT INTO `periode` (`id_periode`, `id_kuesioner`, `deskripsi`, `deskripsi_detail`, `waktu_min`, `waktu_maks`, `respondent_id`, `generator_config`, `custom_data_format`, `data_helper`) VALUES
(1, 1, 'EDOM 2013/2014 Mata Kuliah {Nama_MK}', 'EDOM 2013/2014 Genap (UTS) Mata Kuliah {Nama_MK}', '2014-02-24 17:00:00', '2014-03-01 17:00:00', 'sisfo_get_username()', 'db="sisfo";sql="SELECT k.MKID AS MKID, k.MKKode AS MKKode, k.Nama AS Nama_MK, j.DosenID AS DosenID, d.Nama AS Nama_Dosen, mk.Sesi AS Sesi\nFROM krs k\nLEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID\nLEFT OUTER JOIN dosen d ON j.DosenID = d.Login\nLEFT OUTER JOIN mk mk ON k.MKID = mk.MKID\nWHERE k.MhswID = ''{respondent_id}'' AND k.TahunID = ''20132''"', '{MKID};{MKKode};{Nama_MK};{Sesi};{DosenID};{Nama_Dosen};20132', ''),
(2, 2, 'Survey Kepuasan Mahasiswa 2013/2014', 'Survey Kepuasan Mahasiswa 2013/2014 Genap', '2014-02-24 17:00:00', '2014-03-02 17:00:00', 'sisfo_get_username()', 'db="sisfo";sql="SELECT m.MhswID FROM mhsw m WHERE m.Login = ''{respondent_id}''"', '', ''),
(3, 2, 'Survey Kepuasan Mahasiswa 2014/2015</td><td>', 'Survey Kepuasan Mahasiswa 2014/2015 Ganjil', '2014-02-24 17:00:00', '2014-03-07 17:00:00', 'sisfo_get_username()', 'db="sisfo";sql="SELECT m.MhswID FROM mhsw m WHERE m.Login = ''{respondent_id}''"', '', ''),
(4, 1, '{Nama_MK}</td><td>{Nama_Dosen}', 'EDOM 2013/2014 Genap (UTS) Mata Kuliah {Nama_MK} Oleh {Nama_Dosen}', '2014-03-03 17:00:00', '2014-03-30 17:00:00', 'sisfo_get_username()', 'db="sisfo";sql="SELECT *\nFROM (\nSELECT m.ProdiID AS mhsw_ProdiID, p.Nama AS mhsw_Nama_Prodi, p.Nama_en AS mhsw_Nama_Prodi_en, m.ProgramID AS mhsw_ProgramID, pr.Nama AS mhsw_Nama_Program, k.KRSID,\nk.MKID AS MKID, mk.Sesi AS Sesi, k.MKKode AS MKKode, k.Nama AS Nama_MK, j.DosenID AS DosenID, d.Nama AS Nama_Dosen, d.Homebase AS Homebase,\n1 AS order_no, -1 AS is_same, 20131 AS tahun, k.JadwalID AS JadwalID\nFROM krs k\nLEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID\nLEFT OUTER JOIN dosen d ON j.DosenID = d.Login\nLEFT OUTER JOIN mk mk ON k.MKID = mk.MKID\nLEFT OUTER JOIN mhsw m ON k.MhswID = m.MhswID\nLEFT OUTER JOIN prodi p ON m.ProdiID = p.ProdiID\nLEFT OUTER JOIN program pr ON m.ProgramID = pr.ProgramID\nWHERE k.MhswID = ''{respondent_id}'' AND k.TahunID = ''20131'' AND j.NA = ''N''\nUNION\nSELECT m.ProdiID AS mhsw_ProdiID, p.Nama AS mhsw_Nama_Prodi, p.Nama_en AS mhsw_Nama_Prodi_en, m.ProgramID AS mhsw_ProgramID, pr.Nama AS mhsw_Nama_Program, k.KRSID,\nk.MKID AS MKID, mk.Sesi AS Sesi, k.MKKode AS MKKode, k.Nama AS Nama_MK, IF(ISNULL(jd.DosenID), j.DosenID, jd.DosenID) AS DosenID, IF(ISNULL(jd.DosenID), d.Nama, dsn.Nama) AS Nama_Dosen, IF(ISNULL(jd.DosenID), d.Homebase, dsn.Homebase) AS Homebase,\n2 AS order_no, IF(ISNULL(jd.DosenID), 1, 0) AS is_same, 20131 AS tahun, k.JadwalID AS JadwalID\nFROM krs k\nLEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID\nLEFT OUTER JOIN dosen d ON j.DosenID = d.Login\nLEFT OUTER JOIN mk mk ON k.MKID = mk.MKID\nLEFT OUTER JOIN jadwaldosen jd ON k.JadwalID = jd.JadwalID\nLEFT OUTER JOIN dosen dsn ON jd.DosenID = dsn.Login\nLEFT OUTER JOIN mhsw m ON k.MhswID = m.MhswID\nLEFT OUTER JOIN prodi p ON m.ProdiID = p.ProdiID\nLEFT OUTER JOIN program pr ON m.ProgramID = pr.ProgramID\nWHERE k.MhswID = ''{respondent_id}'' AND k.TahunID = ''20131'' AND j.NA = ''N''\n) aa\nORDER BY aa.MKKode, aa.Nama_MK, aa.order_no, aa.Nama_Dosen;"', '{mhsw_ProdiID};{mhsw_Nama_Prodi};{mhsw_Nama_Prodi_en};{mhsw_ProgramID};{mhsw_Nama_Program};{KRSID};{MKID};{Sesi};{MKKode};{Nama_MK};{DosenID};{Nama_Dosen};{Homebase};{order_no};{tahun};{JadwalID}', '{is_same}'),
(5, 1, '{Nama_MK}</td><td>{Nama_Dosen}', 'EDOM 2013/2014 Genap (UTS) Mata Kuliah {Nama_MK} Oleh {Nama_Dosen}', '2014-03-03 17:00:00', '2014-03-11 17:00:00', 'sisfo_get_username()', 'db="sisfo";sql="SELECT *\nFROM (\nSELECT m.ProdiID AS mhsw_ProdiID, p.Nama AS mhsw_Nama_Prodi, p.Nama_en AS mhsw_Nama_Prodi_en, m.ProgramID AS mhsw_ProgramID, pr.Nama AS mhsw_Nama_Program, k.KRSID,\nk.MKID AS MKID, mk.Sesi AS Sesi, k.MKKode AS MKKode, k.Nama AS Nama_MK, j.DosenID AS DosenID, d.Nama AS Nama_Dosen, d.Homebase AS Homebase,\n1 AS order_no, -1 AS is_same, 20132 AS tahun, k.JadwalID AS JadwalID\nFROM krs k\nLEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID\nLEFT OUTER JOIN dosen d ON j.DosenID = d.Login\nLEFT OUTER JOIN mk mk ON k.MKID = mk.MKID\nLEFT OUTER JOIN mhsw m ON k.MhswID = m.MhswID\nLEFT OUTER JOIN prodi p ON m.ProdiID = p.ProdiID\nLEFT OUTER JOIN program pr ON m.ProgramID = pr.ProgramID\nWHERE k.MhswID = ''{respondent_id}'' AND k.TahunID = ''20132'' AND j.NA = ''N''\nUNION\nSELECT m.ProdiID AS mhsw_ProdiID, p.Nama AS mhsw_Nama_Prodi, p.Nama_en AS mhsw_Nama_Prodi_en, m.ProgramID AS mhsw_ProgramID, pr.Nama AS mhsw_Nama_Program, k.KRSID,\nk.MKID AS MKID, mk.Sesi AS Sesi, k.MKKode AS MKKode, k.Nama AS Nama_MK, IF(ISNULL(jd.DosenID), j.DosenID, jd.DosenID) AS DosenID, IF(ISNULL(jd.DosenID), d.Nama, dsn.Nama) AS Nama_Dosen, IF(ISNULL(jd.DosenID), d.Homebase, dsn.Homebase) AS Homebase,\n2 AS order_no, IF(ISNULL(jd.DosenID), 1, 0) AS is_same, 20132 AS tahun, k.JadwalID AS JadwalID\nFROM krs k\nLEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID\nLEFT OUTER JOIN dosen d ON j.DosenID = d.Login\nLEFT OUTER JOIN mk mk ON k.MKID = mk.MKID\nLEFT OUTER JOIN jadwaldosen jd ON k.JadwalID = jd.JadwalID\nLEFT OUTER JOIN dosen dsn ON jd.DosenID = dsn.Login\nLEFT OUTER JOIN mhsw m ON k.MhswID = m.MhswID\nLEFT OUTER JOIN prodi p ON m.ProdiID = p.ProdiID\nLEFT OUTER JOIN program pr ON m.ProgramID = pr.ProgramID\nWHERE k.MhswID = ''{respondent_id}'' AND k.TahunID = ''20132'' AND j.NA = ''N''\n) aa\nORDER BY aa.MKKode, aa.Nama_MK, aa.order_no, aa.Nama_Dosen;"', '{mhsw_ProdiID};{mhsw_Nama_Prodi};{mhsw_Nama_Prodi_en};{mhsw_ProgramID};{mhsw_Nama_Program};{KRSID};{MKID};{Sesi};{MKKode};{Nama_MK};{DosenID};{Nama_Dosen};{Homebase};{order_no};{tahun};{JadwalID}', '{is_same}');

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

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `jawaban_edom` AS select `SPLIT_STRING`(`j`.`custom_data`,';',1) AS `mhsw_ProdiID`,`SPLIT_STRING`(`j`.`custom_data`,';',2) AS `mhsw_Nama_Prodi`,`SPLIT_STRING`(`j`.`custom_data`,';',4) AS `mhsw_ProgramID`,`SPLIT_STRING`(`j`.`custom_data`,';',5) AS `mhsw_Nama_Program`,`SPLIT_STRING`(`j`.`custom_data`,';',6) AS `KRSID`,`SPLIT_STRING`(`j`.`custom_data`,';',7) AS `MKID`,`SPLIT_STRING`(`j`.`custom_data`,';',9) AS `MKKode`,`SPLIT_STRING`(`j`.`custom_data`,';',10) AS `Nama_MK`,`SPLIT_STRING`(`j`.`custom_data`,';',11) AS `DosenID`,`SPLIT_STRING`(`j`.`custom_data`,';',12) AS `Nama_Dosen`,`SPLIT_STRING`(`j`.`custom_data`,';',13) AS `Homebase`,`SPLIT_STRING`(`j`.`custom_data`,';',15) AS `tahun`,`SPLIT_STRING`(`j`.`custom_data`,';',16) AS `JadwalID`,`j`.`id_periode` AS `id_periode`,`j`.`id_kuesioner` AS `id_kuesioner`,`j`.`id_pertanyaan` AS `id_pertanyaan`,`j`.`respondent_id` AS `respondent_id`,`p`.`nilai` AS `jawaban_pilihan`,`p2`.`nilai` AS `jawaban_pilihan2`,`j`.`jawaban_isian` AS `jawaban_isian` from (((`jawaban` `j` left join `master_kuesioner` `mk` on((`mk`.`id_kuesioner` = `j`.`id_kuesioner`))) left join `pilihan` `p` on((`p`.`id_pilihan` = `j`.`jawaban_pilihan`))) left join `pilihan` `p2` on((`p`.`id_pilihan` = `j`.`jawaban_pilihan2`))) where (`mk`.`shortname` = 'EDOM');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
