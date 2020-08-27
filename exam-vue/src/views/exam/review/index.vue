<template>

  <data-table
    ref="pagingTable"
    :options="options"
    :list-query="listQuery"
  >
    <template slot="filter-content">

      <el-input v-model="listQuery.params.title" placeholder="搜索考试名称" style="width: 200px;" class="filter-item" />

    </template>

    <template slot="data-columns">

      <el-table-column
        label="考试名称"
      >
        <template slot-scope="scope">
          <router-link :to="{name: 'UpdateExam', params: {id: scope.row.id}}">
            {{ scope.row.title }}
          </router-link>
        </template>

      </el-table-column>


      <el-table-column
        label="考试类型"
      >
        <template slot-scope="scope">
          <span v-if="scope.row.open">公开考试</span>
          <span v-else>内部考试</span>
        </template>

      </el-table-column>

      <el-table-column
        label="考试描述"
        prop="content"
      />

      <el-table-column
        label="创建时间"
        prop="createTime"
      />

      <el-table-column
        label="操作"
        align="center"
        prop="createTime"
      >
        <template slot-scope="scope">
          <el-button type="warning" round size="small" @click="handlePre(scope.row.id)">开始考试</el-button>
        </template>

      </el-table-column>

    </template>

  </data-table>

</template>

<script>
import DataTable from '@/components/DataTable'

export default {
  name: 'ExamList',
  components: { DataTable },
  data() {
    return {

      listQuery: {
        current: 1,
        size: 10,
        params: {
          name: ''
        }
      },

      options: {
        // 可批量操作
        multi: true,
        // 批量操作列表
        multiActions: [
          {
            value: 'delete',
            label: '删除'
          }, {
            value: 'enable',
            label: '启用'
          },
          {
            value: 'disable',
            label: '禁用'
          }
        ],
        // 列表请求URL
        listUrl: '/exam/exam/paging',
        // 删除请求URL
        deleteUrl: '/exam/exam/delete',
        addRoute: 'AddExam'
      }
    }
  },
  methods: {

    // 开始考试
    handlePre(examId) {
      this.$router.push({ name: 'PreExam', params: { examId: examId }})
    }
  }
}
</script>
