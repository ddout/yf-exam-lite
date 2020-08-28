<template>

  <div class="app-container">

    <el-row :gutter="24">

      <el-col :span="24">
        <el-card style="margin-bottom: 10px">

          距结束还有：<span style="color: #ff0000;">{{ min }}分钟{{ sec }}秒</span>
          <el-button style="float: right; margin-top: -10px" type="primary" icon="el-icon-plus" :loading="loading" @click="handHandExam()">
            {{ handleText }}
          </el-button>

        </el-card>
      </el-col>

      <el-col :span="6" :xs="24" style="margin-bottom: 10px">

        <el-card>

          <p class="card-title">答题卡</p>
          <el-row :gutter="24" class="card-line" style="padding-left: 10px">
            <el-tag type="info">未作答</el-tag>
            <el-tag type="success">已作答</el-tag>
          </el-row>

          <div v-if="paperData.radioList!==undefined && paperData.radioList.length > 0">
            <p class="card-title">单选题</p>
            <el-row :gutter="24" class="card-line">
              <el-tag v-for="item in paperData.radioList" :type="cardItemClass(item.answered, item.quId)" @click="handSave(item)"> {{ item.sort+1 }}</el-tag>
            </el-row>
          </div>

          <div v-if="paperData.multiList!==undefined && paperData.multiList.length > 0">
            <p class="card-title">多选题</p>
            <el-row :gutter="24" class="card-line">
              <el-tag v-for="item in paperData.multiList" :type="cardItemClass(item.answered, item.quId)" @click="handSave(item)">{{ item.sort+1 }}</el-tag>
            </el-row>
          </div>

          <div v-if="paperData.judgeList!==undefined && paperData.judgeList.length > 0">
            <p class="card-title">判断题</p>
            <el-row :gutter="24" class="card-line">
              <el-tag v-for="item in paperData.judgeList" :type="cardItemClass(item.answered, item.quId)" @click="handSave(item)">{{ item.sort+1 }}</el-tag>
            </el-row>
          </div>

          <div v-if="paperData.saqList!==undefined && paperData.saqList.length > 0">
            <p class="card-title">简答题</p>
            <el-row :gutter="24" class="card-line">
              <el-tag v-for="item in paperData.saqList" :type="cardItemClass(item.answered, item.quId)" @click="handSave(item)">{{ item.sort+1 }}</el-tag>
            </el-row>
          </div>

        </el-card>

      </el-col>

      <el-col :span="18" :xs="24">

        <el-card class="qu-content">
          <p v-if="quData.content">{{ quData.sort + 1 }}.{{ quData.content }}</p>
          <p v-if="quData.image"><img :src="quData.image"></p>
          <div v-if="quData.quType === 1 || quData.quType===3">
            <el-radio-group v-model="radioValue">
              <el-radio v-for="item in quData.answerList" :label="item.id">{{ item.abc }}.{{ item.content }} <div v-if="item.image" style="clear: both"><img :src="item.image"></div></el-radio>
            </el-radio-group>
          </div>

          <div v-if="quData.quType === 2">

            <el-checkbox-group v-model="multiValue">
              <el-checkbox v-for="item in quData.answerList" :label="item.id">{{ item.abc }}.{{ item.content }} <div v-if="item.image" style="clear: both"><img :src="item.image"></div></el-checkbox>
            </el-checkbox-group>

          </div>

          <div v-if="quData.quType === 4">
            <el-input v-model="saqValue" type="textarea" :rows="10" />
          </div>

        </el-card>

        <div style="margin-top: 20px">
          <el-button v-if="showPrevious" type="primary" icon="el-icon-back" @click="handPrevious()">
            上一题
          </el-button>

          <el-button v-if="showNext" type="warning" icon="el-icon-right" @click="handNext()">
            下一题
          </el-button>

        </div>

      </el-col>


      <el-col :span="24">
        <el-card style="margin-top: 10px; margin-bottom: 10px">

          距结束还有：<span style="color: #ff0000;">{{ min }}分钟{{ sec }}秒</span>
          <el-button  v-if="!showNext" style="float: right; margin-top: -10px" type="primary" icon="el-icon-plus" :loading="loading" @click="handHandExam()">
            {{ handleText }}
          </el-button>

        </el-card>
      </el-col>

    </el-row>

  </div>

