package com.pms.pm.service;

import java.util.List;
import com.pms.pm.domain.MedicalVideos;

/**
 * 罪犯就医视频Service接口
 * 
 * @author LiuZhengPing
 * @date 2026-08-01
 */
public interface IMedicalVideosService 
{
    /**
     * 查询罪犯就医视频
     * 
     * @param id 罪犯就医视频主键
     * @return 罪犯就医视频
     */
    public MedicalVideos selectMedicalVideosById(Long id);

    /**
     * 查询罪犯就医视频列表
     * 
     * @param medicalVideos 罪犯就医视频
     * @return 罪犯就医视频集合
     */
    public List<MedicalVideos> selectMedicalVideosList(MedicalVideos medicalVideos);

    /**
     * 新增罪犯就医视频
     * 
     * @param medicalVideos 罪犯就医视频
     * @return 结果
     */
    public int insertMedicalVideos(MedicalVideos medicalVideos);

    /**
     * 批量删除罪犯就医视频
     * 
     * @param ids 需要删除的罪犯就医视频主键集合
     * @return 结果
     */
    public int deleteMedicalVideosByIds(Long[] ids);

    /**
     * 删除罪犯就医视频信息
     * 
     * @param id 罪犯就医视频主键
     * @return 结果
     */
    public int deleteMedicalVideosById(Long id);
}
