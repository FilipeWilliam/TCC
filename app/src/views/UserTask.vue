<template>
  <v-card class="question__card">
    <v-card-title class="question__index">Questão {{ currentQuestion }}</v-card-title>

    <template v-if="loading">
      <div class="d-flex justify-center align-center">
        <v-progress-circular indeterminate></v-progress-circular>
      </div>
    </template>

    <template v-else>
      <v-card-title class="question__title">{{ questionData.title }}</v-card-title>

      <v-container>
        <v-row>
          <v-col class="question__alternative" :class="{ 'question__alternative--wrong': alternative.isWrong }"
            v-for="(alternative, index) in questionData.alternatives" :key="index" cols="6">
            <v-card @click="chooseAlternative(alternative)">
              <v-card-text class="text-center">{{ alternative.text }}</v-card-text>
            </v-card>
          </v-col>
        </v-row>
      </v-container>
    </template>
  </v-card>
</template>

<script lang="ts" setup>
import axios from 'axios';
import { ref } from 'vue';

let currentQuestion = ref(1);
let loading = ref(true);
let userData = ref({
  id: 1,
  name: '',
  points: 0
})
let questionData = ref({
  id: 0,
  title: '',
  alternatives: []
});
let startQuestionTime: Date;

let getQuestion = () => {
  loading.value = true;

  setTimeout(() => {
    axios.get('http://localhost:3000/questions/' + currentQuestion.value)
      .then((response: any) => {
        questionData.value.alternatives = response.data.alternatives;
        questionData.value.title = response.data.title;
        questionData.value.id = response.data.id;
        startQuestionTime = new Date();
      })
      .catch(console.log)
      .finally(() => loading.value = false);
  }, 500);
}

let chooseAlternative = (currentAlternative: any) => {
  let endQuestionTime: Date = new Date();

  if (currentAlternative.isCorrect) {
    axios.put('http://localhost:3000/users/' + userData.value.id, {
      points: userData.value.points + 100,
      name: userData.value.name
    })
      .then(() => userData.value.points += 100)
      .catch(console.log);
  }

  axios.post('http://localhost:3000/userQuestions', {
    currentQuestion: questionData.value.id,
    alternative: currentAlternative.id,
    user: 1,
    timeElapsed: (endQuestionTime - startQuestionTime)
  })
    .then(() => {
      checkAnswer();
      setTimeout(() => {
        currentQuestion.value++;
        getQuestion();
      }, 2000);
    })
    .catch(console.log)
}

let checkAnswer = () => {
  questionData.value.alternatives.forEach((alternative) => {
    if (!alternative.isCorrect) {
      alternative.isWrong = true;
    }
  })
}

getQuestion();
</script>


<style>
.user__data {
  position: absolute;
  top: 20px;
  right: 20px;
}

.question__card {
  height: 450px;
  display: flex !important;
  flex-direction: column;
  justify-content: space-between;
}

.question__card .question__index {
  text-align: center;
  background: rgb(var(--v-theme-primary));
  color: #FFF;
  text-shadow: 0 0 3px #000;
}

.question__title {
  text-overflow: initial !important;
  white-space: normal !important;
  height: 200px;
  display: flex !important;
  justify-content: center;
  align-items: center;
  text-align: center;
}

.question__alternative .v-card {
  color: #FFF;
}

.question__alternative--wrong .v-card {
  background-color: grey !important;
}

.question__alternative:nth-child(1) .v-card {
  background-color: red;
}

.question__alternative:nth-child(2) .v-card {
  background-color: green;
}

.question__alternative:nth-child(3) .v-card {
  background-color: blue;
}

.question__alternative:nth-child(4) .v-card {
  background-color: purple;
}
</style>