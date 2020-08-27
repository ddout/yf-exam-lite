<template>

  <el-upload
    v-model="fileUrl"
    class="avatar-uploader"
    :show-file-list="false"
    action="http://localhost:8101/common/api/oss/upload"
    :on-success="handleUploaded"
  >
    <img v-if="value" :src="value" :class="type?type:'square'">
    <i v-else :class="'el-icon-plus avatar-uploader-icon '+(type?type:'square')" />
  </el-upload>

</template>

<script>

export default {
  name: 'SingleUpload',
  props: {
    value: String,
    type: String
  },
  data() {
    return {
      fileUrl: ''
    }
  },

  watch: {
    // 检测查询变化
    value: {
      handler() {
        this.fileUrl = this.value
      }
    }
  },

  created() {
    this.fileUrl = this.value
  },

  methods: {

    handleUploaded(response) {
      this.$emit('input', response.data.url)
    }

  }
}
</script>

<style>
  .avatar-uploader .el-upload {
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
  }
  .avatar-uploader .el-upload:hover {
    border-color: #409EFF;
  }

  .square{
    display: block;
    width: 60px;
    height: 60px;
  }

  .rectangle{
    display: block;
    width: 120px;
    height: 60px;
  }

  .avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
    line-height: 60px;
    text-align: center;
  }
</style>
