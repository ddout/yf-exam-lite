import { post } from '@/utils/request'

/**
 * 题库详情
 * @param data
 */
export function fetchDetail(data) {
  return post('/qu/repo/detail', data)
}

/**
 * 保存题库
 * @param data
 */
export function saveData(data) {
  return post('/qu/repo/save', data)
}

/**
 * 保存题库
 * @param data
 */
export function fetchList(data) {
  return post('/qu/repo/list', data)
}

/**
 * 题库批量操作
 * @param data
 */
export function batchAction(data) {
  return post('/qu/repo/batch-action', data)
}
