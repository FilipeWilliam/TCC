<template>
    <v-card>
        <v-card-title class="content__headline">Desempenho dos estudantes</v-card-title>

        <div>
            <canvas ref="chart"></canvas>
        </div>
        <v-card-title class="text-center">Desempenho médio dos estudantes: {{ average }}%</v-card-title>
    </v-card>
</template>
  
<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { Chart } from 'chart.js/auto';

const chart = ref(null);
const chartdown = ref(null);
const average = ref(0);

const mountChart = () => {
    const ctx = chart.value!.getContext('2d');

    const studentCount = 10;
    const studentNames = Array.from({ length: studentCount }, (_, i) => `Estudante ${i + 1}`);
    const randomPercentages = Array.from({ length: studentCount }, () => Math.floor(Math.random() * 100) + 1);
    const mediaDesempenho = randomPercentages.reduce((soma, porcentagem) => soma + porcentagem, 0) / randomPercentages.length;
    average.value = mediaDesempenho.toFixed(2);

    const data = {
        labels: studentNames,
        datasets: [{
            label: 'Rendimento (%)',
            data: randomPercentages,
            backgroundColor: 'rgba(75, 192, 192, 0.7)',
            borderColor: 'rgba(75, 192, 192, 1)',
            borderWidth: 1,
        }],
    };

    new Chart(ctx, {
        type: 'bar',
        data: data,
        options: {
            scales: {
                y: {
                    beginAtZero: false,
                    max: 100,
                    title: {
                        display: true,
                        text: 'Rendimento (%)',
                    },
                },
            },
        },
    });
}

onMounted(() => {
    mountChart();
});
</script>
  
<style></style>
  