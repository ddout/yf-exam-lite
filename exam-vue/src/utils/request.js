import axios from 'axios'
import { MessageBox, Message } from 'element-ui'
import store from '@/store'
import { getToken } from '@/utils/auth'
import querystring from 'querystring'

// 请求实例
const instance = axios.create({
  baseURL: process.env.VUE_APP_BASE_API,
  timeout: 60000
})

/**
 * 封装post请求 FormData方式
 * @param url
 * @param data
 * @returns {Promise}
 */
const formInstance = axios.create({
  baseURL: process.env.VUE_APP_BASE_API,
  headers: { 'content-type': 'multipart/form-data' },
  timeout: 120000
})

// 请求前置过滤器
instance.interceptors.request.use(
  config => {
    if (store.getters.token) {
      config.headers['token'] = getToken()
    }
    return config
  },
  error => {
    console.log(error)
    return Promise.reject(error)
  }
)

// 响应数据拦截并做通用处理
instance.interceptors.response.use(
  response => {
    const res = response.data

    // 0为正确响应码
    if (res.code !== 0) {
      Message({
        message: res.msg || 'Error',
        type: 'error',
        duration: 5 * 1000
      })

      // 登录超时响应码
      if (res.code === 10010002) {
        // to re-login
        MessageBox.confirm('登录超时，请重新登录！', '登录提示', {
          confirmButtonText: '重新登录',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          store.dispatch('user/resetToken').then(() => {
            location.reload()
          })
        })
      }
      return Promise.reject(new Error(res.msg || 'Error'))
    } else {
      return res
    }
  },
  error => {
    console.log('err' + error)
    Message({
      message: error.message,
      type: 'error',
      duration: 5 * 1000
    })
    return Promise.reject(error)
  }
)


/**
 * 下载
 * @param url
 * @param data
 */
export function download(url, data) {
  // 构造完整地址
  const fullUrl = process.env.VUE_APP_BASE_API + url + '?' + querystring.stringify(data)
  // 创建链接并模拟点击
  const a = document.createElement('a')
  a.href = fullUrl
  a.click()
}

/**
 * 封装get方法
 * @param url
 * @param data
 * @returns {Promise}
 */
export function get(url, params = {}) {
  return new Promise((resolve, reject) => {
    instance.get(url, {
      params: params
    }).then(response => {
      resolve(response)
    })
      .catch(err => {
        reject(err)
      })
  })
}

/**
 * 封装post请求
 * @param url
 * @param data
 * @returns {Promise}
 */
export function post(url, data = {}) {
  return new Promise((resolve, reject) => {
    instance.post(url, data)
      .then(response => {
        resolve(response)
      }, err => {
        reject(err)
      })
  })
}

/**
 * 使用表单的方式POST数据
 * @param url
 * @param data
 * @returns {Promise<any>}
 */
export function postForm(url, data = {}) {
  return new Promise((resolve, reject) => {
    formInstance.post(url, data)
      .then(response => {
        resolve(response)
      }, err => {
        reject(err)
      })
  })
}
