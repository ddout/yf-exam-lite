import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

/* Layout */
import Layout from '@/layout'

/**
 * Note: sub-menu only appear when route children.length >= 1
 * Detail see: https://panjiachen.github.io/vue-element-admin-site/guide/essentials/router-and-nav.html
 *
 * hidden: true                   if set true, item will not show in the sidebar(default is false)
 * alwaysShow: true               if set true, will always show the root menu
 *                                if not set alwaysShow, when item has more than one children route,
 *                                it will becomes nested mode, otherwise not show the root menu
 * redirect: noRedirect           if set noRedirect will no redirect in the breadcrumb
 * name:'router-name'             the name is used by <keep-alive> (must set!!!)
 * meta : {
    roles: ['admin','editor']    control the page roles (you can set multiple roles)
    title: 'title'               the name show in sidebar and breadcrumb (recommend set)
    icon: 'svg-name'             the icon show in the sidebar
    noCache: true                if set true, the page will no be cached(default is false)
    affix: true                  if set true, the tag will affix in the tags-view
    breadcrumb: false            if set false, the item will hidden in breadcrumb(default is true)
    activeMenu: '/example/list'  if set path, the sidebar will highlight the path you set
  }
 */

/**
 * constantRoutes
 * a base page that does not have permission requirements
 * all roles can be accessed
 */
export const constantRoutes = [
  {
    path: '/redirect',
    component: Layout,
    hidden: true,
    children: [
      {
        path: '/redirect/:path*',
        component: () => import('@/views/redirect/index')
      }
    ]
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import('@/views/login/index'),
    hidden: true
  },
  {
    path: '/register',
    name: 'Register',
    component: () => import('@/views/login/register'),
    hidden: true
  },
  {
    path: '/auth-redirect',
    component: () => import('@/views/login/auth-redirect'),
    hidden: true
  },
  {
    path: '/404',
    component: () => import('@/views/error-page/404'),
    hidden: true
  },
  {
    path: '/401',
    component: () => import('@/views/error-page/401'),
    hidden: true
  },
  {
    path: '/',
    component: Layout,
    redirect: '/dashboard',
    children: [
      {
        path: 'dashboard',
        component: () => import('@/views/dashboard/index'),
        name: 'Dashboard',
        meta: { title: '控制台', icon: 'dashboard', affix: true }
      },

      {
        path: 'qu/view/:id',
        component: () => import('@/views/qu/qu/view'),
        name: 'ViewQu',
        meta: { title: '题目详情', noCache: true, activeMenu: '/manage/qu' },
        hidden: true
      }
    ]
  },

  {
    path: '/profile',
    component: Layout,
    redirect: '/profile/index',
    hidden: true,
    children: [
      {
        path: 'index',
        component: () => import('@/views/profile/index'),
        name: 'Profile',
        meta: { title: '个人资料', icon: 'user', noCache: true }
      }
    ]
  }
]

/**
 * asyncRoutes
 * the routes that need to be dynamically loaded based on user roles
 */
