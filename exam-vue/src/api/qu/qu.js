import { post, get, postForm, download } from '@/utils/request'

/**
 * 题库详情
 * @param data
 */
export function fetchDetail(id) {
  return post('/qu/qu/detail', { id: id })
}

/**
 * 保存题库
 * @param data
 */
export function saveData(data) {
  return post('/qu/qu/save', data)
}

/**
 * 导出
 * @param data
 */
export function exportExcel(data) {
  return download('/qu/qu/export', data)
}

/**
 * 导入模板
 * @param data
 */
export function importTemplate() {
  return download('/qu/qu/import/template')
}

/**
 * 导出
 * @param data
 */
export function importExcel(data) {
  return postForm('/qu/qu/import', data)
}

