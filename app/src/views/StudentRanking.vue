<template>
    <div>
        <v-card>
            <div class="d-flex justify-center">
                <v-card-title class="text-center">Parabéns! Seu aproveitamento está em 94%. <br> Você está entre os 15
                    melhores!</v-card-title>
            </div>
            <canvas ref="chart"></canvas>
        </v-card>

        <v-card>
            <canvas ref="chartdown"></canvas>
        </v-card>
    </div>
</template>
  
<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { Chart } from 'chart.js/auto';

const chart = ref(null);
const chartdown = ref(null);

const mountChart = () => {
    const ctx = chart.value!.getContext('2d');

    const data = {
        labels: ['0%-50%', '50%-60%', '60%-80%', '80%-100%'],
        datasets: [{
            label: 'Quantidade de Alunos',
            data: [2, 3, 1, 15],
            backgroundColor: [
                'rgba(255, 99, 132, 0.7)',
                'rgba(255, 206, 86, 0.7)',
                'rgba(75, 192, 192, 0.7)',
                'rgba(54, 162, 235, 0.7)',
            ],
            borderColor: [
                'rgba(255, 99, 132, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(54, 162, 235, 1)',
            ],
            borderWidth: 1,
        }],
    };

    new Chart(ctx, {
        type: 'bar',
        data: data,
        options: {
            scales: {
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: 'Quantidade de Alunos',
                    },
                },
                x: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: 'Rendimento acadêmico',
                    },
                },
            },
            plugins: {
                legend: {
                    display: false,
                },
                tooltip: {
                    callbacks: {
                        label: (context) => {
                            const datasetLabel = context.dataset.label || '';
                            return `${datasetLabel}: ${context.parsed.y}`;
                        },
                    },
                },
            },
        },
    });
}

const mountChart2 = () => {
    const ctx = chartdown.value.getContext('2d');

    const data = {
        labels: ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro'],
        datasets: [{
            label: 'Aproveitamento (%)',
            data: [60, 65, 70, 75, 80, 82, 85, 88, 90, 92, 94],
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
                        text: 'Aproveitamento (%)',
                    },
                },
            },
        },
    });
}

onMounted(() => {
    mountChart();
    mountChart2();
});
</script>
  
<style></style>
  