export const asyncRoutes = [

  {
    path: '/exam/start/:id',
    component: () => import('@/views/paper/exam/exam'),
    name: 'StartExam',
    meta: { title: '开始考试' },
    hidden: true
  },

  {
    path: '/online',
    component: Layout,
    redirect: '/online/exam',
    name: 'Online',
    meta: {
      title: '在线考试',
      icon: 'list'
    },
    children: [

      {
        path: 'exam',
        component: () => import('@/views/paper/exam/list'),
        name: 'ListExam',
        meta: { title: '在线考试', noCache: true, icon: 'guide' }
      },

      {
        path: 'exam/prepare/:examId',
        component: () => import('@/views/paper/exam/preview'),
        name: 'PreExam',
        meta: { title: '准备考试', noCache: true, activeMenu: '/online/exam' },
        hidden: true
      },

      {
        path: 'exam/result/:id',
        component: () => import('@/views/paper/exam/result'),
        name: 'ShowExam',
        meta: { title: '考试结果', noCache: true, activeMenu: '/online/exam' },
        hidden: true
      },

      // {
      //   path: 'tran',
      //   component: () => import('@/views/user/book'),
      //   name: 'ListTran',
      //   meta: { title: '错题训练', noCache: true, icon: 'study' }
      // },

      {
        path: 'tran/start',
        component: () => import('@/views/user/book/train'),
        name: 'StartTran',
        meta: { title: '错题训练2', noCache: true, activeMenu: '/online/tran' },
        hidden: true
      },

      {
        path: 'exam/records',
        component: () => import('@/views/paper/paper'),
        name: 'ListMyPaper',
        meta: { title: '考试记录', noCache: true, icon: 'paper' }
      }

    ]
  },
  {
    path: '/manage',
    component: Layout,
    redirect: '/manage/qu',
    name: 'Manage',
    meta: {
      title: '考试管理',
      icon: 'example',
      roles: ['sa', 'teacher']
    },
    children: [

      {
        path: 'repo',
        component: () => import('@/views/qu/repo'),
        name: 'ListRepo',
        meta: { title: '题库管理', noCache: true, icon: 'repo' }
      },

      {
        path: 'repo/add',
        component: () => import('@/views/qu/repo/form'),
        name: 'AddRepo',
        meta: { title: '添加题库', noCache: true, activeMenu: '/manage/repo' },
        hidden: true
      },

      {
        path: 'repo/update/:id',
        component: () => import('@/views/qu/repo/form'),
        name: 'UpdateRepo',
        meta: { title: '题库详情', noCache: true, activeMenu: '/manage/repo' },
        hidden: true
      },

      {
        path: 'qu',
        component: () => import('@/views/qu/qu'),
        name: 'ListQu',
        meta: { title: '试题管理', noCache: true, icon: 'support' }
      },

      {
        path: 'qu/add',
        component: () => import('@/views/qu/qu/form'),
        name: 'AddQu',
        meta: { title: '添加试题', noCache: true, activeMenu: '/manage/qu' },
        hidden: true
      },

      {
        path: 'qu/update/:id',
        component: () => import('@/views/qu/qu/form'),
        name: 'UpdateQu',
        meta: { title: '修改试题', noCache: true, activeMenu: '/manage/qu' },
        hidden: true
      },

      {
        path: 'rule',
        component: () => import('@/views/paper/rule'),
        name: 'ListRule',
        meta: { title: '规则管理', noCache: true, icon: 'topic' }
      },

      {
        path: 'rule/add',
        component: () => import('@/views/paper/rule/form'),
        name: 'AddRule',
        meta: { title: '添加规则', noCache: true, activeMenu: '/manage/rule' },
        hidden: true
      },

      {
        path: 'rule/update/:id',
        component: () => import('@/views/paper/rule/form'),
        name: 'UpdateRule',
        meta: { title: '修改规则', noCache: true, activeMenu: '/manage/rule' },
        hidden: true
      },

      {
        path: 'exam',
        component: () => import('@/views/exam/exam'),
        name: 'ListExam',
        meta: { title: '考试管理', noCache: true, icon: 'log' }
      },

      {
        path: 'review-paper/:examId',
        component: () => import('@/views/paper/paper/review'),
        name: 'ReviewPaper',
        meta: { title: '批阅试卷', noCache: true },
        hidden: true
      },

      {
        path: 'exam/add',
        component: () => import('@/views/exam/exam/form'),
        name: 'AddExam',
        meta: { title: '添加考试', noCache: true, activeMenu: '/manage/exam' },
        hidden: true
      },

      {
        path: 'exam/update/:id',
        component: () => import('@/views/exam/exam/form'),
        name: 'UpdateExam',
        meta: { title: '修改考试', noCache: true, activeMenu: '/manage/exam' },
        hidden: true
      }
    ]
  },

  {
    path: '/sys',
    component: Layout,
    redirect: '/sys/config',
    name: 'Sys',
    meta: {
      title: '系统设置',
      icon: 'configure',
      roles: ['sa']
    },
    children: [

      {
        path: 'role',
        component: () => import('@/views/sys/role'),
        name: 'SysRole',
        meta: { title: '角色管理', icon: 'role' }
      },

      {
        path: 'user',
        component: () => import('@/views/sys/user'),
        name: 'SysUser',
        meta: { title: '用户管理', icon: 'admin' }
      },

      {
        path: 'syslog',
        component: () => import('@/views/sys/log'),
        name: 'SysLog',
        meta: { title: '系统日志', icon: 'log' }
      }

    ]
  },

  // 404 page must be placed at the end !!!
  { path: '*', redirect: '/dashboard', hidden: true }
]

const createRouter = () => new Router({
  // mode: 'history', // require service support
  scrollBehavior: () => ({ y: 0 }),
  routes: constantRoutes
})

const router = createRouter()

// Detail see: https://github.com/vuejs/vue-router/issues/1234#issuecomment-357941465
export function resetRouter() {
  const newRouter = createRouter()
  router.matcher = newRouter.matcher // reset router
}

export default router
