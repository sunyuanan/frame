/*
 Navicat Premium Data Transfer

 Source Server         : dk_mysql
 Source Server Type    : MySQL
 Source Server Version : 80022
 Source Host           : localhost:3307
 Source Schema         : frame_test

 Target Server Type    : MySQL
 Target Server Version : 80022
 File Encoding         : 65001

 Date: 08/08/2022 16:32:14
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ip_blacklist_info
-- ----------------------------
DROP TABLE IF EXISTS `ip_blacklist_info`;
CREATE TABLE `ip_blacklist_info`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ip` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '黑名单IP',
  `mapping` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地址 (所有则是*)',
  `create_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sync_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注原因',
  `effective_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '有效时间 (单位小时) -1则永久',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否启用 1启动',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'ip黑名单记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ip_blacklist_info
-- ----------------------------

-- ----------------------------
-- Table structure for job_log
-- ----------------------------
DROP TABLE IF EXISTS `job_log`;
CREATE TABLE `job_log`  (
  `job_log_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务组名',
  `method_name` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务方法',
  `method_params` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '方法参数',
  `job_message` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of job_log
-- ----------------------------

-- ----------------------------
-- Table structure for public_attachement
-- ----------------------------
DROP TABLE IF EXISTS `public_attachement`;
CREATE TABLE `public_attachement`  (
  `id` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'id',
  `fjmc` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件名称',
  `fjlj` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件路径',
  `create_time` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新时间',
  `sync_time` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '时间戳',
  `glid` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关联id',
  `fjlx` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件类型',
  `fjhzm` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件后缀',
  `ysmc` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '原始名称',
  `fjdl` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '附件大类',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci COMMENT = '附件信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of public_attachement
-- ----------------------------
INSERT INTO `public_attachement` VALUES ('56dece0d7d40405583966b1e99a5dd90', '20220215094618-08227b840e20411a97bdb137092adf55', 'vitalSings/importAndExportFile/20220215094618-08227b840e20411a97bdb137092adf55.txt', '2022-02-15 09:46:18', NULL, '1644889578878', NULL, '生命体征导入导出模板', '.txt', '20220214114454-04f659134f46465aa16abd381875aec8.txt', '导入导出模板');

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `BLOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CALENDAR_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CALENDAR` longblob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `CALENDAR_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CRON_EXPRESSION` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TIME_ZONE_ID` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  INDEX `SYS_C001197117`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ENTRY_ID` varchar(95) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `FIRED_TIME` decimal(65, 30) NOT NULL,
  `SCHED_TIME` decimal(65, 30) NOT NULL,
  `PRIORITY` decimal(65, 30) NOT NULL,
  `STATE` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `ENTRY_ID`) USING BTREE,
  INDEX `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY`(`SCHED_NAME`, `INSTANCE_NAME`, `REQUESTS_RECOVERY`) USING BTREE,
  INDEX `IDX_QRTZ_FT_JG`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_FT_J_G`(`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_FT_TG`(`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_FT_TRIG_INST_NAME`(`SCHED_NAME`, `INSTANCE_NAME`) USING BTREE,
  INDEX `IDX_QRTZ_FT_T_G`(`TRIGGER_NAME`, `SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `DESCRIPTION` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_DURABLE` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_UPDATE_DATA` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_DATA` longblob NULL,
  `JOB_METHOD_NAME` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_J_GRP`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_J_REQ_RECOVERY`(`SCHED_NAME`, `REQUESTS_RECOVERY`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `LOCK_NAME` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `LOCK_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO `qrtz_locks` VALUES ('clusteredScheduler', 'STATE_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('clusteredScheduler', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `LAST_CHECKIN_TIME` decimal(65, 30) NOT NULL,
  `CHECKIN_INTERVAL` decimal(65, 30) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `INSTANCE_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
INSERT INTO `qrtz_scheduler_state` VALUES ('clusteredScheduler', 'DESKTOP-HOVKLEA1588214489680', 1588221591087.000000000000000000000000000000, 10000.000000000000000000000000000000);

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `REPEAT_COUNT` decimal(65, 30) NOT NULL,
  `REPEAT_INTERVAL` decimal(65, 30) NOT NULL,
  `TIMES_TRIGGERED` decimal(65, 30) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `STR_PROP_1` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `STR_PROP_2` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `STR_PROP_3` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `INT_PROP_1` decimal(65, 30) NULL DEFAULT NULL,
  `INT_PROP_2` decimal(65, 30) NULL DEFAULT NULL,
  `LONG_PROP_1` decimal(65, 30) NULL DEFAULT NULL,
  `LONG_PROP_2` decimal(65, 30) NULL DEFAULT NULL,
  `DEC_PROP_1` decimal(65, 30) NULL DEFAULT NULL,
  `DEC_PROP_2` decimal(65, 30) NULL DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `DESCRIPTION` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `NEXT_FIRE_TIME` decimal(65, 30) NULL DEFAULT NULL,
  `PREV_FIRE_TIME` decimal(65, 30) NULL DEFAULT NULL,
  `PRIORITY` decimal(65, 30) NULL DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_TYPE` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `START_TIME` decimal(65, 30) NOT NULL,
  `END_TIME` decimal(65, 30) NULL DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `MISFIRE_INSTR` decimal(65, 30) NULL DEFAULT NULL,
  `JOB_DATA` longblob NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_C`(`SCHED_NAME`, `CALENDAR_NAME`) USING BTREE,
  INDEX `IDX_QRTZ_T_G`(`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_J`(`JOB_NAME`, `JOB_GROUP`, `SCHED_NAME`) USING BTREE,
  INDEX `IDX_QRTZ_T_JG`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_NEXT_FIRE_TIME`(`NEXT_FIRE_TIME`, `SCHED_NAME`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_MISFIRE`(`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST`(`NEXT_FIRE_TIME`, `TRIGGER_STATE`, `SCHED_NAME`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST_MISFIRE`(`NEXT_FIRE_TIME`, `TRIGGER_STATE`, `SCHED_NAME`, `MISFIRE_INSTR`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP`(`TRIGGER_GROUP`, `TRIGGER_STATE`, `NEXT_FIRE_TIME`, `MISFIRE_INSTR`, `SCHED_NAME`) USING BTREE,
  INDEX `IDX_QRTZ_T_N_G_STATE`(`TRIGGER_GROUP`, `TRIGGER_STATE`, `SCHED_NAME`) USING BTREE,
  INDEX `IDX_QRTZ_T_N_STATE`(`TRIGGER_STATE`, `SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_STATE`(`TRIGGER_STATE`, `SCHED_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for quartz_entity
-- ----------------------------
DROP TABLE IF EXISTS `quartz_entity`;
CREATE TABLE `quartz_entity`  (
  `ID` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务ID',
  `JOB_NAME` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务名称',
  `JOB_GROUP` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务组名',
  `METHOD_NAME` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '任务方法',
  `METHOD_PARAMS` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '方法参数',
  `CRON_EXPRESSION` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'CRON执行表达式',
  `MISFIRE_POLICY` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `CONCURRENT` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否并发执行（0允许 1禁止）',
  `STATUS` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态（0正常 1暂停）',
  `CREATE_BY` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `CREATE_TIME` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建时间',
  `UPDATE_BY` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `UPDATE_TIME` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新时间',
  `REMARK` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '备注信息',
  PRIMARY KEY (`ID`, `JOB_NAME`, `JOB_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of quartz_entity
-- ----------------------------
INSERT INTO `quartz_entity` VALUES ('30b5d1d576c24d78bcbebf44764b14ba', 'timedTaskPublicJob', 't1', 'test1', NULL, '* * * * * ?', '0', NULL, '1', NULL, NULL, NULL, '2022-01-04 10:57:04', 'test');
INSERT INTO `quartz_entity` VALUES ('74273a87cd224d07b885e4e33cc87e11', 'timedTaskPublicJob', '1', 'test2', NULL, '* * * * * ?', '0', NULL, '1', NULL, NULL, NULL, '2022-01-04 10:57:06', '1');
INSERT INTO `quartz_entity` VALUES ('a93cb4c812f74c3483a39f2eeffdbbfa', 'timedTaskPublicJob', 'T1', 'test', '', '*/5 * * * * ?', '0', NULL, '1', NULL, NULL, NULL, '2022-01-04 10:57:08', '定时任务');

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `ID` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字典编码',
  `DICT_SORT` int(0) NULL DEFAULT NULL COMMENT '字典排序',
  `DICT_LABEL` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典标签',
  `DICT_VALUE` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典键值',
  `DICT_TYPE` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典类型',
  `STATUS` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态（0正常 1停用）',
  `CREATE_TIME` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建时间',
  `UPDATE_TIME` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新时间',
  `SYNC_TIME` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '时间戳',
  `REMARK` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '备注',
  `TYPE_ID` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型ID',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES ('039b7827b4cd11de3a8512477b60c4fb', 2, '导入导出模板', 'importAndExportFile', 'majorCategories', '0', '2020-08-11 10:54:26', '2021-12-18 15:14:58', '1597114466439', 'drdcmb', 'b896af49054c3f34a165f315315c4cba');
