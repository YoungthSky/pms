<template>
  <div class="app-container">
     <el-alert
      v-if="criminalNo"
      type="success"
      :closable="false"
      show-icon
      style="margin-bottom: 12px"
    >
      <template #title>
        <span style="font-weight: bold; font-family: SimHei, '黑体', sans-serif;">当前查看  罪犯姓名：<span style="color: red;">{{ criminalName }}</span>  罪犯编号：<span style="color: red;">{{ criminalNo }}</span> 的就医记录</span>
      </template>
    </el-alert>
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="80px">
      <!-- <el-form-item label="罪犯编号" prop="criminalNo">
        <el-input v-model="queryParams.criminalNo" placeholder="请输入罪犯编号" clearable @keyup.enter="handleQuery" />
      </el-form-item> -->
      <el-form-item label="就医类型" prop="medicalType">
        <el-select v-model="queryParams.medicalType" placeholder="请选择就医类型" clearable>
          <el-option label="狱内就医" :value="1" />
          <el-option label="离监就医" :value="2" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="Plus"
          @click="handleAdd"
          v-hasPermi="['pm:medical:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="Edit"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['pm:medical:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['pm:medical:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="Download"
          @click="handleExport"
          v-hasPermi="['pm:medical:export']"
        >导出</el-button>
      </el-col>
      <!-- <el-col :span="1.5">
        <el-button type="info" plain icon="Back" @click="handleGoBack">返回罪犯列表</el-button>
      </el-col> -->
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

   

    <el-table v-loading="loading" :data="medicalList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <!-- <el-table-column label="罪犯编号" align="center" prop="criminalNo" /> -->
      <el-table-column label="就医类型" align="center" prop="medicalType">
        <template #default="scope">
          <el-tag v-if="scope.row.medicalType === 1" type="success">狱内就医</el-tag>
          <el-tag v-else-if="scope.row.medicalType === 2" type="warning">离监就医</el-tag>
          <el-tag v-else type="info">未知</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="就医记录" align="center" prop="recordFilePath" show-overflow-tooltip >
         <template #default="scope">
          <el-button link type="primary" icon="view" @click="handleMedicalInfo(scope.row)">查看</el-button>
        </template>
      </el-table-column>
      <el-table-column label="录入时间" align="center" prop="createdAt" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.createdAt, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['pm:medical:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['pm:medical:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    
    <pagination
      v-show="total>0"
      :total="total"
      v-model:page="queryParams.pageNum"
      v-model:limit="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改罪犯就医记录对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body @close="handleDialogClose">
      <el-form ref="medicalRef" :model="form" :rules="rules" label-width="100px">
        <el-row>
          <el-col :span="24">
            <el-form-item label="罪犯编号" prop="criminalNo">
              <el-input v-model="form.criminalNo" placeholder="请输入罪犯编号" :disabled="!!criminalNo" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="就医类型" prop="medicalType">
              <el-select v-model="form.medicalType" placeholder="请选择就医类型">
                <el-option label="狱内就医" :value="1" />
                <el-option label="离监就医" :value="2" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="就医记录" prop="recordFilePath" required>
              <div style="width: 100%">
                <el-upload
                  ref="uploadRef"
                  :auto-upload="false"
                  :limit="1"
                  :on-change="handleFileChange"
                  :on-remove="handleFileRemove"
                  :file-list="fileList"
                  accept=".pdf"
                  drag
                >
                  <el-icon class="el-icon--upload"><upload-filled /></el-icon>
                  <div class="el-upload__text">将PDF文件拖到此处，或<em>点击选择文件</em></div>
                  <template #tip>
                    <div class="el-upload__tip">只能上传 PDF 文件，大小不超过 50MB</div>
                  </template>
                </el-upload>
              </div>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" :loading="submitLoading" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 就医视频区域 -->
    <el-divider content-position="left">就医视频</el-divider>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="Plus"
          @click="handleAddVideo"
          v-hasPermi="['pm:video:add']"
        >上传视频</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="Delete"
          :disabled="videoMultiple"
          @click="handleDeleteVideo"
          v-hasPermi="['pm:video:remove']"
        >删除</el-button>
      </el-col>
    </el-row>

    <el-table v-loading="videoLoading" :data="videoList" @selection-change="handleVideoSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="就医视频" align="center" prop="videoFilePath" show-overflow-tooltip>
        <template #default="scope">
          <el-button link type="primary" icon="VideoPlay" @click="handlePlayVideo(scope.row)">播放</el-button>
        </template>
      </el-table-column>
      <el-table-column label="录入时间" align="center" prop="createdAt" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.createdAt, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Delete" @click="handleDeleteVideo(scope.row)" v-hasPermi="['pm:video:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="videoTotal>0"
      :total="videoTotal"
      v-model:page="videoQueryParams.pageNum"
      v-model:limit="videoQueryParams.pageSize"
      @pagination="getVideoList"
    />

    <!-- 上传视频对话框 -->
    <el-dialog title="上传就医视频" v-model="videoOpen" width="500px" append-to-body @close="handleVideoDialogClose">
      <el-form ref="videoFormRef" :model="videoForm" :rules="videoRules" label-width="100px">
        <el-row>
          <el-col :span="24">
            <el-form-item label="罪犯编号" prop="criminalNo">
              <el-input v-model="videoForm.criminalNo" placeholder="请输入罪犯编号" :disabled="!!criminalNo" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="就医视频" prop="videoFilePath" required>
              <div style="width: 100%">
                <el-upload
                  ref="videoUploadRef"
                  :auto-upload="false"
                  :limit="1"
                  :on-change="handleVideoFileChange"
                  :on-remove="handleVideoFileRemove"
                  :file-list="videoFileList"
                  accept=".mp4,.avi,.mov,.wmv,.flv,.mkv"
                  drag
                >
                  <el-icon class="el-icon--upload"><upload-filled /></el-icon>
                  <div class="el-upload__text">将视频文件拖到此处，或<em>点击选择文件</em></div>
                  <template #tip>
                    <div class="el-upload__tip">支持 MP4/AVI/MOV/WMV/FLV/MKV 格式，大小不超过 500MB</div>
                  </template>
                </el-upload>
              </div>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" :loading="videoSubmitLoading" @click="submitVideoForm">确 定</el-button>
          <el-button @click="videoOpen = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 视频播放对话框 -->
    <el-dialog title="播放就医视频" v-model="playOpen" width="700px" append-to-body @close="handlePlayClose" destroy-on-close>
      <video
        v-if="playUrl"
        ref="videoPlayerRef"
        :src="playUrl"
        controls
        autoplay
        style="width: 100%; max-height: 450px; background: #000; border-radius: 4px;"
      ></video>
    </el-dialog>
  </div>
</template>

<script setup lang="ts" name="Medical">
import type { MedicalRecords, MedicalQueryParams } from "@/types/api/pm/medical"
import type { MedicalVideos, VideoQueryParams } from "@/types/api/pm/video"
import { listMedical, getMedical, delMedical, addMedical, updateMedical, addMedicalWithFile } from "@/api/pm/medical"
import { listVideo, delVideo, addVideoWithFile } from "@/api/pm/video"
import { useRoute, useRouter } from "vue-router"
import { UploadFilled } from "@element-plus/icons-vue"
import useTagsViewStore from '@/store/modules/tagsView'

const route = useRoute()
const router = useRouter()
const tagsViewStore = useTagsViewStore()
const { proxy } = getCurrentInstance()

/** 保存本页面固定的路由信息，用于离开时关闭 tab（避免 onDeactivated 中 route 已变为新页面） */
const selfPath = '/pm/medical'
const selfView = { path: selfPath, name: 'Medical' }

/** 从路由参数中获取罪犯编号和罪犯姓名 */
const criminalNo = ref<string>((route.query.criminalNo as string) || '')
const criminalName = ref<string>((route.query.criminalName as string) || '')

const medicalList = ref<MedicalRecords[]>([])
const open = ref<boolean>(false)
const loading = ref<boolean>(true)
const showSearch = ref<boolean>(true)
const ids = ref<number[]>([])
const single = ref<boolean>(true)
const multiple = ref<boolean>(true)
const total = ref<number>(0)
const title = ref<string>("")
const submitLoading = ref<boolean>(false)
const uploadRef = ref()
const fileList = ref<any[]>([])
const selectedFile = ref<File | null>(null)
const baseUrl = import.meta.env.VITE_APP_BASE_API

/** ========== 就医视频相关状态 ========== */
const videoList = ref<MedicalVideos[]>([])
const videoLoading = ref<boolean>(false)
const videoTotal = ref<number>(0)
const videoIds = ref<number[]>([])
const videoMultiple = ref<boolean>(true)
const videoOpen = ref<boolean>(false)
const videoSubmitLoading = ref<boolean>(false)
const videoUploadRef = ref()
const videoFileList = ref<any[]>([])
const selectedVideoFile = ref<File | null>(null)
const playOpen = ref<boolean>(false)
const playUrl = ref<string>('')
const videoPlayerRef = ref()

const videoForm = reactive({
  criminalNo: criminalNo.value || '',
  videoFilePath: ''
})

const videoQueryParams = reactive({
  pageNum: 1,
  pageSize: 10,
  criminalNo: criminalNo.value || undefined,
} as VideoQueryParams)

const videoRules = {
  criminalNo: [
    { required: true, message: "罪犯编号不能为空", trigger: "blur" }
  ]
}

const data = reactive({
  form: {} as MedicalRecords,
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    criminalNo: criminalNo.value || undefined,
    medicalType: undefined,
  } as MedicalQueryParams,
  rules: {
    criminalNo: [
      { required: true, message: "罪犯编号不能为空", trigger: "blur" }
    ],
    medicalType: [
      { required: true, message: "就医类型不能为空", trigger: "change" }
    ],
    recordFilePath: [
      { required: true, message: "就医记录文件不能为空", trigger: "change" }
    ]
  }
})

const { queryParams, form, rules } = toRefs(data)

/** 组件被激活时调用（keep-alive 缓存组件再次进入时触发） */
onActivated(() => {
  const newCriminalNo = (route.query.criminalNo as string) || ''
  const newCriminalName = (route.query.criminalName as string) || ''
  criminalNo.value = newCriminalNo
  criminalName.value = newCriminalName
  queryParams.value.criminalNo = newCriminalNo || undefined
  queryParams.value.pageNum = 1
  getList()
  // 同步刷新视频列表
  videoQueryParams.criminalNo = newCriminalNo || undefined
  videoQueryParams.pageNum = 1
  videoForm.criminalNo = newCriminalNo
  getVideoList()
})

/** 离开页面时自动关闭当前就医记录 tab */
onDeactivated(() => {
  tagsViewStore.delVisitedView(selfView)
  tagsViewStore.delCachedView(selfView)
})

/** 监听路由参数变化，当从基本信息页跳转过来时自动刷新数据 */
watch(() => route.query.criminalNo, (newVal: string | string[]) => {
  const val = (newVal as string) || ''
  if (val !== criminalNo.value) {
    criminalNo.value = val
    criminalName.value = (route.query.criminalName as string) || ''
    queryParams.value.criminalNo = val || undefined
    queryParams.value.pageNum = 1
    getList()
    // 同步刷新视频列表
    videoQueryParams.criminalNo = val || undefined
    videoQueryParams.pageNum = 1
    videoForm.criminalNo = val
    getVideoList()
  }
})

/** 返回罪犯列表 */
function handleGoBack() {
  router.push('/pm/cm')
}

/** 查询罪犯就医记录列表 */
function getList() {
  loading.value = true
  listMedical(queryParams.value).then(response => {
    medicalList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

/** 取消按钮 - 撤销所有操作，不对数据库操作，不上传文件 */
function cancel() {
  open.value = false
  reset()
}

/** 对话框关闭时清理状态 */
function handleDialogClose() {
  fileList.value = []
  selectedFile.value = null
  submitLoading.value = false
}

/** 文件选择变化 */
function handleFileChange(uploadFile: any) {
  const rawFile = uploadFile.raw as File
  if (!rawFile) return
  // 校验文件类型
  if (rawFile.type !== 'application/pdf') {
    proxy.$modal.msgError('只能上传 PDF 格式文件!')
    fileList.value = []
    selectedFile.value = null
    return
  }
  // 校验文件大小
  if (rawFile.size / 1024 / 1024 > 50) {
    proxy.$modal.msgError('文件大小不能超过 50MB!')
    fileList.value = []
    selectedFile.value = null
    return
  }
  selectedFile.value = rawFile
  // 标记表单已选择文件（用于校验）
  form.value.recordFilePath = rawFile.name
}

/** 文件移除 */
function handleFileRemove() {
  selectedFile.value = null
  form.value.recordFilePath = null
}

/** 表单重置 */
function reset() {
  form.value = {
    id: null,
    criminalNo: criminalNo.value || null,
    medicalType: null,
    recordFilePath: null,
    createdAt: null
  }
  fileList.value = []
  selectedFile.value = null
  proxy.resetForm("medicalRef")
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

/** 重置按钮操作 */
function resetQuery() {
  proxy.resetForm("queryRef")
  // 重置后保留罪犯编号筛选
  if (criminalNo.value) {
    queryParams.value.criminalNo = criminalNo.value
  }
  handleQuery()
}

/** 多选框选中数据 */
function handleSelectionChange(selection: MedicalRecords[]) {
  ids.value = selection.map(item => item.id)
  single.value = selection.length != 1
  multiple.value = !selection.length
}

/** 新增按钮操作 */
function handleAdd() {
  reset()
  open.value = true
  title.value = "添加罪犯就医记录"
}

/** 修改按钮操作 */
function handleUpdate(row: MedicalRecords) {
  reset()
  const _id = row.id || ids.value[0]
  getMedical(_id).then(response => {
    form.value = response.data
    open.value = true
    title.value = "修改罪犯就医记录"
  })
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["medicalRef"].validate((valid: boolean) => {
    if (valid) {
      if (form.value.id != null) {
        // 修改操作
        updateMedical(form.value).then(() => {
          proxy.$modal.msgSuccess("修改成功")
          open.value = false
          getList()
        })
      } else {
        // 新增操作 - 校验是否已选择PDF文件
        if (!selectedFile.value) {
          proxy.$modal.msgWarning("请先选择就医记录PDF文件")
          return
        }
        // 构建 FormData，将文件和表单字段一起提交
        const formData = new FormData()
        formData.append('file', selectedFile.value)
        formData.append('criminalNo', form.value.criminalNo)
        formData.append('medicalType', String(form.value.medicalType))
        submitLoading.value = true
        addMedicalWithFile(formData).then((res) => {
          proxy.$modal.msgSuccess("新增成功")
          open.value = false
          getList()
        }).catch(() => {
          proxy.$modal.msgError("新增失败，请重试")
        }).finally(() => {
          submitLoading.value = false
        })
      }
    }
  })
}

/** 删除按钮操作 */
function handleDelete(row: MedicalRecords) {
  const _ids = row.id || ids.value
  proxy.$modal.confirm('是否确认删除罪犯就医记录编号为"' + _ids + '"的数据项？').then(function() {
    return delMedical(_ids)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

/** 查看就医记录PDF */
function handleMedicalInfo(row: MedicalRecords) {
  if (row.recordFilePath) {
    const url = baseUrl + row.recordFilePath
    window.open(url, '_blank')
  } else {
    proxy.$modal.msgWarning("暂无就医记录文件")
  }
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('pm/medical/export', {
    ...queryParams.value
  }, `medical_${new Date().getTime()}.xlsx`)
}

/** ========== 就医视频相关方法 ========== */

/** 查询就医视频列表 */
function getVideoList() {
  videoLoading.value = true
  listVideo(videoQueryParams).then(response => {
    videoList.value = response.rows
    videoTotal.value = response.total
    videoLoading.value = false
  })
}

/** 视频多选框选中数据 */
function handleVideoSelectionChange(selection: MedicalVideos[]) {
  videoIds.value = selection.map(item => item.id)
  videoMultiple.value = !selection.length
}

/** 上传视频按钮操作 */
function handleAddVideo() {
  videoForm.criminalNo = criminalNo.value || ''
  videoForm.videoFilePath = ''
  videoFileList.value = []
  selectedVideoFile.value = null
  videoOpen.value = true
}

/** 视频文件选择变化 */
function handleVideoFileChange(uploadFile: any) {
  const rawFile = uploadFile.raw as File
  if (!rawFile) return
  // 校验文件类型
  const allowedTypes = ['video/mp4', 'video/avi', 'video/quicktime', 'video/x-ms-wmv', 'video/x-flv', 'video/x-matroska']
  const ext = (rawFile.name.split('.').pop() || '').toLowerCase()
  const allowedExts = ['mp4', 'avi', 'mov', 'wmv', 'flv', 'mkv']
  if (!allowedTypes.includes(rawFile.type) && !allowedExts.includes(ext)) {
    proxy.$modal.msgError('只支持 MP4/AVI/MOV/WMV/FLV/MKV 格式视频!')
    videoFileList.value = []
    selectedVideoFile.value = null
    return
  }
  // 校验文件大小 500MB
  if (rawFile.size / 1024 / 1024 > 500) {
    proxy.$modal.msgError('视频文件大小不能超过 500MB!')
    videoFileList.value = []
    selectedVideoFile.value = null
    return
  }
  selectedVideoFile.value = rawFile
  videoForm.videoFilePath = rawFile.name
}

/** 视频文件移除 */
function handleVideoFileRemove() {
  selectedVideoFile.value = null
  videoForm.videoFilePath = ''
}

/** 视频上传对话框关闭时清理 */
function handleVideoDialogClose() {
  videoFileList.value = []
  selectedVideoFile.value = null
  videoSubmitLoading.value = false
}

/** 提交视频上传 */
function submitVideoForm() {
  if (!videoForm.criminalNo) {
    proxy.$modal.msgWarning("罪犯编号不能为空")
    return
  }
  if (!selectedVideoFile.value) {
    proxy.$modal.msgWarning("请先选择视频文件")
    return
  }
  const formData = new FormData()
  formData.append('file', selectedVideoFile.value)
  formData.append('criminalNo', videoForm.criminalNo)
  videoSubmitLoading.value = true
  addVideoWithFile(formData).then(() => {
    proxy.$modal.msgSuccess("上传成功")
    videoOpen.value = false
    getVideoList()
  }).catch(() => {
    proxy.$modal.msgError("上传失败，请重试")
  }).finally(() => {
    videoSubmitLoading.value = false
  })
}

/** 删除视频 */
function handleDeleteVideo(row?: MedicalVideos) {
  const _ids = row?.id || videoIds.value
  proxy.$modal.confirm('是否确认删除选中的就医视频？').then(function() {
    return delVideo(_ids)
  }).then(() => {
    getVideoList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

/** 播放视频 */
function handlePlayVideo(row: MedicalVideos) {
  if (row.videoFilePath) {
    playUrl.value = baseUrl + row.videoFilePath
    playOpen.value = true
  } else {
    proxy.$modal.msgWarning("暂无视频文件")
  }
}

/** 关闭播放对话框 */
function handlePlayClose() {
  playUrl.value = ''
}

getList()
getVideoList()
</script>
