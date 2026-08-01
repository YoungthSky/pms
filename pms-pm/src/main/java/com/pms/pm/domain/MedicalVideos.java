package com.pms.pm.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.pms.common.annotation.Excel;
import com.pms.common.core.domain.BaseEntity;

/**
 * 罪犯就医视频对象 t_medical_videos
 * 
 * @author LiuZhengPing
 * @date 2026-08-01
 */
public class MedicalVideos extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 自增主键 */
    private Long id;

    /** 罪犯编号 (关联 t_criminals_archive.criminal_no) */
    @Excel(name = "罪犯编号")
    private String criminalNo;

    /** 就医视频文件路径 */
    @Excel(name = "视频文件路径")
    private String videoFilePath;

    /** 视频录入时间 */
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

    public void setVideoFilePath(String videoFilePath) 
    {
        this.videoFilePath = videoFilePath;
    }

    public String getVideoFilePath() 
    {
        return videoFilePath;
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
            .append("videoFilePath", getVideoFilePath())
            .append("createdAt", getCreatedAt())
            .toString();
    }
}
