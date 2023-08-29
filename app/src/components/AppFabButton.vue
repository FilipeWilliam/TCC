<template>
  <v-btn class="v-btn--fixed v-btn--bottom v-btn--right" size="large" icon color="primary">
    <v-icon>mdi-plus</v-icon>
  </v-btn>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
  setup() {

  }
})
</script>

<style>
.v-btn--fixed {
  position: fixed !important;
}

.v-btn--fixed.v-btn--bottom {
  bottom: 16px !important;
}

.v-btn--fixed.v-btn--right {
  right: 16px !important;
}
</style>