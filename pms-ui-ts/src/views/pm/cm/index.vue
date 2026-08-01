<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="罪犯编号" prop="criminalNo">
        <el-input v-model="queryParams.criminalNo" placeholder="请输入罪犯编号" clearable @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="罪犯姓名" prop="criminalName">
        <el-input v-model="queryParams.criminalName" placeholder="请输入罪犯姓名" clearable @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="Plus" @click="handleAdd"
          v-hasPermi="['system:archive:add']">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain icon="Edit" :disabled="single" @click="handleUpdate"
          v-hasPermi="['system:archive:edit']">修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete"
          v-hasPermi="['system:archive:remove']">删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="warning" plain icon="Download" @click="handleExport"
          v-hasPermi="['system:archive:export']">导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="archiveList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <!-- <el-table-column label="自增主键" align="center" prop="id" /> -->
      <el-table-column label="罪犯姓名" align="center" prop="criminalName" />
      <el-table-column label="罪犯编号" align="center" prop="criminalNo" />

      <el-table-column label="基本信息" align="center" prop="basicInfoPath" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="View" @click="handleViewBasicInfo(scope.row)"
            :disabled="!scope.row.basicInfoPath">查看</el-button>
          <el-button link type="primary" icon="Plus" @click="handleUploadBasicInfo(scope.row)"
            v-hasPermi="['system:archive:edit']">新增</el-button>
        </template>
      </el-table-column>

      <el-table-column label="就医信息" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="view" @click="handleMedicalInfo(scope.row)">查看</el-button>
          <el-button link type="primary" icon="Plus" @click="handleMedicalInfo(scope.row)"
            v-hasPermi="['system:archive:add']">新增</el-button>
        </template>
      </el-table-column>
      <el-table-column label="管控信息" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="view" @click="handleMedicalInfo(scope.row)">查看</el-button>
          <el-button link type="primary" icon="Plus" @click="handleMedicalInfo(scope.row)"
            v-hasPermi="['system:archive:add']">新增</el-button>
        </template>
      </el-table-column>
      <el-table-column label="减假暂信息" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="view" @click="handleMedicalInfo(scope.row)">查看</el-button>
          <el-button link type="primary" icon="Plus" @click="handleMedicalInfo(scope.row)"
            v-hasPermi="['system:archive:add']">新增</el-button>
        </template>
      </el-table-column>
      <el-table-column label="教育改造信息" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="view" @click="handleMedicalInfo(scope.row)">查看</el-button>
          <el-button link type="primary" icon="Plus" @click="handleMedicalInfo(scope.row)"
            v-hasPermi="['system:archive:add']">新增</el-button>
        </template>
      </el-table-column>
      <el-table-column label="亲情电话信息" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="view" @click="handleMedicalInfo(scope.row)">查看</el-button>
          <el-button link type="primary" icon="Plus" @click="handleMedicalInfo(scope.row)"
            v-hasPermi="['system:archive:add']">新增</el-button>
        </template>
      </el-table-column>
       <el-table-column label="亲情会见信息" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="view" @click="handleMedicalInfo(scope.row)">查看</el-button>
          <el-button link type="primary" icon="Plus" @click="handleMedicalInfo(scope.row)"
            v-hasPermi="['system:archive:add']">新增</el-button>
        </template>
      </el-table-column>


      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)"
            v-hasPermi="['system:archive:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)"
            v-hasPermi="['system:archive:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum"
      v-model:limit="queryParams.pageSize" @pagination="getList" />

    <!-- 上传基本信息PDF对话框 -->
    <el-dialog title="上传基本信息" v-model="uploadOpen" width="450px" append-to-body>
      <el-upload
        ref="uploadRef"
        :action="uploadUrl"
        :headers="uploadHeaders"
        :data="uploadData"
        :limit="1"
        :auto-upload="false"
        :on-success="handleUploadSuccess"
        :on-error="handleUploadError"
        :before-upload="handleBeforeUpload"
        accept=".pdf"
        drag
      >
        <el-icon class="el-icon--upload"><upload-filled /></el-icon>
        <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
        <template #tip>
          <div class="el-upload__tip">只能上传 PDF 文件，大小不超过 50MB</div>
        </template>
      </el-upload>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitUpload">确认上传</el-button>
          <el-button @click="uploadOpen = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 添加或修改罪犯基础档案对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="archiveRef" :model="form" :rules="rules" label-width="100px">
        <el-row>
          <el-col :span="24">
            <el-form-item label="罪犯编号" prop="criminalNo">
              <el-input v-model="form.criminalNo" placeholder="请输入罪犯编号(唯一业务标识)" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="罪犯姓名" prop="criminalName">
              <el-input v-model="form.criminalName" placeholder="请输入罪犯姓名" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="基本信息文件" prop="basicInfoPath">
              <image-upload v-model="form.basicInfoPath" />
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts" name="Archive">
import type { CriminalsArchive, ArchiveQueryParams } from "@/types/api/pm/cm/archive"
import { listArchive, getArchive, delArchive, addArchive, updateArchive } from "@/api/pm/cm/archive"
import { useRouter } from "vue-router"
import { getToken } from "@/utils/auth"
import { UploadFilled } from "@element-plus/icons-vue"

const router = useRouter()


const { proxy } = getCurrentInstance()

