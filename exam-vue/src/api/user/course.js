import { post } from '@/utils/request'

/**
 * 题库详情
 * @param data
 */
export function fetchDetail(id) {
  return post('/exam/exam/detail',{ id: id })
}

/**
 * 保存题库
 * @param data
 */
export function saveData(data) {
  return post('/exam/exam/save', data)
}
