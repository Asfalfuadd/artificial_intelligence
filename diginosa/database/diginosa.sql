-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 11, 2026 at 09:08 PM
-- Server version: 8.4.7
-- PHP Version: 8.5.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `diginosa`
--

-- --------------------------------------------------------

--
-- Table structure for table `conditions`
--

DROP TABLE IF EXISTS `conditions`;
CREATE TABLE IF NOT EXISTS `conditions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `rule_id` int DEFAULT NULL,
  `gejala_kode` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `condition_type` enum('required','support') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `operator_type` enum('AND') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rule_id` (`rule_id`),
  KEY `gejala_kode` (`gejala_kode`)
) ENGINE=MyISAM AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `conditions`
--

INSERT INTO `conditions` (`id`, `rule_id`, `gejala_kode`, `condition_type`, `operator_type`) VALUES
(1, 1, 'G11', 'required', 'AND'),
(2, 1, 'G15', 'required', 'AND'),
(3, 1, 'G04', 'support', 'AND'),
(4, 1, 'G10', 'support', 'AND'),
(5, 1, 'G03', 'support', 'AND'),
(6, 1, 'G22', 'support', 'AND'),
(7, 2, 'G10', 'required', 'AND'),
(8, 2, 'G15', 'required', 'AND'),
(9, 2, 'G11', 'support', 'AND'),
(10, 2, 'G01', 'support', 'AND'),
(11, 2, 'G04', 'support', 'AND'),
(12, 3, 'G04', 'required', 'AND'),
(13, 3, 'G05', 'required', 'AND'),
(14, 3, 'G07', 'support', 'AND'),
(15, 3, 'G10', 'support', 'AND'),
(16, 3, 'G17', 'support', 'AND'),
(17, 3, 'G16', 'support', 'AND'),
(18, 4, 'G10', 'required', 'AND'),
(19, 4, 'G17', 'required', 'AND'),
(20, 4, 'G04', 'support', 'AND'),
(21, 4, 'G05', 'support', 'AND'),
(22, 4, 'G07', 'support', 'AND'),
(23, 5, 'G13', 'required', 'AND'),
(24, 5, 'G14', 'required', 'AND'),
(25, 5, 'G07', 'support', 'AND'),
(26, 5, 'G31', 'support', 'AND'),
(27, 5, 'G32', 'support', 'AND'),
(28, 6, 'G31', 'required', 'AND'),
(29, 6, 'G32', 'required', 'AND'),
(30, 6, 'G13', 'support', 'AND'),
(31, 6, 'G14', 'support', 'AND'),
(32, 6, 'G02', 'support', 'AND'),
(33, 7, 'G06', 'required', 'AND'),
(34, 7, 'G19', 'required', 'AND'),
(35, 7, 'G12', 'support', 'AND'),
(36, 7, 'G16', 'support', 'AND'),
(37, 7, 'G20', 'support', 'AND'),
(38, 7, 'G17', 'support', 'AND'),
(39, 8, 'G06', 'required', 'AND'),
(40, 8, 'G20', 'required', 'AND'),
(41, 8, 'G19', 'support', 'AND'),
(42, 8, 'G12', 'support', 'AND'),
(43, 8, 'G17', 'support', 'AND'),
(44, 9, 'G22', 'required', 'AND'),
(45, 9, 'G07', 'required', 'AND'),
(46, 9, 'G05', 'support', 'AND'),
(47, 9, 'G12', 'support', 'AND'),
(48, 9, 'G16', 'support', 'AND'),
(49, 10, 'G22', 'required', 'AND'),
(50, 10, 'G12', 'required', 'AND'),
(51, 10, 'G07', 'support', 'AND'),
(52, 10, 'G05', 'support', 'AND'),
(53, 10, 'G16', 'support', 'AND'),
(54, 10, 'G13', 'support', 'AND'),
(55, 11, 'G23', 'required', 'AND'),
(56, 11, 'G25', 'support', 'AND'),
(57, 11, 'G26', 'support', 'AND'),
(58, 11, 'G27', 'support', 'AND'),
(59, 11, 'G28', 'support', 'AND'),
(60, 12, 'G24', 'required', 'AND'),
(61, 12, 'G23', 'support', 'AND'),
(62, 12, 'G25', 'support', 'AND'),
(63, 13, 'G25', 'required', 'AND'),
(64, 13, 'G26', 'required', 'AND'),
(65, 13, 'G27', 'support', 'AND'),
(66, 13, 'G28', 'support', 'AND'),
(67, 13, 'G23', 'support', 'AND'),
(68, 14, 'G29', 'required', 'AND'),
(69, 14, 'G30', 'required', 'AND'),
(70, 14, 'G02', 'support', 'AND'),
(71, 14, 'G14', 'support', 'AND'),
(72, 14, 'G31', 'support', 'AND'),
(73, 14, 'G32', 'support', 'AND'),
(74, 15, 'G14', 'required', 'AND'),
(75, 15, 'G31', 'required', 'AND'),
(76, 15, 'G29', 'support', 'AND'),
(77, 15, 'G30', 'support', 'AND'),
(78, 15, 'G32', 'support', 'AND'),
(79, 15, 'G02', 'support', 'AND'),
(80, 16, 'G33', 'required', 'AND'),
(81, 16, 'G34', 'required', 'AND'),
(82, 16, 'G35', 'support', 'AND'),
(83, 16, 'G36', 'support', 'AND'),
(84, 16, 'G37', 'support', 'AND'),
(85, 17, 'G35', 'required', 'AND'),
(86, 17, 'G36', 'required', 'AND'),
(87, 17, 'G33', 'support', 'AND'),
(88, 17, 'G34', 'support', 'AND'),
(89, 17, 'G37', 'support', 'AND'),
(90, 18, 'G08', 'required', 'AND'),
(91, 18, 'G09', 'required', 'AND'),
(92, 18, 'G01', 'support', 'AND'),
(93, 18, 'G15', 'support', 'AND'),
(94, 18, 'G37', 'support', 'AND'),
(95, 19, 'G08', 'required', 'AND'),
(96, 19, 'G15', 'required', 'AND'),
(97, 19, 'G09', 'support', 'AND'),
(98, 19, 'G01', 'support', 'AND'),
(99, 19, 'G37', 'support', 'AND'),
(100, 20, 'G18', 'required', 'AND'),
(101, 20, 'G38', 'required', 'AND'),
(102, 20, 'G07', 'support', 'AND'),
(103, 20, 'G12', 'support', 'AND'),
(104, 20, 'G16', 'support', 'AND'),
(105, 20, 'G21', 'support', 'AND'),
(106, 20, 'G39', 'support', 'AND'),
(107, 21, 'G18', 'required', 'AND'),
(108, 21, 'G39', 'required', 'AND'),
(109, 21, 'G07', 'support', 'AND'),
(110, 21, 'G12', 'support', 'AND'),
(111, 21, 'G21', 'support', 'AND'),
(112, 21, 'G38', 'support', 'AND'),
(113, 22, 'G21', 'required', 'AND'),
(114, 22, 'G12', 'required', 'AND'),
(115, 22, 'G18', 'support', 'AND'),
(116, 22, 'G07', 'support', 'AND'),
(117, 22, 'G38', 'support', 'AND'),
(118, 22, 'G39', 'support', 'AND');

