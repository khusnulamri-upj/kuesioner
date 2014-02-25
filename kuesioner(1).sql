-- phpMyAdmin SQL Dump
-- version 4.0.9
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Feb 25, 2014 at 10:30 AM
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
('ed9490a10ae8f13b7f141ad6cfc79475', '::1', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:27.0) Gecko/20100101 Firefox/27.0', 1393320471, '');

-- --------------------------------------------------------

--
-- Table structure for table `grup_pilihan`
--

CREATE TABLE IF NOT EXISTS `grup_pilihan` (
  `id_grup_pilihan` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `deskripsi` text NOT NULL,
  PRIMARY KEY (`id_grup_pilihan`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `grup_pilihan`
--

INSERT INTO `grup_pilihan` (`id_grup_pilihan`, `deskripsi`) VALUES
(1, '1 = Sangat Tidak Baik, 2 = Tidak Baik, 3 = Agak Baik, 4 = Cukup Baik, 5 = Baik, 6 = Sangat Baik'),
(2, '1 = Sangat Tidak Penting, 2 = Tidak Penting, 3 = Kurang Penting, 4 = Cukup Penting, 5 = Penting, 6 = Sangat Penting'),
(3, '1 = Sangat Tidak Puas, 2 = Tidak Puas, 3 = Kurang Puas, 4 = Cukup Puas, 5 = Puas, 6 = Sangat Puas');

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
  `jawaban_pilihan` int(11) DEFAULT NULL,
  `jawaban_isian` text,
  PRIMARY KEY (`id_jawaban`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `jawaban`
--

INSERT INTO `jawaban` (`created_at`, `id_jawaban`, `id_periode`, `id_kuesioner`, `id_pertanyaan`, `respondent_id`, `jawaban_pilihan`, `jawaban_isian`) VALUES
('2014-02-25 08:05:03', 1, 1, 1, 1, '', 1, NULL),
('2014-02-25 08:05:03', 2, 1, 1, 2, '', 1, NULL),
('2014-02-25 08:05:03', 3, 1, 1, 3, '', 6, NULL),
('2014-02-25 08:05:03', 4, 1, 1, 4, '', 6, NULL),
('2014-02-25 08:05:03', 5, 1, 1, 16, '', 6, NULL),
('2014-02-25 08:05:03', 6, 1, 1, 17, '', 6, NULL),
('2014-02-25 08:05:03', 7, 1, 1, 18, '', 1, NULL),
('2014-02-25 08:05:03', 8, 1, 1, 19, '', 1, NULL),
('2014-02-25 08:05:03', 9, 1, 1, 20, '', NULL, 'test');

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
  PRIMARY KEY (`id_kuesioner`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `master_kuesioner`
--

INSERT INTO `master_kuesioner` (`id_kuesioner`, `nama_kuesioner`) VALUES
(1, 'Evaluasi Dosen Oleh Mahasiswa'),
(2, 'Kepuasan Mahasiswa');

-- --------------------------------------------------------

--
-- Table structure for table `master_pertanyaan`
--

CREATE TABLE IF NOT EXISTS `master_pertanyaan` (
  `id_pertanyaan` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_kuesioner` bigint(20) unsigned NOT NULL,
  `isi` text NOT NULL,
  `tipe` enum('pilihan','isian') NOT NULL,
  `id_kategori` bigint(20) unsigned NOT NULL,
  `id_grup_pilihan` bigint(20) unsigned DEFAULT NULL,
  `id_grup_pilihan2` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_pertanyaan`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=52 ;

--
-- Dumping data for table `master_pertanyaan`
--

INSERT INTO `master_pertanyaan` (`id_pertanyaan`, `id_kuesioner`, `isi`, `tipe`, `id_kategori`, `id_grup_pilihan`, `id_grup_pilihan2`) VALUES
(1, 1, 'Kesiapan dosen dalam memberi perkuliahan/praktikum/praktek', 'pilihan', 1, 1, NULL),
(2, 1, 'Kemampuan dosen menyampaikan materi', 'pilihan', 1, 1, NULL),
(3, 1, 'Kemampuan dosen membangkitkan minat terhadap materi', 'pilihan', 1, 1, NULL),
(4, 1, 'Pemanfaatan media dan teknologi pembelajaran dalam menjelaskan materi', 'pilihan', 1, 1, NULL),
(5, 1, 'Keadilan penilaian terhadap mahasiswa', 'pilihan', 1, 1, NULL),
(6, 1, 'Kemampuan dosen membimbing mahasiswa', 'pilihan', 1, 1, NULL),
(7, 1, 'Kesesuaian materi yang disampaikan di kelas dengan silabus', 'pilihan', 1, 1, NULL),
(8, 1, 'Keluasan wawasan keilmuan dosen pada bidang yang diajarkan', 'pilihan', 1, 1, NULL),
(9, 1, 'Kemampuan menunjukkan keterkaitan antara bidang keahlian yang diajarkan', 'pilihan', 1, 1, NULL),
(10, 1, 'Penguasaan akan isu-isu mutakhir dalam bidang yang diajarkan', 'pilihan', 1, 1, NULL),
(11, 1, 'Keteraturan dan ketertiban dosen dalam mempersiapkan perkuliahan', 'pilihan', 1, 1, NULL),
(12, 1, 'Bersikap santun dan menghargai orang lain', 'pilihan', 1, 1, NULL),
(13, 1, 'Bersikap dan berperilaku yang positif', 'pilihan', 1, 1, NULL),
(14, 1, 'Satunya kata dan tindakan', 'pilihan', 1, 1, NULL),
(15, 1, 'Kemampuan dosen mengendalikan diri dalam berbagai situasi dan kondisi', 'pilihan', 1, 1, NULL),
(16, 1, 'Semangat dan antusiasme dosen dalam mendidik', 'pilihan', 1, 1, NULL),
(17, 1, 'Kemampuan dosen dalam menyampaikan pendapat', 'pilihan', 1, 1, NULL),
(18, 1, 'Kemampuan dosen dalam menerima kritik, saran, dan pendapat mahasiswa', 'pilihan', 1, 1, NULL),
(19, 1, 'Kemampuan dosen untuk bergaul di kalangan mahasiswa', 'pilihan', 1, 1, NULL),
(20, 1, 'Saran untuk perbaikan', 'isian', 1, NULL, NULL),
(21, 2, 'Kebersihan dan kerapian ruang kuliah', 'pilihan', 2, 2, 3),
(22, 2, 'Kelengkapan koleksi dan kenyamanan perpustakaan', 'pilihan', 2, 2, 3),
(23, 2, 'Ketersediaan laboratorium sesuai dengan keilmuan', 'pilihan', 2, 2, 3),
(24, 2, 'Laboratorium komputer yang memadai dan mudah diakses', 'pilihan', 2, 2, 3),
(25, 2, 'Kebersihan toilet', 'pilihan', 2, 2, 3),
(26, 2, 'Kebersihan fasilitas ibadah', 'pilihan', 2, 2, 3),
(27, 2, 'Tempat Parkir yang memadai, teratur, dan aman', 'pilihan', 2, 2, 3),
(28, 2, 'Kantin yang memadai dan aman', 'pilihan', 2, 2, 3),
(29, 2, 'Kemudahan akses kampus dengan kendaraan umum', 'pilihan', 2, 2, 3),
(30, 2, 'Staf akademik santun dalam melakukan pelayanan akademik', 'pilihan', 3, 2, 3),
(31, 2, 'Staf akademik mempunyai kemampuan untuk melayani kepentingan mahasiswa', 'pilihan', 3, 2, 3),
(32, 2, 'Staf akademik dapat menyelesaikan tugas/ pekerjaan sesuai janji', 'pilihan', 3, 2, 3),
(33, 2, 'Pelaksanaan ujian dilakukan tepat waktu', 'pilihan', 4, 2, 3),
(34, 2, 'Perkuliahan yang terjadwal baik dan sesuai dengan jadwal', 'pilihan', 4, 2, 3),
(35, 2, 'UPJ menyediakan bantuan (keringanan) bagi mahasiswa tidak mampu', 'pilihan', 4, 2, 3),
(36, 2, 'UPJ selalu membantu mahasiswa apabila menghadapi masalah akademik', 'pilihan', 4, 2, 3),
(37, 2, 'UPJ menyediakan waktu bagi orang tua mahasiswa', 'pilihan', 4, 2, 3),
(38, 2, 'Permasalahan/keluhan mahasiswa selalu ditangani UPJ melalui dosen pembimbing', 'pilihan', 5, 2, 3),
(39, 2, 'Waktu digunakan efektif oleh dosen dalam mengajar', 'pilihan', 5, 2, 3),
(40, 2, 'Adanya sanksi bagi mahasiswa yang melangar peraturan yang ditetapkan', 'pilihan', 5, 2, 3),
(41, 2, 'UPJ selalu berusaha untuk memahami kepentingan dan kesulitan mahasiswa', 'pilihan', 5, 2, 3),
(42, 2, 'UPJ berusaha memahami minat dan bakat mahasiswa dan berusaha  untuk mengembangkannya', 'pilihan', 5, 2, 3);

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
  `deskripsi` varchar(100) NOT NULL,
  `waktu_min` timestamp NULL DEFAULT NULL,
  `waktu_maks` timestamp NULL DEFAULT NULL,
  `respondent_id` varchar(25) NOT NULL COMMENT 'nama fungsi untuk mendapatkan respondent_id',
  `gen_active` tinyint(1) NOT NULL DEFAULT '0',
  `gen_database` text,
  PRIMARY KEY (`id_periode`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `periode`
--

INSERT INTO `periode` (`id_periode`, `id_kuesioner`, `deskripsi`, `waktu_min`, `waktu_maks`, `respondent_id`, `gen_active`, `gen_database`) VALUES
(1, 1, 'EDOM 2013/2014 Genap (UTS)', '2014-02-24 17:00:00', '2014-03-30 17:00:00', 'sisfo_get_username()', 0, 'db:sisfo;sql:"SELECT k.MKID AS MKID, k.MKKode AS MKKode, k.Nama AS Nama_MK, j.DosenID AS DosenID, d.Nama AS Nama_Dosen\nFROM krs k\nLEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID\nLEFT OUTER JOIN dosen d ON j.DosenID = d.Login\nWHERE k.MhswID = ''2011071001'' AND k.TahunID = ''20132''"'),
(2, 2, 'Survey Kepuasan Mahasiswa 2013/2014 Genap', '2014-02-24 17:00:00', '2014-02-27 17:00:00', 'sisfo_get_username()', 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pilihan`
--

CREATE TABLE IF NOT EXISTS `pilihan` (
  `id_pilihan` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_grup_pilihan` bigint(20) unsigned NOT NULL,
  `deskripsi` varchar(100) NOT NULL,
  `nilai` int(11) NOT NULL,
  PRIMARY KEY (`id_pilihan`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=19 ;

--
-- Dumping data for table `pilihan`
--

INSERT INTO `pilihan` (`id_pilihan`, `id_grup_pilihan`, `deskripsi`, `nilai`) VALUES
(1, 1, 'Sangat Tidak Baik', 1),
(2, 1, 'Tidak Baik', 2),
(3, 1, 'Agak Baik', 3),
(4, 1, 'Cukup Baik', 4),
(5, 1, 'Baik', 5),
(6, 1, 'Sangat Baik', 6),
(7, 2, 'Sangat Tidak Penting', 1),
(8, 2, 'Tidak Penting', 2),
(9, 2, 'Kurang Penting', 3),
(10, 2, 'Cukup Penting', 4),
(11, 2, 'Penting', 5),
(12, 2, 'Sangat Penting', 6),
(13, 3, 'Sangat Tidak Puas', 1),
(14, 3, 'Tidak Puas', 2),
(15, 3, 'Kurang Puas', 3),
(16, 3, 'Cukup Puas', 4),
(17, 3, 'Puas', 5),
(18, 3, 'Sangat Puas', 6);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
