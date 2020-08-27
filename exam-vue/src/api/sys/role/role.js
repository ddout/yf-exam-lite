import { post } from '@/utils/request'

export function fetchList() {
  return post('/sys/role/list', {})
}

