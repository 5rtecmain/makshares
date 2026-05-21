-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 16, 2026 at 09:37 AM
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
-- Database: `workflow`
--

-- --------------------------------------------------------

--
-- Table structure for table `action`
--

DROP TABLE IF EXISTS `action`;
CREATE TABLE IF NOT EXISTS `action` (
  `actionID` int NOT NULL AUTO_INCREMENT,
  `actionTypeID` int NOT NULL,
  `processID` int NOT NULL,
  `actionName` varchar(100) NOT NULL,
  `actionDescription` varchar(200) NOT NULL,
  PRIMARY KEY (`actionID`),
  KEY `fk_actiontype_action` (`actionTypeID`),
  KEY `fk_process_action` (`processID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `actiontarget`
--

DROP TABLE IF EXISTS `actiontarget`;
CREATE TABLE IF NOT EXISTS `actiontarget` (
  `actionTargetID` int NOT NULL AUTO_INCREMENT,
  `actionID` int NOT NULL,
  `targetID` int NOT NULL,
  `groupID` int NOT NULL,
  PRIMARY KEY (`actionTargetID`),
  KEY `fk_action_actiontarget` (`actionID`),
  KEY `fk_target_actiontarget` (`targetID`),
  KEY `fk_group_actiontarget` (`groupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `actiontype`
--

DROP TABLE IF EXISTS `actiontype`;
CREATE TABLE IF NOT EXISTS `actiontype` (
  `actionTypeID` int NOT NULL AUTO_INCREMENT,
  `actionName` varchar(200) NOT NULL,
  PRIMARY KEY (`actionTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='actions & activities';

-- --------------------------------------------------------

--
-- Table structure for table `activity`
--

DROP TABLE IF EXISTS `activity`;
CREATE TABLE IF NOT EXISTS `activity` (
  `activityID` int NOT NULL AUTO_INCREMENT,
  `activityTypeID` int NOT NULL,
  `processID` int NOT NULL,
  `activityName` varchar(200) NOT NULL,
  `activityDescription` varchar(300) NOT NULL,
  PRIMARY KEY (`activityID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `activitytarget`
--

DROP TABLE IF EXISTS `activitytarget`;
CREATE TABLE IF NOT EXISTS `activitytarget` (
  `activityTargetID` int NOT NULL AUTO_INCREMENT,
  `activityID` int NOT NULL,
  `targetID` int NOT NULL,
  `groupID` int NOT NULL,
  PRIMARY KEY (`activityTargetID`),
  KEY `fk_activity_activitytarget` (`activityID`),
  KEY `fk_target_activitytarget` (`targetID`),
  KEY `fk_group_activitytarget` (`groupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `activitytype`
--

DROP TABLE IF EXISTS `activitytype`;
CREATE TABLE IF NOT EXISTS `activitytype` (
  `activityTypeID` int NOT NULL AUTO_INCREMENT,
  `activityTypeName` varchar(100) NOT NULL,
  PRIMARY KEY (`activityTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `groupmember`
--

DROP TABLE IF EXISTS `groupmember`;
CREATE TABLE IF NOT EXISTS `groupmember` (
  `groupID` int NOT NULL,
  `userID` int NOT NULL,
  PRIMARY KEY (`groupID`,`userID`),
  KEY `fk_user_groupmember` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
CREATE TABLE IF NOT EXISTS `groups` (
  `groupID` int NOT NULL AUTO_INCREMENT,
  `processID` int NOT NULL,
  PRIMARY KEY (`groupID`),
  KEY `fk_process_group` (`processID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `process`
--

DROP TABLE IF EXISTS `process`;
CREATE TABLE IF NOT EXISTS `process` (
  `processID` int NOT NULL AUTO_INCREMENT,
  `processName` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`processID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `processadmin`
--

DROP TABLE IF EXISTS `processadmin`;
CREATE TABLE IF NOT EXISTS `processadmin` (
  `processID` int NOT NULL,
  `userID` int NOT NULL,
  PRIMARY KEY (`processID`,`userID`),
  KEY `fk_user_processAdmin` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `request`
--

DROP TABLE IF EXISTS `request`;
CREATE TABLE IF NOT EXISTS `request` (
  `requestID` int NOT NULL AUTO_INCREMENT,
  `processID` int NOT NULL,
  `title` varchar(300) NOT NULL,
  `dateRequested` date NOT NULL,
  `userID` int NOT NULL,
  `userFirstName` varchar(12) NOT NULL,
  `currentStateID` int NOT NULL,
  PRIMARY KEY (`requestID`),
  KEY `fk_process_request` (`processID`),
  KEY `fk_user_request` (`userID`),
  KEY `fk_state_request` (`currentStateID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='request or task';

-- --------------------------------------------------------

--
-- Table structure for table `requestactions`
--

DROP TABLE IF EXISTS `requestactions`;
CREATE TABLE IF NOT EXISTS `requestactions` (
  `requestActionID` int NOT NULL AUTO_INCREMENT,
  `requestID` int NOT NULL,
  `actionID` int NOT NULL,
  `transitionID` int NOT NULL,
  `isActive` tinyint NOT NULL,
  `isComplete` tinyint NOT NULL,
  PRIMARY KEY (`requestActionID`),
  KEY `fk_action_requestaction` (`actionID`),
  KEY `fk_request_requestaction` (`requestID`),
  KEY `fk_transition_requestaction` (`transitionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `requestdata`
--

DROP TABLE IF EXISTS `requestdata`;
CREATE TABLE IF NOT EXISTS `requestdata` (
  `requestDataID` int NOT NULL AUTO_INCREMENT,
  `requestID` int NOT NULL,
  `requestDataName` varchar(50) NOT NULL,
  `requestDataValue` varchar(100) NOT NULL,
  PRIMARY KEY (`requestDataID`),
  KEY `fk_request_requestData` (`requestID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `requestfile`
--

DROP TABLE IF EXISTS `requestfile`;
CREATE TABLE IF NOT EXISTS `requestfile` (
  `requestFileID` int NOT NULL AUTO_INCREMENT,
  `requestID` int NOT NULL,
  `userID` int NOT NULL,
  `dateUploaded` datetime DEFAULT NULL,
  `fileName` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `fileContent` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `MIMETtype` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`requestFileID`),
  KEY `fk_request_requestfile` (`requestID`),
  KEY `fk_user_requestfile` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `requestnote`
--

DROP TABLE IF EXISTS `requestnote`;
CREATE TABLE IF NOT EXISTS `requestnote` (
  `requestNoteID` int NOT NULL AUTO_INCREMENT,
  `requestID` int NOT NULL,
  `userID` int NOT NULL,
  `Note` varchar(300) NOT NULL,
  PRIMARY KEY (`requestNoteID`),
  KEY `fk_request_requestnote` (`requestID`),
  KEY `fk_user_requestnote` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `requeststakeholder`
--

DROP TABLE IF EXISTS `requeststakeholder`;
CREATE TABLE IF NOT EXISTS `requeststakeholder` (
  `requestID` int NOT NULL,
  `userID` int NOT NULL,
  PRIMARY KEY (`requestID`,`userID`),
  KEY `fk_user_requeststakeholder` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `state`
--

DROP TABLE IF EXISTS `state`;
CREATE TABLE IF NOT EXISTS `state` (
  `stateID` int NOT NULL AUTO_INCREMENT,
  `stateTypeID` int NOT NULL,
  `stateName` varchar(100) NOT NULL,
  `stateDescription` varchar(200) NOT NULL,
  `processID` int NOT NULL,
  PRIMARY KEY (`stateID`),
  KEY `fk_statetype_state` (`stateTypeID`),
  KEY `fk_process_state` (`processID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stateactivity`
--

DROP TABLE IF EXISTS `stateactivity`;
CREATE TABLE IF NOT EXISTS `stateactivity` (
  `stateID` int NOT NULL,
  `activityID` int NOT NULL,
  PRIMARY KEY (`stateID`,`activityID`),
  KEY `fk_activity_stateactivity` (`activityID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `statetype`
--

DROP TABLE IF EXISTS `statetype`;
CREATE TABLE IF NOT EXISTS `statetype` (
  `stateTypeID` int NOT NULL AUTO_INCREMENT,
  `stateName` varchar(200) NOT NULL,
  PRIMARY KEY (`stateTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `statetype`
--

INSERT INTO `statetype` (`stateTypeID`, `stateName`) VALUES
(1, 'Start'),
(2, 'Normal'),
(3, 'Complete'),
(4, 'Denied'),
(5, 'Cancelled');

-- --------------------------------------------------------

--
-- Table structure for table `target`
--

DROP TABLE IF EXISTS `target`;
CREATE TABLE IF NOT EXISTS `target` (
  `targetID` int NOT NULL AUTO_INCREMENT,
  `targetName` varchar(100) NOT NULL,
  `targetDescription` varchar(200) NOT NULL,
  PRIMARY KEY (`targetID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transitionaction`
--

DROP TABLE IF EXISTS `transitionaction`;
CREATE TABLE IF NOT EXISTS `transitionaction` (
  `transitionID` int NOT NULL AUTO_INCREMENT,
  `actionID` int NOT NULL,
  PRIMARY KEY (`transitionID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transitionactivity`
--

DROP TABLE IF EXISTS `transitionactivity`;
CREATE TABLE IF NOT EXISTS `transitionactivity` (
  `transitionID` int NOT NULL,
  `acitvityID` int NOT NULL,
  PRIMARY KEY (`transitionID`,`acitvityID`),
  KEY `fk_activity_transitionactivity` (`acitvityID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transitions`
--

DROP TABLE IF EXISTS `transitions`;
CREATE TABLE IF NOT EXISTS `transitions` (
  `transitionID` int NOT NULL AUTO_INCREMENT,
  `processID` int NOT NULL,
  `currentStateID` int NOT NULL,
  `nextStateID` int NOT NULL,
  PRIMARY KEY (`transitionID`),
  KEY `fk_process_transition` (`processID`),
  KEY `fk_state_current_transition` (`currentStateID`),
  KEY `fk_state_next_transition` (`nextStateID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `userID` int NOT NULL AUTO_INCREMENT,
  `userFirstName` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `action`
--
ALTER TABLE `action`
  ADD CONSTRAINT `fk_actiontype_action` FOREIGN KEY (`actionTypeID`) REFERENCES `actiontype` (`actionTypeID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_process_action` FOREIGN KEY (`processID`) REFERENCES `process` (`processID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `actiontarget`
--
ALTER TABLE `actiontarget`
  ADD CONSTRAINT `fk_action_actiontarget` FOREIGN KEY (`actionID`) REFERENCES `action` (`actionID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_group_actiontarget` FOREIGN KEY (`groupID`) REFERENCES `groups` (`groupID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_target_actiontarget` FOREIGN KEY (`targetID`) REFERENCES `target` (`targetID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `activitytarget`
--
ALTER TABLE `activitytarget`
  ADD CONSTRAINT `fk_activity_activitytarget` FOREIGN KEY (`activityID`) REFERENCES `activity` (`activityID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_group_activitytarget` FOREIGN KEY (`groupID`) REFERENCES `groups` (`groupID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_target_activitytarget` FOREIGN KEY (`targetID`) REFERENCES `target` (`targetID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `groupmember`
--
ALTER TABLE `groupmember`
  ADD CONSTRAINT `fk_group_groupmember` FOREIGN KEY (`groupID`) REFERENCES `groups` (`groupID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user_groupmember` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `groups`
--
ALTER TABLE `groups`
  ADD CONSTRAINT `fk_process_group` FOREIGN KEY (`processID`) REFERENCES `process` (`processID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `processadmin`
--
ALTER TABLE `processadmin`
  ADD CONSTRAINT `fk_process_processAdmin` FOREIGN KEY (`processID`) REFERENCES `process` (`processID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user_processAdmin` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `request`
--
ALTER TABLE `request`
  ADD CONSTRAINT `fk_process_request` FOREIGN KEY (`processID`) REFERENCES `process` (`processID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_state_request` FOREIGN KEY (`currentStateID`) REFERENCES `state` (`stateID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user_request` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `requestactions`
--
ALTER TABLE `requestactions`
  ADD CONSTRAINT `fk_action_requestaction` FOREIGN KEY (`actionID`) REFERENCES `action` (`actionID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_request_requestaction` FOREIGN KEY (`requestID`) REFERENCES `request` (`requestID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_transition_requestaction` FOREIGN KEY (`transitionID`) REFERENCES `transitions` (`transitionID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `requestdata`
--
ALTER TABLE `requestdata`
  ADD CONSTRAINT `fk_request_requestData` FOREIGN KEY (`requestID`) REFERENCES `request` (`requestID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `requestfile`
--
ALTER TABLE `requestfile`
  ADD CONSTRAINT `fk_request_requestfile` FOREIGN KEY (`requestID`) REFERENCES `request` (`requestID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user_requestfile` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `requestnote`
--
ALTER TABLE `requestnote`
  ADD CONSTRAINT `fk_request_requestnote` FOREIGN KEY (`requestID`) REFERENCES `request` (`requestID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user_requestnote` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `requeststakeholder`
--
ALTER TABLE `requeststakeholder`
  ADD CONSTRAINT `fk_request_requeststakeholder` FOREIGN KEY (`requestID`) REFERENCES `request` (`requestID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user_requeststakeholder` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `state`
--
ALTER TABLE `state`
  ADD CONSTRAINT `fk_process_state` FOREIGN KEY (`processID`) REFERENCES `process` (`processID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_statetype_state` FOREIGN KEY (`stateTypeID`) REFERENCES `statetype` (`stateTypeID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `stateactivity`
--
ALTER TABLE `stateactivity`
  ADD CONSTRAINT `fk_activity_stateactivity` FOREIGN KEY (`activityID`) REFERENCES `activity` (`activityID`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_state_stateactivity` FOREIGN KEY (`stateID`) REFERENCES `state` (`stateID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `transitionactivity`
--
ALTER TABLE `transitionactivity`
  ADD CONSTRAINT `fk_activity_transitionactivity` FOREIGN KEY (`acitvityID`) REFERENCES `activity` (`activityID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_transition_transitionactivity` FOREIGN KEY (`transitionID`) REFERENCES `transitions` (`transitionID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `transitions`
--
ALTER TABLE `transitions`
  ADD CONSTRAINT `fk_process_transition` FOREIGN KEY (`processID`) REFERENCES `process` (`processID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_state_current_transition` FOREIGN KEY (`currentStateID`) REFERENCES `state` (`stateID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_state_next_transition` FOREIGN KEY (`nextStateID`) REFERENCES `state` (`stateID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
