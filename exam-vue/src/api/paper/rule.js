import { post } from '@/utils/request'

/**
 * 题库详情
 * @param data
 */
export function fetchDetail(id) {
  return post('/paper/rule/detail', { id: id })
}

/**
 * 保存题库
 * @param data
 */
export function saveData(data) {
  return post('/paper/rule/save', data)
}

/**
 * 保存题库
 * @param data
 */
export function fetchList() {
  return post('/paper/rule/list', {})
}