const archiveList = ref<CriminalsArchive[]>([])
const open = ref<boolean>(false)
const uploadOpen = ref<boolean>(false)
const loading = ref<boolean>(true)
const showSearch = ref<boolean>(true)
const ids = ref<number[]>([])
const single = ref<boolean>(true)
const multiple = ref<boolean>(true)
const total = ref<number>(0)
const title = ref<string>("")
const baseUrl = import.meta.env.VITE_APP_BASE_API
const uploadUrl = ref(import.meta.env.VITE_APP_BASE_API + '/system/archive/uploadBasicInfo')
const uploadHeaders = ref({ Authorization: "Bearer " + getToken() })
const uploadData = ref<{ id: string }>({ id: '' })

const data = reactive({
  form: {} as CriminalsArchive,
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    criminalNo: undefined,
    criminalName: undefined,
    basicInfoPath: undefined,
  } as ArchiveQueryParams,
  rules: {
    uuid: [
      { required: true, message: "全局唯一标识符(UUID)不能为空", trigger: "blur" }
    ],
    criminalNo: [
      { required: true, message: "罪犯编号(唯一业务标识)不能为空", trigger: "blur" }
    ],
    criminalName: [
      { required: true, message: "罪犯姓名不能为空", trigger: "blur" }
    ],
    createdAt: [
      { required: true, message: "创建时间不能为空", trigger: "blur" }
    ],
    updatedAt: [
      { required: true, message: "更新时间不能为空", trigger: "blur" }
    ],
  }
})

const { queryParams, form, rules } = toRefs(data)

/** 就医信息按钮操作 */
function handleMedicalInfo(row: CriminalsArchive) {
  router.push({
    path: '/pm/medical',
    query: {
      criminalNo: row.criminalNo,
      criminalName: row.criminalName
    }
  })
}

/** 查看基本信息PDF */
function handleViewBasicInfo(row: CriminalsArchive) {
  if (row.basicInfoPath) {
    const url = baseUrl + row.basicInfoPath
    window.open(url, '_blank')
  } else {
    proxy.$modal.msgWarning("暂无基本信息文件")
  }
}

/** 新增基本信息 - 打开上传对话框 */
function handleUploadBasicInfo(row: CriminalsArchive) {
  uploadData.value = { id: row.id }
  uploadOpen.value = true
}

/** 上传前校验 */
function handleBeforeUpload(file: File): boolean {
  const isPdf = file.type === 'application/pdf'
  if (!isPdf) {
    proxy.$modal.msgError('只能上传 PDF 格式文件!')
    return false
  }
  const isLt50M = file.size / 1024 / 1024 < 50
  if (!isLt50M) {
    proxy.$modal.msgError('文件大小不能超过 50MB!')
    return false
  }
  return true
}

/** 确认上传 */
function submitUpload() {
  proxy.$refs["uploadRef"].submit()
}

/** 上传成功 */
function handleUploadSuccess(res: any) {
  if (res.code === 200) {
    proxy.$modal.msgSuccess("上传成功")
    uploadOpen.value = false
    getList()
  } else {
    proxy.$modal.msgError(res.msg)
  }
}

/** 上传失败 */
function handleUploadError() {
  proxy.$modal.msgError("上传失败")
}

/** 查询罪犯基础档案列表 */
function getList() {
  loading.value = true
  listArchive(queryParams.value).then(response => {
    archiveList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

/** 取消按钮 */
function cancel() {
  open.value = false
  reset()
}

/** 表单重置 */
function reset() {
  form.value = {
    id: null,
    uuid: null,
    criminalNo: null,
    criminalName: null,
    basicInfoPath: null,
    createdAt: null,
    updatedAt: null,
    createdBy: null
  }
  proxy.resetForm("archiveRef")
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

/** 重置按钮操作 */
function resetQuery() {
  proxy.resetForm("queryRef")
  handleQuery()
}

/** 多选框选中数据 */
function handleSelectionChange(selection: CriminalsArchive[]) {
  ids.value = selection.map(item => item.id)
  single.value = selection.length != 1
  multiple.value = !selection.length
}

/** 新增按钮操作 */
function handleAdd() {
  reset()
  open.value = true
  title.value = "添加罪犯基础档案"
}

/** 修改按钮操作 */
function handleUpdate(row: CriminalsArchive) {
  reset()
  const _id = row.id || ids.value[0]
  getArchive(_id).then(response => {
    form.value = response.data
    open.value = true
    title.value = "修改罪犯基础档案"
  })
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["archiveRef"].validate((valid: boolean) => {
    if (valid) {
      if (form.value.id != null) {
        updateArchive(form.value).then(() => {
          proxy.$modal.msgSuccess("修改成功")
          open.value = false
          getList()
        })
      } else {
        addArchive(form.value).then(() => {
          proxy.$modal.msgSuccess("新增成功")
          open.value = false
          getList()
        })
      }
    }
  })
}

/** 删除按钮操作 */
function handleDelete(row: CriminalsArchive) {
  const _ids = row.id || ids.value
  proxy.$modal.confirm('是否确认删除罪犯基础档案编号为"' + _ids + '"的数据项？').then(function () {
    return delArchive(_ids)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => { })
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('system/archive/export', {
    ...queryParams.value
  }, `archive_${new Date().getTime()}.xlsx`)
}

getList()
</script>
