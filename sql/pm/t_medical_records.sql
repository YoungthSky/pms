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

 Date: 31/07/2026 22:04:33
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_medical_records  就医记录表
-- ----------------------------
DROP TABLE IF EXISTS `t_medical_records`;
CREATE TABLE `t_medical_records`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `criminal_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '罪犯编号 (关联 t_criminals_archive.criminal_no)',
  `medical_type` tinyint NOT NULL COMMENT '就医类型: 1-狱内就医 2-离监就医',
  `record_file_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '就医记录文件路径 (图片/PDF/文档)',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '就医记录录入时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_criminal_no`(`criminal_no` ASC) USING BTREE,
  CONSTRAINT `fk_medical_criminal_no` FOREIGN KEY (`criminal_no`) REFERENCES `t_criminals_archive` (`criminal_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '罪犯就医记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_medical_records
-- ----------------------------
INSERT INTO `t_medical_records` VALUES (1, 'Z-2023-1001', 1, '/data/files/medical/Z-2023-1001/2023/11/medical_rec_001.pdf', '2026-07-28 20:00:17');
INSERT INTO `t_medical_records` VALUES (2, 'Z-2023-1001', 3, '/data/files/medical/Z-2023-1001/2024/01/medical_rec_002.pdf', '2026-07-28 20:00:17');
INSERT INTO `t_medical_records` VALUES (3, 'Z-2023-1002', 2, '/data/files/medical/Z-2023-1002/2023/12/medical_rec_001.pdf', '2026-07-28 20:00:17');
INSERT INTO `t_medical_records` VALUES (4, 'Z-2023-1003', 1, '/data/files/medical/Z-2023-1003/2023/10/medical_rec_001.pdf', '2026-07-28 20:00:17');
INSERT INTO `t_medical_records` VALUES (5, 'Z-2023-1003', 1, '/data/files/medical/Z-2023-1003/2024/02/medical_rec_002.pdf', '2026-07-28 20:00:17');
INSERT INTO `t_medical_records` VALUES (6, 'Z-2023-1003', 3, '/data/files/medical/Z-2023-1003/2024/03/medical_rec_003.pdf', '2026-07-28 20:00:17');
INSERT INTO `t_medical_records` VALUES (7, 'Z-2023-1004', 2, '/data/files/medical/Z-2023-1004/2023/11/medical_rec_001.pdf', '2026-07-28 20:00:17');
INSERT INTO `t_medical_records` VALUES (8, 'Z-2023-1005', 3, '/data/files/medical/Z-2023-1005/2023/12/medical_rec_001.pdf', '2026-07-28 20:00:17');
INSERT INTO `t_medical_records` VALUES (9, 'Z-2023-1005', 1, '/data/files/medical/Z-2023-1005/2024/01/medical_rec_002.pdf', '2026-07-28 20:00:17');
INSERT INTO `t_medical_records` VALUES (10, 'Z-2023-1006', 2, '/data/files/medical/Z-2023-1006/2023/10/medical_rec_001.pdf', '2026-07-28 20:00:17');
INSERT INTO `t_medical_records` VALUES (11, 'Z-2023-1006', 1, '/data/files/medical/Z-2023-1006/2023/12/medical_rec_002.pdf', '2026-07-28 20:00:17');
INSERT INTO `t_medical_records` VALUES (12, 'Z-2023-1006', 3, '/data/files/medical/Z-2023-1006/2024/02/medical_rec_003.pdf', '2026-07-28 20:00:17');
INSERT INTO `t_medical_records` VALUES (13, 'Z-2023-1007', 1, '/data/files/medical/Z-2023-1007/2024/01/medical_rec_001.pdf', '2026-07-28 20:00:17');
INSERT INTO `t_medical_records` VALUES (14, 'Z-2023-1008', 3, '/data/files/medical/Z-2023-1008/2023/11/medical_rec_001.pdf', '2026-07-28 20:00:17');
INSERT INTO `t_medical_records` VALUES (15, 'Z-2023-1008', 2, '/data/files/medical/Z-2023-1008/2024/03/medical_rec_002.pdf', '2026-07-28 20:00:17');
INSERT INTO `t_medical_records` VALUES (16, 'Z-2023-1009', 1, '/data/files/medical/Z-2023-1009/2023/10/medical_rec_001.pdf', '2026-07-28 20:00:17');
INSERT INTO `t_medical_records` VALUES (17, 'Z-2023-1009', 2, '/data/files/medical/Z-2023-1009/2023/12/medical_rec_002.pdf', '2026-07-28 20:00:17');
INSERT INTO `t_medical_records` VALUES (18, 'Z-2023-1009', 1, '/data/files/medical/Z-2023-1009/2024/02/medical_rec_003.pdf', '2026-07-28 20:00:17');
INSERT INTO `t_medical_records` VALUES (19, 'Z-2023-1010', 3, '/data/files/medical/Z-2023-1010/2024/01/medical_rec_001.pdf', '2026-07-28 20:00:17');

SET FOREIGN_KEY_CHECKS = 1;