</template>

<script>
import { paperDetail, quDetail, handExam, fillAnswer } from '@/api/paper/exam'
import { Loading } from 'element-ui'

export default {
  name: 'ExamProcess',

  data() {
    return {
      // 全屏/不全屏
      isFullscreen: false,
      camVisible: true,
      showPrevious: false,
      showNext: true,
      loading: false,
      handleText: '交卷',
      pageLoading: false,
      // 试卷ID
      paperId: '',
      // 当前答题卡
      cardItem: {},
      allItem: [],
      // 当前题目内容
      quData: {
        answerList: []
      },
      // 试卷信息
      paperData: {
        leftSeconds: 99999,
        radioList: [],
        multiList: [],
        judgeList: [],
        saqList: []
      },
      // 单选选定值
      radioValue: '',
      // 简答题值
      saqValue: '',
      // 多选选定值
      multiValue: [],
      // 已答ID
      answeredIds: [],
      min: '00',
      sec: '00'
    }
  },
  created() {
    const id = this.$route.params.id
    if (typeof id !== 'undefined') {
      this.paperId = id
      this.fetchData(id)
    }
  },

  methods: {

    // 倒计时
    countdown() {
      const leftSeconds = this.paperData.leftSeconds

      // 强制交卷
      if (leftSeconds < 0) {
        this.doHandler()
        return
      }

      // 时
      const min = parseInt(leftSeconds / 60 % 60)
      const sec = parseInt(leftSeconds % 60)

      this.min = min > 9 ? min : '0' + min
      this.sec = sec > 9 ? sec : '0' + sec
      const that = this
      this.paperData.leftSeconds -= 1
      setTimeout(function() {
        that.countdown()
      }, 1000)
    },

    // 答题卡样式
    cardItemClass(answered, quId) {
      if (quId === this.cardItem.quId) {
        return 'warning'
      }

      if (answered) {
        return 'success'
      }

      if (!answered) {
        return 'info'
      }
    },

    /**
     * 统计有多少题没答的
     * @returns {number}
     */
    countNotAnswered() {
      let notAnswered = 0

      this.paperData.radioList.forEach(function(item) {
        if (!item.answered) {
          notAnswered += 1
        }
      })

      this.paperData.multiList.forEach(function(item) {
        if (!item.answered) {
          notAnswered += 1
        }
      })

      this.paperData.judgeList.forEach(function(item) {
        if (!item.answered) {
          notAnswered += 1
        }
      })

      this.paperData.saqList.forEach(function(item) {
        if (!item.answered) {
          notAnswered += 1
        }
      })

      return notAnswered
    },

    /**
     * 下一题
     */
    handNext() {
      const index = this.cardItem.sort + 1
      this.handSave(this.allItem[index])
    },

    /**
     * 上一题
     */
    handPrevious() {
      const index = this.cardItem.sort - 1
      this.handSave(this.allItem[index])
    },

    doHandler() {
      this.handleText = '正在交卷，请等待...'
      this.loading = true

      const params = { id: this.paperId }
      handExam(params).then(() => {
        this.$message({
          message: '试卷提交成功，即将进入试卷详情！',
          type: 'success'
        })

        this.$router.push({ name: 'ShowExam', params: { id: this.paperId }})
      })
    },

    // 交卷操作
    handHandExam() {
      const that = this

      // 交卷保存答案
      this.handSave(this.cardItem, function() {
        const notAnswered = that.countNotAnswered()

        let msg = '确认要交卷吗？'

        if (notAnswered > 0) {
          msg = '您还有' + notAnswered + '题未作答，确认要交卷吗?'
        }

        that.$confirm(msg, '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          that.doHandler()
        }).catch(() => {
          that.$message({
            type: 'info',
            message: '交卷已取消，您可以继续作答！'
          })
        })
      })
    },

    // 保存答案
    handSave(item, callback) {
      if (item.id === this.allItem[0].id) {
        this.showPrevious = false
      } else {
        this.showPrevious = true
      }

      // 最后一个索引
      const last = this.allItem.length - 1

      if (item.id === this.allItem[last].id) {
        this.showNext = false
      } else {
        this.showNext = true
      }

      const answers = this.multiValue
      if (this.radioValue !== '') {
        answers.push(this.radioValue)
      }

      const params = { paperId: this.paperId, quId: this.cardItem.quId, answers: answers, answer: this.saqValue }
      fillAnswer(params).then(() => {
        // 必须选择一个值
        if (answers.length > 0) {
          // 加入已答列表
          this.cardItem.answered = true
        }

        // 最后一个动作，交卷
        if (callback) {
          callback()
        }

        // 查找详情
        this.fetchQuData(item)
      })
    },

    // 试卷详情
    fetchQuData(item) {
      // 打开
      const loading = Loading.service({
        text: '拼命加载中',
        background: 'rgba(0, 0, 0, 0.7)'
      })

      // 获得详情
      this.cardItem = item

      // 查找下个详情
      const params = { paperId: this.paperId, quId: item.quId }
      quDetail(params).then(response => {
        console.log(response)
        this.quData = response.data
        this.radioValue = ''
        this.multiValue = []

        // 填充该题目的答案
        this.quData.answerList.forEach((item) => {
          if ((this.quData.quType === 1 || this.quData.quType === 3) && item.checked) {
            this.radioValue = item.id
          }

          if (this.quData.quType === 2 && item.checked) {
            this.multiValue.push(item.id)
          }
        })

        // 填充主观答案
        this.saqValue = this.quData.answer

        // 关闭详情
        loading.close()
      })
    },

    // 试卷详情
    fetchData(id) {
      const params = { id: id }
      paperDetail(params).then(response => {
        // 试卷内容
        this.paperData = response.data

        // 获得第一题内容
        if (this.paperData.radioList) {
          this.cardItem = this.paperData.radioList[0]
        } else if (this.paperData.multiList) {
          this.cardItem = this.paperData.multiList[0]
        } else if (this.paperData.judgeList) {
          this.cardItem = this.paperData.judgeList[0]
        } else {
          this.cardItem = this.paperData.saqList[0]
        }

        const that = this

        this.paperData.radioList.forEach(function(item) {
          that.allItem.push(item)
        })

        this.paperData.multiList.forEach(function(item) {
          that.allItem.push(item)
        })

        this.paperData.judgeList.forEach(function(item) {
          that.allItem.push(item)
        })

        this.paperData.saqList.forEach(function(item) {
          that.allItem.push(item)
        })

        // 当前选定
        this.fetchQuData(this.cardItem)

        // 倒计时
        this.countdown()
      })
    }

  }
}
</script>

<style scoped>

  .web-cam{
    position: absolute;
    right: 5px;
    bottom: 10px;
  }

  .qu-content{

  }

  .qu-content div{
    line-height: 30px;
  }

  .el-checkbox-group label,.el-radio-group label{
    width: 100%;
  }

  .card-title{
    background: #eee;
    line-height: 35px;
    text-align: center;
    font-size: 14px;
  }
  .card-line{
    padding-left: 10px
  }
  .card-line span {
    cursor: pointer;
    margin: 2px;
  }

  /deep/
  .el-radio, .el-checkbox{
    padding: 9px 20px 9px 10px;
    border-radius: 4px;
    border: 1px solid #dcdfe6;
    margin-bottom: 10px;
  }

  .is-checked{
    border: #409eff 1px solid;
  }

  .el-radio img, .el-checkbox img{
    max-width: 200px;
    max-height: 200px;
    border: #dcdfe6 1px dotted;
  }

  /deep/
  .el-checkbox__inner {
    display: none;
  }

  /deep/
  .el-radio__inner{
    display: none;
  }

  /deep/
  .el-checkbox__label{
    line-height: 30px;
  }

  /deep/
  .el-radio__label{
    line-height: 30px;
  }

</style>

