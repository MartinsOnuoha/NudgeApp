<template>
    <div id="app">
        <homeNav />
        <router-view></router-view>
    </div>
</template>
<script>
    import homeNav  from '@/components/nav.vue'
export default {
    components: {
        homeNav
    }
}
</script>
<style  scoped>
#app{
    margin: 0%;
    overflow: hidden;
}
</style>