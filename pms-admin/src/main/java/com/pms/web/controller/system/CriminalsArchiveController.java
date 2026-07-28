package com.pms.system.controller;

import java.util.List;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.pms.common.annotation.Log;
import com.pms.common.core.controller.BaseController;
import com.pms.common.core.domain.AjaxResult;
import com.pms.common.enums.BusinessType;
import com.pms.system.domain.CriminalsArchive;
import com.pms.system.service.ICriminalsArchiveService;
import com.pms.common.utils.poi.ExcelUtil;
import com.pms.common.core.page.TableDataInfo;

/**
 * 罪犯基础档案Controller
 * 
 * @author LiuZhengPing
 * @date 2026-07-28
 */
@RestController
@RequestMapping("/system/archive")
public class CriminalsArchiveController extends BaseController
{
    @Autowired
    private ICriminalsArchiveService criminalsArchiveService;

    /**
     * 查询罪犯基础档案列表
     */
    @PreAuthorize("@ss.hasPermi('system:archive:list')")
    @GetMapping("/list")
    public TableDataInfo list(CriminalsArchive criminalsArchive)
    {
        startPage();
        List<CriminalsArchive> list = criminalsArchiveService.selectCriminalsArchiveList(criminalsArchive);
        return getDataTable(list);
    }

    /**
     * 导出罪犯基础档案列表
     */
    @PreAuthorize("@ss.hasPermi('system:archive:export')")
    @Log(title = "罪犯基础档案", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, CriminalsArchive criminalsArchive)
    {
        List<CriminalsArchive> list = criminalsArchiveService.selectCriminalsArchiveList(criminalsArchive);
        ExcelUtil<CriminalsArchive> util = new ExcelUtil<CriminalsArchive>(CriminalsArchive.class);
        util.exportExcel(response, list, "罪犯基础档案数据");
    }

    /**
     * 获取罪犯基础档案详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:archive:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") String id)
    {
        return success(criminalsArchiveService.selectCriminalsArchiveById(id));
    }

    /**
     * 新增罪犯基础档案
     */
    @PreAuthorize("@ss.hasPermi('system:archive:add')")
    @Log(title = "罪犯基础档案", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody CriminalsArchive criminalsArchive)
    {
        return toAjax(criminalsArchiveService.insertCriminalsArchive(criminalsArchive));
    }

    /**
     * 修改罪犯基础档案
     */
    @PreAuthorize("@ss.hasPermi('system:archive:edit')")
    @Log(title = "罪犯基础档案", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody CriminalsArchive criminalsArchive)
    {
        return toAjax(criminalsArchiveService.updateCriminalsArchive(criminalsArchive));
    }

    /**
     * 删除罪犯基础档案
     */
    @PreAuthorize("@ss.hasPermi('system:archive:remove')")
    @Log(title = "罪犯基础档案", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable String[] ids)
    {
        return toAjax(criminalsArchiveService.deleteCriminalsArchiveByIds(ids));
    }
}
