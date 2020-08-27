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
        prop="title"
        show-overflow-tooltip
      />

      <el-table-column
        label="考试类型"
        align="center"
        width="150px"
      >
        <template slot-scope="scope">
          <span v-if="scope.row.open">公开考试</span>
          <span v-else>内部考试</span>
        </template>

      </el-table-column>

      <el-table-column
        label="考试描述"
        prop="content"
        show-overflow-tooltip
      />

      <el-table-column
        label="创建时间"
        prop="createTime"
        align="center"
        width="180px"
      />

      <el-table-column
        label="操作"
        align="center"
        width="150px"
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
  name: 'OnlineList',
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
        multi: false,
        // 列表请求URL
        listUrl: '/exam/exam/paging'
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
