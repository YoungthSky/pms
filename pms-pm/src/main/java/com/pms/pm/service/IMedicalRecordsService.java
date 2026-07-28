package com.pms.pm.service;

import java.util.List;
import com.pms.pm.domain.MedicalRecords;

/**
 * 罪犯就医记录Service接口
 * 
 * @author LiuZhengPing
 * @date 2026-07-28
 */
public interface IMedicalRecordsService 
{
    /**
     * 查询罪犯就医记录
     * 
     * @param id 罪犯就医记录主键
     * @return 罪犯就医记录
     */
    public MedicalRecords selectMedicalRecordsById(String id);

    /**
     * 查询罪犯就医记录列表
     * 
     * @param medicalRecords 罪犯就医记录
     * @return 罪犯就医记录集合
     */
    public List<MedicalRecords> selectMedicalRecordsList(MedicalRecords medicalRecords);

    /**
     * 新增罪犯就医记录
     * 
     * @param medicalRecords 罪犯就医记录
     * @return 结果
     */
    public int insertMedicalRecords(MedicalRecords medicalRecords);

    /**
     * 修改罪犯就医记录
     * 
     * @param medicalRecords 罪犯就医记录
     * @return 结果
     */
    public int updateMedicalRecords(MedicalRecords medicalRecords);

    /**
     * 批量删除罪犯就医记录
     * 
     * @param ids 需要删除的罪犯就医记录主键集合
     * @return 结果
     */
    public int deleteMedicalRecordsByIds(String[] ids);

    /**
     * 删除罪犯就医记录信息
     * 
     * @param id 罪犯就医记录主键
     * @return 结果
     */
    public int deleteMedicalRecordsById(String id);
}
