package com.pms.pm.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.pms.pm.mapper.MedicalVideosMapper;
import com.pms.pm.domain.MedicalVideos;
import com.pms.pm.service.IMedicalVideosService;

/**
 * 罪犯就医视频Service业务层处理
 * 
 * @author LiuZhengPing
 * @date 2026-08-01
 */
@Service
public class MedicalVideosServiceImpl implements IMedicalVideosService 
{
    @Autowired
    private MedicalVideosMapper medicalVideosMapper;

    /**
     * 查询罪犯就医视频
     * 
     * @param id 罪犯就医视频主键
     * @return 罪犯就医视频
     */
    @Override
    public MedicalVideos selectMedicalVideosById(Long id)
    {
        return medicalVideosMapper.selectMedicalVideosById(id);
    }

    /**
     * 查询罪犯就医视频列表
     * 
     * @param medicalVideos 罪犯就医视频
     * @return 罪犯就医视频
     */
    @Override
    public List<MedicalVideos> selectMedicalVideosList(MedicalVideos medicalVideos)
    {
        return medicalVideosMapper.selectMedicalVideosList(medicalVideos);
    }

    /**
     * 新增罪犯就医视频
     * 
     * @param medicalVideos 罪犯就医视频
     * @return 结果
     */
    @Override
    public int insertMedicalVideos(MedicalVideos medicalVideos)
    {
        return medicalVideosMapper.insertMedicalVideos(medicalVideos);
    }

    /**
     * 批量删除罪犯就医视频
     * 
     * @param ids 需要删除的罪犯就医视频主键
     * @return 结果
     */
    @Override
    public int deleteMedicalVideosByIds(Long[] ids)
    {
        return medicalVideosMapper.deleteMedicalVideosByIds(ids);
    }

    /**
     * 删除罪犯就医视频信息
     * 
     * @param id 罪犯就医视频主键
     * @return 结果
     */
    @Override
    public int deleteMedicalVideosById(Long id)
    {
        return medicalVideosMapper.deleteMedicalVideosById(id);
    }
}
