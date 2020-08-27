<template>
  <div class="app-container">

    <el-form ref="postForm" :model="postForm" :rules="rules" label-position="left" label-width="120px">

      <el-card>

        <el-form-item label="规则名称" prop="title">
          <el-input v-model="postForm.title" />
        </el-form-item>

        <el-form-item label="客观题分数" prop="objScore">
          <el-input-number v-model="postForm.objScore" :controls="false" :min="0" :max="200" @change="handleScoreChange" />
        </el-form-item>


        <el-form-item label="总分数" prop="totalScore">
          <el-input-number v-model="postForm.totalScore" :controls="false" readonly style="width: 200px" />
        </el-form-item>

        <el-form-item label="及格分" prop="qualifyScore">
          <el-input-number v-model="postForm.qualifyScore" :controls="false" />
        </el-form-item>

        <el-form-item label="考试时长(分钟)" prop="totalTime">
          <el-input-number v-model="postForm.totalTime" :controls="false" />
        </el-form-item>

      </el-card>

      <div class="filter-container" style="margin-top: 15px">

        <el-button class="filter-item" size="small" icon="el-icon-plus" @click="handleAdd">
          添加题库
        </el-button>

      </div>

      <el-table
        :data="postForm.repoList"
        :border="true"
        style="width: 100%;"
      >
        <el-table-column
          label="题库"
          width="200"
        >
          <template slot-scope="scope">
            <repo-select v-model="scope.row.repoId" :multi="false" />
          </template>

        </el-table-column>
        <el-table-column
          label="单选题数量"
          align="center"
        >

          <template slot-scope="scope">
            <el-input-number v-model="scope.row.radioCount" :controls="false" style="width: 100%" />
          </template>

        </el-table-column>

        <el-table-column
          label="单选题分数"
          align="center"
        >
          <template slot-scope="scope">
            <el-input-number v-model="scope.row.radioScore" :controls="false" style="width: 100%" />
          </template>
        </el-table-column>

        <el-table-column
          label="多选题数量"
          align="center"
        >

          <template slot-scope="scope">
            <el-input-number v-model="scope.row.multiCount" :controls="false" style="width: 100%" />
          </template>

        </el-table-column>

        <el-table-column
          label="多选题分数"
          align="center"
        >
          <template slot-scope="scope">
            <el-input-number v-model="scope.row.multiScore" :controls="false" style="width: 100%;"  />
          </template>
        </el-table-column>


        <el-table-column
          label="删除"
          align="center"
          width="80px"
        >
          <template slot-scope="scope">
            <el-button type="danger" icon="el-icon-delete" circle @click="removeItem(scope.$index)" />
          </template>
        </el-table-column>

      </el-table>

      <div style="margin-top: 20px">
        <el-button type="primary" @click="submitForm">保存</el-button>
        <el-button type="info" @click="onCancel">取消</el-button>
      </div>

    </el-form>

  </div>
</template>

<script>
import { fetchDetail, saveData } from '@/api/paper/rule'
import RepoSelect from '@/components/RepoSelect'

export default {
  name: 'RuleDetail',
  components: { RepoSelect },
  data() {
    return {
      postForm: {
        repoList: [
        ],

        totalScore: 0,
        subjScore: 0,
        objScore: 0

      },
      rules: {
        title: [
          { required: true, message: '规则标题不能为空！' }
        ],

        totalScore: [
          { required: true, message: '总分数不能为空' }
        ],
        objScore: [
          { required: true, message: '客观题分数不能为空' }
        ],
        qualifyScore: [
          { required: true, message: '及格分不能为空' }
        ],
        totalTime: [
          { required: true, message: '考试时长不能为空' }
        ]
      }
    }
  },
  created() {
    const id = this.$route.params.id
    if (typeof id !== 'undefined') {
      this.fetchData(id)
    }
  },
  methods: {

    handleScoreChange() {
      this.postForm.totalScore = this.postForm.objScore + this.postForm.subjScore
    },
    // 添加子项
    handleAdd() {
      this.postForm.repoList.push({ isRight: false, content: '', analysis: '' })
    },

    removeItem(index) {
      this.postForm.repoList.splice(index, 1)
    },

    fetchData(id) {
      fetchDetail(id).then(response => {
        this.postForm = response.data
      })
    },
    submitForm() {
      console.log(JSON.stringify(this.postForm))

      this.$refs.postForm.validate((valid) => {
        if (!valid) {
          return
        }

        saveData(this.postForm).then(response => {
          this.postForm = response.data
          this.$notify({
            title: '成功',
            message: '考试规则保存成功！',
            type: 'success',
            duration: 2000
          })

          this.$router.push({ name: 'ListRule' })
        })
      })
    },
    onCancel() {
      this.$router.push({ name: 'ListRule' })
    }

  }
}
</script>

<style scoped>

</style>

