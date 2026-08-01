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

 Date: 01/08/2026 00:00:00
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_medical_videos
-- ----------------------------
DROP TABLE IF EXISTS `t_medical_videos`;
CREATE TABLE `t_medical_videos`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `criminal_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '罪犯编号 (关联 t_criminals_archive.criminal_no)',
  `video_file_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '就医视频文件路径',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '视频录入时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_criminal_no`(`criminal_no` ASC) USING BTREE,
  CONSTRAINT `fk_video_criminal_no` FOREIGN KEY (`criminal_no`) REFERENCES `t_criminals_archive` (`criminal_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '罪犯就医视频表' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
