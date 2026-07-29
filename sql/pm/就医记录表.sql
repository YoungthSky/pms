SET NAMES utf8mb4;

-- 删除已存在的表（谨慎操作）
DROP TABLE IF EXISTS `t_medical_records`;

-- 创建罪犯就医记录表
CREATE TABLE `t_medical_records` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT COMMENT '自增主键',
    
    -- 关联字段 (直接关联业务编号)
    `criminal_no` VARCHAR(20) NOT NULL COMMENT '罪犯编号 (关联 t_criminals_archive.criminal_no)',
    
    -- 核心业务字段
    `medical_type` TINYINT NOT NULL COMMENT '就医类型: 1-狱内就医 2-离监就医',
    `record_file_path` VARCHAR(500) NOT NULL COMMENT '就医记录文件路径 (图片/PDF/文档)',
    
    -- 审计字段
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '就医记录录入时间',
    
    -- 约束与索引
    PRIMARY KEY (`id`),
    KEY `idx_criminal_no` (`criminal_no`),
    CONSTRAINT `fk_medical_criminal_no` FOREIGN KEY (`criminal_no`) REFERENCES `t_criminals_archive`(`criminal_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='罪犯就医记录表';


INSERT INTO `t_medical_records` (
    `criminal_no`, 
    `medical_type`, 
    `record_file_path`
) VALUES 
-- 张伟 (Z-2023-1001): 2条记录
('Z-2023-1001', 1, '/data/files/medical/Z-2023-1001/2023/11/medical_rec_001.pdf'),
('Z-2023-1001', 3, '/data/files/medical/Z-2023-1001/2024/01/medical_rec_002.pdf'),

-- 李娜 (Z-2023-1002): 1条记录
('Z-2023-1002', 2, '/data/files/medical/Z-2023-1002/2023/12/medical_rec_001.pdf'),

-- 王强 (Z-2023-1003): 3条记录
('Z-2023-1003', 1, '/data/files/medical/Z-2023-1003/2023/10/medical_rec_001.pdf'),
('Z-2023-1003', 1, '/data/files/medical/Z-2023-1003/2024/02/medical_rec_002.pdf'),
('Z-2023-1003', 3, '/data/files/medical/Z-2023-1003/2024/03/medical_rec_003.pdf'),

-- 刘洋 (Z-2023-1004): 1条记录
('Z-2023-1004', 2, '/data/files/medical/Z-2023-1004/2023/11/medical_rec_001.pdf'),

-- 陈静 (Z-2023-1005): 2条记录
('Z-2023-1005', 3, '/data/files/medical/Z-2023-1005/2023/12/medical_rec_001.pdf'),
('Z-2023-1005', 1, '/data/files/medical/Z-2023-1005/2024/01/medical_rec_002.pdf'),

-- 杨秀英 (Z-2023-1006): 3条记录
('Z-2023-1006', 2, '/data/files/medical/Z-2023-1006/2023/10/medical_rec_001.pdf'),
('Z-2023-1006', 1, '/data/files/medical/Z-2023-1006/2023/12/medical_rec_002.pdf'),
('Z-2023-1006', 3, '/data/files/medical/Z-2023-1006/2024/02/medical_rec_003.pdf'),

-- 赵军 (Z-2023-1007): 1条记录
('Z-2023-1007', 1, '/data/files/medical/Z-2023-1007/2024/01/medical_rec_001.pdf'),

-- 黄勇 (Z-2023-1008): 2条记录
('Z-2023-1008', 3, '/data/files/medical/Z-2023-1008/2023/11/medical_rec_001.pdf'),
('Z-2023-1008', 2, '/data/files/medical/Z-2023-1008/2024/03/medical_rec_002.pdf'),

-- 周敏 (Z-2023-1009): 3条记录
('Z-2023-1009', 1, '/data/files/medical/Z-2023-1009/2023/10/medical_rec_001.pdf'),
('Z-2023-1009', 2, '/data/files/medical/Z-2023-1009/2023/12/medical_rec_002.pdf'),
('Z-2023-1009', 1, '/data/files/medical/Z-2023-1009/2024/02/medical_rec_003.pdf'),

-- 吴刚 (Z-2023-1010): 1条记录
('Z-2023-1010', 3, '/data/files/medical/Z-2023-1010/2024/01/medical_rec_001.pdf');

-- 验证插入结果
SELECT * FROM `t_medical_records` ORDER BY `id` ASC;