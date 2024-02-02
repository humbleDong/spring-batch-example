/*
 Navicat Premium Data Transfer

 Source Server         : Mysql80
 Source Server Type    : MySQL
 Source Server Version : 80034
 Source Host           : localhost:3306
 Source Schema         : springbatch

 Target Server Type    : MySQL
 Target Server Version : 80034
 File Encoding         : 65001

 Date: 02/02/2024 16:21:48
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for batch_job_execution
-- ----------------------------
DROP TABLE IF EXISTS `batch_job_execution`;
CREATE TABLE `batch_job_execution`  (
  `JOB_EXECUTION_ID` bigint(0) NOT NULL,
  `VERSION` bigint(0) NULL DEFAULT NULL,
  `JOB_INSTANCE_ID` bigint(0) NOT NULL,
  `CREATE_TIME` datetime(6) NOT NULL,
  `START_TIME` datetime(6) NULL DEFAULT NULL,
  `END_TIME` datetime(6) NULL DEFAULT NULL,
  `STATUS` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `EXIT_CODE` varchar(2500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `EXIT_MESSAGE` varchar(2500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `LAST_UPDATED` datetime(6) NULL DEFAULT NULL,
  `JOB_CONFIGURATION_LOCATION` varchar(2500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`JOB_EXECUTION_ID`) USING BTREE,
  INDEX `JOB_INST_EXEC_FK`(`JOB_INSTANCE_ID`) USING BTREE,
  CONSTRAINT `JOB_INST_EXEC_FK` FOREIGN KEY (`JOB_INSTANCE_ID`) REFERENCES `batch_job_instance` (`JOB_INSTANCE_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of batch_job_execution
-- ----------------------------
INSERT INTO `batch_job_execution` VALUES (1, 2, 1, '2024-01-31 10:04:36.045000', '2024-01-31 10:04:36.220000', '2024-01-31 10:04:36.432000', 'COMPLETED', 'COMPLETED', '', '2024-01-31 10:04:36.432000', NULL);
INSERT INTO `batch_job_execution` VALUES (2, 2, 2, '2024-01-31 10:12:15.785000', '2024-01-31 10:12:15.864000', '2024-01-31 10:12:16.043000', 'COMPLETED', 'COMPLETED', '', '2024-01-31 10:12:16.044000', NULL);
INSERT INTO `batch_job_execution` VALUES (3, 2, 3, '2024-01-31 15:48:03.211000', '2024-01-31 15:48:03.350000', '2024-01-31 15:48:03.542000', 'COMPLETED', 'COMPLETED', '', '2024-01-31 15:48:03.542000', NULL);
INSERT INTO `batch_job_execution` VALUES (4, 2, 4, '2024-01-31 16:59:18.692000', '2024-01-31 16:59:18.884000', '2024-01-31 16:59:19.094000', 'COMPLETED', 'COMPLETED', '', '2024-01-31 16:59:19.094000', NULL);
INSERT INTO `batch_job_execution` VALUES (5, 2, 5, '2024-01-31 17:55:19.209000', '2024-01-31 17:55:19.412000', '2024-01-31 17:55:19.725000', 'COMPLETED', 'COMPLETED', '', '2024-01-31 17:55:19.725000', NULL);
INSERT INTO `batch_job_execution` VALUES (6, 2, 6, '2024-01-31 17:55:27.965000', '2024-01-31 17:55:28.024000', '2024-01-31 17:55:28.178000', 'COMPLETED', 'COMPLETED', '', '2024-01-31 17:55:28.179000', NULL);
INSERT INTO `batch_job_execution` VALUES (7, 2, 7, '2024-01-31 17:56:16.783000', '2024-01-31 17:56:16.842000', '2024-01-31 17:56:16.988000', 'COMPLETED', 'COMPLETED', '', '2024-01-31 17:56:16.988000', NULL);
INSERT INTO `batch_job_execution` VALUES (8, 2, 8, '2024-01-31 18:04:26.590000', '2024-01-31 18:04:26.656000', '2024-01-31 18:04:26.819000', 'COMPLETED', 'COMPLETED', '', '2024-01-31 18:04:26.820000', NULL);
INSERT INTO `batch_job_execution` VALUES (9, 2, 9, '2024-01-31 18:04:32.712000', '2024-01-31 18:04:32.771000', '2024-01-31 18:04:32.917000', 'COMPLETED', 'COMPLETED', '', '2024-01-31 18:04:32.917000', NULL);
INSERT INTO `batch_job_execution` VALUES (10, 2, 10, '2024-01-31 18:18:29.784000', '2024-01-31 18:18:29.941000', '2024-01-31 18:18:30.129000', 'COMPLETED', 'COMPLETED', '', '2024-01-31 18:18:30.129000', NULL);
INSERT INTO `batch_job_execution` VALUES (11, 2, 11, '2024-01-31 18:28:48.850000', '2024-01-31 18:28:48.918000', '2024-01-31 18:28:49.124000', 'COMPLETED', 'COMPLETED', '', '2024-01-31 18:28:49.125000', NULL);
INSERT INTO `batch_job_execution` VALUES (12, 2, 11, '2024-02-01 10:38:14.647000', '2024-02-01 10:38:14.885000', '2024-02-01 10:38:14.947000', 'COMPLETED', 'NOOP', 'All steps already completed or no steps configured for this job.', '2024-02-01 10:38:14.947000', NULL);
INSERT INTO `batch_job_execution` VALUES (13, 1, 12, '2024-02-01 10:38:23.122000', '2024-02-01 10:38:23.213000', NULL, 'STARTED', 'UNKNOWN', '', '2024-02-01 10:38:23.213000', NULL);
INSERT INTO `batch_job_execution` VALUES (14, 2, 13, '2024-02-01 10:42:03.973000', '2024-02-01 10:42:04.046000', '2024-02-01 10:42:04.242000', 'COMPLETED', 'COMPLETED', '', '2024-02-01 10:42:04.242000', NULL);
INSERT INTO `batch_job_execution` VALUES (15, 2, 14, '2024-02-01 10:43:28.852000', '2024-02-01 10:43:28.961000', '2024-02-01 10:43:29.180000', 'COMPLETED', 'COMPLETED', '', '2024-02-01 10:43:29.180000', NULL);
INSERT INTO `batch_job_execution` VALUES (16, 2, 15, '2024-02-01 10:49:02.108000', '2024-02-01 10:49:02.190000', '2024-02-01 10:49:02.500000', 'COMPLETED', 'COMPLETED', '', '2024-02-01 10:49:02.500000', NULL);
INSERT INTO `batch_job_execution` VALUES (17, 2, 16, '2024-02-01 11:36:45.548000', '2024-02-01 11:36:45.645000', '2024-02-01 11:36:45.803000', 'COMPLETED', 'COMPLETED', '', '2024-02-01 11:36:45.804000', NULL);
INSERT INTO `batch_job_execution` VALUES (18, 2, 17, '2024-02-01 11:57:09.180000', '2024-02-01 11:57:09.250000', '2024-02-01 11:57:09.529000', 'COMPLETED', 'COMPLETED', '', '2024-02-01 11:57:09.530000', NULL);
INSERT INTO `batch_job_execution` VALUES (19, 2, 18, '2024-02-01 15:23:18.260000', '2024-02-01 15:23:18.527000', '2024-02-01 15:23:18.828000', 'COMPLETED', 'COMPLETED', '', '2024-02-01 15:23:18.829000', NULL);
INSERT INTO `batch_job_execution` VALUES (20, 2, 19, '2024-02-01 15:25:03.290000', '2024-02-01 15:25:03.357000', '2024-02-01 15:25:03.774000', 'COMPLETED', 'COMPLETED', '', '2024-02-01 15:25:03.774000', NULL);
INSERT INTO `batch_job_execution` VALUES (21, 2, 20, '2024-02-01 15:42:30.297000', '2024-02-01 15:42:30.365000', '2024-02-01 15:42:30.695000', 'COMPLETED', 'COMPLETED', '', '2024-02-01 15:42:30.696000', NULL);
INSERT INTO `batch_job_execution` VALUES (22, 2, 21, '2024-02-01 16:04:26.966000', '2024-02-01 16:04:27.027000', '2024-02-01 16:04:27.395000', 'COMPLETED', 'COMPLETED', '', '2024-02-01 16:04:27.396000', NULL);
INSERT INTO `batch_job_execution` VALUES (23, 2, 22, '2024-02-01 16:06:06.115000', '2024-02-01 16:06:06.192000', '2024-02-01 16:06:06.534000', 'COMPLETED', 'COMPLETED', '', '2024-02-01 16:06:06.535000', NULL);
INSERT INTO `batch_job_execution` VALUES (24, 2, 23, '2024-02-01 16:07:53.339000', '2024-02-01 16:07:53.402000', '2024-02-01 16:07:54.103000', 'COMPLETED', 'COMPLETED', '', '2024-02-01 16:07:54.104000', NULL);
INSERT INTO `batch_job_execution` VALUES (25, 2, 24, '2024-02-01 16:08:48.047000', '2024-02-01 16:08:48.125000', '2024-02-01 16:08:48.293000', 'COMPLETED', 'COMPLETED', '', '2024-02-01 16:08:48.294000', NULL);
INSERT INTO `batch_job_execution` VALUES (26, 2, 25, '2024-02-01 16:08:59.145000', '2024-02-01 16:08:59.222000', '2024-02-01 16:08:59.397000', 'FAILED', 'FAILED', '', '2024-02-01 16:08:59.397000', NULL);
INSERT INTO `batch_job_execution` VALUES (27, 2, 26, '2024-02-01 16:09:24.453000', '2024-02-01 16:09:24.524000', '2024-02-01 16:09:24.705000', 'COMPLETED', 'COMPLETED', '', '2024-02-01 16:09:24.706000', NULL);
INSERT INTO `batch_job_execution` VALUES (28, 2, 27, '2024-02-01 16:09:35.162000', '2024-02-01 16:09:35.241000', '2024-02-01 16:09:35.685000', 'FAILED', 'FAILED', '', '2024-02-01 16:09:35.685000', NULL);
INSERT INTO `batch_job_execution` VALUES (29, 2, 28, '2024-02-01 16:09:52.746000', '2024-02-01 16:09:52.823000', '2024-02-01 16:09:53.073000', 'STOPPED', 'STOPPED', '', '2024-02-01 16:09:53.073000', NULL);
INSERT INTO `batch_job_execution` VALUES (30, 2, 29, '2024-02-01 16:32:39.067000', '2024-02-01 16:32:39.147000', '2024-02-01 16:32:41.025000', 'COMPLETED', 'COMPLETED', '', '2024-02-01 16:32:41.025000', NULL);
INSERT INTO `batch_job_execution` VALUES (31, 2, 30, '2024-02-01 16:56:42.523000', '2024-02-01 16:56:42.604000', '2024-02-01 16:56:42.783000', 'COMPLETED', 'COMPLETED', '', '2024-02-01 16:56:42.784000', NULL);
INSERT INTO `batch_job_execution` VALUES (32, 2, 31, '2024-02-01 17:13:08.381000', '2024-02-01 17:13:08.564000', '2024-02-01 17:13:08.836000', 'COMPLETED', 'COMPLETED', '', '2024-02-01 17:13:08.837000', NULL);
INSERT INTO `batch_job_execution` VALUES (33, 2, 32, '2024-02-01 17:29:01.990000', '2024-02-01 17:29:02.067000', '2024-02-01 17:29:02.219000', 'COMPLETED', 'COMPLETED', '', '2024-02-01 17:29:02.219000', NULL);
INSERT INTO `batch_job_execution` VALUES (34, 2, 33, '2024-02-01 18:16:07.514000', '2024-02-01 18:16:07.591000', '2024-02-01 18:16:07.793000', 'STOPPED', 'STOPPED', '', '2024-02-01 18:16:07.796000', NULL);
INSERT INTO `batch_job_execution` VALUES (35, 2, 33, '2024-02-01 18:23:39.631000', '2024-02-01 18:23:39.815000', '2024-02-01 18:23:40.175000', 'COMPLETED', 'COMPLETED', '', '2024-02-01 18:23:40.175000', NULL);
INSERT INTO `batch_job_execution` VALUES (36, 2, 34, '2024-02-01 18:31:54.236000', '2024-02-01 18:31:54.471000', '2024-02-01 18:31:54.745000', 'STOPPED', 'STOPPED', 'org.springframework.batch.core.JobInterruptedException', '2024-02-01 18:31:54.745000', NULL);
INSERT INTO `batch_job_execution` VALUES (37, 2, 34, '2024-02-01 18:32:13.484000', '2024-02-01 18:32:13.554000', '2024-02-01 18:32:13.835000', 'COMPLETED', 'COMPLETED', '', '2024-02-01 18:32:13.835000', NULL);
INSERT INTO `batch_job_execution` VALUES (38, 2, 35, '2024-02-02 11:05:26.788000', '2024-02-02 11:05:27.030000', '2024-02-02 11:05:28.004000', 'STOPPED', 'STOPPED', 'org.springframework.batch.core.JobInterruptedException', '2024-02-02 11:05:28.004000', NULL);
INSERT INTO `batch_job_execution` VALUES (39, 2, 36, '2024-02-02 11:16:14.346000', '2024-02-02 11:16:14.426000', '2024-02-02 11:16:14.629000', 'STOPPED', 'STOPPED', 'org.springframework.batch.core.JobInterruptedException', '2024-02-02 11:16:14.629000', NULL);
INSERT INTO `batch_job_execution` VALUES (40, 2, 36, '2024-02-02 11:17:19.245000', '2024-02-02 11:17:19.309000', '2024-02-02 11:17:20.083000', 'COMPLETED', 'COMPLETED', '', '2024-02-02 11:17:20.083000', NULL);
INSERT INTO `batch_job_execution` VALUES (41, 2, 36, '2024-02-02 11:18:58.588000', '2024-02-02 11:18:58.662000', '2024-02-02 11:18:58.721000', 'COMPLETED', 'NOOP', 'All steps already completed or no steps configured for this job.', '2024-02-02 11:18:58.721000', NULL);
INSERT INTO `batch_job_execution` VALUES (42, 2, 36, '2024-02-02 11:19:49.238000', '2024-02-02 11:19:49.591000', '2024-02-02 11:19:49.653000', 'COMPLETED', 'NOOP', 'All steps already completed or no steps configured for this job.', '2024-02-02 11:19:49.653000', NULL);
INSERT INTO `batch_job_execution` VALUES (43, 2, 37, '2024-02-02 11:23:51.592000', '2024-02-02 11:23:51.662000', '2024-02-02 11:23:51.956000', 'COMPLETED', 'COMPLETED', '', '2024-02-02 11:23:51.956000', NULL);
INSERT INTO `batch_job_execution` VALUES (44, 2, 37, '2024-02-02 11:24:16.588000', '2024-02-02 11:24:16.731000', '2024-02-02 11:24:16.774000', 'COMPLETED', 'NOOP', 'All steps already completed or no steps configured for this job.', '2024-02-02 11:24:16.774000', NULL);
INSERT INTO `batch_job_execution` VALUES (45, 2, 37, '2024-02-02 11:25:09.669000', '2024-02-02 11:25:09.749000', '2024-02-02 11:25:10.656000', 'COMPLETED', 'COMPLETED', '', '2024-02-02 11:25:10.656000', NULL);
INSERT INTO `batch_job_execution` VALUES (46, 2, 38, '2024-02-02 14:53:13.004000', '2024-02-02 14:53:13.081000', '2024-02-02 14:53:13.462000', 'COMPLETED', 'COMPLETED', '', '2024-02-02 14:53:13.462000', NULL);
INSERT INTO `batch_job_execution` VALUES (47, 2, 39, '2024-02-02 15:13:41.412000', '2024-02-02 15:13:41.501000', '2024-02-02 15:13:41.845000', 'COMPLETED', 'COMPLETED', '', '2024-02-02 15:13:41.845000', NULL);
INSERT INTO `batch_job_execution` VALUES (48, 2, 39, '2024-02-02 15:22:55.024000', '2024-02-02 15:22:55.114000', '2024-02-02 15:22:55.154000', 'COMPLETED', 'NOOP', 'All steps already completed or no steps configured for this job.', '2024-02-02 15:22:55.154000', NULL);
INSERT INTO `batch_job_execution` VALUES (49, 2, 39, '2024-02-02 15:31:04.876000', '2024-02-02 15:31:04.938000', '2024-02-02 15:31:04.973000', 'COMPLETED', 'NOOP', 'All steps already completed or no steps configured for this job.', '2024-02-02 15:31:04.974000', NULL);
INSERT INTO `batch_job_execution` VALUES (50, 2, 40, '2024-02-02 15:31:22.735000', '2024-02-02 15:31:22.805000', '2024-02-02 15:31:23.168000', 'COMPLETED', 'COMPLETED', '', '2024-02-02 15:31:23.169000', NULL);
INSERT INTO `batch_job_execution` VALUES (51, 2, 41, '2024-02-02 15:44:26.070000', '2024-02-02 15:44:26.149000', '2024-02-02 15:44:26.471000', 'COMPLETED', 'COMPLETED', '', '2024-02-02 15:44:26.472000', NULL);
INSERT INTO `batch_job_execution` VALUES (52, 2, 41, '2024-02-02 15:49:10.914000', '2024-02-02 15:49:10.986000', '2024-02-02 15:49:11.021000', 'COMPLETED', 'NOOP', 'All steps already completed or no steps configured for this job.', '2024-02-02 15:49:11.022000', NULL);
INSERT INTO `batch_job_execution` VALUES (53, 2, 42, '2024-02-02 15:49:39.356000', '2024-02-02 15:49:39.425000', '2024-02-02 15:49:39.872000', 'COMPLETED', 'COMPLETED', '', '2024-02-02 15:49:39.872000', NULL);
INSERT INTO `batch_job_execution` VALUES (54, 2, 43, '2024-02-02 16:00:42.676000', '2024-02-02 16:00:42.752000', '2024-02-02 16:00:43.579000', 'COMPLETED', 'COMPLETED', '', '2024-02-02 16:00:43.580000', NULL);
INSERT INTO `batch_job_execution` VALUES (55, 2, 44, '2024-02-02 16:02:01.163000', '2024-02-02 16:02:01.231000', '2024-02-02 16:02:02.356000', 'COMPLETED', 'COMPLETED', '', '2024-02-02 16:02:02.357000', NULL);

-- ----------------------------
-- Table structure for batch_job_execution_context
-- ----------------------------
DROP TABLE IF EXISTS `batch_job_execution_context`;
CREATE TABLE `batch_job_execution_context`  (
  `JOB_EXECUTION_ID` bigint(0) NOT NULL,
  `SHORT_CONTEXT` varchar(2500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `SERIALIZED_CONTEXT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  PRIMARY KEY (`JOB_EXECUTION_ID`) USING BTREE,
  CONSTRAINT `JOB_EXEC_CTX_FK` FOREIGN KEY (`JOB_EXECUTION_ID`) REFERENCES `batch_job_execution` (`JOB_EXECUTION_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of batch_job_execution_context
-- ----------------------------
INSERT INTO `batch_job_execution_context` VALUES (1, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (2, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (3, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (4, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (5, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (6, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (7, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (8, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (9, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (10, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (11, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (12, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (13, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (14, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (15, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (16, '{\"@class\":\"java.util.HashMap\",\"key-step1-job\":\"value-step1-job\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (17, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (18, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (19, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (20, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (21, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (22, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (23, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (24, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (25, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (26, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (27, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (28, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (29, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (30, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (31, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (32, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (33, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (34, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (35, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (36, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (37, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (38, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (39, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (40, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (41, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (42, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (43, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (44, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (45, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (46, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (47, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (48, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (49, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (50, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (51, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (52, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (53, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (54, '{\"@class\":\"java.util.HashMap\"}', NULL);
INSERT INTO `batch_job_execution_context` VALUES (55, '{\"@class\":\"java.util.HashMap\"}', NULL);

-- ----------------------------
-- Table structure for batch_job_execution_params
-- ----------------------------
DROP TABLE IF EXISTS `batch_job_execution_params`;
CREATE TABLE `batch_job_execution_params`  (
  `JOB_EXECUTION_ID` bigint(0) NOT NULL,
  `TYPE_CD` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `KEY_NAME` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `STRING_VAL` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DATE_VAL` datetime(6) NULL DEFAULT NULL,
  `LONG_VAL` bigint(0) NULL DEFAULT NULL,
  `DOUBLE_VAL` double NULL DEFAULT NULL,
  `IDENTIFYING` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  INDEX `JOB_EXEC_PARAMS_FK`(`JOB_EXECUTION_ID`) USING BTREE,
  CONSTRAINT `JOB_EXEC_PARAMS_FK` FOREIGN KEY (`JOB_EXECUTION_ID`) REFERENCES `batch_job_execution` (`JOB_EXECUTION_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of batch_job_execution_params
-- ----------------------------
INSERT INTO `batch_job_execution_params` VALUES (1, 'STRING', 'name', 'xiaodong', '1970-01-01 08:00:00.000000', 0, 0, 'Y');
INSERT INTO `batch_job_execution_params` VALUES (2, 'STRING', 'name', 'xiaodong', '1970-01-01 08:00:00.000000', 0, 0, 'Y');
INSERT INTO `batch_job_execution_params` VALUES (3, 'STRING', 'name', 'xiaodong', '1970-01-01 08:00:00.000000', 0, 0, 'Y');
INSERT INTO `batch_job_execution_params` VALUES (3, 'STRING', 'age', '18', '1970-01-01 08:00:00.000000', 0, 0, 'Y');
INSERT INTO `batch_job_execution_params` VALUES (4, 'STRING', 'name', 'null', '1970-01-01 08:00:00.000000', 0, 0, 'Y');
INSERT INTO `batch_job_execution_params` VALUES (4, 'STRING', 'age', '18', '1970-01-01 08:00:00.000000', 0, 0, 'Y');
INSERT INTO `batch_job_execution_params` VALUES (5, 'LONG', 'run.id', '', '1970-01-01 08:00:00.000000', 1, 0, 'Y');
INSERT INTO `batch_job_execution_params` VALUES (6, 'LONG', 'run.id', '', '1970-01-01 08:00:00.000000', 2, 0, 'Y');
INSERT INTO `batch_job_execution_params` VALUES (7, 'LONG', 'run.id', '', '1970-01-01 08:00:00.000000', 3, 0, 'Y');
INSERT INTO `batch_job_execution_params` VALUES (8, 'LONG', 'daily', '', '1970-01-01 08:00:00.000000', 1706695466555, 0, 'Y');
INSERT INTO `batch_job_execution_params` VALUES (9, 'LONG', 'daily', '', '1970-01-01 08:00:00.000000', 1706695472683, 0, 'Y');
INSERT INTO `batch_job_execution_params` VALUES (13, 'LONG', 'run.id', '', '1970-01-01 08:00:00.000000', 1, 0, 'Y');
INSERT INTO `batch_job_execution_params` VALUES (14, 'LONG', 'run.id', '', '1970-01-01 08:00:00.000000', 2, 0, 'Y');
INSERT INTO `batch_job_execution_params` VALUES (15, 'LONG', 'run.id', '', '1970-01-01 08:00:00.000000', 3, 0, 'Y');
INSERT INTO `batch_job_execution_params` VALUES (16, 'LONG', 'run.id', '', '1970-01-01 08:00:00.000000', 1, 0, 'Y');
INSERT INTO `batch_job_execution_params` VALUES (17, 'LONG', 'run.id', '', '1970-01-01 08:00:00.000000', 1, 0, 'Y');
INSERT INTO `batch_job_execution_params` VALUES (18, 'LONG', 'run.id', '', '1970-01-01 08:00:00.000000', 1, 0, 'Y');
INSERT INTO `batch_job_execution_params` VALUES (19, 'LONG', 'run.id', '', '1970-01-01 08:00:00.000000', 1, 0, 'Y');
INSERT INTO `batch_job_execution_params` VALUES (20, 'LONG', 'run.id', '', '1970-01-01 08:00:00.000000', 2, 0, 'Y');
INSERT INTO `batch_job_execution_params` VALUES (21, 'LONG', 'run.id', '', '1970-01-01 08:00:00.000000', 1, 0, 'Y');
INSERT INTO `batch_job_execution_params` VALUES (22, 'LONG', 'run.id', '', '1970-01-01 08:00:00.000000', 3, 0, 'Y');
INSERT INTO `batch_job_execution_params` VALUES (23, 'LONG', 'run.id', '', '1970-01-01 08:00:00.000000', 4, 0, 'Y');
INSERT INTO `batch_job_execution_params` VALUES (24, 'LONG', 'run.id', '', '1970-01-01 08:00:00.000000', 5, 0, 'Y');
INSERT INTO `batch_job_execution_params` VALUES (25, 'LONG', 'run.id', '', '1970-01-01 08:00:00.000000', 6, 0, 'Y');
INSERT INTO `batch_job_execution_params` VALUES (26, 'LONG', 'run.id', '', '1970-01-01 08:00:00.000000', 7, 0, 'Y');
INSERT INTO `batch_job_execution_params` VALUES (27, 'LONG', 'run.id', '', '1970-01-01 08:00:00.000000', 8, 0, 'Y');
INSERT INTO `batch_job_execution_params` VALUES (28, 'LONG', 'run.id', '', '1970-01-01 08:00:00.000000', 9, 0, 'Y');
INSERT INTO `batch_job_execution_params` VALUES (29, 'LONG', 'run.id', '', '1970-01-01 08:00:00.000000', 10, 0, 'Y');
INSERT INTO `batch_job_execution_params` VALUES (30, 'LONG', 'run.id', '', '1970-01-01 08:00:00.000000', 1, 0, 'Y');
INSERT INTO `batch_job_execution_params` VALUES (33, 'STRING', 'name', 'xiaodong', '1970-01-01 08:00:00.000000', 0, 0, 'Y');
INSERT INTO `batch_job_execution_params` VALUES (33, 'LONG', 'run.id', '', '1970-01-01 08:00:00.000000', 1, 0, 'Y');

-- ----------------------------
-- Table structure for batch_job_execution_seq
-- ----------------------------
DROP TABLE IF EXISTS `batch_job_execution_seq`;
CREATE TABLE `batch_job_execution_seq`  (
  `ID` bigint(0) NOT NULL,
  `UNIQUE_KEY` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  UNIQUE INDEX `UNIQUE_KEY_UN`(`UNIQUE_KEY`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of batch_job_execution_seq
-- ----------------------------
INSERT INTO `batch_job_execution_seq` VALUES (55, '0');

-- ----------------------------
-- Table structure for batch_job_instance
-- ----------------------------
DROP TABLE IF EXISTS `batch_job_instance`;
CREATE TABLE `batch_job_instance`  (
  `JOB_INSTANCE_ID` bigint(0) NOT NULL,
  `VERSION` bigint(0) NULL DEFAULT NULL,
  `JOB_NAME` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `JOB_KEY` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`JOB_INSTANCE_ID`) USING BTREE,
  UNIQUE INDEX `JOB_INST_UN`(`JOB_NAME`, `JOB_KEY`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of batch_job_instance
-- ----------------------------
INSERT INTO `batch_job_instance` VALUES (1, 0, 'params-job', 'e02489cb478199e6515b08a4055918eb');
INSERT INTO `batch_job_instance` VALUES (2, 0, 'params-chunk-job', 'e02489cb478199e6515b08a4055918eb');
INSERT INTO `batch_job_instance` VALUES (3, 0, 'default-params-validator-job', '69c99493abf88f45dde80731ec79c150');
INSERT INTO `batch_job_instance` VALUES (4, 0, 'composite-params-validator-job', 'ef81bff075c325cfb47e0988961a793b');
INSERT INTO `batch_job_instance` VALUES (5, 0, 'incr-params-job', '853d3449e311f40366811cbefb3d93d7');
INSERT INTO `batch_job_instance` VALUES (6, 0, 'incr-params-job', 'e070bff4379694c0210a51d9f6c6a564');
INSERT INTO `batch_job_instance` VALUES (7, 0, 'incr-params-job', 'a3364faf893276dea0caacefbf618db5');
INSERT INTO `batch_job_instance` VALUES (8, 0, 'incr-params-job', 'a7251176a40a5f6c96df84afd8e5e022');
INSERT INTO `batch_job_instance` VALUES (9, 0, 'incr-params-job', 'e281f5db7023992c4f024df8e4c0dd08');
INSERT INTO `batch_job_instance` VALUES (10, 0, 'job-state-listener-job', 'd41d8cd98f00b204e9800998ecf8427e');
INSERT INTO `batch_job_instance` VALUES (11, 0, 'job-state-anno-listener-job', 'd41d8cd98f00b204e9800998ecf8427e');
INSERT INTO `batch_job_instance` VALUES (12, 0, 'step-chunk-tasklet-job', '853d3449e311f40366811cbefb3d93d7');
INSERT INTO `batch_job_instance` VALUES (13, 0, 'step-chunk-tasklet-job', 'e070bff4379694c0210a51d9f6c6a564');
INSERT INTO `batch_job_instance` VALUES (14, 0, 'step-chunk-tasklet-job', 'a3364faf893276dea0caacefbf618db5');
INSERT INTO `batch_job_instance` VALUES (15, 0, 'execution-context-job', '853d3449e311f40366811cbefb3d93d7');
INSERT INTO `batch_job_instance` VALUES (16, 0, 'step-listener-job1', '853d3449e311f40366811cbefb3d93d7');
INSERT INTO `batch_job_instance` VALUES (17, 0, 'step-multi-job1', '853d3449e311f40366811cbefb3d93d7');
INSERT INTO `batch_job_instance` VALUES (18, 0, 'condition-step-job', '853d3449e311f40366811cbefb3d93d7');
INSERT INTO `batch_job_instance` VALUES (19, 0, 'condition-step-job', 'e070bff4379694c0210a51d9f6c6a564');
INSERT INTO `batch_job_instance` VALUES (20, 0, 'customize-step-job', '853d3449e311f40366811cbefb3d93d7');
INSERT INTO `batch_job_instance` VALUES (21, 0, 'condition-step-job', 'a3364faf893276dea0caacefbf618db5');
INSERT INTO `batch_job_instance` VALUES (22, 0, 'condition-step-job', '47c0a8118b74165a864b66d37c7b6cf5');
INSERT INTO `batch_job_instance` VALUES (23, 0, 'condition-step-job', 'ce148f5f9c2bf4dc9bd44a7a5f64204c');
INSERT INTO `batch_job_instance` VALUES (24, 0, 'condition-step-job', 'bd0034040292bc81e6ccac0e25d9a578');
INSERT INTO `batch_job_instance` VALUES (25, 0, 'condition-step-job', '597815c7e4ab1092c1b25130aae725cb');
INSERT INTO `batch_job_instance` VALUES (26, 0, 'condition-step-job', 'f55a96b11012be4fcfb6cf005435182d');
INSERT INTO `batch_job_instance` VALUES (27, 0, 'condition-step-job', '96a5ed9bac43e779455f3e71c0f64840');
INSERT INTO `batch_job_instance` VALUES (28, 0, 'condition-step-job', '1aac4f3e74894b78fa3ce5d8a25e1ef0');
INSERT INTO `batch_job_instance` VALUES (29, 0, 'flow-step-job', '853d3449e311f40366811cbefb3d93d7');
INSERT INTO `batch_job_instance` VALUES (30, 0, 'start-test-job', 'd41d8cd98f00b204e9800998ecf8427e');
INSERT INTO `batch_job_instance` VALUES (31, 0, 'hello-restful-job', 'd41d8cd98f00b204e9800998ecf8427e');
INSERT INTO `batch_job_instance` VALUES (32, 0, 'hello-restful-job', '762970146402fd792981f55b0aca80c3');
INSERT INTO `batch_job_instance` VALUES (33, 0, 'job-stop-job', 'd41d8cd98f00b204e9800998ecf8427e');
INSERT INTO `batch_job_instance` VALUES (34, 0, 'job-stop-sign-job', 'd41d8cd98f00b204e9800998ecf8427e');
INSERT INTO `batch_job_instance` VALUES (35, 0, 'job-forbid-restart-job', 'd41d8cd98f00b204e9800998ecf8427e');
INSERT INTO `batch_job_instance` VALUES (36, 0, 'job-restart-limit-job', 'd41d8cd98f00b204e9800998ecf8427e');
INSERT INTO `batch_job_instance` VALUES (37, 0, 'job-allow-restart-job', 'd41d8cd98f00b204e9800998ecf8427e');
INSERT INTO `batch_job_instance` VALUES (38, 0, 'flat-reader-job', 'd41d8cd98f00b204e9800998ecf8427e');
INSERT INTO `batch_job_instance` VALUES (39, 0, 'mapper-flat-reader-job', 'd41d8cd98f00b204e9800998ecf8427e');
INSERT INTO `batch_job_instance` VALUES (40, 0, 'json-flat-reader-job', 'd41d8cd98f00b204e9800998ecf8427e');
INSERT INTO `batch_job_instance` VALUES (41, 0, 'cursor-db-reader-job', 'd41d8cd98f00b204e9800998ecf8427e');
INSERT INTO `batch_job_instance` VALUES (42, 0, 'cursor-db-reader-job-age>16', 'd41d8cd98f00b204e9800998ecf8427e');
INSERT INTO `batch_job_instance` VALUES (43, 0, 'page-db-reader-job', 'd41d8cd98f00b204e9800998ecf8427e');
INSERT INTO `batch_job_instance` VALUES (44, 0, 'page-db-reader-job1', 'd41d8cd98f00b204e9800998ecf8427e');

-- ----------------------------
-- Table structure for batch_job_seq
-- ----------------------------
DROP TABLE IF EXISTS `batch_job_seq`;
CREATE TABLE `batch_job_seq`  (
  `ID` bigint(0) NOT NULL,
  `UNIQUE_KEY` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  UNIQUE INDEX `UNIQUE_KEY_UN`(`UNIQUE_KEY`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of batch_job_seq
-- ----------------------------
INSERT INTO `batch_job_seq` VALUES (44, '0');

-- ----------------------------
-- Table structure for batch_step_execution
-- ----------------------------
DROP TABLE IF EXISTS `batch_step_execution`;
CREATE TABLE `batch_step_execution`  (
  `STEP_EXECUTION_ID` bigint(0) NOT NULL,
  `VERSION` bigint(0) NOT NULL,
  `STEP_NAME` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `JOB_EXECUTION_ID` bigint(0) NOT NULL,
  `START_TIME` datetime(6) NOT NULL,
  `END_TIME` datetime(6) NULL DEFAULT NULL,
  `STATUS` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `COMMIT_COUNT` bigint(0) NULL DEFAULT NULL,
  `READ_COUNT` bigint(0) NULL DEFAULT NULL,
  `FILTER_COUNT` bigint(0) NULL DEFAULT NULL,
  `WRITE_COUNT` bigint(0) NULL DEFAULT NULL,
  `READ_SKIP_COUNT` bigint(0) NULL DEFAULT NULL,
  `WRITE_SKIP_COUNT` bigint(0) NULL DEFAULT NULL,
  `PROCESS_SKIP_COUNT` bigint(0) NULL DEFAULT NULL,
  `ROLLBACK_COUNT` bigint(0) NULL DEFAULT NULL,
  `EXIT_CODE` varchar(2500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `EXIT_MESSAGE` varchar(2500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `LAST_UPDATED` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`STEP_EXECUTION_ID`) USING BTREE,
  INDEX `JOB_EXEC_STEP_FK`(`JOB_EXECUTION_ID`) USING BTREE,
  CONSTRAINT `JOB_EXEC_STEP_FK` FOREIGN KEY (`JOB_EXECUTION_ID`) REFERENCES `batch_job_execution` (`JOB_EXECUTION_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of batch_step_execution
-- ----------------------------
INSERT INTO `batch_step_execution` VALUES (1, 3, 'step1', 1, '2024-01-31 10:04:36.320000', '2024-01-31 10:04:36.399000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-01-31 10:04:36.401000');
INSERT INTO `batch_step_execution` VALUES (2, 3, 'step1', 2, '2024-01-31 10:12:15.950000', '2024-01-31 10:12:16.019000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-01-31 10:12:16.020000');
INSERT INTO `batch_step_execution` VALUES (3, 3, 'step1', 3, '2024-01-31 15:48:03.448000', '2024-01-31 15:48:03.515000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-01-31 15:48:03.516000');
INSERT INTO `batch_step_execution` VALUES (4, 3, 'step1', 4, '2024-01-31 16:59:18.992000', '2024-01-31 16:59:19.067000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-01-31 16:59:19.068000');
INSERT INTO `batch_step_execution` VALUES (5, 3, 'step1', 5, '2024-01-31 17:55:19.612000', '2024-01-31 17:55:19.689000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-01-31 17:55:19.690000');
INSERT INTO `batch_step_execution` VALUES (6, 3, 'step1', 6, '2024-01-31 17:55:28.090000', '2024-01-31 17:55:28.156000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-01-31 17:55:28.157000');
INSERT INTO `batch_step_execution` VALUES (7, 3, 'step1', 7, '2024-01-31 17:56:16.903000', '2024-01-31 17:56:16.967000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-01-31 17:56:16.968000');
INSERT INTO `batch_step_execution` VALUES (8, 3, 'step1', 8, '2024-01-31 18:04:26.723000', '2024-01-31 18:04:26.792000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-01-31 18:04:26.793000');
INSERT INTO `batch_step_execution` VALUES (9, 3, 'step1', 9, '2024-01-31 18:04:32.831000', '2024-01-31 18:04:32.896000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-01-31 18:04:32.897000');
INSERT INTO `batch_step_execution` VALUES (10, 3, 'step1', 10, '2024-01-31 18:18:30.009000', '2024-01-31 18:18:30.077000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-01-31 18:18:30.078000');
INSERT INTO `batch_step_execution` VALUES (11, 3, 'step1', 11, '2024-01-31 18:28:48.997000', '2024-01-31 18:28:49.090000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-01-31 18:28:49.090000');
INSERT INTO `batch_step_execution` VALUES (12, 78, 'step1', 13, '2024-02-01 10:38:23.322000', NULL, 'STARTED', 77, 231, 0, 231, 0, 0, 0, 0, 'EXECUTING', '', '2024-02-01 10:38:25.781000');
INSERT INTO `batch_step_execution` VALUES (13, 4, 'step1', 14, '2024-02-01 10:42:04.114000', '2024-02-01 10:42:04.211000', 'COMPLETED', 2, 3, 0, 3, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-01 10:42:04.211000');
INSERT INTO `batch_step_execution` VALUES (14, 6, 'step1', 15, '2024-02-01 10:43:29.023000', '2024-02-01 10:43:29.164000', 'COMPLETED', 4, 10, 0, 10, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-01 10:43:29.164000');
INSERT INTO `batch_step_execution` VALUES (15, 3, 'step1', 16, '2024-02-01 10:49:02.258000', '2024-02-01 10:49:02.330000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-01 10:49:02.331000');
INSERT INTO `batch_step_execution` VALUES (16, 3, 'step2', 16, '2024-02-01 10:49:02.414000', '2024-02-01 10:49:02.476000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-01 10:49:02.477000');
INSERT INTO `batch_step_execution` VALUES (17, 3, 'step1', 17, '2024-02-01 11:36:45.709000', '2024-02-01 11:36:45.778000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-01 11:36:45.779000');
INSERT INTO `batch_step_execution` VALUES (18, 3, 'step1', 18, '2024-02-01 11:57:09.319000', '2024-02-01 11:57:09.381000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-01 11:57:09.382000');
INSERT INTO `batch_step_execution` VALUES (19, 3, 'step2', 18, '2024-02-01 11:57:09.443000', '2024-02-01 11:57:09.504000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-01 11:57:09.505000');
INSERT INTO `batch_step_execution` VALUES (20, 3, 'step1', 19, '2024-02-01 15:23:18.602000', '2024-02-01 15:23:18.675000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-01 15:23:18.676000');
INSERT INTO `batch_step_execution` VALUES (21, 3, 'successStep', 19, '2024-02-01 15:23:18.743000', '2024-02-01 15:23:18.807000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-01 15:23:18.808000');
INSERT INTO `batch_step_execution` VALUES (22, 3, 'step1', 20, '2024-02-01 15:25:03.433000', '2024-02-01 15:25:03.519000', 'ABANDONED', 0, 0, 0, 0, 0, 0, 0, 1, 'FAILED', 'java.lang.RuntimeException: 测试fail结果\r\n	at com.ldd.step_condition.ConditionStepJob$1.execute(ConditionStepJob.java:39)\r\n	at org.springframework.batch.core.step.tasklet.TaskletStep$ChunkTransactionCallback.doInTransaction(TaskletStep.java:407)\r\n	at org.springframework.batch.core.step.tasklet.TaskletStep$ChunkTransactionCallback.doInTransaction(TaskletStep.java:331)\r\n	at org.springframework.transaction.support.TransactionTemplate.execute(TransactionTemplate.java:140)\r\n	at org.springframework.batch.core.step.tasklet.TaskletStep$2.doInChunkContext(TaskletStep.java:273)\r\n	at org.springframework.batch.core.scope.context.StepContextRepeatCallback.doInIteration(StepContextRepeatCallback.java:82)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.getNextResult(RepeatTemplate.java:375)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.executeInternal(RepeatTemplate.java:215)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.iterate(RepeatTemplate.java:145)\r\n	at org.springframework.batch.core.step.tasklet.TaskletStep.doExecute(TaskletStep.java:258)\r\n	at org.springframework.batch.core.step.AbstractStep.execute(AbstractStep.java:208)\r\n	at org.springframework.batch.core.job.SimpleStepHandler.handleStep(SimpleStepHandler.java:152)\r\n	at org.springframework.batch.core.job.flow.JobFlowExecutor.executeStep(JobFlowExecutor.java:68)\r\n	at org.springframework.batch.core.job.flow.support.state.StepState.handle(StepState.java:68)\r\n	at org.springframework.batch.core.job.flow.support.SimpleFlow.resume(SimpleFlow.java:169)\r\n	at org.springframework.batch.core.job.flow.support.SimpleFlow.start(SimpleFlow.java:144)\r\n	at org.springframework.batch.core.job.flow.FlowJob.doExecute(FlowJob.java:139)\r\n	at org.springframework.batch.core.job.AbstractJob.execute(AbstractJob.java:320)\r\n	at org.springframework.batch.core.launch.support.SimpleJobLauncher$1.run(SimpleJobLauncher.java:149)\r\n	at org.springframework.core.task.SyncTaskExecutor.execute(SyncTaskExecutor.java:50)\r\n	at org.springframework.batch.core.launch.support.SimpleJobLauncher.run(SimpleJobLauncher.java:140)\r\n	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:77)\r\n	at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.base/java.lang.reflect.Method.invoke(Method.java:568)\r\n	at org.springframework.aop.support.AopUtil', '2024-02-01 15:25:03.550000');
INSERT INTO `batch_step_execution` VALUES (23, 3, 'failStep', 20, '2024-02-01 15:25:03.634000', '2024-02-01 15:25:03.750000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-01 15:25:03.750000');
INSERT INTO `batch_step_execution` VALUES (24, 3, 'firstStep', 21, '2024-02-01 15:42:30.443000', '2024-02-01 15:42:30.518000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-01 15:42:30.519000');
INSERT INTO `batch_step_execution` VALUES (25, 3, 'stepA', 21, '2024-02-01 15:42:30.593000', '2024-02-01 15:42:30.666000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-01 15:42:30.667000');
INSERT INTO `batch_step_execution` VALUES (26, 3, 'step1', 22, '2024-02-01 16:04:27.100000', '2024-02-01 16:04:27.190000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-01 16:04:27.191000');
INSERT INTO `batch_step_execution` VALUES (27, 3, 'successStep', 22, '2024-02-01 16:04:27.298000', '2024-02-01 16:04:27.369000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-01 16:04:27.369000');
INSERT INTO `batch_step_execution` VALUES (28, 3, 'step1', 23, '2024-02-01 16:06:06.278000', '2024-02-01 16:06:06.358000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-01 16:06:06.359000');
INSERT INTO `batch_step_execution` VALUES (29, 3, 'successStep', 23, '2024-02-01 16:06:06.428000', '2024-02-01 16:06:06.507000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-01 16:06:06.507000');
INSERT INTO `batch_step_execution` VALUES (30, 3, 'step1', 24, '2024-02-01 16:07:53.471000', '2024-02-01 16:07:53.540000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-01 16:07:53.541000');
INSERT INTO `batch_step_execution` VALUES (31, 3, 'successStep', 24, '2024-02-01 16:07:53.752000', '2024-02-01 16:07:53.973000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-01 16:07:53.973000');
INSERT INTO `batch_step_execution` VALUES (32, 2, 'step1', 25, '2024-02-01 16:08:48.202000', '2024-02-01 16:08:48.263000', 'FAILED', 0, 0, 0, 0, 0, 0, 0, 1, 'FAILED', 'java.lang.RuntimeException: 测试fail结果\r\n	at com.ldd.step_status.StepStatusJob$1.execute(StepStatusJob.java:39)\r\n	at org.springframework.batch.core.step.tasklet.TaskletStep$ChunkTransactionCallback.doInTransaction(TaskletStep.java:407)\r\n	at org.springframework.batch.core.step.tasklet.TaskletStep$ChunkTransactionCallback.doInTransaction(TaskletStep.java:331)\r\n	at org.springframework.transaction.support.TransactionTemplate.execute(TransactionTemplate.java:140)\r\n	at org.springframework.batch.core.step.tasklet.TaskletStep$2.doInChunkContext(TaskletStep.java:273)\r\n	at org.springframework.batch.core.scope.context.StepContextRepeatCallback.doInIteration(StepContextRepeatCallback.java:82)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.getNextResult(RepeatTemplate.java:375)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.executeInternal(RepeatTemplate.java:215)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.iterate(RepeatTemplate.java:145)\r\n	at org.springframework.batch.core.step.tasklet.TaskletStep.doExecute(TaskletStep.java:258)\r\n	at org.springframework.batch.core.step.AbstractStep.execute(AbstractStep.java:208)\r\n	at org.springframework.batch.core.job.SimpleStepHandler.handleStep(SimpleStepHandler.java:152)\r\n	at org.springframework.batch.core.job.flow.JobFlowExecutor.executeStep(JobFlowExecutor.java:68)\r\n	at org.springframework.batch.core.job.flow.support.state.StepState.handle(StepState.java:68)\r\n	at org.springframework.batch.core.job.flow.support.SimpleFlow.resume(SimpleFlow.java:169)\r\n	at org.springframework.batch.core.job.flow.support.SimpleFlow.start(SimpleFlow.java:144)\r\n	at org.springframework.batch.core.job.flow.FlowJob.doExecute(FlowJob.java:139)\r\n	at org.springframework.batch.core.job.AbstractJob.execute(AbstractJob.java:320)\r\n	at org.springframework.batch.core.launch.support.SimpleJobLauncher$1.run(SimpleJobLauncher.java:149)\r\n	at org.springframework.core.task.SyncTaskExecutor.execute(SyncTaskExecutor.java:50)\r\n	at org.springframework.batch.core.launch.support.SimpleJobLauncher.run(SimpleJobLauncher.java:140)\r\n	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:77)\r\n	at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.base/java.lang.reflect.Method.invoke(Method.java:568)\r\n	at org.springframework.aop.support.AopUtils.invokeJ', '2024-02-01 16:08:48.264000');
INSERT INTO `batch_step_execution` VALUES (33, 2, 'step1', 26, '2024-02-01 16:08:59.312000', '2024-02-01 16:08:59.372000', 'FAILED', 0, 0, 0, 0, 0, 0, 0, 1, 'FAILED', 'java.lang.RuntimeException: 测试fail结果\r\n	at com.ldd.step_status.StepStatusJob$1.execute(StepStatusJob.java:39)\r\n	at org.springframework.batch.core.step.tasklet.TaskletStep$ChunkTransactionCallback.doInTransaction(TaskletStep.java:407)\r\n	at org.springframework.batch.core.step.tasklet.TaskletStep$ChunkTransactionCallback.doInTransaction(TaskletStep.java:331)\r\n	at org.springframework.transaction.support.TransactionTemplate.execute(TransactionTemplate.java:140)\r\n	at org.springframework.batch.core.step.tasklet.TaskletStep$2.doInChunkContext(TaskletStep.java:273)\r\n	at org.springframework.batch.core.scope.context.StepContextRepeatCallback.doInIteration(StepContextRepeatCallback.java:82)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.getNextResult(RepeatTemplate.java:375)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.executeInternal(RepeatTemplate.java:215)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.iterate(RepeatTemplate.java:145)\r\n	at org.springframework.batch.core.step.tasklet.TaskletStep.doExecute(TaskletStep.java:258)\r\n	at org.springframework.batch.core.step.AbstractStep.execute(AbstractStep.java:208)\r\n	at org.springframework.batch.core.job.SimpleStepHandler.handleStep(SimpleStepHandler.java:152)\r\n	at org.springframework.batch.core.job.flow.JobFlowExecutor.executeStep(JobFlowExecutor.java:68)\r\n	at org.springframework.batch.core.job.flow.support.state.StepState.handle(StepState.java:68)\r\n	at org.springframework.batch.core.job.flow.support.SimpleFlow.resume(SimpleFlow.java:169)\r\n	at org.springframework.batch.core.job.flow.support.SimpleFlow.start(SimpleFlow.java:144)\r\n	at org.springframework.batch.core.job.flow.FlowJob.doExecute(FlowJob.java:139)\r\n	at org.springframework.batch.core.job.AbstractJob.execute(AbstractJob.java:320)\r\n	at org.springframework.batch.core.launch.support.SimpleJobLauncher$1.run(SimpleJobLauncher.java:149)\r\n	at org.springframework.core.task.SyncTaskExecutor.execute(SyncTaskExecutor.java:50)\r\n	at org.springframework.batch.core.launch.support.SimpleJobLauncher.run(SimpleJobLauncher.java:140)\r\n	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:77)\r\n	at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.base/java.lang.reflect.Method.invoke(Method.java:568)\r\n	at org.springframework.aop.support.AopUtils.invokeJ', '2024-02-01 16:08:59.373000');
INSERT INTO `batch_step_execution` VALUES (34, 2, 'step1', 27, '2024-02-01 16:09:24.612000', '2024-02-01 16:09:24.676000', 'FAILED', 0, 0, 0, 0, 0, 0, 0, 1, 'FAILED', 'java.lang.RuntimeException: 测试fail结果\r\n	at com.ldd.step_status.StepStatusJob$1.execute(StepStatusJob.java:39)\r\n	at org.springframework.batch.core.step.tasklet.TaskletStep$ChunkTransactionCallback.doInTransaction(TaskletStep.java:407)\r\n	at org.springframework.batch.core.step.tasklet.TaskletStep$ChunkTransactionCallback.doInTransaction(TaskletStep.java:331)\r\n	at org.springframework.transaction.support.TransactionTemplate.execute(TransactionTemplate.java:140)\r\n	at org.springframework.batch.core.step.tasklet.TaskletStep$2.doInChunkContext(TaskletStep.java:273)\r\n	at org.springframework.batch.core.scope.context.StepContextRepeatCallback.doInIteration(StepContextRepeatCallback.java:82)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.getNextResult(RepeatTemplate.java:375)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.executeInternal(RepeatTemplate.java:215)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.iterate(RepeatTemplate.java:145)\r\n	at org.springframework.batch.core.step.tasklet.TaskletStep.doExecute(TaskletStep.java:258)\r\n	at org.springframework.batch.core.step.AbstractStep.execute(AbstractStep.java:208)\r\n	at org.springframework.batch.core.job.SimpleStepHandler.handleStep(SimpleStepHandler.java:152)\r\n	at org.springframework.batch.core.job.flow.JobFlowExecutor.executeStep(JobFlowExecutor.java:68)\r\n	at org.springframework.batch.core.job.flow.support.state.StepState.handle(StepState.java:68)\r\n	at org.springframework.batch.core.job.flow.support.SimpleFlow.resume(SimpleFlow.java:169)\r\n	at org.springframework.batch.core.job.flow.support.SimpleFlow.start(SimpleFlow.java:144)\r\n	at org.springframework.batch.core.job.flow.FlowJob.doExecute(FlowJob.java:139)\r\n	at org.springframework.batch.core.job.AbstractJob.execute(AbstractJob.java:320)\r\n	at org.springframework.batch.core.launch.support.SimpleJobLauncher$1.run(SimpleJobLauncher.java:149)\r\n	at org.springframework.core.task.SyncTaskExecutor.execute(SyncTaskExecutor.java:50)\r\n	at org.springframework.batch.core.launch.support.SimpleJobLauncher.run(SimpleJobLauncher.java:140)\r\n	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:77)\r\n	at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.base/java.lang.reflect.Method.invoke(Method.java:568)\r\n	at org.springframework.aop.support.AopUtils.invokeJ', '2024-02-01 16:09:24.676000');
INSERT INTO `batch_step_execution` VALUES (35, 2, 'step1', 28, '2024-02-01 16:09:35.437000', '2024-02-01 16:09:35.616000', 'FAILED', 0, 0, 0, 0, 0, 0, 0, 1, 'FAILED', 'java.lang.RuntimeException: 测试fail结果\r\n	at com.ldd.step_status.StepStatusJob$1.execute(StepStatusJob.java:39)\r\n	at org.springframework.batch.core.step.tasklet.TaskletStep$ChunkTransactionCallback.doInTransaction(TaskletStep.java:407)\r\n	at org.springframework.batch.core.step.tasklet.TaskletStep$ChunkTransactionCallback.doInTransaction(TaskletStep.java:331)\r\n	at org.springframework.transaction.support.TransactionTemplate.execute(TransactionTemplate.java:140)\r\n	at org.springframework.batch.core.step.tasklet.TaskletStep$2.doInChunkContext(TaskletStep.java:273)\r\n	at org.springframework.batch.core.scope.context.StepContextRepeatCallback.doInIteration(StepContextRepeatCallback.java:82)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.getNextResult(RepeatTemplate.java:375)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.executeInternal(RepeatTemplate.java:215)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.iterate(RepeatTemplate.java:145)\r\n	at org.springframework.batch.core.step.tasklet.TaskletStep.doExecute(TaskletStep.java:258)\r\n	at org.springframework.batch.core.step.AbstractStep.execute(AbstractStep.java:208)\r\n	at org.springframework.batch.core.job.SimpleStepHandler.handleStep(SimpleStepHandler.java:152)\r\n	at org.springframework.batch.core.job.flow.JobFlowExecutor.executeStep(JobFlowExecutor.java:68)\r\n	at org.springframework.batch.core.job.flow.support.state.StepState.handle(StepState.java:68)\r\n	at org.springframework.batch.core.job.flow.support.SimpleFlow.resume(SimpleFlow.java:169)\r\n	at org.springframework.batch.core.job.flow.support.SimpleFlow.start(SimpleFlow.java:144)\r\n	at org.springframework.batch.core.job.flow.FlowJob.doExecute(FlowJob.java:139)\r\n	at org.springframework.batch.core.job.AbstractJob.execute(AbstractJob.java:320)\r\n	at org.springframework.batch.core.launch.support.SimpleJobLauncher$1.run(SimpleJobLauncher.java:149)\r\n	at org.springframework.core.task.SyncTaskExecutor.execute(SyncTaskExecutor.java:50)\r\n	at org.springframework.batch.core.launch.support.SimpleJobLauncher.run(SimpleJobLauncher.java:140)\r\n	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:77)\r\n	at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.base/java.lang.reflect.Method.invoke(Method.java:568)\r\n	at org.springframework.aop.support.AopUtils.invokeJ', '2024-02-01 16:09:35.617000');
INSERT INTO `batch_step_execution` VALUES (36, 3, 'step1', 29, '2024-02-01 16:09:52.928000', '2024-02-01 16:09:53.006000', 'ABANDONED', 0, 0, 0, 0, 0, 0, 0, 1, 'FAILED', 'java.lang.RuntimeException: 测试fail结果\r\n	at com.ldd.step_status.StepStatusJob$1.execute(StepStatusJob.java:39)\r\n	at org.springframework.batch.core.step.tasklet.TaskletStep$ChunkTransactionCallback.doInTransaction(TaskletStep.java:407)\r\n	at org.springframework.batch.core.step.tasklet.TaskletStep$ChunkTransactionCallback.doInTransaction(TaskletStep.java:331)\r\n	at org.springframework.transaction.support.TransactionTemplate.execute(TransactionTemplate.java:140)\r\n	at org.springframework.batch.core.step.tasklet.TaskletStep$2.doInChunkContext(TaskletStep.java:273)\r\n	at org.springframework.batch.core.scope.context.StepContextRepeatCallback.doInIteration(StepContextRepeatCallback.java:82)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.getNextResult(RepeatTemplate.java:375)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.executeInternal(RepeatTemplate.java:215)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.iterate(RepeatTemplate.java:145)\r\n	at org.springframework.batch.core.step.tasklet.TaskletStep.doExecute(TaskletStep.java:258)\r\n	at org.springframework.batch.core.step.AbstractStep.execute(AbstractStep.java:208)\r\n	at org.springframework.batch.core.job.SimpleStepHandler.handleStep(SimpleStepHandler.java:152)\r\n	at org.springframework.batch.core.job.flow.JobFlowExecutor.executeStep(JobFlowExecutor.java:68)\r\n	at org.springframework.batch.core.job.flow.support.state.StepState.handle(StepState.java:68)\r\n	at org.springframework.batch.core.job.flow.support.SimpleFlow.resume(SimpleFlow.java:169)\r\n	at org.springframework.batch.core.job.flow.support.SimpleFlow.start(SimpleFlow.java:144)\r\n	at org.springframework.batch.core.job.flow.FlowJob.doExecute(FlowJob.java:139)\r\n	at org.springframework.batch.core.job.AbstractJob.execute(AbstractJob.java:320)\r\n	at org.springframework.batch.core.launch.support.SimpleJobLauncher$1.run(SimpleJobLauncher.java:149)\r\n	at org.springframework.core.task.SyncTaskExecutor.execute(SyncTaskExecutor.java:50)\r\n	at org.springframework.batch.core.launch.support.SimpleJobLauncher.run(SimpleJobLauncher.java:140)\r\n	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:77)\r\n	at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.base/java.lang.reflect.Method.invoke(Method.java:568)\r\n	at org.springframework.aop.support.AopUtils.invokeJ', '2024-02-01 16:09:53.045000');
INSERT INTO `batch_step_execution` VALUES (37, 3, 'stepA', 30, '2024-02-01 16:32:39.230000', '2024-02-01 16:32:39.318000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-01 16:32:39.319000');
INSERT INTO `batch_step_execution` VALUES (38, 2, 'stepB', 30, '2024-02-01 16:32:39.413000', '2024-02-01 16:32:40.661000', 'COMPLETED', 0, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-01 16:32:40.663000');
INSERT INTO `batch_step_execution` VALUES (39, 3, 'stepB1', 30, '2024-02-01 16:32:39.486000', '2024-02-01 16:32:39.602000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-01 16:32:39.603000');
INSERT INTO `batch_step_execution` VALUES (40, 3, 'stepB2', 30, '2024-02-01 16:32:39.829000', '2024-02-01 16:32:39.970000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-01 16:32:39.971000');
INSERT INTO `batch_step_execution` VALUES (41, 3, 'stepB3', 30, '2024-02-01 16:32:40.155000', '2024-02-01 16:32:40.513000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-01 16:32:40.514000');
INSERT INTO `batch_step_execution` VALUES (42, 3, 'stepC', 30, '2024-02-01 16:32:40.887000', '2024-02-01 16:32:40.996000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-01 16:32:40.996000');
INSERT INTO `batch_step_execution` VALUES (43, 3, 'step1', 31, '2024-02-01 16:56:42.681000', '2024-02-01 16:56:42.758000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-01 16:56:42.759000');
INSERT INTO `batch_step_execution` VALUES (44, 3, 'step1', 32, '2024-02-01 17:13:08.671000', '2024-02-01 17:13:08.800000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-01 17:13:08.803000');
INSERT INTO `batch_step_execution` VALUES (45, 3, 'step1', 33, '2024-02-01 17:29:02.133000', '2024-02-01 17:29:02.200000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-01 17:29:02.201000');
INSERT INTO `batch_step_execution` VALUES (46, 3, 'step1', 34, '2024-02-01 18:16:07.667000', '2024-02-01 18:16:07.756000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'STOPPED', '', '2024-02-01 18:16:07.757000');
INSERT INTO `batch_step_execution` VALUES (47, 3, 'step1', 35, '2024-02-01 18:23:39.899000', '2024-02-01 18:23:39.973000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-01 18:23:39.973000');
INSERT INTO `batch_step_execution` VALUES (48, 3, 'step2', 35, '2024-02-01 18:23:40.066000', '2024-02-01 18:23:40.146000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-01 18:23:40.148000');
INSERT INTO `batch_step_execution` VALUES (49, 3, 'step1', 36, '2024-02-01 18:31:54.642000', '2024-02-01 18:31:54.720000', 'STOPPED', 1, 0, 0, 0, 0, 0, 0, 0, 'STOPPED', 'org.springframework.batch.core.JobInterruptedException', '2024-02-01 18:31:54.721000');
INSERT INTO `batch_step_execution` VALUES (50, 3, 'step1', 37, '2024-02-01 18:32:13.625000', '2024-02-01 18:32:13.679000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-01 18:32:13.680000');
INSERT INTO `batch_step_execution` VALUES (51, 3, 'step2', 37, '2024-02-01 18:32:13.749000', '2024-02-01 18:32:13.810000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-01 18:32:13.811000');
INSERT INTO `batch_step_execution` VALUES (52, 3, 'step1', 38, '2024-02-02 11:05:27.416000', '2024-02-02 11:05:27.771000', 'STOPPED', 1, 0, 0, 0, 0, 0, 0, 0, 'STOPPED', 'org.springframework.batch.core.JobInterruptedException', '2024-02-02 11:05:27.802000');
INSERT INTO `batch_step_execution` VALUES (53, 3, 'step1', 39, '2024-02-02 11:16:14.519000', '2024-02-02 11:16:14.598000', 'STOPPED', 1, 0, 0, 0, 0, 0, 0, 0, 'STOPPED', 'org.springframework.batch.core.JobInterruptedException', '2024-02-02 11:16:14.600000');
INSERT INTO `batch_step_execution` VALUES (54, 3, 'step1', 40, '2024-02-02 11:17:19.402000', '2024-02-02 11:17:19.454000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-02 11:17:19.455000');
INSERT INTO `batch_step_execution` VALUES (55, 3, 'step2', 40, '2024-02-02 11:17:19.954000', '2024-02-02 11:17:20.042000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-02 11:17:20.044000');
INSERT INTO `batch_step_execution` VALUES (56, 3, 'step1', 43, '2024-02-02 11:23:51.737000', '2024-02-02 11:23:51.801000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-02 11:23:51.802000');
INSERT INTO `batch_step_execution` VALUES (57, 3, 'step2', 43, '2024-02-02 11:23:51.871000', '2024-02-02 11:23:51.932000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-02 11:23:51.933000');
INSERT INTO `batch_step_execution` VALUES (58, 3, 'step1', 45, '2024-02-02 11:25:09.879000', '2024-02-02 11:25:10.023000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-02 11:25:10.024000');
INSERT INTO `batch_step_execution` VALUES (59, 3, 'step2', 45, '2024-02-02 11:25:10.322000', '2024-02-02 11:25:10.591000', 'COMPLETED', 1, 0, 0, 0, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-02 11:25:10.591000');
INSERT INTO `batch_step_execution` VALUES (60, 8, 'step1', 46, '2024-02-02 14:53:13.159000', '2024-02-02 14:53:13.436000', 'COMPLETED', 6, 5, 0, 5, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-02 14:53:13.436000');
INSERT INTO `batch_step_execution` VALUES (61, 8, 'step1', 47, '2024-02-02 15:13:41.579000', '2024-02-02 15:13:41.815000', 'COMPLETED', 6, 5, 0, 5, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-02 15:13:41.817000');
INSERT INTO `batch_step_execution` VALUES (62, 8, 'step1', 50, '2024-02-02 15:31:22.878000', '2024-02-02 15:31:23.138000', 'COMPLETED', 6, 5, 0, 5, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-02 15:31:23.139000');
INSERT INTO `batch_step_execution` VALUES (63, 8, 'step1', 51, '2024-02-02 15:44:26.227000', '2024-02-02 15:44:26.437000', 'COMPLETED', 6, 5, 0, 5, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-02 15:44:26.438000');
INSERT INTO `batch_step_execution` VALUES (64, 5, 'step1', 53, '2024-02-02 15:49:39.506000', '2024-02-02 15:49:39.785000', 'COMPLETED', 3, 2, 0, 2, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-02 15:49:39.786000');
INSERT INTO `batch_step_execution` VALUES (65, 15, 'step1', 54, '2024-02-02 16:00:42.830000', '2024-02-02 16:00:43.549000', 'COMPLETED', 13, 12, 0, 12, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-02 16:00:43.551000');
INSERT INTO `batch_step_execution` VALUES (66, 15, 'step1', 55, '2024-02-02 16:02:01.310000', '2024-02-02 16:02:02.323000', 'COMPLETED', 13, 12, 0, 12, 0, 0, 0, 0, 'COMPLETED', '', '2024-02-02 16:02:02.324000');

-- ----------------------------
-- Table structure for batch_step_execution_context
-- ----------------------------
DROP TABLE IF EXISTS `batch_step_execution_context`;
CREATE TABLE `batch_step_execution_context`  (
  `STEP_EXECUTION_ID` bigint(0) NOT NULL,
  `SHORT_CONTEXT` varchar(2500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `SERIALIZED_CONTEXT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  PRIMARY KEY (`STEP_EXECUTION_ID`) USING BTREE,
  CONSTRAINT `STEP_EXEC_CTX_FK` FOREIGN KEY (`STEP_EXECUTION_ID`) REFERENCES `batch_step_execution` (`STEP_EXECUTION_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of batch_step_execution_context
-- ----------------------------
INSERT INTO `batch_step_execution_context` VALUES (1, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.params.ParamsJob$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (2, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.params.ParamsJob$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (3, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.params_validator.ParamsValidatorJob$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (4, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.params_validator.ParamsValidatorJob$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (5, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.params_incr.IncrementParamJob$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (6, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.params_incr.IncrementParamJob$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (7, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.params_incr.IncrementParamJob$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (8, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.params_incr.IncrementParamJob$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (9, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.params_incr.IncrementParamJob$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (10, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.job_listener.StatusListenerJob$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (11, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.job_anno_listener.StatusListenerAnnoJob$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (12, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (13, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (14, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (15, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.context.ExecutionContextJob$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\",\"key-step1-step\":\"value-step1-step\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (16, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.context.ExecutionContextJob$2\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (17, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.step_listener.StepListenerJob$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (18, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.multi_step.MultiStepJob$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (19, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.multi_step.MultiStepJob$2\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (20, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.step_condition.ConditionStepJob$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (21, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.step_condition.ConditionStepJob$2\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (22, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.step_condition.ConditionStepJob$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (23, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.step_condition.ConditionStepJob$3\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (24, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.step_condition_decider.CustomizeStatusStepJob$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (25, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.step_condition_decider.CustomizeStatusStepJob$2\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (26, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.step_status.StepStatusJob$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (27, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.step_status.StepStatusJob$2\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (28, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.step_status.StepStatusJob$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (29, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.step_status.StepStatusJob$2\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (30, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.step_status.StepStatusJob$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (31, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.step_status.StepStatusJob$2\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (32, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.step_status.StepStatusJob$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (33, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.step_status.StepStatusJob$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (34, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.step_status.StepStatusJob$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (35, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.step_status.StepStatusJob$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (36, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.step_status.StepStatusJob$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (37, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.flow_step.FlowStepJob$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (38, '{\"@class\":\"java.util.HashMap\",\"batch.stepType\":\"org.springframework.batch.core.job.flow.FlowStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (39, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.flow_step.FlowStepJob$2\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (40, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.flow_step.FlowStepJob$3\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (41, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.flow_step.FlowStepJob$4\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (42, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.flow_step.FlowStepJob$5\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (43, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.start_test_job.StartJobTest$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (44, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.start_restful_job.config.BatchConfig$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (45, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.start_restful_job.config.BatchConfig$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (46, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.stop_job.ListenerJobStopJob$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (47, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.stop_job.ListenerJobStopJob$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (48, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.stop_job.ListenerJobStopJob$2\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (49, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.stop_sign_job.SignJobStopJob$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (50, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.stop_sign_job.SignJobStopJob$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (51, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.stop_sign_job.SignJobStopJob$2\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (52, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.forbid_restart_job.JobForBidRestartJob$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (53, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.restart_limit_job.JobLimitRestartJob$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (54, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.restart_limit_job.JobLimitRestartJob$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (55, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.restart_limit_job.JobLimitRestartJob$2\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (56, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.restart_allow_job.JobAllowRestartJob$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (57, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.restart_allow_job.JobAllowRestartJob$2\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (58, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.restart_allow_job.JobAllowRestartJob$1\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (59, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"com.ldd.restart_allow_job.JobAllowRestartJob$2\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (60, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\",\"userItemReader.read.count\":6}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (61, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\",\"userMapperItemReader.read.count\":6}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (62, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\",\"userJsonItemReader.read.count\":6}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (63, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"userCursorItemReader.read.count\":6,\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (64, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"userCursorItemReader.read.count\":3,\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (65, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"userPagingItemReader.read.count\":13,\"userPagingItemReader.start.after\":{\"@class\":\"java.util.LinkedHashMap\",\"id\":[\"java.lang.Long\",22]},\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);
INSERT INTO `batch_step_execution_context` VALUES (66, '{\"@class\":\"java.util.HashMap\",\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"userPagingItemReader.read.count\":13,\"userPagingItemReader.start.after\":{\"@class\":\"java.util.LinkedHashMap\",\"id\":[\"java.lang.Long\",22]},\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}', NULL);

-- ----------------------------
-- Table structure for batch_step_execution_seq
-- ----------------------------
DROP TABLE IF EXISTS `batch_step_execution_seq`;
CREATE TABLE `batch_step_execution_seq`  (
  `ID` bigint(0) NOT NULL,
  `UNIQUE_KEY` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  UNIQUE INDEX `UNIQUE_KEY_UN`(`UNIQUE_KEY`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of batch_step_execution_seq
-- ----------------------------
INSERT INTO `batch_step_execution_seq` VALUES (66, '0');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `age` int(0) NULL DEFAULT NULL COMMENT '年龄',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'xiaodong', 18);
INSERT INTO `user` VALUES (2, 'xiaojia', 17);
INSERT INTO `user` VALUES (3, 'xiaoxue', 16);
INSERT INTO `user` VALUES (4, 'xiaoming', 15);
INSERT INTO `user` VALUES (5, 'xiaogang', 14);
INSERT INTO `user` VALUES (6, 'xiaodong2', 18);
INSERT INTO `user` VALUES (7, 'xiaojia2', 17);
INSERT INTO `user` VALUES (8, 'xiaoxue2', 16);
INSERT INTO `user` VALUES (9, 'xiaoming2', 15);
INSERT INTO `user` VALUES (10, 'xiaogang3', 14);
INSERT INTO `user` VALUES (11, 'xiaodong3', 18);
INSERT INTO `user` VALUES (12, 'xiaojia3', 17);
INSERT INTO `user` VALUES (13, 'xiaoxue3', 16);
INSERT INTO `user` VALUES (14, 'xiaoming3', 15);
INSERT INTO `user` VALUES (15, 'xiaogang3', 14);
INSERT INTO `user` VALUES (16, 'xiaodong4', 18);
INSERT INTO `user` VALUES (17, 'xiaojia4', 17);
INSERT INTO `user` VALUES (18, 'xiaoxue4', 16);
INSERT INTO `user` VALUES (19, 'xiaoming4', 15);
INSERT INTO `user` VALUES (20, 'xiaogang4', 14);
INSERT INTO `user` VALUES (21, 'xiaodong5', 18);
INSERT INTO `user` VALUES (22, 'xiaojia5', 17);
INSERT INTO `user` VALUES (23, 'xiaoxue5', 16);
INSERT INTO `user` VALUES (24, 'xiaoming5', 15);
INSERT INTO `user` VALUES (25, 'xiaogang5', 14);
INSERT INTO `user` VALUES (26, 'xiaodong6', 18);
INSERT INTO `user` VALUES (27, 'xiaojia6', 17);
INSERT INTO `user` VALUES (28, 'xiaoxue6', 16);
INSERT INTO `user` VALUES (29, 'xiaoming6', 15);
INSERT INTO `user` VALUES (30, 'xiaogang6', 14);

SET FOREIGN_KEY_CHECKS = 1;