<template>

  <data-table
    ref="pagingTable"
    :options="options"
    :list-query="listQuery"
  >
    <template slot="filter-content">

      <el-input v-model="listQuery.params.title" placeholder="搜索规则名称" style="width: 200px;" class="filter-item" />

    </template>

    <template slot="data-columns">

      <el-table-column
        label="规则名称"
        align="center"
        prop="title"
      >

        <template slot-scope="scope">
          <router-link :to="{ name: 'UpdateRule', params: {id : scope.row.id}}">
            {{ scope.row.title }}
          </router-link>

        </template>

      </el-table-column>

      <el-table-column
        label="总分"
        align="center"
        prop="totalScore"
      />

      <el-table-column
        label="考试时长(分钟)"
        align="center"
        prop="totalTime"
      />

      <el-table-column
        label="及格分数"
        align="center"
        prop="qualifyScore"
      />

    </template>

  </data-table>

</template>

<script>
import DataTable from '@/components/DataTable'

export default {
  name: 'QuList',
  components: { DataTable },
  data() {
    return {

      listQuery: {
        current: 1,
        size: 10,
        params: {
          title: ''
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
          }
        ],
        // 列表请求URL
        listUrl: '/paper/rule/paging',
        // 删除请求URL
        deleteUrl: '/paper/rule/delete',
        // 添加数据路由
        addRoute: 'AddRule'
      }
    }
  },
  methods: {

  }
}
</script>
