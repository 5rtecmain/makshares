-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 09, 2026 at 01:47 PM
-- Server version: 8.2.0
-- PHP Version: 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `correspondences`
--

-- --------------------------------------------------------

--
-- Table structure for table `certificates`
--

DROP TABLE IF EXISTS `certificates`;
CREATE TABLE IF NOT EXISTS `certificates` (
  `certificateID` int NOT NULL AUTO_INCREMENT,
  `certificateNumberFrom` int NOT NULL,
  `certificateNumberTo` int DEFAULT NULL,
  `distinctiveNumberFrom` int DEFAULT NULL,
  `distinctiveNumberTo` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `onHand` tinyint(1) DEFAULT NULL,
  `folio` int DEFAULT NULL,
  PRIMARY KEY (`certificateID`),
  KEY `fk_folio_certificates` (`folio`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `certificates`
--

INSERT INTO `certificates` (`certificateID`, `certificateNumberFrom`, `certificateNumberTo`, `distinctiveNumberFrom`, `distinctiveNumberTo`, `quantity`, `onHand`, `folio`) VALUES
(1, 10129, NULL, 3392601, 3392700, 100, 0, NULL),
(2, 11719, NULL, 3726241, 3726250, 10, 0, NULL),
(3, 14553, NULL, 4095565, 4095575, 11, 0, NULL),
(4, 16623, NULL, 4503709, 4503720, 12, 0, NULL),
(5, 18814, NULL, 4948510, 4948522, 13, 0, NULL),
(6, 21326, NULL, 5453110, 5453123, 14, 0, NULL),
(7, 23903, NULL, 6003036, 6003051, 16, 1, NULL),
(8, 27412, NULL, 6899501, 6899526, 26, 1, NULL),
(9, 29649, NULL, 7596604, 7596623, 20, 1, NULL),
(10, 32015, NULL, 8362014, 8362035, 22, 1, NULL),
(11, 35649, NULL, 9996710, 9996757, 48, 1, NULL),
(12, 40634, NULL, 11997240, 11997289, 50, 1, NULL),
(13, 40635, NULL, 11997290, 11997297, 8, 1, NULL),
(14, 44688, NULL, 14398215, 14398264, 50, 1, NULL),
(15, 44689, NULL, 14398265, 14398284, 20, 1, NULL),
(16, 47732, NULL, 15885773, 15885797, 25, 1, NULL),
(17, 47733, NULL, 15885798, 15885814, 17, 1, NULL),
(18, 49878, NULL, 17477502, 17477526, 25, 1, NULL),
(19, 49879, NULL, 17477527, 17477547, 21, 1, NULL),
(20, 51925, NULL, 19222823, 19222872, 50, 1, NULL),
(21, 65699, NULL, 45229830, 45229884, 55, 1, NULL),
(22, 66929, NULL, 52282647, 52282768, 122, 1, NULL),
(23, 68113, NULL, 62732130, 62732276, 147, 1, NULL),
(24, 74650, NULL, 68532265, 68532364, 100, 1, NULL),
(25, 74651, NULL, 68532365, 68532440, 76, 1, NULL),
(26, 83317, NULL, 82234087, 82234186, 100, 1, NULL),
(27, 83318, NULL, 82234187, 82234286, 100, 1, NULL),
(28, 83319, NULL, 82234287, 82234297, 11, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `companies`
--

DROP TABLE IF EXISTS `companies`;
CREATE TABLE IF NOT EXISTS `companies` (
  `companyID` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `ticker` varchar(10) NOT NULL,
  `addressLine1` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `addressLine2` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `city` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `zip` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`companyID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `companies`
--

INSERT INTO `companies` (`companyID`, `name`, `ticker`, `addressLine1`, `addressLine2`, `city`, `zip`) VALUES
(1, 'Abbott Laboratories (Pakistan) Limited', 'ABOT', '', '', '', ''),
(2, 'Al-noor Sugar Mill (Pvt) Limited', 'ALNRS', '', '', '', ''),
(3, 'Exide Pakistan Limited', 'EXIDE', '', '', '', ''),
(4, 'Haleon Pakistan Limited', 'HALEON', '', '', '', ''),
(5, 'Rafhan Maize Products Company Limited', 'RMPL', '', '', '', ''),
(6, 'Reckitt Benckiser Pakistan Limited', 'RBPL', '', '', '', ''),
(7, 'Service Industries Limited', 'SRVI', '', '', '', ''),
(8, 'Shell Pakistan Limited', 'SHEL', '', '', '', ''),
(9, 'Sitara Chemical Industries Limited', 'SCIL', '', '', '', ''),
(10, 'Unilever Foods Pakistan Limited', 'UPFL', '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `folios`
--

DROP TABLE IF EXISTS `folios`;
CREATE TABLE IF NOT EXISTS `folios` (
  `folioID` int NOT NULL AUTO_INCREMENT,
  `folioNumber` varchar(11) NOT NULL,
  `ownerID` int NOT NULL,
  `companyID` int NOT NULL,
  `registrarID` int NOT NULL,
  PRIMARY KEY (`folioID`),
  KEY `fk_owner_folio` (`ownerID`),
  KEY `fk_company_folio` (`companyID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `owners`
--

DROP TABLE IF EXISTS `owners`;
CREATE TABLE IF NOT EXISTS `owners` (
  `ownerID` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `cnic` varchar(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `dod` date DEFAULT NULL,
  PRIMARY KEY (`ownerID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `owners`
--

INSERT INTO `owners` (`ownerID`, `name`, `cnic`, `dob`, `dod`) VALUES
(1, 'Muhammad Ayub Khan', '3520015215387', '1934-07-14', '0000-00-00'),
(2, 'Zainab Bibi', '3520014595382', '1932-01-01', '2004-11-17'),
(3, 'Raja Mohammad Idrees Khan', '3520264071447', '1956-05-01', '0000-00-00'),
(4, 'Raja Muhammad Anees Khan', '3520237955551', '1958-07-24', '0000-00-00'),
(5, 'Muhammad Ilyas Khan', '3520228348195', '1962-05-07', '0000-00-00');

-- --------------------------------------------------------

--
-- Table structure for table `registrars`
--

DROP TABLE IF EXISTS `registrars`;
CREATE TABLE IF NOT EXISTS `registrars` (
  `registrarID` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `ticker` varchar(8) DEFAULT NULL,
  `addressLine1` varchar(30) DEFAULT NULL,
  `addressLine2` varchar(30) DEFAULT NULL,
  `city` varchar(20) DEFAULT NULL,
  `zip` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`registrarID`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `registrars`
--

INSERT INTO `registrars` (`registrarID`, `name`, `ticker`, `addressLine1`, `addressLine2`, `city`, `zip`) VALUES
(1, 'CDC Share Registration Service', 'CDC', NULL, NULL, NULL, NULL),
(2, 'FAMCO Share Registrar Services', 'FAMCO', NULL, NULL, NULL, NULL);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `certificates`
--
ALTER TABLE `certificates`
  ADD CONSTRAINT `fk_folio_certificates` FOREIGN KEY (`folio`) REFERENCES `folios` (`folioID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `folios`
--
ALTER TABLE `folios`
  ADD CONSTRAINT `fk_company_folio` FOREIGN KEY (`companyID`) REFERENCES `companies` (`companyID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_owner_folio` FOREIGN KEY (`ownerID`) REFERENCES `owners` (`ownerID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
