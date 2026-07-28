package com.pms.pm.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.pms.pm.mapper.MedicalRecordsMapper;
import com.pms.pm.domain.MedicalRecords;
import com.pms.pm.service.IMedicalRecordsService;

/**
 * 罪犯就医记录Service业务层处理
 * 
 * @author LiuZhengPing
 * @date 2026-07-28
 */
@Service
public class MedicalRecordsServiceImpl implements IMedicalRecordsService 
{
    @Autowired
    private MedicalRecordsMapper medicalRecordsMapper;

    /**
     * 查询罪犯就医记录
     * 
     * @param id 罪犯就医记录主键
     * @return 罪犯就医记录
     */
    @Override
    public MedicalRecords selectMedicalRecordsById(String id)
    {
        return medicalRecordsMapper.selectMedicalRecordsById(id);
    }

    /**
     * 查询罪犯就医记录列表
     * 
     * @param medicalRecords 罪犯就医记录
     * @return 罪犯就医记录
     */
    @Override
    public List<MedicalRecords> selectMedicalRecordsList(MedicalRecords medicalRecords)
    {
        return medicalRecordsMapper.selectMedicalRecordsList(medicalRecords);
    }

    /**
     * 新增罪犯就医记录
     * 
     * @param medicalRecords 罪犯就医记录
     * @return 结果
     */
    @Override
    public int insertMedicalRecords(MedicalRecords medicalRecords)
    {
        return medicalRecordsMapper.insertMedicalRecords(medicalRecords);
    }

    /**
     * 修改罪犯就医记录
     * 
     * @param medicalRecords 罪犯就医记录
     * @return 结果
     */
    @Override
    public int updateMedicalRecords(MedicalRecords medicalRecords)
    {
        return medicalRecordsMapper.updateMedicalRecords(medicalRecords);
    }

    /**
     * 批量删除罪犯就医记录
     * 
     * @param ids 需要删除的罪犯就医记录主键
     * @return 结果
     */
    @Override
    public int deleteMedicalRecordsByIds(String[] ids)
    {
        return medicalRecordsMapper.deleteMedicalRecordsByIds(ids);
    }

    /**
     * 删除罪犯就医记录信息
     * 
     * @param id 罪犯就医记录主键
     * @return 结果
     */
    @Override
    public int deleteMedicalRecordsById(String id)
    {
        return medicalRecordsMapper.deleteMedicalRecordsById(id);
    }
}