-- --------------------------------------------------------

--
-- Table structure for table `gejala`
--

DROP TABLE IF EXISTS `gejala`;
CREATE TABLE IF NOT EXISTS `gejala` (
  `kode` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`kode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `gejala`
--

INSERT INTO `gejala` (`kode`, `nama`) VALUES
('G01', 'Lampu indikator tidak menyala'),
('G02', 'Tampilan kadang hilang'),
('G03', 'Peringatan baterai CMOS lemah'),
('G04', 'Laptop restart / mati sendiri'),
('G05', 'Laptop hang / error'),
('G06', 'Harddisk tidak terdeteksi'),
('G07', 'Blue screen'),
('G08', 'Tidak charging'),
('G09', 'Charger berkedip'),
('G10', 'Menyala sebentar lalu mati'),
('G11', 'Laptop mati total'),
('G12', 'Gagal booting'),
('G13', 'Layar blank'),
('G14', 'Layar bergaris'),
('G15', 'Tidak ada aliran listrik'),
('G16', 'Sistem lambat'),
('G17', 'Suara aneh'),
('G18', 'Tidak bisa masuk Windows'),
('G19', 'Unknown disk error'),
('G20', 'Retry boot disk'),
('G21', 'Tidak bisa install OS'),
('G22', 'Bunyi beep saat booting'),
('G23', 'Keyboard tidak berfungsi'),
('G24', 'Touchpad tidak berfungsi'),
('G25', 'Beberapa tombol tidak berfungsi'),
('G26', 'Salah input saat mengetik'),
('G27', 'Keyboard mengetik sendiri'),
('G28', 'Tombol Fn tidak berfungsi'),
('G29', 'Layar redup'),
('G30', 'Layar gelap'),
('G31', 'Garis pada layar'),
('G32', 'Sebagian layar tidak tampil'),
('G33', 'Indikator baterai tidak menyala'),
('G34', 'Ada tanda silang pada baterai'),
('G35', 'Baterai tidak penuh'),
('G36', 'Tidak bisa charging ulang'),
('G37', 'Laptop mati saat dicas'),
('G38', 'Terkena virus'),
('G39', 'Update Windows gagal');

-- --------------------------------------------------------

--
-- Table structure for table `kategori`
--

DROP TABLE IF EXISTS `kategori`;
CREATE TABLE IF NOT EXISTS `kategori` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kategori`
--

INSERT INTO `kategori` (`id`, `nama`) VALUES
(25, 'Power & Daya'),
(26, 'Display & Layar'),
(27, 'Booting & Sistem'),
(28, 'Storage & OS'),
(29, 'Input Device'),
(30, 'Baterai');

-- --------------------------------------------------------

--
-- Table structure for table `kategori_gejala`
--

DROP TABLE IF EXISTS `kategori_gejala`;
CREATE TABLE IF NOT EXISTS `kategori_gejala` (
  `id` int NOT NULL AUTO_INCREMENT,
  `kategori` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gejala_kode` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `gejala_kode` (`gejala_kode`)
) ENGINE=MyISAM AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kategori_gejala`
--

INSERT INTO `kategori_gejala` (`id`, `kategori`, `gejala_kode`) VALUES
(1, 'Power & Daya', 'G01'),
(2, 'Power & Daya', 'G04'),
(3, 'Power & Daya', 'G08'),
(4, 'Power & Daya', 'G09'),
(5, 'Power & Daya', 'G10'),
(6, 'Power & Daya', 'G11'),
(7, 'Power & Daya', 'G15'),
(8, 'Display & Layar', 'G02'),
(9, 'Display & Layar', 'G13'),
(10, 'Display & Layar', 'G14'),
(11, 'Display & Layar', 'G29'),
(12, 'Display & Layar', 'G30'),
(13, 'Display & Layar', 'G31'),
(14, 'Display & Layar', 'G32'),
(15, 'Booting & Sistem', 'G03'),
(16, 'Booting & Sistem', 'G05'),
(17, 'Booting & Sistem', 'G07'),
(18, 'Booting & Sistem', 'G12'),
(19, 'Booting & Sistem', 'G16'),
(20, 'Booting & Sistem', 'G17'),
(21, 'Booting & Sistem', 'G22'),
(22, 'Storage & OS', 'G06'),
(23, 'Storage & OS', 'G18'),
(24, 'Storage & OS', 'G19'),
(25, 'Storage & OS', 'G20'),
(26, 'Storage & OS', 'G21'),
(27, 'Storage & OS', 'G38'),
(28, 'Storage & OS', 'G39'),
(29, 'Input Device', 'G23'),
(30, 'Input Device', 'G24'),
(31, 'Input Device', 'G25'),
(32, 'Input Device', 'G26'),
(33, 'Input Device', 'G27'),
(34, 'Input Device', 'G28'),
(35, 'Baterai', 'G33'),
(36, 'Baterai', 'G34'),
(37, 'Baterai', 'G35'),
(38, 'Baterai', 'G36'),
(39, 'Baterai', 'G37');

-- --------------------------------------------------------

--
-- Table structure for table `kerusakan`
--

DROP TABLE IF EXISTS `kerusakan`;
CREATE TABLE IF NOT EXISTS `kerusakan` (
  `kode` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deskripsi` text COLLATE utf8mb4_unicode_ci,
  `solusi` text COLLATE utf8mb4_unicode_ci,
  `icon` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`kode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kerusakan`
--

INSERT INTO `kerusakan` (`kode`, `nama`, `deskripsi`, `solusi`, `icon`) VALUES
('K01', 'Kerusakan Mainboard', 'Mainboard (motherboard) mengalami kerusakan pada komponen utama seperti chipset, kapasitor, atau jalur PCB.', 'Periksa kapasitor yang mengembung atau bocor pada mainboard|Lakukan pengecekan tegangan pada IC power mainboard|Bawa ke teknisi profesional untuk diagnosa lebih lanjut|Pertimbangkan penggantian mainboard jika kerusakan parah', '🔧'),
('K02', 'Kerusakan Processor', 'Processor (CPU) mengalami overheat, kerusakan pin, atau degradasi performa yang menyebabkan laptop tidak stabil.', 'Bersihkan heatsink dan kipas processor dari debu|Ganti thermal paste pada processor|Periksa suhu processor menggunakan software monitoring|Jika processor rusak permanen, perlu diganti oleh teknisi', '⚡'),
('K03', 'Kerusakan VGA / Chipset', 'Kartu grafis (VGA) atau chipset grafis mengalami kerusakan yang menyebabkan masalah tampilan visual.', 'Update atau reinstall driver VGA|Lakukan reballing chipset VGA (oleh teknisi)|Periksa koneksi kabel flex display|Gunakan VGA eksternal sebagai solusi sementara', '🖥️'),
('K04', 'Kerusakan Harddisk', 'Harddisk (HDD/SSD) mengalami bad sector, kerusakan mekanis, atau kegagalan baca/tulis data.', 'Backup data penting segera sebelum harddisk gagal total|Jalankan CHKDSK untuk memperbaiki bad sector ringan|Ganti harddisk dengan SSD baru untuk performa lebih baik|Gunakan software recovery jika data hilang', '💾'),
('K05', 'Kerusakan RAM', 'Modul RAM mengalami kerusakan atau tidak terbaca dengan baik oleh sistem.', 'Cabut dan pasang kembali RAM, bersihkan pin dengan penghapus|Tes RAM satu per satu jika ada lebih dari satu keping|Jalankan Windows Memory Diagnostic atau MemTest86|Ganti modul RAM yang rusak dengan yang baru', '🧩'),
('K06', 'Kerusakan Keyboard / Touchpad', 'Keyboard atau touchpad tidak berfungsi dengan baik, bisa karena kerusakan hardware atau masalah driver.', 'Periksa koneksi kabel flex keyboard/touchpad|Update atau reinstall driver keyboard/touchpad|Bersihkan keyboard dari debu atau cairan yang masuk|Ganti keyboard/touchpad jika kerusakan hardware|Gunakan keyboard/mouse eksternal sebagai solusi sementara', '⌨️'),
('K07', 'Kerusakan LCD', 'Layar LCD mengalami kerusakan seperti dead pixel, garis-garis, atau backlight mati.', 'Periksa kabel flex LCD yang mungkin longgar atau rusak|Periksa inverter backlight (untuk LCD non-LED)|Ganti panel LCD jika ada dead pixel atau garis permanen|Hubungkan ke monitor eksternal untuk memastikan VGA normal', '📺'),
('K08', 'Kerusakan Baterai', 'Baterai laptop tidak dapat menyimpan daya, kembung, atau tidak terdeteksi oleh sistem.', 'Kalibrasi baterai (charge penuh lalu discharge hingga mati)|Periksa kondisi fisik baterai (kembung/bocor)|Reset battery controller melalui BIOS|Ganti baterai dengan yang baru dan original', '🔋'),
('K09', 'Kerusakan Charger', 'Adaptor charger tidak berfungsi dengan baik, kabel rusak, atau output tegangan tidak stabil.', 'Periksa kabel charger dari kerusakan fisik|Tes charger dengan multimeter untuk cek output tegangan|Periksa port charging pada laptop|Ganti charger dengan yang sesuai spesifikasi laptop', '🔌'),
('K10', 'Kerusakan Sistem Operasi', 'Sistem operasi (Windows) mengalami kerusakan file sistem, infeksi virus, atau kegagalan update.', 'Jalankan System File Checker (sfc /scannow)|Lakukan scan antivirus secara menyeluruh|Gunakan System Restore ke titik pemulihan sebelumnya|Reinstall Windows jika kerusakan parah|Backup data penting sebelum melakukan reinstall', '💻');

-- --------------------------------------------------------

--
-- Table structure for table `riwayat_diagnosa`
--

DROP TABLE IF EXISTS `riwayat_diagnosa`;
CREATE TABLE IF NOT EXISTS `riwayat_diagnosa` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tanggal` datetime DEFAULT NULL,
  `gejala` text COLLATE utf8mb4_unicode_ci,
  `hasil` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `confidence` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rules`
--

DROP TABLE IF EXISTS `rules`;
CREATE TABLE IF NOT EXISTS `rules` (
  `id` int NOT NULL AUTO_INCREMENT,
  `kerusakan_kode` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `kerusakan_kode` (`kerusakan_kode`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rules`
--

INSERT INTO `rules` (`id`, `kerusakan_kode`) VALUES
(1, 'K01'),
(2, 'K01'),
(3, 'K02'),
(4, 'K02'),
(5, 'K03'),
(6, 'K03'),
(7, 'K04'),
(8, 'K04'),
(9, 'K05'),
(10, 'K05'),
(11, 'K06'),
(12, 'K06'),
(13, 'K06'),
(14, 'K07'),
(15, 'K07'),
(16, 'K08'),
(17, 'K08'),
(18, 'K09'),
(19, 'K09'),
(20, 'K10'),
(21, 'K10'),
(22, 'K10');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
