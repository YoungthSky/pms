package com.pms.system.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.pms.common.annotation.Excel;
import com.pms.common.core.domain.BaseEntity;

/**
 * 罪犯基础档案对象 t_criminals_archive
 * 
 * @author LiuZhengPing
 * @date 2026-07-28
 */
public class CriminalsArchive extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 自增主键 */
    private String id;

    /** 全局唯一标识符(UUID) */
    private String uuid;

    /** 罪犯编号(唯一业务标识) */
    @Excel(name = "罪犯编号(唯一业务标识)")
    private String criminalNo;

    /** 罪犯姓名 */
    @Excel(name = "罪犯姓名")
    private String criminalName;

    /** 基本信息文件存储路径(如PDF/JSON路径) */
    @Excel(name = "基本信息文件存储路径(如PDF/JSON路径)")
    private String basicInfoPath;

    /** 创建时间 */
    private Date createdAt;

    /** 更新时间 */
    private Date updatedAt;

    /** 录入人 */
    private String createdBy;

    public void setId(String id) 
    {
        this.id = id;
    }

    public String getId() 
    {
        return id;
    }

    public void setUuid(String uuid) 
    {
        this.uuid = uuid;
    }

    public String getUuid() 
    {
        return uuid;
    }

    public void setCriminalNo(String criminalNo) 
    {
        this.criminalNo = criminalNo;
    }

    public String getCriminalNo() 
    {
        return criminalNo;
    }

    public void setCriminalName(String criminalName) 
    {
        this.criminalName = criminalName;
    }

    public String getCriminalName() 
    {
        return criminalName;
    }

    public void setBasicInfoPath(String basicInfoPath) 
    {
        this.basicInfoPath = basicInfoPath;
    }

    public String getBasicInfoPath() 
    {
        return basicInfoPath;
    }

    public void setCreatedAt(Date createdAt) 
    {
        this.createdAt = createdAt;
    }

    public Date getCreatedAt() 
    {
        return createdAt;
    }

    public void setUpdatedAt(Date updatedAt) 
    {
        this.updatedAt = updatedAt;
    }

    public Date getUpdatedAt() 
    {
        return updatedAt;
    }

    public void setCreatedBy(String createdBy) 
    {
        this.createdBy = createdBy;
    }

    public String getCreatedBy() 
    {
        return createdBy;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("uuid", getUuid())
            .append("criminalNo", getCriminalNo())
            .append("criminalName", getCriminalName())
            .append("basicInfoPath", getBasicInfoPath())
            .append("createdAt", getCreatedAt())
            .append("updatedAt", getUpdatedAt())
            .append("createdBy", getCreatedBy())
            .toString();
    }
}
