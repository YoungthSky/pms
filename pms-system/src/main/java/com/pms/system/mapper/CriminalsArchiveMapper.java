package com.pms.system.mapper;

import java.util.List;
import com.pms.system.domain.CriminalsArchive;

/**
 * 罪犯基础档案Mapper接口
 * 
 * @author LiuZhengPing
 * @date 2026-07-28
 */
public interface CriminalsArchiveMapper 
{
    /**
     * 查询罪犯基础档案
     * 
     * @param id 罪犯基础档案主键
     * @return 罪犯基础档案
     */
    public CriminalsArchive selectCriminalsArchiveById(String id);

    /**
     * 查询罪犯基础档案列表
     * 
     * @param criminalsArchive 罪犯基础档案
     * @return 罪犯基础档案集合
     */
    public List<CriminalsArchive> selectCriminalsArchiveList(CriminalsArchive criminalsArchive);

    /**
     * 新增罪犯基础档案
     * 
     * @param criminalsArchive 罪犯基础档案
     * @return 结果
     */
    public int insertCriminalsArchive(CriminalsArchive criminalsArchive);

    /**
     * 修改罪犯基础档案
     * 
     * @param criminalsArchive 罪犯基础档案
     * @return 结果
     */
    public int updateCriminalsArchive(CriminalsArchive criminalsArchive);

    /**
     * 删除罪犯基础档案
     * 
     * @param id 罪犯基础档案主键
     * @return 结果
     */
    public int deleteCriminalsArchiveById(String id);

    /**
     * 批量删除罪犯基础档案
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteCriminalsArchiveByIds(String[] ids);
}
