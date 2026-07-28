import type { PageDomain, BaseEntity } from "../../common";

/** 罪犯基础档案配置分页查询参数 */
export interface ArchiveQueryParams extends PageDomain {
  /** 罪犯编号(唯一业务标识) */
  criminalNo?: string;
  /** 罪犯姓名 */
  criminalName?: string;
  /** 基本信息文件存储路径(如PDF/JSON路径) */
  basicInfoPath?: string;
}

/** 罪犯基础档案配置信息 */
export interface CriminalsArchive extends BaseEntity {
  /** 自增主键 */
  id?: string;
  /** 全局唯一标识符(UUID) */
  uuid?: string;
  /** 罪犯编号(唯一业务标识) */
  criminalNo?: string;
  /** 罪犯姓名 */
  criminalName?: string;
  /** 基本信息文件存储路径(如PDF/JSON路径) */
  basicInfoPath?: string;
  /** 创建时间 */
  createdAt?: string;
  /** 更新时间 */
  updatedAt?: string;
  /** 录入人 */
  createdBy?: string;
}
