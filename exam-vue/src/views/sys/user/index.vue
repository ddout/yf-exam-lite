<template>

  <div>

    <data-table
      ref="pagingTable"
      :options="options"
      :list-query="listQuery"
      @multi-actions="handleMultiAction"
    >

      <template slot="filter-content">

        <el-button class="filter-item" type="primary" icon="el-icon-plus" @click="handleAdd">
          添加
        </el-button>

      </template>

      <template slot="data-columns">

        <el-table-column
          type="selection"
          width="55"
        />

        <el-table-column
          align="center"
          label="用户名"
          prop="userName"
        />

        <el-table-column
          align="center"
          label="姓名"
          prop="realName"
        />

        <el-table-column
          align="center"
          label="角色"
          prop="roleIds"
        />

        <el-table-column
          align="center"
          label="创建时间"
          prop="createTime"
        />

        <el-table-column
          align="center"
          label="状态"
        >

          <template slot-scope="scope">
            {{ scope.row.state | stateFilter }}
          </template>
        </el-table-column>

        <el-table-column
          align="center"
          label="操作"
        >

          <template slot-scope="scope">
            <el-button size="small" icon="el-icon-edit" @click="handleUpdate(scope.row)">修改</el-button>
          </template>
        </el-table-column>

      </template>
    </data-table>

    <el-dialog title="添加用户" :visible.sync="dialogVisible" width="500px">

      <el-form :model="formData" label-position="left" label-width="100px">

        <el-form-item label="用户名">
          <el-input v-model="formData.userName" />
        </el-form-item>

        <el-form-item label="姓名">
          <el-input v-model="formData.realName" />
        </el-form-item>

        <el-form-item label="密码">
          <el-input v-model="formData.password" placeholder="不修改请留空" type="password" />
        </el-form-item>

        <el-form-item label="角色">
          <meet-role v-model="formData.roles" />
        </el-form-item>

        <el-form-item label="头像" prop="avatar">
          <el-upload
            class="avatar-uploader"
            :show-file-list="false"
            action="/api/v1/common/oss/upload"
            :on-success="handleUploadSuccess"
          >
            <img v-if="formData.avatar" :src="formData.avatar" class="avatar">
            <i v-else class="el-icon-plus avatar-uploader-icon" />
          </el-upload>
        </el-form-item>

      </el-form>

      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="handleSave">确 定</el-button>
      </div>

    </el-dialog>

  </div>

</template>

<script>
import DataTable from '@/components/DataTable'
import MeetRole from '@/components/MeetRole'
import { saveData } from '@/api/sys/user/user'

export default {
  name: 'SysUserList',
  components: { DataTable, MeetRole },
  filters: {

    // 订单状态
    userState(value) {
      const map = {
        '0': '正常',
        '1': '禁用'
      }
      return map[value]
    }
  },
  data() {
    return {


      dialogVisible: false,

      listQuery: {
        current: 1,
        size: 10,
        params: {
        }
      },

      formData: {
        avatar: ''
      },

      options: {
        // 列表请求URL
        listUrl: '/sys/user/paging',
        // 启用禁用
        stateUrl: '/sys/user/state',

        // 批量操作列表
        multiActions: [
          {
            value: 'enable',
            label: '启用'
          }, {
            value: 'disable',
            label: '禁用'
          }
        ]
      }
    }
  },

  methods: {

    handleUploadSuccess(response) {
      // 上传图片赋值
      this.formData.avatar = response.data.url
    },


    handleAdd() {
      this.formData = {};
      this.dialogVisible = true
    },

    handleUpdate(row) {
      this.dialogVisible = true
      this.formData = row
      this.formData.roles = row.roleIds.split(',')
      this.formData.password = null

      console.log(JSON.stringify(this.formData))
    },

    handleSave() {
      saveData(this.formData).then(() => {
        this.$message({
          type: 'success',
          message: '用户修改成功!'
        })
        this.dialogVisible = false
        this.$refs.pagingTable.getList()
      })
    },

    // 批量操作监听
    handleMultiAction(obj) {
      if (obj.opt === 'cancel') {
        this.handleCancelOrder(obj.ids)
      }
    }
  }
}
</script>
