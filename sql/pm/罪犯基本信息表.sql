-- 删除已存在的表（谨慎操作，生产环境请勿直接执行）
DROP TABLE IF EXISTS `t_criminals_archive`;

-- 创建罪犯基础档案表
CREATE TABLE `t_criminals_archive` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT COMMENT '自增主键',
    `uuid` CHAR(36) NOT NULL DEFAULT (UUID()) COMMENT '全局唯一标识符(UUID)',
    
    -- 核心业务字段
    `criminal_no` VARCHAR(20) NOT NULL COMMENT '罪犯编号(唯一业务标识)',
    `criminal_name` VARCHAR(50) NOT NULL COMMENT '罪犯姓名',
    
    -- 附件信息
    `basic_info_path` VARCHAR(255) DEFAULT NULL COMMENT '基本信息文件存储路径(如PDF/JSON路径)',
    
    -- 审计字段
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `created_by` VARCHAR(50) DEFAULT NULL COMMENT '录入人',
    
    -- 约束与索引
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_uuid` (`uuid`),
    UNIQUE KEY `uk_criminal_no` (`criminal_no`),
    KEY `idx_criminal_name` (`criminal_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='罪犯基础档案表';

-- 插入10条测试数据
INSERT INTO `t_criminals_archive` (
    `criminal_no`, 
    `criminal_name`, 
    `basic_info_path`, 
    `created_by`
) VALUES 
('Z-2023-1001', '张伟', '/data/files/criminals/Z-2023-1001_profile.pdf', 'admin'),
('Z-2023-1002', '李娜', '/data/files/criminals/Z-2023-1002_profile.pdf', 'admin'),
('Z-2023-1003', '王强', '/data/files/criminals/Z-2023-1003_profile.pdf', 'operator_01'),
('Z-2023-1004', '刘洋', '/data/files/criminals/Z-2023-1004_profile.pdf', 'operator_01'),
('Z-2023-1005', '陈静', '/data/files/criminals/Z-2023-1005_profile.pdf', 'admin'),
('Z-2023-1006', '杨秀英', '/data/files/criminals/Z-2023-1006_profile.pdf', 'operator_02'),
('Z-2023-1007', '赵军', '/data/files/criminals/Z-2023-1007_profile.pdf', 'admin'),
('Z-2023-1008', '黄勇', '/data/files/criminals/Z-2023-1008_profile.pdf', 'operator_01'),
('Z-2023-1009', '周敏', '/data/files/criminals/Z-2023-1009_profile.pdf', 'operator_02'),
('Z-2023-1010', '吴刚', '/data/files/criminals/Z-2023-1010_profile.pdf', 'admin');

-- 验证插入结果
SELECT * FROM `t_criminals_archive` ORDER BY `id` ASC;
