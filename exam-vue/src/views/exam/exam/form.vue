<template>
  <div class="app-container">

    <el-form ref="postForm" :model="postForm" :rules="rules" label-position="left" label-width="120px">

      <el-card>

        <el-form-item label="考试名称" prop="title">
          <el-input v-model="postForm.title" />
        </el-form-item>

        <el-form-item label="考试描述" prop="content">
          <el-input v-model="postForm.content" type="textarea" />
        </el-form-item>

        <el-form-item label="考试权限" prop="open">
          <el-switch
            v-model="postForm.open"
            style="display: block"
            active-color="#13ce66"
            inactive-color="#ff4949"
            active-text="公开考试"
            inactive-text="内部考试"
          />
        </el-form-item>


        <el-form-item v-if="!postForm.open" label="考试口令" prop="password" >
          <el-input v-model="postForm.password" placeholder="只有输入正确的口令才可以考试"/>
        </el-form-item>



        <el-form-item label="考试规则" prop="ruleId">
          <rule-select v-model="postForm.ruleId" />
        </el-form-item>

      </el-card>

      <div style="margin-top: 20px">
        <el-button type="primary" @click="submitForm">保存</el-button>
        <el-button type="info" @click="onCancel">返回</el-button>
      </div>

    </el-form>

  </div>
</template>

<script>
import { fetchDetail, saveData } from '@/api/exam/exam'
import RuleSelect from '@/components/RuleSelect'

export default {
  name: 'ExamDetail',
  components: { RuleSelect },
  data() {
    return {

      postForm: {
        repoList: [
        ],
        open: true
      },
      rules: {
        title: [
          { required: true, message: '考试名称不能为空！' }
        ],

        open: [
          { required: true, message: '考试权限不能为空！' }
        ],

        content: [
          { required: true, message: '课程描述不能为空' }
        ],
        ruleId: [
          { required: true, message: '考试规则不能为空' }
        ],
        password: [
          { required: true, message: '考试口令不能为空！' }
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

    fetchData(id) {
      fetchDetail(id).then(response => {
        this.postForm = response.data
      })
    },
    submitForm() {

      this.$refs.postForm.validate((valid) => {
        if (!valid) {
          return
        }

        saveData(this.postForm).then(() => {
          this.$notify({
            title: '成功',
            message: '考试保存成功！',
            type: 'success',
            duration: 2000
          })

          this.$router.push({ name: 'ListExam' })
        })
      })
    },
    onCancel() {
      this.$router.push({ name: 'ListExam' })
    }

  }
}
</script>

<style scoped>

</style>

