<template>
  <div class="dashboard-container" style="text-align: center;">
    <img src="@/assets/haoyun.jpg" style="width: 50%;height: 400px;margin:0 auto;">
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'Dashboard',
  data() {
    return {
      currentRole: 'adminDashboard'
    }
  },
  computed: {
    ...mapGetters([
      'roles'
    ])
  },
  created() {

  }
}
</script>
