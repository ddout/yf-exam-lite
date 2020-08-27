<template>
  <div class="app-container">

    <el-row :gutter="24">

      <el-col :span="24" style="margin-bottom: 20px">

        <el-card class="pre-exam">

          <div><strong>考试名称：</strong>{{ postForm.title }}</div>
          <div><strong>考试时长：</strong>{{ postForm.totalTime }}分钟</div>
          <div v-if="postForm.subjScore > 0"><strong>客观分数：</strong>{{ postForm.objScore }}分</div>
          <div v-if="postForm.subjScore > 0"><strong>主观总分：</strong>{{ postForm.subjScore }}分</div>
          <div><strong>试卷总分：</strong>{{ postForm.totalScore }}分</div>
          <div><strong>及格分数：</strong>{{ postForm.qualifyScore }}分</div>
          <div><strong>考试描述：</strong>{{ postForm.content }}</div>

        </el-card>

      </el-col>

      <el-col :span="24">

        <el-button type="primary" icon="el-icon-caret-right" :loading="loading" @click="handleCreate">
          {{ loadingText }}
        </el-button>

        <el-button @click="handleBack">
          返回
        </el-button>

      </el-col>

    </el-row>

  </div>
</template>

<script>
import { fetchDetail } from '@/api/exam/exam'
import { createPaper } from '@/api/paper/exam'

export default {
  name: 'PreExam',
  data() {
    return {
      examId: '',
      loading: false,
      loadingText: '开始考试',
      postForm: {}
    }
  },

  created() {
    this.examId = this.$route.params.examId
    this.fetchData(this.examId)
  },

  methods: {

    showLoading() {
      this.loading = true
      this.loadingText = '创建试卷中'
    },

    closeLoading() {
      this.loading = false
      this.loadingText = '开始考试'
    },

    fetchData(id) {
      fetchDetail(id).then(response => {
        this.postForm = response.data
      })
    },

    handleCreate() {
      const params = { examId: this.examId }
      const ctx = this

      this.showLoading()

      createPaper(params).then(response => {
        console.log(response)

        if (response.code === 0) {
          ctx.$message({
            message: '试卷创建成功，即将进入考试！',
            type: 'success'
          })

          setTimeout(function() {
            ctx.$router.push({ name: 'StartExam', params: { id: response.data.id }})
          }, 2000)
        } else {
          ctx.$message.error(response.data.msg)
          this.closeLoading()
        }
      })
    },

    handleBack() {
      window.location.href = document.referrer
    }

  }
}
</script>

<style scoped>

  .pre-exam div {

    line-height: 42px;
    color: #555555;
  }

</style>

