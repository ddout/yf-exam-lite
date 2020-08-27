import { post } from '@/utils/request'

export function getRoutes() {
  return post('/routes', {})
}

export function getRoles() {
  return post('/roles', {})
}

export function addRole(data) {
  return post('/role', data)
}

export function updateRole(id, data) {
  return post(`/role/${id}`, data)
}

export function deleteRole(id) {
  return post(`/role/${id}`, {})
}
