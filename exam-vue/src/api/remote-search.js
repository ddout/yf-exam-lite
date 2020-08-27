import { get } from '@/utils/request'

export function searchUser(name) {
  return get('/search/user', { params: name })
}

export function transactionList(query) {
  return get('/transaction/list', { params: query })
}
