import request from '@/utils/request'
import type { AjaxResult, TableDataInfo, MedicalQueryParams, MedicalRecords } from '@/types'

// 查询罪犯就医记录列表
export function listMedical(query: MedicalQueryParams): Promise<TableDataInfo<MedicalRecords[]>> {
  return request({
    url: '/pm/medical/list',
    method: 'get',
    params: query
  })
}

// 查询罪犯就医记录详细
export function getMedical(id: number): Promise<AjaxResult<MedicalRecords>> {
  return request({
    url: '/pm/medical/' + id,
    method: 'get'
  })
}

// 新增罪犯就医记录
export function addMedical(data: MedicalRecords): Promise<AjaxResult> {
  return request({
    url: '/pm/medical',
    method: 'post',
    data: data
  })
}

// 新增罪犯就医记录（含PDF文件上传）
export function addMedicalWithFile(data: FormData): Promise<AjaxResult> {
  return request({
    url: '/pm/medical/addWithFile',
    method: 'post',
    headers: { 'Content-Type': 'multipart/form-data' },
    data: data
  })
}

// 修改罪犯就医记录
export function updateMedical(data: MedicalRecords): Promise<AjaxResult> {
  return request({
    url: '/pm/medical',
    method: 'put',
    data: data
  })
}

// 删除罪犯就医记录
export function delMedical(id: number | number[]): Promise<AjaxResult> {
  return request({
    url: '/pm/medical/' + id,
    method: 'delete'
  })
}


