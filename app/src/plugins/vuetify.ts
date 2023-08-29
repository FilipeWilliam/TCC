import '@mdi/font/css/materialdesignicons.css'
import 'vuetify/styles'
import { VDataTableServer } from 'vuetify/labs/VDataTable';
import { createVuetify } from 'vuetify'
import { pt } from 'vuetify/locale'

export default createVuetify({
  components: {
    VDataTableServer
  },
  locale: {
    locale: 'pt',
    messages: { pt }
  },
  theme: {
    themes: {
      light: {
        colors: {
          primary: '#3D4D63',
          secondary: '#F2D096',
          surface: '#E7E7E7',
          background: '#E7E7E7',
        },
      },
    },
  },
})
