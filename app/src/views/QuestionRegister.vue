<template>
  <v-card>
    <v-card-title class="content__headline d-flex align-text-center">
      <span class="d-flex align-text-center">Cadastrar questão</span>
      <v-spacer></v-spacer>
      <v-btn icon="mdi-message-text" size="small" @click="openIADialog"></v-btn>
    </v-card-title>

    <v-container fluid>
      <v-row>
        <v-col cols="12">
          <v-text-field v-model="question.title" label="Título" hide-details variant="outlined"></v-text-field>
        </v-col>

        <v-col v-for="(alternative, index) in question.alternatives" cols="3">
          <v-text-field v-model="alternative.text" :label="'Alternativa' + (index + 1)" variant="outlined"
            hide-details></v-text-field>
        </v-col>

      </v-row>
    </v-container>

    <v-card-actions>
      <v-spacer></v-spacer>
      <v-btn color="primary">Salvar</v-btn>
    </v-card-actions>
  </v-card>

  <v-dialog v-model="dialog.open" width="500" @click.outside="closeDialog">
    <v-card>
      <v-card-title class="content__headline">Gerar questão</v-card-title>

      <v-container>
        <v-row>
          <v-col cols="12">
            <v-text-field v-model="questionGeneration" label="Tema" hide-details variant="outlined"></v-text-field>
          </v-col>
        </v-row>
      </v-container>

      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="primary" :loading="dialog.loading" @click="searchQuestion">Gerar</v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script setup lang="ts">
import api from '@/plugins/api';
import { useAppStore } from '@/store/app';
import { catchErrorDefault, cloneDeep } from '@/utils';
import { ref } from 'vue';

let appStore = useAppStore();
let dialog = ref({ open: false, loading: false });
let question = ref({
  title: '',
  alternatives: [
    { text: '' },
    { text: '' },
    { text: '' },
    { text: '' },
  ]
});

let questionGeneration = ref('')
let openIADialog = () => {
  dialog.value.open = true;
}

let searchQuestion = () => {
  dialog.value.loading = true;

  api.get('/questions')
    .then((response) => {
      let allQuestions = cloneDeep(response.data);
      let correctQuestion = allQuestions.find((q: any) => q.title.includes(questionGeneration.value));

      setTimeout(() => {
        if (correctQuestion === undefined) {
          appStore.setSnackbar('Nenhuma questão encontrada com esse tema.');
          closeDialog();
        } else {
          question.value.alternatives = cloneDeep(correctQuestion.alternatives);
          question.value.title = correctQuestion.title;
          closeDialog();
        }
      }, 1000);

    })
    .catch(catchErrorDefault);

  let closeDialog = () => {
    questionGeneration.value = '';
    dialog.value.open = false;
    dialog.value.loading = false;
  }
}

</script>

<style></style>