INSERT INTO `sys_dict_data` VALUES ('5351601a31b53e1d684c161af9f31dbd', 1, '设备用户头像', 'equipmentUser/tx/', 'systemPathConfiguration', '0', '2020-08-11 10:31:12', '2020-08-17 10:42:36', '1597113072619', 'equipmentUserTx', 'd7256bfa6e29b5bbe9776531d1697b30');
INSERT INTO `sys_dict_data` VALUES ('5a132cf262a1ae85af7662114b7e2529', 1, '头像', 'headPortrait', 'majorCategories', '0', '2020-08-11 11:03:05', '2021-12-18 15:15:01', '1597114985562', 'tx', 'b896af49054c3f34a165f315315c4cba');
INSERT INTO `sys_dict_data` VALUES ('a98f2243ce932b82820d0c95ea01245f', 4, '生命体征导入导出模板', 'vitalSings/importAndExportFile/', 'systemPathConfiguration', '0', '2020-08-13 10:57:12', '2021-12-18 15:05:54', '1597287432704', 'vitalSingsImportAndExportFile', 'd7256bfa6e29b5bbe9776531d1697b30');
INSERT INTO `sys_dict_data` VALUES ('bb8e20915b78e2709a8439c3f0f61c84', 5, '设备导入导出模板', 'equipment/importAndExportFile/', 'systemPathConfiguration', '0', '2020-08-14 17:57:41', '2020-08-17 10:45:03', '1597399061286', 'equipmentImportAndExportFile', 'd7256bfa6e29b5bbe9776531d1697b30');
INSERT INTO `sys_dict_data` VALUES ('be2a9bc3c3d98288c9dd24d47a12e986', 6, '用户头像', 'user/tx/', 'systemPathConfiguration', '0', '2020-08-17 14:38:55', '2020-08-17 14:39:09', '1597646335557', 'userTx', 'd7256bfa6e29b5bbe9776531d1697b30');
INSERT INTO `sys_dict_data` VALUES ('e6f1074487e5a000f585482eae030063', 3, '设备用户犯罪记录导入导出模板', 'equipmentUserCriminaRecord/ImportAndExportFile/', 'systemPathConfiguration', '0', '2020-08-11 16:38:19', '2020-08-17 10:45:12', '1597135099952', 'equipmentUserCriminaRecordImportAndExportFile', 'd7256bfa6e29b5bbe9776531d1697b30');
INSERT INTO `sys_dict_data` VALUES ('eab9cb3a658965c7099613e0be515a8d', 2, '设备用户导入导出模板', 'equipmentUser/importAndExportFile/', 'systemPathConfiguration', '0', '2020-08-11 10:30:52', '2020-08-17 10:45:20', '1597113052643', 'equipmentUserImportAndExportFile', 'd7256bfa6e29b5bbe9776531d1697b30');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `ID` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字典主键',
  `DICT_NAME` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典名称',
  `DICT_TYPE` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典类型',
  `STATUS` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态（0正常 1停用）',
  `CREATE_TIME` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建时间',
  `SYNC_TIME` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '时间戳',
  `UPDATE_TIME` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新时间',
  `REMARK` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '备注',
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE INDEX `DICT_TYPE`(`DICT_TYPE`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES ('b896af49054c3f34a165f315315c4cba', '附件大类', 'majorCategories', '0', '2020-08-11 10:51:21', '1597114281141', NULL, 'fjdl');
INSERT INTO `sys_dict_type` VALUES ('d7256bfa6e29b5bbe9776531d1697b30', '系统附件路径配置', 'systemPathConfiguration', '0', '2020-08-11 10:30:19', '1597113019769', '2021-12-18 15:51:21', 'xtljpz');

-- ----------------------------
-- Table structure for sys_generator
-- ----------------------------
DROP TABLE IF EXISTS `sys_generator`;
CREATE TABLE `sys_generator`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'ID',
  `table_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '表名',
  `menu_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '菜单名称',
  `pid` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '上级菜单',
  `gen_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_generator
-- ----------------------------
INSERT INTO `sys_generator` VALUES ('1452941579131092993', 'sys_user', NULL, NULL, '2021-10-26 18:14:01');
INSERT INTO `sys_generator` VALUES ('1453667537940430850', 'sys_log', NULL, NULL, '2021-10-28 18:18:43');
INSERT INTO `sys_generator` VALUES ('1453904041224708098', 'sys_intercept_log', NULL, NULL, '2021-10-29 09:58:30');
INSERT INTO `sys_generator` VALUES ('1454344327939842050', 'quartz_entity', NULL, NULL, '2021-10-30 15:08:02');
INSERT INTO `sys_generator` VALUES ('1455448489658191874', 'sys_permission', NULL, NULL, '2021-11-02 16:15:35');
INSERT INTO `sys_generator` VALUES ('1455477670714585089', 'sys_user_role', NULL, NULL, '2021-11-02 18:11:32');
INSERT INTO `sys_generator` VALUES ('1455478078371573762', 'sys_role_permission', NULL, NULL, '2021-11-02 18:13:10');
INSERT INTO `sys_generator` VALUES ('1456081453946241025', 'sys_dict_data', NULL, NULL, '2021-11-04 10:10:45');
INSERT INTO `sys_generator` VALUES ('1456081474963898370', 'sys_role', NULL, NULL, '2021-11-04 10:10:50');
INSERT INTO `sys_generator` VALUES ('1456081701150130178', 'sys_dict_type', NULL, NULL, '2021-11-04 10:11:44');
INSERT INTO `sys_generator` VALUES ('1456512774317293569', 'sys_tree_data', NULL, NULL, '2021-11-05 14:44:40');
INSERT INTO `sys_generator` VALUES ('1458334749586399234', 'sys_user_login_view', NULL, NULL, '2021-11-10 15:24:33');
INSERT INTO `sys_generator` VALUES ('1472031359524687874', 'sys_user_company', NULL, NULL, '2021-12-18 10:29:59');
INSERT INTO `sys_generator` VALUES ('1472079081858445314', 'public_attachement', NULL, NULL, '2021-12-18 13:39:37');
INSERT INTO `sys_generator` VALUES ('1493513392943828994', 'ip_blacklist_info', NULL, NULL, '2022-02-15 17:11:55');
INSERT INTO `sys_generator` VALUES ('1498580345135939585', 'while_region_info', NULL, NULL, '2022-03-01 16:46:11');
INSERT INTO `sys_generator` VALUES ('1498582350382350338', 'white_region_info', NULL, NULL, '2022-03-01 16:54:09');
INSERT INTO `sys_generator` VALUES ('2', 'sys_generator', '代码生成', '0', '2020-03-20 13:16:47');

-- ----------------------------
-- Table structure for sys_intercept_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_intercept_log`;
CREATE TABLE `sys_intercept_log`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '拦截的IP',
  `request_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接口地址',
  `method` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求方式',
  `params` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '参数',
  `create_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sync_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `error_info` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '拦截内容',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '拦截异常日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_intercept_log
-- ----------------------------
INSERT INTO `sys_intercept_log` VALUES ('0051a637-04f1-46a9-8d33-b4350bad5d39', '0:0:0:0:0:0:0:1', 'http://localhost:888/', 'GET', NULL, '2022-01-27 16:55:27', '1643273727723', '未提供Token');
INSERT INTO `sys_intercept_log` VALUES ('0663643d-6831-4152-bfe5-1d1694b02b00', '0:0:0:0:0:0:0:1', 'http://localhost:888/', 'GET', NULL, '2022-01-27 16:54:57', '1643273697466', '未提供Token');
INSERT INTO `sys_intercept_log` VALUES ('0cba291c-51e2-44b5-83df-987bb6617ed5', '192.168.0.124', 'http://192.168.0.124:888/sysInterceptLog/listByPage', 'POST', '{\"page\":1,\"limit\":13,\"ip\":\"\"}', '2022-04-06 14:34:29', '1649226869185', 'ip黑名单访问');
INSERT INTO `sys_intercept_log` VALUES ('156d8d86-cbdc-4944-bab7-8c8c0607a661', '0:0:0:0:0:0:0:1', 'http://localhost:888/login', 'GET', NULL, '2022-03-03 09:41:47', '1646271707996', 'ip黑名单访问');
INSERT INTO `sys_intercept_log` VALUES ('1a5b738e-cf40-470a-b15e-712ce9fc9c12', '192.168.0.124', 'http://192.168.0.124:888/sysLog/logs', 'POST', '{\"page\":1,\"limit\":13,\"operation\":\"\"}', '2022-03-01 16:14:24', '1646122464747', 'ip黑名单访问');
INSERT INTO `sys_intercept_log` VALUES ('1c7e4b09-89ad-42fa-bb29-7759090e298f', '192.168.0.124', 'http://192.168.0.124:888/job/listByPage', 'POST', '{\"page\":1}', '2022-07-28 15:15:35', '1658992535911', 'ip黑名单访问');
INSERT INTO `sys_intercept_log` VALUES ('1e742623-84ab-4fe3-b046-5043d8379a92', '192.168.0.124', 'http://192.168.0.124:888/ipBlacklistInfo/listByPage', 'POST', '{\"page\":1,\"limit\":13,\"ip\":\"\"}', '2022-04-06 14:34:25', '1649226865986', 'ip黑名单访问');
INSERT INTO `sys_intercept_log` VALUES ('21c5629a-d995-45e8-9652-4c689d410778', '0:0:0:0:0:0:0:1', 'http://localhost:888/', 'GET', NULL, '2022-01-27 16:51:29', '1643273489712', '未提供Token');
INSERT INTO `sys_intercept_log` VALUES ('271fc7ee-5948-41cf-ac56-a5e1e0641b8e', '192.168.0.124', 'http://192.168.0.124:888/sysUser/login', 'POST', '{\"username\":\"admin\",\"password\":\"111111\",\"type\":2}', '2022-02-16 09:09:21', '1644973761919', NULL);
INSERT INTO `sys_intercept_log` VALUES ('2ce22cfc-f7cd-4b23-9082-d18268f85d61', '192.168.0.124', 'http://192.168.0.124:888/sysLog/logs', 'OPTIONS', NULL, '2022-03-01 16:14:24', '1646122464738', 'ip黑名单访问');
INSERT INTO `sys_intercept_log` VALUES ('2ce2f31b-7d99-40fb-8704-01c08884a021', '192.168.0.124', 'http://192.168.0.124:888/ipBlacklistInfo/listByPage', 'POST', '{\"page\":1,\"limit\":13,\"ip\":\"\"}', '2022-03-01 16:38:54', '1646123934738', 'Token已被顶下线：eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJsb2dpbklkIjoiNGFjZjUzMDU1NTI4NGMwM2E1NThjMGY3Njg0NDQzNjMiLCJybiI6Ik8yeDNZVnVoUkhqQUo2Z3RPVGJSeDRKVzI1ZGc4RWRZIn0.667iFUVKbPWpAqnQRk6pe5i0HPVjqevcvFDwd2LVPpw');
INSERT INTO `sys_intercept_log` VALUES ('2f8affce-dc2e-459f-8e25-dd160dc2e0e0', '192.168.0.124', 'http://192.168.0.124:888/sysUser/login', 'POST', '{\"username\":\"admin\",\"password\":\"111111\",\"type\":2}', '2022-02-16 09:10:06', '1644973806724', NULL);
INSERT INTO `sys_intercept_log` VALUES ('31c4b4e0-d70d-4bc0-8aa3-df034f3140d7', '192.168.0.124', 'http://192.168.0.124:888/sysInterceptLog/listByPage', 'OPTIONS', NULL, '2022-03-01 16:14:59', '1646122499504', 'ip黑名单访问');
INSERT INTO `sys_intercept_log` VALUES ('3697cbcd-04a6-4dec-949b-f5164cc687dc', '192.168.0.124', 'http://192.168.0.124:888/sysUser/login', 'POST', '{\"username\":\"admin\",\"password\":\"111111\",\"type\":2}', '2022-03-02 11:56:33', '1646193393122', 'ip黑名单访问');
INSERT INTO `sys_intercept_log` VALUES ('3a0ad2ed-adb8-4035-b69f-f03d7334889a', '0:0:0:0:0:0:0:1', 'http://localhost:888/sysPermission/listByCondition', 'POST', '{', '2022-03-03 09:45:34', '1646271934812', '未提供Token');
INSERT INTO `sys_intercept_log` VALUES ('3e3d744d-f877-4d6f-978f-622fe8b21ce8', '192.168.0.124', 'http://192.168.0.124:888/sysInterceptLog/listByPage', 'OPTIONS', NULL, '2022-03-01 16:11:57', '1646122317425', 'ip黑名单访问');
INSERT INTO `sys_intercept_log` VALUES ('3ea437cd-e544-447a-80d2-f5d989c20956', '192.168.0.124', 'http://192.168.0.124:888/sysLog/logs', 'OPTIONS', NULL, '2022-04-06 14:34:29', '1649226869915', 'ip黑名单访问');
INSERT INTO `sys_intercept_log` VALUES ('45e2f5ce-512c-4cbc-9d0a-f28d181b630d', '192.168.0.124', 'http://192.168.0.124:888/sysUser/login', 'POST', '{\"username\":\"admin\",\"password\":\"111111\",\"type\":2}', '2022-02-16 09:12:21', '1644973941678', NULL);
INSERT INTO `sys_intercept_log` VALUES ('53749086-c456-4d76-bbe2-e65bdf25c1a7', '192.168.0.124', 'http://192.168.0.124:888/sysInterceptLog/listByPage', 'POST', '{\"page\":1,\"limit\":13,\"ip\":\"\"}', '2022-03-01 16:11:57', '1646122317437', 'ip黑名单访问');
INSERT INTO `sys_intercept_log` VALUES ('572dd8ab-c91c-44e3-8cbe-dc81266662d0', '0:0:0:0:0:0:0:1', 'http://localhost:888/', 'GET', NULL, '2022-03-03 09:41:44', '1646271704573', 'ip黑名单访问');
INSERT INTO `sys_intercept_log` VALUES ('597ef26c-1d65-46a4-8b71-493a275e4c3b', '0:0:0:0:0:0:0:1', 'http://localhost:888/', 'GET', NULL, '2022-01-27 16:55:31', '1643273731383', '未提供Token');
INSERT INTO `sys_intercept_log` VALUES ('6d5753d0-888a-43db-8cb2-6d358869907f', '192.168.0.124', 'http://192.168.0.124:888/sysLog/logs', 'POST', '{\"page\":1,\"limit\":13,\"operation\":\"\"}', '2022-04-06 14:34:29', '1649226869932', 'ip黑名单访问');
INSERT INTO `sys_intercept_log` VALUES ('6e9d5d40-1d91-4db2-a8dd-ed49941502ab', '192.168.0.124', 'http://192.168.0.124:888/sysLog/logs', 'POST', '{\"page\":1,\"limit\":13,\"operation\":\"\"}', '2022-03-01 16:11:58', '1646122318058', 'ip黑名单访问');
INSERT INTO `sys_intercept_log` VALUES ('6f2bb8e9-ee72-4a5b-8fa3-4831b73c3bd3', '192.168.0.124', 'http://192.168.0.124:888/', 'GET', NULL, '2022-07-27 14:12:59', '1658902379865', 'Token无效：eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJsb2dpbklkIjoiNGFjZjUzMDU1NTI4NGMwM2E1NThjMGY3Njg0NDQzNjMiLCJybiI6Ik1oS2xLVkVpOUNYcUpoWlhHMllaUE5WaWw3UDc5YUV5In0.AGc42uiFO_2K7Hmj2F5CoYL-i-iOt8nBhUNME08lzkU');
INSERT INTO `sys_intercept_log` VALUES ('763aa3b4-be21-4353-8ed4-93fc9e522dad', '192.168.0.124', 'http://192.168.0.124:888/sysRole/update', 'PUT', '{\"id\":\"11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9\",\"name\":\"超级管理员\",\"description\":\"拥有所有权限-不能删除\",\"status\":\"1\",\"permissionList\":[\"2cac5102ece741d9a48eb5524a264294\",\"2f1e10a368c3420da7efb9e28f9dcd89\",\"270a28c3d58343348353455d32fc2c55\",\"088c12320dba460f95ddf52d94bd939b\",\"1026b0e03be14c1ca036ec106d0ec660\",\"4d1555b2e7bf406a91c5713bba13c054\",\"afff2ee8740347cd9aee391307ee6b78\",\"c5af6608d7cf47e0aa57d53ec59e34b6\",\"c5b3d43f56ee40f0b1724fa88935621c\",\"c7dcb23bcf924ce9a1efac91d780b7d2\",\"0e0da70f159b4115b3bbb9731733743f\",\"18254d278201405982cbca7670c48bda\",\"211fedbb1cea47ed8edf30c266ca5282\",\"6b3310e94046485db87ed04f2f5e610e\",\"8813764db7b34dc2ad515ba5b66201e4\",\"bfd6b1d63bbb4b4598652ac09565759f\",\"2971f3d710df48e99fc4b19dfc747266\",\"68f96e445930404788977ea2acdd23d1\",\"7348a6ab4be546c8a66758ce2d23795b\",\"d983d01037f14440a0633e8bec882b55\",\"f4409af657d84910a3d2aa03008f14e8\",\"03e4758110a04f589b80110501fdd34d\",\"3befc6ab26234076947dbc4a3558a627\",\"334af23eb2404398a615aeb09ee0dfbc\",\"527e91eabbb8445db77757fc51cb7131\",\"b7fd20301ba545d8bce51be32d975869\",\"bef54ec653d64a78862b81f5dd48afdb\",\"ca50d2174b0c42c9824f773ac8c0f275\",\"d337a26d47284eb48c6a877b81f52ab1\",\"0a261fae6d264d99adb12711c67e1dc5\",\"722ae34c8c97410eb15aaa3e1bd3910c\",\"78b50f83d6bd41329c5dc425641d7ade\",\"7f377771184a42a98306ddf92a98b86c\",\"a6e0e8483735498fbaa2d26106ffaa49\",\"c45a2629a8514ff4a33ea3cb1174c7ec\",\"d4a8758c3da34e30827757cc61e7cde4\",\"dc84e16c24784f5fa935491b9d2bcacd\",\"2617ef912c564eb58f6aaf89520e3241\",\"ecd2cb371eb34e279efa683488716b88\",\"2861b2b1fc274cd79c43a3dda67cb628\",\"60abd7273f0743908097160b769a3e66\",\"e45de716281c4d859bf612fa41684a44\",\"e698271183e84ec3ae309d027468d3dc\",\"fb4de75a56574f86b7f455fb7e8de7cf\",\"17e5599a62ea439dac746b7118cd0041\",\"24d07d9dcae341e8b36f94d4e2650144\",\"4c8da359f254448e943a33cbaae383c4\",\"50103e8963e746d89ef7817b1cf31241\",\"94eafc7b0e1444a6bbf3f4ea52b99368\",\"b3f9ada00bac47e1a4897b31dea9bb43\",\"db40bbb647ff45f1aa7661777b1d0134\",\"f4d97a7bed404563bd982521d2585900\",\"157c5429d1214839902f65e05e939d29\",\"fd68e0ad5498491688a8790f21c11b98\",\"044f9b38d0dd4180a331b927aa9ffe6d\",\"0f80790e9294448fb29a8ea03c4ac7d2\",\"2ecf9b08451346469916a7495015fbaa\",\"40100f3655754e63a1c55a7a550625ba\",\"5a6e9e8b3b584064a583b4e731cdfd18\",\"b2c0de1721e844e5aad22f72555a9017\",\"eead81c82ab5420e84fe687a6cdb240a\",\"2f403f52fc444046b2c1ebc37428d69c\",\"5163e43a13c64537aaf0d50aa7572cc3\",\"65e0683e9184433daa79a66753759b79\",\"c64e29f27dd14849a1443616c9eaa553\",\"db695d59536e4569a355258bc5f94394\",\"dd48635abaaf4709b73c04dc330be6b1\",\"1733d590018a4300bdcb42d2a773e451\",\"1e9272e8175d4c3b948168f136c2b964\",\"1f6aa9c01bdc41d2b456e6186ed1856c\",\"a3d3ae69d4a04044b08afdb1c058a5da\",\"db49860eba2345f481487e7f7a8151a0\",\"f384e2659e824023b95f35d1bd84d4c9\",\"461c3e77a65342e2b1995d1f3dfc9164\",\"ca32759beb8642128be161b7d0dd433f\",\"d5ebfb1c58ae4ffd9f45a20c77b7f260\",\"d605bd09b6114764a951e0cbc09ebd98\",\"ec057d2c988b4418b2f07b311271581c\",\"f46b4c4b77ad489c81a374d72fc39c8f\",\"f598cd2134dc4358949fb6c68ed6471e\",\"0c1efedee7f747098b6efa2fbf8747a3\",\"70355a9577d746d4a33fa2342ac15a84\",\"adc5cd2824884d14bbb9bca2fac0af3c\",\"affd7aa0cc89493f9c03f944b85ac466\",\"e72a1ef3ee86439c90f4fc87e02d0043\",\"f7ea304bfd394835aec3b482a9b9404b\",\"20edaccce184448fa24f15aa2759b3d1\",\"2f565daf1bee4b459cdb94bb26a06572\",\"75e65c63cf704612a836e52baa2978a6\",\"8418b9af3d72471e9edc142c98f1baea\",\"865fa70c88cb457bbce66ae69f0d5dbf\",\"885ef99a74ea454b881aeb8220c5220a\",\"a0b26dd5395c432da2ba54b5d6a7fb3f\",\"0dfc1a45c1a04cdd9ac810ce64c4afbb\",\"407365d273034590b24c357ae63cd296\",\"46a453d5175649a0819b1add7ffb774d\",\"84d1d3e8833542f3994decbd87936eec\",\"93f7aba124814e2694e6e11df2bcc9a5\",\"a68f8a96a5164cd1a8ab55454681cc84\",\"1cf1aacdcab14c218ae9be077239407f\",\"344d930c397749beb2db9f354fa0e281\",\"421a8ae169934a1eb307984f8526c3a0\",\"9c18d11cd68047269284f9aa34427060\",\"a265636a0763423d8f81be63f25f0a29\",\"e0270568d0804cf6a8f885c88b0b7e7b\"]}', '2022-03-03 11:33:31', '1646278411144', 'Token已被顶下线：eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJsb2dpbklkIjoiNGFjZjUzMDU1NTI4NGMwM2E1NThjMGY3Njg0NDQzNjMiLCJybiI6ImlldUNYODFMM3FoWEJaY0ZXVGZ3djBSY0pkeWFpa2lGIn0.4FIW8LatmXBteA2l6V1SwjkybE5lKiURLZAooQwVI3Q');
INSERT INTO `sys_intercept_log` VALUES ('76476219-2c57-4364-8699-7edc8a0c636c', '192.168.0.124', 'http://192.168.0.124:888/ipBlacklistInfo/listByPage', 'OPTIONS', NULL, '2022-04-06 14:34:25', '1649226865960', 'ip黑名单访问');
INSERT INTO `sys_intercept_log` VALUES ('82782944-8635-4fbc-82af-6e85e42f26d4', '192.168.0.124', 'http://192.168.0.124:888/ipBlacklistInfo/listByPage', 'POST', '{\"page\":1,\"limit\":13,\"ip\":\"\"}', '2022-04-06 14:34:25', '1649226865980', 'ip黑名单访问');
INSERT INTO `sys_intercept_log` VALUES ('88bb9862-e532-4a99-954c-a42c27288696', '192.168.0.124', 'http://192.168.0.124:888/sysLog/logs', 'OPTIONS', NULL, '2022-03-01 16:14:40', '1646122480099', 'ip黑名单访问');
INSERT INTO `sys_intercept_log` VALUES ('8c08be9b-e577-4f5b-87a4-4e9bc534b91f', '192.168.0.124', 'http://192.168.0.124:888/ipBlacklistInfo/listByPage', 'OPTIONS', NULL, '2022-04-06 14:34:25', '1649226865960', 'ip黑名单访问');
INSERT INTO `sys_intercept_log` VALUES ('8e3ee668-53ea-490c-9946-0147eda21602', '192.168.0.124', 'http://192.168.0.124:888/sysUser/login', 'POST', '{\"username\":\"admin\",\"password\":\"111111\",\"type\":2}', '2022-02-16 09:09:10', '1644973750093', NULL);
INSERT INTO `sys_intercept_log` VALUES ('90412325-2d6b-4b56-b814-24be52edaf59', '192.168.0.124', 'http://192.168.0.124:888/sysInterceptLog/listByPage', 'POST', '{\"page\":1,\"limit\":13,\"ip\":\"\"}', '2022-03-01 16:14:59', '1646122499509', 'ip黑名单访问');
INSERT INTO `sys_intercept_log` VALUES ('912d2cd9-4a2c-4462-a9bc-8b40683f2f5c', '192.168.0.124', 'http://192.168.0.124:888/sysUser/login', 'POST', '{\"username\":\"admin\",\"password\":\"111111\",\"type\":2}', '2022-02-16 09:10:18', '1644973818149', NULL);
INSERT INTO `sys_intercept_log` VALUES ('93ba0dce-30fc-448a-a40a-f8b7cd387892', '0:0:0:0:0:0:0:1', 'http://localhost:888/main', 'GET', NULL, '2022-01-27 16:46:05', '1643273165601', '未提供Token');
INSERT INTO `sys_intercept_log` VALUES ('9d770e7b-af75-418a-b9e1-f2b617e27563', '192.168.0.124', 'http://192.168.0.124:888/sysUser/login', 'POST', '{\"username\":\"admin\",\"password\":\"111111\",\"type\":2}', '2022-02-16 09:11:16', '1644973876664', NULL);
INSERT INTO `sys_intercept_log` VALUES ('9fb73979-b6b8-4d97-ab88-30683cafc084', '192.168.0.124', 'http://192.168.0.124:888/job/listByPage', 'OPTIONS', NULL, '2022-07-28 15:15:35', '1658992535888', 'ip黑名单访问');
INSERT INTO `sys_intercept_log` VALUES ('a0e4e5eb-0388-4c44-b5cb-a21855e0e3e6', '192.168.0.124', 'http://192.168.0.124:888/sysRole/update', 'PUT', '{\"id\":\"11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9\",\"name\":\"超级管理员\",\"description\":\"拥有所有权限-不能删除\",\"status\":\"1\",\"permissionList\":[\"2cac5102ece741d9a48eb5524a264294\",\"2f1e10a368c3420da7efb9e28f9dcd89\",\"2f9f079433944514b7ab77ade4dc2d7b\"]}', '2022-03-03 10:29:50', '1646274590131', 'Token已被顶下线：eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJsb2dpbklkIjoiNGFjZjUzMDU1NTI4NGMwM2E1NThjMGY3Njg0NDQzNjMiLCJybiI6Imt0STR6MExHRWd6bTV1aWxEZWRNR2QzUnBvRjFBcDY5In0.um4y3Q1L-OnKcRGunlYMic-QQF_tFFxQQWTHJzdKB28');
INSERT INTO `sys_intercept_log` VALUES ('a6a4f50d-2ee7-4bd3-85a9-0972f1afd48e', '192.168.0.124', 'http://192.168.0.124:888/sysLog/logs', 'OPTIONS', NULL, '2022-03-01 16:12:11', '1646122331075', 'ip黑名单访问');
INSERT INTO `sys_intercept_log` VALUES ('b02ae799-2c3c-445c-ac18-02bcb9961b6a', '192.168.0.124', 'http://192.168.0.124:888/sysUser/logout', 'POST', NULL, '2022-03-03 09:55:53', '1646272553520', 'Token无效：eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJsb2dpbklkIjoiNGFjZjUzMDU1NTI4NGMwM2E1NThjMGY3Njg0NDQzNjMiLCJybiI6Ik8yc1Y3T1d5MVVOZWYxdnZJeGdEbXlTQ0dWQzhBNFc1In0.2Rf7b-FAKLwPv_g5ISqFzeVOmy0omBjgaZSCuldOtlk');
INSERT INTO `sys_intercept_log` VALUES ('d52e578b-ff09-4e24-aa1a-9dfd2f929b04', '0:0:0:0:0:0:0:1', 'http://localhost:888/sysPermission/listByCondition', 'POST', '{', '2022-03-03 09:55:05', '1646272505384', 'Token无效：eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJsb2dpbklkIjoiNGFjZjUzMDU1NTI4NGMwM2E1NThjMGY3Njg0NDQzNjMiLCJybiI6Ik8yc1Y3T1d5MVVOZWYxdnZJeGdEbXlTQ0dWQzhBNFc1In0.2Rf7b-FAKLwPv_g5ISqFzeVOmy0omBjgaZSCuldOtlk');
INSERT INTO `sys_intercept_log` VALUES ('d570bf71-1023-4840-9a4e-c5f1de5a9e07', '192.168.0.124', 'http://192.168.0.124:888/sysUser/login', 'OPTIONS', NULL, '2022-03-02 11:56:33', '1646193393084', 'ip黑名单访问');
INSERT INTO `sys_intercept_log` VALUES ('da9f08ca-c862-4f40-b04d-802aec77dd88', '192.168.0.124', 'http://192.168.0.124:888/sysUser/logout', 'POST', NULL, '2022-03-02 12:02:09', '1646193729032', 'Token无效：eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJsb2dpbklkIjoiNGFjZjUzMDU1NTI4NGMwM2E1NThjMGY3Njg0NDQzNjMiLCJybiI6Im9BaUpOOFVUZWxwSnBZNVlwd0NKcnZxQ1FLRUc4RnZKIn0.M-_1-eu0SaMQODuQeiqxpsafqeKKnCMugt00q7JVM4s');
INSERT INTO `sys_intercept_log` VALUES ('e00fb4ae-50d6-4413-af54-8ff34a5835f2', '192.168.0.124', 'http://192.168.0.124:888/sysUser/login', 'POST', '{\"username\":\"admin\",\"password\":\"111111\",\"type\":2}', '2022-03-02 11:57:54', '1646193474841', 'ip黑名单访问');
INSERT INTO `sys_intercept_log` VALUES ('e75d005d-3a8a-4285-bf34-09c34517c3b8', '192.168.0.124', 'http://192.168.0.124:888/sysLog/logs', 'POST', '{\"page\":1,\"limit\":13,\"operation\":\"\"}', '2022-03-01 16:14:40', '1646122480110', 'ip黑名单访问');
INSERT INTO `sys_intercept_log` VALUES ('f316226b-8668-4dda-b062-93f9df809efa', '192.168.0.124', 'http://192.168.0.124:888/sysInterceptLog/listByPage', 'OPTIONS', NULL, '2022-04-06 14:34:29', '1649226869171', 'ip黑名单访问');
INSERT INTO `sys_intercept_log` VALUES ('f5caec89-c211-48f2-85b9-f0e75fb95848', '192.168.0.124', 'http://192.168.0.124:888/sysUser/login', 'POST', '{\"username\":\"admin\",\"password\":\"111111\",\"type\":2}', '2022-02-16 09:12:07', '1644973927368', NULL);
INSERT INTO `sys_intercept_log` VALUES ('f7f930d7-811e-41ac-9e88-f641f86b9ec1', '192.168.0.124', 'http://192.168.0.124:888/sysLog/logs', 'POST', '{\"page\":1,\"limit\":13,\"operation\":\"\"}', '2022-03-01 16:12:11', '1646122331084', 'ip黑名单访问');
INSERT INTO `sys_intercept_log` VALUES ('f990a3fd-64e2-4b9a-b51b-16e603bc4e2d', '192.168.0.124', 'http://192.168.0.124:888/sysUser/login', 'POST', '{\"username\":\"admin\",\"password\":\"111111\",\"type\":2}', '2022-02-16 09:08:54', '1644973734567', NULL);
INSERT INTO `sys_intercept_log` VALUES ('fb4ed573-d670-458b-8e69-f94d6fdf0a9a', '192.168.0.124', 'http://192.168.0.124:888/sysLog/logs', 'OPTIONS', NULL, '2022-03-01 16:11:58', '1646122318050', 'ip黑名单访问');
INSERT INTO `sys_intercept_log` VALUES ('fd7f4cb2-115d-428a-b71f-e47d049406ec', '0:0:0:0:0:0:0:1', 'http://localhost:888/login', 'GET', NULL, '2022-03-03 09:43:24', '1646271804769', 'ip黑名单访问');
INSERT INTO `sys_intercept_log` VALUES ('ff54ca8e-9322-4a47-9ff0-a9a12ea7fe57', '192.168.0.124', 'http://192.168.0.124:888/sysGenerator/listByPage', 'POST', '{\"page\":1,\"limit\":13,\"search\":\"\"}', '2022-03-01 16:45:43', '1646124343326', 'Token已被顶下线：eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJsb2dpbklkIjoiNGFjZjUzMDU1NTI4NGMwM2E1NThjMGY3Njg0NDQzNjMiLCJybiI6IlJTQUNwVmpJSWh0Y05sTWpMT3FDZTdGclE1S3BmMHFlIn0.QSLrZb-BH_iqYzkKfs9wqMBU0lAG4rVlNYh5jq3aZzk');

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户id',
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `operation` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户操作',
  `time` int(0) NULL DEFAULT NULL COMMENT '响应时间',
  `method` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求方法',
  `params` varchar(5000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求参数',
  `ip` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'IP地址',
  `create_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建时间',
  `type` int(0) NULL DEFAULT NULL COMMENT '类型0普通型1操作日志',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES ('014ec85d-7a20-4671-a97e-232aaf4b8ed3', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '0:0:0:0:0:0:0:1', '2022-04-18 09:34:11', 1);
INSERT INTO `sys_log` VALUES ('029ca2c9-244a-45bc-821a-f093338de820', '4acf530555284c03a558c0f768444363', 'admin', '系统权限-新增系统权限', 0, 'com.example.frame.controller.SysPermissionController.add()', '[{\"createTime\":\"2022-03-03 14:31:36\",\"id\":\"096ca24cadb94aa6a03fe9e9cd8f6f14\",\"limit\":10,\"name\":\"配置-1\",\"orderNum\":\"0\",\"page\":1,\"pid\":\"cbd0f7faa72e49efbfdc094e078b11bf\",\"status\":\"0\",\"type\":\"2\",\"urlWeb\":\"/pz1\"}]', '192.168.0.124', '2022-03-03 14:31:36', 0);
INSERT INTO `sys_log` VALUES ('02d28783-083a-4ae7-80f3-566a56c46815', '4acf530555284c03a558c0f768444363', 'admin', '系统权限-新增系统权限', 0, 'com.example.frame.controller.SysPermissionController.add()', '[{\"createTime\":\"2022-03-03 14:29:54\",\"id\":\"bf00431a93c5406b8e1760479127a51e\",\"limit\":10,\"name\":\"3\",\"orderNum\":\"3\",\"page\":1,\"pid\":\"0\",\"status\":\"0\",\"type\":\"1\",\"urlWeb\":\"3\"}]', '192.168.0.124', '2022-03-03 14:29:54', 0);
INSERT INTO `sys_log` VALUES ('0459bb4b-6d4b-4e04-8547-f33f04758ec8', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.124', '2022-03-01 16:30:56', 1);
INSERT INTO `sys_log` VALUES ('04fc47b8-838b-40ee-a176-94f8f6290503', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.124', '2022-03-03 15:31:51', 1);
INSERT INTO `sys_log` VALUES ('056b5ed2-4c2b-4760-9332-5c7d2584a818', '4acf530555284c03a558c0f768444363', 'admin', '系统权限-更新系统权限', 0, 'com.example.frame.controller.SysPermissionController.update()', '[{\"id\":\"270a28c3d58343348353455d32fc2c55\",\"limit\":10,\"name\":\"第一个\",\"orderNum\":\"5\",\"page\":1,\"pid\":\"0\",\"status\":\"0\",\"type\":\"2\",\"updateTime\":\"2022-03-03 14:21:50\",\"urlWeb\":\"/5\"}]', '192.168.0.124', '2022-03-03 14:21:50', 0);
INSERT INTO `sys_log` VALUES ('06c4e44d-29de-4cab-bc85-289ff530e0cd', '4acf530555284c03a558c0f768444363', 'admin', '查询所有表格-查询所有表格', 0, 'com.example.frame.controller.SqlInjectionController.selectAllTable()', NULL, '192.168.0.124', '2022-03-01 16:37:06', 0);
INSERT INTO `sys_log` VALUES ('075b7841-0b42-46b0-9c4d-a7809f38f505', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.109', '2022-01-05 10:12:44', 1);
INSERT INTO `sys_log` VALUES ('0855a554-0e67-4920-91dd-0b8ff0270656', '4acf530555284c03a558c0f768444363', 'admin', '系统角色-更新系统角色', 0, 'com.example.frame.controller.SysRoleController.update()', '[{\"description\":\"拥有所有权限-不能删除\",\"id\":\"11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9\",\"limit\":10,\"name\":\"超级管理员\",\"page\":1,\"permissionList\":[\"2f9f079433944514b7ab77ade4dc2d7b\",\"088c12320dba460f95ddf52d94bd939b\",\"1026b0e03be14c1ca036ec106d0ec660\",\"4d1555b2e7bf406a91c5713bba13c054\",\"afff2ee8740347cd9aee391307ee6b78\",\"c5af6608d7cf47e0aa57d53ec59e34b6\",\"c5b3d43f56ee40f0b1724fa88935621c\",\"c7dcb23bcf924ce9a1efac91d780b7d2\",\"0e0da70f159b4115b3bbb9731733743f\",\"18254d278201405982cbca7670c48bda\",\"211fedbb1cea47ed8edf30c266ca5282\",\"6b3310e94046485db87ed04f2f5e610e\",\"8813764db7b34dc2ad515ba5b66201e4\",\"bfd6b1d63bbb4b4598652ac09565759f\",\"2971f3d710df48e99fc4b19dfc747266\",\"68f96e445930404788977ea2acdd23d1\",\"7348a6ab4be546c8a66758ce2d23795b\",\"d983d01037f14440a0633e8bec882b55\",\"f4409af657d84910a3d2aa03008f14e8\",\"03e4758110a04f589b80110501fdd34d\",\"3befc6ab26234076947dbc4a3558a627\",\"334af23eb2404398a615aeb09ee0dfbc\",\"527e91eabbb8445db77757fc51cb7131\",\"b7fd20301ba545d8bce51be32d975869\",\"bef54ec653d64a78862b81f5dd48afdb\",\"ca50d2174b0c42c9824f773ac8c0f275\",\"d337a26d47284eb48c6a877b81f52ab1\",\"0a261fae6d264d99adb12711c67e1dc5\",\"722ae34c8c97410eb15aaa3e1bd3910c\",\"78b50f83d6bd41329c5dc425641d7ade\",\"7f377771184a42a98306ddf92a98b86c\",\"a6e0e8483735498fbaa2d26106ffaa49\",\"c45a2629a8514ff4a33ea3cb1174c7ec\",\"d4a8758c3da34e30827757cc61e7cde4\",\"dc84e16c24784f5fa935491b9d2bcacd\",\"2617ef912c564eb58f6aaf89520e3241\",\"ecd2cb371eb34e279efa683488716b88\",\"2861b2b1fc274cd79c43a3dda67cb628\",\"60abd7273f0743908097160b769a3e66\",\"e45de716281c4d859bf612fa41684a44\",\"e698271183e84ec3ae309d027468d3dc\",\"fb4de75a56574f86b7f455fb7e8de7cf\",\"17e5599a62ea439dac746b7118cd0041\",\"24d07d9dcae341e8b36f94d4e2650144\",\"4c8da359f254448e943a33cbaae383c4\",\"50103e8963e746d89ef7817b1cf31241\",\"94eafc7b0e1444a6bbf3f4ea52b99368\",\"b3f9ada00bac47e1a4897b31dea9bb43\",\"db40bbb647ff45f1aa7661777b1d0134\",\"f4d97a7bed404563bd982521d2585900\",\"157c5429d1214839902f65e05e939d29\",\"fd68e0ad5498491688a8790f21c11b98\",\"044f9b38d0dd4180a331b927aa9ffe6d\",\"0f80790e9294448fb29a8ea03c4ac7d2\",\"2ecf9b08451346469916a7495015fbaa\",\"40100f3655754e63a1c55a7a550625ba\",\"5a6e9e8b3b584064a583b4e731cdfd18\",\"b2c0de1721e844e5aad22f72555a9017\",\"eead81c82ab5420e84fe687a6cdb240a\",\"2f403f52fc444046b2c1ebc37428d69c\",\"5163e43a13c64537aaf0d50aa7572cc3\",\"65e0683e9184433daa79a66753759b79\",\"c64e29f27dd14849a1443616c9eaa553\",\"db695d59536e4569a355258bc5f94394\",\"dd48635abaaf4709b73c04dc330be6b1\",\"1733d590018a4300bdcb42d2a773e451\",\"1e9272e8175d4c3b948168f136c2b964\",\"1f6aa9c01bdc41d2b456e6186ed1856c\",\"a3d3ae69d4a04044b08afdb1c058a5da\",\"db49860eba2345f481487e7f7a8151a0\",\"f384e2659e824023b95f35d1bd84d4c9\",\"461c3e77a65342e2b1995d1f3dfc9164\",\"ca32759beb8642128be161b7d0dd433f\",\"d605bd09b6114764a951e0cbc09ebd98\",\"ec057d2c988b4418b2f07b311271581c\",\"f46b4c4b77ad489c81a374d72fc39c8f\",\"f598cd2134dc4358949fb6c68ed6471e\",\"0c1efedee7f747098b6efa2fbf8747a3\",\"70355a9577d746d4a33fa2342ac15a84\",\"adc5cd2824884d14bbb9bca2fac0af3c\",\"affd7aa0cc89493f9c03f944b85ac466\",\"e72a1ef3ee86439c90f4fc87e02d0043\",\"f7ea304bfd394835aec3b482a9b9404b\",\"20edaccce184448fa24f15aa2759b3d1\",\"2f565daf1bee4b459cdb94bb26a06572\",\"75e65c63cf704612a836e52baa2978a6\",\"8418b9af3d72471e9edc142c98f1baea\",\"865fa70c88cb457bbce66ae69f0d5dbf\",\"885ef99a74ea454b881aeb8220c5220a\",\"a0b26dd5395c432da2ba54b5d6a7fb3f\",\"0dfc1a45c1a04cdd9ac810ce64c4afbb\",\"407365d273034590b24c357ae63cd296\",\"46a453d5175649a0819b1add7ffb774d\",\"84d1d3e8833542f3994decbd87936eec\",\"93f7aba124814e2694e6e11df2bcc9a5\",\"a68f8a96a5164cd1a8ab55454681cc84\",\"1cf1aacdcab14c218ae9be077239407f\",\"344d930c397749beb2db9f354fa0e281\",\"421a8ae169934a1eb307984f8526c3a0\",\"9c18d11cd68047269284f9aa34427060\",\"a265636a0763423d8f81be63f25f0a29\",\"e0270568d0804cf6a8f885c88b0b7e7b\"],\"status\":\"1\",\"updateTime\":\"2022-03-03 09:58:27\"}]', '192.168.0.124', '2022-03-03 09:58:27', 0);
INSERT INTO `sys_log` VALUES ('0c528d18-f3ad-4995-918d-0d8b8e31cc35', '4acf530555284c03a558c0f768444363', 'admin', '系统权限-删除系统权限', 0, 'com.example.frame.controller.SysPermissionController.delete()', '[\"2f9f079433944514b7ab77ade4dc2d7b\"]', '192.168.0.124', '2022-03-03 14:25:51', 0);
INSERT INTO `sys_log` VALUES ('0e736de3-ad74-4c68-825b-f7708048a6df', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.124', '2022-03-03 11:31:25', 1);
INSERT INTO `sys_log` VALUES ('0f83efd7-09b6-4b3d-b12a-89bae98c6149', '4acf530555284c03a558c0f768444363', 'admin', '系统角色-更新系统角色', 0, 'com.example.frame.controller.SysRoleController.update()', '[{\"description\":\"拥有所有权限-不能删除\",\"id\":\"11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9\",\"limit\":10,\"name\":\"超级管理员\",\"page\":1,\"permissionList\":[\"2cac5102ece741d9a48eb5524a264294\",\"2f1e10a368c3420da7efb9e28f9dcd89\",\"2f9f079433944514b7ab77ade4dc2d7b\",\"088c12320dba460f95ddf52d94bd939b\",\"1026b0e03be14c1ca036ec106d0ec660\",\"4d1555b2e7bf406a91c5713bba13c054\",\"afff2ee8740347cd9aee391307ee6b78\",\"c5af6608d7cf47e0aa57d53ec59e34b6\",\"c5b3d43f56ee40f0b1724fa88935621c\",\"c7dcb23bcf924ce9a1efac91d780b7d2\",\"0e0da70f159b4115b3bbb9731733743f\",\"18254d278201405982cbca7670c48bda\",\"211fedbb1cea47ed8edf30c266ca5282\",\"6b3310e94046485db87ed04f2f5e610e\",\"8813764db7b34dc2ad515ba5b66201e4\",\"bfd6b1d63bbb4b4598652ac09565759f\",\"2971f3d710df48e99fc4b19dfc747266\",\"68f96e445930404788977ea2acdd23d1\",\"7348a6ab4be546c8a66758ce2d23795b\",\"d983d01037f14440a0633e8bec882b55\",\"f4409af657d84910a3d2aa03008f14e8\",\"03e4758110a04f589b80110501fdd34d\",\"3befc6ab26234076947dbc4a3558a627\",\"334af23eb2404398a615aeb09ee0dfbc\",\"527e91eabbb8445db77757fc51cb7131\",\"b7fd20301ba545d8bce51be32d975869\",\"bef54ec653d64a78862b81f5dd48afdb\",\"ca50d2174b0c42c9824f773ac8c0f275\",\"d337a26d47284eb48c6a877b81f52ab1\",\"0a261fae6d264d99adb12711c67e1dc5\",\"722ae34c8c97410eb15aaa3e1bd3910c\",\"78b50f83d6bd41329c5dc425641d7ade\",\"7f377771184a42a98306ddf92a98b86c\",\"a6e0e8483735498fbaa2d26106ffaa49\",\"c45a2629a8514ff4a33ea3cb1174c7ec\",\"d4a8758c3da34e30827757cc61e7cde4\",\"dc84e16c24784f5fa935491b9d2bcacd\",\"2617ef912c564eb58f6aaf89520e3241\",\"ecd2cb371eb34e279efa683488716b88\",\"2861b2b1fc274cd79c43a3dda67cb628\",\"60abd7273f0743908097160b769a3e66\",\"e45de716281c4d859bf612fa41684a44\",\"e698271183e84ec3ae309d027468d3dc\",\"fb4de75a56574f86b7f455fb7e8de7cf\",\"17e5599a62ea439dac746b7118cd0041\",\"24d07d9dcae341e8b36f94d4e2650144\",\"4c8da359f254448e943a33cbaae383c4\",\"50103e8963e746d89ef7817b1cf31241\",\"94eafc7b0e1444a6bbf3f4ea52b99368\",\"b3f9ada00bac47e1a4897b31dea9bb43\",\"db40bbb647ff45f1aa7661777b1d0134\",\"f4d97a7bed404563bd982521d2585900\",\"157c5429d1214839902f65e05e939d29\",\"fd68e0ad5498491688a8790f21c11b98\",\"044f9b38d0dd4180a331b927aa9ffe6d\",\"0f80790e9294448fb29a8ea03c4ac7d2\",\"2ecf9b08451346469916a7495015fbaa\",\"40100f3655754e63a1c55a7a550625ba\",\"5a6e9e8b3b584064a583b4e731cdfd18\",\"b2c0de1721e844e5aad22f72555a9017\",\"eead81c82ab5420e84fe687a6cdb240a\",\"2f403f52fc444046b2c1ebc37428d69c\",\"5163e43a13c64537aaf0d50aa7572cc3\",\"65e0683e9184433daa79a66753759b79\",\"c64e29f27dd14849a1443616c9eaa553\",\"db695d59536e4569a355258bc5f94394\",\"dd48635abaaf4709b73c04dc330be6b1\",\"1733d590018a4300bdcb42d2a773e451\",\"1e9272e8175d4c3b948168f136c2b964\",\"1f6aa9c01bdc41d2b456e6186ed1856c\",\"a3d3ae69d4a04044b08afdb1c058a5da\",\"db49860eba2345f481487e7f7a8151a0\",\"f384e2659e824023b95f35d1bd84d4c9\",\"461c3e77a65342e2b1995d1f3dfc9164\",\"ca32759beb8642128be161b7d0dd433f\",\"d5ebfb1c58ae4ffd9f45a20c77b7f260\",\"d605bd09b6114764a951e0cbc09ebd98\",\"ec057d2c988b4418b2f07b311271581c\",\"f46b4c4b77ad489c81a374d72fc39c8f\",\"f598cd2134dc4358949fb6c68ed6471e\",\"0c1efedee7f747098b6efa2fbf8747a3\",\"70355a9577d746d4a33fa2342ac15a84\",\"adc5cd2824884d14bbb9bca2fac0af3c\",\"affd7aa0cc89493f9c03f944b85ac466\",\"e72a1ef3ee86439c90f4fc87e02d0043\",\"f7ea304bfd394835aec3b482a9b9404b\",\"20edaccce184448fa24f15aa2759b3d1\",\"2f565daf1bee4b459cdb94bb26a06572\",\"75e65c63cf704612a836e52baa2978a6\",\"8418b9af3d72471e9edc142c98f1baea\",\"865fa70c88cb457bbce66ae69f0d5dbf\",\"885ef99a74ea454b881aeb8220c5220a\",\"a0b26dd5395c432da2ba54b5d6a7fb3f\",\"0dfc1a45c1a04cdd9ac810ce64c4afbb\",\"407365d273034590b24c357ae63cd296\",\"46a453d5175649a0819b1add7ffb774d\",\"84d1d3e8833542f3994decbd87936eec\",\"93f7aba124814e2694e6e11df2bcc9a5\",\"a68f8a96a5164cd1a8ab55454681cc84\",\"1cf1aacdcab14c218ae9be077239407f\",\"344d930c397749beb2db9f354fa0e281\",\"421a8ae169934a1eb307984f8526c3a0\",\"9c18d11cd68047269284f9aa34427060\",\"a265636a0763423d8f81be63f25f0a29\",\"e0270568d0804cf6a8f885c88b0b7e7b\"],\"status\":\"1\",\"updateTime\":\"2022-03-03 11:23:21\"}]', '192.168.0.124', '2022-03-03 11:23:21', 0);
INSERT INTO `sys_log` VALUES ('10b4fcf7-18e1-469b-a7f5-550db9537306', '4acf530555284c03a558c0f768444363', 'admin', '系统访问地区白名单-删除系统访问地区白名单', 0, 'com.example.frame.controller.WhiteRegionInfoController.delete()', '[[\"f95dee0ccb0548b2a4486e13c6122d3d\"]]', '192.168.0.124', '2022-03-01 17:30:17', 0);
INSERT INTO `sys_log` VALUES ('11509faa-50f9-40c0-8e97-cf0ff056fd49', '4acf530555284c03a558c0f768444363', 'admin', '系统权限-删除系统权限', 0, 'com.example.frame.controller.SysPermissionController.delete()', '[\"11e189a1d23b4fdf9fe57ffa9c46c146\"]', '192.168.0.124', '2022-03-03 14:25:52', 0);
INSERT INTO `sys_log` VALUES ('11d7175e-57f9-4da6-bac8-860e1065eae1', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.124', '2022-03-03 15:03:26', 1);
INSERT INTO `sys_log` VALUES ('1211f368-e955-4801-a7f4-ed5888fbe5e5', '4acf530555284c03a558c0f768444363', 'admin', '附件信息表-更新附件信息表', 0, 'com.example.frame.controller.PublicAttachementController.update()', '[{\"fjdl\":\"导入导出模板\",\"tempPath\":\"temp/764f8d30ec9a3d385c5e465dd7637d68.xls\",\"ysmc\":\"追加结果打包导入导出模板.xls\",\"id\":\"be01a5ca0e5a44f38ec91aabef924875\",\"fjlx\":\"生命体征导入导出模板\"}]', '192.168.0.124', '2022-02-15 09:43:47', 0);
INSERT INTO `sys_log` VALUES ('1236af10-91e7-4110-b187-287dbd54c5ad', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.124', '2022-02-15 16:50:56', 1);
INSERT INTO `sys_log` VALUES ('18092b05-11c7-4759-9662-1935d2e06e3a', '4acf530555284c03a558c0f768444363', 'admin', '系统角色-更新系统角色', 0, 'com.example.frame.controller.SysRoleController.update()', '[{\"description\":\"拥有所有权限-不能删除\",\"id\":\"11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9\",\"limit\":10,\"name\":\"超级管理员\",\"page\":1,\"permissionList\":[\"cdf034a7b6254c579804a172925ea261\",\"6c91aaf67d0341b2859b38c0eed28d00\",\"cbd0f7faa72e49efbfdc094e078b11bf\",\"096ca24cadb94aa6a03fe9e9cd8f6f14\",\"4e6f9c62dd2a415881cff9108de07e0b\",\"088c12320dba460f95ddf52d94bd939b\",\"1026b0e03be14c1ca036ec106d0ec660\",\"4d1555b2e7bf406a91c5713bba13c054\",\"afff2ee8740347cd9aee391307ee6b78\",\"c5af6608d7cf47e0aa57d53ec59e34b6\",\"c5b3d43f56ee40f0b1724fa88935621c\",\"c7dcb23bcf924ce9a1efac91d780b7d2\",\"0e0da70f159b4115b3bbb9731733743f\",\"18254d278201405982cbca7670c48bda\",\"211fedbb1cea47ed8edf30c266ca5282\",\"6b3310e94046485db87ed04f2f5e610e\",\"8813764db7b34dc2ad515ba5b66201e4\",\"bfd6b1d63bbb4b4598652ac09565759f\",\"2971f3d710df48e99fc4b19dfc747266\",\"68f96e445930404788977ea2acdd23d1\",\"7348a6ab4be546c8a66758ce2d23795b\",\"d983d01037f14440a0633e8bec882b55\",\"f4409af657d84910a3d2aa03008f14e8\",\"03e4758110a04f589b80110501fdd34d\",\"3befc6ab26234076947dbc4a3558a627\",\"334af23eb2404398a615aeb09ee0dfbc\",\"527e91eabbb8445db77757fc51cb7131\",\"b7fd20301ba545d8bce51be32d975869\",\"bef54ec653d64a78862b81f5dd48afdb\",\"ca50d2174b0c42c9824f773ac8c0f275\",\"d337a26d47284eb48c6a877b81f52ab1\",\"0a261fae6d264d99adb12711c67e1dc5\",\"722ae34c8c97410eb15aaa3e1bd3910c\",\"78b50f83d6bd41329c5dc425641d7ade\",\"7f377771184a42a98306ddf92a98b86c\",\"a6e0e8483735498fbaa2d26106ffaa49\",\"c45a2629a8514ff4a33ea3cb1174c7ec\",\"d4a8758c3da34e30827757cc61e7cde4\",\"dc84e16c24784f5fa935491b9d2bcacd\",\"2617ef912c564eb58f6aaf89520e3241\",\"ecd2cb371eb34e279efa683488716b88\",\"2861b2b1fc274cd79c43a3dda67cb628\",\"60abd7273f0743908097160b769a3e66\",\"e45de716281c4d859bf612fa41684a44\",\"e698271183e84ec3ae309d027468d3dc\",\"fb4de75a56574f86b7f455fb7e8de7cf\",\"17e5599a62ea439dac746b7118cd0041\",\"24d07d9dcae341e8b36f94d4e2650144\",\"4c8da359f254448e943a33cbaae383c4\",\"50103e8963e746d89ef7817b1cf31241\",\"94eafc7b0e1444a6bbf3f4ea52b99368\",\"b3f9ada00bac47e1a4897b31dea9bb43\",\"db40bbb647ff45f1aa7661777b1d0134\",\"f4d97a7bed404563bd982521d2585900\",\"157c5429d1214839902f65e05e939d29\",\"fd68e0ad5498491688a8790f21c11b98\",\"044f9b38d0dd4180a331b927aa9ffe6d\",\"0f80790e9294448fb29a8ea03c4ac7d2\",\"2ecf9b08451346469916a7495015fbaa\",\"40100f3655754e63a1c55a7a550625ba\",\"5a6e9e8b3b584064a583b4e731cdfd18\",\"b2c0de1721e844e5aad22f72555a9017\",\"eead81c82ab5420e84fe687a6cdb240a\",\"2f403f52fc444046b2c1ebc37428d69c\",\"5163e43a13c64537aaf0d50aa7572cc3\",\"65e0683e9184433daa79a66753759b79\",\"c64e29f27dd14849a1443616c9eaa553\",\"db695d59536e4569a355258bc5f94394\",\"dd48635abaaf4709b73c04dc330be6b1\",\"1733d590018a4300bdcb42d2a773e451\",\"1e9272e8175d4c3b948168f136c2b964\",\"1f6aa9c01bdc41d2b456e6186ed1856c\",\"a3d3ae69d4a04044b08afdb1c058a5da\",\"db49860eba2345f481487e7f7a8151a0\",\"f384e2659e824023b95f35d1bd84d4c9\",\"461c3e77a65342e2b1995d1f3dfc9164\",\"ca32759beb8642128be161b7d0dd433f\",\"d5ebfb1c58ae4ffd9f45a20c77b7f260\",\"d605bd09b6114764a951e0cbc09ebd98\",\"ec057d2c988b4418b2f07b311271581c\",\"f46b4c4b77ad489c81a374d72fc39c8f\",\"f598cd2134dc4358949fb6c68ed6471e\",\"0c1efedee7f747098b6efa2fbf8747a3\",\"70355a9577d746d4a33fa2342ac15a84\",\"adc5cd2824884d14bbb9bca2fac0af3c\",\"affd7aa0cc89493f9c03f944b85ac466\",\"e72a1ef3ee86439c90f4fc87e02d0043\",\"f7ea304bfd394835aec3b482a9b9404b\",\"20edaccce184448fa24f15aa2759b3d1\",\"2f565daf1bee4b459cdb94bb26a06572\",\"75e65c63cf704612a836e52baa2978a6\",\"8418b9af3d72471e9edc142c98f1baea\",\"865fa70c88cb457bbce66ae69f0d5dbf\",\"885ef99a74ea454b881aeb8220c5220a\",\"a0b26dd5395c432da2ba54b5d6a7fb3f\",\"0dfc1a45c1a04cdd9ac810ce64c4afbb\",\"407365d273034590b24c357ae63cd296\",\"46a453d5175649a0819b1add7ffb774d\",\"84d1d3e8833542f3994decbd87936eec\",\"93f7aba124814e2694e6e11df2bcc9a5\",\"a68f8a96a5164cd1a8ab55454681cc84\",\"1cf1aacdcab14c218ae9be077239407f\",\"344d930c397749beb2db9f354fa0e281\",\"421a8ae169934a1eb307984f8526c3a0\",\"9c18d11cd68047269284f9aa34427060\",\"a265636a0763423d8f81be63f25f0a29\",\"e0270568d0804cf6a8f885c88b0b7e7b\"],\"status\":\"1\",\"updateTime\":\"2022-03-03 15:33:22\"}]', '192.168.0.124', '2022-03-03 15:33:22', 0);
INSERT INTO `sys_log` VALUES ('1825edee-7b88-43de-be61-e473848240e0', '4acf530555284c03a558c0f768444363', 'admin', '附件信息表-更新附件信息表', 0, 'com.example.frame.controller.PublicAttachementController.update()', '[{\"fjdl\":\"导入导出模板\",\"tempPath\":\"temp/e2792533e430a9ed1664b8c99395c8a5.txt\",\"ysmc\":\"20220114182851-78a7d92a2aa54a339f540c257736aaed.txt\",\"id\":\"9ee4e20301a341a8952cc747e622447e\",\"fjlx\":\"生命体征导入导出模板\"}]', '192.168.0.124', '2022-02-15 09:44:08', 0);
INSERT INTO `sys_log` VALUES ('18c2d361-f2b7-4c22-abde-0e40f55496d2', '4acf530555284c03a558c0f768444363', 'admin', '附件上传-附件上传', 0, 'com.example.frame.controller.FileController.uploadFile()', NULL, '192.168.0.124', '2022-02-15 09:44:07', 0);
INSERT INTO `sys_log` VALUES ('1aa98a5f-02fd-4872-a6db-5b2315461eef', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.124', '2022-04-11 10:28:27', 1);
INSERT INTO `sys_log` VALUES ('1b615f87-8fb2-4f50-9886-0711c27f87d6', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.124', '2022-03-01 16:36:54', 1);
INSERT INTO `sys_log` VALUES ('1bcc81b7-5d69-46a1-af37-15cdd0b74e49', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.124', '2022-02-15 17:45:21', 1);
INSERT INTO `sys_log` VALUES ('1c8d6dcf-0e54-4d6f-a225-b4c8b7b55d84', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.124', '2022-03-01 16:45:45', 1);
INSERT INTO `sys_log` VALUES ('1ce5a28a-f08c-46fd-96be-4d24f70dfaa7', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.124', '2022-04-06 14:33:57', 1);
INSERT INTO `sys_log` VALUES ('2044918d-45d9-4773-8fed-60124e02ac5b', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.124', '2022-03-03 09:48:10', 1);
INSERT INTO `sys_log` VALUES ('212b9e4b-020e-4148-b180-00bc559913df', '4acf530555284c03a558c0f768444363', 'admin', '系统权限-更新系统权限', 0, 'com.example.frame.controller.SysPermissionController.update()', '[{\"id\":\"270a28c3d58343348353455d32fc2c55\",\"limit\":10,\"name\":\"配置配置\",\"orderNum\":\"2\",\"page\":1,\"pid\":\"0\",\"status\":\"0\",\"type\":\"2\",\"updateTime\":\"2022-03-03 14:21:20\",\"urlWeb\":\"/1111\"}]', '192.168.0.124', '2022-03-03 14:21:22', 0);
INSERT INTO `sys_log` VALUES ('221979f7-ab4f-4377-91cf-95c837cadc5e', '4acf530555284c03a558c0f768444363', 'admin', '系统角色-更新系统角色', 0, 'com.example.frame.controller.SysRoleController.update()', '[{\"description\":\"拥有所有权限-不能删除\",\"id\":\"11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9\",\"limit\":10,\"name\":\"超级管理员\",\"page\":1,\"permissionList\":[\"088c12320dba460f95ddf52d94bd939b\",\"1026b0e03be14c1ca036ec106d0ec660\",\"4d1555b2e7bf406a91c5713bba13c054\",\"afff2ee8740347cd9aee391307ee6b78\",\"c5af6608d7cf47e0aa57d53ec59e34b6\",\"c5b3d43f56ee40f0b1724fa88935621c\",\"c7dcb23bcf924ce9a1efac91d780b7d2\",\"0e0da70f159b4115b3bbb9731733743f\",\"18254d278201405982cbca7670c48bda\",\"211fedbb1cea47ed8edf30c266ca5282\",\"6b3310e94046485db87ed04f2f5e610e\",\"8813764db7b34dc2ad515ba5b66201e4\",\"bfd6b1d63bbb4b4598652ac09565759f\",\"2971f3d710df48e99fc4b19dfc747266\",\"68f96e445930404788977ea2acdd23d1\",\"7348a6ab4be546c8a66758ce2d23795b\",\"d983d01037f14440a0633e8bec882b55\",\"f4409af657d84910a3d2aa03008f14e8\",\"03e4758110a04f589b80110501fdd34d\",\"3befc6ab26234076947dbc4a3558a627\",\"334af23eb2404398a615aeb09ee0dfbc\",\"527e91eabbb8445db77757fc51cb7131\",\"b7fd20301ba545d8bce51be32d975869\",\"bef54ec653d64a78862b81f5dd48afdb\",\"ca50d2174b0c42c9824f773ac8c0f275\",\"d337a26d47284eb48c6a877b81f52ab1\",\"0a261fae6d264d99adb12711c67e1dc5\",\"722ae34c8c97410eb15aaa3e1bd3910c\",\"78b50f83d6bd41329c5dc425641d7ade\",\"7f377771184a42a98306ddf92a98b86c\",\"a6e0e8483735498fbaa2d26106ffaa49\",\"c45a2629a8514ff4a33ea3cb1174c7ec\",\"d4a8758c3da34e30827757cc61e7cde4\",\"dc84e16c24784f5fa935491b9d2bcacd\",\"2617ef912c564eb58f6aaf89520e3241\",\"ecd2cb371eb34e279efa683488716b88\",\"2861b2b1fc274cd79c43a3dda67cb628\",\"60abd7273f0743908097160b769a3e66\",\"e45de716281c4d859bf612fa41684a44\",\"e698271183e84ec3ae309d027468d3dc\",\"fb4de75a56574f86b7f455fb7e8de7cf\",\"17e5599a62ea439dac746b7118cd0041\",\"24d07d9dcae341e8b36f94d4e2650144\",\"4c8da359f254448e943a33cbaae383c4\",\"50103e8963e746d89ef7817b1cf31241\",\"94eafc7b0e1444a6bbf3f4ea52b99368\",\"b3f9ada00bac47e1a4897b31dea9bb43\",\"db40bbb647ff45f1aa7661777b1d0134\",\"f4d97a7bed404563bd982521d2585900\",\"157c5429d1214839902f65e05e939d29\",\"fd68e0ad5498491688a8790f21c11b98\",\"044f9b38d0dd4180a331b927aa9ffe6d\",\"0f80790e9294448fb29a8ea03c4ac7d2\",\"2ecf9b08451346469916a7495015fbaa\",\"40100f3655754e63a1c55a7a550625ba\",\"5a6e9e8b3b584064a583b4e731cdfd18\",\"b2c0de1721e844e5aad22f72555a9017\",\"eead81c82ab5420e84fe687a6cdb240a\",\"2f403f52fc444046b2c1ebc37428d69c\",\"5163e43a13c64537aaf0d50aa7572cc3\",\"65e0683e9184433daa79a66753759b79\",\"c64e29f27dd14849a1443616c9eaa553\",\"db695d59536e4569a355258bc5f94394\",\"dd48635abaaf4709b73c04dc330be6b1\",\"1733d590018a4300bdcb42d2a773e451\",\"1e9272e8175d4c3b948168f136c2b964\",\"1f6aa9c01bdc41d2b456e6186ed1856c\",\"a3d3ae69d4a04044b08afdb1c058a5da\",\"db49860eba2345f481487e7f7a8151a0\",\"f384e2659e824023b95f35d1bd84d4c9\",\"461c3e77a65342e2b1995d1f3dfc9164\",\"ca32759beb8642128be161b7d0dd433f\",\"d5ebfb1c58ae4ffd9f45a20c77b7f260\",\"d605bd09b6114764a951e0cbc09ebd98\",\"ec057d2c988b4418b2f07b311271581c\",\"f46b4c4b77ad489c81a374d72fc39c8f\",\"f598cd2134dc4358949fb6c68ed6471e\",\"0c1efedee7f747098b6efa2fbf8747a3\",\"70355a9577d746d4a33fa2342ac15a84\",\"adc5cd2824884d14bbb9bca2fac0af3c\",\"affd7aa0cc89493f9c03f944b85ac466\",\"e72a1ef3ee86439c90f4fc87e02d0043\",\"f7ea304bfd394835aec3b482a9b9404b\",\"20edaccce184448fa24f15aa2759b3d1\",\"2f565daf1bee4b459cdb94bb26a06572\",\"75e65c63cf704612a836e52baa2978a6\",\"8418b9af3d72471e9edc142c98f1baea\",\"865fa70c88cb457bbce66ae69f0d5dbf\",\"885ef99a74ea454b881aeb8220c5220a\",\"a0b26dd5395c432da2ba54b5d6a7fb3f\",\"0dfc1a45c1a04cdd9ac810ce64c4afbb\",\"407365d273034590b24c357ae63cd296\",\"46a453d5175649a0819b1add7ffb774d\",\"84d1d3e8833542f3994decbd87936eec\",\"93f7aba124814e2694e6e11df2bcc9a5\",\"a68f8a96a5164cd1a8ab55454681cc84\",\"1cf1aacdcab14c218ae9be077239407f\",\"344d930c397749beb2db9f354fa0e281\",\"421a8ae169934a1eb307984f8526c3a0\",\"9c18d11cd68047269284f9aa34427060\",\"a265636a0763423d8f81be63f25f0a29\",\"e0270568d0804cf6a8f885c88b0b7e7b\"],\"status\":\"1\",\"updateTime\":\"2022-03-03 11:55:51\"}]', '192.168.0.124', '2022-03-03 11:55:51', 0);
INSERT INTO `sys_log` VALUES ('25029f93-aac8-42bb-8acf-6c97399ffa3c', '4acf530555284c03a558c0f768444363', 'admin', '附件上传-附件上传', 0, 'com.example.frame.controller.FileController.uploadFile()', NULL, '192.168.0.124', '2022-02-15 09:40:37', 0);
INSERT INTO `sys_log` VALUES ('27fb0515-d900-48e9-8cd8-2126502b655f', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登出', 0, 'com.example.frame.controller.SysUserController.logout()', '{\"loginId\":\"4acf530555284c03a558c0f768444363\",\"account\":\"admin\"}', '192.168.0.124', '2022-03-03 09:21:50', 1);
INSERT INTO `sys_log` VALUES ('281b537f-6315-4966-ae39-fc3d0afd060c', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.124', '2022-02-16 09:15:16', 1);
INSERT INTO `sys_log` VALUES ('2836de79-ed58-4e6a-aa5b-3728b484df59', '4acf530555284c03a558c0f768444363', 'admin', 'sql注入-sql注入', 0, 'com.example.frame.controller.SqlInjectionController.sqlInjection()', '[\"select * from sys_user_company\"]', '192.168.0.109', '2022-01-04 11:20:41', 0);
INSERT INTO `sys_log` VALUES ('2948662a-1121-459a-b4ed-62a9c0094c35', '4acf530555284c03a558c0f768444363', 'admin', '系统访问地区白名单-新增系统访问地区白名单', 0, 'com.example.frame.controller.WhiteRegionInfoController.add()', '[{\"city\":\"22\",\"createTime\":\"2022-03-01 17:22:28\",\"id\":\"0c4371d4a6a34fe7a072bbc7f15da5a6\",\"limit\":10,\"page\":1,\"region\":\"22\",\"syncTime\":\"1646126548559\"}]', '192.168.0.124', '2022-03-01 17:22:28', 0);
INSERT INTO `sys_log` VALUES ('2975e160-a619-4d49-99e3-c0882cc6b358', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.109', '2022-01-04 11:25:03', 1);
INSERT INTO `sys_log` VALUES ('2a6eb79c-9572-4343-846e-c6fcfa98aff0', '4acf530555284c03a558c0f768444363', 'admin', '附件信息表-删除附件信息表', 0, 'com.example.frame.controller.PublicAttachementController.delete()', '[[\"6106cf46432942c49422012fffa2f04d\"]]', '192.168.0.124', '2022-02-15 09:34:12', 0);
INSERT INTO `sys_log` VALUES ('2bc6e1d5-39d1-45a6-9e3c-abf4dec034dd', '4acf530555284c03a558c0f768444363', 'admin', '附件上传-附件上传', 0, 'com.example.frame.controller.FileController.uploadFile()', NULL, '192.168.0.124', '2022-02-15 09:39:07', 0);
INSERT INTO `sys_log` VALUES ('2cf85084-1d70-4389-b3cc-5c68012162cf', '4acf530555284c03a558c0f768444363', 'admin', '系统权限-新增系统权限', 0, 'com.example.frame.controller.SysPermissionController.add()', '[{\"createTime\":\"2022-03-03 14:25:25\",\"id\":\"5bf0075397774aff8fb2e010e10f388e\",\"limit\":10,\"name\":\"33\",\"orderNum\":\"33\",\"page\":1,\"pid\":\"0\",\"status\":\"0\",\"type\":\"2\",\"urlWeb\":\"33\"}]', '192.168.0.124', '2022-03-03 14:25:25', 0);
INSERT INTO `sys_log` VALUES ('2e2d4ca2-666c-43a6-8d21-24620c86fb68', '4acf530555284c03a558c0f768444363', 'admin', '系统权限-更新系统权限', 0, 'com.example.frame.controller.SysPermissionController.update()', '[{\"id\":\"270a28c3d58343348353455d32fc2c55\",\"limit\":10,\"name\":\"配置配置\",\"orderNum\":\"2\",\"page\":1,\"pid\":\"0\",\"status\":\"0\",\"type\":\"2\",\"updateTime\":\"2022-03-03 14:20:43\",\"urlWeb\":\"/1111\"}]', '192.168.0.124', '2022-03-03 14:20:47', 0);
INSERT INTO `sys_log` VALUES ('2f635459-7755-439c-af13-560f875ee5fe', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登出', 0, 'com.example.frame.controller.SysUserController.logout()', '{\"loginId\":\"4acf530555284c03a558c0f768444363\",\"account\":\"admin\"}', '192.168.0.124', '2022-02-15 17:16:36', 1);
INSERT INTO `sys_log` VALUES ('30660075-6aa8-4205-b8db-4803b43200fd', '4acf530555284c03a558c0f768444363', 'admin', 'ip黑名单记录表-新增ip黑名单记录表', 0, 'com.example.frame.controller.IpBlacklistInfoController.add()', '[{\"createTime\":\"2022-03-01 16:16:35\",\"effectiveTime\":\"2\",\"id\":\"e53e652a39df4f1382f4ce688143ce3f\",\"ip\":\"192.168.0.124\",\"limit\":10,\"mapping\":\"*\",\"page\":1,\"syncTime\":\"1646122595665\",\"type\":\"1\"}]', '192.168.0.124', '2022-03-01 16:16:35', 0);
INSERT INTO `sys_log` VALUES ('316d2a8e-e893-44f9-9b34-14a2e708b816', '4acf530555284c03a558c0f768444363', 'admin', '系统权限-删除系统权限', 0, 'com.example.frame.controller.SysPermissionController.delete()', '[\"cfff617b6f6444fda7853cdd6ab0c4b6\"]', '192.168.0.124', '2022-03-03 14:25:50', 0);
INSERT INTO `sys_log` VALUES ('323f5640-7dfe-4b12-a264-41d7a45abbc7', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.124', '2022-03-01 15:06:09', 1);
INSERT INTO `sys_log` VALUES ('363a29b2-51e1-4c62-a5d1-89b5718b4bc2', '4acf530555284c03a558c0f768444363', 'admin', '系统角色-更新系统角色', 0, 'com.example.frame.controller.SysRoleController.update()', '[{\"description\":\"拥有所有权限-不能删除\",\"id\":\"11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9\",\"limit\":10,\"name\":\"超级管理员\",\"page\":1,\"permissionList\":[\"2f9f079433944514b7ab77ade4dc2d7b\",\"088c12320dba460f95ddf52d94bd939b\",\"1026b0e03be14c1ca036ec106d0ec660\",\"4d1555b2e7bf406a91c5713bba13c054\",\"afff2ee8740347cd9aee391307ee6b78\",\"c5af6608d7cf47e0aa57d53ec59e34b6\",\"c5b3d43f56ee40f0b1724fa88935621c\",\"c7dcb23bcf924ce9a1efac91d780b7d2\",\"0e0da70f159b4115b3bbb9731733743f\",\"18254d278201405982cbca7670c48bda\",\"211fedbb1cea47ed8edf30c266ca5282\",\"6b3310e94046485db87ed04f2f5e610e\",\"8813764db7b34dc2ad515ba5b66201e4\",\"bfd6b1d63bbb4b4598652ac09565759f\",\"2971f3d710df48e99fc4b19dfc747266\",\"68f96e445930404788977ea2acdd23d1\",\"7348a6ab4be546c8a66758ce2d23795b\",\"d983d01037f14440a0633e8bec882b55\",\"f4409af657d84910a3d2aa03008f14e8\",\"03e4758110a04f589b80110501fdd34d\",\"3befc6ab26234076947dbc4a3558a627\",\"334af23eb2404398a615aeb09ee0dfbc\",\"527e91eabbb8445db77757fc51cb7131\",\"b7fd20301ba545d8bce51be32d975869\",\"bef54ec653d64a78862b81f5dd48afdb\",\"ca50d2174b0c42c9824f773ac8c0f275\",\"d337a26d47284eb48c6a877b81f52ab1\",\"0a261fae6d264d99adb12711c67e1dc5\",\"722ae34c8c97410eb15aaa3e1bd3910c\",\"78b50f83d6bd41329c5dc425641d7ade\",\"7f377771184a42a98306ddf92a98b86c\",\"a6e0e8483735498fbaa2d26106ffaa49\",\"c45a2629a8514ff4a33ea3cb1174c7ec\",\"d4a8758c3da34e30827757cc61e7cde4\",\"dc84e16c24784f5fa935491b9d2bcacd\",\"2617ef912c564eb58f6aaf89520e3241\",\"ecd2cb371eb34e279efa683488716b88\",\"2861b2b1fc274cd79c43a3dda67cb628\",\"60abd7273f0743908097160b769a3e66\",\"e45de716281c4d859bf612fa41684a44\",\"e698271183e84ec3ae309d027468d3dc\",\"fb4de75a56574f86b7f455fb7e8de7cf\",\"17e5599a62ea439dac746b7118cd0041\",\"24d07d9dcae341e8b36f94d4e2650144\",\"4c8da359f254448e943a33cbaae383c4\",\"50103e8963e746d89ef7817b1cf31241\",\"94eafc7b0e1444a6bbf3f4ea52b99368\",\"b3f9ada00bac47e1a4897b31dea9bb43\",\"db40bbb647ff45f1aa7661777b1d0134\",\"f4d97a7bed404563bd982521d2585900\",\"157c5429d1214839902f65e05e939d29\",\"fd68e0ad5498491688a8790f21c11b98\",\"044f9b38d0dd4180a331b927aa9ffe6d\",\"0f80790e9294448fb29a8ea03c4ac7d2\",\"2ecf9b08451346469916a7495015fbaa\",\"40100f3655754e63a1c55a7a550625ba\",\"5a6e9e8b3b584064a583b4e731cdfd18\",\"b2c0de1721e844e5aad22f72555a9017\",\"eead81c82ab5420e84fe687a6cdb240a\",\"2f403f52fc444046b2c1ebc37428d69c\",\"5163e43a13c64537aaf0d50aa7572cc3\",\"65e0683e9184433daa79a66753759b79\",\"c64e29f27dd14849a1443616c9eaa553\",\"db695d59536e4569a355258bc5f94394\",\"dd48635abaaf4709b73c04dc330be6b1\",\"1733d590018a4300bdcb42d2a773e451\",\"1e9272e8175d4c3b948168f136c2b964\",\"1f6aa9c01bdc41d2b456e6186ed1856c\",\"a3d3ae69d4a04044b08afdb1c058a5da\",\"db49860eba2345f481487e7f7a8151a0\",\"f384e2659e824023b95f35d1bd84d4c9\",\"461c3e77a65342e2b1995d1f3dfc9164\",\"ca32759beb8642128be161b7d0dd433f\",\"d605bd09b6114764a951e0cbc09ebd98\",\"ec057d2c988b4418b2f07b311271581c\",\"f46b4c4b77ad489c81a374d72fc39c8f\",\"f598cd2134dc4358949fb6c68ed6471e\",\"0c1efedee7f747098b6efa2fbf8747a3\",\"70355a9577d746d4a33fa2342ac15a84\",\"adc5cd2824884d14bbb9bca2fac0af3c\",\"affd7aa0cc89493f9c03f944b85ac466\",\"e72a1ef3ee86439c90f4fc87e02d0043\",\"f7ea304bfd394835aec3b482a9b9404b\",\"20edaccce184448fa24f15aa2759b3d1\",\"2f565daf1bee4b459cdb94bb26a06572\",\"75e65c63cf704612a836e52baa2978a6\",\"8418b9af3d72471e9edc142c98f1baea\",\"865fa70c88cb457bbce66ae69f0d5dbf\",\"885ef99a74ea454b881aeb8220c5220a\",\"a0b26dd5395c432da2ba54b5d6a7fb3f\",\"0dfc1a45c1a04cdd9ac810ce64c4afbb\",\"407365d273034590b24c357ae63cd296\",\"46a453d5175649a0819b1add7ffb774d\",\"84d1d3e8833542f3994decbd87936eec\",\"93f7aba124814e2694e6e11df2bcc9a5\",\"a68f8a96a5164cd1a8ab55454681cc84\",\"1cf1aacdcab14c218ae9be077239407f\",\"344d930c397749beb2db9f354fa0e281\",\"421a8ae169934a1eb307984f8526c3a0\",\"9c18d11cd68047269284f9aa34427060\",\"a265636a0763423d8f81be63f25f0a29\",\"e0270568d0804cf6a8f885c88b0b7e7b\"],\"status\":\"1\",\"updateTime\":\"2022-03-03 10:17:50\"}]', '192.168.0.124', '2022-03-03 10:17:50', 0);
INSERT INTO `sys_log` VALUES ('366a5b1d-1015-42d9-9257-1bab74d3d517', '4acf530555284c03a558c0f768444363', 'admin', '附件上传-附件上传', 0, 'com.example.frame.controller.FileController.uploadFile()', NULL, '192.168.0.124', '2022-02-15 09:37:25', 0);
INSERT INTO `sys_log` VALUES ('38ac10f9-427d-4e53-af53-9a11d32291dd', '4acf530555284c03a558c0f768444363', 'admin', '系统权限-更新系统权限', 0, 'com.example.frame.controller.SysPermissionController.update()', '[{\"id\":\"4e6f9c62dd2a415881cff9108de07e0b\",\"limit\":10,\"name\":\"配置-2\",\"orderNum\":\"1\",\"page\":1,\"pid\":\"cbd0f7faa72e49efbfdc094e078b11bf\",\"status\":\"0\",\"type\":\"2\",\"updateTime\":\"2022-03-03 15:03:37\",\"urlWeb\":\"/pz2\"}]', '192.168.0.124', '2022-03-03 15:03:37', 0);
INSERT INTO `sys_log` VALUES ('3d475fca-c4ac-4e21-981c-9a617674cda1', '4acf530555284c03a558c0f768444363', 'admin', '系统权限-更新系统权限', 0, 'com.example.frame.controller.SysPermissionController.update()', '[{\"id\":\"4e6f9c62dd2a415881cff9108de07e0b\",\"limit\":10,\"name\":\"配置-2\",\"orderNum\":\"1\",\"page\":1,\"pid\":\"cbd0f7faa72e49efbfdc094e078b11bf\",\"status\":\"0\",\"type\":\"2\",\"updateTime\":\"2022-03-03 15:03:34\",\"urlWeb\":\"/pz3\"}]', '192.168.0.124', '2022-03-03 15:03:34', 0);
INSERT INTO `sys_log` VALUES ('472436f2-180d-43bb-8456-0d2da839db0b', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.124', '2022-03-01 17:28:25', 1);
INSERT INTO `sys_log` VALUES ('4bc03188-4cb9-4060-a426-5bd88be50970', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.109', '2022-01-05 10:15:21', 1);
INSERT INTO `sys_log` VALUES ('4f9c876c-17d8-4394-99d2-233e4bb8e861', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.124', '2022-03-01 17:05:53', 1);
INSERT INTO `sys_log` VALUES ('51376510-10af-410c-aab2-fa7687c73e4e', '4acf530555284c03a558c0f768444363', 'admin', 'ip黑名单记录表-新增ip黑名单记录表', 0, 'com.example.frame.controller.IpBlacklistInfoController.add()', '[{\"createTime\":\"2022-03-01 16:14:57\",\"effectiveTime\":\"1\",\"id\":\"9406cacc7fad4fefa1a8a4f1f6dea47f\",\"ip\":\"192.168.0.124\",\"limit\":10,\"mapping\":\"*\",\"page\":1,\"syncTime\":\"1646122497634\",\"type\":\"1\"}]', '192.168.0.124', '2022-03-01 16:14:57', 0);
INSERT INTO `sys_log` VALUES ('5210e645-fee1-4cc4-9138-8fd3f0e219df', '4acf530555284c03a558c0f768444363', 'admin', 'ip黑名单记录表-新增ip黑名单记录表', 0, 'com.example.frame.controller.IpBlacklistInfoController.add()', '[{\"createTime\":\"2022-04-11 10:30:02\",\"effectiveTime\":\"-1\",\"id\":\"a8a945e81ed34927ae9a02459cef608f\",\"ip\":\"0.0.0.0\",\"limit\":10,\"mapping\":\"*\",\"page\":1,\"syncTime\":\"1649644202006\",\"type\":\"1\"}]', '192.168.0.124', '2022-04-11 10:30:02', 0);
INSERT INTO `sys_log` VALUES ('52486004-8a6e-4989-8d8c-a9341eea25b3', '4acf530555284c03a558c0f768444363', 'admin', 'ip黑名单记录表-新增ip黑名单记录表', 0, 'com.example.frame.controller.IpBlacklistInfoController.add()', '[{\"createTime\":\"2022-07-27 15:00:17\",\"effectiveTime\":\"1\",\"id\":\"ed4e9b5b1b7f4e5b93bd5216be7a31ca\",\"ip\":\"111\",\"limit\":10,\"mapping\":\"*\",\"page\":1,\"syncTime\":\"1658905217649\",\"type\":\"1\"}]', '192.168.0.124', '2022-07-27 15:00:17', 0);
INSERT INTO `sys_log` VALUES ('53592d4f-eb9f-434e-bef5-6601a4086e3e', '4acf530555284c03a558c0f768444363', 'admin', '系统角色-更新系统角色', 0, 'com.example.frame.controller.SysRoleController.update()', '[{\"description\":\"拥有所有权限-不能删除\",\"id\":\"11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9\",\"limit\":10,\"name\":\"超级管理员\",\"page\":1,\"permissionList\":[],\"status\":\"1\",\"updateTime\":\"2022-03-03 15:39:05\"}]', '192.168.0.124', '2022-03-03 15:39:05', 0);
INSERT INTO `sys_log` VALUES ('535d2a1f-a0bf-410a-bae8-37c0870d68fe', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.124', '2022-03-03 10:52:57', 1);
INSERT INTO `sys_log` VALUES ('54631806-af9c-42a2-9ae8-02860ede66a9', '4acf530555284c03a558c0f768444363', 'admin', 'sql注入-sql注入', 0, 'com.example.frame.controller.SqlInjectionController.sqlInjection()', '[\"select * from public_attachement\"]', '192.168.0.109', '2022-01-04 11:20:39', 0);
INSERT INTO `sys_log` VALUES ('55209d84-32b9-43cd-b146-bae5e1887d75', '4acf530555284c03a558c0f768444363', 'admin', '系统权限-新增系统权限', 0, 'com.example.frame.controller.SysPermissionController.add()', '[{\"createTime\":\"2022-03-03 14:29:50\",\"id\":\"35344cba2f244c2493d4e4fc169f2460\",\"limit\":10,\"name\":\"22\",\"orderNum\":\"22\",\"page\":1,\"pid\":\"72dc221d76ae43b9a8777e53da99d53c\",\"status\":\"0\",\"type\":\"2\",\"urlWeb\":\"22\"}]', '192.168.0.124', '2022-03-03 14:29:50', 0);
INSERT INTO `sys_log` VALUES ('575fc52b-3b06-418d-97a6-4a783c82a698', '4acf530555284c03a558c0f768444363', 'admin', '系统权限-删除系统权限', 0, 'com.example.frame.controller.SysPermissionController.delete()', '[\"bf00431a93c5406b8e1760479127a51e\"]', '192.168.0.124', '2022-03-03 14:30:43', 0);
INSERT INTO `sys_log` VALUES ('5b4b1d7b-28df-4425-9c12-721d75d74a21', '4acf530555284c03a558c0f768444363', 'admin', 'ip黑名单记录表-新增ip黑名单记录表', 0, 'com.example.frame.controller.IpBlacklistInfoController.add()', '[{\"createTime\":\"2022-03-01 16:11:53\",\"effectiveTime\":\"1\",\"id\":\"35c3a427580f4bf58133173921eb01d9\",\"ip\":\"192.168.0.124\",\"limit\":10,\"mapping\":\"*\",\"page\":1,\"syncTime\":\"1646122313681\"}]', '192.168.0.124', '2022-03-01 16:11:53', 0);
INSERT INTO `sys_log` VALUES ('5c876d15-af33-4779-a973-cc3264093fbd', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.124', '2022-02-15 09:08:23', 1);
INSERT INTO `sys_log` VALUES ('5fe55a15-9308-4e81-9770-aab64d444d0c', '4acf530555284c03a558c0f768444363', 'admin', 'sql注入-sql注入', 0, 'com.example.frame.controller.SqlInjectionController.sqlInjection()', '[\"select * from qrtz_cron_triggers\"]', '192.168.0.109', '2022-01-04 11:20:37', 0);
INSERT INTO `sys_log` VALUES ('613263da-799e-46f8-b39e-8c05757dc1d2', '4acf530555284c03a558c0f768444363', 'admin', '系统权限-新增系统权限', 0, 'com.example.frame.controller.SysPermissionController.add()', '[{\"createTime\":\"2022-03-03 14:31:14\",\"id\":\"cbd0f7faa72e49efbfdc094e078b11bf\",\"limit\":10,\"name\":\"系统配置\",\"orderNum\":\"2\",\"page\":1,\"pid\":\"0\",\"status\":\"0\",\"type\":\"1\"}]', '192.168.0.124', '2022-03-03 14:31:14', 0);
INSERT INTO `sys_log` VALUES ('63a173fa-5b83-47f3-bd78-7018cd45fabd', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.124', '2022-07-27 14:13:08', 1);
INSERT INTO `sys_log` VALUES ('6578a5de-d214-4f02-a73e-a3d0ffd29ca0', '4acf530555284c03a558c0f768444363', 'admin', 'ip黑名单记录表-删除ip黑名单记录表', 0, 'com.example.frame.controller.IpBlacklistInfoController.delete()', '[[\"a8a945e81ed34927ae9a02459cef608f\"]]', '192.168.0.124', '2022-04-11 10:31:08', 0);
INSERT INTO `sys_log` VALUES ('673ff6d0-6f72-4852-bd41-582ad04ee941', '4acf530555284c03a558c0f768444363', 'admin', '系统访问地区白名单-删除系统访问地区白名单', 0, 'com.example.frame.controller.WhiteRegionInfoController.delete()', '[[\"36795f0ccd974d99ba928328ea14e624\"]]', '192.168.0.124', '2022-03-01 17:30:17', 0);
INSERT INTO `sys_log` VALUES ('6aee7805-d9d1-4298-b716-6501f8a39d7f', '4acf530555284c03a558c0f768444363', 'admin', 'ip黑名单记录表-删除ip黑名单记录表', 0, 'com.example.frame.controller.IpBlacklistInfoController.delete()', '[[\"19298e20c4674eb2b7386f5793b6734f\"]]', '192.168.0.124', '2022-07-28 15:15:41', 0);
INSERT INTO `sys_log` VALUES ('6f1e5f80-7b2e-49fa-a560-3f2a2c721c4e', '4acf530555284c03a558c0f768444363', 'admin', '查询所有表格-查询所有表格', 0, 'com.example.frame.controller.SqlInjectionController.selectAllTable()', NULL, '192.168.0.124', '2022-03-01 16:37:09', 0);
INSERT INTO `sys_log` VALUES ('6f4d447a-6404-4b62-ad4f-ef19df69750e', '4acf530555284c03a558c0f768444363', 'admin', '系统角色-更新系统角色', 0, 'com.example.frame.controller.SysRoleController.update()', '[{\"description\":\"你好\",\"id\":\"960377d5b6c74972ab6b45f647129ecc\",\"limit\":10,\"name\":\"市管理员\",\"page\":1,\"permissionList\":[\"088c12320dba460f95ddf52d94bd939b\",\"1026b0e03be14c1ca036ec106d0ec660\",\"4d1555b2e7bf406a91c5713bba13c054\",\"afff2ee8740347cd9aee391307ee6b78\",\"c5af6608d7cf47e0aa57d53ec59e34b6\",\"c5b3d43f56ee40f0b1724fa88935621c\",\"c7dcb23bcf924ce9a1efac91d780b7d2\",\"0e0da70f159b4115b3bbb9731733743f\",\"18254d278201405982cbca7670c48bda\",\"211fedbb1cea47ed8edf30c266ca5282\",\"6b3310e94046485db87ed04f2f5e610e\",\"8813764db7b34dc2ad515ba5b66201e4\",\"bfd6b1d63bbb4b4598652ac09565759f\",\"2971f3d710df48e99fc4b19dfc747266\",\"68f96e445930404788977ea2acdd23d1\",\"7348a6ab4be546c8a66758ce2d23795b\",\"d983d01037f14440a0633e8bec882b55\",\"f4409af657d84910a3d2aa03008f14e8\",\"03e4758110a04f589b80110501fdd34d\",\"3befc6ab26234076947dbc4a3558a627\",\"334af23eb2404398a615aeb09ee0dfbc\",\"527e91eabbb8445db77757fc51cb7131\",\"b7fd20301ba545d8bce51be32d975869\",\"bef54ec653d64a78862b81f5dd48afdb\",\"ca50d2174b0c42c9824f773ac8c0f275\",\"d337a26d47284eb48c6a877b81f52ab1\",\"0a261fae6d264d99adb12711c67e1dc5\",\"722ae34c8c97410eb15aaa3e1bd3910c\",\"78b50f83d6bd41329c5dc425641d7ade\",\"7f377771184a42a98306ddf92a98b86c\",\"a6e0e8483735498fbaa2d26106ffaa49\",\"c45a2629a8514ff4a33ea3cb1174c7ec\",\"d4a8758c3da34e30827757cc61e7cde4\",\"dc84e16c24784f5fa935491b9d2bcacd\",\"ee07e8c52a18422195cb02e86cf1855b\",\"032d03ca6fa949ad89db06ae2d29a80a\",\"0ba0b79f95874a1a88a9010651e33f57\",\"8502660955264d94b7122be852c797c6\",\"98ff03cfd4724f8f96498ca2cb3bf758\",\"ac11e15a148142acbb47b62db1439c4a\",\"d0261441a42a4a148178aa3aaf048c36\",\"2617ef912c564eb58f6aaf89520e3241\",\"ecd2cb371eb34e279efa683488716b88\",\"2861b2b1fc274cd79c43a3dda67cb628\",\"60abd7273f0743908097160b769a3e66\",\"e45de716281c4d859bf612fa41684a44\",\"e698271183e84ec3ae309d027468d3dc\",\"fb4de75a56574f86b7f455fb7e8de7cf\",\"17e5599a62ea439dac746b7118cd0041\",\"24d07d9dcae341e8b36f94d4e2650144\",\"4c8da359f254448e943a33cbaae383c4\",\"50103e8963e746d89ef7817b1cf31241\",\"94eafc7b0e1444a6bbf3f4ea52b99368\",\"b3f9ada00bac47e1a4897b31dea9bb43\",\"db40bbb647ff45f1aa7661777b1d0134\",\"f4d97a7bed404563bd982521d2585900\",\"157c5429d1214839902f65e05e939d29\",\"fd68e0ad5498491688a8790f21c11b98\",\"044f9b38d0dd4180a331b927aa9ffe6d\",\"0f80790e9294448fb29a8ea03c4ac7d2\",\"2ecf9b08451346469916a7495015fbaa\",\"40100f3655754e63a1c55a7a550625ba\",\"5a6e9e8b3b584064a583b4e731cdfd18\",\"b2c0de1721e844e5aad22f72555a9017\",\"eead81c82ab5420e84fe687a6cdb240a\",\"2f403f52fc444046b2c1ebc37428d69c\",\"5163e43a13c64537aaf0d50aa7572cc3\",\"65e0683e9184433daa79a66753759b79\",\"c64e29f27dd14849a1443616c9eaa553\",\"db695d59536e4569a355258bc5f94394\",\"dd48635abaaf4709b73c04dc330be6b1\",\"1733d590018a4300bdcb42d2a773e451\",\"1e9272e8175d4c3b948168f136c2b964\",\"1f6aa9c01bdc41d2b456e6186ed1856c\",\"a3d3ae69d4a04044b08afdb1c058a5da\",\"db49860eba2345f481487e7f7a8151a0\",\"f384e2659e824023b95f35d1bd84d4c9\",\"461c3e77a65342e2b1995d1f3dfc9164\",\"ca32759beb8642128be161b7d0dd433f\",\"d5ebfb1c58ae4ffd9f45a20c77b7f260\",\"d605bd09b6114764a951e0cbc09ebd98\",\"ec057d2c988b4418b2f07b311271581c\",\"f46b4c4b77ad489c81a374d72fc39c8f\",\"f598cd2134dc4358949fb6c68ed6471e\",\"0c1efedee7f747098b6efa2fbf8747a3\",\"70355a9577d746d4a33fa2342ac15a84\",\"adc5cd2824884d14bbb9bca2fac0af3c\",\"affd7aa0cc89493f9c03f944b85ac466\",\"e72a1ef3ee86439c90f4fc87e02d0043\",\"f7ea304bfd394835aec3b482a9b9404b\",\"20edaccce184448fa24f15aa2759b3d1\",\"2f565daf1bee4b459cdb94bb26a06572\",\"75e65c63cf704612a836e52baa2978a6\",\"8418b9af3d72471e9edc142c98f1baea\",\"865fa70c88cb457bbce66ae69f0d5dbf\",\"885ef99a74ea454b881aeb8220c5220a\",\"a0b26dd5395c432da2ba54b5d6a7fb3f\",\"0dfc1a45c1a04cdd9ac810ce64c4afbb\",\"407365d273034590b24c357ae63cd296\",\"46a453d5175649a0819b1add7ffb774d\",\"84d1d3e8833542f3994decbd87936eec\",\"93f7aba124814e2694e6e11df2bcc9a5\",\"a68f8a96a5164cd1a8ab55454681cc84\",\"1cf1aacdcab14c218ae9be077239407f\",\"344d930c397749beb2db9f354fa0e281\",\"421a8ae169934a1eb307984f8526c3a0\",\"9c18d11cd68047269284f9aa34427060\",\"a265636a0763423d8f81be63f25f0a29\",\"e0270568d0804cf6a8f885c88b0b7e7b\"],\"status\":\"1\",\"updateTime\":\"2022-04-18 09:34:23\"}]', '0:0:0:0:0:0:0:1', '2022-04-18 09:34:23', 0);
INSERT INTO `sys_log` VALUES ('6f63f662-6a2b-4b0e-80b3-94b29eafcab0', '4acf530555284c03a558c0f768444363', 'admin', '系统角色-更新系统角色', 0, 'com.example.frame.controller.SysRoleController.update()', '[{\"description\":\"拥有所有权限-不能删除\",\"id\":\"11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9\",\"limit\":10,\"name\":\"超级管理员\",\"page\":1,\"permissionList\":[\"2cac5102ece741d9a48eb5524a264294\",\"2f1e10a368c3420da7efb9e28f9dcd89\",\"2f9f079433944514b7ab77ade4dc2d7b\"],\"status\":\"1\",\"updateTime\":\"2022-03-03 10:21:34\"}]', '192.168.0.124', '2022-03-03 10:21:34', 0);
INSERT INTO `sys_log` VALUES ('6f6ed7ba-5a1b-4695-8398-bd5b9120d8db', '4acf530555284c03a558c0f768444363', 'admin', '字典数据表-新增字典数据表', 0, 'com.example.frame.controller.SysDictDataController.add()', '[{\"createTime\":\"2022-02-15 09:18:30\",\"dictLabel\":\"123\",\"dictType\":\"systemPathConfiguration\",\"dictValue\":\"123\",\"id\":\"56c238c1413f4d7d8b7955d95f3b3775\",\"limit\":10,\"page\":1,\"remark\":\"123\",\"status\":\"0\",\"syncTime\":\"1644887910235\",\"typeId\":\"d7256bfa6e29b5bbe9776531d1697b30\"}]', '192.168.0.124', '2022-02-15 09:18:30', 0);
INSERT INTO `sys_log` VALUES ('6f8faa7c-280d-4efb-a037-2db484c0957e', '4acf530555284c03a558c0f768444363', 'admin', '系统角色-更新系统角色', 0, 'com.example.frame.controller.SysRoleController.update()', '[{\"description\":\"拥有所有权限-不能删除\",\"id\":\"11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9\",\"limit\":10,\"name\":\"超级管理员\",\"page\":1,\"permissionList\":[\"2cac5102ece741d9a48eb5524a264294\",\"11e189a1d23b4fdf9fe57ffa9c46c146\",\"270a28c3d58343348353455d32fc2c55\",\"088c12320dba460f95ddf52d94bd939b\",\"1026b0e03be14c1ca036ec106d0ec660\",\"4d1555b2e7bf406a91c5713bba13c054\",\"afff2ee8740347cd9aee391307ee6b78\",\"c5af6608d7cf47e0aa57d53ec59e34b6\",\"c5b3d43f56ee40f0b1724fa88935621c\",\"c7dcb23bcf924ce9a1efac91d780b7d2\",\"0e0da70f159b4115b3bbb9731733743f\",\"18254d278201405982cbca7670c48bda\",\"211fedbb1cea47ed8edf30c266ca5282\",\"6b3310e94046485db87ed04f2f5e610e\",\"8813764db7b34dc2ad515ba5b66201e4\",\"bfd6b1d63bbb4b4598652ac09565759f\",\"2971f3d710df48e99fc4b19dfc747266\",\"68f96e445930404788977ea2acdd23d1\",\"7348a6ab4be546c8a66758ce2d23795b\",\"d983d01037f14440a0633e8bec882b55\",\"f4409af657d84910a3d2aa03008f14e8\",\"03e4758110a04f589b80110501fdd34d\",\"3befc6ab26234076947dbc4a3558a627\",\"334af23eb2404398a615aeb09ee0dfbc\",\"527e91eabbb8445db77757fc51cb7131\",\"b7fd20301ba545d8bce51be32d975869\",\"bef54ec653d64a78862b81f5dd48afdb\",\"ca50d2174b0c42c9824f773ac8c0f275\",\"d337a26d47284eb48c6a877b81f52ab1\",\"0a261fae6d264d99adb12711c67e1dc5\",\"722ae34c8c97410eb15aaa3e1bd3910c\",\"78b50f83d6bd41329c5dc425641d7ade\",\"7f377771184a42a98306ddf92a98b86c\",\"a6e0e8483735498fbaa2d26106ffaa49\",\"c45a2629a8514ff4a33ea3cb1174c7ec\",\"d4a8758c3da34e30827757cc61e7cde4\",\"dc84e16c24784f5fa935491b9d2bcacd\",\"2617ef912c564eb58f6aaf89520e3241\",\"ecd2cb371eb34e279efa683488716b88\",\"2861b2b1fc274cd79c43a3dda67cb628\",\"60abd7273f0743908097160b769a3e66\",\"e45de716281c4d859bf612fa41684a44\",\"e698271183e84ec3ae309d027468d3dc\",\"fb4de75a56574f86b7f455fb7e8de7cf\",\"17e5599a62ea439dac746b7118cd0041\",\"24d07d9dcae341e8b36f94d4e2650144\",\"4c8da359f254448e943a33cbaae383c4\",\"50103e8963e746d89ef7817b1cf31241\",\"94eafc7b0e1444a6bbf3f4ea52b99368\",\"b3f9ada00bac47e1a4897b31dea9bb43\",\"db40bbb647ff45f1aa7661777b1d0134\",\"f4d97a7bed404563bd982521d2585900\",\"157c5429d1214839902f65e05e939d29\",\"fd68e0ad5498491688a8790f21c11b98\",\"044f9b38d0dd4180a331b927aa9ffe6d\",\"0f80790e9294448fb29a8ea03c4ac7d2\",\"2ecf9b08451346469916a7495015fbaa\",\"40100f3655754e63a1c55a7a550625ba\",\"5a6e9e8b3b584064a583b4e731cdfd18\",\"b2c0de1721e844e5aad22f72555a9017\",\"eead81c82ab5420e84fe687a6cdb240a\",\"2f403f52fc444046b2c1ebc37428d69c\",\"5163e43a13c64537aaf0d50aa7572cc3\",\"65e0683e9184433daa79a66753759b79\",\"c64e29f27dd14849a1443616c9eaa553\",\"db695d59536e4569a355258bc5f94394\",\"dd48635abaaf4709b73c04dc330be6b1\",\"1733d590018a4300bdcb42d2a773e451\",\"1e9272e8175d4c3b948168f136c2b964\",\"1f6aa9c01bdc41d2b456e6186ed1856c\",\"a3d3ae69d4a04044b08afdb1c058a5da\",\"db49860eba2345f481487e7f7a8151a0\",\"f384e2659e824023b95f35d1bd84d4c9\",\"461c3e77a65342e2b1995d1f3dfc9164\",\"ca32759beb8642128be161b7d0dd433f\",\"d5ebfb1c58ae4ffd9f45a20c77b7f260\",\"d605bd09b6114764a951e0cbc09ebd98\",\"ec057d2c988b4418b2f07b311271581c\",\"f46b4c4b77ad489c81a374d72fc39c8f\",\"f598cd2134dc4358949fb6c68ed6471e\",\"0c1efedee7f747098b6efa2fbf8747a3\",\"70355a9577d746d4a33fa2342ac15a84\",\"adc5cd2824884d14bbb9bca2fac0af3c\",\"affd7aa0cc89493f9c03f944b85ac466\",\"e72a1ef3ee86439c90f4fc87e02d0043\",\"f7ea304bfd394835aec3b482a9b9404b\",\"20edaccce184448fa24f15aa2759b3d1\",\"2f565daf1bee4b459cdb94bb26a06572\",\"75e65c63cf704612a836e52baa2978a6\",\"8418b9af3d72471e9edc142c98f1baea\",\"865fa70c88cb457bbce66ae69f0d5dbf\",\"885ef99a74ea454b881aeb8220c5220a\",\"a0b26dd5395c432da2ba54b5d6a7fb3f\",\"0dfc1a45c1a04cdd9ac810ce64c4afbb\",\"407365d273034590b24c357ae63cd296\",\"46a453d5175649a0819b1add7ffb774d\",\"84d1d3e8833542f3994decbd87936eec\",\"93f7aba124814e2694e6e11df2bcc9a5\",\"a68f8a96a5164cd1a8ab55454681cc84\",\"1cf1aacdcab14c218ae9be077239407f\",\"344d930c397749beb2db9f354fa0e281\",\"421a8ae169934a1eb307984f8526c3a0\",\"9c18d11cd68047269284f9aa34427060\",\"a265636a0763423d8f81be63f25f0a29\",\"e0270568d0804cf6a8f885c88b0b7e7b\"],\"status\":\"1\",\"updateTime\":\"2022-03-03 11:56:57\"}]', '192.168.0.124', '2022-03-03 11:56:57', 0);
INSERT INTO `sys_log` VALUES ('7060f868-ef8c-4717-b1a1-ed53fd3746c5', '4acf530555284c03a558c0f768444363', 'admin', '系统权限-新增系统权限', 0, 'com.example.frame.controller.SysPermissionController.add()', '[{\"createTime\":\"2022-03-03 14:30:52\",\"id\":\"cdf034a7b6254c579804a172925ea261\",\"limit\":10,\"name\":\"首页\",\"orderNum\":\"0\",\"page\":1,\"pid\":\"0\",\"status\":\"0\",\"type\":\"1\",\"urlWeb\":\"/home\"}]', '192.168.0.124', '2022-03-03 14:30:52', 0);
INSERT INTO `sys_log` VALUES ('70fc758e-46c3-4f22-8537-e5389fd3eabe', '4acf530555284c03a558c0f768444363', 'admin', 'ip黑名单记录表-新增ip黑名单记录表', 0, 'com.example.frame.controller.IpBlacklistInfoController.add()', '[{\"createTime\":\"2022-03-01 16:13:26\",\"effectiveTime\":\"1\",\"id\":\"d595fc7b78684fb5a542879fe90186fe\",\"ip\":\"1\",\"limit\":10,\"mapping\":\"*\",\"page\":1,\"syncTime\":\"1646122406667\",\"type\":\"1\"}]', '192.168.0.124', '2022-03-01 16:13:26', 0);
INSERT INTO `sys_log` VALUES ('72110f19-f579-42f2-8432-894c6078561e', '4acf530555284c03a558c0f768444363', 'admin', '系统角色-更新系统角色', 0, 'com.example.frame.controller.SysRoleController.update()', '[{\"description\":\"拥有所有权限-不能删除\",\"id\":\"11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9\",\"limit\":10,\"name\":\"超级管理员\",\"page\":1,\"permissionList\":[\"2f9f079433944514b7ab77ade4dc2d7b\"],\"status\":\"1\",\"updateTime\":\"2022-03-03 10:19:13\"}]', '192.168.0.124', '2022-03-03 10:19:13', 0);
INSERT INTO `sys_log` VALUES ('73353c5e-9ee3-4025-9ebb-948378bb7078', '4acf530555284c03a558c0f768444363', 'admin', '查询所有表格-查询所有表格', 0, 'com.example.frame.controller.SqlInjectionController.selectAllTable()', NULL, '192.168.0.109', '2022-01-04 11:20:35', 0);
INSERT INTO `sys_log` VALUES ('73745796-6788-4c3b-8181-798b039dd5eb', '4acf530555284c03a558c0f768444363', 'admin', '系统权限-删除系统权限', 0, 'com.example.frame.controller.SysPermissionController.delete()', '[\"270a28c3d58343348353455d32fc2c55\"]', '192.168.0.124', '2022-03-03 14:21:26', 0);
INSERT INTO `sys_log` VALUES ('76a95673-2c91-4a13-a3e6-ab2a0586fe4d', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.109', '2022-01-04 11:20:34', 1);
INSERT INTO `sys_log` VALUES ('79842c2f-2ed4-4745-bf55-2b8a82f7c6ea', '4acf530555284c03a558c0f768444363', 'admin', '字典数据表-删除字典数据表', 0, 'com.example.frame.controller.SysDictDataController.delete()', '[[\"8c7fad09bbe54a61a2f417b4c5b68716\"]]', '192.168.0.124', '2022-02-15 09:18:57', 0);
INSERT INTO `sys_log` VALUES ('7af87193-7828-4d3a-b046-77209cc5e794', '4acf530555284c03a558c0f768444363', 'admin', '字典数据表-新增字典数据表', 0, 'com.example.frame.controller.SysDictDataController.add()', '[{\"createTime\":\"2022-02-15 09:18:51\",\"dictLabel\":\"123\",\"dictType\":\"systemPathConfiguration\",\"dictValue\":\"123\",\"id\":\"8c7fad09bbe54a61a2f417b4c5b68716\",\"limit\":10,\"page\":1,\"remark\":\"123\",\"status\":\"0\",\"syncTime\":\"1644887931913\",\"typeId\":\"d7256bfa6e29b5bbe9776531d1697b30\"}]', '192.168.0.124', '2022-02-15 09:18:51', 0);
INSERT INTO `sys_log` VALUES ('7c736191-c8ba-45df-bd9a-b373dae8ad20', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.109', '2022-01-05 09:45:29', 1);
INSERT INTO `sys_log` VALUES ('7c830c1e-cfaf-450a-9748-a4ab1f91ad81', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登出', 0, 'com.example.frame.controller.SysUserController.logout()', '{\"loginId\":\"4acf530555284c03a558c0f768444363\",\"account\":\"admin\"}', '192.168.0.124', '2022-03-02 12:02:16', 1);
INSERT INTO `sys_log` VALUES ('7d60c443-76fd-4cd3-8b57-f6300dc989a2', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.124', '2022-03-01 16:38:56', 1);
INSERT INTO `sys_log` VALUES ('7fce1909-6822-4ec8-9561-0965ecdf6f92', '4acf530555284c03a558c0f768444363', 'admin', '系统权限-更新系统权限', 0, 'com.example.frame.controller.SysPermissionController.update()', '[{\"id\":\"配置配置\",\"limit\":10,\"name\":\"0\",\"orderNum\":\"0\",\"page\":1,\"pid\":\"/1111\",\"status\":\"2\",\"updateTime\":\"2022-03-03 14:19:18\",\"urlWeb\":\"2\"}]', '192.168.0.124', '2022-03-03 14:20:13', 0);
INSERT INTO `sys_log` VALUES ('7fe2ee87-568f-46e8-ab00-c65550ca840a', '4acf530555284c03a558c0f768444363', 'admin', '附件信息表-更新附件信息表', 0, 'com.example.frame.controller.PublicAttachementController.update()', '[{\"fjdl\":\"导入导出模板\",\"tempPath\":\"temp/5cedb737eb828ead37011179f6bd7af1.txt\",\"ysmc\":\"20220214114454-04f659134f46465aa16abd381875aec8.txt\",\"id\":\"078caeaea69748fda18ec4f85a8f22ba\",\"fjlx\":\"生命体征导入导出模板\"}]', '192.168.0.124', '2022-02-15 09:45:59', 0);
INSERT INTO `sys_log` VALUES ('80283bd0-056e-4cb6-895d-3008db5164e2', '4acf530555284c03a558c0f768444363', 'admin', '系统权限-新增系统权限', 0, 'com.example.frame.controller.SysPermissionController.add()', '[{\"createTime\":\"2022-03-03 11:28:14\",\"id\":\"270a28c3d58343348353455d32fc2c55\",\"limit\":10,\"name\":\"配置配置\",\"orderNum\":\"2\",\"page\":1,\"pid\":\"11e189a1d23b4fdf9fe57ffa9c46c146\",\"status\":\"0\",\"type\":\"2\",\"urlWeb\":\"/1111\"}]', '192.168.0.124', '2022-03-03 11:28:14', 0);
INSERT INTO `sys_log` VALUES ('813397ad-02dd-4cdb-b685-d30bb02c6705', '4acf530555284c03a558c0f768444363', 'admin', '系统角色-更新系统角色', 0, 'com.example.frame.controller.SysRoleController.update()', '[{\"description\":\"拥有所有权限-不能删除\",\"id\":\"11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9\",\"limit\":10,\"name\":\"超级管理员\",\"page\":1,\"permissionList\":[\"2cac5102ece741d9a48eb5524a264294\",\"2f1e10a368c3420da7efb9e28f9dcd89\",\"11e189a1d23b4fdf9fe57ffa9c46c146\",\"2f9f079433944514b7ab77ade4dc2d7b\",\"088c12320dba460f95ddf52d94bd939b\",\"1026b0e03be14c1ca036ec106d0ec660\",\"4d1555b2e7bf406a91c5713bba13c054\",\"afff2ee8740347cd9aee391307ee6b78\",\"c5af6608d7cf47e0aa57d53ec59e34b6\",\"c5b3d43f56ee40f0b1724fa88935621c\",\"c7dcb23bcf924ce9a1efac91d780b7d2\",\"0e0da70f159b4115b3bbb9731733743f\",\"18254d278201405982cbca7670c48bda\",\"211fedbb1cea47ed8edf30c266ca5282\",\"6b3310e94046485db87ed04f2f5e610e\",\"8813764db7b34dc2ad515ba5b66201e4\",\"bfd6b1d63bbb4b4598652ac09565759f\",\"2971f3d710df48e99fc4b19dfc747266\",\"68f96e445930404788977ea2acdd23d1\",\"7348a6ab4be546c8a66758ce2d23795b\",\"d983d01037f14440a0633e8bec882b55\",\"f4409af657d84910a3d2aa03008f14e8\",\"03e4758110a04f589b80110501fdd34d\",\"3befc6ab26234076947dbc4a3558a627\",\"334af23eb2404398a615aeb09ee0dfbc\",\"527e91eabbb8445db77757fc51cb7131\",\"b7fd20301ba545d8bce51be32d975869\",\"bef54ec653d64a78862b81f5dd48afdb\",\"ca50d2174b0c42c9824f773ac8c0f275\",\"d337a26d47284eb48c6a877b81f52ab1\",\"0a261fae6d264d99adb12711c67e1dc5\",\"722ae34c8c97410eb15aaa3e1bd3910c\",\"78b50f83d6bd41329c5dc425641d7ade\",\"7f377771184a42a98306ddf92a98b86c\",\"a6e0e8483735498fbaa2d26106ffaa49\",\"c45a2629a8514ff4a33ea3cb1174c7ec\",\"d4a8758c3da34e30827757cc61e7cde4\",\"dc84e16c24784f5fa935491b9d2bcacd\",\"2617ef912c564eb58f6aaf89520e3241\",\"ecd2cb371eb34e279efa683488716b88\",\"2861b2b1fc274cd79c43a3dda67cb628\",\"60abd7273f0743908097160b769a3e66\",\"e45de716281c4d859bf612fa41684a44\",\"e698271183e84ec3ae309d027468d3dc\",\"fb4de75a56574f86b7f455fb7e8de7cf\",\"17e5599a62ea439dac746b7118cd0041\",\"24d07d9dcae341e8b36f94d4e2650144\",\"4c8da359f254448e943a33cbaae383c4\",\"50103e8963e746d89ef7817b1cf31241\",\"94eafc7b0e1444a6bbf3f4ea52b99368\",\"b3f9ada00bac47e1a4897b31dea9bb43\",\"db40bbb647ff45f1aa7661777b1d0134\",\"f4d97a7bed404563bd982521d2585900\",\"157c5429d1214839902f65e05e939d29\",\"fd68e0ad5498491688a8790f21c11b98\",\"044f9b38d0dd4180a331b927aa9ffe6d\",\"0f80790e9294448fb29a8ea03c4ac7d2\",\"2ecf9b08451346469916a7495015fbaa\",\"40100f3655754e63a1c55a7a550625ba\",\"5a6e9e8b3b584064a583b4e731cdfd18\",\"b2c0de1721e844e5aad22f72555a9017\",\"eead81c82ab5420e84fe687a6cdb240a\",\"2f403f52fc444046b2c1ebc37428d69c\",\"5163e43a13c64537aaf0d50aa7572cc3\",\"65e0683e9184433daa79a66753759b79\",\"c64e29f27dd14849a1443616c9eaa553\",\"db695d59536e4569a355258bc5f94394\",\"dd48635abaaf4709b73c04dc330be6b1\",\"1733d590018a4300bdcb42d2a773e451\",\"1e9272e8175d4c3b948168f136c2b964\",\"1f6aa9c01bdc41d2b456e6186ed1856c\",\"a3d3ae69d4a04044b08afdb1c058a5da\",\"db49860eba2345f481487e7f7a8151a0\",\"f384e2659e824023b95f35d1bd84d4c9\",\"461c3e77a65342e2b1995d1f3dfc9164\",\"ca32759beb8642128be161b7d0dd433f\",\"d5ebfb1c58ae4ffd9f45a20c77b7f260\",\"d605bd09b6114764a951e0cbc09ebd98\",\"ec057d2c988b4418b2f07b311271581c\",\"f46b4c4b77ad489c81a374d72fc39c8f\",\"f598cd2134dc4358949fb6c68ed6471e\",\"0c1efedee7f747098b6efa2fbf8747a3\",\"70355a9577d746d4a33fa2342ac15a84\",\"adc5cd2824884d14bbb9bca2fac0af3c\",\"affd7aa0cc89493f9c03f944b85ac466\",\"e72a1ef3ee86439c90f4fc87e02d0043\",\"f7ea304bfd394835aec3b482a9b9404b\",\"20edaccce184448fa24f15aa2759b3d1\",\"2f565daf1bee4b459cdb94bb26a06572\",\"75e65c63cf704612a836e52baa2978a6\",\"8418b9af3d72471e9edc142c98f1baea\",\"865fa70c88cb457bbce66ae69f0d5dbf\",\"885ef99a74ea454b881aeb8220c5220a\",\"a0b26dd5395c432da2ba54b5d6a7fb3f\",\"0dfc1a45c1a04cdd9ac810ce64c4afbb\",\"407365d273034590b24c357ae63cd296\",\"46a453d5175649a0819b1add7ffb774d\",\"84d1d3e8833542f3994decbd87936eec\",\"93f7aba124814e2694e6e11df2bcc9a5\",\"a68f8a96a5164cd1a8ab55454681cc84\",\"1cf1aacdcab14c218ae9be077239407f\",\"344d930c397749beb2db9f354fa0e281\",\"421a8ae169934a1eb307984f8526c3a0\",\"9c18d11cd68047269284f9aa34427060\",\"a265636a0763423d8f81be63f25f0a29\",\"e0270568d0804cf6a8f885c88b0b7e7b\"],\"status\":\"1\",\"updateTime\":\"2022-03-03 11:27:35\"}]', '192.168.0.124', '2022-03-03 11:27:35', 0);
INSERT INTO `sys_log` VALUES ('8133f379-606a-4148-829b-686fea012c11', '4acf530555284c03a558c0f768444363', 'admin', '系统角色-更新系统角色', 0, 'com.example.frame.controller.SysRoleController.update()', '[{\"description\":\"拥有所有权限-不能删除\",\"id\":\"11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9\",\"limit\":10,\"name\":\"超级管理员\",\"page\":1,\"permissionList\":[\"cbd0f7faa72e49efbfdc094e078b11bf\",\"096ca24cadb94aa6a03fe9e9cd8f6f14\",\"4e6f9c62dd2a415881cff9108de07e0b\"],\"status\":\"1\",\"updateTime\":\"2022-03-03 15:44:33\"}]', '192.168.0.124', '2022-03-03 15:44:33', 0);
INSERT INTO `sys_log` VALUES ('8148de43-6477-4345-8c8d-58da1ffdc920', '4acf530555284c03a558c0f768444363', 'admin', '系统访问地区白名单-删除系统访问地区白名单', 0, 'com.example.frame.controller.WhiteRegionInfoController.delete()', '[[\"1\"]]', '192.168.0.124', '2022-03-01 17:30:16', 0);
INSERT INTO `sys_log` VALUES ('89c60601-fb23-43e7-8f4a-735145fd41a6', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.124', '2022-04-11 10:37:56', 1);
INSERT INTO `sys_log` VALUES ('8bde2ff0-929a-4fa7-87c2-b391a574d83e', '4acf530555284c03a558c0f768444363', 'admin', 'ip黑名单记录表-新增ip黑名单记录表', 0, 'com.example.frame.controller.IpBlacklistInfoController.add()', '[{\"createTime\":\"2022-03-01 15:28:05\",\"effectiveTime\":\"-1\",\"id\":\"e0ce9f8b5bc6405b972830487e78b317\",\"ip\":\"192.168.0.124\",\"limit\":10,\"page\":1,\"syncTime\":\"1646119685050\",\"type\":\"1\"}]', '192.168.0.124', '2022-03-01 15:28:05', 0);
INSERT INTO `sys_log` VALUES ('8dbb8c90-36f8-422c-a21a-a5633bdde746', '4acf530555284c03a558c0f768444363', 'admin', '系统角色-更新系统角色', 0, 'com.example.frame.controller.SysRoleController.update()', '[{\"description\":\"拥有所有权限-不能删除\",\"id\":\"11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9\",\"limit\":10,\"name\":\"超级管理员\",\"page\":1,\"permissionList\":[\"cdf034a7b6254c579804a172925ea261\",\"6c91aaf67d0341b2859b38c0eed28d00\",\"cbd0f7faa72e49efbfdc094e078b11bf\",\"096ca24cadb94aa6a03fe9e9cd8f6f14\",\"4e6f9c62dd2a415881cff9108de07e0b\"],\"status\":\"1\",\"updateTime\":\"2022-03-03 15:36:33\"}]', '192.168.0.124', '2022-03-03 15:36:33', 0);
INSERT INTO `sys_log` VALUES ('90869044-e840-4e5b-8ce6-d68fad6896bb', '4acf530555284c03a558c0f768444363', 'admin', 'ip黑名单记录表-新增ip黑名单记录表', 0, 'com.example.frame.controller.IpBlacklistInfoController.add()', '[{\"createTime\":\"2022-07-28 15:13:41\",\"effectiveTime\":\"1\",\"id\":\"19298e20c4674eb2b7386f5793b6734f\",\"ip\":\"111\",\"limit\":10,\"mapping\":\"*\",\"page\":1,\"syncTime\":\"1658992421652\",\"type\":\"1\"}]', '192.168.0.124', '2022-07-28 15:13:41', 0);
INSERT INTO `sys_log` VALUES ('90cb2303-cd7d-435f-be5b-2cb7cc5a4bb6', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.104', '2022-01-27 16:46:03', 1);
INSERT INTO `sys_log` VALUES ('91e225e8-c47b-47df-b190-ab3451d8d121', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.124', '2022-02-15 09:07:24', 1);
INSERT INTO `sys_log` VALUES ('95502c35-faad-46f7-abe9-86fda1e2f3b1', '4acf530555284c03a558c0f768444363', 'admin', '附件上传-附件上传', 0, 'com.example.frame.controller.FileController.uploadFile()', NULL, '192.168.0.124', '2022-02-15 09:45:31', 0);
INSERT INTO `sys_log` VALUES ('97ac9d0c-4273-4366-9af2-7c84cede7ecb', '4acf530555284c03a558c0f768444363', 'admin', '系统访问地区白名单-新增系统访问地区白名单', 0, 'com.example.frame.controller.WhiteRegionInfoController.add()', '[{\"city\":\"33\",\"createTime\":\"2022-03-01 17:22:50\",\"id\":\"36795f0ccd974d99ba928328ea14e624\",\"limit\":10,\"page\":1,\"region\":\"22\",\"syncTime\":\"1646126570571\"}]', '192.168.0.124', '2022-03-01 17:22:50', 0);
INSERT INTO `sys_log` VALUES ('9a1c48e9-df05-46d5-8fcb-15e3bad8ec0c', '4acf530555284c03a558c0f768444363', 'admin', '附件信息表-更新附件信息表', 0, 'com.example.frame.controller.PublicAttachementController.update()', '[{\"fjdl\":\"导入导出模板\",\"tempPath\":\"temp/1488401d23e82d647ebf0dde605b5097.txt\",\"ysmc\":\"20220214114454-04f659134f46465aa16abd381875aec8.txt\",\"id\":\"15daf5cf02b34b62a5213b5259b6ccc2\",\"fjlx\":\"生命体征导入导出模板\"}]', '192.168.0.124', '2022-02-15 09:46:18', 0);
INSERT INTO `sys_log` VALUES ('9dd6b500-5089-46b4-b7ee-3df6c5c33a1d', '4acf530555284c03a558c0f768444363', 'admin', '系统访问地区白名单-删除系统访问地区白名单', 0, 'com.example.frame.controller.WhiteRegionInfoController.delete()', '[[\"0c4371d4a6a34fe7a072bbc7f15da5a6\"]]', '192.168.0.124', '2022-03-01 17:30:15', 0);
INSERT INTO `sys_log` VALUES ('9fd0b0ce-c474-4d4e-a00e-21a74ecfe462', '4acf530555284c03a558c0f768444363', 'admin', '附件上传-附件上传', 0, 'com.example.frame.controller.FileController.uploadFile()', NULL, '192.168.0.124', '2022-02-15 09:43:45', 0);
INSERT INTO `sys_log` VALUES ('a1a67b3c-b3bc-4b31-802a-c2496231506b', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.124', '2022-03-02 12:02:15', 1);
INSERT INTO `sys_log` VALUES ('a4434f47-e247-4a59-a4b7-51b32d724a85', '4acf530555284c03a558c0f768444363', 'admin', '系统角色-更新系统角色', 0, 'com.example.frame.controller.SysRoleController.update()', '[{\"description\":\"拥有所有权限-不能删除\",\"id\":\"11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9\",\"limit\":10,\"name\":\"超级管理员\",\"page\":1,\"permissionList\":[\"cbd0f7faa72e49efbfdc094e078b11bf\",\"4e6f9c62dd2a415881cff9108de07e0b\"],\"status\":\"1\",\"updateTime\":\"2022-03-03 15:40:35\"}]', '192.168.0.124', '2022-03-03 15:40:35', 0);
INSERT INTO `sys_log` VALUES ('a6e58cff-9e7a-4e1f-bf51-8e6c74f1a559', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.104', '2022-01-27 16:55:44', 1);
INSERT INTO `sys_log` VALUES ('a72c803d-6a4e-4db8-a42e-d395271ca928', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.124', '2022-03-01 15:50:46', 1);
INSERT INTO `sys_log` VALUES ('a89f4a9e-85d2-477a-886f-e9cf74bc0464', '4acf530555284c03a558c0f768444363', 'admin', 'ip黑名单记录表-新增ip黑名单记录表', 0, 'com.example.frame.controller.IpBlacklistInfoController.add()', '[{\"createTime\":\"2022-03-01 16:13:34\",\"effectiveTime\":\"1\",\"id\":\"eae5ba8abb6b431db2acb75288df7933\",\"ip\":\"192.168.0.124\",\"limit\":10,\"mapping\":\"*\",\"page\":1,\"syncTime\":\"1646122414892\"}]', '192.168.0.124', '2022-03-01 16:13:34', 0);
INSERT INTO `sys_log` VALUES ('a991caab-8971-4c87-8c1c-2c65dce8165b', '4acf530555284c03a558c0f768444363', 'admin', '系统权限-更新系统权限', 0, 'com.example.frame.controller.SysPermissionController.update()', '[{\"id\":\"首页\",\"limit\":10,\"name\":\"0\",\"orderNum\":\"0\",\"page\":1,\"pid\":\"/home\",\"status\":\"2\",\"updateTime\":\"2022-03-03 14:19:03\",\"urlWeb\":\"1\"}]', '192.168.0.124', '2022-03-03 14:19:09', 0);
INSERT INTO `sys_log` VALUES ('a99eeb0c-91f8-45fa-bed2-6bb45498a7ce', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.124', '2022-03-03 10:23:39', 1);
INSERT INTO `sys_log` VALUES ('b1563716-fc69-4bde-ab50-68167f3909ad', '4acf530555284c03a558c0f768444363', 'admin', '系统角色-更新系统角色', 0, 'com.example.frame.controller.SysRoleController.update()', '[{\"description\":\"拥有所有权限-不能删除\",\"id\":\"11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9\",\"limit\":10,\"name\":\"超级管理员\",\"page\":1,\"permissionList\":[\"cdf034a7b6254c579804a172925ea261\",\"6c91aaf67d0341b2859b38c0eed28d00\"],\"status\":\"1\",\"updateTime\":\"2022-03-03 15:39:00\"}]', '192.168.0.124', '2022-03-03 15:39:00', 0);
INSERT INTO `sys_log` VALUES ('b26e69a2-a1e2-4e42-b73a-83fdb325a385', '4acf530555284c03a558c0f768444363', 'admin', '附件信息表-新增附件信息表', 0, 'com.example.frame.controller.PublicAttachementController.add()', '[{\"fjdl\":\"导入导出模板\",\"tempPath\":\"temp/2ba5c981ec3a2842003bf48b9cc9f609.txt\",\"ysmc\":\"20220114182851-78a7d92a2aa54a339f540c257736aaed.txt\",\"fjlx\":\"生命体征导入导出模板\"}]', '192.168.0.124', '2022-02-15 09:37:26', 0);
INSERT INTO `sys_log` VALUES ('b35c6a75-73dd-425d-afa8-efee94943ff8', '4acf530555284c03a558c0f768444363', 'admin', '系统权限-新增系统权限', 0, 'com.example.frame.controller.SysPermissionController.add()', '[{\"createTime\":\"2022-03-03 14:31:04\",\"id\":\"6c91aaf67d0341b2859b38c0eed28d00\",\"limit\":10,\"name\":\"用户管理\",\"orderNum\":\"1\",\"page\":1,\"pid\":\"0\",\"status\":\"0\",\"type\":\"1\",\"urlWeb\":\"/user\"}]', '192.168.0.124', '2022-03-03 14:31:04', 0);
INSERT INTO `sys_log` VALUES ('b3c61c7a-cb68-450f-9453-785b73c02a35', '4acf530555284c03a558c0f768444363', 'admin', '系统角色-更新系统角色', 0, 'com.example.frame.controller.SysRoleController.update()', '[{\"description\":\"拥有所有权限-不能删除\",\"id\":\"11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9\",\"limit\":10,\"name\":\"超级管理员\",\"page\":1,\"permissionList\":[\"2cac5102ece741d9a48eb5524a264294\",\"2f1e10a368c3420da7efb9e28f9dcd89\",\"11e189a1d23b4fdf9fe57ffa9c46c146\",\"2f9f079433944514b7ab77ade4dc2d7b\",\"088c12320dba460f95ddf52d94bd939b\",\"1026b0e03be14c1ca036ec106d0ec660\",\"4d1555b2e7bf406a91c5713bba13c054\",\"afff2ee8740347cd9aee391307ee6b78\",\"c5af6608d7cf47e0aa57d53ec59e34b6\",\"c5b3d43f56ee40f0b1724fa88935621c\",\"c7dcb23bcf924ce9a1efac91d780b7d2\",\"0e0da70f159b4115b3bbb9731733743f\",\"18254d278201405982cbca7670c48bda\",\"211fedbb1cea47ed8edf30c266ca5282\",\"6b3310e94046485db87ed04f2f5e610e\",\"8813764db7b34dc2ad515ba5b66201e4\",\"bfd6b1d63bbb4b4598652ac09565759f\",\"2971f3d710df48e99fc4b19dfc747266\",\"68f96e445930404788977ea2acdd23d1\",\"7348a6ab4be546c8a66758ce2d23795b\",\"d983d01037f14440a0633e8bec882b55\",\"f4409af657d84910a3d2aa03008f14e8\",\"03e4758110a04f589b80110501fdd34d\",\"3befc6ab26234076947dbc4a3558a627\",\"334af23eb2404398a615aeb09ee0dfbc\",\"527e91eabbb8445db77757fc51cb7131\",\"b7fd20301ba545d8bce51be32d975869\",\"bef54ec653d64a78862b81f5dd48afdb\",\"ca50d2174b0c42c9824f773ac8c0f275\",\"d337a26d47284eb48c6a877b81f52ab1\",\"0a261fae6d264d99adb12711c67e1dc5\",\"722ae34c8c97410eb15aaa3e1bd3910c\",\"78b50f83d6bd41329c5dc425641d7ade\",\"7f377771184a42a98306ddf92a98b86c\",\"a6e0e8483735498fbaa2d26106ffaa49\",\"c45a2629a8514ff4a33ea3cb1174c7ec\",\"d4a8758c3da34e30827757cc61e7cde4\",\"dc84e16c24784f5fa935491b9d2bcacd\",\"ee07e8c52a18422195cb02e86cf1855b\",\"032d03ca6fa949ad89db06ae2d29a80a\",\"0ba0b79f95874a1a88a9010651e33f57\",\"8502660955264d94b7122be852c797c6\",\"98ff03cfd4724f8f96498ca2cb3bf758\",\"ac11e15a148142acbb47b62db1439c4a\",\"d0261441a42a4a148178aa3aaf048c36\",\"2617ef912c564eb58f6aaf89520e3241\",\"ecd2cb371eb34e279efa683488716b88\",\"2861b2b1fc274cd79c43a3dda67cb628\",\"60abd7273f0743908097160b769a3e66\",\"e45de716281c4d859bf612fa41684a44\",\"e698271183e84ec3ae309d027468d3dc\",\"fb4de75a56574f86b7f455fb7e8de7cf\",\"17e5599a62ea439dac746b7118cd0041\",\"24d07d9dcae341e8b36f94d4e2650144\",\"4c8da359f254448e943a33cbaae383c4\",\"50103e8963e746d89ef7817b1cf31241\",\"94eafc7b0e1444a6bbf3f4ea52b99368\",\"b3f9ada00bac47e1a4897b31dea9bb43\",\"db40bbb647ff45f1aa7661777b1d0134\",\"f4d97a7bed404563bd982521d2585900\",\"157c5429d1214839902f65e05e939d29\",\"fd68e0ad5498491688a8790f21c11b98\",\"044f9b38d0dd4180a331b927aa9ffe6d\",\"0f80790e9294448fb29a8ea03c4ac7d2\",\"2ecf9b08451346469916a7495015fbaa\",\"40100f3655754e63a1c55a7a550625ba\",\"5a6e9e8b3b584064a583b4e731cdfd18\",\"b2c0de1721e844e5aad22f72555a9017\",\"eead81c82ab5420e84fe687a6cdb240a\",\"2f403f52fc444046b2c1ebc37428d69c\",\"5163e43a13c64537aaf0d50aa7572cc3\",\"65e0683e9184433daa79a66753759b79\",\"c64e29f27dd14849a1443616c9eaa553\",\"db695d59536e4569a355258bc5f94394\",\"dd48635abaaf4709b73c04dc330be6b1\",\"1733d590018a4300bdcb42d2a773e451\",\"1e9272e8175d4c3b948168f136c2b964\",\"1f6aa9c01bdc41d2b456e6186ed1856c\",\"a3d3ae69d4a04044b08afdb1c058a5da\",\"db49860eba2345f481487e7f7a8151a0\",\"f384e2659e824023b95f35d1bd84d4c9\",\"461c3e77a65342e2b1995d1f3dfc9164\",\"ca32759beb8642128be161b7d0dd433f\",\"d605bd09b6114764a951e0cbc09ebd98\",\"ec057d2c988b4418b2f07b311271581c\",\"f46b4c4b77ad489c81a374d72fc39c8f\",\"f598cd2134dc4358949fb6c68ed6471e\",\"0c1efedee7f747098b6efa2fbf8747a3\",\"70355a9577d746d4a33fa2342ac15a84\",\"adc5cd2824884d14bbb9bca2fac0af3c\",\"affd7aa0cc89493f9c03f944b85ac466\",\"e72a1ef3ee86439c90f4fc87e02d0043\",\"f7ea304bfd394835aec3b482a9b9404b\",\"20edaccce184448fa24f15aa2759b3d1\",\"2f565daf1bee4b459cdb94bb26a06572\",\"75e65c63cf704612a836e52baa2978a6\",\"8418b9af3d72471e9edc142c98f1baea\",\"865fa70c88cb457bbce66ae69f0d5dbf\",\"885ef99a74ea454b881aeb8220c5220a\",\"a0b26dd5395c432da2ba54b5d6a7fb3f\",\"0dfc1a45c1a04cdd9ac810ce64c4afbb\",\"407365d273034590b24c357ae63cd296\",\"46a453d5175649a0819b1add7ffb774d\",\"84d1d3e8833542f3994decbd87936eec\",\"93f7aba124814e2694e6e11df2bcc9a5\",\"a68f8a96a5164cd1a8ab55454681cc84\",\"1cf1aacdcab14c218ae9be077239407f\",\"344d930c397749beb2db9f354fa0e281\",\"421a8ae169934a1eb307984f8526c3a0\",\"9c18d11cd68047269284f9aa34427060\",\"a265636a0763423d8f81be63f25f0a29\",\"e0270568d0804cf6a8f885c88b0b7e7b\"],\"status\":\"1\",\"updateTime\":\"2022-03-03 10:32:05\"}]', '192.168.0.124', '2022-03-03 10:32:05', 0);
INSERT INTO `sys_log` VALUES ('b4dea5ed-09ef-4bba-85da-07887882b96f', '4acf530555284c03a558c0f768444363', 'admin', '附件上传-附件上传', 0, 'com.example.frame.controller.FileController.uploadFile()', NULL, '192.168.0.124', '2022-02-15 09:44:32', 0);
INSERT INTO `sys_log` VALUES ('b593dcab-8c0a-433d-80d6-9a36d6bf6a23', '4acf530555284c03a558c0f768444363', 'admin', '查询所有表格-查询所有表格', 0, 'com.example.frame.controller.SqlInjectionController.selectAllTable()', NULL, '192.168.0.109', '2022-01-04 11:25:09', 0);
INSERT INTO `sys_log` VALUES ('b9c35594-5979-4109-af80-8a93405d0b40', '4acf530555284c03a558c0f768444363', 'admin', '系统权限-新增系统权限', 0, 'com.example.frame.controller.SysPermissionController.add()', '[{\"createTime\":\"2022-03-03 14:31:56\",\"id\":\"4e6f9c62dd2a415881cff9108de07e0b\",\"limit\":10,\"name\":\"配置-2\",\"orderNum\":\"1\",\"page\":1,\"pid\":\"cbd0f7faa72e49efbfdc094e078b11bf\",\"status\":\"0\",\"type\":\"2\",\"urlWeb\":\"/pz2\"}]', '192.168.0.124', '2022-03-03 14:31:56', 0);
INSERT INTO `sys_log` VALUES ('bc94ab75-ca11-4f43-b1bc-caaae56de439', '4acf530555284c03a558c0f768444363', 'admin', 'ip黑名单记录表-删除ip黑名单记录表', 0, 'com.example.frame.controller.IpBlacklistInfoController.delete()', '[[\"7f8fa3ca33c5484fa614640df3619e0f\"]]', '192.168.0.124', '2022-07-28 15:15:42', 0);
INSERT INTO `sys_log` VALUES ('beb9c278-0d1a-45dd-bc69-96c0b7faf1c6', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.124', '2022-07-28 14:10:18', 1);
INSERT INTO `sys_log` VALUES ('bec7fcaf-678f-456b-bade-35421bb96538', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登出', 0, 'com.example.frame.controller.SysUserController.logout()', '{\"loginId\":\"4acf530555284c03a558c0f768444363\",\"account\":\"admin\"}', '192.168.0.124', '2022-03-02 11:59:39', 1);
INSERT INTO `sys_log` VALUES ('bffc05c6-59ea-4bc0-a244-844285ce13e6', '4acf530555284c03a558c0f768444363', 'admin', '系统角色-更新系统角色', 0, 'com.example.frame.controller.SysRoleController.update()', '[{\"description\":\"拥有所有权限-不能删除\",\"id\":\"11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9\",\"limit\":10,\"name\":\"超级管理员\",\"page\":1,\"permissionList\":[\"088c12320dba460f95ddf52d94bd939b\",\"1026b0e03be14c1ca036ec106d0ec660\",\"4d1555b2e7bf406a91c5713bba13c054\",\"afff2ee8740347cd9aee391307ee6b78\",\"c5af6608d7cf47e0aa57d53ec59e34b6\",\"c5b3d43f56ee40f0b1724fa88935621c\",\"c7dcb23bcf924ce9a1efac91d780b7d2\",\"0e0da70f159b4115b3bbb9731733743f\",\"18254d278201405982cbca7670c48bda\",\"211fedbb1cea47ed8edf30c266ca5282\",\"6b3310e94046485db87ed04f2f5e610e\",\"8813764db7b34dc2ad515ba5b66201e4\",\"bfd6b1d63bbb4b4598652ac09565759f\",\"2971f3d710df48e99fc4b19dfc747266\",\"68f96e445930404788977ea2acdd23d1\",\"7348a6ab4be546c8a66758ce2d23795b\",\"d983d01037f14440a0633e8bec882b55\",\"f4409af657d84910a3d2aa03008f14e8\",\"03e4758110a04f589b80110501fdd34d\",\"3befc6ab26234076947dbc4a3558a627\",\"334af23eb2404398a615aeb09ee0dfbc\",\"527e91eabbb8445db77757fc51cb7131\",\"b7fd20301ba545d8bce51be32d975869\",\"bef54ec653d64a78862b81f5dd48afdb\",\"ca50d2174b0c42c9824f773ac8c0f275\",\"d337a26d47284eb48c6a877b81f52ab1\",\"0a261fae6d264d99adb12711c67e1dc5\",\"722ae34c8c97410eb15aaa3e1bd3910c\",\"78b50f83d6bd41329c5dc425641d7ade\",\"7f377771184a42a98306ddf92a98b86c\",\"a6e0e8483735498fbaa2d26106ffaa49\",\"c45a2629a8514ff4a33ea3cb1174c7ec\",\"d4a8758c3da34e30827757cc61e7cde4\",\"dc84e16c24784f5fa935491b9d2bcacd\",\"2617ef912c564eb58f6aaf89520e3241\",\"ecd2cb371eb34e279efa683488716b88\",\"2861b2b1fc274cd79c43a3dda67cb628\",\"60abd7273f0743908097160b769a3e66\",\"e45de716281c4d859bf612fa41684a44\",\"e698271183e84ec3ae309d027468d3dc\",\"fb4de75a56574f86b7f455fb7e8de7cf\",\"17e5599a62ea439dac746b7118cd0041\",\"24d07d9dcae341e8b36f94d4e2650144\",\"4c8da359f254448e943a33cbaae383c4\",\"50103e8963e746d89ef7817b1cf31241\",\"94eafc7b0e1444a6bbf3f4ea52b99368\",\"b3f9ada00bac47e1a4897b31dea9bb43\",\"db40bbb647ff45f1aa7661777b1d0134\",\"f4d97a7bed404563bd982521d2585900\",\"157c5429d1214839902f65e05e939d29\",\"fd68e0ad5498491688a8790f21c11b98\",\"044f9b38d0dd4180a331b927aa9ffe6d\",\"0f80790e9294448fb29a8ea03c4ac7d2\",\"2ecf9b08451346469916a7495015fbaa\",\"40100f3655754e63a1c55a7a550625ba\",\"5a6e9e8b3b584064a583b4e731cdfd18\",\"b2c0de1721e844e5aad22f72555a9017\",\"eead81c82ab5420e84fe687a6cdb240a\",\"2f403f52fc444046b2c1ebc37428d69c\",\"5163e43a13c64537aaf0d50aa7572cc3\",\"65e0683e9184433daa79a66753759b79\",\"c64e29f27dd14849a1443616c9eaa553\",\"db695d59536e4569a355258bc5f94394\",\"dd48635abaaf4709b73c04dc330be6b1\",\"1733d590018a4300bdcb42d2a773e451\",\"1e9272e8175d4c3b948168f136c2b964\",\"1f6aa9c01bdc41d2b456e6186ed1856c\",\"a3d3ae69d4a04044b08afdb1c058a5da\",\"db49860eba2345f481487e7f7a8151a0\",\"f384e2659e824023b95f35d1bd84d4c9\",\"461c3e77a65342e2b1995d1f3dfc9164\",\"ca32759beb8642128be161b7d0dd433f\",\"d5ebfb1c58ae4ffd9f45a20c77b7f260\",\"d605bd09b6114764a951e0cbc09ebd98\",\"ec057d2c988b4418b2f07b311271581c\",\"f46b4c4b77ad489c81a374d72fc39c8f\",\"f598cd2134dc4358949fb6c68ed6471e\",\"0c1efedee7f747098b6efa2fbf8747a3\",\"70355a9577d746d4a33fa2342ac15a84\",\"adc5cd2824884d14bbb9bca2fac0af3c\",\"affd7aa0cc89493f9c03f944b85ac466\",\"e72a1ef3ee86439c90f4fc87e02d0043\",\"f7ea304bfd394835aec3b482a9b9404b\",\"20edaccce184448fa24f15aa2759b3d1\",\"2f565daf1bee4b459cdb94bb26a06572\",\"75e65c63cf704612a836e52baa2978a6\",\"8418b9af3d72471e9edc142c98f1baea\",\"865fa70c88cb457bbce66ae69f0d5dbf\",\"885ef99a74ea454b881aeb8220c5220a\",\"a0b26dd5395c432da2ba54b5d6a7fb3f\",\"0dfc1a45c1a04cdd9ac810ce64c4afbb\",\"407365d273034590b24c357ae63cd296\",\"46a453d5175649a0819b1add7ffb774d\",\"84d1d3e8833542f3994decbd87936eec\",\"93f7aba124814e2694e6e11df2bcc9a5\",\"a68f8a96a5164cd1a8ab55454681cc84\",\"1cf1aacdcab14c218ae9be077239407f\",\"344d930c397749beb2db9f354fa0e281\",\"421a8ae169934a1eb307984f8526c3a0\",\"9c18d11cd68047269284f9aa34427060\",\"a265636a0763423d8f81be63f25f0a29\",\"e0270568d0804cf6a8f885c88b0b7e7b\"],\"status\":\"1\",\"updateTime\":\"2022-03-03 11:55:16\"}]', '192.168.0.124', '2022-03-03 11:55:16', 0);
INSERT INTO `sys_log` VALUES ('c19566fa-f1f0-4af8-8c67-af4ed80ac118', '4acf530555284c03a558c0f768444363', 'admin', '系统角色-更新系统角色', 0, 'com.example.frame.controller.SysRoleController.update()', '[{\"description\":\"拥有所有权限-不能删除\",\"id\":\"11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9\",\"limit\":10,\"name\":\"超级管理员\",\"page\":1,\"permissionList\":[\"2cac5102ece741d9a48eb5524a264294\",\"2f1e10a368c3420da7efb9e28f9dcd89\",\"2f9f079433944514b7ab77ade4dc2d7b\",\"088c12320dba460f95ddf52d94bd939b\",\"1026b0e03be14c1ca036ec106d0ec660\",\"4d1555b2e7bf406a91c5713bba13c054\",\"afff2ee8740347cd9aee391307ee6b78\",\"c5af6608d7cf47e0aa57d53ec59e34b6\",\"c5b3d43f56ee40f0b1724fa88935621c\",\"c7dcb23bcf924ce9a1efac91d780b7d2\",\"0e0da70f159b4115b3bbb9731733743f\",\"18254d278201405982cbca7670c48bda\",\"211fedbb1cea47ed8edf30c266ca5282\",\"6b3310e94046485db87ed04f2f5e610e\",\"8813764db7b34dc2ad515ba5b66201e4\",\"bfd6b1d63bbb4b4598652ac09565759f\",\"2971f3d710df48e99fc4b19dfc747266\",\"68f96e445930404788977ea2acdd23d1\",\"7348a6ab4be546c8a66758ce2d23795b\",\"d983d01037f14440a0633e8bec882b55\",\"f4409af657d84910a3d2aa03008f14e8\",\"03e4758110a04f589b80110501fdd34d\",\"3befc6ab26234076947dbc4a3558a627\",\"334af23eb2404398a615aeb09ee0dfbc\",\"527e91eabbb8445db77757fc51cb7131\",\"b7fd20301ba545d8bce51be32d975869\",\"bef54ec653d64a78862b81f5dd48afdb\",\"ca50d2174b0c42c9824f773ac8c0f275\",\"d337a26d47284eb48c6a877b81f52ab1\",\"0a261fae6d264d99adb12711c67e1dc5\",\"722ae34c8c97410eb15aaa3e1bd3910c\",\"78b50f83d6bd41329c5dc425641d7ade\",\"7f377771184a42a98306ddf92a98b86c\",\"a6e0e8483735498fbaa2d26106ffaa49\",\"c45a2629a8514ff4a33ea3cb1174c7ec\",\"d4a8758c3da34e30827757cc61e7cde4\",\"dc84e16c24784f5fa935491b9d2bcacd\",\"2617ef912c564eb58f6aaf89520e3241\",\"ecd2cb371eb34e279efa683488716b88\",\"2861b2b1fc274cd79c43a3dda67cb628\",\"60abd7273f0743908097160b769a3e66\",\"e45de716281c4d859bf612fa41684a44\",\"e698271183e84ec3ae309d027468d3dc\",\"fb4de75a56574f86b7f455fb7e8de7cf\",\"17e5599a62ea439dac746b7118cd0041\",\"24d07d9dcae341e8b36f94d4e2650144\",\"4c8da359f254448e943a33cbaae383c4\",\"50103e8963e746d89ef7817b1cf31241\",\"94eafc7b0e1444a6bbf3f4ea52b99368\",\"b3f9ada00bac47e1a4897b31dea9bb43\",\"db40bbb647ff45f1aa7661777b1d0134\",\"f4d97a7bed404563bd982521d2585900\",\"157c5429d1214839902f65e05e939d29\",\"fd68e0ad5498491688a8790f21c11b98\",\"044f9b38d0dd4180a331b927aa9ffe6d\",\"0f80790e9294448fb29a8ea03c4ac7d2\",\"2ecf9b08451346469916a7495015fbaa\",\"40100f3655754e63a1c55a7a550625ba\",\"5a6e9e8b3b584064a583b4e731cdfd18\",\"b2c0de1721e844e5aad22f72555a9017\",\"eead81c82ab5420e84fe687a6cdb240a\",\"2f403f52fc444046b2c1ebc37428d69c\",\"5163e43a13c64537aaf0d50aa7572cc3\",\"65e0683e9184433daa79a66753759b79\",\"c64e29f27dd14849a1443616c9eaa553\",\"db695d59536e4569a355258bc5f94394\",\"dd48635abaaf4709b73c04dc330be6b1\",\"1733d590018a4300bdcb42d2a773e451\",\"1e9272e8175d4c3b948168f136c2b964\",\"1f6aa9c01bdc41d2b456e6186ed1856c\",\"a3d3ae69d4a04044b08afdb1c058a5da\",\"db49860eba2345f481487e7f7a8151a0\",\"f384e2659e824023b95f35d1bd84d4c9\",\"461c3e77a65342e2b1995d1f3dfc9164\",\"ca32759beb8642128be161b7d0dd433f\",\"d5ebfb1c58ae4ffd9f45a20c77b7f260\",\"d605bd09b6114764a951e0cbc09ebd98\",\"ec057d2c988b4418b2f07b311271581c\",\"f46b4c4b77ad489c81a374d72fc39c8f\",\"f598cd2134dc4358949fb6c68ed6471e\",\"0c1efedee7f747098b6efa2fbf8747a3\",\"70355a9577d746d4a33fa2342ac15a84\",\"adc5cd2824884d14bbb9bca2fac0af3c\",\"affd7aa0cc89493f9c03f944b85ac466\",\"e72a1ef3ee86439c90f4fc87e02d0043\",\"f7ea304bfd394835aec3b482a9b9404b\",\"20edaccce184448fa24f15aa2759b3d1\",\"2f565daf1bee4b459cdb94bb26a06572\",\"75e65c63cf704612a836e52baa2978a6\",\"8418b9af3d72471e9edc142c98f1baea\",\"865fa70c88cb457bbce66ae69f0d5dbf\",\"885ef99a74ea454b881aeb8220c5220a\",\"a0b26dd5395c432da2ba54b5d6a7fb3f\",\"0dfc1a45c1a04cdd9ac810ce64c4afbb\",\"407365d273034590b24c357ae63cd296\",\"46a453d5175649a0819b1add7ffb774d\",\"84d1d3e8833542f3994decbd87936eec\",\"93f7aba124814e2694e6e11df2bcc9a5\",\"a68f8a96a5164cd1a8ab55454681cc84\",\"1cf1aacdcab14c218ae9be077239407f\",\"344d930c397749beb2db9f354fa0e281\",\"421a8ae169934a1eb307984f8526c3a0\",\"9c18d11cd68047269284f9aa34427060\",\"a265636a0763423d8f81be63f25f0a29\",\"e0270568d0804cf6a8f885c88b0b7e7b\"],\"status\":\"1\",\"updateTime\":\"2022-03-03 11:26:59\"}]', '192.168.0.124', '2022-03-03 11:26:59', 0);
INSERT INTO `sys_log` VALUES ('c62eaabc-f5e2-40d9-803e-86faa81bcafc', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.124', '2022-03-03 09:21:15', 1);
INSERT INTO `sys_log` VALUES ('c8994067-b0eb-4c6e-b47e-b57162629d7d', '4acf530555284c03a558c0f768444363', 'admin', 'sql注入-sql注入', 0, 'com.example.frame.controller.SqlInjectionController.sqlInjection()', '[\"select * from sys_tree_data\"]', '192.168.0.109', '2022-01-04 11:20:40', 0);
INSERT INTO `sys_log` VALUES ('ca10b1ed-d225-4214-8050-a5bca3275949', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.104', '2022-01-27 16:52:14', 1);
INSERT INTO `sys_log` VALUES ('ca6157e5-2e82-4eee-ac01-9d99ca6cff52', '4acf530555284c03a558c0f768444363', 'admin', '系统访问地区白名单-新增系统访问地区白名单', 0, 'com.example.frame.controller.WhiteRegionInfoController.add()', '[{\"city\":\"33\",\"createTime\":\"2022-03-01 17:23:00\",\"id\":\"f95dee0ccb0548b2a4486e13c6122d3d\",\"limit\":10,\"page\":1,\"region\":\"33\",\"syncTime\":\"1646126580814\"}]', '192.168.0.124', '2022-03-01 17:23:00', 0);
INSERT INTO `sys_log` VALUES ('cb63ef9b-d49a-448d-a0cd-f92f947fdae8', '4acf530555284c03a558c0f768444363', 'admin', '系统权限-新增系统权限', 0, 'com.example.frame.controller.SysPermissionController.add()', '[{\"createTime\":\"2022-03-03 14:29:39\",\"id\":\"a27f81e76e444af3b2697a0e34973f35\",\"limit\":10,\"name\":\"2\",\"orderNum\":\"2\",\"page\":1,\"pid\":\"72dc221d76ae43b9a8777e53da99d53c\",\"status\":\"0\",\"type\":\"2\",\"urlWeb\":\"2\"}]', '192.168.0.124', '2022-03-03 14:29:39', 0);
INSERT INTO `sys_log` VALUES ('cc0ce051-51e1-490f-b664-ceff932b3192', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '0:0:0:0:0:0:0:1', '2022-04-14 18:19:40', 1);
INSERT INTO `sys_log` VALUES ('ccf2e42f-b08c-415c-9ce8-23f6e2ccfb4f', '4acf530555284c03a558c0f768444363', 'admin', '附件信息表-更新附件信息表', 0, 'com.example.frame.controller.PublicAttachementController.update()', '[{\"fjdl\":\"导入导出模板\",\"tempPath\":\"temp/fb71b9d0ac014a54722f9476a84e9da2.txt\",\"ysmc\":\"20220214114454-04f659134f46465aa16abd381875aec8.txt\",\"id\":\"a690688d4b514de38856ee00d547d5ba\",\"fjlx\":\"生命体征导入导出模板\"}]', '192.168.0.124', '2022-02-15 09:44:35', 0);
INSERT INTO `sys_log` VALUES ('cf64a562-b376-4d5a-9a19-982efc4c8b9e', '4acf530555284c03a558c0f768444363', 'admin', '系统权限-删除系统权限', 0, 'com.example.frame.controller.SysPermissionController.delete()', '[\"72dc221d76ae43b9a8777e53da99d53c\"]', '192.168.0.124', '2022-03-03 14:30:42', 0);
INSERT INTO `sys_log` VALUES ('d19d4aff-87b5-4938-8f8d-0b35685c72da', '4acf530555284c03a558c0f768444363', 'admin', 'ip黑名单记录表-删除ip黑名单记录表', 0, 'com.example.frame.controller.IpBlacklistInfoController.delete()', '[[\"ed4e9b5b1b7f4e5b93bd5216be7a31ca\"]]', '192.168.0.124', '2022-07-27 15:05:27', 0);
INSERT INTO `sys_log` VALUES ('d96c0e91-7b2d-4bcb-a361-a4a6fadeff5b', '4acf530555284c03a558c0f768444363', 'admin', '系统角色-更新系统角色', 0, 'com.example.frame.controller.SysRoleController.update()', '[{\"description\":\"拥有所有权限-不能删除\",\"id\":\"11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9\",\"limit\":10,\"name\":\"超级管理员\",\"page\":1,\"permissionList\":[null,null,null,null,\"088c12320dba460f95ddf52d94bd939b\",\"1026b0e03be14c1ca036ec106d0ec660\",\"4d1555b2e7bf406a91c5713bba13c054\",\"afff2ee8740347cd9aee391307ee6b78\",\"c5af6608d7cf47e0aa57d53ec59e34b6\",\"c5b3d43f56ee40f0b1724fa88935621c\",\"c7dcb23bcf924ce9a1efac91d780b7d2\",\"0e0da70f159b4115b3bbb9731733743f\",\"18254d278201405982cbca7670c48bda\",\"211fedbb1cea47ed8edf30c266ca5282\",\"6b3310e94046485db87ed04f2f5e610e\",\"8813764db7b34dc2ad515ba5b66201e4\",\"bfd6b1d63bbb4b4598652ac09565759f\",\"2971f3d710df48e99fc4b19dfc747266\",\"68f96e445930404788977ea2acdd23d1\",\"7348a6ab4be546c8a66758ce2d23795b\",\"d983d01037f14440a0633e8bec882b55\",\"f4409af657d84910a3d2aa03008f14e8\",\"03e4758110a04f589b80110501fdd34d\",\"3befc6ab26234076947dbc4a3558a627\",\"334af23eb2404398a615aeb09ee0dfbc\",\"527e91eabbb8445db77757fc51cb7131\",\"b7fd20301ba545d8bce51be32d975869\",\"bef54ec653d64a78862b81f5dd48afdb\",\"ca50d2174b0c42c9824f773ac8c0f275\",\"d337a26d47284eb48c6a877b81f52ab1\",\"0a261fae6d264d99adb12711c67e1dc5\",\"722ae34c8c97410eb15aaa3e1bd3910c\",\"78b50f83d6bd41329c5dc425641d7ade\",\"7f377771184a42a98306ddf92a98b86c\",\"a6e0e8483735498fbaa2d26106ffaa49\",\"c45a2629a8514ff4a33ea3cb1174c7ec\",\"d4a8758c3da34e30827757cc61e7cde4\",\"dc84e16c24784f5fa935491b9d2bcacd\",\"2617ef912c564eb58f6aaf89520e3241\",\"ecd2cb371eb34e279efa683488716b88\",\"2861b2b1fc274cd79c43a3dda67cb628\",\"60abd7273f0743908097160b769a3e66\",\"e45de716281c4d859bf612fa41684a44\",\"e698271183e84ec3ae309d027468d3dc\",\"fb4de75a56574f86b7f455fb7e8de7cf\",\"17e5599a62ea439dac746b7118cd0041\",\"24d07d9dcae341e8b36f94d4e2650144\",\"4c8da359f254448e943a33cbaae383c4\",\"50103e8963e746d89ef7817b1cf31241\",\"94eafc7b0e1444a6bbf3f4ea52b99368\",\"b3f9ada00bac47e1a4897b31dea9bb43\",\"db40bbb647ff45f1aa7661777b1d0134\",\"f4d97a7bed404563bd982521d2585900\",\"157c5429d1214839902f65e05e939d29\",\"fd68e0ad5498491688a8790f21c11b98\",\"044f9b38d0dd4180a331b927aa9ffe6d\",\"0f80790e9294448fb29a8ea03c4ac7d2\",\"2ecf9b08451346469916a7495015fbaa\",\"40100f3655754e63a1c55a7a550625ba\",\"5a6e9e8b3b584064a583b4e731cdfd18\",\"b2c0de1721e844e5aad22f72555a9017\",\"eead81c82ab5420e84fe687a6cdb240a\",\"2f403f52fc444046b2c1ebc37428d69c\",\"5163e43a13c64537aaf0d50aa7572cc3\",\"65e0683e9184433daa79a66753759b79\",\"c64e29f27dd14849a1443616c9eaa553\",\"db695d59536e4569a355258bc5f94394\",\"dd48635abaaf4709b73c04dc330be6b1\",\"1733d590018a4300bdcb42d2a773e451\",\"1e9272e8175d4c3b948168f136c2b964\",\"1f6aa9c01bdc41d2b456e6186ed1856c\",\"a3d3ae69d4a04044b08afdb1c058a5da\",\"db49860eba2345f481487e7f7a8151a0\",\"f384e2659e824023b95f35d1bd84d4c9\",\"461c3e77a65342e2b1995d1f3dfc9164\",\"ca32759beb8642128be161b7d0dd433f\",\"d5ebfb1c58ae4ffd9f45a20c77b7f260\",\"d605bd09b6114764a951e0cbc09ebd98\",\"ec057d2c988b4418b2f07b311271581c\",\"f46b4c4b77ad489c81a374d72fc39c8f\",\"f598cd2134dc4358949fb6c68ed6471e\",\"0c1efedee7f747098b6efa2fbf8747a3\",\"70355a9577d746d4a33fa2342ac15a84\",\"adc5cd2824884d14bbb9bca2fac0af3c\",\"affd7aa0cc89493f9c03f944b85ac466\",\"e72a1ef3ee86439c90f4fc87e02d0043\",\"f7ea304bfd394835aec3b482a9b9404b\",\"20edaccce184448fa24f15aa2759b3d1\",\"2f565daf1bee4b459cdb94bb26a06572\",\"75e65c63cf704612a836e52baa2978a6\",\"8418b9af3d72471e9edc142c98f1baea\",\"865fa70c88cb457bbce66ae69f0d5dbf\",\"885ef99a74ea454b881aeb8220c5220a\",\"a0b26dd5395c432da2ba54b5d6a7fb3f\",\"0dfc1a45c1a04cdd9ac810ce64c4afbb\",\"407365d273034590b24c357ae63cd296\",\"46a453d5175649a0819b1add7ffb774d\",\"84d1d3e8833542f3994decbd87936eec\",\"93f7aba124814e2694e6e11df2bcc9a5\",\"a68f8a96a5164cd1a8ab55454681cc84\",\"1cf1aacdcab14c218ae9be077239407f\",\"344d930c397749beb2db9f354fa0e281\",\"421a8ae169934a1eb307984f8526c3a0\",\"9c18d11cd68047269284f9aa34427060\",\"a265636a0763423d8f81be63f25f0a29\",\"e0270568d0804cf6a8f885c88b0b7e7b\"],\"status\":\"1\",\"updateTime\":\"2022-03-03 11:55:06\"}]', '192.168.0.124', '2022-03-03 11:55:06', 0);
INSERT INTO `sys_log` VALUES ('dc79f915-aad9-4451-9625-2a43f4294655', '4acf530555284c03a558c0f768444363', 'admin', '系统访问地区白名单-新增系统访问地区白名单', 0, 'com.example.frame.controller.WhiteRegionInfoController.add()', '[{\"city\":\"珠海市\",\"createTime\":\"2022-03-01 17:30:27\",\"id\":\"d4aa9ff83a9e4576bdf68e8230a3ca9a\",\"limit\":10,\"page\":1,\"region\":\"广东省\",\"syncTime\":\"1646127027593\"}]', '192.168.0.124', '2022-03-01 17:30:27', 0);
INSERT INTO `sys_log` VALUES ('de606d51-cc72-4f20-9786-27784096ee46', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.124', '2022-03-01 17:45:58', 1);
INSERT INTO `sys_log` VALUES ('de746f0f-575f-44a5-bbcc-2bee21466bf2', '4acf530555284c03a558c0f768444363', 'admin', '附件上传-附件上传', 0, 'com.example.frame.controller.FileController.uploadFile()', NULL, '192.168.0.124', '2022-02-15 09:46:16', 0);
INSERT INTO `sys_log` VALUES ('df69a7e0-0524-4446-a968-e3838cdc8990', '4acf530555284c03a558c0f768444363', 'admin', '系统权限-删除系统权限', 0, 'com.example.frame.controller.SysPermissionController.delete()', '[\"2f1e10a368c3420da7efb9e28f9dcd89\"]', '192.168.0.124', '2022-03-03 14:25:52', 0);
INSERT INTO `sys_log` VALUES ('e0bb82ed-b1a4-4f9e-8ea3-3cc94cbdaa0a', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.124', '2022-03-03 09:55:58', 1);
INSERT INTO `sys_log` VALUES ('e0bd85bc-411c-42cd-8d20-b5700f61b567', '4acf530555284c03a558c0f768444363', 'admin', '字典数据表-删除字典数据表', 0, 'com.example.frame.controller.SysDictDataController.delete()', '[[\"56c238c1413f4d7d8b7955d95f3b3775\"]]', '192.168.0.124', '2022-02-15 09:18:44', 0);
INSERT INTO `sys_log` VALUES ('e25bced8-14d0-4fde-ba44-fbea8e64d36f', '4acf530555284c03a558c0f768444363', 'admin', '系统角色-更新系统角色', 0, 'com.example.frame.controller.SysRoleController.update()', '[{\"description\":\"恩恩1\",\"id\":\"cd39c25627cc4e1f9200a2d7cb432735\",\"limit\":10,\"name\":\"区管理员\",\"page\":1,\"permissionList\":[\"088c12320dba460f95ddf52d94bd939b\",\"1026b0e03be14c1ca036ec106d0ec660\",\"4d1555b2e7bf406a91c5713bba13c054\",\"afff2ee8740347cd9aee391307ee6b78\",\"c5af6608d7cf47e0aa57d53ec59e34b6\",\"c5b3d43f56ee40f0b1724fa88935621c\",\"c7dcb23bcf924ce9a1efac91d780b7d2\",\"0e0da70f159b4115b3bbb9731733743f\",\"18254d278201405982cbca7670c48bda\",\"211fedbb1cea47ed8edf30c266ca5282\",\"6b3310e94046485db87ed04f2f5e610e\",\"8813764db7b34dc2ad515ba5b66201e4\",\"bfd6b1d63bbb4b4598652ac09565759f\",\"2971f3d710df48e99fc4b19dfc747266\",\"68f96e445930404788977ea2acdd23d1\",\"7348a6ab4be546c8a66758ce2d23795b\",\"d983d01037f14440a0633e8bec882b55\",\"f4409af657d84910a3d2aa03008f14e8\",\"03e4758110a04f589b80110501fdd34d\",\"3befc6ab26234076947dbc4a3558a627\",\"334af23eb2404398a615aeb09ee0dfbc\",\"527e91eabbb8445db77757fc51cb7131\",\"b7fd20301ba545d8bce51be32d975869\",\"bef54ec653d64a78862b81f5dd48afdb\",\"ca50d2174b0c42c9824f773ac8c0f275\",\"d337a26d47284eb48c6a877b81f52ab1\",\"0a261fae6d264d99adb12711c67e1dc5\",\"722ae34c8c97410eb15aaa3e1bd3910c\",\"78b50f83d6bd41329c5dc425641d7ade\",\"7f377771184a42a98306ddf92a98b86c\",\"a6e0e8483735498fbaa2d26106ffaa49\",\"c45a2629a8514ff4a33ea3cb1174c7ec\",\"d4a8758c3da34e30827757cc61e7cde4\",\"dc84e16c24784f5fa935491b9d2bcacd\",\"ee07e8c52a18422195cb02e86cf1855b\",\"032d03ca6fa949ad89db06ae2d29a80a\",\"0ba0b79f95874a1a88a9010651e33f57\",\"8502660955264d94b7122be852c797c6\",\"98ff03cfd4724f8f96498ca2cb3bf758\",\"ac11e15a148142acbb47b62db1439c4a\",\"d0261441a42a4a148178aa3aaf048c36\",\"2617ef912c564eb58f6aaf89520e3241\",\"ecd2cb371eb34e279efa683488716b88\",\"2861b2b1fc274cd79c43a3dda67cb628\",\"60abd7273f0743908097160b769a3e66\",\"e45de716281c4d859bf612fa41684a44\",\"e698271183e84ec3ae309d027468d3dc\",\"fb4de75a56574f86b7f455fb7e8de7cf\",\"17e5599a62ea439dac746b7118cd0041\",\"24d07d9dcae341e8b36f94d4e2650144\",\"4c8da359f254448e943a33cbaae383c4\",\"50103e8963e746d89ef7817b1cf31241\",\"94eafc7b0e1444a6bbf3f4ea52b99368\",\"b3f9ada00bac47e1a4897b31dea9bb43\",\"db40bbb647ff45f1aa7661777b1d0134\",\"f4d97a7bed404563bd982521d2585900\",\"157c5429d1214839902f65e05e939d29\",\"fd68e0ad5498491688a8790f21c11b98\",\"044f9b38d0dd4180a331b927aa9ffe6d\",\"0f80790e9294448fb29a8ea03c4ac7d2\",\"2ecf9b08451346469916a7495015fbaa\",\"40100f3655754e63a1c55a7a550625ba\",\"5a6e9e8b3b584064a583b4e731cdfd18\",\"b2c0de1721e844e5aad22f72555a9017\",\"eead81c82ab5420e84fe687a6cdb240a\",\"2f403f52fc444046b2c1ebc37428d69c\",\"5163e43a13c64537aaf0d50aa7572cc3\",\"65e0683e9184433daa79a66753759b79\",\"c64e29f27dd14849a1443616c9eaa553\",\"db695d59536e4569a355258bc5f94394\",\"dd48635abaaf4709b73c04dc330be6b1\",\"1733d590018a4300bdcb42d2a773e451\",\"1e9272e8175d4c3b948168f136c2b964\",\"1f6aa9c01bdc41d2b456e6186ed1856c\",\"a3d3ae69d4a04044b08afdb1c058a5da\",\"db49860eba2345f481487e7f7a8151a0\",\"f384e2659e824023b95f35d1bd84d4c9\",\"461c3e77a65342e2b1995d1f3dfc9164\",\"ca32759beb8642128be161b7d0dd433f\",\"d5ebfb1c58ae4ffd9f45a20c77b7f260\",\"d605bd09b6114764a951e0cbc09ebd98\",\"ec057d2c988b4418b2f07b311271581c\",\"f46b4c4b77ad489c81a374d72fc39c8f\",\"f598cd2134dc4358949fb6c68ed6471e\",\"0c1efedee7f747098b6efa2fbf8747a3\",\"70355a9577d746d4a33fa2342ac15a84\",\"adc5cd2824884d14bbb9bca2fac0af3c\",\"affd7aa0cc89493f9c03f944b85ac466\",\"e72a1ef3ee86439c90f4fc87e02d0043\",\"f7ea304bfd394835aec3b482a9b9404b\",\"20edaccce184448fa24f15aa2759b3d1\",\"2f565daf1bee4b459cdb94bb26a06572\",\"75e65c63cf704612a836e52baa2978a6\",\"8418b9af3d72471e9edc142c98f1baea\",\"865fa70c88cb457bbce66ae69f0d5dbf\",\"885ef99a74ea454b881aeb8220c5220a\",\"a0b26dd5395c432da2ba54b5d6a7fb3f\",\"0dfc1a45c1a04cdd9ac810ce64c4afbb\",\"407365d273034590b24c357ae63cd296\",\"46a453d5175649a0819b1add7ffb774d\",\"84d1d3e8833542f3994decbd87936eec\",\"93f7aba124814e2694e6e11df2bcc9a5\",\"a68f8a96a5164cd1a8ab55454681cc84\",\"1cf1aacdcab14c218ae9be077239407f\",\"344d930c397749beb2db9f354fa0e281\",\"421a8ae169934a1eb307984f8526c3a0\",\"9c18d11cd68047269284f9aa34427060\",\"a265636a0763423d8f81be63f25f0a29\",\"e0270568d0804cf6a8f885c88b0b7e7b\"],\"status\":\"1\",\"updateTime\":\"2022-04-18 09:34:28\"}]', '0:0:0:0:0:0:0:1', '2022-04-18 09:34:28', 0);
INSERT INTO `sys_log` VALUES ('e5a67344-0766-4306-97a5-39ff028ed2c9', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.124', '2022-03-01 17:01:59', 1);
INSERT INTO `sys_log` VALUES ('e6d002f5-3658-4249-b3ff-b59f7414d6c9', '4acf530555284c03a558c0f768444363', 'admin', '系统权限-删除系统权限', 0, 'com.example.frame.controller.SysPermissionController.delete()', '[\"5bf0075397774aff8fb2e010e10f388e\"]', '192.168.0.124', '2022-03-03 14:25:49', 0);
INSERT INTO `sys_log` VALUES ('ea07845f-bc50-42d8-a978-6763b9ddfbcb', '4acf530555284c03a558c0f768444363', 'admin', '系统权限-更新系统权限', 0, 'com.example.frame.controller.SysPermissionController.update()', '[{\"id\":\"270a28c3d58343348353455d32fc2c55\",\"limit\":10,\"name\":\"1\",\"orderNum\":\"1\",\"page\":1,\"pid\":\"0\",\"status\":\"0\",\"type\":\"2\",\"updateTime\":\"2022-03-03 14:23:48\",\"urlWeb\":\"1\"}]', '192.168.0.124', '2022-03-03 14:23:48', 0);
INSERT INTO `sys_log` VALUES ('ea64e75b-cd13-435a-88fe-c63f1ef89584', '4acf530555284c03a558c0f768444363', 'admin', '系统权限-新增系统权限', 0, 'com.example.frame.controller.SysPermissionController.add()', '[{\"createTime\":\"2022-03-03 14:25:56\",\"id\":\"268e433a73db4980bcf2bd385e968ab8\",\"limit\":10,\"name\":\"1\",\"orderNum\":\"1\",\"page\":1,\"pid\":\"0\",\"status\":\"0\",\"type\":\"1\",\"urlWeb\":\"1\"}]', '192.168.0.124', '2022-03-03 14:25:56', 0);
INSERT INTO `sys_log` VALUES ('ebabaf7f-a9eb-4397-82ed-afd3c1051467', '4acf530555284c03a558c0f768444363', 'admin', 'sql注入-sql注入', 0, 'com.example.frame.controller.SqlInjectionController.sqlInjection()', '[\"select * from public_attachement\"]', '192.168.0.109', '2022-01-04 11:20:38', 0);
INSERT INTO `sys_log` VALUES ('ec85b169-b910-47ee-9193-575dafdcca5e', '4acf530555284c03a558c0f768444363', 'admin', 'sql注入-sql注入', 0, 'com.example.frame.controller.SqlInjectionController.sqlInjection()', '[\"select * from qrtz_scheduler_state\"]', '192.168.0.109', '2022-01-04 11:20:36', 0);
INSERT INTO `sys_log` VALUES ('ef0caf28-4937-4a4c-8463-35d3cefed813', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.124', '2022-07-27 14:12:21', 1);
INSERT INTO `sys_log` VALUES ('f70dc3bd-fcc7-4eec-9540-9f1a38682c53', '4acf530555284c03a558c0f768444363', 'admin', '系统角色-更新系统角色', 0, 'com.example.frame.controller.SysRoleController.update()', '[{\"description\":\"拥有所有权限-不能删除\",\"id\":\"11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9\",\"limit\":10,\"name\":\"超级管理员\",\"page\":1,\"permissionList\":[\"cbd0f7faa72e49efbfdc094e078b11bf\",\"4e6f9c62dd2a415881cff9108de07e0b\"],\"status\":\"1\",\"updateTime\":\"2022-03-03 15:39:14\"}]', '192.168.0.124', '2022-03-03 15:39:14', 0);
INSERT INTO `sys_log` VALUES ('f8856867-679f-4413-a881-1774aa69c296', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.124', '2022-03-01 15:13:14', 1);
INSERT INTO `sys_log` VALUES ('f9730298-3f95-4948-ac4b-5a3f8258409d', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '0:0:0:0:0:0:0:1', '2022-04-16 09:47:07', 1);
INSERT INTO `sys_log` VALUES ('fd0e3db6-7b2d-4d30-ba32-0d59515db448', '4acf530555284c03a558c0f768444363', 'admin', '系统权限-新增系统权限', 0, 'com.example.frame.controller.SysPermissionController.add()', '[{\"createTime\":\"2022-03-03 14:29:07\",\"id\":\"72dc221d76ae43b9a8777e53da99d53c\",\"limit\":10,\"name\":\"1\",\"orderNum\":\"1\",\"page\":1,\"pid\":\"0\",\"status\":\"0\",\"type\":\"1\",\"urlWeb\":\"1\"}]', '192.168.0.124', '2022-03-03 14:29:07', 0);
INSERT INTO `sys_log` VALUES ('fd2a1031-d5bc-4fdc-a37b-c9858093e6c0', '4acf530555284c03a558c0f768444363', 'admin', 'ip黑名单记录表-新增ip黑名单记录表', 0, 'com.example.frame.controller.IpBlacklistInfoController.add()', '[{\"createTime\":\"2022-04-06 14:34:25\",\"effectiveTime\":\"-1\",\"id\":\"7f8fa3ca33c5484fa614640df3619e0f\",\"ip\":\"192.168.0.124\",\"limit\":10,\"mapping\":\"*\",\"page\":1,\"syncTime\":\"1649226865920\",\"type\":\"1\"}]', '192.168.0.124', '2022-04-06 14:34:25', 0);
INSERT INTO `sys_log` VALUES ('fddd96d6-6a2a-4cb9-9abc-5b68493b9fe8', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.104', '2022-01-27 16:47:49', 1);
INSERT INTO `sys_log` VALUES ('ff290625-e852-4781-bdf2-53d578c29394', '4acf530555284c03a558c0f768444363', 'admin', '系统权限-新增系统权限', 0, 'com.example.frame.controller.SysPermissionController.add()', '[{\"createTime\":\"2022-03-03 14:24:52\",\"id\":\"cfff617b6f6444fda7853cdd6ab0c4b6\",\"limit\":10,\"name\":\"22\",\"orderNum\":\"22\",\"page\":1,\"pid\":\"0\",\"status\":\"0\",\"type\":\"2\",\"urlWeb\":\"22\"}]', '192.168.0.124', '2022-03-03 14:24:52', 0);
INSERT INTO `sys_log` VALUES ('ffd384d7-4950-42a0-b30e-d63401013d18', '4acf530555284c03a558c0f768444363', 'admin', '用户管理-登录', 0, 'com.example.frame.controller.SysUserController.login()', '[{\"password\":\"111111\",\"type\":\"2\",\"username\":\"admin\"}]', '192.168.0.124', '2022-03-02 11:59:36', 1);

-- ----------------------------
-- Table structure for sys_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_permission`;
CREATE TABLE `sys_permission`  (
  `ID` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `CODE` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单权限编码',
  `NAME` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单权限名称',
  `PERMS` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '授权(多个用逗号分隔，如：SYS:USER:ADD,SYS:USER:EDIT)',
  `URL` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '访问地址URL',
  `METHOD` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资源请求类型',
  `PID` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父级菜单权限名称',
  `ORDER_NUM` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '排序',
  `TYPE` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单权限类型(1:目录;2:菜单;3:按钮)',
  `STATUS` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态1:正常 0：禁用',
  `CREATE_TIME` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建时间',
  `UPDATE_TIME` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新时间',
  `DELETED` int(0) NULL DEFAULT NULL COMMENT '是否删除(1未删除；0已删除)',
  `URL_WEB` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '前端URL',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统权限' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_permission
-- ----------------------------
INSERT INTO `sys_permission` VALUES ('032d03ca6fa949ad89db06ae2d29a80a', NULL, '更新', 'testtest-update', '/testtest/update', 'PUT', '6235a798ff744900b88df0cded720770', NULL, '3', '1', '2021-11-12 17:09:03', '2021-11-12 17:25:28', 0, NULL);
INSERT INTO `sys_permission` VALUES ('03e4758110a04f589b80110501fdd34d', NULL, '附件上传', 'file-upload', '/file/upload', 'POST', '20819f14279346ec82bfd88b0053b148', NULL, '3', '1', '2022-02-15 09:36:54', '2022-07-28 15:29:51', 0, NULL);
INSERT INTO `sys_permission` VALUES ('044f9b38d0dd4180a331b927aa9ffe6d', NULL, '新增任务', 'job-add', '/job/add', 'POST', '9a1647856ce84a07a520ba9022412250', NULL, '3', '1', '2021-11-12 15:51:22', '2022-07-28 15:29:51', 0, NULL);
INSERT INTO `sys_permission` VALUES ('05e98272559947018f0fb07787aee029', NULL, '用户登录账号表', NULL, NULL, NULL, '0', NULL, '3', '1', '2021-11-04 17:35:23', NULL, 0, NULL);
INSERT INTO `sys_permission` VALUES ('088c12320dba460f95ddf52d94bd939b', NULL, '锁定用户', 'sysUserLogin-lockUser', '/sysUserLogin/lockUser', 'POST', '05e98272559947018f0fb07787aee029', NULL, '3', '1', '2021-12-18 10:29:35', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('096ca24cadb94aa6a03fe9e9cd8f6f14', NULL, '配置-1', NULL, NULL, NULL, 'cbd0f7faa72e49efbfdc094e078b11bf', '0', '2', '0', '2022-03-03 14:31:36', NULL, NULL, '/pz1');
INSERT INTO `sys_permission` VALUES ('0a261fae6d264d99adb12711c67e1dc5', NULL, '根据id查询单条系统访问地区白名单数据', 'whiteRegionInfo-listById', '/whiteRegionInfo/listById', 'POST', '50a832df8e7d42b396477d31acd1efd7', NULL, '3', '1', '2022-03-01 17:01:54', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('0ba0b79f95874a1a88a9010651e33f57', NULL, '查询分页数据', 'testtest-listByPage', '/testtest/listByPage', 'POST', '6235a798ff744900b88df0cded720770', NULL, '3', '1', '2021-11-12 17:09:03', '2021-11-12 17:25:28', 0, NULL);
INSERT INTO `sys_permission` VALUES ('0c1efedee7f747098b6efa2fbf8747a3', NULL, '删除系统用户角色', 'sysUserRole-delete', '/sysUserRole/delete', 'DELETE', 'c9e7993fc6a34383af30568b940657fb', NULL, '3', '1', '2021-11-04 17:35:23', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('0dfc1a45c1a04cdd9ac810ce64c4afbb', NULL, '新增字典类型表', 'sysDictType-add', '/sysDictType/add', 'POST', 'f343c49108aa4c798e16250b3385c0d8', NULL, '3', '1', '2021-11-04 17:35:22', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('0e0da70f159b4115b3bbb9731733743f', NULL, '根据id查询单条系统角色数据', 'sysRole-listById', '/sysRole/listById', 'POST', '128e88875fe042ab8fdc205339334371', NULL, '3', '1', '2021-11-04 17:35:22', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('0f80790e9294448fb29a8ea03c4ac7d2', NULL, '分页获取信息接口', 'job-listByPage', '/job/listByPage', 'POST', '9a1647856ce84a07a520ba9022412250', NULL, '3', '1', '2021-11-12 15:51:22', '2022-07-28 15:29:51', 0, NULL);
INSERT INTO `sys_permission` VALUES ('1026b0e03be14c1ca036ec106d0ec660', NULL, '删除用户登录账号表', 'sysUserLogin-delete', '/sysUserLogin/delete', 'DELETE', '05e98272559947018f0fb07787aee029', NULL, '3', '1', '2021-11-12 15:51:23', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('128e88875fe042ab8fdc205339334371', NULL, '系统角色', NULL, NULL, NULL, '0', NULL, '3', '1', '2021-11-04 17:35:22', NULL, 0, NULL);
INSERT INTO `sys_permission` VALUES ('157c5429d1214839902f65e05e939d29', NULL, '查询所有表格', 'sqlInjection-table', '/sqlInjection/selectAllTable', 'POST', '9466f2aa0c7e47069c7cc2e956bd0411', NULL, '3', '1', '2021-12-14 10:32:21', '2022-07-28 15:29:51', 0, NULL);
INSERT INTO `sys_permission` VALUES ('1733d590018a4300bdcb42d2a773e451', NULL, '新增系统角色权限', 'sysRolePermission-add', '/sysRolePermission/add', 'POST', 'b9b6c506c19a47418c6df56b207fb1f0', NULL, '3', '1', '2021-11-04 17:35:22', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('17e5599a62ea439dac746b7118cd0041', NULL, '更新ip黑名单记录表', 'ipBlacklistInfo-update', '/ipBlacklistInfo/update', 'PUT', '81bc4ae4383f4882907ca26b6634332c', NULL, '3', '1', '2022-02-16 09:24:40', '2022-07-28 15:29:51', 0, NULL);
INSERT INTO `sys_permission` VALUES ('18254d278201405982cbca7670c48bda', NULL, '查询系统角色分页数据', 'sysRole-listByPage', '/sysRole/listByPage', 'POST', '128e88875fe042ab8fdc205339334371', NULL, '3', '1', '2021-11-04 17:35:22', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('1cf1aacdcab14c218ae9be077239407f', NULL, '查询用户单位中间表分页数据', 'sysUserCompany-listByPage', '/sysUserCompany/listByPage', 'POST', 'fb468f143915460babd3eb7ac80ba9fd', NULL, '3', '1', '2021-12-18 13:02:01', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('1d343d24f36b4f7ca59d5f0620c0b5f0', NULL, '拦截异常日志表', NULL, NULL, NULL, '0', NULL, '3', '1', '2021-11-04 17:35:22', NULL, 0, NULL);
INSERT INTO `sys_permission` VALUES ('1e9272e8175d4c3b948168f136c2b964', NULL, '根据条件查询List数据', 'sysRolePermission-listByCondition', '/sysRolePermission/listByCondition', 'POST', 'b9b6c506c19a47418c6df56b207fb1f0', NULL, '3', '1', '2021-11-04 17:52:41', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('1f6aa9c01bdc41d2b456e6186ed1856c', NULL, '更新系统角色权限', 'sysRolePermission-update', '/sysRolePermission/update', 'PUT', 'b9b6c506c19a47418c6df56b207fb1f0', NULL, '3', '1', '2021-11-04 17:35:22', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('20819f14279346ec82bfd88b0053b148', NULL, '文件上传下载', NULL, NULL, NULL, '0', NULL, '3', '1', '2022-02-15 09:36:54', NULL, 0, NULL);
INSERT INTO `sys_permission` VALUES ('20edaccce184448fa24f15aa2759b3d1', NULL, '查询系统权限树数据', 'sysPermission-listByTree', '/sysPermission/listByTree', 'POST', 'efd4142f6851489dbf68320f6e8b0f47', NULL, '3', '1', '2021-11-04 17:52:41', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('211fedbb1cea47ed8edf30c266ca5282', NULL, '根据条件查询系统角色List数据', 'sysRole-listByCondition', '/sysRole/listByCondition', 'POST', '128e88875fe042ab8fdc205339334371', NULL, '3', '1', '2021-11-10 16:21:50', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('24d07d9dcae341e8b36f94d4e2650144', NULL, '查询ip黑名单记录表分页数据', 'ipBlacklistInfo-listByPage', '/ipBlacklistInfo/listByPage', 'POST', '81bc4ae4383f4882907ca26b6634332c', NULL, '3', '1', '2022-02-16 09:24:40', '2022-07-28 15:29:51', 0, NULL);
INSERT INTO `sys_permission` VALUES ('2617ef912c564eb58f6aaf89520e3241', NULL, '删除日志接口', 'sysLog-logs', '/sysLog/logs', 'DELETE', '662bd6ab4a0b46008d8ab5c651a06c0f', NULL, '3', '1', '2021-11-12 15:51:23', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('2861b2b1fc274cd79c43a3dda67cb628', NULL, '根据id查询单条字典数据表数据', 'sysDictData-listById', '/sysDictData/listById', 'POST', '6b389c32a71b4948a29c57f6cb3cde26', NULL, '3', '1', '2021-11-04 17:35:22', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('2971f3d710df48e99fc4b19dfc747266', NULL, '根据id查询单条拦截异常日志表数据', 'sysInterceptLog-listById', '/sysInterceptLog/listById', 'POST', '1d343d24f36b4f7ca59d5f0620c0b5f0', NULL, '3', '1', '2021-11-12 15:51:22', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('2ecf9b08451346469916a7495015fbaa', NULL, '恢复任务接口', 'job-resume', '/job/resume', 'POST', '9a1647856ce84a07a520ba9022412250', NULL, '3', '1', '2021-11-12 15:51:22', '2022-07-28 15:29:51', 0, NULL);
INSERT INTO `sys_permission` VALUES ('2f403f52fc444046b2c1ebc37428d69c', NULL, '根据条件查询附件信息表List数据', 'publicAttachement-listByCondition', '/publicAttachement/listByCondition', 'POST', 'b45acf9df7e442bb85550e958c1d6e2f', NULL, '3', '1', '2021-12-18 14:51:03', '2022-07-28 15:29:51', 0, NULL);
INSERT INTO `sys_permission` VALUES ('2f565daf1bee4b459cdb94bb26a06572', NULL, '删除系统权限', 'sysPermission-delete', '/sysPermission/delete', 'DELETE', 'efd4142f6851489dbf68320f6e8b0f47', NULL, '3', '1', '2021-11-04 17:52:41', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('334af23eb2404398a615aeb09ee0dfbc', NULL, '根据条件查询树形数据List数据', 'sysTreeData-listByCondition', '/sysTreeData/listByCondition', 'POST', '3b2c6ab28a17427ea1322976cd9f8b86', NULL, '3', '1', '2021-11-05 14:46:36', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('344d930c397749beb2db9f354fa0e281', NULL, '删除用户单位中间表', 'sysUserCompany-delete', '/sysUserCompany/delete', 'DELETE', 'fb468f143915460babd3eb7ac80ba9fd', NULL, '3', '1', '2021-12-18 13:02:01', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('3b2c6ab28a17427ea1322976cd9f8b86', NULL, '树形数据', NULL, NULL, NULL, '0', NULL, '3', '1', '2021-11-05 14:46:36', NULL, 0, NULL);
INSERT INTO `sys_permission` VALUES ('3befc6ab26234076947dbc4a3558a627', NULL, '查看（下载）附件', 'file-download', '/file/download', 'GET', '20819f14279346ec82bfd88b0053b148', NULL, '3', '1', '2022-02-15 09:36:54', '2022-07-28 15:29:51', 0, NULL);
INSERT INTO `sys_permission` VALUES ('40100f3655754e63a1c55a7a550625ba', NULL, '停止任务接口', 'job-pause', '/job/pause', 'POST', '9a1647856ce84a07a520ba9022412250', NULL, '3', '1', '2021-11-12 15:51:22', '2022-07-28 15:29:51', 0, NULL);
INSERT INTO `sys_permission` VALUES ('407365d273034590b24c357ae63cd296', NULL, '删除字典类型表', 'sysDictType-delete', '/sysDictType/delete', 'DELETE', 'f343c49108aa4c798e16250b3385c0d8', NULL, '3', '1', '2021-11-04 17:35:22', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('421a8ae169934a1eb307984f8526c3a0', NULL, '新增用户单位中间表', 'sysUserCompany-add', '/sysUserCompany/add', 'POST', 'fb468f143915460babd3eb7ac80ba9fd', NULL, '3', '1', '2021-12-18 13:02:01', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('461c3e77a65342e2b1995d1f3dfc9164', NULL, '更新系统用户', 'sysUser-update', '/sysUser/update', 'PUT', 'bff80ff5ca6d4eaf8059e3ea8d98f472', NULL, '3', '1', '2021-11-12 15:51:23', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('46a453d5175649a0819b1add7ffb774d', NULL, '更新字典类型表', 'sysDictType-update', '/sysDictType/update', 'PUT', 'f343c49108aa4c798e16250b3385c0d8', NULL, '3', '1', '2021-11-04 17:35:22', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('4c8da359f254448e943a33cbaae383c4', NULL, '删除ip黑名单记录表', 'ipBlacklistInfo-delete', '/ipBlacklistInfo/delete', 'DELETE', '81bc4ae4383f4882907ca26b6634332c', NULL, '3', '1', '2022-02-16 09:24:40', '2022-07-28 15:29:51', 0, NULL);
INSERT INTO `sys_permission` VALUES ('4d1555b2e7bf406a91c5713bba13c054', NULL, '查询用户登录账号表分页数据', 'sysUserLogin-listByPage', '/sysUserLogin/listByPage', 'POST', '05e98272559947018f0fb07787aee029', NULL, '3', '1', '2021-11-12 15:51:23', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('4e6f9c62dd2a415881cff9108de07e0b', NULL, '配置-2', NULL, NULL, NULL, 'cbd0f7faa72e49efbfdc094e078b11bf', '1', '2', '0', '2022-03-03 14:31:56', '2022-03-03 15:03:37', NULL, '/pz2');
INSERT INTO `sys_permission` VALUES ('50103e8963e746d89ef7817b1cf31241', NULL, '根据id查询单条ip黑名单记录表数据', 'ipBlacklistInfo-listById', '/ipBlacklistInfo/listById', 'POST', '81bc4ae4383f4882907ca26b6634332c', NULL, '3', '1', '2022-02-16 09:24:40', '2022-07-28 15:29:51', 0, NULL);
INSERT INTO `sys_permission` VALUES ('50a832df8e7d42b396477d31acd1efd7', NULL, '系统访问地区白名单', NULL, NULL, NULL, '0', NULL, '3', '1', '2022-03-01 17:01:54', NULL, 0, NULL);
INSERT INTO `sys_permission` VALUES ('5163e43a13c64537aaf0d50aa7572cc3', NULL, '新增附件信息表', 'publicAttachement-add', '/publicAttachement/add', 'POST', 'b45acf9df7e442bb85550e958c1d6e2f', NULL, '3', '1', '2021-12-18 14:51:03', '2022-07-28 15:29:51', 0, NULL);
INSERT INTO `sys_permission` VALUES ('527e91eabbb8445db77757fc51cb7131', NULL, '新增树形数据', 'sysTreeData-add', '/sysTreeData/add', 'POST', '3b2c6ab28a17427ea1322976cd9f8b86', NULL, '3', '1', '2021-11-05 14:46:36', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('5a6e9e8b3b584064a583b4e731cdfd18', NULL, '更新测试表', 'job-edit', '/job/edit', 'PUT', '9a1647856ce84a07a520ba9022412250', NULL, '3', '1', '2021-11-12 15:51:22', '2022-07-28 15:29:51', 0, NULL);
INSERT INTO `sys_permission` VALUES ('60abd7273f0743908097160b769a3e66', NULL, '新增字典数据表', 'sysDictData-add', '/sysDictData/add', 'POST', '6b389c32a71b4948a29c57f6cb3cde26', NULL, '3', '1', '2021-11-04 17:35:22', '2022-07-28 15:29:51', 0, NULL);
INSERT INTO `sys_permission` VALUES ('61aff301359f4089b1c6b7e629f73c10', NULL, 'websocke手动重启机制', NULL, NULL, NULL, '0', NULL, '3', '1', '2021-12-10 10:19:55', NULL, 0, NULL);
INSERT INTO `sys_permission` VALUES ('6235a798ff744900b88df0cded720770', NULL, '', NULL, NULL, NULL, '0', NULL, '3', '1', '2021-11-12 17:09:03', NULL, 0, NULL);
INSERT INTO `sys_permission` VALUES ('65e0683e9184433daa79a66753759b79', NULL, '查询附件信息表分页数据', 'publicAttachement-listByPage', '/publicAttachement/listByPage', 'POST', 'b45acf9df7e442bb85550e958c1d6e2f', NULL, '3', '1', '2021-12-18 14:51:03', '2022-07-28 15:29:51', 0, NULL);
INSERT INTO `sys_permission` VALUES ('662bd6ab4a0b46008d8ab5c651a06c0f', NULL, '系统日志', NULL, NULL, NULL, '0', NULL, '3', '1', '2021-11-04 17:35:22', NULL, 0, NULL);
INSERT INTO `sys_permission` VALUES ('68f96e445930404788977ea2acdd23d1', NULL, '查询拦截异常日志表分页数据', 'sysInterceptLog-listByPage', '/sysInterceptLog/listByPage', 'POST', '1d343d24f36b4f7ca59d5f0620c0b5f0', NULL, '3', '1', '2021-11-12 15:51:22', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('6b3310e94046485db87ed04f2f5e610e', NULL, '新增系统角色', 'sysRole-add', '/sysRole/add', 'POST', '128e88875fe042ab8fdc205339334371', NULL, '3', '1', '2021-11-04 17:35:22', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('6b389c32a71b4948a29c57f6cb3cde26', NULL, '字典数据表', NULL, NULL, NULL, '0', NULL, '3', '1', '2021-11-04 17:35:22', NULL, 0, NULL);
INSERT INTO `sys_permission` VALUES ('6c91aaf67d0341b2859b38c0eed28d00', NULL, '用户管理', NULL, NULL, NULL, '0', '1', '1', '0', '2022-03-03 14:31:04', NULL, NULL, '/user');
INSERT INTO `sys_permission` VALUES ('70355a9577d746d4a33fa2342ac15a84', NULL, '新增系统用户角色', 'sysUserRole-add', '/sysUserRole/add', 'POST', 'c9e7993fc6a34383af30568b940657fb', NULL, '3', '1', '2021-11-04 17:35:23', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('722ae34c8c97410eb15aaa3e1bd3910c', NULL, '删除系统访问地区白名单', 'whiteRegionInfo-delete', '/whiteRegionInfo/delete', 'DELETE', '50a832df8e7d42b396477d31acd1efd7', NULL, '3', '1', '2022-03-01 17:01:54', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('7348a6ab4be546c8a66758ce2d23795b', NULL, '更新拦截异常日志表', 'sysInterceptLog-update', '/sysInterceptLog/update', 'PUT', '1d343d24f36b4f7ca59d5f0620c0b5f0', NULL, '3', '1', '2021-11-12 15:51:22', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('75e65c63cf704612a836e52baa2978a6', NULL, '查询系统权限List数据', 'sysPermission-listByCondition', '/sysPermission/listByCondition', 'POST', 'efd4142f6851489dbf68320f6e8b0f47', NULL, '3', '1', '2021-11-04 17:52:41', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('78b50f83d6bd41329c5dc425641d7ade', NULL, '新增系统访问地区白名单', 'whiteRegionInfo-add', '/whiteRegionInfo/add', 'POST', '50a832df8e7d42b396477d31acd1efd7', NULL, '3', '1', '2022-03-01 17:01:54', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('7f377771184a42a98306ddf92a98b86c', NULL, '根据条件查询系统访问地区白名单List数据', 'whiteRegionInfo-listByCondition', '/whiteRegionInfo/listByCondition', 'POST', '50a832df8e7d42b396477d31acd1efd7', NULL, '3', '1', '2022-03-01 17:01:54', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('81bc4ae4383f4882907ca26b6634332c', NULL, 'ip黑名单记录表', NULL, NULL, NULL, '0', NULL, '3', '1', '2022-02-16 09:24:40', NULL, 0, NULL);
INSERT INTO `sys_permission` VALUES ('8418b9af3d72471e9edc142c98f1baea', NULL, '查询系统权限分页数据', 'sysPermission-listByPage', '/sysPermission/listByPage', 'POST', 'efd4142f6851489dbf68320f6e8b0f47', NULL, '3', '1', '2021-11-04 17:52:41', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('84d1d3e8833542f3994decbd87936eec', NULL, '查询字典类型表List数据', 'sysDictType-listByCondition', '/sysDictType/listByCondition', 'POST', 'f343c49108aa4c798e16250b3385c0d8', NULL, '3', '1', '2021-12-18 15:56:13', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('8502660955264d94b7122be852c797c6', NULL, '删除', 'testtest-delete', '/testtest/delete', 'DELETE', '6235a798ff744900b88df0cded720770', NULL, '3', '1', '2021-11-12 17:09:03', '2021-11-12 17:25:28', 0, NULL);
INSERT INTO `sys_permission` VALUES ('862160b3e613482abd9248eaabf7ed23', NULL, '代码生成表', NULL, NULL, NULL, '0', NULL, '3', '1', '2021-11-04 17:35:22', NULL, 0, NULL);
INSERT INTO `sys_permission` VALUES ('865fa70c88cb457bbce66ae69f0d5dbf', NULL, '根据id查询单条系统权限数据', 'sysPermission-listById', '/sysPermission/listById', 'POST', 'efd4142f6851489dbf68320f6e8b0f47', NULL, '3', '1', '2021-11-04 17:52:41', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('8813764db7b34dc2ad515ba5b66201e4', NULL, '更新系统角色', 'sysRole-update', '/sysRole/update', 'PUT', '128e88875fe042ab8fdc205339334371', NULL, '3', '1', '2021-11-04 17:35:22', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('885ef99a74ea454b881aeb8220c5220a', NULL, '新增系统权限', 'sysPermission-add', '/sysPermission/add', 'POST', 'efd4142f6851489dbf68320f6e8b0f47', NULL, '3', '1', '2021-11-04 17:52:41', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('93f7aba124814e2694e6e11df2bcc9a5', NULL, '查询字典类型表分页数据', 'sysDictType-listByPage', '/sysDictType/listByPage', 'POST', 'f343c49108aa4c798e16250b3385c0d8', NULL, '3', '1', '2021-11-04 17:35:22', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('9466f2aa0c7e47069c7cc2e956bd0411', NULL, 'sql注入操作', NULL, NULL, NULL, '0', NULL, '3', '1', '2021-12-10 15:21:29', NULL, 0, NULL);
INSERT INTO `sys_permission` VALUES ('94eafc7b0e1444a6bbf3f4ea52b99368', NULL, '根据条件查询ip黑名单记录表List数据', 'ipBlacklistInfo-listByCondition', '/ipBlacklistInfo/listByCondition', 'POST', '81bc4ae4383f4882907ca26b6634332c', NULL, '3', '1', '2022-02-16 09:24:40', '2022-07-28 15:29:51', 0, NULL);
INSERT INTO `sys_permission` VALUES ('98ff03cfd4724f8f96498ca2cb3bf758', NULL, '根据条件查询List数据', 'testtest-listByCondition', '/testtest/listByCondition', 'POST', '6235a798ff744900b88df0cded720770', NULL, '3', '1', '2021-11-12 17:09:03', '2021-11-12 17:25:28', 0, NULL);
INSERT INTO `sys_permission` VALUES ('9a1647856ce84a07a520ba9022412250', NULL, '任务调度', NULL, NULL, NULL, '0', NULL, '3', '1', '2021-11-04 17:35:22', NULL, 0, NULL);
INSERT INTO `sys_permission` VALUES ('9c18d11cd68047269284f9aa34427060', NULL, '根据id查询单条用户单位中间表数据', 'sysUserCompany-listById', '/sysUserCompany/listById', 'POST', 'fb468f143915460babd3eb7ac80ba9fd', NULL, '3', '1', '2021-12-18 13:02:01', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('a0b26dd5395c432da2ba54b5d6a7fb3f', NULL, '更新系统权限', 'sysPermission-update', '/sysPermission/update', 'PUT', 'efd4142f6851489dbf68320f6e8b0f47', NULL, '3', '1', '2021-11-04 17:52:41', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('a265636a0763423d8f81be63f25f0a29', NULL, '根据条件查询用户单位中间表List数据', 'sysUserCompany-listByCondition', '/sysUserCompany/listByCondition', 'POST', 'fb468f143915460babd3eb7ac80ba9fd', NULL, '3', '1', '2021-12-18 13:02:01', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('a3d3ae69d4a04044b08afdb1c058a5da', NULL, '根据id查询单条系统角色权限数据', 'sysRolePermission-listById', '/sysRolePermission/listById', 'POST', 'b9b6c506c19a47418c6df56b207fb1f0', NULL, '3', '1', '2021-11-04 17:35:23', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('a68f8a96a5164cd1a8ab55454681cc84', NULL, '根据id查询单条字典类型表数据', 'sysDictType-listById', '/sysDictType/listById', 'POST', 'f343c49108aa4c798e16250b3385c0d8', NULL, '3', '1', '2021-11-04 17:35:22', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('a6e0e8483735498fbaa2d26106ffaa49', NULL, '更新系统访问地区白名单', 'whiteRegionInfo-update', '/whiteRegionInfo/update', 'PUT', '50a832df8e7d42b396477d31acd1efd7', NULL, '3', '1', '2022-03-01 17:01:54', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('ac11e15a148142acbb47b62db1439c4a', NULL, '根据id查询单条数据', 'testtest-listById', '/testtest/listById', 'POST', '6235a798ff744900b88df0cded720770', NULL, '3', '1', '2021-11-12 17:09:03', '2021-11-12 17:25:28', 0, NULL);
INSERT INTO `sys_permission` VALUES ('adc5cd2824884d14bbb9bca2fac0af3c', NULL, '更新系统用户角色', 'sysUserRole-update', '/sysUserRole/update', 'PUT', 'c9e7993fc6a34383af30568b940657fb', NULL, '3', '1', '2021-11-04 17:35:23', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('affd7aa0cc89493f9c03f944b85ac466', NULL, '查询系统用户角色分页数据', 'sysUserRole-listByPage', '/sysUserRole/listByPage', 'POST', 'c9e7993fc6a34383af30568b940657fb', NULL, '3', '1', '2021-11-04 17:35:23', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('afff2ee8740347cd9aee391307ee6b78', NULL, '根据id查询单条用户登录账号表数据', 'sysUserLogin-listById', '/sysUserLogin/listById', 'POST', '05e98272559947018f0fb07787aee029', NULL, '3', '1', '2021-11-12 15:51:23', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('b2c0de1721e844e5aad22f72555a9017', NULL, '删除任务接口', 'job-deleted', '/job/deleted', 'DELETE', '9a1647856ce84a07a520ba9022412250', NULL, '3', '1', '2021-11-12 15:51:22', '2022-07-28 15:29:51', 0, NULL);
INSERT INTO `sys_permission` VALUES ('b3f9ada00bac47e1a4897b31dea9bb43', NULL, '新增ip黑名单记录表', 'ipBlacklistInfo-add', '/ipBlacklistInfo/add', 'POST', '81bc4ae4383f4882907ca26b6634332c', NULL, '3', '1', '2022-02-16 09:24:40', '2022-07-28 15:29:51', 0, NULL);
INSERT INTO `sys_permission` VALUES ('b45acf9df7e442bb85550e958c1d6e2f', NULL, '附件信息表', NULL, NULL, NULL, '0', NULL, '3', '1', '2021-12-18 14:51:03', NULL, 0, NULL);
INSERT INTO `sys_permission` VALUES ('b7fd20301ba545d8bce51be32d975869', NULL, '删除树形数据', 'sysTreeData-delete', '/sysTreeData/delete', 'DELETE', '3b2c6ab28a17427ea1322976cd9f8b86', NULL, '3', '1', '2021-11-05 14:46:36', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('b9b6c506c19a47418c6df56b207fb1f0', NULL, '系统角色权限', NULL, NULL, NULL, '0', NULL, '3', '1', '2021-11-04 17:35:22', NULL, 0, NULL);
INSERT INTO `sys_permission` VALUES ('bef54ec653d64a78862b81f5dd48afdb', NULL, '根据id查询单条树形数据数据', 'sysTreeData-listById', '/sysTreeData/listById', 'POST', '3b2c6ab28a17427ea1322976cd9f8b86', NULL, '3', '1', '2021-11-05 14:46:36', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('bfd6b1d63bbb4b4598652ac09565759f', NULL, '删除系统角色', 'sysRole-delete', '/sysRole/delete', 'DELETE', '128e88875fe042ab8fdc205339334371', NULL, '3', '1', '2021-11-04 17:35:22', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('bff80ff5ca6d4eaf8059e3ea8d98f472', NULL, '系统用户', NULL, NULL, NULL, '0', NULL, '3', '1', '2021-11-04 17:35:23', NULL, 0, NULL);
INSERT INTO `sys_permission` VALUES ('c45a2629a8514ff4a33ea3cb1174c7ec', NULL, '查询系统访问地区白名单分页数据', 'whiteRegionInfo-listByPage', '/whiteRegionInfo/listByPage', 'POST', '50a832df8e7d42b396477d31acd1efd7', NULL, '3', '1', '2022-03-01 17:01:54', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('c5af6608d7cf47e0aa57d53ec59e34b6', NULL, '新增用户登录账号表', 'sysUserLogin-add', '/sysUserLogin/add', 'POST', '05e98272559947018f0fb07787aee029', NULL, '3', '1', '2021-11-12 15:51:23', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('c5b3d43f56ee40f0b1724fa88935621c', NULL, '解锁用户', 'sysUserLogin-untieUser', '/sysUserLogin/untieUser', 'POST', '05e98272559947018f0fb07787aee029', NULL, '3', '1', '2021-12-18 10:29:35', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('c64e29f27dd14849a1443616c9eaa553', NULL, '删除附件信息表', 'publicAttachement-delete', '/publicAttachement/delete', 'DELETE', 'b45acf9df7e442bb85550e958c1d6e2f', NULL, '3', '1', '2021-12-18 14:51:03', '2022-07-28 15:29:51', 0, NULL);
INSERT INTO `sys_permission` VALUES ('c7dcb23bcf924ce9a1efac91d780b7d2', NULL, '更新用户登录账号表', 'sysUserLogin-update', '/sysUserLogin/update', 'PUT', '05e98272559947018f0fb07787aee029', NULL, '3', '1', '2021-11-12 15:51:23', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('c9e7993fc6a34383af30568b940657fb', NULL, '系统用户角色', NULL, NULL, NULL, '0', NULL, '3', '1', '2021-11-04 17:35:23', NULL, 0, NULL);
INSERT INTO `sys_permission` VALUES ('ca32759beb8642128be161b7d0dd433f', NULL, '查询系统用户分页数据', 'sysUser-listByPage', '/sysUser/listByPage', 'POST', 'bff80ff5ca6d4eaf8059e3ea8d98f472', NULL, '3', '1', '2021-11-12 15:51:23', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('ca50d2174b0c42c9824f773ac8c0f275', NULL, '查询树形数据分页数据', 'sysTreeData-listByPage', '/sysTreeData/listByPage', 'POST', '3b2c6ab28a17427ea1322976cd9f8b86', NULL, '3', '1', '2021-11-05 14:46:36', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('cbd0f7faa72e49efbfdc094e078b11bf', NULL, '系统配置', NULL, NULL, NULL, '0', '2', '1', '0', '2022-03-03 14:31:14', NULL, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('cdf034a7b6254c579804a172925ea261', NULL, '首页', NULL, NULL, NULL, '0', '0', '1', '0', '2022-03-03 14:30:52', NULL, NULL, '/home');
INSERT INTO `sys_permission` VALUES ('d0261441a42a4a148178aa3aaf048c36', NULL, '新增', 'testtest-add', '/testtest/add', 'POST', '6235a798ff744900b88df0cded720770', NULL, '3', '1', '2021-11-12 17:09:03', '2021-11-12 17:25:28', 0, NULL);
INSERT INTO `sys_permission` VALUES ('d337a26d47284eb48c6a877b81f52ab1', NULL, '更新树形数据', 'sysTreeData-update', '/sysTreeData/update', 'PUT', '3b2c6ab28a17427ea1322976cd9f8b86', NULL, '3', '1', '2021-11-05 14:46:36', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('d4a8758c3da34e30827757cc61e7cde4', NULL, '停止webSocket', 'websocket-stop', '/websocket/stopWebsocket', 'POST', '61aff301359f4089b1c6b7e629f73c10', NULL, '3', '1', '2021-12-10 11:09:14', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('d5ebfb1c58ae4ffd9f45a20c77b7f260', NULL, '获取菜单', 'sysUser-getAllMenus', '/sysUser/getAllMenus', 'POST', 'bff80ff5ca6d4eaf8059e3ea8d98f472', NULL, '3', '1', '2022-03-03 10:54:27', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('d605bd09b6114764a951e0cbc09ebd98', NULL, '查询盘符空间', 'sysUser-diskInfo', '/sysUser/diskInfo', 'POST', 'bff80ff5ca6d4eaf8059e3ea8d98f472', NULL, '3', '1', '2021-11-26 14:20:57', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('d983d01037f14440a0633e8bec882b55', NULL, '新增拦截异常日志表', 'sysInterceptLog-add', '/sysInterceptLog/add', 'POST', '1d343d24f36b4f7ca59d5f0620c0b5f0', NULL, '3', '1', '2021-11-12 15:51:22', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('db40bbb647ff45f1aa7661777b1d0134', NULL, '查询分页数据', 'sysGenerator-listByPage', '/sysGenerator/listByPage', 'POST', '862160b3e613482abd9248eaabf7ed23', NULL, '3', '1', '2021-11-12 15:51:22', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('db49860eba2345f481487e7f7a8151a0', NULL, '删除系统角色权限', 'sysRolePermission-delete', '/sysRolePermission/delete', 'DELETE', 'b9b6c506c19a47418c6df56b207fb1f0', NULL, '3', '1', '2021-11-04 17:35:23', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('db695d59536e4569a355258bc5f94394', NULL, '根据id查询单条附件信息表数据', 'publicAttachement-listById', '/publicAttachement/listById', 'POST', 'b45acf9df7e442bb85550e958c1d6e2f', NULL, '3', '1', '2021-12-18 14:51:03', '2022-07-28 15:29:51', 0, NULL);
INSERT INTO `sys_permission` VALUES ('dc84e16c24784f5fa935491b9d2bcacd', NULL, '查看webSocketList', 'websocket-list', '/websocket/list', 'POST', '61aff301359f4089b1c6b7e629f73c10', NULL, '3', '1', '2021-12-10 11:00:12', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('dd48635abaaf4709b73c04dc330be6b1', NULL, '更新附件信息表', 'publicAttachement-update', '/publicAttachement/update', 'PUT', 'b45acf9df7e442bb85550e958c1d6e2f', NULL, '3', '1', '2021-12-18 14:51:03', '2022-07-28 15:29:51', 0, NULL);
INSERT INTO `sys_permission` VALUES ('ded7dd69306c405fa19002198a42d23a', NULL, '文件导入导出管理', NULL, NULL, NULL, '0', NULL, '3', '1', '2022-01-04 10:56:22', NULL, 0, NULL);
INSERT INTO `sys_permission` VALUES ('e0270568d0804cf6a8f885c88b0b7e7b', NULL, '更新用户单位中间表', 'sysUserCompany-update', '/sysUserCompany/update', 'PUT', 'fb468f143915460babd3eb7ac80ba9fd', NULL, '3', '1', '2021-12-18 13:02:01', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('e45de716281c4d859bf612fa41684a44', NULL, '删除字典数据表', 'sysDictData-delete', '/sysDictData/delete', 'DELETE', '6b389c32a71b4948a29c57f6cb3cde26', NULL, '3', '1', '2021-11-04 17:35:22', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('e698271183e84ec3ae309d027468d3dc', NULL, '查询字典数据表分页数据', 'sysDictData-listByPage', '/sysDictData/listByPage', 'POST', '6b389c32a71b4948a29c57f6cb3cde26', NULL, '3', '1', '2021-11-04 17:35:22', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('e72a1ef3ee86439c90f4fc87e02d0043', NULL, '根据id查询单条系统用户角色数据', 'sysUserRole-listById', '/sysUserRole/listById', 'POST', 'c9e7993fc6a34383af30568b940657fb', NULL, '3', '1', '2021-11-04 17:35:23', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('ec057d2c988b4418b2f07b311271581c', NULL, '新增系统用户', 'sysUser-add', '/sysUser/add', 'POST', 'bff80ff5ca6d4eaf8059e3ea8d98f472', NULL, '3', '1', '2021-11-12 15:51:23', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('ecd2cb371eb34e279efa683488716b88', NULL, '分页查询系统操作日志接口', 'sysLog-logs', '/sysLog/logs', 'POST', '662bd6ab4a0b46008d8ab5c651a06c0f', NULL, '3', '1', '2021-11-12 15:51:23', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('ee07e8c52a18422195cb02e86cf1855b', NULL, '重启webSocket', 'websocket-restart', '/websocket/restartWebsocket', 'POST', '61aff301359f4089b1c6b7e629f73c10', NULL, '3', '1', '2021-12-10 11:00:12', NULL, 0, NULL);
INSERT INTO `sys_permission` VALUES ('eead81c82ab5420e84fe687a6cdb240a', NULL, '触发任务接口', 'job-trigger', '/job/trigger', 'POST', '9a1647856ce84a07a520ba9022412250', NULL, '3', '1', '2021-11-12 15:51:22', '2022-07-28 15:29:51', 0, NULL);
INSERT INTO `sys_permission` VALUES ('efd4142f6851489dbf68320f6e8b0f47', NULL, '系统权限', NULL, NULL, NULL, '0', NULL, '3', '1', '2021-11-04 17:35:22', NULL, 0, NULL);
INSERT INTO `sys_permission` VALUES ('f343c49108aa4c798e16250b3385c0d8', NULL, '字典类型表', NULL, NULL, NULL, '0', NULL, '3', '1', '2021-11-04 17:35:22', NULL, 0, NULL);
INSERT INTO `sys_permission` VALUES ('f384e2659e824023b95f35d1bd84d4c9', NULL, '查询系统角色权限分页数据', 'sysRolePermission-listByPage', '/sysRolePermission/listByPage', 'POST', 'b9b6c506c19a47418c6df56b207fb1f0', NULL, '3', '1', '2021-11-04 17:35:23', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('f4409af657d84910a3d2aa03008f14e8', NULL, '删除拦截异常日志表', 'sysInterceptLog-delete', '/sysInterceptLog/delete', 'DELETE', '1d343d24f36b4f7ca59d5f0620c0b5f0', NULL, '3', '1', '2021-11-12 15:51:22', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('f46b4c4b77ad489c81a374d72fc39c8f', NULL, '根据id查询单条系统用户数据', 'sysUser-listById', '/sysUser/listById', 'POST', 'bff80ff5ca6d4eaf8059e3ea8d98f472', NULL, '3', '1', '2021-11-12 15:51:23', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('f4d97a7bed404563bd982521d2585900', NULL, '生成', 'sysGenerator-listByPage', '/sysGenerator/add', 'POST', '862160b3e613482abd9248eaabf7ed23', NULL, '3', '1', '2021-11-12 15:51:22', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('f598cd2134dc4358949fb6c68ed6471e', NULL, '删除系统用户', 'sysUser-delete', '/sysUser/delete', 'DELETE', 'bff80ff5ca6d4eaf8059e3ea8d98f472', NULL, '3', '1', '2021-11-12 15:51:23', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('f7ea304bfd394835aec3b482a9b9404b', NULL, '导入文件', 'excelWeb-importExcel', '/excelWeb/importExcel', 'POST', 'ded7dd69306c405fa19002198a42d23a', NULL, '3', '1', '2022-01-04 10:56:22', '2022-07-28 15:29:51', 0, NULL);
INSERT INTO `sys_permission` VALUES ('fb468f143915460babd3eb7ac80ba9fd', NULL, '用户单位中间表', NULL, NULL, NULL, '0', NULL, '3', '1', '2021-12-18 13:02:01', NULL, 0, NULL);
INSERT INTO `sys_permission` VALUES ('fb4de75a56574f86b7f455fb7e8de7cf', NULL, '更新字典数据表', 'sysDictData-update', '/sysDictData/update', 'PUT', '6b389c32a71b4948a29c57f6cb3cde26', NULL, '3', '1', '2021-11-04 17:35:22', '2022-07-28 15:29:52', 0, NULL);
INSERT INTO `sys_permission` VALUES ('fd68e0ad5498491688a8790f21c11b98', NULL, 'sql注入', 'sqlInjection-sql', '/sqlInjection/sqlInjection', 'POST', '9466f2aa0c7e47069c7cc2e956bd0411', NULL, '3', '1', '2021-12-10 17:38:26', '2022-07-28 15:29:51', 0, NULL);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `ID` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `NAME` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名称',
  `DESCRIPTION` text CHARACTER SET utf8 COLLATE utf8_general_mysql500_ci NULL,
  `STATUS` decimal(4, 0) NULL DEFAULT NULL COMMENT '状态(1:正常0:弃用)',
  `CREATE_TIME` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `UPDATE_TIME` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `DELETED` int(0) NULL DEFAULT NULL COMMENT '是否删除(1未删除；0已删除)',
  `type` int(0) NULL DEFAULT NULL COMMENT '角色类型',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_mysql500_ci COMMENT = '系统角色' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '超级管理员', '拥有所有权限-不能删除', 1, '2019-11-01 19:26:29', '2022-03-03 15:44:33', 1, NULL);
INSERT INTO `sys_role` VALUES ('960377d5b6c74972ab6b45f647129ecc', '市管理员', '你好', 1, '2021-11-05 11:49:49', '2022-04-18 09:34:23', 1, NULL);
INSERT INTO `sys_role` VALUES ('cd39c25627cc4e1f9200a2d7cb432735', '区管理员', '恩恩1', 1, '2021-11-04 18:34:41', '2022-04-18 09:34:28', NULL, NULL);

-- ----------------------------
-- Table structure for sys_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_permission`;
CREATE TABLE `sys_role_permission`  (
  `ID` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `ROLE_ID` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色ID',
  `PERMISSION_ID` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单权限ID',
  `CREATE_TIME` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_mysql500_ci COMMENT = '系统角色权限' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_permission
-- ----------------------------
INSERT INTO `sys_role_permission` VALUES ('01854c5a38144824b04437a25e14e746', '960377d5b6c74972ab6b45f647129ecc', 'ec057d2c988b4418b2f07b311271581c', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('01cfe1651edf4e8aa5d3ce1f3b9b7c56', '960377d5b6c74972ab6b45f647129ecc', 'c5b3d43f56ee40f0b1724fa88935621c', '2022-04-18 09:34:22');
INSERT INTO `sys_role_permission` VALUES ('02cd757515204e18b5b2f66cc3b65b36', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'd605bd09b6114764a951e0cbc09ebd98', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('03185fc3df3c427daecf78129b6d9e92', '960377d5b6c74972ab6b45f647129ecc', '40100f3655754e63a1c55a7a550625ba', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('04359830b6154c198d8cb47c567d8888', '960377d5b6c74972ab6b45f647129ecc', '865fa70c88cb457bbce66ae69f0d5dbf', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('05160888c0514b459e082dcfa4d1a5dd', '960377d5b6c74972ab6b45f647129ecc', '84d1d3e8833542f3994decbd87936eec', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('064c9a1ced504a799d07de90d503619a', '960377d5b6c74972ab6b45f647129ecc', 'a3d3ae69d4a04044b08afdb1c058a5da', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('096d1737b6694bfc8895f466095cd689', 'cd39c25627cc4e1f9200a2d7cb432735', '20edaccce184448fa24f15aa2759b3d1', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('09a71dd7a65f48b5ace9106d8ddfd85e', '960377d5b6c74972ab6b45f647129ecc', '8418b9af3d72471e9edc142c98f1baea', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('09b6f30a0a3149d6ad931e36a2731b63', '960377d5b6c74972ab6b45f647129ecc', 'a68f8a96a5164cd1a8ab55454681cc84', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('0bc2e370caf646008d221127c6eb4a16', 'cd39c25627cc4e1f9200a2d7cb432735', '8502660955264d94b7122be852c797c6', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('0bcf9f4731e14fe2b4e91afa9b518253', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '461c3e77a65342e2b1995d1f3dfc9164', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('0d6da08bc10d46988359fc3be4ab6d47', 'cd39c25627cc4e1f9200a2d7cb432735', 'a6e0e8483735498fbaa2d26106ffaa49', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('0d7ba5dc2c1e4221aa93553f1796ac25', 'cd39c25627cc4e1f9200a2d7cb432735', '50103e8963e746d89ef7817b1cf31241', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('0e4ef9a06454444ba7987e120592763d', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '044f9b38d0dd4180a331b927aa9ffe6d', '2022-07-28 15:29:51');
INSERT INTO `sys_role_permission` VALUES ('103e1c5aa25f4c6881c5a84643c433fa', '960377d5b6c74972ab6b45f647129ecc', '0e0da70f159b4115b3bbb9731733743f', '2022-04-18 09:34:22');
INSERT INTO `sys_role_permission` VALUES ('109fa2f7a8e64e009acd8ae6320ddef2', '960377d5b6c74972ab6b45f647129ecc', 'eead81c82ab5420e84fe687a6cdb240a', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('119ad88c325c4116bc326d846f4b7985', '960377d5b6c74972ab6b45f647129ecc', 'e0270568d0804cf6a8f885c88b0b7e7b', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('11fff04aca7349e8ad960f8af06f9bb0', 'cd39c25627cc4e1f9200a2d7cb432735', '6b3310e94046485db87ed04f2f5e610e', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('1206ffd93bf3443db8d57288988b2c1c', 'cd39c25627cc4e1f9200a2d7cb432735', 'e698271183e84ec3ae309d027468d3dc', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('12401c91f7754639bce33b76189627f0', '960377d5b6c74972ab6b45f647129ecc', '0c1efedee7f747098b6efa2fbf8747a3', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('12bed68c01634389968e31d6f8f2d632', 'cd39c25627cc4e1f9200a2d7cb432735', 'f46b4c4b77ad489c81a374d72fc39c8f', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('137f7e93243c4d9381bd4dc7df50283c', 'cd39c25627cc4e1f9200a2d7cb432735', '865fa70c88cb457bbce66ae69f0d5dbf', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('1538f282a9d0405daa420c6c4ccb4cae', '960377d5b6c74972ab6b45f647129ecc', '4d1555b2e7bf406a91c5713bba13c054', '2022-04-18 09:34:22');
INSERT INTO `sys_role_permission` VALUES ('1598981da3204f02ad9250314ecc3f04', '960377d5b6c74972ab6b45f647129ecc', 'dd48635abaaf4709b73c04dc330be6b1', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('173ae451d3d84c4d85b78a0fc749ce27', '960377d5b6c74972ab6b45f647129ecc', '50103e8963e746d89ef7817b1cf31241', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('173eaf282dda453db894f3e8bf2834c2', 'cd39c25627cc4e1f9200a2d7cb432735', '98ff03cfd4724f8f96498ca2cb3bf758', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('18a97428b7784b48b147ba7775d8b4a4', '960377d5b6c74972ab6b45f647129ecc', '9c18d11cd68047269284f9aa34427060', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('18f5ac828e504213ade4f4a4cd5a24ef', 'cd39c25627cc4e1f9200a2d7cb432735', '211fedbb1cea47ed8edf30c266ca5282', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('1934ae2a95d649c892638c92136ccc2b', 'cd39c25627cc4e1f9200a2d7cb432735', '70355a9577d746d4a33fa2342ac15a84', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('198087a230f14736abc5a44ec081f6be', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'e45de716281c4d859bf612fa41684a44', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('19a2c13ce0174e3c9383d596d55d5366', '960377d5b6c74972ab6b45f647129ecc', 'db49860eba2345f481487e7f7a8151a0', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('1a16cb3eaf1c493faab99c4872d9425d', '960377d5b6c74972ab6b45f647129ecc', '407365d273034590b24c357ae63cd296', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('1d6f5c19e38b433a894247eb663f6d2e', 'cd39c25627cc4e1f9200a2d7cb432735', 'd5ebfb1c58ae4ffd9f45a20c77b7f260', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('1d7ace6a2cf34127a9092ee600a9f924', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '0dfc1a45c1a04cdd9ac810ce64c4afbb', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('1e2db4ed21634236bf1cb73a14ad7007', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'e698271183e84ec3ae309d027468d3dc', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('1f08a14a823845afb150fb5318370e6d', '960377d5b6c74972ab6b45f647129ecc', 'f4d97a7bed404563bd982521d2585900', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('1fcd869b801545f08df00adab55bc7bf', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '20edaccce184448fa24f15aa2759b3d1', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('2000f6f96ef747b0a3d342491e878a18', '960377d5b6c74972ab6b45f647129ecc', 'db695d59536e4569a355258bc5f94394', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('2016be88a6b347309d509fa74539aece', '960377d5b6c74972ab6b45f647129ecc', 'a265636a0763423d8f81be63f25f0a29', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('20209a324e5c44849530303d97aac275', '960377d5b6c74972ab6b45f647129ecc', '5163e43a13c64537aaf0d50aa7572cc3', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('20e0f6d572ae48208c116a829cd7026d', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '344d930c397749beb2db9f354fa0e281', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('22327c60a3c043709c4c43e2ca207532', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '211fedbb1cea47ed8edf30c266ca5282', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('23357fb313ec4b938aa24c05fd32ef03', '960377d5b6c74972ab6b45f647129ecc', '75e65c63cf704612a836e52baa2978a6', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('259a133592644c77a46bda5303c4636d', 'cd39c25627cc4e1f9200a2d7cb432735', '2f403f52fc444046b2c1ebc37428d69c', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('267745c954c446478c2718264b84b593', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'bef54ec653d64a78862b81f5dd48afdb', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('26b60e6703d54a0f939f828d8fe05023', 'cd39c25627cc4e1f9200a2d7cb432735', 'dc84e16c24784f5fa935491b9d2bcacd', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('28aa26545255469f9c273109812e7bea', '960377d5b6c74972ab6b45f647129ecc', '885ef99a74ea454b881aeb8220c5220a', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('297229dff9824bc8a92e2420f5316997', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'dd48635abaaf4709b73c04dc330be6b1', '2022-07-28 15:29:51');
INSERT INTO `sys_role_permission` VALUES ('29c9b60406c641cc989f40d9dce3c71d', '960377d5b6c74972ab6b45f647129ecc', 'f384e2659e824023b95f35d1bd84d4c9', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('2a5f6054f30a4601b63a15ba8934a17d', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'c5af6608d7cf47e0aa57d53ec59e34b6', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('2ac6e2bd477e472e9a0175c2466ca691', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'f598cd2134dc4358949fb6c68ed6471e', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('2b0ae4f83f0644dfb3ea99cb3566c982', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '421a8ae169934a1eb307984f8526c3a0', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('2b214191115c42f28c0adce413db9a59', '960377d5b6c74972ab6b45f647129ecc', '2861b2b1fc274cd79c43a3dda67cb628', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('2bea648d26b84dc0b30bd15bb1d43472', '960377d5b6c74972ab6b45f647129ecc', 'b2c0de1721e844e5aad22f72555a9017', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('2c1fffe02997462aa951bf681c872cae', '960377d5b6c74972ab6b45f647129ecc', '70355a9577d746d4a33fa2342ac15a84', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('2c3fbaacc5884164a0ccd1115ecfc14d', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '334af23eb2404398a615aeb09ee0dfbc', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('2caeb052cb6940c3b100a75a7beb9bef', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '1733d590018a4300bdcb42d2a773e451', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('2daaa0c78f934378a2c326ebbc22265c', 'cd39c25627cc4e1f9200a2d7cb432735', 'ca50d2174b0c42c9824f773ac8c0f275', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('2e30693ccf4d4348a185ac1e0b1d6298', '960377d5b6c74972ab6b45f647129ecc', '0ba0b79f95874a1a88a9010651e33f57', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('2e6e175c361c429aa5f45e72fb81fe5c', 'cd39c25627cc4e1f9200a2d7cb432735', '1f6aa9c01bdc41d2b456e6186ed1856c', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('2fd5c986aa91455d992770d2de4109c9', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '2ecf9b08451346469916a7495015fbaa', '2022-07-28 15:29:51');
INSERT INTO `sys_role_permission` VALUES ('309dfb08d6ef4836a5f9853f706093b8', 'cd39c25627cc4e1f9200a2d7cb432735', '0a261fae6d264d99adb12711c67e1dc5', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('30a23490afce4d2dbb5d765e0018f2c1', 'cd39c25627cc4e1f9200a2d7cb432735', '75e65c63cf704612a836e52baa2978a6', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('30bff07500d54f7ebb06ad8063fe0348', '960377d5b6c74972ab6b45f647129ecc', 'bfd6b1d63bbb4b4598652ac09565759f', '2022-04-18 09:34:22');
INSERT INTO `sys_role_permission` VALUES ('3130183112304f6c817a64f8a63aa964', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'd983d01037f14440a0633e8bec882b55', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('3220b801f3164bb88f6a1dd05895ac15', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '84d1d3e8833542f3994decbd87936eec', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('33ae0fa637f243e28b10f76263f44ed8', 'cd39c25627cc4e1f9200a2d7cb432735', '088c12320dba460f95ddf52d94bd939b', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('33bee3b34e9a45eb87cee00f2fe4b563', '960377d5b6c74972ab6b45f647129ecc', '78b50f83d6bd41329c5dc425641d7ade', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('34124f8d539843d69d44ac5f2575d60c', '960377d5b6c74972ab6b45f647129ecc', 'd337a26d47284eb48c6a877b81f52ab1', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('37c6e6c419234ed6800f4a378b660fa0', 'cd39c25627cc4e1f9200a2d7cb432735', 'fd68e0ad5498491688a8790f21c11b98', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('38b982d3c4c4498b95e919e97992e2ee', 'cd39c25627cc4e1f9200a2d7cb432735', 'd0261441a42a4a148178aa3aaf048c36', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('39764089fa824f158626b3f3e1827074', 'cd39c25627cc4e1f9200a2d7cb432735', '1cf1aacdcab14c218ae9be077239407f', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('39a3eb1143da4f3e93584a6c8c2a7b58', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '3befc6ab26234076947dbc4a3558a627', '2022-07-28 15:29:51');
INSERT INTO `sys_role_permission` VALUES ('39cbdc1bbd1f4c449534918a9c528621', 'cd39c25627cc4e1f9200a2d7cb432735', 'a0b26dd5395c432da2ba54b5d6a7fb3f', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('3a1578255d92482e93e04fa0e1c5810b', '960377d5b6c74972ab6b45f647129ecc', 'f7ea304bfd394835aec3b482a9b9404b', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('3b1e8dbca75b491db2bf9abb5c52679a', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'f384e2659e824023b95f35d1bd84d4c9', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('3b91bf632c9843c1b56818208c577e18', 'cd39c25627cc4e1f9200a2d7cb432735', '421a8ae169934a1eb307984f8526c3a0', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('3c5d290bc8674b58aa3baea04b088768', 'cd39c25627cc4e1f9200a2d7cb432735', 'b7fd20301ba545d8bce51be32d975869', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('3cb2efdee99b40ef88ad0fa5e0613c11', '960377d5b6c74972ab6b45f647129ecc', '722ae34c8c97410eb15aaa3e1bd3910c', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('3cf4eb40721f4a25b44edef241a4d19c', 'cd39c25627cc4e1f9200a2d7cb432735', '2971f3d710df48e99fc4b19dfc747266', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('3f35cdc574944082a4cc46053045ed81', 'cd39c25627cc4e1f9200a2d7cb432735', '1026b0e03be14c1ca036ec106d0ec660', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('404efcd99a0449ce9da5486b2e7582c5', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '2f403f52fc444046b2c1ebc37428d69c', '2022-07-28 15:29:51');
INSERT INTO `sys_role_permission` VALUES ('431e640d78734451aaf249ae296efb23', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'fd68e0ad5498491688a8790f21c11b98', '2022-07-28 15:29:51');
INSERT INTO `sys_role_permission` VALUES ('44a3589b44374853b927ce898086b047', 'cd39c25627cc4e1f9200a2d7cb432735', 'ac11e15a148142acbb47b62db1439c4a', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('4608b9fe6fcd4117aa9979e79cdc3c71', 'cd39c25627cc4e1f9200a2d7cb432735', '8418b9af3d72471e9edc142c98f1baea', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('498add702c7343a49f674f44545f0382', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '885ef99a74ea454b881aeb8220c5220a', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('49d5bf2b89e0452e96d747a9151a9deb', '960377d5b6c74972ab6b45f647129ecc', '461c3e77a65342e2b1995d1f3dfc9164', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('4a1dacdb3aac4589ace16a206a20ff3e', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'c7dcb23bcf924ce9a1efac91d780b7d2', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('4a7c9c68247a46a89fa527477904b077', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'c45a2629a8514ff4a33ea3cb1174c7ec', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('4b3ece6e0a07474cb5dbd20e9f794be5', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '2617ef912c564eb58f6aaf89520e3241', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('4c1682dcc1eb4b0fbdf665333e0348c3', 'cd39c25627cc4e1f9200a2d7cb432735', '344d930c397749beb2db9f354fa0e281', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('4c1c112adbab4fe5ac2a8ac70b3ec32e', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '17e5599a62ea439dac746b7118cd0041', '2022-07-28 15:29:51');
INSERT INTO `sys_role_permission` VALUES ('4dfd19a1a5e24c1e9a07bad85c029883', 'cd39c25627cc4e1f9200a2d7cb432735', '2ecf9b08451346469916a7495015fbaa', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('4ed2de2c011140f782ac7970d9426612', '960377d5b6c74972ab6b45f647129ecc', 'b3f9ada00bac47e1a4897b31dea9bb43', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('4ee48878c44947bbb3dab88ac037295b', '960377d5b6c74972ab6b45f647129ecc', 'dc84e16c24784f5fa935491b9d2bcacd', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('4eefb4c0fe2b40098e69012a164af934', '960377d5b6c74972ab6b45f647129ecc', 'c7dcb23bcf924ce9a1efac91d780b7d2', '2022-04-18 09:34:22');
INSERT INTO `sys_role_permission` VALUES ('500eafcad7c64cdaa6b58427f43bc418', '960377d5b6c74972ab6b45f647129ecc', '17e5599a62ea439dac746b7118cd0041', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('50a564e49d0b461293a0eae2048746a9', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '68f96e445930404788977ea2acdd23d1', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('51a411bd84024a21852a3db1ab184cd7', 'cd39c25627cc4e1f9200a2d7cb432735', 'affd7aa0cc89493f9c03f944b85ac466', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('51cb50751bbd42f190cfeb30f47e1786', 'cd39c25627cc4e1f9200a2d7cb432735', 'ec057d2c988b4418b2f07b311271581c', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('525aa371d3a74368bbd6b4f359242719', '960377d5b6c74972ab6b45f647129ecc', '1cf1aacdcab14c218ae9be077239407f', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('5270ef303e1e441795d714f8e004e396', '960377d5b6c74972ab6b45f647129ecc', 'ac11e15a148142acbb47b62db1439c4a', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('52f9493d27004c7ea5ccbe410dcde3bd', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'a265636a0763423d8f81be63f25f0a29', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('5313bcd5e8044c5baab3dce2c31fbb15', '960377d5b6c74972ab6b45f647129ecc', '7f377771184a42a98306ddf92a98b86c', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('5370f6613d594e398ba77ca0657d1a8e', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '03e4758110a04f589b80110501fdd34d', '2022-07-28 15:29:51');
INSERT INTO `sys_role_permission` VALUES ('54169f57cccf49a991acb727121ac0d6', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'e72a1ef3ee86439c90f4fc87e02d0043', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('5438496e318b47328e9b70c084864fd6', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'b2c0de1721e844e5aad22f72555a9017', '2022-07-28 15:29:51');
INSERT INTO `sys_role_permission` VALUES ('5611b00456b648759df391c2535bf931', '960377d5b6c74972ab6b45f647129ecc', 'f4409af657d84910a3d2aa03008f14e8', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('57223e3e647948009a501b2c6064f106', 'cd39c25627cc4e1f9200a2d7cb432735', '0c1efedee7f747098b6efa2fbf8747a3', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('5770ff8714a74348ab500b2d624e45d7', 'cd39c25627cc4e1f9200a2d7cb432735', 'b2c0de1721e844e5aad22f72555a9017', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('5a6a85a0a9da4618b7e2548c43325e79', '960377d5b6c74972ab6b45f647129ecc', 'd605bd09b6114764a951e0cbc09ebd98', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('5ae8224ec4af45aa8fdabc3b51c0da21', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'ec057d2c988b4418b2f07b311271581c', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('5c4dda3bf47b42e18faab62603f7566c', 'cd39c25627cc4e1f9200a2d7cb432735', 'dd48635abaaf4709b73c04dc330be6b1', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('5c78c6bc71274fc886724ec2d117ef28', '960377d5b6c74972ab6b45f647129ecc', '0dfc1a45c1a04cdd9ac810ce64c4afbb', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('5e60b03eb27b4b10a22ee3b8a001888d', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '1026b0e03be14c1ca036ec106d0ec660', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('5ed032f4cdd4426f841b0114974c0a2d', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'adc5cd2824884d14bbb9bca2fac0af3c', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('5f0806f086b54952a9b1e2d55fdd7911', '960377d5b6c74972ab6b45f647129ecc', '527e91eabbb8445db77757fc51cb7131', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('5fa5cef17b8a479aaeca97e6fd346bdc', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '6b3310e94046485db87ed04f2f5e610e', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('5fcd03ac5db74ddf97442ef949b5b7b1', 'cd39c25627cc4e1f9200a2d7cb432735', '40100f3655754e63a1c55a7a550625ba', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('5fe3a31af3a84766939e52783d089320', '960377d5b6c74972ab6b45f647129ecc', '1e9272e8175d4c3b948168f136c2b964', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('60b405b298ac49de9c7f5506241cbab4', 'cd39c25627cc4e1f9200a2d7cb432735', 'fb4de75a56574f86b7f455fb7e8de7cf', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('612acfccee524c28bd9d095e1dd810fa', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'c5b3d43f56ee40f0b1724fa88935621c', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('6189c15676a1413dbcc2a976474a1ff9', '960377d5b6c74972ab6b45f647129ecc', '032d03ca6fa949ad89db06ae2d29a80a', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('62500f80bc374db08efa0f3e48bf294d', 'cd39c25627cc4e1f9200a2d7cb432735', 'e0270568d0804cf6a8f885c88b0b7e7b', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('63aa680773884015a6d8aba1f12f845e', '960377d5b6c74972ab6b45f647129ecc', 'f598cd2134dc4358949fb6c68ed6471e', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('647844ee55314d15a1380eaaa96bf5ca', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'a0b26dd5395c432da2ba54b5d6a7fb3f', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('6499028e57364451995f9c37ffac447b', 'cd39c25627cc4e1f9200a2d7cb432735', '1733d590018a4300bdcb42d2a773e451', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('65191543784d4f42a1d2effbf9495975', '960377d5b6c74972ab6b45f647129ecc', 'fd68e0ad5498491688a8790f21c11b98', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('65b77082cad0478a933f8a0da09b6a9d', 'cd39c25627cc4e1f9200a2d7cb432735', '7f377771184a42a98306ddf92a98b86c', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('668607fb7bb14299931137d663f2ec9c', 'cd39c25627cc4e1f9200a2d7cb432735', 'c64e29f27dd14849a1443616c9eaa553', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('67717178e1d249d18f252687c887a609', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'ca32759beb8642128be161b7d0dd433f', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('68ae543466cb4f868bc6be81bb8c4154', 'cd39c25627cc4e1f9200a2d7cb432735', '24d07d9dcae341e8b36f94d4e2650144', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('68cf878153fb4b60b957b5b1317889a6', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '088c12320dba460f95ddf52d94bd939b', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('6935076fa56d480abc670f6844f21c69', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'c64e29f27dd14849a1443616c9eaa553', '2022-07-28 15:29:51');
INSERT INTO `sys_role_permission` VALUES ('693f8e8dd99f448e9214612234130f44', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'ecd2cb371eb34e279efa683488716b88', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('6bbcc30226194399bfb653447773f375', '960377d5b6c74972ab6b45f647129ecc', '344d930c397749beb2db9f354fa0e281', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('6cc272a77e93482ba1f8407485931edd', 'cd39c25627cc4e1f9200a2d7cb432735', '94eafc7b0e1444a6bbf3f4ea52b99368', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('6daf9d84d08b42759893c3ed1efaab03', '960377d5b6c74972ab6b45f647129ecc', 'b7fd20301ba545d8bce51be32d975869', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('6db1da8a67bd4a46ad1fe3e24be61121', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '0e0da70f159b4115b3bbb9731733743f', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('6ef57a3fe73e40bd9dc78b52f8883096', '960377d5b6c74972ab6b45f647129ecc', '0f80790e9294448fb29a8ea03c4ac7d2', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('70d4a0e9d71248be99a157e16e4329a0', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '2861b2b1fc274cd79c43a3dda67cb628', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('716189d9d4e74f51af96929acd0bb0bd', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '65e0683e9184433daa79a66753759b79', '2022-07-28 15:29:51');
INSERT INTO `sys_role_permission` VALUES ('73a0879f21bd4d6f8453ef7b8b885a5f', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '7f377771184a42a98306ddf92a98b86c', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('7470f7ff570443e7ab59fd96c59d0419', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '407365d273034590b24c357ae63cd296', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('75304b6d709f401ebde92bbb3694c751', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'b3f9ada00bac47e1a4897b31dea9bb43', '2022-07-28 15:29:51');
INSERT INTO `sys_role_permission` VALUES ('75399f8d89bf4201ab67025a6720e56f', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '78b50f83d6bd41329c5dc425641d7ade', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('75eedd4690774464a37fac3b5ccd9987', '960377d5b6c74972ab6b45f647129ecc', '68f96e445930404788977ea2acdd23d1', '2022-04-18 09:34:22');
INSERT INTO `sys_role_permission` VALUES ('77009c2404cf40df9a7cd0fa4f361aee', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '9c18d11cd68047269284f9aa34427060', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('78e37ad6d3f14ce588677f1b6a33da43', 'cd39c25627cc4e1f9200a2d7cb432735', 'c5b3d43f56ee40f0b1724fa88935621c', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('795c8681326e415f997628850b4ea99e', '960377d5b6c74972ab6b45f647129ecc', 'a0b26dd5395c432da2ba54b5d6a7fb3f', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('7a0d9174940f405b9e1d9b4e91b6eaf8', 'cd39c25627cc4e1f9200a2d7cb432735', '157c5429d1214839902f65e05e939d29', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('7a60780d6628401f9b1a9d630d9ba963', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '1e9272e8175d4c3b948168f136c2b964', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('7c21339a163f455787b8417df28db265', '960377d5b6c74972ab6b45f647129ecc', '24d07d9dcae341e8b36f94d4e2650144', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('7e35ec9c0ad3408cadf320f43026293b', 'cd39c25627cc4e1f9200a2d7cb432735', 'c5af6608d7cf47e0aa57d53ec59e34b6', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('7ec23cc703034dae87861c1eba2b6ddb', 'cd39c25627cc4e1f9200a2d7cb432735', '461c3e77a65342e2b1995d1f3dfc9164', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('7f40e809fe6f4543bd87b9a5fc72bc26', '960377d5b6c74972ab6b45f647129ecc', '4c8da359f254448e943a33cbaae383c4', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('7f94160b45f74eff9eae814c55671f9d', 'cd39c25627cc4e1f9200a2d7cb432735', '032d03ca6fa949ad89db06ae2d29a80a', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('8012d9560b2845e681e00ee2803b4e7c', 'cd39c25627cc4e1f9200a2d7cb432735', '044f9b38d0dd4180a331b927aa9ffe6d', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('812aba6b627147368dcb3d26c1b84993', '960377d5b6c74972ab6b45f647129ecc', '8502660955264d94b7122be852c797c6', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('816e4ee43cf94e9a865e7b47681696a5', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '2f565daf1bee4b459cdb94bb26a06572', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('8223b817354e4be99bc041a072936d11', '960377d5b6c74972ab6b45f647129ecc', '044f9b38d0dd4180a331b927aa9ffe6d', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('8392d0871f394b0295ba12f8ad179e91', 'cd39c25627cc4e1f9200a2d7cb432735', 'db695d59536e4569a355258bc5f94394', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('84ea1e33a3d14e23a4a375e81b52caf7', 'cd39c25627cc4e1f9200a2d7cb432735', '4c8da359f254448e943a33cbaae383c4', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('855e8442ef714312b61a940151ab4697', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '0f80790e9294448fb29a8ea03c4ac7d2', '2022-07-28 15:29:51');
INSERT INTO `sys_role_permission` VALUES ('87675929f8d7452da02a7cb1ec8fc915', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'db695d59536e4569a355258bc5f94394', '2022-07-28 15:29:51');
INSERT INTO `sys_role_permission` VALUES ('87936e529b4440e4a991505b795bcf7b', '960377d5b6c74972ab6b45f647129ecc', 'c5af6608d7cf47e0aa57d53ec59e34b6', '2022-04-18 09:34:22');
INSERT INTO `sys_role_permission` VALUES ('87cac86024ad44498ebacaf7b806ed7d', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '75e65c63cf704612a836e52baa2978a6', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('87cca5e1267b4b60bb2533a77d22d578', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'd5ebfb1c58ae4ffd9f45a20c77b7f260', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('891a5624c13a49e7abeb57f17a6c2ba5', 'cd39c25627cc4e1f9200a2d7cb432735', 'd337a26d47284eb48c6a877b81f52ab1', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('8b28340adf854c27a33b17f043fa0eac', 'cd39c25627cc4e1f9200a2d7cb432735', 'a68f8a96a5164cd1a8ab55454681cc84', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('8b56b8aaf7a648f3a46407f8dbb15251', '960377d5b6c74972ab6b45f647129ecc', 'c45a2629a8514ff4a33ea3cb1174c7ec', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('8b67b2e13e2849f3b21b1e905112204b', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'e0270568d0804cf6a8f885c88b0b7e7b', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('8cbe4923c1384d59a05101d4f491a22b', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'ca50d2174b0c42c9824f773ac8c0f275', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('8d6b581902854e44bebcf8c8417e1ca6', 'cd39c25627cc4e1f9200a2d7cb432735', '407365d273034590b24c357ae63cd296', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('8fd0c2e85afd495997b3c1af1ed5ec50', 'cd39c25627cc4e1f9200a2d7cb432735', '527e91eabbb8445db77757fc51cb7131', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('90987868b03c468db7659a83a25c7184', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'fb4de75a56574f86b7f455fb7e8de7cf', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('90b01c0bd583478aa4f7df3f07bbe7df', 'cd39c25627cc4e1f9200a2d7cb432735', 'f7ea304bfd394835aec3b482a9b9404b', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('92599461ef07400889b3f447cd018fd0', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '60abd7273f0743908097160b769a3e66', '2022-07-28 15:29:51');
INSERT INTO `sys_role_permission` VALUES ('9263f21890014710b4104ba61a88552d', '960377d5b6c74972ab6b45f647129ecc', '334af23eb2404398a615aeb09ee0dfbc', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('926c639ebce7483fb08ee042cd2bb4da', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'f46b4c4b77ad489c81a374d72fc39c8f', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('92ddea33e5a64da691a05bea024a4460', 'cd39c25627cc4e1f9200a2d7cb432735', '18254d278201405982cbca7670c48bda', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('936e4bfe82c341fd98521d587d683d1d', 'cd39c25627cc4e1f9200a2d7cb432735', 'a265636a0763423d8f81be63f25f0a29', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('93e94f47c5774bdb9c670688d6eb3199', 'cd39c25627cc4e1f9200a2d7cb432735', '17e5599a62ea439dac746b7118cd0041', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('942d9ca950f048bd957517d79ed0b3f6', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '1f6aa9c01bdc41d2b456e6186ed1856c', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('94d6d175d3ff4de09ead2b2079ee6281', 'cd39c25627cc4e1f9200a2d7cb432735', '78b50f83d6bd41329c5dc425641d7ade', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('958c2b9390334bb0bc51bfc11d0a4355', 'cd39c25627cc4e1f9200a2d7cb432735', '9c18d11cd68047269284f9aa34427060', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('95dcb54c1ef2416fa7593949714f13f6', 'cd39c25627cc4e1f9200a2d7cb432735', 'db49860eba2345f481487e7f7a8151a0', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('96b36d07e88c4602800475716bdfaa1a', 'cd39c25627cc4e1f9200a2d7cb432735', '0ba0b79f95874a1a88a9010651e33f57', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('98612a1eba0d4fb482c6b7cc4d8e351a', 'cd39c25627cc4e1f9200a2d7cb432735', '334af23eb2404398a615aeb09ee0dfbc', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('98f74051eb57406f9a522602f8c4d650', '960377d5b6c74972ab6b45f647129ecc', 'bef54ec653d64a78862b81f5dd48afdb', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('9a06fb72df6c4bb1bdeffe3e4f1d4b20', '960377d5b6c74972ab6b45f647129ecc', '60abd7273f0743908097160b769a3e66', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('9af16302d0e2442f80f6f3545bc3727d', '960377d5b6c74972ab6b45f647129ecc', '211fedbb1cea47ed8edf30c266ca5282', '2022-04-18 09:34:22');
INSERT INTO `sys_role_permission` VALUES ('9be92105e3224349aefa490a72a84f65', 'cd39c25627cc4e1f9200a2d7cb432735', '7348a6ab4be546c8a66758ce2d23795b', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('9ca135cb0cf94f309f7bdc9462e267ec', 'cd39c25627cc4e1f9200a2d7cb432735', '5163e43a13c64537aaf0d50aa7572cc3', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('9d21ba54861543c6b98633f608ec33bb', 'cd39c25627cc4e1f9200a2d7cb432735', '2f565daf1bee4b459cdb94bb26a06572', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('9d7335ff58b94395b294f56d93f29aa2', 'cd39c25627cc4e1f9200a2d7cb432735', 'd983d01037f14440a0633e8bec882b55', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('9d9a97921feb464d99502e2ac4a43b42', '960377d5b6c74972ab6b45f647129ecc', '6b3310e94046485db87ed04f2f5e610e', '2022-04-18 09:34:22');
INSERT INTO `sys_role_permission` VALUES ('9e3a892e12b8447d90104061c1918b65', '960377d5b6c74972ab6b45f647129ecc', 'afff2ee8740347cd9aee391307ee6b78', '2022-04-18 09:34:22');
INSERT INTO `sys_role_permission` VALUES ('9ee5a882feee4aa7bd1ed8e92c165650', '960377d5b6c74972ab6b45f647129ecc', '2971f3d710df48e99fc4b19dfc747266', '2022-04-18 09:34:22');
INSERT INTO `sys_role_permission` VALUES ('a00e329dce974634a28dc712abed22ff', 'cd39c25627cc4e1f9200a2d7cb432735', '5a6e9e8b3b584064a583b4e731cdfd18', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('a2477ed75ffc42e184490876955cc670', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '8813764db7b34dc2ad515ba5b66201e4', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('a348a3e1ccb54276963b430e0fba2972', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '40100f3655754e63a1c55a7a550625ba', '2022-07-28 15:29:51');
INSERT INTO `sys_role_permission` VALUES ('a4491087a22a46729ff4126e59882939', 'cd39c25627cc4e1f9200a2d7cb432735', 'afff2ee8740347cd9aee391307ee6b78', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('a4518948952c43fe858ffbd19a51fb80', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '0c1efedee7f747098b6efa2fbf8747a3', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('a53589437ba84059b533682ae0d3f6de', 'cd39c25627cc4e1f9200a2d7cb432735', 'ee07e8c52a18422195cb02e86cf1855b', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('a8d0ce150afa468da119f026aa662996', '960377d5b6c74972ab6b45f647129ecc', 'd4a8758c3da34e30827757cc61e7cde4', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('a8de08accc6c416eb4e2f26ae9d50611', '960377d5b6c74972ab6b45f647129ecc', 'd5ebfb1c58ae4ffd9f45a20c77b7f260', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('a936ed7f30334cf99d8ee9d580de81af', '960377d5b6c74972ab6b45f647129ecc', '0a261fae6d264d99adb12711c67e1dc5', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('a9aab19a4ca7407ba0a216310217f05a', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '865fa70c88cb457bbce66ae69f0d5dbf', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('a9f1ce86d8e14b1ebb79e8eef1016f83', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '1cf1aacdcab14c218ae9be077239407f', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('aa6729dfb14641948b550073cce5655a', '960377d5b6c74972ab6b45f647129ecc', 'c64e29f27dd14849a1443616c9eaa553', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('aa7b1783628c4e93a9058d6a0ebe23a6', '960377d5b6c74972ab6b45f647129ecc', '088c12320dba460f95ddf52d94bd939b', '2022-04-18 09:34:22');
INSERT INTO `sys_role_permission` VALUES ('abcaa3b1cc81423d8d155a07de17073e', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'db40bbb647ff45f1aa7661777b1d0134', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('ac22fdd20c914f84a3fe57427803230c', '960377d5b6c74972ab6b45f647129ecc', '98ff03cfd4724f8f96498ca2cb3bf758', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('ad4aa9a6059f47a6bdf77a2eb17d7244', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '24d07d9dcae341e8b36f94d4e2650144', '2022-07-28 15:29:51');
INSERT INTO `sys_role_permission` VALUES ('ae194d5fed634f929b9b861ef30debe8', '960377d5b6c74972ab6b45f647129ecc', 'ee07e8c52a18422195cb02e86cf1855b', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('ae84d32b39f1402c90650ef9b24b8856', 'cd39c25627cc4e1f9200a2d7cb432735', 'f598cd2134dc4358949fb6c68ed6471e', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('ae8866903a9a402ead9a90b7bc75d0d8', '960377d5b6c74972ab6b45f647129ecc', '3befc6ab26234076947dbc4a3558a627', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('ae9e300dd03f495bad006d1df89a7b9d', '960377d5b6c74972ab6b45f647129ecc', 'db40bbb647ff45f1aa7661777b1d0134', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('af0d44a2d8564c45acb4e58ea93e4064', 'cd39c25627cc4e1f9200a2d7cb432735', '46a453d5175649a0819b1add7ffb774d', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('b018043c8d304c7cbf33dfbc10b7a603', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '46a453d5175649a0819b1add7ffb774d', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('b0882c7ce19a4cd5a71b9119d7579542', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'db49860eba2345f481487e7f7a8151a0', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('b0db31c7f04a46c6a1493783833e258c', 'cd39c25627cc4e1f9200a2d7cb432735', 'ecd2cb371eb34e279efa683488716b88', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('b25724aabb044f4cbe91d4634f849f44', 'cd39c25627cc4e1f9200a2d7cb432735', '4d1555b2e7bf406a91c5713bba13c054', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('b3d7d65b90434a5f85838ba5f1789a45', 'cd39c25627cc4e1f9200a2d7cb432735', '93f7aba124814e2694e6e11df2bcc9a5', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('b729de2e5872439097fc3b014f18a90a', 'cd39c25627cc4e1f9200a2d7cb432735', '3befc6ab26234076947dbc4a3558a627', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('b7b61d64296946a2a5283913c3329aa3', 'cd39c25627cc4e1f9200a2d7cb432735', '8813764db7b34dc2ad515ba5b66201e4', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('b8a52a8301c640248cc33534f48c9f19', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '7348a6ab4be546c8a66758ce2d23795b', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('b8b3feaa51eb4c6d837e6e49d01423d5', 'cd39c25627cc4e1f9200a2d7cb432735', 'a3d3ae69d4a04044b08afdb1c058a5da', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('b8c9cbf43c18427092e058a7a331bc52', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'afff2ee8740347cd9aee391307ee6b78', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('b9bb076e6caa4c9d94a1fd349818a4f1', 'cd39c25627cc4e1f9200a2d7cb432735', 'f4409af657d84910a3d2aa03008f14e8', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('ba41cb006acd488191b9949ce8eb8a30', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'a68f8a96a5164cd1a8ab55454681cc84', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('bb4223bd4ff74e028607f9606c86bfb2', 'cd39c25627cc4e1f9200a2d7cb432735', 'e72a1ef3ee86439c90f4fc87e02d0043', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('bc0c13416f1e44cbb9824e343d75c6a0', 'cd39c25627cc4e1f9200a2d7cb432735', 'f4d97a7bed404563bd982521d2585900', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('bc37ab7d9f6740b7bfeedf3cfd13c7be', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '5163e43a13c64537aaf0d50aa7572cc3', '2022-07-28 15:29:51');
INSERT INTO `sys_role_permission` VALUES ('bc4bcc0ff0e14de091a43d1f772774d9', 'cd39c25627cc4e1f9200a2d7cb432735', '0e0da70f159b4115b3bbb9731733743f', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('bd2bb51385bf472bbd73592b2d54f419', '960377d5b6c74972ab6b45f647129ecc', 'adc5cd2824884d14bbb9bca2fac0af3c', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('bdb0dfd717044aa8960a7a329af84636', '960377d5b6c74972ab6b45f647129ecc', '2ecf9b08451346469916a7495015fbaa', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('c0090f28a38d462abe0e2ae72e39582f', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'f7ea304bfd394835aec3b482a9b9404b', '2022-07-28 15:29:51');
INSERT INTO `sys_role_permission` VALUES ('c0d3a1acf69947529a907349e16ac216', '960377d5b6c74972ab6b45f647129ecc', '94eafc7b0e1444a6bbf3f4ea52b99368', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('c0dcf1487e724451b877524a5e5cc688', 'cd39c25627cc4e1f9200a2d7cb432735', 'bef54ec653d64a78862b81f5dd48afdb', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('c0eb7965b0524e01a385cb3b044f91cc', '960377d5b6c74972ab6b45f647129ecc', 'ca50d2174b0c42c9824f773ac8c0f275', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('c244842cc047495d868c37a23e9d5f2e', 'cd39c25627cc4e1f9200a2d7cb432735', 'f384e2659e824023b95f35d1bd84d4c9', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('c28c26b2cb334304a80ac78b04a225a6', '960377d5b6c74972ab6b45f647129ecc', 'fb4de75a56574f86b7f455fb7e8de7cf', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('c2b4cc76c121406982f762f17c4abd9e', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '096ca24cadb94aa6a03fe9e9cd8f6f14', '2022-03-03 15:44:33');
INSERT INTO `sys_role_permission` VALUES ('c3306d8842f44629a0f9da59bfcfd20d', 'cd39c25627cc4e1f9200a2d7cb432735', 'adc5cd2824884d14bbb9bca2fac0af3c', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('c457c51bd5924bd89759b745b4bd5c61', '960377d5b6c74972ab6b45f647129ecc', '157c5429d1214839902f65e05e939d29', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('c51e694732394785846dbf77cbb779e3', '960377d5b6c74972ab6b45f647129ecc', '93f7aba124814e2694e6e11df2bcc9a5', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('c5e080c54bf54862b472e66c7addd49e', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'a3d3ae69d4a04044b08afdb1c058a5da', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('c5f0d2353a644e2d9398f57dfe58aa93', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'affd7aa0cc89493f9c03f944b85ac466', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('c65f63ceb8074987906840cd9a21637a', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '18254d278201405982cbca7670c48bda', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('c65ff1b9eaf84c37848d0d20c8ed91ac', '960377d5b6c74972ab6b45f647129ecc', '5a6e9e8b3b584064a583b4e731cdfd18', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('c6fffb36400d4a2e88d265d97a48124b', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '8418b9af3d72471e9edc142c98f1baea', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('c709ad26e70c4393a39a3224d9b6a3f8', 'cd39c25627cc4e1f9200a2d7cb432735', 'ca32759beb8642128be161b7d0dd433f', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('c85bcf6a736b4968a6d1af0e3801bbbe', '960377d5b6c74972ab6b45f647129ecc', '2617ef912c564eb58f6aaf89520e3241', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('c8e7141d8e7549a9a5ca4a054575c045', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '527e91eabbb8445db77757fc51cb7131', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('c8e957f6018542c3b29aaf6935ae7c89', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '70355a9577d746d4a33fa2342ac15a84', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('c9243926b10044e184207acc0edcc1ec', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'dc84e16c24784f5fa935491b9d2bcacd', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('c9cc306f5b6c4a70a414e1473b665c89', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'd4a8758c3da34e30827757cc61e7cde4', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('ca159559bd274cd792d72510f17390c2', 'cd39c25627cc4e1f9200a2d7cb432735', '84d1d3e8833542f3994decbd87936eec', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('cadb06fe51a8481187ad6240c62ceffb', '960377d5b6c74972ab6b45f647129ecc', '65e0683e9184433daa79a66753759b79', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('cb4831d0b808490dbecf281c1b7ceae7', 'cd39c25627cc4e1f9200a2d7cb432735', 'eead81c82ab5420e84fe687a6cdb240a', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('cbc3b8861ca8457c91fddc484e55928a', '960377d5b6c74972ab6b45f647129ecc', '1026b0e03be14c1ca036ec106d0ec660', '2022-04-18 09:34:22');
INSERT INTO `sys_role_permission` VALUES ('cc764b74e56f48698c2894ffe83c1f7a', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '50103e8963e746d89ef7817b1cf31241', '2022-07-28 15:29:51');
INSERT INTO `sys_role_permission` VALUES ('cd1c9c6f2cf44a77ba250a60af04a0df', 'cd39c25627cc4e1f9200a2d7cb432735', '65e0683e9184433daa79a66753759b79', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('cd4451f54c33481ab059c3dc4d70c419', '960377d5b6c74972ab6b45f647129ecc', 'e45de716281c4d859bf612fa41684a44', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('cd494b2f3ddf4f8fb4bc867b59fe6a39', 'cd39c25627cc4e1f9200a2d7cb432735', 'd605bd09b6114764a951e0cbc09ebd98', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('cd72dbab8edd4efa990f82f2b5e7093c', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'a6e0e8483735498fbaa2d26106ffaa49', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('cdc12b3c6a9740ca85c56bec6c8ef309', 'cd39c25627cc4e1f9200a2d7cb432735', '2617ef912c564eb58f6aaf89520e3241', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('cec0bb28270248fdb61f7fb44c758288', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '2971f3d710df48e99fc4b19dfc747266', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('d0c3f73b43d24fec8ddcce5ea1dd91d2', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'b7fd20301ba545d8bce51be32d975869', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('d1076f86849b4594b008f6d924f62043', '960377d5b6c74972ab6b45f647129ecc', 'd0261441a42a4a148178aa3aaf048c36', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('d1ef97e0fb984874a951754337e2602e', 'cd39c25627cc4e1f9200a2d7cb432735', '0f80790e9294448fb29a8ea03c4ac7d2', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('d20ca1ecc20e4bf3a33fdbe2bf539276', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '94eafc7b0e1444a6bbf3f4ea52b99368', '2022-07-28 15:29:51');
INSERT INTO `sys_role_permission` VALUES ('d5413fd917af4403a9cccc6996486fb2', 'cd39c25627cc4e1f9200a2d7cb432735', '0dfc1a45c1a04cdd9ac810ce64c4afbb', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('d7c2570f126f40229850deeea35b75d2', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'd337a26d47284eb48c6a877b81f52ab1', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('d8741f3d26534ef6bc867aaa49e27ff0', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '722ae34c8c97410eb15aaa3e1bd3910c', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('d91c3b8cb11c410ba11c33a6ddc60125', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'cbd0f7faa72e49efbfdc094e078b11bf', '2022-03-03 15:44:33');
INSERT INTO `sys_role_permission` VALUES ('d9208bfee9d64ad4848c5b6592209635', 'cd39c25627cc4e1f9200a2d7cb432735', 'db40bbb647ff45f1aa7661777b1d0134', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('d938e86578e3434ea292d4a8e35bbe51', 'cd39c25627cc4e1f9200a2d7cb432735', 'c45a2629a8514ff4a33ea3cb1174c7ec', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('d983c245d7d547959d1791f9e08e5462', 'cd39c25627cc4e1f9200a2d7cb432735', 'bfd6b1d63bbb4b4598652ac09565759f', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('da7b79d0548448379ed76262f618b497', '960377d5b6c74972ab6b45f647129ecc', 'a6e0e8483735498fbaa2d26106ffaa49', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('db19030a2a01429f95e280f20969fe70', '960377d5b6c74972ab6b45f647129ecc', '20edaccce184448fa24f15aa2759b3d1', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('dd223a90296d4a9f9de134aefd04c793', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '4c8da359f254448e943a33cbaae383c4', '2022-07-28 15:29:51');
INSERT INTO `sys_role_permission` VALUES ('dea11a4834994eb5bdef0db2635783bb', '960377d5b6c74972ab6b45f647129ecc', 'affd7aa0cc89493f9c03f944b85ac466', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('df013443b5e74492bd043d96faadf592', '960377d5b6c74972ab6b45f647129ecc', 'ecd2cb371eb34e279efa683488716b88', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('df9f2796806b42cd8e062b0a94126e14', '960377d5b6c74972ab6b45f647129ecc', 'e698271183e84ec3ae309d027468d3dc', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('dfc24894c7e7428b922c5859eda2ade2', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '157c5429d1214839902f65e05e939d29', '2022-07-28 15:29:51');
INSERT INTO `sys_role_permission` VALUES ('e0124d82a47849f192ae3222243d32c8', 'cd39c25627cc4e1f9200a2d7cb432735', '2861b2b1fc274cd79c43a3dda67cb628', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('e135b89c42be4f54a3372a7fff9fe85e', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '0a261fae6d264d99adb12711c67e1dc5', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('e139f5ef3a894f2d91981b6e13d82b10', '960377d5b6c74972ab6b45f647129ecc', '7348a6ab4be546c8a66758ce2d23795b', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('e1e313cf3d3a4a5098f474be36ddbd29', '960377d5b6c74972ab6b45f647129ecc', '421a8ae169934a1eb307984f8526c3a0', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('e259aebb4a7c4e1ba76a0ec132a3963b', 'cd39c25627cc4e1f9200a2d7cb432735', 'd4a8758c3da34e30827757cc61e7cde4', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('e279e701ec9946eebdc9d417c5c21397', 'cd39c25627cc4e1f9200a2d7cb432735', '68f96e445930404788977ea2acdd23d1', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('e2d078030a174d3494a6d71986bd2629', '960377d5b6c74972ab6b45f647129ecc', 'e72a1ef3ee86439c90f4fc87e02d0043', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('e371ce63235a4e9b9398b67cfd228f73', '960377d5b6c74972ab6b45f647129ecc', 'f46b4c4b77ad489c81a374d72fc39c8f', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('e5de46efd90c4e10abcae23b79b40b22', '960377d5b6c74972ab6b45f647129ecc', '1f6aa9c01bdc41d2b456e6186ed1856c', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('e5f9cd39b4484f3392ff2ae4be4d3057', '960377d5b6c74972ab6b45f647129ecc', '1733d590018a4300bdcb42d2a773e451', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('e60ececc852d4d11a1967233140fe0e7', '960377d5b6c74972ab6b45f647129ecc', '8813764db7b34dc2ad515ba5b66201e4', '2022-04-18 09:34:22');
INSERT INTO `sys_role_permission` VALUES ('e7271572f45d4fa4ae9dc22321e0b1c6', '960377d5b6c74972ab6b45f647129ecc', '03e4758110a04f589b80110501fdd34d', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('e894541d8f0045a79a914b9066f7a6d6', 'cd39c25627cc4e1f9200a2d7cb432735', 'c7dcb23bcf924ce9a1efac91d780b7d2', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('e9747551a6a64f5f8d51d8f5834fb1df', '960377d5b6c74972ab6b45f647129ecc', '2f565daf1bee4b459cdb94bb26a06572', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('ea7ec6c77fd64510930461bc53fd6436', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'f4d97a7bed404563bd982521d2585900', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('eac8c5af08314e2aa8ee71290e7b13eb', '960377d5b6c74972ab6b45f647129ecc', 'ca32759beb8642128be161b7d0dd433f', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('ecc1cb26398a49ad97b80069c3c08196', '960377d5b6c74972ab6b45f647129ecc', '18254d278201405982cbca7670c48bda', '2022-04-18 09:34:22');
INSERT INTO `sys_role_permission` VALUES ('edc30ff866eb49cbb4f198e767644103', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'bfd6b1d63bbb4b4598652ac09565759f', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('ee341171a5e041e6ac7e6342f2eab3f8', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'eead81c82ab5420e84fe687a6cdb240a', '2022-07-28 15:29:51');
INSERT INTO `sys_role_permission` VALUES ('ee53d81ce2a44db3b01e9e8a85a6e3b8', 'cd39c25627cc4e1f9200a2d7cb432735', '60abd7273f0743908097160b769a3e66', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('ef095997392f4ae59e3cef91c8229632', 'cd39c25627cc4e1f9200a2d7cb432735', '03e4758110a04f589b80110501fdd34d', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('ef4e52d7bb12481a9f8199f81fa2f0bd', 'cd39c25627cc4e1f9200a2d7cb432735', 'b3f9ada00bac47e1a4897b31dea9bb43', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('f04a037000a44e198587c2e11a74c038', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '5a6e9e8b3b584064a583b4e731cdfd18', '2022-07-28 15:29:51');
INSERT INTO `sys_role_permission` VALUES ('f1e0fdd4acf64934b073c53c9e6606ef', 'cd39c25627cc4e1f9200a2d7cb432735', '1e9272e8175d4c3b948168f136c2b964', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('f35e72bbd83e49d2bd119cff80c1afc2', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '4e6f9c62dd2a415881cff9108de07e0b', '2022-03-03 15:44:33');
INSERT INTO `sys_role_permission` VALUES ('f3d3bae07d5d48199b5e435bc9e40432', '960377d5b6c74972ab6b45f647129ecc', '46a453d5175649a0819b1add7ffb774d', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('f7ba455fcca34ef6ba3671ed1fed2c2e', 'cd39c25627cc4e1f9200a2d7cb432735', '722ae34c8c97410eb15aaa3e1bd3910c', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('f82bbabe4f514127af78f0e0335f352f', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '4d1555b2e7bf406a91c5713bba13c054', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('f866b34546a5429b9191830496269986', '960377d5b6c74972ab6b45f647129ecc', '2f403f52fc444046b2c1ebc37428d69c', '2022-04-18 09:34:23');
INSERT INTO `sys_role_permission` VALUES ('f9772558d7c744b99eb3f0d676c61562', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', 'f4409af657d84910a3d2aa03008f14e8', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('fd76eeae3a2e4acf9578ba4a95ddc5cd', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '93f7aba124814e2694e6e11df2bcc9a5', '2022-07-28 15:29:52');
INSERT INTO `sys_role_permission` VALUES ('fea71ec3eb124757bba3bedb57041457', 'cd39c25627cc4e1f9200a2d7cb432735', 'e45de716281c4d859bf612fa41684a44', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('ff3e3f53f5734e21a12d536dd37bb19f', 'cd39c25627cc4e1f9200a2d7cb432735', '885ef99a74ea454b881aeb8220c5220a', '2022-04-18 09:34:28');
INSERT INTO `sys_role_permission` VALUES ('ff4a8f455fb5489494cf33a6046844a3', '960377d5b6c74972ab6b45f647129ecc', 'd983d01037f14440a0633e8bec882b55', '2022-04-18 09:34:23');

-- ----------------------------
-- Table structure for sys_tree_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_tree_data`;
CREATE TABLE `sys_tree_data`  (
  `ID` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `SD_CODE` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '编码',
  `SD_NAME` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `SD_PID` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父节点id',
  `SD_LEVEL` int(0) NULL DEFAULT NULL COMMENT '级别',
  `CREATE_TIME` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建时间',
  `UPDATE_TIME` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新时间',
  `SYNC_TIME` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '时间戳',
  `PATH` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '路径',
  `PATH_NAME` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称路径',
  `TYPE` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型',
  `BZ` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `SD_PATH` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '编码路径',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SD_CODE`(`SD_CODE`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '树形数据' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_tree_data
-- ----------------------------
INSERT INTO `sys_tree_data` VALUES ('1920c770b2884a7d9f986fdea116883b', '22', '22', '41e9f47b2c634423ab8977ead3eca5d1', 2, '2021-11-05 17:28:35', NULL, '1636104515005', '#41e9f47b2c634423ab8977ead3eca5d1#1920c770b2884a7d9f986fdea116883b#', '#2#22#', NULL, '22', '#2#22#');
INSERT INTO `sys_tree_data` VALUES ('41e9f47b2c634423ab8977ead3eca5d1', '2', '2', '0', 1, '2021-11-05 17:28:31', NULL, '1636104511811', '#41e9f47b2c634423ab8977ead3eca5d1#', '#2#', NULL, '2', '#2#');
INSERT INTO `sys_tree_data` VALUES ('60246fd9dbc74be391d05349b6b6b499', '1', '珠海市', '0', 1, '2021-11-05 17:28:14', '2021-11-10 18:07:19', '1636104494436', '#60246fd9dbc74be391d05349b6b6b499#', '#珠海市#', NULL, NULL, '#1#');
INSERT INTO `sys_tree_data` VALUES ('7351f3356ce14ce4a249b2be14cdc13b', '222', '222', '1920c770b2884a7d9f986fdea116883b', 3, '2021-11-05 17:28:39', NULL, '1636104519763', '#41e9f47b2c634423ab8977ead3eca5d1#1920c770b2884a7d9f986fdea116883b#7351f3356ce14ce4a249b2be14cdc13b#', '#2#22#222#', NULL, '222', '#2#22#222#');
INSERT INTO `sys_tree_data` VALUES ('acd51c9f76f64c4c93b8a4d437821c6c', '111', '吉大街道', 'b09c9452faf847b7a80990cdea42256c', 3, '2021-11-05 17:28:23', '2021-11-10 18:07:34', '1636104503980', '#60246fd9dbc74be391d05349b6b6b499#b09c9452faf847b7a80990cdea42256c#acd51c9f76f64c4c93b8a4d437821c6c#', '#珠海市#香洲区#吉大街道#', NULL, NULL, '#1#11#111#');
INSERT INTO `sys_tree_data` VALUES ('b09c9452faf847b7a80990cdea42256c', '11', '香洲区', '60246fd9dbc74be391d05349b6b6b499', 2, '2021-11-05 17:28:19', '2021-11-10 18:07:26', '1636104499947', '#60246fd9dbc74be391d05349b6b6b499#b09c9452faf847b7a80990cdea42256c#', '#珠海市#香洲区#', NULL, NULL, '#1#11#');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `ID` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户ID',
  `PHONE` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号码',
  `REAL_NAME` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '真实名称',
  `SEX` int(0) NULL DEFAULT NULL COMMENT '性别(1.男 2.女)',
  `CREATE_TIME` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建时间',
  `UPDATE_TIME` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新时间',
  `SYNC_TIME` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '时间戳',
  `JH` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '警号',
  `ZJHM` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '证件号码',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_mysql500_ci COMMENT = '系统用户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('6d4cf79df7494715bba5397187470079', 'admin1', 'admin', NULL, '2021-03-10 15:45:06', NULL, NULL, NULL, 'admin');
INSERT INTO `sys_user` VALUES ('c7fccf98101d4e55ba76170213fe6ef9', NULL, 'aaa1', NULL, '2021-11-11 16:02:29', NULL, NULL, '123', '123');

-- ----------------------------
-- Table structure for sys_user_company
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_company`;
CREATE TABLE `sys_user_company`  (
  `ID` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键id',
  `USER_LOGIN_ID` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户登录id',
  `SQDM` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '社区代码',
  `CREATE_TIME` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建时间',
  `UPDATE_TIME` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新时间',
  `SYNC_TIME` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '时间戳',
  `PCSDM` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '派出所代码',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户单位中间表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_company
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user_login
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_login`;
CREATE TABLE `sys_user_login`  (
  `ID` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `CREATE_TIME` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建时间',
  `UPDATE_TIME` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新时间',
  `SYNC_TIME` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '时间戳',
  `STATUS` int(0) NULL DEFAULT NULL COMMENT '账户状态(0.正常 1.锁定 )',
  `ACCOUNT` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登录账号',
  `SALT` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '加密盐值',
  `PASSWORD` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `ENCRYPTION_PASSWORD` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '加密密码',
  `LAST_LOGIN_TIME` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后登录时间',
  `USER_ID` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户ID',
  `SD_ID` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '单位id',
  `TYPE` int(0) NULL DEFAULT NULL COMMENT '账号类型',
  `abnormal_num` int(0) NULL DEFAULT NULL COMMENT '超过3次密码错误则每错一次禁30分钟 5次则锁定',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_mysql500_ci COMMENT = '用户登录账号表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_login
-- ----------------------------
INSERT INTO `sys_user_login` VALUES ('4acf530555284c03a558c0f768444363', '2021-03-10 15:45:06', '2021-11-11 11:02:31', '1615362306246', 0, 'admin', 'a57ab9aad1814ba59872', '111111', 'ecce98e6bd2821cc415235386f07448a', '2022-07-28 14:10:17', '6d4cf79df7494715bba5397187470079', NULL, 0, 0);
INSERT INTO `sys_user_login` VALUES ('f4753fa4f0b84be0bb61291b92fccceb', '2021-11-11 16:02:29', '2021-11-24 15:21:54', '1636617749428', 0, '123', 'bcbffe9dcad1461fb2a6', '123456', '6b337b04b0305dfb4ff5c6f0728fc6a0', NULL, 'c7fccf98101d4e55ba76170213fe6ef9', NULL, 0, 0);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `ID` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户ID',
  `USER_ID` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ROLE_ID` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色ID',
  `CREATE_TIME` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建时间',
  `SD_CODE` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '单位编码',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_mysql500_ci COMMENT = '系统用户角色' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('95d9e37225ef41488a4e0192b6496180', '4acf530555284c03a558c0f768444363', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '2021-03-10 07:45:06.168', NULL);
INSERT INTO `sys_user_role` VALUES ('9a64ab781f2b4b8b91eeeca2fa39beab', 'f4753fa4f0b84be0bb61291b92fccceb', '11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9', '2021-11-11 16:02:29', NULL);

-- ----------------------------
-- Table structure for white_region_info
-- ----------------------------
DROP TABLE IF EXISTS `white_region_info`;
CREATE TABLE `white_region_info`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `city` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '城市',
  `create_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sync_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `region` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '省',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统访问地区白名单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of white_region_info
-- ----------------------------
INSERT INTO `white_region_info` VALUES ('d4aa9ff83a9e4576bdf68e8230a3ca9a', '珠海', '2022-03-01 17:30:27', NULL, '1646127027593', '广东');

-- ----------------------------
-- View structure for sys_user_login_view
-- ----------------------------
DROP VIEW IF EXISTS `sys_user_login_view`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `sys_user_login_view` AS select `sys_user_login`.`STATUS` AS `STATUS`,`sys_user_login`.`ACCOUNT` AS `ACCOUNT`,`sys_user_login`.`SALT` AS `SALT`,`sys_user_login`.`PASSWORD` AS `PASSWORD`,`sys_user_login`.`ENCRYPTION_PASSWORD` AS `ENCRYPTION_PASSWORD`,`sys_user_login`.`LAST_LOGIN_TIME` AS `LAST_LOGIN_TIME`,`sys_user_login`.`USER_ID` AS `USER_ID`,`sys_user_login`.`SD_ID` AS `SD_ID`,`sys_user_login`.`abnormal_num` AS `abnormal_num`,`sys_user_login`.`TYPE` AS `TYPE`,`sys_user_login`.`ID` AS `ID`,`sys_user`.`REAL_NAME` AS `REAL_NAME`,`sys_user`.`PHONE` AS `PHONE`,`sys_user`.`SEX` AS `SEX`,`sys_user`.`JH` AS `JH`,`sys_user`.`ZJHM` AS `ZJHM`,`sys_user_company`.`SQDM` AS `SD_CODE`,`sys_user_role`.`ROLE_ID` AS `ROLE_ID`,`sys_tree_data`.`SD_NAME` AS `SD_NAME`,`sys_tree_data`.`PATH` AS `PATH`,`sys_tree_data`.`SD_PATH` AS `SD_PATH`,`sys_user_login`.`CREATE_TIME` AS `CREATE_TIME`,`sys_user_role`.`ID` AS `relate_id`,`sys_role`.`NAME` AS `role_name` from (((((`sys_user_login` left join `sys_user` on((`sys_user_login`.`USER_ID` = `sys_user`.`ID`))) left join `sys_user_role` on((`sys_user_role`.`USER_ID` = `sys_user_login`.`ID`))) left join `sys_user_company` on((`sys_user_company`.`USER_LOGIN_ID` = `sys_user_login`.`ID`))) left join `sys_tree_data` on((`sys_user_company`.`SQDM` = `sys_tree_data`.`SD_CODE`))) left join `sys_role` on((`sys_user_role`.`ROLE_ID` = `sys_role`.`ID`)));

SET FOREIGN_KEY_CHECKS = 1;
