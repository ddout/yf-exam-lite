import { post } from '@/utils/request'

// 获得用户协议详情，固定ID为0
export function fetchDetail() {
  return post('/sys/config/detail', { id: '0' })
}

export function saveData(data) {
  return post('/sys/config/save', data)
}
