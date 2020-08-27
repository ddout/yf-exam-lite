// import parseTime, formatTime and set to filter
export { parseTime, formatTime } from '@/utils'

/**
 * Show plural label if time is plural number
 * @param {number} time
 * @param {string} label
 * @return {string}
 */
function pluralize(time, label) {
  if (time === 1) {
    return time + label
  }
  return time + label + 's'
}

/**
 * @param {number} time
 */
export function timeAgo(time) {
  const between = Date.now() / 1000 - Number(time)
  if (between < 3600) {
    return pluralize(~~(between / 60), ' minute')
  } else if (between < 86400) {
    return pluralize(~~(between / 3600), ' hour')
  } else {
    return pluralize(~~(between / 86400), ' day')
  }
}

/**
 * Number formatting
 * like 10000 => 10k
 * @param {number} num
 * @param {number} digits
 */
export function numberFormatter(num, digits) {
  const si = [
    { value: 1E18, symbol: 'E' },
    { value: 1E15, symbol: 'P' },
    { value: 1E12, symbol: 'T' },
    { value: 1E9, symbol: 'G' },
    { value: 1E6, symbol: 'M' },
    { value: 1E3, symbol: 'k' }
  ]
  for (let i = 0; i < si.length; i++) {
    if (num >= si[i].value) {
      return (num / si[i].value).toFixed(digits).replace(/\.0+$|(\.[0-9]*[1-9])0+$/, '$1') + si[i].symbol
    }
  }
  return num.toString()
}

/**
 * 10000 => "10,000"
 * @param {number} num
 */
export function toThousandFilter(num) {
  return (+num || 0).toString().replace(/^-?\d+/g, m => m.replace(/(?=(?!\b)(\d{3})+$)/g, ','))
}

/**
 * Upper case first char
 * @param {String} string
 */
export function uppercaseFirst(string) {
  return string.charAt(0).toUpperCase() + string.slice(1)
}

/**
 * 通用状态过滤器
 * @param value
 * @returns {*}
 */
export function stateFilter(value) {
  const map = {
    '0': '正常',
    '1': '禁用'
  }
  return map[value]
}

/**
 * 跳转类型
 * @param value
 * @returns {*}
 */
export function jumpTypeFilter(value) {
  const map = {
    '1': '商品',
    '2': '竞拍',
    '3': '专题'
  }
  return map[value]
}

/**
 * 是否类型过滤器
 * @param value
 * @returns {*}
 */
export function booleanFilter(value) {
  const map = {
    'true': '是',
    'false': '否',
    '0': '否',
    '1': '是'
  }
  return map[value]
}

/**
 * 折扣过滤器
 * @param value
 * @returns {*}
 */
export function discountFilter(value) {
  if (value === 1 || value === 0) {
    return '无'
  }
  return value * 10
}

/**
 * 百分比过滤器
 * @param value
 * @returns {*}
 */
export function percentFilter(value) {
  return (value * 100) + '%'
}

/**
 * 专题类型
 * @param value
 * @returns {*}
 */
export function topicTypeFilter(value) {
  const map = {
    '1': '商城专题',
    '2': '竞拍专题'
  }
  return map[value]
}

/**
 * 协议类型
 * @param value
 * @returns {*}
 */
export function supportTypeFilter(value) {
  const map = {
    '0': '通用协议',
    '1': '注册问题',
    '2': '积分问题',
    '3': '发货问题',
    '4': '竞拍问题',
    '5': '名词释义'
  }
  return map[value]
}

/**
 * 消息可见性
 * @param value
 * @returns {*}
 */
export function notifyLevelFilter(value) {
  const map = {
    '0': '全部可见',
    '1': '注册用户',
    '2': '会员'
  }
  return map[value]
}

/**
 * VIP类型
 * @param value
 * @returns {*}
 */
export function vipTypeFilter(value) {
  const map = {
    '1': '周卡',
    '2': '月卡',
    '3': '半年卡',
    '4': '年卡'
  }
  return map[value]
}

/**
 * VIP订单状态
 * @param value
 * @returns {*}
 */
export function vipOrderStateFilter(value) {
  const map = {
    '0': '待下单',
    '1': '待支付',
    '2': '待发货',
    '3': '待评价',
    '4': '已完成'
  }
  return map[value]
}

/**
 * 竞拍参与状态
 * @param value
 * @returns {*}
 */
export function joinStateFilter(value) {
  const map = {
    '1': '出价中',
    '2': '中拍',
    '3': '失败',
    '4': '差价购',
    '5': '失效'
  }
  return map[value]
}


/**
 * 竞拍参与状态
 * @param value
 * @returns {*}
 */
export function quTypeFilter(value) {
  const map = {
    '1': '单选题',
    '2': '多选题',
    '3': '判断题',
    '4': '简答题'
  }
  return map[value]
}


/**
 * 竞拍参与状态
 * @param value
 * @returns {*}
 */
export function examStateFilter(value) {
  const map = {
    '1': '已考试',
    '0': '未考试'
  }
  return map[value]
}

/**
 * 竞拍参与状态
 * @param value
 * @returns {*}
 */
export function examResultFilter(value) {
  const map = {
    '1': '合格',
    '0': '不合格'
  }
  return map[value]
}



/**
 * 竞拍参与状态
 * @param value
 * @returns {*}
 */
export function paperStateFilter(value) {
  const map = {
    '0': '考试中',
    '1': '阅卷中',
    '2': '已考完'
  }
  return map[value]
}
