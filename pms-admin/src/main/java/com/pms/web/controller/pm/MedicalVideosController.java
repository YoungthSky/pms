package com.pms.web.controller.pm;

import java.util.List;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
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
import com.pms.pm.domain.MedicalVideos;
import com.pms.pm.service.IMedicalVideosService;
import com.pms.common.core.page.TableDataInfo;

/**
 * 罪犯就医视频Controller
 * 
 * @author LiuZhengPing
 * @date 2026-08-01
 */
@RestController
@RequestMapping("/pm/video")
public class MedicalVideosController extends BaseController
{
    @Autowired
    private IMedicalVideosService medicalVideosService;

    /**
     * 查询罪犯就医视频列表
     */
    @PreAuthorize("@ss.hasPermi('pm:video:list')")
    @GetMapping("/list")
    public TableDataInfo list(MedicalVideos medicalVideos)
    {
        startPage();
        List<MedicalVideos> list = medicalVideosService.selectMedicalVideosList(medicalVideos);
        return getDataTable(list);
    }

    /**
     * 获取罪犯就医视频详细信息
     */
    @PreAuthorize("@ss.hasPermi('pm:video:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(medicalVideosService.selectMedicalVideosById(id));
    }

    /**
     * 新增罪犯就医视频（含视频文件上传）
     */
    @PreAuthorize("@ss.hasPermi('pm:video:add')")
    @Log(title = "罪犯就医视频", businessType = BusinessType.INSERT)
    @PostMapping("/addWithFile")
    public AjaxResult addWithFile(@RequestParam("file") MultipartFile file,
                                  @RequestParam("criminalNo") String criminalNo)
    {
        try
        {
            // 上传文件路径
            String filePath = RuoYiConfig.getUploadPath();
            // 上传并返回新文件名称
            String fileName = FileUploadUtils.upload(filePath, file);
            // 构建就医视频对象并插入数据库
            MedicalVideos medicalVideos = new MedicalVideos();
            medicalVideos.setCriminalNo(criminalNo);
            medicalVideos.setVideoFilePath(fileName);
            medicalVideosService.insertMedicalVideos(medicalVideos);
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
     * 删除罪犯就医视频
     */
    @PreAuthorize("@ss.hasPermi('pm:video:remove')")
    @Log(title = "罪犯就医视频", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(medicalVideosService.deleteMedicalVideosByIds(ids));
    }
}
