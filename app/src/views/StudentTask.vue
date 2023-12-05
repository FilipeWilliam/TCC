<template>
    <v-card class="question__card">
        <v-card-title class="question__index">Questão 3</v-card-title>

        <v-card-title class="question__title">Qual evento histórico marcou o início da Revolução Francesa em
            1789?</v-card-title>

        <v-container>
            <v-row>
                <v-col class="question__alternative" v-for="(alternative, index) in questionData.alternatives" :key="index"
                    cols="6">
                    <v-card>
                        <v-card-text class="text-center">{{ alternative.text }}</v-card-text>
                    </v-card>
                </v-col>
            </v-row>
        </v-container>
    </v-card>

    <v-dialog v-model="dialog.open" width="600">
        <v-card>
            <v-card-title class="content__headline">Parabéns!</v-card-title>

            <v-card-text>Você está se saindo muito bem! 🔥😎🔥<br /><br /> Atenção na próxima questão para acertar 3
                perguntas
                seguidas!</v-card-text>

            <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="primary">Próxima questão</v-btn>
            </v-card-actions>
        </v-card>
    </v-dialog>
</template>
  
<script lang="ts" setup>
import { ref } from 'vue';

let dialog = ref({
    open: true
})
let questionData = ref({
    id: 0,
    title: '',
    alternatives: [
        { text: 'A Tomada da Bastilha', },
        { text: 'Proclamação da República', },
        { text: 'Batalha de Waterloo', },
        { text: 'Congresso de Viena', },
    ]
});

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

.question__alternative:nth-child(1) .v-card {
    background-color: red !important;
}

.question__alternative:nth-child(2) .v-card {
    background-color: grey !important;
}

.question__alternative:nth-child(3) .v-card {
    background-color: grey !important;
}

.question__alternative:nth-child(4) .v-card {
    background-color: grey !important;
}
</style>