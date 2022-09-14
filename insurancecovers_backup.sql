-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 16, 2021 at 02:45 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `insurancecovers`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `cost_month` (IN `afm` INT, IN `return_date` DATE)  BEGIN
	SET @custID =(SELECT CustomerID 
					FROM Customers
                    WHERE Customers.afm = afm);	SET @cost_of_month = ((SELECT SUM(Cost)
							FROM contracts
                            WHERE Contracts.CustomerID = @custID))/12;
    SET @contracts = (SELECT COUNT(ContractID)
							FROM Contracts
                            WHERE Contracts.CustomerID = @custID);
     SELECT @cost_of_month AS "Συνολικό ποσό πληρωμής", @contracts AS "Πλήθος Συμβολαίων" ;                                        
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `contract_duration` (`x` DATE, `y` DATE) RETURNS INT(11) BEGIN
DECLARE f INT;
SET f= FLOOR(DATEDIFF(x,y)/30);
RETURN f;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `contracts`
--

CREATE TABLE `contracts` (
  `ContractID` int(2) NOT NULL,
  `CoverID` int(2) DEFAULT NULL,
  `StartDate` date DEFAULT NULL,
  `EndDate` date DEFAULT NULL,
  `Cost` float(4,1) DEFAULT NULL,
  `CustomerID` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contracts`
--

INSERT INTO `contracts` (`ContractID`, `CoverID`, `StartDate`, `EndDate`, `Cost`, `CustomerID`) VALUES
(1, 2, '2020-06-15', '2022-06-15', 638.2, 2),
(2, 1, '2018-12-01', '2020-12-01', 358.8, 3),
(3, 4, '2019-03-09', '2021-03-09', 342.1, 1),
(4, 1, '2020-11-14', '2021-11-14', 179.4, 2),
(5, 3, '2019-09-27', '2022-09-27', 281.4, 4);

--
-- Triggers `contracts`
--
DELIMITER $$
CREATE TRIGGER `cost_of_contracts_trigg_ins` AFTER INSERT ON `contracts` FOR EACH ROW BEGIN 
UPDATE 	cost_of_contracts
   SET CostOfContracts = (SELECT SUM(Cost)
							FROM contracts
                            WHERE CustomerID = new.CustomerID)
                            WHERE CustID = new.CustomerID;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `cost_of_contracts_trigg_upd` AFTER UPDATE ON `contracts` FOR EACH ROW BEGIN 
UPDATE 	cost_of_contracts
   SET CostOfContracts = (SELECT SUM(Cost)
							FROM contracts
                            WHERE CustomerID = new.CustomerID)
                            WHERE CustID = new.CustomerID;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `cost_of_contracts`
--

CREATE TABLE `cost_of_contracts` (
  `CustID` int(11) DEFAULT NULL,
  `CostOfContracts` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cost_of_contracts`
--

INSERT INTO `cost_of_contracts` (`CustID`, `CostOfContracts`) VALUES
(1, 342.1),
(2, 857.1),
(3, NULL),
(4, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `coverage`
--

CREATE TABLE `coverage` (
  `CoverageID` int(2) NOT NULL,
  `CoverageName` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `coverage`
--

INSERT INTO `coverage` (`CoverageID`, `CoverageName`) VALUES
(1, 'Ετήσιο check up, Ιατρικές Επισκέψεις'),
(2, 'Επίδομα ανάρρωσης, Καταβολή εξόδων νοσηλείας'),
(3, 'Πυρκαγιά, Κλοπή & ζημιές, Διάρρηξη σωληνώσεων'),
(4, 'ΚΤΕΟ, Ατύχημα,Ολική κλοπή');

-- --------------------------------------------------------

--
-- Table structure for table `covers`
--

CREATE TABLE `covers` (
  `CoverID` int(2) NOT NULL,
  `CoverName` varchar(50) DEFAULT NULL,
  `CostPerYear` float DEFAULT NULL,
  `MinDuration` int(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `covers`
--

INSERT INTO `covers` (`CoverID`, `CoverName`, `CostPerYear`, `MinDuration`) VALUES
(1, 'Ασφάλεια Υγείας', 179.4, 12),
(2, 'Σοβαρής Ασθένειας', 319.1, 12),
(3, 'Ασφάλεια Σπιτιού', 187.62, 24),
(4, 'Ασφάλεια Αυτοκινήτου', 164.3, 6);

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `CustomerID` int(2) NOT NULL,
  `CustomerName` varchar(50) DEFAULT NULL,
  `Address` varchar(50) DEFAULT NULL,
  `PhoneNumber` int(10) DEFAULT NULL,
  `AFM` int(2) DEFAULT NULL,
  `DOY` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`CustomerID`, `CustomerName`, `Address`, `PhoneNumber`, `AFM`, `DOY`) VALUES
(1, 'Δημήτρης Χατζηστεφάνου', 'Ευελιπίδων 69', 2104769852, 180319944, 'Α` Αθηνών'),
(2, 'Στέφανος Χατζηπαύλου', 'Λ. Βασιλίσσης Σοφίας 64', 2105874963, 241119935, 'Δ` Αθηνών'),
(3, 'Παύλος Χατζηκώστας', 'Μιχαλακοπούλου 36', 2106974851, 140419917, 'ΙΔ` Αθηνών'),
(4, 'Κωνσταντίνος Παπαδόπουλος', 'Υμηττού 46', 2107256987, 130619894, 'ΙΓ` Αθηνών');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contracts`
--
ALTER TABLE `contracts`
  ADD PRIMARY KEY (`ContractID`),
  ADD KEY `CoverID` (`CoverID`),
  ADD KEY `CustomerID` (`CustomerID`);

--
-- Indexes for table `coverage`
--
ALTER TABLE `coverage`
  ADD PRIMARY KEY (`CoverageID`);

--
-- Indexes for table `covers`
--
ALTER TABLE `covers`
  ADD PRIMARY KEY (`CoverID`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`CustomerID`),
  ADD UNIQUE KEY `AFM` (`AFM`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `coverage`
--
ALTER TABLE `coverage`
  MODIFY `CoverageID` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `contracts`
--
ALTER TABLE `contracts`
  ADD CONSTRAINT `contracts_ibfk_1` FOREIGN KEY (`CoverID`) REFERENCES `covers` (`CoverID`),
  ADD CONSTRAINT `contracts_ibfk_2` FOREIGN KEY (`CustomerID`) REFERENCES `customers` (`CustomerID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
