import Vue from 'vue';
import App from './App.vue';
import router from './router';
import store from './store';  
import '@/utils/componentImport'
import './registerServiceWorker';
import vuetify from './utils/vuetify';

Vue.config.productionTip = false;

new Vue({
  router,
  store,
  vuetify,
  render: h => h(App)
}).$mount('#app');
