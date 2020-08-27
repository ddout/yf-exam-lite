import { post } from '@/utils/request'

export function login(data) {
  return post('/sys/user/login', data)
}

export function getInfo(token) {
  return post('/sys/user/info?token=' + token)
}

export function logout() {
  return post('/sys/user/logout', {})
}

export function reg(data) {
  return post('/sys/user/reg', data)
}
