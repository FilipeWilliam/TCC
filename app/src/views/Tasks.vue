<template>
  <v-card>
    <v-card-title class="content__headline">Tarefas</v-card-title>

    <AppDataTable :headers="(headers as any)" :items="taskStore.allTasks" :get-data="listTasks">
      <template #item.periodStart="{ item }">
        {{ formattedDate(item.raw.periodStart + ' 00:00:00') }}
      </template>

      <template #item.periodEnd="{ item }">
        {{ formattedDate(item.raw.periodEnd + ' 23:59:59') }}
      </template>
    </AppDataTable>

  </v-card>
</template>

<script lang="ts" setup>
import AppDataTable from '@/components/AppDataTable.vue';
import { useTaskStore } from '@/store/task';
import { formattedDate } from '@/utils';

let taskStore = useTaskStore();

const headers = [
  {
    title: 'Disciplina',
    align: 'left',
    key: 'subject',
    sortable: false,
  },
  {
    title: 'Data de início',
    align: 'left',
    key: 'periodStart',
    sortable: false,
  },
  {
    title: 'Data de término',
    align: 'left',
    key: 'periodEnd',
    sortable: false,
  },
]

const listTasks = () => {
  return new Promise((resolve, reject) => {
    taskStore.list({})
      .then(resolve)
      .catch(reject);
  })

}

</script>

<style></style>