import { post } from '@/utils/request'

/**
 * 题库详情
 * @param data
 */
export function nextQu(id) {
  return post('/user/wrong-book/next',  { id: id })
}

