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

 Date: 31/07/2026 22:03:11
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `form_col_num` int NULL DEFAULT 1 COMMENT '表单布局（单列 双列 三列）',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (8, 't_criminals_archive', '罪犯基础档案表', NULL, NULL, 'CriminalsArchive', 'crud', 'element-plus-typescript', 'com.pms.system', 'system', 'archive', '罪犯基础档案', 'LiuZhengPing', 1, '0', '/', '{\"genView\":\"0\",\"parentMenuId\":4}', 'admin', '2026-07-28 09:59:04', '', '2026-07-28 10:07:18', NULL);
INSERT INTO `gen_table` VALUES (9, 't_medical_records', '罪犯就医记录表', NULL, NULL, 'MedicalRecords', 'crud', 'element-plus-typescript', 'com.pms.pm', 'pm', 'medical', '罪犯就医记录', 'LiuZhengPing', 1, '0', '/', '{\"genView\":\"0\",\"parentMenuId\":4}', 'admin', '2026-07-28 20:03:53', '', '2026-07-28 20:10:44', NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 70 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (57, 8, 'id', '自增主键', 'bigint unsigned', 'String', 'id', '1', '1', '0', '0', NULL, NULL, NULL, 'EQ', NULL, '', 1, 'admin', '2026-07-28 09:59:04', '', '2026-07-28 10:07:18');
INSERT INTO `gen_table_column` VALUES (58, 8, 'uuid', '全局唯一标识符(UUID)', 'char(36)', 'String', 'uuid', '0', '0', '1', '0', '0', '0', '0', 'EQ', 'input', '', 2, 'admin', '2026-07-28 09:59:04', '', '2026-07-28 10:07:18');
INSERT INTO `gen_table_column` VALUES (59, 8, 'criminal_no', '罪犯编号(唯一业务标识)', 'varchar(20)', 'String', 'criminalNo', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2026-07-28 09:59:04', '', '2026-07-28 10:07:18');
INSERT INTO `gen_table_column` VALUES (60, 8, 'criminal_name', '罪犯姓名', 'varchar(50)', 'String', 'criminalName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 4, 'admin', '2026-07-28 09:59:04', '', '2026-07-28 10:07:18');
INSERT INTO `gen_table_column` VALUES (61, 8, 'basic_info_path', '基本信息文件存储路径(如PDF/JSON路径)', 'varchar(255)', 'String', 'basicInfoPath', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'imageUpload', '', 5, 'admin', '2026-07-28 09:59:04', '', '2026-07-28 10:07:18');
INSERT INTO `gen_table_column` VALUES (62, 8, 'created_at', '创建时间', 'datetime', 'Date', 'createdAt', '0', '0', '1', '0', '0', '0', '0', 'EQ', 'datetime', '', 6, 'admin', '2026-07-28 09:59:04', '', '2026-07-28 10:07:18');
INSERT INTO `gen_table_column` VALUES (63, 8, 'updated_at', '更新时间', 'datetime', 'Date', 'updatedAt', '0', '0', '1', '0', '0', '0', '0', 'EQ', 'datetime', '', 7, 'admin', '2026-07-28 09:59:04', '', '2026-07-28 10:07:18');
INSERT INTO `gen_table_column` VALUES (64, 8, 'created_by', '录入人', 'varchar(50)', 'String', 'createdBy', '0', '0', '0', '0', '0', '0', '0', 'EQ', 'input', '', 8, 'admin', '2026-07-28 09:59:04', '', '2026-07-28 10:07:18');
INSERT INTO `gen_table_column` VALUES (65, 9, 'id', '自增主键', 'bigint unsigned', 'String', 'id', '1', '1', '0', '0', NULL, NULL, NULL, 'EQ', NULL, '', 1, 'admin', '2026-07-28 20:03:53', '', '2026-07-28 20:10:44');
INSERT INTO `gen_table_column` VALUES (66, 9, 'criminal_no', '罪犯编号 (关联 t_criminals_archive.criminal_no)', 'varchar(20)', 'String', 'criminalNo', '0', '0', '0', '0', '0', '0', '0', 'EQ', 'input', '', 2, 'admin', '2026-07-28 20:03:53', '', '2026-07-28 20:10:44');
INSERT INTO `gen_table_column` VALUES (67, 9, 'medical_type', '就医类型: 1-狱内就医 2-离监就医', 'tinyint', 'Long', 'medicalType', '0', '0', '0', '0', '0', '0', '0', 'EQ', 'select', '', 3, 'admin', '2026-07-28 20:03:53', '', '2026-07-28 20:10:44');
INSERT INTO `gen_table_column` VALUES (68, 9, 'record_file_path', '就医记录', 'varchar(500)', 'String', 'recordFilePath', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'textarea', '', 4, 'admin', '2026-07-28 20:03:53', '', '2026-07-28 20:10:44');
INSERT INTO `gen_table_column` VALUES (69, 9, 'created_at', '录入时间', 'datetime', 'Date', 'createdAt', '0', '0', '1', '0', '0', '1', '0', 'EQ', 'datetime', '', 5, 'admin', '2026-07-28 20:03:53', '', '2026-07-28 20:10:44');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2026-07-26 16:19:03', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2026-07-26 16:19:03', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2026-07-26 16:19:03', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'false', 'Y', 'admin', '2026-07-26 16:19:03', 'admin', '2026-07-26 18:00:11', '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2026-07-26 16:19:03', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2026-07-26 16:19:03', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
INSERT INTO `sys_config` VALUES (7, '用户管理-初始密码修改策略', 'sys.account.initPasswordModify', '1', 'Y', 'admin', '2026-07-26 16:19:03', '', NULL, '0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` VALUES (8, '用户管理-账号密码更新周期', 'sys.account.passwordValidateDays', '0', 'Y', 'admin', '2026-07-26 16:19:03', '', NULL, '密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` VALUES (9, '用户管理-密码字符范围', 'sys.account.chrtype', '0', 'Y', 'admin', '2026-07-26 16:19:03', '', NULL, '默认任意字符范围，0任意（密码可以输入任意字符），1数字（密码只能为0-9数字），2英文字母（密码只能为a-z和A-Z字母），3字母和数字（密码必须包含字母，数字）,4字母数字和特殊字符（目前支持的特殊字符包括：~!@#$%^&*()-=_+）');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '甘孜监狱', 0, '甘孜监狱长', '15888888888', 'admin@qq.com', '0', '0', 'admin', '2026-07-26 16:18:58', 'admin', '2026-07-27 11:49:51');
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '名山监区', 1, '岷山监狱长', '15888888888', 'adminMS@qq.com', '0', '0', 'admin', '2026-07-26 16:18:58', 'admin', '2026-07-27 11:51:23');
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '甘孜监区', 2, '甘孜监狱长', '15888888888', 'adminGZ@qq.com', '0', '0', 'admin', '2026-07-26 16:18:58', 'admin', '2026-07-27 11:52:00');
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '办公室', 1, '', '15888888888', '', '0', '0', 'admin', '2026-07-26 16:18:58', 'admin', '2026-07-27 11:53:10');
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '狱政科', 2, '陈科长', '15888888888', 'Chen@qq.com', '0', '0', 'admin', '2026-07-26 16:18:58', 'admin', '2026-07-27 11:54:08');
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '教育改造科', 3, '', '15888888888', '', '0', '0', 'admin', '2026-07-26 16:18:58', 'admin', '2026-07-27 11:56:03');
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2026-07-26 16:18:58', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2026-07-26 16:18:58', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '办公室', 1, '', '15888888888', '', '0', '0', 'admin', '2026-07-26 16:18:58', 'admin', '2026-07-27 11:55:07');
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '狱政科', 2, '', '15888888888', '', '0', '0', 'admin', '2026-07-26 16:18:58', 'admin', '2026-07-27 11:55:21');

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '停用状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2026-07-26 16:19:02', '', NULL, '登录状态列表');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2026-07-26 16:19:03', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2026-07-26 16:19:03', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2026-07-26 16:19:03', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '异常信息',
  `start_time` datetime NULL DEFAULT NULL COMMENT '执行开始时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '执行结束时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 192 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-26 16:32:14');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '退出成功', '2026-07-26 16:41:46');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-26 16:42:21');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '退出成功', '2026-07-26 16:44:57');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-26 16:45:02');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '退出成功', '2026-07-26 16:49:01');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-26 16:49:07');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '退出成功', '2026-07-26 17:34:01');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-26 17:47:28');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '退出成功', '2026-07-26 18:00:17');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-26 18:00:23');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '退出成功', '2026-07-26 18:00:32');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '1', '用户不存在/密码错误', '2026-07-26 18:00:51');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-26 18:00:59');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '退出成功', '2026-07-26 18:02:06');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-26 18:48:08');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '退出成功', '2026-07-26 18:48:23');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '1', '用户不存在/密码错误', '2026-07-26 18:48:52');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '1', '用户不存在/密码错误', '2026-07-26 18:48:56');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '1', '用户不存在/密码错误', '2026-07-26 18:49:25');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '1', '用户不存在/密码错误', '2026-07-26 18:52:52');
INSERT INTO `sys_logininfor` VALUES (121, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '1', '用户不存在/密码错误', '2026-07-26 18:53:24');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '1', '用户不存在/密码错误', '2026-07-26 18:53:32');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '1', '用户不存在/密码错误，找回密码请联系管理员', '2026-07-26 18:54:27');
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '1', '用户不存在/密码错误，找回密码请联系管理员', '2026-07-26 18:54:54');
INSERT INTO `sys_logininfor` VALUES (125, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '1', '用户不存在/密码错误，找回密码请联系管理员', '2026-07-26 18:55:03');
INSERT INTO `sys_logininfor` VALUES (126, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '1', '用户不存在/密码错误，找回密码请联系管理员', '2026-07-26 18:55:09');
INSERT INTO `sys_logininfor` VALUES (127, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '1', '用户不存在/密码错误，找回密码请联系管理员', '2026-07-26 18:55:14');
INSERT INTO `sys_logininfor` VALUES (128, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '1', '用户不存在/密码错误，找回密码请联系管理员', '2026-07-26 18:55:50');
INSERT INTO `sys_logininfor` VALUES (129, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '1', '用户不存在/密码错误，找回密码请联系管理员', '2026-07-26 18:55:53');
INSERT INTO `sys_logininfor` VALUES (130, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-26 19:03:22');
INSERT INTO `sys_logininfor` VALUES (131, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-27 11:31:46');
INSERT INTO `sys_logininfor` VALUES (132, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '退出成功', '2026-07-27 11:32:24');
INSERT INTO `sys_logininfor` VALUES (133, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-27 11:32:26');
INSERT INTO `sys_logininfor` VALUES (134, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '退出成功', '2026-07-27 12:15:58');
INSERT INTO `sys_logininfor` VALUES (135, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-27 12:16:00');
INSERT INTO `sys_logininfor` VALUES (136, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-27 12:43:45');
INSERT INTO `sys_logininfor` VALUES (137, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-27 12:45:39');
INSERT INTO `sys_logininfor` VALUES (138, 'admin', '127.0.0.1', '内网IP', 'Chrome 150', 'Windows10', '0', '登录成功', '2026-07-27 12:55:41');
INSERT INTO `sys_logininfor` VALUES (139, 'admin', '127.0.0.1', '内网IP', 'Chrome 150', 'Windows10', '0', '登录成功', '2026-07-27 12:57:07');
INSERT INTO `sys_logininfor` VALUES (140, 'admin', '127.0.0.1', '内网IP', 'Chrome 150', 'Windows10', '0', '登录成功', '2026-07-27 12:58:33');
INSERT INTO `sys_logininfor` VALUES (141, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-27 13:03:06');
INSERT INTO `sys_logininfor` VALUES (142, 'admin', '127.0.0.1', '内网IP', 'Chrome 150', 'Windows10', '1', '用户不存在/密码错误，找回密码请联系管理员', '2026-07-27 15:44:02');
INSERT INTO `sys_logininfor` VALUES (143, 'admin', '127.0.0.1', '内网IP', 'Chrome 150', 'Windows10', '0', '登录成功', '2026-07-27 15:44:03');
INSERT INTO `sys_logininfor` VALUES (144, 'admin', '127.0.0.1', '内网IP', 'Chrome 150', 'Windows10', '0', '退出成功', '2026-07-27 15:45:34');
INSERT INTO `sys_logininfor` VALUES (145, 'admin', '127.0.0.1', '内网IP', 'Chrome 150', 'Windows10', '0', '登录成功', '2026-07-27 15:45:44');
INSERT INTO `sys_logininfor` VALUES (146, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-27 16:36:47');
INSERT INTO `sys_logininfor` VALUES (147, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '退出成功', '2026-07-27 18:01:17');
INSERT INTO `sys_logininfor` VALUES (148, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-27 18:01:19');
INSERT INTO `sys_logininfor` VALUES (149, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-27 19:07:54');
INSERT INTO `sys_logininfor` VALUES (150, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '退出成功', '2026-07-27 19:07:54');
INSERT INTO `sys_logininfor` VALUES (151, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-27 20:08:59');
INSERT INTO `sys_logininfor` VALUES (152, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '退出成功', '2026-07-27 20:16:57');
INSERT INTO `sys_logininfor` VALUES (153, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-27 20:16:59');
INSERT INTO `sys_logininfor` VALUES (154, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-27 20:45:30');
INSERT INTO `sys_logininfor` VALUES (155, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '退出成功', '2026-07-27 20:45:30');
INSERT INTO `sys_logininfor` VALUES (156, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-28 09:07:13');
INSERT INTO `sys_logininfor` VALUES (157, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-28 09:58:11');
INSERT INTO `sys_logininfor` VALUES (158, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-28 11:03:03');
INSERT INTO `sys_logininfor` VALUES (159, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '退出成功', '2026-07-28 11:32:14');
INSERT INTO `sys_logininfor` VALUES (160, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-28 11:32:17');
INSERT INTO `sys_logininfor` VALUES (161, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-28 14:35:55');
INSERT INTO `sys_logininfor` VALUES (162, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '退出成功', '2026-07-28 14:44:27');
INSERT INTO `sys_logininfor` VALUES (163, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-28 14:44:29');
INSERT INTO `sys_logininfor` VALUES (164, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-28 15:48:03');
INSERT INTO `sys_logininfor` VALUES (165, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-28 16:24:55');
INSERT INTO `sys_logininfor` VALUES (166, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '退出成功', '2026-07-28 16:30:52');
INSERT INTO `sys_logininfor` VALUES (167, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-28 16:30:52');
INSERT INTO `sys_logininfor` VALUES (168, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '退出成功', '2026-07-28 16:39:53');
INSERT INTO `sys_logininfor` VALUES (169, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-28 16:40:07');
INSERT INTO `sys_logininfor` VALUES (170, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-28 16:58:55');
INSERT INTO `sys_logininfor` VALUES (171, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-28 17:18:31');
INSERT INTO `sys_logininfor` VALUES (172, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-28 18:22:49');
INSERT INTO `sys_logininfor` VALUES (173, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '退出成功', '2026-07-28 18:43:28');
INSERT INTO `sys_logininfor` VALUES (174, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-28 18:43:29');
INSERT INTO `sys_logininfor` VALUES (175, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-28 20:03:00');
INSERT INTO `sys_logininfor` VALUES (176, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '退出成功', '2026-07-28 20:21:32');
INSERT INTO `sys_logininfor` VALUES (177, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-28 20:21:32');
INSERT INTO `sys_logininfor` VALUES (178, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '退出成功', '2026-07-28 20:25:57');
INSERT INTO `sys_logininfor` VALUES (179, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-28 20:26:00');
INSERT INTO `sys_logininfor` VALUES (180, 'admin', '127.0.0.1', '内网IP', 'Chrome 150', 'Windows10', '0', '登录成功', '2026-07-29 15:11:00');
INSERT INTO `sys_logininfor` VALUES (181, 'admin', '127.0.0.1', '内网IP', 'Chrome 150', 'Windows10', '0', '退出成功', '2026-07-29 15:11:32');
INSERT INTO `sys_logininfor` VALUES (182, 'admin', '127.0.0.1', '内网IP', 'Chrome 150', 'Windows10', '0', '登录成功', '2026-07-29 15:11:59');
INSERT INTO `sys_logininfor` VALUES (183, 'admin', '127.0.0.1', '内网IP', 'Chrome 150', 'Windows10', '0', '退出成功', '2026-07-29 15:13:34');
INSERT INTO `sys_logininfor` VALUES (184, 'admin', '127.0.0.1', '内网IP', 'Chrome 150', 'Windows10', '1', '用户不存在/密码错误，找回密码请联系管理员', '2026-07-29 15:13:53');
INSERT INTO `sys_logininfor` VALUES (185, 'admin', '127.0.0.1', '内网IP', 'Chrome 150', 'Windows10', '0', '登录成功', '2026-07-29 15:14:09');
INSERT INTO `sys_logininfor` VALUES (186, 'admin', '127.0.0.1', '内网IP', 'Chrome 150', 'Windows10', '0', '登录成功', '2026-07-29 15:33:08');
INSERT INTO `sys_logininfor` VALUES (187, 'admin', '127.0.0.1', '内网IP', 'Chrome 150', 'Windows10', '0', '登录成功', '2026-07-29 17:07:26');
INSERT INTO `sys_logininfor` VALUES (188, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-29 17:46:02');
INSERT INTO `sys_logininfor` VALUES (189, 'admin', '127.0.0.1', '内网IP', 'Safari 26.5.2', 'Mac OS >=10.15.7', '0', '登录成功', '2026-07-29 17:47:15');
INSERT INTO `sys_logininfor` VALUES (190, 'admin', '127.0.0.1', '内网IP', 'Chrome 150', 'Windows10', '0', '登录成功', '2026-07-29 17:50:07');
INSERT INTO `sys_logininfor` VALUES (191, 'admin', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-31 12:03:24');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2025 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2026-07-26 16:18:59', 'admin', '2026-07-27 18:30:29', '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2026-07-26 16:18:59', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2026-07-26 16:18:59', '', NULL, '系统工具目录');
INSERT INTO `sys_menu` VALUES (4, '罪犯管理', 0, 0, 'pm', NULL, '', '', 1, 0, 'M', '0', '0', '', 'peoples', 'admin', '2026-07-26 16:18:59', 'admin', '2026-07-28 17:10:24', '若依官网地址');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2026-07-26 16:18:59', 'admin', '2026-07-27 12:16:51', '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2026-07-26 16:18:59', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2026-07-26 16:18:59', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2026-07-26 16:18:59', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2026-07-26 16:18:59', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2026-07-26 16:18:59', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2026-07-26 16:18:59', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2026-07-26 16:18:59', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2026-07-26 16:18:59', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2026-07-26 16:18:59', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2026-07-26 16:18:59', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2026-07-26 16:18:59', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2026-07-26 16:18:59', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2026-07-26 16:18:59', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2026-07-26 16:18:59', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2026-07-26 16:18:59', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2026-07-26 16:18:59', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2026-07-26 16:18:59', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2026-07-26 16:18:59', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2026-07-26 16:18:59', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2026-07-26 16:18:59', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2026-07-26 16:18:59', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2026-07-26 16:18:59', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2026-07-26 16:18:59', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2026-07-26 16:18:59', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2026-07-26 16:18:59', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2026-07-26 16:18:59', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2026-07-26 16:19:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2013, '罪犯基本信息', 4, 0, 'archive', 'pm/cm/index', NULL, '', 1, 0, 'C', '0', '0', 'pm:archive:list', 'documentation', 'admin', '2026-07-28 10:08:21', 'admin', '2026-07-28 17:20:31', '罪犯基础档案菜单');
INSERT INTO `sys_menu` VALUES (2014, '罪犯基础档案查询', 2013, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:archive:query', '#', 'admin', '2026-07-28 10:08:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2015, '罪犯基础档案新增', 2013, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:archive:add', '#', 'admin', '2026-07-28 10:08:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2016, '罪犯基础档案修改', 2013, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:archive:edit', '#', 'admin', '2026-07-28 10:08:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2017, '罪犯基础档案删除', 2013, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:archive:remove', '#', 'admin', '2026-07-28 10:08:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2018, '罪犯基础档案导出', 2013, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:archive:export', '#', 'admin', '2026-07-28 10:08:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2019, '罪犯就医记录', 4, 1, 'medical', 'pm/medical/index', NULL, '', 1, 0, 'C', '0', '0', 'pm:medical:list', 'druid', 'admin', '2026-07-28 20:13:43', 'admin', '2026-07-28 20:32:17', '罪犯就医记录菜单');
INSERT INTO `sys_menu` VALUES (2020, '罪犯就医记录查询', 2019, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'pm:medical:query', '#', 'admin', '2026-07-28 20:13:43', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2021, '罪犯就医记录新增', 2019, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'pm:medical:add', '#', 'admin', '2026-07-28 20:13:43', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2022, '罪犯就医记录修改', 2019, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'pm:medical:edit', '#', 'admin', '2026-07-28 20:13:43', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2023, '罪犯就医记录删除', 2019, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'pm:medical:remove', '#', 'admin', '2026-07-28 20:13:43', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2024, '罪犯就医记录导出', 2019, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'pm:medical:export', '#', 'admin', '2026-07-28 20:13:43', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-28 四川省甘孜监狱执法证据保全系统v1 更新啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2026-07-26 16:19:03', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 四川省甘孜监狱执法证据保全系统v1维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2026-07-26 16:19:03', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (3, '四川省甘孜监狱执法证据保全系统v1介绍', '1', 0x3C703E3C7370616E207374796C653D22636F6C6F723A20726762283233302C20302C2030293B223EE9A1B9E79BAEE4BB8BE7BB8D3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A20726762283130332C203130362C20313038293B223EE59B9BE5B79DE79C81E79498E5AD9CE79B91E78BB1E689A7E6B395E8AF81E68DAEE4BF9DE585A8E7B3BBE7BB9F7631EFBC8CE698AFE79498E5AD9CE79B91E78BB1E4B8BAE6B7B1E58C96E689A7E6B395E8A784E88C83E58C96E5BBBAE8AEBEE38081E68993E980A0E6B395E6B2BBE79B91E78BB1E8808CE887AAE4B8BBE69E84E5BBBAE79A84E699BAE883BDE58C96E8AF81E68DAEE7AEA1E79086E5B9B3E58FB0E38082E7B3BBE7BB9FE4BBA5E2809CE4B880E789A9E4B880E7A081E38081E585A8E7A88BE8BFBDE6BAAFE38081E699BAE883BDE7AEA1E68EA7E38081E5AE89E585A8E997ADE78EAFE2809DE4B8BAE6A0B8E5BF83EFBC8CE4BE9DE6899872666964E794B5E5AD90E6A087E7ADBEE4B88EE789A9E88194E7BD91E68A80E69CAFEFBC8CE5AE9EE78EB0E789A9E8AF81E38081E4B9A6E8AF81E38081E794B5E5AD90E695B0E68DAEE7AD89E585A8E7B1BBE59E8BE8AF81E68DAEE4BB8EE799BBE8AEB0E38081E585A5E5BA93E38081E6B581E8BDACE588B0E99480E6AF81E79A84E585A8E7949FE591BDE591A8E69C9FE695B0E5AD97E58C96E7AEA1E79086E38082E9809AE8BF87E699BAE883BDE789A9E88194E5AD98E582A8E380813234E5B08FE697B6E78EAFE5A283E79B91E68EA7E38081E5BC82E5B8B8E8A18CE4B8BAE887AAE58AA8E68AA5E8ADA6E4B88EE8BDA8E8BFB9E8BFBDE6BAAFEFBC8CE4B8A5E6A0BCE890BDE5AE9EE2809CE4B99DE998B2E2809DE5AE89E585A8E6A087E58786EFBC8CE7A1AEE4BF9DE8AF81E68DAEE789A9E79086E4B88EE4BFA1E681AFE5AE89E585A8E38082E7B3BBE7BB9FE694AFE68C81E79C81E38081E79B91E38081E58CBAE4B889E7BAA7E88194E7BD91E4B88EE8B7A8E983A8E997A8E695B0E68DAEE5AFB9E68EA5EFBC8CE58685E7BDAEE699BAE883BDE9A284E8ADA6E4B88EE7BB9FE8AEA1E58886E69E90E58A9FE883BDEFBC8CE69C89E69588E7A0B4E8A7A3E4BCA0E7BB9FE8AF81E68DAEE7AEA1E79086E4BF9DE5AD98E99ABEE38081E6B581E8BDACE4B9B1E38081E8BFBDE6BAAFE5BCB1E7AD89E7979BE782B9EFBC8CE698BEE89197E68F90E58D87E8AF81E68DAEE993BEE5AE8CE695B4E680A7E4B88EE689A7E6B395E585ACE4BFA1E58A9BEFBC8CE4B8BAE79498E5AD9CE79B91E78BB1E689A7E6B395E79B91E79DA3E4B88EE8A784E88C83E58C96E5BBBAE8AEBEE68F90E4BE9BE59D9AE5AE9EE7A791E68A80E694AFE69291E380823C2F7370616E3E3C2F703E3C703E3C696D67207372633D222F6465762D6170692F70726F66696C652F75706C6F61642F323032362F30372F32382F6C6F676F5F3230323630373238313134343032413030312E706E67223E3C2F703E3C703E3C62723E3C2F703E3C703E3C6272207374796C653D22636F6C6F723A207267622834382C2034392C203531293B20666F6E742D66616D696C793A202671756F743B48656C766574696361204E6575652671756F743B2C2048656C7665746963612C20417269616C2C2073616E732D73657269663B20666F6E742D73697A653A20313270783B223E3C2F703E, '0', 'admin', '2026-07-26 16:19:03', 'admin', '2026-07-28 11:44:04', '管理员');

-- ----------------------------
-- Table structure for sys_notice_read
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice_read`;
CREATE TABLE `sys_notice_read`  (
  `read_id` bigint NOT NULL AUTO_INCREMENT COMMENT '已读主键',
  `notice_id` int NOT NULL COMMENT '公告id',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `read_time` datetime NOT NULL COMMENT '阅读时间',
  PRIMARY KEY (`read_id`) USING BTREE,
  UNIQUE INDEX `uk_user_notice`(`user_id` ASC, `notice_id` ASC) USING BTREE COMMENT '同一用户同一公告只记录一次'
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '公告已读记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice_read
-- ----------------------------
INSERT INTO `sys_notice_read` VALUES (1, 3, 1, '2026-07-28 11:38:27');
INSERT INTO `sys_notice_read` VALUES (2, 2, 1, '2026-07-28 11:41:40');
INSERT INTO `sys_notice_read` VALUES (3, 1, 1, '2026-07-28 11:41:48');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 241 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '参数管理', 2, 'com.pms.web.controller.system.SysConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/config', '127.0.0.1', '内网IP', '{\"configId\":4,\"configKey\":\"sys.account.captchaEnabled\",\"configName\":\"账号自助-验证码开关\",\"configType\":\"Y\",\"configValue\":\"false\",\"createBy\":\"admin\",\"createTime\":\"2026-07-26 16:19:03\",\"params\":{},\"remark\":\"是否开启验证码功能（true开启，false关闭）\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-26 18:00:11', 63);
INSERT INTO `sys_oper_log` VALUES (101, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-07-26 16:18:59\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"若依官网\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"http://ruoyi.vip\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 11:32:09', 51);
INSERT INTO `sys_oper_log` VALUES (102, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-07-26 16:18:59\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"若依官网\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"http://ruoyi.vip\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 11:35:58', 23);
INSERT INTO `sys_oper_log` VALUES (103, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-07-26 16:18:59\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"若依官网\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"http://ruoyi.vip\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 11:36:27', 25);
INSERT INTO `sys_oper_log` VALUES (104, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-07-26 16:18:59\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"若依官网\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"http://ruoyi.vip\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 11:46:09', 30);
INSERT INTO `sys_oper_log` VALUES (105, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-07-26 16:18:59\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"若依官网\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"http://ruoyi.vip\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 11:46:39', 32);
INSERT INTO `sys_oper_log` VALUES (106, '部门管理', 2, 'com.pms.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0\",\"children\":[],\"deptId\":100,\"deptName\":\"甘孜监狱\",\"email\":\"admin@qq.com\",\"leader\":\"甘孜监狱长\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 11:49:51', 32);
INSERT INTO `sys_oper_log` VALUES (107, '部门管理', 2, 'com.pms.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"deptId\":101,\"deptName\":\"名山监区\",\"email\":\"adminMS@qq.com\",\"leader\":\"岷山监狱长\",\"orderNum\":1,\"params\":{},\"parentId\":100,\"parentName\":\"甘孜监狱\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 11:51:23', 39);
INSERT INTO `sys_oper_log` VALUES (108, '部门管理', 2, 'com.pms.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"deptId\":102,\"deptName\":\"甘孜监区\",\"email\":\"adminGZ@qq.com\",\"leader\":\"甘孜监狱长\",\"orderNum\":2,\"params\":{},\"parentId\":100,\"parentName\":\"甘孜监狱\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 11:52:00', 30);
INSERT INTO `sys_oper_log` VALUES (109, '部门管理', 2, 'com.pms.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"办公室\",\"email\":\"\",\"leader\":\"\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"parentName\":\"名山监区\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 11:53:10', 29);
INSERT INTO `sys_oper_log` VALUES (110, '部门管理', 2, 'com.pms.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":104,\"deptName\":\"狱政科\",\"email\":\"Chen@qq.com\",\"leader\":\"陈科长\",\"orderNum\":2,\"params\":{},\"parentId\":101,\"parentName\":\"名山监区\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 11:54:08', 26);
INSERT INTO `sys_oper_log` VALUES (111, '部门管理', 2, 'com.pms.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"deptId\":108,\"deptName\":\"办公室\",\"email\":\"\",\"leader\":\"\",\"orderNum\":1,\"params\":{},\"parentId\":100,\"parentName\":\"甘孜监区\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 11:54:33', 33);
INSERT INTO `sys_oper_log` VALUES (112, '部门管理', 2, 'com.pms.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,102\",\"children\":[],\"deptId\":108,\"deptName\":\"办公室\",\"email\":\"\",\"leader\":\"\",\"orderNum\":1,\"params\":{},\"parentId\":102,\"parentName\":\"甘孜监狱\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 11:55:07', 38);
INSERT INTO `sys_oper_log` VALUES (113, '部门管理', 2, 'com.pms.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,102\",\"children\":[],\"deptId\":109,\"deptName\":\"狱政科\",\"email\":\"\",\"leader\":\"\",\"orderNum\":2,\"params\":{},\"parentId\":102,\"parentName\":\"甘孜监区\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 11:55:21', 24);
INSERT INTO `sys_oper_log` VALUES (114, '部门管理', 2, 'com.pms.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":105,\"deptName\":\"教育改造科\",\"email\":\"\",\"leader\":\"\",\"orderNum\":3,\"params\":{},\"parentId\":101,\"parentName\":\"名山监区\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 11:56:03', 31);
INSERT INTO `sys_oper_log` VALUES (115, '部门管理', 3, 'com.pms.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/106', '127.0.0.1', '内网IP', '106 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 11:56:06', 16);
INSERT INTO `sys_oper_log` VALUES (116, '部门管理', 3, 'com.pms.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/107', '127.0.0.1', '内网IP', '107 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 11:56:09', 17);
INSERT INTO `sys_oper_log` VALUES (117, '用户管理', 1, 'com.pms.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"nickName\":\"刘正平\",\"params\":{},\"phonenumber\":\"13551131957\",\"postIds\":[4],\"roleIds\":[2],\"sex\":\"0\",\"status\":\"0\",\"userName\":\"LiuZhengPing\"} ', '{\"msg\":\"新增用户\'LiuZhengPing\'失败，登录账号已存在\",\"code\":500}', 0, NULL, '2026-07-27 11:58:53', 4);
INSERT INTO `sys_oper_log` VALUES (118, '岗位管理', 2, 'com.pms.web.controller.system.SysPostController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/post', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-07-26 16:18:59\",\"flag\":false,\"params\":{},\"postCode\":\"Warden\",\"postId\":1,\"postName\":\"监狱长\",\"postSort\":1,\"remark\":\"\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 12:00:08', 32);
INSERT INTO `sys_oper_log` VALUES (119, '岗位管理', 2, 'com.pms.web.controller.system.SysPostController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/post', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-07-26 16:18:59\",\"flag\":false,\"params\":{},\"postCode\":\"Section Chief\",\"postId\":2,\"postName\":\"科长\",\"postSort\":2,\"remark\":\"\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 12:01:07', 25);
INSERT INTO `sys_oper_log` VALUES (120, '岗位管理', 2, 'com.pms.web.controller.system.SysPostController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/post', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-07-26 16:18:59\",\"flag\":false,\"params\":{},\"postCode\":\"Prison Warden\",\"postId\":1,\"postName\":\"监狱长\",\"postSort\":1,\"remark\":\"\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 12:01:30', 18);
INSERT INTO `sys_oper_log` VALUES (121, '岗位管理', 2, 'com.pms.web.controller.system.SysPostController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/post', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-07-26 16:18:59\",\"flag\":false,\"params\":{},\"postCode\":\"Guard\",\"postId\":3,\"postName\":\"警卫\",\"postSort\":3,\"remark\":\"\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 12:02:13', 20);
INSERT INTO `sys_oper_log` VALUES (122, '岗位管理', 2, 'com.pms.web.controller.system.SysPostController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/post', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-07-26 16:18:59\",\"flag\":false,\"params\":{},\"postCode\":\"Technician\",\"postId\":4,\"postName\":\"技术员\",\"postSort\":4,\"remark\":\"\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 12:02:50', 24);
INSERT INTO `sys_oper_log` VALUES (123, '用户管理', 2, 'com.pms.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":true,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2026-07-26 16:18:58\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"办公室\",\"leader\":\"\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":103,\"email\":\"13688401821@139.com\",\"loginDate\":\"2026-07-27 11:32:27\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"陈科长\",\"params\":{},\"phonenumber\":\"13688401821\",\"postIds\":[2],\"pwdUpdateDate\":\"2026-07-26 16:18:58\",\"remark\":\"管理员\",\"roleIds\":[1],\"roles\":[{\"admin\":true,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":1,\"roleKey\":\"admin\",\"roleName\":\"超级管理员\",\"roleSort\":1,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"\",\"userId\":1,\"userName\":\"admin\"} ', NULL, 1, '不允许操作超级管理员用户', '2026-07-27 12:03:32', 7);
INSERT INTO `sys_oper_log` VALUES (124, '用户管理', 1, 'com.pms.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptId\":103,\"nickName\":\"谢平\",\"params\":{},\"postIds\":[4],\"roleIds\":[2],\"sex\":\"0\",\"status\":\"0\",\"userId\":100,\"userName\":\"XiePing\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 12:06:10', 108);
INSERT INTO `sys_oper_log` VALUES (125, '用户管理', 2, 'com.pms.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2026-07-26 16:18:58\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":105,\"deptName\":\"教育改造科\",\"leader\":\"\",\"orderNum\":3,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":103,\"email\":\"965625780@qq.com\",\"loginDate\":\"2026-07-26 16:18:58\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"刘正平\",\"params\":{},\"phonenumber\":\"13551131957\",\"postIds\":[2],\"pwdUpdateDate\":\"2026-07-26 16:18:58\",\"remark\":\"测试员\",\"roleIds\":[2],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\"}],\"sex\":\"2\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":2,\"userName\":\"LiuZhengPing\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 12:06:22', 45);
INSERT INTO `sys_oper_log` VALUES (126, '用户管理', 2, 'com.pms.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2026-07-26 16:18:58\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"办公室\",\"leader\":\"\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":103,\"email\":\"965625780@qq.com\",\"loginDate\":\"2026-07-26 16:18:58\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"刘正平\",\"params\":{},\"phonenumber\":\"13551131957\",\"postIds\":[2],\"pwdUpdateDate\":\"2026-07-26 16:18:58\",\"remark\":\"测试员\",\"roleIds\":[2],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-27 12:06:22\",\"userId\":2,\"userName\":\"LiuZhengPing\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 12:06:35', 31);
INSERT INTO `sys_oper_log` VALUES (127, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/user/index\",\"createTime\":\"2026-07-26 16:18:59\",\"icon\":\"user\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":100,\"menuName\":\"用户管理\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":1,\"path\":\"user\",\"perms\":\"system:user:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 12:15:31', 28);
INSERT INTO `sys_oper_log` VALUES (128, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/user/index\",\"createTime\":\"2026-07-26 16:18:59\",\"icon\":\"user\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":100,\"menuName\":\"用户管理\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":1,\"path\":\"user\",\"perms\":\"system:user:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 12:16:28', 30);
INSERT INTO `sys_oper_log` VALUES (129, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/user/index\",\"createTime\":\"2026-07-26 16:18:59\",\"icon\":\"user\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":100,\"menuName\":\"用户管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1,\"path\":\"user\",\"perms\":\"system:user:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 12:16:51', 19);
INSERT INTO `sys_oper_log` VALUES (130, '个人信息', 2, 'com.pms.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', '办公室', '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"13688401821@139.com\",\"nickName\":\"陈科长\",\"params\":{},\"phonenumber\":\"13688401821\",\"sex\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 13:11:23', 24);
INSERT INTO `sys_oper_log` VALUES (131, '用户头像', 2, 'com.pms.web.controller.system.SysProfileController.avatar()', 'POST', 1, 'admin', '办公室', '/system/user/profile/avatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2026/07/27/f74c9f705cbb417a8f2d6c7c7b97c24a.jpg\",\"code\":200}', 0, NULL, '2026-07-27 13:12:01', 167);
INSERT INTO `sys_oper_log` VALUES (132, '个人信息', 2, 'com.pms.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', '办公室', '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"13688401821@139.com\",\"nickName\":\"陈科长\",\"params\":{},\"phonenumber\":\"13688401821\",\"sex\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 13:12:03', 26);
INSERT INTO `sys_oper_log` VALUES (133, '代码生成', 6, 'com.pms.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '办公室', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"t_criminals_archive\",\"tplWebType\":\"element-plus-typescript\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 16:37:08', 130);
INSERT INTO `sys_oper_log` VALUES (134, '代码生成', 2, 'com.pms.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '办公室', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"archive\",\"className\":\"TCriminalsArchive\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"自增主键\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"bigint unsigned\",\"createBy\":\"admin\",\"createTime\":\"2026-07-27 16:37:08\",\"dictType\":\"\",\"edit\":false,\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Uuid\",\"columnComment\":\"全局唯一标识符(UUID)\",\"columnId\":2,\"columnName\":\"uuid\",\"columnType\":\"char(36)\",\"createBy\":\"admin\",\"createTime\":\"2026-07-27 16:37:08\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"uuid\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CriminalNo\",\"columnComment\":\"罪犯编号(唯一业务标识)\",\"columnId\":3,\"columnName\":\"criminal_no\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2026-07-27 16:37:08\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"criminalNo\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CriminalName\",\"columnComment\":\"罪犯姓名\",\"columnId\":4,\"columnName\":\"criminal_name\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-07-27 16:37:08\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 16:44:46', 60);
INSERT INTO `sys_oper_log` VALUES (135, '代码生成', 2, 'com.pms.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '办公室', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"criminal-archive\",\"className\":\"TCriminalsArchive\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"自增主键\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"bigint unsigned\",\"createBy\":\"admin\",\"createTime\":\"2026-07-27 16:37:08\",\"dictType\":\"\",\"edit\":false,\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-07-27 16:44:46\",\"usableColumn\":false},{\"capJavaField\":\"Uuid\",\"columnComment\":\"全局唯一标识符(UUID)\",\"columnId\":2,\"columnName\":\"uuid\",\"columnType\":\"char(36)\",\"createBy\":\"admin\",\"createTime\":\"2026-07-27 16:37:08\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"0\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"1\",\"javaField\":\"uuid\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-07-27 16:44:46\",\"usableColumn\":false},{\"capJavaField\":\"CriminalNo\",\"columnComment\":\"罪犯编号(唯一业务标识)\",\"columnId\":3,\"columnName\":\"criminal_no\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2026-07-27 16:37:08\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"criminalNo\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-07-27 16:44:46\",\"usableColumn\":false},{\"capJavaField\":\"CriminalName\",\"columnComment\":\"罪犯姓名\",\"columnId\":4,\"columnName\":\"criminal_name\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-07-27 16:37:08\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 16:52:38', 58);
INSERT INTO `sys_oper_log` VALUES (136, '代码生成', 8, 'com.pms.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '办公室', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"t_criminals_archive\"}', NULL, 0, NULL, '2026-07-27 16:52:53', 63);
INSERT INTO `sys_oper_log` VALUES (137, '代码生成', 2, 'com.pms.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '办公室', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"criminal-archive\",\"className\":\"TCriminalsArchive\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"自增主键\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"bigint unsigned\",\"createBy\":\"admin\",\"createTime\":\"2026-07-27 16:37:08\",\"dictType\":\"\",\"edit\":false,\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-07-27 16:52:38\",\"usableColumn\":false},{\"capJavaField\":\"Uuid\",\"columnComment\":\"全局唯一标识符(UUID)\",\"columnId\":2,\"columnName\":\"uuid\",\"columnType\":\"char(36)\",\"createBy\":\"admin\",\"createTime\":\"2026-07-27 16:37:08\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"0\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"1\",\"javaField\":\"uuid\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-07-27 16:52:38\",\"usableColumn\":false},{\"capJavaField\":\"CriminalNo\",\"columnComment\":\"罪犯编号(唯一业务标识)\",\"columnId\":3,\"columnName\":\"criminal_no\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2026-07-27 16:37:08\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"criminalNo\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-07-27 16:52:38\",\"usableColumn\":false},{\"capJavaField\":\"CriminalName\",\"columnComment\":\"罪犯姓名\",\"columnId\":4,\"columnName\":\"criminal_name\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-07-27 16:37:08\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 17:36:10', 42);
INSERT INTO `sys_oper_log` VALUES (138, '代码生成', 8, 'com.pms.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '办公室', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"t_criminals_archive\"}', NULL, 0, NULL, '2026-07-27 17:36:15', 61);
INSERT INTO `sys_oper_log` VALUES (139, '代码生成', 8, 'com.pms.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '办公室', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"t_criminals_archive\"}', NULL, 0, NULL, '2026-07-27 17:36:21', 54);
INSERT INTO `sys_oper_log` VALUES (140, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-07-26 16:18:59\",\"icon\":\"system\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":1,\"menuName\":\"系统管理\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"system\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 18:30:29', 73);
INSERT INTO `sys_oper_log` VALUES (141, '菜单管理', 1, 'com.pms.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"罪犯管理\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"CriminalManagement\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 18:30:43', 25);
INSERT INTO `sys_oper_log` VALUES (142, '保存菜单排序', 2, 'com.pms.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', '办公室', '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"2000\",\"orderNums\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 18:30:59', 21);
INSERT INTO `sys_oper_log` VALUES (143, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-07-26 16:18:59\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"若依官网\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"http://ruoyi.vip\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 18:32:47', 23);
INSERT INTO `sys_oper_log` VALUES (144, '菜单管理', 3, 'com.pms.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '办公室', '/system/menu/4', '127.0.0.1', '内网IP', '4 ', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2026-07-27 18:33:03', 21);
INSERT INTO `sys_oper_log` VALUES (145, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-07-26 16:18:59\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"若依官网\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"http://ruoyi.vip\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 18:33:09', 22);
INSERT INTO `sys_oper_log` VALUES (146, '菜单管理', 3, 'com.pms.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '办公室', '/system/menu/4', '127.0.0.1', '内网IP', '4 ', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2026-07-27 18:33:12', 7);
INSERT INTO `sys_oper_log` VALUES (147, '菜单管理', 3, 'com.pms.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '办公室', '/system/menu/4', '127.0.0.1', '内网IP', '4 ', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2026-07-27 18:33:19', 0);
INSERT INTO `sys_oper_log` VALUES (148, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-07-26 16:18:59\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":4,\"menuName\":\"罪犯管理\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"CriminalManagement\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"修改菜单\'罪犯管理\'失败，菜单名称已存在\",\"code\":500}', 0, NULL, '2026-07-27 18:34:35', 5);
INSERT INTO `sys_oper_log` VALUES (149, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-07-26 16:18:59\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":4,\"menuName\":\"罪犯管理1\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"CriminalManagement\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"修改菜单\'罪犯管理1\'失败，路由名称或地址已存在\",\"code\":500}', 0, NULL, '2026-07-27 18:34:39', 6);
INSERT INTO `sys_oper_log` VALUES (150, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-07-26 16:18:59\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":4,\"menuName\":\"罪犯管理1\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"CriminalManagement1\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 18:34:44', 22);
INSERT INTO `sys_oper_log` VALUES (151, '菜单管理', 3, 'com.pms.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '办公室', '/system/menu/2000', '127.0.0.1', '内网IP', '2000 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 18:34:56', 26);
INSERT INTO `sys_oper_log` VALUES (152, '菜单管理', 3, 'com.pms.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '办公室', '/system/menu/4', '127.0.0.1', '内网IP', '4 ', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2026-07-27 18:35:00', 4);
INSERT INTO `sys_oper_log` VALUES (153, '保存菜单排序', 2, 'com.pms.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', '办公室', '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"4\",\"orderNums\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 18:35:22', 16);
INSERT INTO `sys_oper_log` VALUES (154, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-07-26 16:18:59\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":4,\"menuName\":\"罪犯管理\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"CriminalManagement\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 18:35:45', 24);
INSERT INTO `sys_oper_log` VALUES (155, '代码生成', 2, 'com.pms.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '办公室', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"criminal-archive\",\"className\":\"TCriminalsArchive\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"自增主键\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"bigint unsigned\",\"createBy\":\"admin\",\"createTime\":\"2026-07-27 16:37:08\",\"dictType\":\"\",\"edit\":false,\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-07-27 17:36:10\",\"usableColumn\":false},{\"capJavaField\":\"Uuid\",\"columnComment\":\"全局唯一标识符(UUID)\",\"columnId\":2,\"columnName\":\"uuid\",\"columnType\":\"char(36)\",\"createBy\":\"admin\",\"createTime\":\"2026-07-27 16:37:08\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"0\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"1\",\"javaField\":\"uuid\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-07-27 17:36:10\",\"usableColumn\":false},{\"capJavaField\":\"CriminalNo\",\"columnComment\":\"罪犯编号(唯一业务标识)\",\"columnId\":3,\"columnName\":\"criminal_no\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2026-07-27 16:37:08\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"criminalNo\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-07-27 17:36:10\",\"usableColumn\":false},{\"capJavaField\":\"CriminalName\",\"columnComment\":\"罪犯姓名\",\"columnId\":4,\"columnName\":\"criminal_name\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-07-27 16:37:08\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 19:00:45', 45);
INSERT INTO `sys_oper_log` VALUES (156, '代码生成', 3, 'com.pms.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '办公室', '/tool/gen/1', '127.0.0.1', '内网IP', '[1] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 19:01:58', 39);
INSERT INTO `sys_oper_log` VALUES (157, '代码生成', 6, 'com.pms.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '办公室', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"t_criminals_archive\",\"tplWebType\":\"element-plus-typescript\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 19:02:04', 73);
INSERT INTO `sys_oper_log` VALUES (158, '代码生成', 3, 'com.pms.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '办公室', '/tool/gen/2', '127.0.0.1', '内网IP', '[2] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 19:06:19', 42);
INSERT INTO `sys_oper_log` VALUES (159, '代码生成', 6, 'com.pms.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '办公室', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"t_criminals_archive\",\"tplWebType\":\"element-plus-typescript\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 19:06:24', 83);
INSERT INTO `sys_oper_log` VALUES (160, '代码生成', 3, 'com.pms.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '办公室', '/tool/gen/3', '127.0.0.1', '内网IP', '[3] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 19:08:11', 46);
INSERT INTO `sys_oper_log` VALUES (161, '代码生成', 6, 'com.pms.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '办公室', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"t_criminals_archive\",\"tplWebType\":\"element-plus-typescript\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 19:08:22', 68);
INSERT INTO `sys_oper_log` VALUES (162, '代码生成', 3, 'com.pms.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '办公室', '/tool/gen/4', '127.0.0.1', '内网IP', '[4] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 19:08:56', 28);
INSERT INTO `sys_oper_log` VALUES (163, '代码生成', 6, 'com.pms.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '办公室', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"t_criminals_archive\",\"tplWebType\":\"element-plus-typescript\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 19:09:02', 52);
INSERT INTO `sys_oper_log` VALUES (164, '代码生成', 3, 'com.pms.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '办公室', '/tool/gen/5', '127.0.0.1', '内网IP', '[5] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 19:10:01', 36);
INSERT INTO `sys_oper_log` VALUES (165, '代码生成', 6, 'com.pms.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '办公室', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"t_criminals_archive\",\"tplWebType\":\"element-plus-typescript\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 19:10:09', 76);
INSERT INTO `sys_oper_log` VALUES (166, '代码生成', 3, 'com.pms.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '办公室', '/tool/gen/6', '127.0.0.1', '内网IP', '[6] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 19:21:29', 51);
INSERT INTO `sys_oper_log` VALUES (167, '代码生成', 6, 'com.pms.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '办公室', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"t_criminals_archive\",\"tplWebType\":\"element-plus-typescript\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 19:21:37', 85);
INSERT INTO `sys_oper_log` VALUES (168, '代码生成', 2, 'com.pms.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '办公室', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"archive\",\"className\":\"TCriminalsArchive\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"自增主键\",\"columnId\":49,\"columnName\":\"id\",\"columnType\":\"bigint unsigned\",\"createBy\":\"admin\",\"createTime\":\"2026-07-27 19:21:37\",\"dictType\":\"\",\"edit\":false,\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Uuid\",\"columnComment\":\"全局唯一标识符(UUID)\",\"columnId\":50,\"columnName\":\"uuid\",\"columnType\":\"char(36)\",\"createBy\":\"admin\",\"createTime\":\"2026-07-27 19:21:37\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"uuid\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CriminalNo\",\"columnComment\":\"罪犯编号(唯一业务标识)\",\"columnId\":51,\"columnName\":\"criminal_no\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2026-07-27 19:21:37\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"criminalNo\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CriminalName\",\"columnComment\":\"罪犯姓名\",\"columnId\":52,\"columnName\":\"criminal_name\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-07-27 19:21:37\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequire', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 19:24:26', 63);
INSERT INTO `sys_oper_log` VALUES (169, '代码生成', 2, 'com.pms.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '办公室', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"criminals-archive\",\"className\":\"TCriminalsArchive\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"自增主键\",\"columnId\":49,\"columnName\":\"id\",\"columnType\":\"bigint unsigned\",\"createBy\":\"admin\",\"createTime\":\"2026-07-27 19:21:37\",\"dictType\":\"\",\"edit\":false,\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"updateTime\":\"2026-07-27 19:24:26\",\"usableColumn\":false},{\"capJavaField\":\"Uuid\",\"columnComment\":\"全局唯一标识符(UUID)\",\"columnId\":50,\"columnName\":\"uuid\",\"columnType\":\"char(36)\",\"createBy\":\"admin\",\"createTime\":\"2026-07-27 19:21:37\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"0\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"1\",\"javaField\":\"uuid\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"updateTime\":\"2026-07-27 19:24:26\",\"usableColumn\":false},{\"capJavaField\":\"CriminalNo\",\"columnComment\":\"罪犯编号(唯一业务标识)\",\"columnId\":51,\"columnName\":\"criminal_no\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2026-07-27 19:21:37\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"criminalNo\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"updateTime\":\"2026-07-27 19:24:26\",\"usableColumn\":false},{\"capJavaField\":\"CriminalName\",\"columnComment\":\"罪犯姓名\",\"columnId\":52,\"columnName\":\"criminal_name\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-07-27 19:21:37\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"incre', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 19:29:18', 41);
INSERT INTO `sys_oper_log` VALUES (170, '代码生成', 8, 'com.pms.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '办公室', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"t_criminals_archive\"}', NULL, 0, NULL, '2026-07-27 19:31:14', 47);
INSERT INTO `sys_oper_log` VALUES (171, '字典类型', 1, 'com.pms.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '办公室', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"员工状态\",\"dictType\":\"emp_status\",\"params\":{},\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 20:11:33', 31);
INSERT INTO `sys_oper_log` VALUES (172, '字典类型', 2, 'com.pms.web.controller.system.SysDictTypeController.edit()', 'PUT', 1, 'admin', '办公室', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-07-27 20:11:33\",\"dictId\":100,\"dictName\":\"员工状态\",\"dictType\":\"emp_status\",\"params\":{},\"remark\":\"员工状态测试\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 20:12:27', 47);
INSERT INTO `sys_oper_log` VALUES (173, '字典类型', 3, 'com.pms.web.controller.system.SysDictTypeController.remove()', 'DELETE', 1, 'admin', '办公室', '/system/dict/type/100', '127.0.0.1', '内网IP', '[100] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 20:13:22', 33);
INSERT INTO `sys_oper_log` VALUES (174, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-07-26 16:18:59\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":4,\"menuName\":\"罪犯管理\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"CriminalManagement\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 20:15:55', 35);
INSERT INTO `sys_oper_log` VALUES (175, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-07-26 16:18:59\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":4,\"menuName\":\"罪犯管理\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"CriminalManagement1\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 20:16:36', 25);
INSERT INTO `sys_oper_log` VALUES (176, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-07-26 16:18:59\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":4,\"menuName\":\"罪犯管理\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"CriminalManagement\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 20:17:21', 20);
INSERT INTO `sys_oper_log` VALUES (177, '代码生成', 2, 'com.pms.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '办公室', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"criminals-archive\",\"className\":\"CriminalsArchive\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"自增主键\",\"columnId\":49,\"columnName\":\"id\",\"columnType\":\"bigint unsigned\",\"createBy\":\"admin\",\"createTime\":\"2026-07-27 19:21:37\",\"dictType\":\"\",\"edit\":false,\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"updateTime\":\"2026-07-27 19:29:18\",\"usableColumn\":false},{\"capJavaField\":\"Uuid\",\"columnComment\":\"全局唯一标识符(UUID)\",\"columnId\":50,\"columnName\":\"uuid\",\"columnType\":\"char(36)\",\"createBy\":\"admin\",\"createTime\":\"2026-07-27 19:21:37\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"0\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"1\",\"javaField\":\"uuid\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"updateTime\":\"2026-07-27 19:29:18\",\"usableColumn\":false},{\"capJavaField\":\"CriminalNo\",\"columnComment\":\"罪犯编号(唯一业务标识)\",\"columnId\":51,\"columnName\":\"criminal_no\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2026-07-27 19:21:37\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"criminalNo\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"updateTime\":\"2026-07-27 19:29:18\",\"usableColumn\":false},{\"capJavaField\":\"CriminalName\",\"columnComment\":\"罪犯姓名\",\"columnId\":52,\"columnName\":\"criminal_name\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-07-27 19:21:37\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increm', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-27 20:23:05', 47);
INSERT INTO `sys_oper_log` VALUES (178, '代码生成', 8, 'com.pms.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '办公室', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"t_criminals_archive\"}', NULL, 0, NULL, '2026-07-27 20:23:49', 103);
INSERT INTO `sys_oper_log` VALUES (179, '代码生成', 3, 'com.pms.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '办公室', '/tool/gen/7', '127.0.0.1', '内网IP', '[7] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 09:59:00', 77);
INSERT INTO `sys_oper_log` VALUES (180, '代码生成', 6, 'com.pms.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '办公室', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"t_criminals_archive\",\"tplWebType\":\"element-plus-typescript\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 09:59:04', 111);
INSERT INTO `sys_oper_log` VALUES (181, '代码生成', 2, 'com.pms.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '办公室', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"archive\",\"className\":\"CriminalsArchive\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"自增主键\",\"columnId\":57,\"columnName\":\"id\",\"columnType\":\"bigint unsigned\",\"createBy\":\"admin\",\"createTime\":\"2026-07-28 09:59:04\",\"dictType\":\"\",\"edit\":false,\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Uuid\",\"columnComment\":\"全局唯一标识符(UUID)\",\"columnId\":58,\"columnName\":\"uuid\",\"columnType\":\"char(36)\",\"createBy\":\"admin\",\"createTime\":\"2026-07-28 09:59:04\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"0\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"1\",\"javaField\":\"uuid\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CriminalNo\",\"columnComment\":\"罪犯编号(唯一业务标识)\",\"columnId\":59,\"columnName\":\"criminal_no\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2026-07-28 09:59:04\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"criminalNo\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CriminalName\",\"columnComment\":\"罪犯姓名\",\"columnId\":60,\"columnName\":\"criminal_name\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-07-28 09:59:04\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isReq', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 10:00:47', 88);
INSERT INTO `sys_oper_log` VALUES (182, '代码生成', 8, 'com.pms.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '办公室', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"t_criminals_archive\"}', NULL, 0, NULL, '2026-07-28 10:00:51', 192);
INSERT INTO `sys_oper_log` VALUES (183, '代码生成', 2, 'com.pms.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '办公室', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"archive\",\"className\":\"CriminalsArchive\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"自增主键\",\"columnId\":57,\"columnName\":\"id\",\"columnType\":\"bigint unsigned\",\"createBy\":\"admin\",\"createTime\":\"2026-07-28 09:59:04\",\"dictType\":\"\",\"edit\":false,\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"updateTime\":\"2026-07-28 10:00:47\",\"usableColumn\":false},{\"capJavaField\":\"Uuid\",\"columnComment\":\"全局唯一标识符(UUID)\",\"columnId\":58,\"columnName\":\"uuid\",\"columnType\":\"char(36)\",\"createBy\":\"admin\",\"createTime\":\"2026-07-28 09:59:04\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"0\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"1\",\"javaField\":\"uuid\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"updateTime\":\"2026-07-28 10:00:47\",\"usableColumn\":false},{\"capJavaField\":\"CriminalNo\",\"columnComment\":\"罪犯编号(唯一业务标识)\",\"columnId\":59,\"columnName\":\"criminal_no\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2026-07-28 09:59:04\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"criminalNo\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"updateTime\":\"2026-07-28 10:00:47\",\"usableColumn\":false},{\"capJavaField\":\"CriminalName\",\"columnComment\":\"罪犯姓名\",\"columnId\":60,\"columnName\":\"criminal_name\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-07-28 09:59:04\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 10:07:18', 95);
INSERT INTO `sys_oper_log` VALUES (184, '代码生成', 8, 'com.pms.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '办公室', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"t_criminals_archive\"}', NULL, 0, NULL, '2026-07-28 10:07:24', 52);
INSERT INTO `sys_oper_log` VALUES (185, '菜单管理', 3, 'com.pms.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '办公室', '/system/menu/2001', '127.0.0.1', '内网IP', '2001 ', '{\"msg\":\"存在子菜单,不允许删除\",\"code\":601}', 0, NULL, '2026-07-28 10:28:25', 12);
INSERT INTO `sys_oper_log` VALUES (186, '菜单管理', 3, 'com.pms.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '办公室', '/system/menu/2002', '127.0.0.1', '内网IP', '2002 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 10:28:35', 82);
INSERT INTO `sys_oper_log` VALUES (187, '菜单管理', 3, 'com.pms.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '办公室', '/system/menu/2003', '127.0.0.1', '内网IP', '2003 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 10:28:37', 21);
INSERT INTO `sys_oper_log` VALUES (188, '菜单管理', 3, 'com.pms.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '办公室', '/system/menu/2004', '127.0.0.1', '内网IP', '2004 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 10:28:40', 23);
INSERT INTO `sys_oper_log` VALUES (189, '菜单管理', 3, 'com.pms.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '办公室', '/system/menu/2005', '127.0.0.1', '内网IP', '2005 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 10:28:42', 23);
INSERT INTO `sys_oper_log` VALUES (190, '菜单管理', 3, 'com.pms.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '办公室', '/system/menu/2006', '127.0.0.1', '内网IP', '2006 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 10:28:45', 20);
INSERT INTO `sys_oper_log` VALUES (191, '菜单管理', 3, 'com.pms.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '办公室', '/system/menu/2001', '127.0.0.1', '内网IP', '2001 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 10:28:49', 23);
INSERT INTO `sys_oper_log` VALUES (192, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-07-26 16:18:59\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":4,\"menuName\":\"罪犯管理\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"system\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"修改菜单\'罪犯管理\'失败，路由名称或地址已存在\",\"code\":500}', 0, NULL, '2026-07-28 10:30:44', 23);
INSERT INTO `sys_oper_log` VALUES (193, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-07-26 16:18:59\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":4,\"menuName\":\"罪犯管理\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"system\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"修改菜单\'罪犯管理\'失败，路由名称或地址已存在\",\"code\":500}', 0, NULL, '2026-07-28 10:30:48', 6);
INSERT INTO `sys_oper_log` VALUES (194, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-07-26 16:18:59\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":4,\"menuName\":\"罪犯管理\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"system\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"修改菜单\'罪犯管理\'失败，路由名称或地址已存在\",\"code\":500}', 0, NULL, '2026-07-28 10:30:52', 11);
INSERT INTO `sys_oper_log` VALUES (195, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-07-26 16:18:59\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":4,\"menuName\":\"罪犯管理\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"system\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"修改菜单\'罪犯管理\'失败，路由名称或地址已存在\",\"code\":500}', 0, NULL, '2026-07-28 10:30:53', 7);
INSERT INTO `sys_oper_log` VALUES (196, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/archive/index\",\"createTime\":\"2026-07-28 10:08:21\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2013,\"menuName\":\"罪犯基础档案\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":4,\"path\":\"archive\",\"perms\":\"system:archive:list\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"修改菜单\'罪犯基础档案\'失败，路由名称或地址已存在\",\"code\":500}', 0, NULL, '2026-07-28 10:31:15', 6);
INSERT INTO `sys_oper_log` VALUES (197, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-07-26 16:18:59\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":4,\"menuName\":\"罪犯管理\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"/\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 10:31:30', 68);
INSERT INTO `sys_oper_log` VALUES (198, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-07-26 16:18:59\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":4,\"menuName\":\"罪犯管理\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"system\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"修改菜单\'罪犯管理\'失败，路由名称或地址已存在\",\"code\":500}', 0, NULL, '2026-07-28 10:32:09', 5);
INSERT INTO `sys_oper_log` VALUES (199, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-07-26 16:18:59\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":4,\"menuName\":\"罪犯管理\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"system\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"修改菜单\'罪犯管理\'失败，路由名称或地址已存在\",\"code\":500}', 0, NULL, '2026-07-28 10:32:14', 8);
INSERT INTO `sys_oper_log` VALUES (200, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-07-26 16:18:59\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":4,\"menuName\":\"罪犯管理\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"system1\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 10:32:20', 20);
INSERT INTO `sys_oper_log` VALUES (201, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-07-26 16:18:59\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":4,\"menuName\":\"罪犯管理\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"pm\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 10:33:00', 25);
INSERT INTO `sys_oper_log` VALUES (202, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-07-26 16:18:59\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":4,\"menuName\":\"罪犯管理\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"pm\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 10:33:37', 70);
INSERT INTO `sys_oper_log` VALUES (203, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-07-26 16:18:59\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":4,\"menuName\":\"罪犯管理\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"pm\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 10:34:18', 38);
INSERT INTO `sys_oper_log` VALUES (204, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"pm/archive/index\",\"createTime\":\"2026-07-28 10:08:21\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2013,\"menuName\":\"罪犯基础档案\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":4,\"path\":\"archive\",\"perms\":\"pm:archive:list\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"修改菜单\'罪犯基础档案\'失败，路由名称或地址已存在\",\"code\":500}', 0, NULL, '2026-07-28 11:12:36', 8);
INSERT INTO `sys_oper_log` VALUES (205, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"pm/archive/index\",\"createTime\":\"2026-07-28 10:08:21\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2013,\"menuName\":\"罪犯基础档案\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":4,\"path\":\"archive\",\"perms\":\"pm:archive:list\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"修改菜单\'罪犯基础档案\'失败，路由名称或地址已存在\",\"code\":500}', 0, NULL, '2026-07-28 11:12:39', 49);
INSERT INTO `sys_oper_log` VALUES (206, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"pm/archive/index\",\"createTime\":\"2026-07-28 10:08:21\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2013,\"menuName\":\"罪犯基础档案\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":4,\"path\":\"archive\",\"perms\":\"pm:archive:list\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"修改菜单\'罪犯基础档案\'失败，路由名称或地址已存在\",\"code\":500}', 0, NULL, '2026-07-28 11:12:44', 5);
INSERT INTO `sys_oper_log` VALUES (207, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/archive/index\",\"createTime\":\"2026-07-28 10:02:00\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2007,\"menuName\":\"罪犯基础档案\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":3,\"path\":\"archive\",\"perms\":\"system:archive:list\",\"routeName\":\"\",\"status\":\"1\",\"visible\":\"0\"} ', '{\"msg\":\"修改菜单\'罪犯基础档案\'失败，路由名称或地址已存在\",\"code\":500}', 0, NULL, '2026-07-28 11:13:41', 7);
INSERT INTO `sys_oper_log` VALUES (208, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/archive/index\",\"createTime\":\"2026-07-28 10:02:00\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2007,\"menuName\":\"罪犯基础档案\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":3,\"path\":\"archive\",\"perms\":\"system:archive:list\",\"routeName\":\"\",\"status\":\"1\",\"visible\":\"0\"} ', '{\"msg\":\"修改菜单\'罪犯基础档案\'失败，路由名称或地址已存在\",\"code\":500}', 0, NULL, '2026-07-28 11:13:58', 7);
INSERT INTO `sys_oper_log` VALUES (209, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/archive/index\",\"createTime\":\"2026-07-28 10:02:00\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2007,\"menuName\":\"罪犯基础档案\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":3,\"path\":\"archive\",\"perms\":\"system:archive:list\",\"routeName\":\"\",\"status\":\"1\",\"visible\":\"0\"} ', '{\"msg\":\"修改菜单\'罪犯基础档案\'失败，路由名称或地址已存在\",\"code\":500}', 0, NULL, '2026-07-28 11:14:34', 6);
INSERT INTO `sys_oper_log` VALUES (210, '菜单管理', 3, 'com.pms.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '办公室', '/system/menu/2008', '127.0.0.1', '内网IP', '2008 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 11:14:46', 24);
INSERT INTO `sys_oper_log` VALUES (211, '菜单管理', 3, 'com.pms.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '办公室', '/system/menu/2009', '127.0.0.1', '内网IP', '2009 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 11:14:51', 25);
INSERT INTO `sys_oper_log` VALUES (212, '菜单管理', 3, 'com.pms.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '办公室', '/system/menu/2007', '127.0.0.1', '内网IP', '2007 ', '{\"msg\":\"存在子菜单,不允许删除\",\"code\":601}', 0, NULL, '2026-07-28 11:14:54', 2);
INSERT INTO `sys_oper_log` VALUES (213, '菜单管理', 3, 'com.pms.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '办公室', '/system/menu/2010', '127.0.0.1', '内网IP', '2010 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 11:14:57', 35);
INSERT INTO `sys_oper_log` VALUES (214, '菜单管理', 3, 'com.pms.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '办公室', '/system/menu/2011', '127.0.0.1', '内网IP', '2011 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 11:15:00', 17);
INSERT INTO `sys_oper_log` VALUES (215, '菜单管理', 3, 'com.pms.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '办公室', '/system/menu/2012', '127.0.0.1', '内网IP', '2012 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 11:15:03', 60);
INSERT INTO `sys_oper_log` VALUES (216, '菜单管理', 3, 'com.pms.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '办公室', '/system/menu/2007', '127.0.0.1', '内网IP', '2007 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 11:15:06', 65);
INSERT INTO `sys_oper_log` VALUES (217, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"pm/archive/index\",\"createTime\":\"2026-07-28 10:08:21\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2013,\"menuName\":\"罪犯基础档案\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":4,\"path\":\"archive\",\"perms\":\"system:archive:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 11:15:32', 22);
INSERT INTO `sys_oper_log` VALUES (218, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"pm/archive/index\",\"createTime\":\"2026-07-28 10:08:21\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2013,\"menuName\":\"罪犯基础档案\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":4,\"path\":\"archive\",\"perms\":\"pm:archive:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 11:15:50', 28);
INSERT INTO `sys_oper_log` VALUES (219, '用户头像', 2, 'com.pms.web.controller.system.SysProfileController.avatar()', 'POST', 1, 'admin', '办公室', '/system/user/profile/avatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2026/07/28/070952122857425dbf4bf25b0cf2b67e.png\",\"code\":200}', 0, NULL, '2026-07-28 11:32:54', 153);
INSERT INTO `sys_oper_log` VALUES (220, '个人信息', 2, 'com.pms.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', '办公室', '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"13688401821@139.com\",\"nickName\":\"陈科长\",\"params\":{},\"phonenumber\":\"13688401821\",\"sex\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 11:32:56', 25);
INSERT INTO `sys_oper_log` VALUES (221, '个人信息', 2, 'com.pms.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', '办公室', '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"13688401821@139.com\",\"nickName\":\"陈科长\",\"params\":{},\"phonenumber\":\"13688401821\",\"sex\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 11:33:06', 17);
INSERT INTO `sys_oper_log` VALUES (222, '罪犯基础档案', 1, 'com.pms.system.controller.CriminalsArchiveController.add()', 'POST', 1, 'admin', '办公室', '/system/archive', '127.0.0.1', '内网IP', '{\"criminalName\":\"赵四\",\"criminalNo\":\"z-2023-1011\",\"id\":\"11\",\"params\":{}} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 11:34:50', 56);
INSERT INTO `sys_oper_log` VALUES (223, '通知公告', 2, 'com.pms.web.controller.system.SysNoticeController.edit()', 'PUT', 1, 'admin', '办公室', '/system/notice', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-07-26 16:19:03\",\"isRead\":false,\"noticeContent\":\"<p><span style=\\\"color: rgb(230, 0, 0);\\\">项目介绍</span></p><p><span style=\\\"color: rgb(51, 51, 51);\\\">岗位管理、定时任务、服务监控、登录日志、操作日志、代码生成等功能。其中，还支持多数据源、数据权限、国际化、Redis缓存、Docker部署、滑动验证码、第三方认证登录、分布式事务、、分库分表处理等技术特点。</span></p><p><img src=\\\"https://foruda.gitee.com/images/1773931848342439032/a4d22313_1815095.png\\\" style=\\\"width: 64px;\\\"></p><p><br></p><p><br style=\\\"color: rgb(48, 49, 51); font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; font-size: 12px;\\\"></p>\",\"noticeId\":3,\"noticeTitle\":\"四川省甘孜监狱执法证据保全系统v1介绍\",\"noticeType\":\"1\",\"params\":{},\"remark\":\"管理员\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 11:42:45', 28);
INSERT INTO `sys_oper_log` VALUES (224, '通知公告', 2, 'com.pms.web.controller.system.SysNoticeController.edit()', 'PUT', 1, 'admin', '办公室', '/system/notice', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-07-26 16:19:03\",\"isRead\":false,\"noticeContent\":\"<p><span style=\\\"color: rgb(230, 0, 0);\\\">项目介绍</span></p><p><span style=\\\"color: rgb(103, 106, 108);\\\">四川省甘孜监狱执法证据保全系统v1，是甘孜监狱为深化执法规范化建设、打造法治监狱而自主构建的智能化证据管理平台。系统以“一物一码、全程追溯、智能管控、安全闭环”为核心，依托rfid电子标签与物联网技术，实现物证、书证、电子数据等全类型证据从登记、入库、流转到销毁的全生命周期数字化管理。通过智能物联存储、24小时环境监控、异常行为自动报警与轨迹追溯，严格落实“九防”安全标准，确保证据物理与信息安全。系统支持省、监、区三级联网与跨部门数据对接，内置智能预警与统计分析功能，有效破解传统证据管理保存难、流转乱、追溯弱等痛点，显著提升证据链完整性与执法公信力，为甘孜监狱执法监督与规范化建设提供坚实科技支撑。</span></p><p><img src=\\\"/dev-api/profile/upload/2026/07/28/logo_20260728114402A001.png\\\"></p><p><br></p><p><br style=\\\"color: rgb(48, 49, 51); font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; font-size: 12px;\\\"></p>\",\"noticeId\":3,\"noticeTitle\":\"四川省甘孜监狱执法证据保全系统v1介绍\",\"noticeType\":\"1\",\"params\":{},\"remark\":\"管理员\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2026-07-28 11:42:45\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 11:44:04', 25);
INSERT INTO `sys_oper_log` VALUES (225, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"pm/archive/index\",\"createTime\":\"2026-07-28 10:08:21\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2013,\"menuName\":\"罪犯基础信息\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":4,\"path\":\"archive\",\"perms\":\"pm:archive:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 14:36:38', 42);
INSERT INTO `sys_oper_log` VALUES (226, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"pm/archive/index\",\"createTime\":\"2026-07-28 10:08:21\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2013,\"menuName\":\"罪犯基本信息\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":4,\"path\":\"archive\",\"perms\":\"pm:archive:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 14:38:43', 35);
INSERT INTO `sys_oper_log` VALUES (227, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-07-26 16:18:59\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":4,\"menuName\":\"罪犯管理\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"cm\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 14:39:58', 37);
INSERT INTO `sys_oper_log` VALUES (228, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"cm/archive/index\",\"createTime\":\"2026-07-28 10:08:21\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2013,\"menuName\":\"罪犯基本信息\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":4,\"path\":\"archive\",\"perms\":\"pm:archive:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 14:40:10', 65);
INSERT INTO `sys_oper_log` VALUES (229, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-07-26 16:18:59\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":4,\"menuName\":\"罪犯管理\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"pm\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 17:10:25', 61);
INSERT INTO `sys_oper_log` VALUES (230, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"pm/cm/index\",\"createTime\":\"2026-07-28 10:08:21\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2013,\"menuName\":\"罪犯基本信息\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":4,\"path\":\"archive\",\"perms\":\"pm:archive:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 17:11:10', 64);
INSERT INTO `sys_oper_log` VALUES (231, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"pm/cm/index\",\"createTime\":\"2026-07-28 10:08:21\",\"icon\":\"documentation\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2013,\"menuName\":\"罪犯基本信息\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":4,\"path\":\"archive\",\"perms\":\"pm:archive:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 17:20:31', 20);
INSERT INTO `sys_oper_log` VALUES (232, '罪犯基础档案', 5, 'com.pms.web.controller.cm.CriminalsArchiveController.export()', 'POST', 1, 'admin', '办公室', '/system/archive/export', '127.0.0.1', '内网IP', '{\"pageSize\":\"10\",\"pageNum\":\"1\"}', NULL, 0, NULL, '2026-07-28 17:20:53', 855);
INSERT INTO `sys_oper_log` VALUES (233, '代码生成', 6, 'com.pms.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '办公室', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"t_medical_records\",\"tplWebType\":\"element-plus-typescript\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 20:03:53', 95);
INSERT INTO `sys_oper_log` VALUES (234, '代码生成', 2, 'com.pms.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '办公室', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"medical\",\"className\":\"MedicalRecords\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"自增主键\",\"columnId\":65,\"columnName\":\"id\",\"columnType\":\"bigint unsigned\",\"createBy\":\"admin\",\"createTime\":\"2026-07-28 20:03:53\",\"dictType\":\"\",\"edit\":false,\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":9,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CriminalNo\",\"columnComment\":\"罪犯编号 (关联 t_criminals_archive.criminal_no)\",\"columnId\":66,\"columnName\":\"criminal_no\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2026-07-28 20:03:53\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"0\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"criminalNo\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":9,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"MedicalType\",\"columnComment\":\"就医类型: 1-狱内就医 2-离监就医\",\"columnId\":67,\"columnName\":\"medical_type\",\"columnType\":\"tinyint\",\"createBy\":\"admin\",\"createTime\":\"2026-07-28 20:03:53\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"select\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"0\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"medicalType\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":9,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"RecordFilePath\",\"columnComment\":\"就医记录\",\"columnId\":68,\"columnName\":\"record_file_path\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2026-07-28 20:03:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrem', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 20:10:44', 77);
INSERT INTO `sys_oper_log` VALUES (235, '代码生成', 8, 'com.pms.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '办公室', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"t_medical_records\"}', NULL, 0, NULL, '2026-07-28 20:11:37', 210);
INSERT INTO `sys_oper_log` VALUES (236, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"pm/medical/index\",\"createTime\":\"2026-07-28 20:13:43\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2019,\"menuName\":\"罪犯就医记录\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":4,\"path\":\"medical\",\"perms\":\"pm:medical:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 20:31:09', 91);
INSERT INTO `sys_oper_log` VALUES (237, '保存菜单排序', 2, 'com.pms.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', '办公室', '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"2013\",\"orderNums\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 20:31:14', 28);
INSERT INTO `sys_oper_log` VALUES (238, '菜单管理', 2, 'com.pms.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '办公室', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"pm/medical/index\",\"createTime\":\"2026-07-28 20:13:43\",\"icon\":\"druid\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2019,\"menuName\":\"罪犯就医记录\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":4,\"path\":\"medical\",\"perms\":\"pm:medical:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-28 20:32:17', 27);
INSERT INTO `sys_oper_log` VALUES (239, '罪犯基础档案', 1, 'com.pms.web.controller.pm.CriminalsArchiveController.add()', 'POST', 1, 'admin', '办公室', '/system/archive', '127.0.0.1', '内网IP', '{\"criminalName\":\"谢谢111\",\"criminalNo\":\"11111111111\",\"id\":\"12\",\"params\":{}} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-29 15:19:42', 38);
INSERT INTO `sys_oper_log` VALUES (240, '罪犯基础档案', 2, 'com.pms.web.controller.pm.CriminalsArchiveController.edit()', 'PUT', 1, 'admin', '办公室', '/system/archive', '127.0.0.1', '内网IP', '{\"createdAt\":\"2026-07-29 15:19:42\",\"criminalName\":\"杜月笙\",\"criminalNo\":\"11111111111\",\"id\":\"12\",\"params\":{},\"updatedAt\":\"2026-07-29 15:19:42\",\"uuid\":\"de7326f7-8b1d-11f1-980e-b025aa41a4ed\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-29 15:37:59', 31);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'Prison Warden', '监狱长', 1, '0', 'admin', '2026-07-26 16:18:59', 'admin', '2026-07-27 12:01:30', '');
INSERT INTO `sys_post` VALUES (2, 'Section Chief', '科长', 2, '0', 'admin', '2026-07-26 16:18:59', 'admin', '2026-07-27 12:01:07', '');
INSERT INTO `sys_post` VALUES (3, 'Guard', '警卫', 3, '0', 'admin', '2026-07-26 16:18:59', 'admin', '2026-07-27 12:02:13', '');
INSERT INTO `sys_post` VALUES (4, 'Technician', '技术员', 4, '0', 'admin', '2026-07-26 16:18:59', 'admin', '2026-07-27 12:02:50', '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2026-07-26 16:18:59', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2026-07-26 16:18:59', '', NULL, '普通角色');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 117);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime NULL DEFAULT NULL COMMENT '密码最后更新时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '陈科长', '00', '13688401821@139.com', '13688401821', '0', '/profile/avatar/2026/07/28/070952122857425dbf4bf25b0cf2b67e.png', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-07-31 12:03:21', '2026-07-26 16:18:58', 'admin', '2026-07-26 16:18:58', '', '2026-07-28 11:33:06', '管理员');
INSERT INTO `sys_user` VALUES (2, 103, 'LiuZhengPing', '刘正平', '00', '965625780@qq.com', '13551131957', '2', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-07-26 16:18:58', '2026-07-26 16:18:58', 'admin', '2026-07-26 16:18:58', 'admin', '2026-07-27 12:06:35', '测试员');
INSERT INTO `sys_user` VALUES (100, 103, 'XiePing', '谢平', '00', '', '', '2', '', '$2a$10$Ox7iiMRHdMo8gb9PQ5d.NO6z7bhMNRh8wvAmm6btzh6MpOTmTheDa', '0', '0', '', NULL, NULL, 'admin', '2026-07-27 12:06:10', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);
INSERT INTO `sys_user_post` VALUES (100, 4);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);
INSERT INTO `sys_user_role` VALUES (100, 2);

SET FOREIGN_KEY_CHECKS = 1;
