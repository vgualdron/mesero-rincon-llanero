<template>
  <AppHeaderDropdown right no-caret>
    <template slot="header">
      <h5 style="line-height: 2.2;display: inline;">{{ username }}</h5>
      <img
        src="static/img/avatar-profile.jpg"
        class="img-avatar"
        alt="Vgualdron" />
    </template>\
    <template slot="dropdown">
      <b-dropdown-header tag="div" class="text-center"><strong>Cuenta</strong></b-dropdown-header>
      <b-dropdown-item @click="cerrarSesion()"><i class="fa fa-lock" /> Cerrar Pestaña</b-dropdown-item>
    </template>
  </AppHeaderDropdown>
</template>

<script>
import { HeaderDropdown as AppHeaderDropdown } from '@coreui/vue'
export default {
  name: 'DefaultHeaderDropdownAccnt',
  components: {
    AppHeaderDropdown
  },
  methods: {
    cerrarSesion: function () {
      localStorage.removeItem('token')
      location.href = '/'
      // window.close()
    }
  },
  computed: {
    username () {
      return localStorage.getItem('username')
    }
  },
  data: () => {
    return { itemsCount: 42 }
  }
}
</script>