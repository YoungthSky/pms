/*
 Navicat Premium Dump SQL

 Source Server         : MySql
 Source Server Type    : MySQL
 Source Server Version : 80046 (8.0.46)
 Source Host           : localhost:3306
 Source Schema         : pms

 Target Server Type    : MySQL
 Target Server Version : 80046 (8.0.46)
 File Encoding         : 65001

 Date: 31/07/2026 22:06:53
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_criminals_archive
-- ----------------------------
DROP TABLE IF EXISTS `t_criminals_archive`;
CREATE TABLE `t_criminals_archive`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `uuid` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT (uuid()) COMMENT '全局唯一标识符(UUID)',
  `criminal_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '罪犯编号(唯一业务标识)',
  `criminal_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '罪犯姓名',
  `basic_info_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '基本信息文件存储路径(如PDF/JSON路径)',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `created_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '录入人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_uuid`(`uuid` ASC) USING BTREE,
  UNIQUE INDEX `uk_criminal_no`(`criminal_no` ASC) USING BTREE,
  INDEX `idx_criminal_name`(`criminal_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '罪犯基础档案表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_criminals_archive
-- ----------------------------
INSERT INTO `t_criminals_archive` VALUES (1, '02cff740-8996-11f1-b458-b025aa41a4ed', 'Z-2023-1001', '张伟', '/data/files/criminals/Z-2023-1001_profile.pdf', '2026-07-27 16:34:41', '2026-07-27 16:34:41', 'admin');
INSERT INTO `t_criminals_archive` VALUES (2, '02cffc29-8996-11f1-b458-b025aa41a4ed', 'Z-2023-1002', '李娜', '/data/files/criminals/Z-2023-1002_profile.pdf', '2026-07-27 16:34:41', '2026-07-27 16:34:41', 'admin');
INSERT INTO `t_criminals_archive` VALUES (3, '02cffd7f-8996-11f1-b458-b025aa41a4ed', 'Z-2023-1003', '王强', '/data/files/criminals/Z-2023-1003_profile.pdf', '2026-07-27 16:34:41', '2026-07-27 16:34:41', 'operator_01');
INSERT INTO `t_criminals_archive` VALUES (4, '02cffe51-8996-11f1-b458-b025aa41a4ed', 'Z-2023-1004', '刘洋', '/data/files/criminals/Z-2023-1004_profile.pdf', '2026-07-27 16:34:41', '2026-07-27 16:34:41', 'operator_01');
INSERT INTO `t_criminals_archive` VALUES (5, '02cfff10-8996-11f1-b458-b025aa41a4ed', 'Z-2023-1005', '陈静', '/data/files/criminals/Z-2023-1005_profile.pdf', '2026-07-27 16:34:41', '2026-07-27 16:34:41', 'admin');
INSERT INTO `t_criminals_archive` VALUES (6, '02cfffda-8996-11f1-b458-b025aa41a4ed', 'Z-2023-1006', '杨秀英', '/data/files/criminals/Z-2023-1006_profile.pdf', '2026-07-27 16:34:41', '2026-07-27 16:34:41', 'operator_02');
INSERT INTO `t_criminals_archive` VALUES (7, '02d00093-8996-11f1-b458-b025aa41a4ed', 'Z-2023-1007', '赵军', '/data/files/criminals/Z-2023-1007_profile.pdf', '2026-07-27 16:34:41', '2026-07-27 16:34:41', 'admin');
INSERT INTO `t_criminals_archive` VALUES (8, '02d0014f-8996-11f1-b458-b025aa41a4ed', 'Z-2023-1008', '黄勇', '/data/files/criminals/Z-2023-1008_profile.pdf', '2026-07-27 16:34:41', '2026-07-27 16:34:41', 'operator_01');
INSERT INTO `t_criminals_archive` VALUES (9, '02d00239-8996-11f1-b458-b025aa41a4ed', 'Z-2023-1009', '周敏', '/data/files/criminals/Z-2023-1009_profile.pdf', '2026-07-27 16:34:41', '2026-07-27 16:34:41', 'operator_02');
INSERT INTO `t_criminals_archive` VALUES (10, '02d00420-8996-11f1-b458-b025aa41a4ed', 'Z-2023-1010', '吴刚', '/data/files/criminals/Z-2023-1010_profile.pdf', '2026-07-27 16:34:41', '2026-07-27 16:34:41', 'admin');
INSERT INTO `t_criminals_archive` VALUES (11, '4a114b6b-8a35-11f1-980e-b025aa41a4ed', 'z-2023-1011', '赵四', NULL, '2026-07-28 11:34:50', '2026-07-28 11:34:50', NULL);
INSERT INTO `t_criminals_archive` VALUES (12, 'de7326f7-8b1d-11f1-980e-b025aa41a4ed', '11111111111', '杜月笙', NULL, '2026-07-29 15:19:42', '2026-07-29 15:19:42', NULL);

SET FOREIGN_KEY_CHECKS = 1;
