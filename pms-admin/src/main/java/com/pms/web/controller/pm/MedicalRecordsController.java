package com.pms.web.controller.pm;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import com.pms.common.annotation.Log;
import com.pms.common.config.RuoYiConfig;
import com.pms.common.core.controller.BaseController;
import com.pms.common.core.domain.AjaxResult;
import com.pms.common.enums.BusinessType;
import com.pms.common.utils.file.FileUploadUtils;
import com.pms.pm.domain.MedicalRecords;
import com.pms.pm.service.IMedicalRecordsService;
import com.pms.common.utils.poi.ExcelUtil;
import com.pms.common.core.page.TableDataInfo;

/**
 * 罪犯就医记录Controller
 * 
 * @author LiuZhengPing
 * @date 2026-07-28
 */
@RestController
@RequestMapping("/pm/medical")
public class MedicalRecordsController extends BaseController
{
    @Autowired
    private IMedicalRecordsService medicalRecordsService;

    /**
     * 查询罪犯就医记录列表
     */
    @PreAuthorize("@ss.hasPermi('pm:medical:list')")
    @GetMapping("/list")
    public TableDataInfo list(MedicalRecords medicalRecords)
    {
        startPage();
        List<MedicalRecords> list = medicalRecordsService.selectMedicalRecordsList(medicalRecords);
        return getDataTable(list);
    }

    /**
     * 导出罪犯就医记录列表
     */
    @PreAuthorize("@ss.hasPermi('pm:medical:export')")
    @Log(title = "罪犯就医记录", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, MedicalRecords medicalRecords)
    {
        List<MedicalRecords> list = medicalRecordsService.selectMedicalRecordsList(medicalRecords);
        ExcelUtil<MedicalRecords> util = new ExcelUtil<MedicalRecords>(MedicalRecords.class);
        util.exportExcel(response, list, "罪犯就医记录数据");
    }

    /**
     * 获取罪犯就医记录详细信息
     */
    @PreAuthorize("@ss.hasPermi('pm:medical:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(medicalRecordsService.selectMedicalRecordsById(id));
    }

    /**
     * 新增罪犯就医记录
     */
    @PreAuthorize("@ss.hasPermi('pm:medical:add')")
    @Log(title = "罪犯就医记录", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody MedicalRecords medicalRecords)
    {
        return toAjax(medicalRecordsService.insertMedicalRecords(medicalRecords));
    }

    /**
     * 新增罪犯就医记录（含PDF文件上传）
     */
    @PreAuthorize("@ss.hasPermi('pm:medical:add')")
    @Log(title = "罪犯就医记录", businessType = BusinessType.INSERT)
    @PostMapping("/addWithFile")
    public AjaxResult addWithFile(@RequestParam("file") MultipartFile file,
                                  @RequestParam("criminalNo") String criminalNo,
                                  @RequestParam("medicalType") Integer medicalType)
    {
        try
        {
            // 上传文件路径
            String filePath = RuoYiConfig.getUploadPath();
            // 上传并返回新文件名称
            String fileName = FileUploadUtils.upload(filePath, file);
            // 构建就医记录对象并插入数据库
            MedicalRecords medicalRecords = new MedicalRecords();
            medicalRecords.setCriminalNo(criminalNo);
            medicalRecords.setMedicalType(medicalType);
            medicalRecords.setRecordFilePath(fileName);
            medicalRecordsService.insertMedicalRecords(medicalRecords);
            AjaxResult ajax = AjaxResult.success("新增成功");
            ajax.put("fileName", fileName);
            return ajax;
        }
        catch (Exception e)
        {
            return AjaxResult.error(e.getMessage());
        }
    }

    /**
     * 修改罪犯就医记录
     */
    @PreAuthorize("@ss.hasPermi('pm:medical:edit')")
    @Log(title = "罪犯就医记录", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody MedicalRecords medicalRecords)
    {
        return toAjax(medicalRecordsService.updateMedicalRecords(medicalRecords));
    }

    /**
     * 删除罪犯就医记录
     */
    @PreAuthorize("@ss.hasPermi('pm:medical:remove')")
    @Log(title = "罪犯就医记录", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(medicalRecordsService.deleteMedicalRecordsByIds(ids));
    }
}
