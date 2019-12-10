import Vue from 'vue';
import VueRouter from 'vue-router';
import Home from '../views/Home.vue';
import { HomeLayout, AuthLayout } from '@/layouts'
import Signin from '@/views/auth/signin'
import Signup from '@/views/auth/signup'

Vue.use(VueRouter);

const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeLayout,
    children: [
      {
        path: '/',
        name: 'home',
        component: Home,
      },
      {
        path: '/about',
        name: 'about',
        // route level code-splitting
        // this generates a separate chunk (about.[hash].js) for this route
        // which is lazy-loaded when the route is visited.
        component: () => import(/* webpackChunkName: "about" */ '../views/About.vue'),
      },
    ]
  },
  {
    path: '/sessions',
    component: AuthLayout,
    children: [
      {
        path: 'signin',
        name: 'Signin',
        component: Signin
      },
      {
        path: 'signup',
        name: 'Signup',
        component: Signup
      }
    ]
  }

];

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes,
});

export default router;
