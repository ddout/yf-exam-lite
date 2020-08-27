<template>
  <div class="app-container">

    <el-form ref="postForm" :model="postForm" :rules="rules" label-position="top">

      <el-card>

        <el-form-item label="预热时长/分钟" prop="prepare">
          <el-input-number v-model="postForm.prepare" :min="0" :max="999999" placeholder="预热时长/分钟" />
        </el-form-item>

        <el-form-item label="休市开始时间" prop="restStart">
          <el-time-select
            v-model="postForm.restStart"
            :picker-options="{
              start: '00:00',
              step: '00:30',
              end: '23:59'
            }"
            placeholder="休市开始时间"
          />

        </el-form-item>

        <el-form-item label="休市结束时间" prop="restEnd">

          <el-time-select
            v-model="postForm.restEnd"
            :picker-options="{
              start: '00:00',
              step: '00:30',
              end: '23:59'
            }"
            placeholder="休市结束时间"
          />

        </el-form-item>

        <el-row>
          <el-button type="primary" @click="submitForm">保存</el-button>
        </el-row>

      </el-card>

    </el-form>

  </div>
</template>

<script>
import { fetchDetail, saveData } from '@/api/sys/config/config'

export default {
  name: 'Config',
  data() {
    return {
      postForm: {
        id: '0'
      },
      loading: false,
      rules: {
        prepare: [
          { required: true, message: '预热时长不能为空！' }
        ],
        restStart: [
          { required: true, message: '预热时长不能为空！' }
        ],
        restEnd: [
          { required: true, message: '预热时长不能为空！' }
        ]
      }
    }
  },
  created() {
    this.fetchData()
  },
  methods: {

    fetchData() {
      fetchDetail().then(response => {
        this.postForm = response.data
      })
    },
    submitForm() {
      console.log(JSON.stringify(this.postForm))

      this.$refs.postForm.validate((valid) => {
        if (!valid) {
          return
        }

        this.loading = true
        this.postForm.id = '0'

        saveData(this.postForm).then(() => {
          this.$notify({
            title: '成功',
            message: '配置保存成功！',
            type: 'success',
            duration: 2000
          })
        })
        this.loading = false
      })
    }
  }
}
</script>

<style scoped>

</style>
