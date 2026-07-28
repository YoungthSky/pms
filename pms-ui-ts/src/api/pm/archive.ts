import request from '@/utils/request'
import type { AjaxResult, TableDataInfo, ArchiveQueryParams, CriminalsArchive } from '@/types'

// 查询罪犯基础档案列表
export function listArchive(query: ArchiveQueryParams): Promise<TableDataInfo<CriminalsArchive[]>> {
  return request({
    url: '/system/archive/list',
    method: 'get',
    params: query
  })
}

// 查询罪犯基础档案详细
export function getArchive(id: number): Promise<AjaxResult<CriminalsArchive>> {
  return request({
    url: '/system/archive/' + id,
    method: 'get'
  })
}

// 新增罪犯基础档案
export function addArchive(data: CriminalsArchive): Promise<AjaxResult> {
  return request({
    url: '/system/archive',
    method: 'post',
    data: data
  })
}

// 修改罪犯基础档案
export function updateArchive(data: CriminalsArchive): Promise<AjaxResult> {
  return request({
    url: '/system/archive',
    method: 'put',
    data: data
  })
}

// 删除罪犯基础档案
export function delArchive(id: number | number[]): Promise<AjaxResult> {
  return request({
    url: '/system/archive/' + id,
    method: 'delete'
  })
}


