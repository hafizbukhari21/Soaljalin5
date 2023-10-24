-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 24, 2023 at 09:32 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `soalempatjalin`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertTableC` ()   BEGIN

insert into table_c (cardnumber, iss, acq, dest, status_a, status_iss, status_acq, status_dest)
SELECT ta.CARDNUMBER,ta.ISS,ta.ACQ,ta.DEST,ta.STATUS,
issOk.status AS status_issuer ,
acqOk.status AS status_acquirer,
destOk.status AS status_dest
from table_a as ta 
left JOIN (
	SELECT * FROM table_b WHERE STATUS =1 AND SOURCE=acq 
) AS acqOk ON acqOk.CARDNUMBER = ta.CARDNUMBER
left JOIN (
	SELECT * FROM table_b WHERE STATUS =1 AND SOURCE=iss 
) AS issOk ON issOk.CARDNUMBER = ta.CARDNUMBER
left JOIN (
	SELECT * FROM table_b WHERE STATUS =1 AND SOURCE=dest 
) AS destOk ON destOk.CARDNUMBER = ta.CARDNUMBER
WHERE 
(ta.ISS = acqOk.ISS AND ta.ACQ = acqOk.ACQ AND ta.DEST = acqOk.DEST) OR 
(ta.ISS = issOk.ISS AND ta.ACQ = issOk.ACQ AND ta.DEST = issOk.DEST) OR 
(ta.ISS = destOk.ISS AND ta.ACQ = destOk.ACQ AND ta.DEST = destOk.DEST);  

    
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `table_a`
--

CREATE TABLE `table_a` (
  `ID` int(11) NOT NULL,
  `CARDNUMBER` varchar(100) NOT NULL,
  `ISS` varchar(100) NOT NULL,
  `ACQ` varchar(100) NOT NULL,
  `DEST` varchar(100) NOT NULL,
  `STATUS` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `table_a`
--

INSERT INTO `table_a` (`ID`, `CARDNUMBER`, `ISS`, `ACQ`, `DEST`, `STATUS`) VALUES
(1, '123', 'MDR', 'BNI', 'MDR', 1),
(2, '222', 'BCA', 'BCA', 'BNI', 1),
(3, '444', 'BRI', 'BTN', 'BCA', 1);

-- --------------------------------------------------------

--
-- Table structure for table `table_b`
--

CREATE TABLE `table_b` (
  `ID` int(11) NOT NULL,
  `CARDNUMBER` varchar(100) NOT NULL,
  `ISS` varchar(100) NOT NULL,
  `ACQ` varchar(100) NOT NULL,
  `DEST` varchar(100) NOT NULL,
  `STATUS` int(11) NOT NULL,
  `SOURCE` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `table_b`
--

INSERT INTO `table_b` (`ID`, `CARDNUMBER`, `ISS`, `ACQ`, `DEST`, `STATUS`, `SOURCE`) VALUES
(1, '123', 'MDR', 'BNI', 'MDR', 1, 'MDR'),
(2, '123', 'MDR', 'BNI', 'MDR', 0, 'BNI'),
(3, '222', 'BCA', 'BCA', 'BNI', 1, 'BCA'),
(5, '444', 'BRI', 'BTN', 'BCA', 1, 'BRI'),
(6, '444', 'BRI', 'BTN', 'BCA', 0, 'BTN'),
(7, '444', 'BRI', 'BTN', 'BCA', 1, 'BCA');

-- --------------------------------------------------------

--
-- Table structure for table `table_c`
--

CREATE TABLE `table_c` (
  `ID` int(11) NOT NULL,
  `CARDNUMBER` varchar(100) NOT NULL,
  `ISS` varchar(100) NOT NULL,
  `ACQ` varchar(100) NOT NULL,
  `DEST` varchar(100) NOT NULL,
  `STATUS_A` int(11) NOT NULL,
  `STATUS_ISS` int(11) NOT NULL DEFAULT 0,
  `STATUS_ACQ` int(11) NOT NULL DEFAULT 0,
  `STATUS_DEST` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `table_c`
--

INSERT INTO `table_c` (`ID`, `CARDNUMBER`, `ISS`, `ACQ`, `DEST`, `STATUS_A`, `STATUS_ISS`, `STATUS_ACQ`, `STATUS_DEST`) VALUES
(25, '123', 'MDR', 'BNI', 'MDR', 1, 1, 0, 1),
(26, '222', 'BCA', 'BCA', 'BNI', 1, 1, 1, 0),
(27, '444', 'BRI', 'BTN', 'BCA', 1, 1, 0, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `table_a`
--
ALTER TABLE `table_a`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `table_b`
--
ALTER TABLE `table_b`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `CARDNUMBER` (`CARDNUMBER`),
  ADD KEY `CARDNUMBER_2` (`CARDNUMBER`);

--
-- Indexes for table `table_c`
--
ALTER TABLE `table_c`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `table_a`
--
ALTER TABLE `table_a`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `table_b`
--
ALTER TABLE `table_b`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `table_c`
--
ALTER TABLE `table_c`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
