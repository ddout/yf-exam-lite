import { post } from '@/utils/request'

export function updateData(data) {
  return post('/sys/user/update', data)
}

export function saveData(data) {
  return post('/sys/user/save', data)
}

export function userReg(data) {
  return post('/sys/user/reg', data)
}
