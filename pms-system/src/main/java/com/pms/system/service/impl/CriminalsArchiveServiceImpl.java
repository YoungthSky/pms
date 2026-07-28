package com.pms.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.pms.system.mapper.CriminalsArchiveMapper;
import com.pms.system.domain.CriminalsArchive;
import com.pms.system.service.ICriminalsArchiveService;

/**
 * 罪犯基础档案Service业务层处理
 * 
 * @author LiuZhengPing
 * @date 2026-07-28
 */
@Service
public class CriminalsArchiveServiceImpl implements ICriminalsArchiveService 
{
    @Autowired
    private CriminalsArchiveMapper criminalsArchiveMapper;

    /**
     * 查询罪犯基础档案
     * 
     * @param id 罪犯基础档案主键
     * @return 罪犯基础档案
     */
    @Override
    public CriminalsArchive selectCriminalsArchiveById(String id)
    {
        return criminalsArchiveMapper.selectCriminalsArchiveById(id);
    }

    /**
     * 查询罪犯基础档案列表
     * 
     * @param criminalsArchive 罪犯基础档案
     * @return 罪犯基础档案
     */
    @Override
    public List<CriminalsArchive> selectCriminalsArchiveList(CriminalsArchive criminalsArchive)
    {
        return criminalsArchiveMapper.selectCriminalsArchiveList(criminalsArchive);
    }

    /**
     * 新增罪犯基础档案
     * 
     * @param criminalsArchive 罪犯基础档案
     * @return 结果
     */
    @Override
    public int insertCriminalsArchive(CriminalsArchive criminalsArchive)
    {
        return criminalsArchiveMapper.insertCriminalsArchive(criminalsArchive);
    }

    /**
     * 修改罪犯基础档案
     * 
     * @param criminalsArchive 罪犯基础档案
     * @return 结果
     */
    @Override
    public int updateCriminalsArchive(CriminalsArchive criminalsArchive)
    {
        return criminalsArchiveMapper.updateCriminalsArchive(criminalsArchive);
    }

    /**
     * 批量删除罪犯基础档案
     * 
     * @param ids 需要删除的罪犯基础档案主键
     * @return 结果
     */
    @Override
    public int deleteCriminalsArchiveByIds(String[] ids)
    {
        return criminalsArchiveMapper.deleteCriminalsArchiveByIds(ids);
    }

    /**
     * 删除罪犯基础档案信息
     * 
     * @param id 罪犯基础档案主键
     * @return 结果
     */
    @Override
    public int deleteCriminalsArchiveById(String id)
    {
        return criminalsArchiveMapper.deleteCriminalsArchiveById(id);
    }
}
