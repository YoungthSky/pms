import request from '@/utils/request'
import type { AjaxResult, TableDataInfo } from '@/types'
import type { VideoQueryParams, MedicalVideos } from '@/types/api/pm/video'

// 查询罪犯就医视频列表
export function listVideo(query: VideoQueryParams): Promise<TableDataInfo<MedicalVideos[]>> {
  return request({
    url: '/pm/video/list',
    method: 'get',
    params: query
  })
}

// 查询罪犯就医视频详细
export function getVideo(id: number): Promise<AjaxResult<MedicalVideos>> {
  return request({
    url: '/pm/video/' + id,
    method: 'get'
  })
}

// 新增罪犯就医视频（含视频文件上传）
export function addVideoWithFile(data: FormData): Promise<AjaxResult> {
  return request({
    url: '/pm/video/addWithFile',
    method: 'post',
    headers: { 'Content-Type': 'multipart/form-data' },
    data: data
  })
}

// 删除罪犯就医视频
export function delVideo(id: number | number[]): Promise<AjaxResult> {
  return request({
    url: '/pm/video/' + id,
    method: 'delete'
  })
}
