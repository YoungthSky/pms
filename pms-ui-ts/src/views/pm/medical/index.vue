<template>
  <div class="app-container">
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
      <el-table-column label="就医记录" align="center" prop="recordFilePath" show-overflow-tooltip />
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
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="medicalRef" :model="form" :rules="rules" label-width="100px">
        <el-row>
          <el-col :span="24">
            <el-form-item label="罪犯编号" prop="criminalNo">
              <el-input v-model="form.criminalNo" placeholder="请输入罪犯编号" />
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
            <el-form-item label="就医记录" prop="recordFilePath">
              <el-button link type="primary" icon="Plus" @click="handleMedicalInfo(scope.row)"
            v-hasPermi="['system:archive:add']">上传PDF</el-button>
              <!-- <el-input v-model="form.recordFilePath" placeholder="请输入就医记录文件" /> -->
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

<script setup lang="ts" name="Medical">
import type { MedicalRecords, MedicalQueryParams } from "@/types/api/pm/medical"
import { listMedical, getMedical, delMedical, addMedical, updateMedical } from "@/api/pm/medical"
import { useRoute, useRouter } from "vue-router"

const route = useRoute()
const router = useRouter()
const { proxy } = getCurrentInstance()

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
      { required: true, message: "就医记录文件不能为空", trigger: "blur" }
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

/** 取消按钮 */
function cancel() {
  open.value = false
  reset()
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
        updateMedical(form.value).then(() => {
          proxy.$modal.msgSuccess("修改成功")
          open.value = false
          getList()
        })
      } else {
        addMedical(form.value).then(() => {
          proxy.$modal.msgSuccess("新增成功")
          open.value = false
          getList()
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

/** 导出按钮操作 */
function handleExport() {
  proxy.download('pm/medical/export', {
    ...queryParams.value
  }, `medical_${new Date().getTime()}.xlsx`)
}

getList()
</script>
