import type { PageDomain, BaseEntity } from "../common";

/** 罪犯就医视频分页查询参数 */
export interface VideoQueryParams extends PageDomain {
  /** 罪犯编号 */
  criminalNo?: string;
}

/** 罪犯就医视频信息 */
export interface MedicalVideos extends BaseEntity {
  /** 自增主键 */
  id?: number;
  /** 罪犯编号 (关联 t_criminals_archive.criminal_no) */
  criminalNo?: string;
  /** 就医视频文件路径 */
  videoFilePath?: string;
  /** 录入时间 */
  createdAt?: string;
}
