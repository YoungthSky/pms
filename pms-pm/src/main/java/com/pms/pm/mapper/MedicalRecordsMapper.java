package com.pms.pm.mapper;

import java.util.List;
import com.pms.pm.domain.MedicalRecords;

/**
 * 罪犯就医记录Mapper接口
 * 
 * @author LiuZhengPing
 * @date 2026-08-01
 */
public interface MedicalRecordsMapper 
{
    /**
     * 查询罪犯就医记录
     * 
     * @param id 罪犯就医记录主键
     * @return 罪犯就医记录
     */
    public MedicalRecords selectMedicalRecordsById(Long id);

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
     * 删除罪犯就医记录
     * 
     * @param id 罪犯就医记录主键
     * @return 结果
     */
    public int deleteMedicalRecordsById(Long id);

    /**
     * 批量删除罪犯就医记录
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteMedicalRecordsByIds(Long[] ids);
}
