package com.pms.pm.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.pms.common.annotation.Excel;
import com.pms.common.core.domain.BaseEntity;

/**
 * 罪犯就医记录对象 t_medical_records
 * 
 * @author LiuZhengPing
 * @date 2026-08-01
 */
public class MedicalRecords extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 自增主键 */
    private Long id;

    /** 罪犯编号 (关联 t_criminals_archive.criminal_no) */
    @Excel(name = "罪犯编号")
    private String criminalNo;

    /** 就医类型: 1-狱内就医 2-离监就医 */
    @Excel(name = "就医类型", readConverterExp = "1=狱内就医,2=离监就医")
    private Integer medicalType;

    /** 就医记录文件路径 (图片/PDF/文档) */
    @Excel(name = "就医记录文件路径")
    private String recordFilePath;

    /** 就医记录录入时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "录入时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date createdAt;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setCriminalNo(String criminalNo) 
    {
        this.criminalNo = criminalNo;
    }

    public String getCriminalNo() 
    {
        return criminalNo;
    }

    public void setMedicalType(Integer medicalType) 
    {
        this.medicalType = medicalType;
    }

    public Integer getMedicalType() 
    {
        return medicalType;
    }

    public void setRecordFilePath(String recordFilePath) 
    {
        this.recordFilePath = recordFilePath;
    }

    public String getRecordFilePath() 
    {
        return recordFilePath;
    }

    public void setCreatedAt(Date createdAt) 
    {
        this.createdAt = createdAt;
    }

    public Date getCreatedAt() 
    {
        return createdAt;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("criminalNo", getCriminalNo())
            .append("medicalType", getMedicalType())
            .append("recordFilePath", getRecordFilePath())
            .append("createdAt", getCreatedAt())
            .toString();
    }
}
