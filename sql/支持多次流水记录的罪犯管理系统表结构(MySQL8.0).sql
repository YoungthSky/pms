SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ==========================================
-- 1. 主表：罪犯基本信息表
-- 存储静态、唯一的身份信息
-- ==========================================
DROP TABLE IF EXISTS t_prisoner_base;
CREATE TABLE t_prisoner_base (
    prisoner_no VARCHAR(50) NOT NULL COMMENT '罪犯编号',
    name VARCHAR(50) NOT NULL COMMENT '罪犯姓名',
    -- 如果“管控信息”中的“主管民警”是当前唯一的，也可以放这里，否则放子表
    -- 此处暂只保留导图根节点明确的基本身份字段
    PRIMARY KEY (prisoner_no)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='罪犯基本信息主表';

-- ==========================================
-- 2. 子表：就医信息表 (支持多次记录)
-- 每次就医产生一条新记录
-- ==========================================
DROP TABLE IF EXISTS t_medical_record;
CREATE TABLE t_medical_record (
    id BIGINT AUTO_INCREMENT,
    prisoner_no VARCHAR(50) NOT NULL COMMENT '罪犯编号',
    record_type ENUM('普通就医', '离监就医', '狱内就医') DEFAULT '普通就医' COMMENT '就医类型',
    record_image_path VARCHAR(500) COMMENT '就医记录图片路径', -- 对应: 就医记录/离监/狱内记录
    video_path VARCHAR(500) COMMENT '就医视频路径',             -- 对应: 就医视频
    visit_date DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '就诊时间', -- 系统辅助字段，用于排序
    PRIMARY KEY (id),
    INDEX idx_prisoner (prisoner_no),
    CONSTRAINT fk_med_prisoner FOREIGN KEY (prisoner_no) REFERENCES t_prisoner_base(prisoner_no) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='就医流水记录表';

-- ==========================================
-- 3. 子表：管控信息表
-- 注：如果“五专五定”和“主管民警”会随时间变更，也建议作为流水记录；
-- 如果只关注当前状态，可只存一条。此处按“可能变更”处理，支持多条历史。
-- ==========================================
DROP TABLE IF EXISTS t_control_record;
CREATE TABLE t_control_record (
    id BIGINT AUTO_INCREMENT,
    prisoner_no VARCHAR(50) NOT NULL COMMENT '罪犯编号',
    police_name VARCHAR(50) COMMENT '主管民警姓名',   -- 对应: 姓名
    police_badge_no VARCHAR(20) COMMENT '主管民警警号', -- 对应: 警号
    five_special_detail JSON COMMENT '五专五定情况',    -- 对应: 五专五定情况
    effective_date DATE COMMENT '生效日期',
    is_current TINYINT DEFAULT 1 COMMENT '是否当前有效',
    PRIMARY KEY (id),
    INDEX idx_prisoner (prisoner_no),
    CONSTRAINT fk_ctrl_prisoner FOREIGN KEY (prisoner_no) REFERENCES t_prisoner_base(prisoner_no) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='管控变更记录表';

-- ==========================================
-- 4. 子表：减假暂信息表 (支持多次裁定)
-- ==========================================
DROP TABLE IF EXISTS t_sentence_change_record;
CREATE TABLE t_sentence_change_record (
    id BIGINT AUTO_INCREMENT,
    prisoner_no VARCHAR(50) NOT NULL COMMENT '罪犯编号',
    change_type ENUM('减刑', '假释', '暂予监外执行') NOT NULL COMMENT '变动类型',
    info_content TEXT COMMENT '详细信息内容', -- 统一存储减刑/假释/暂予监外的具体文本描述
    ruling_date DATE COMMENT '裁定日期',
    PRIMARY KEY (id),
    INDEX idx_prisoner (prisoner_no),
    CONSTRAINT fk_sent_prisoner FOREIGN KEY (prisoner_no) REFERENCES t_prisoner_base(prisoner_no) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='减假暂流水记录表';

-- ==========================================
-- 5. 子表：教育改造信息表 (支持多次考核)
-- ==========================================
DROP TABLE IF EXISTS t_education_record;
CREATE TABLE t_education_record (
    id BIGINT AUTO_INCREMENT,
    prisoner_no VARCHAR(50) NOT NULL COMMENT '罪犯编号',
    three_classes_content TEXT COMMENT '三课教育情况',
    assessment_content TEXT COMMENT '考核情况',
    record_date DATE COMMENT '记录日期',
    PRIMARY KEY (id),
    INDEX idx_prisoner (prisoner_no),
    CONSTRAINT fk_edu_prisoner FOREIGN KEY (prisoner_no) REFERENCES t_prisoner_base(prisoner_no) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='教育改造流水记录表';

-- ==========================================
-- 6. 子表：通信信息表 (支持多次收发信)
-- ==========================================
DROP TABLE IF EXISTS t_communication_record;
CREATE TABLE t_communication_record (
    id BIGINT AUTO_INCREMENT,
    prisoner_no VARCHAR(50) NOT NULL COMMENT '罪犯编号',
    comm_type ENUM('收信', '寄信', '违规查处') NOT NULL COMMENT '通信类型',
    content_detail TEXT COMMENT '登记详情/查处详情', -- 对应: 收信登记/寄信登记/违规查处
    comm_date DATE COMMENT '通信日期',
    PRIMARY KEY (id),
    INDEX idx_prisoner (prisoner_no),
    CONSTRAINT fk_comm_prisoner FOREIGN KEY (prisoner_no) REFERENCES t_prisoner_base(prisoner_no) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='通信流水记录表';

-- ==========================================
-- 7. 子表：亲情电话信息表 (支持多次拨打)
-- ==========================================
DROP TABLE IF EXISTS t_phone_call_record;
CREATE TABLE t_phone_call_record (
    id BIGINT AUTO_INCREMENT,
    prisoner_no VARCHAR(50) NOT NULL COMMENT '罪犯编号',
    approval_form_data JSON COMMENT '审批表内容(JSON)',      -- 对应: 审批表
    call_detail TEXT COMMENT '拨打记录详情',                 -- 对应: 拨打记录
    called_object_info TEXT COMMENT '拨打对象登记信息',       -- 对应: 拨打对象登记
    audio_path VARCHAR(500) COMMENT '录音文件路径',           -- 对应: 录音记录
    call_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '通话时间',
    PRIMARY KEY (id),
    INDEX idx_prisoner (prisoner_no),
    CONSTRAINT fk_phone_prisoner FOREIGN KEY (prisoner_no) REFERENCES t_prisoner_base(prisoner_no) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='亲情电话流水记录表';

-- ==========================================
-- 8. 子表：亲情会见信息表 (支持多次会见)
-- ==========================================
DROP TABLE IF EXISTS t_visit_record;
CREATE TABLE t_visit_record (
    id BIGINT AUTO_INCREMENT,
    prisoner_no VARCHAR(50) NOT NULL COMMENT '罪犯编号',
    visit_type ENUM('现场会见', '远程视频会见') NOT NULL COMMENT '会见类型',
    visit_form_content TEXT COMMENT '会见单内容',             -- 对应: 会见单
    relationship_proof_path VARCHAR(500) COMMENT '亲属关系证明路径', -- 对应: 亲属关系证明
    av_record_path VARCHAR(500) COMMENT '音视频记录路径',     -- 对应: 现场音视频记录
    visit_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '会见时间',
    PRIMARY KEY (id),
    INDEX idx_prisoner (prisoner_no),
    CONSTRAINT fk_visit_prisoner FOREIGN KEY (prisoner_no) REFERENCES t_prisoner_base(prisoner_no) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='亲情会见流水记录表';

SET FOREIGN_KEY_CHECKS = 1;
