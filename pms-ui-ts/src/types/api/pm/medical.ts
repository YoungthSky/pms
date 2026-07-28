import type { PageDomain, BaseEntity } from "../common";

/** 罪犯就医记录配置分页查询参数 */
export interface MedicalQueryParams extends PageDomain {
}

/** 罪犯就医记录配置信息 */
export interface MedicalRecords extends BaseEntity {
  /** 自增主键 */
  id?: string;
  /** 罪犯编号 (关联 t_criminals_archive.criminal_no) */
  criminalNo?: string;
  /** 就医类型: 1-狱内就医 2-离监就医 */
  medicalType?: number;
  /** 就医记录 */
  recordFilePath?: string;
  /** 录入时间 */
  createdAt?: string;
}
