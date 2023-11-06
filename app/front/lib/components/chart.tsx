"use client"

import React from 'react';
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  TimeScale,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend,
} from 'chart.js';
import { Line } from 'react-chartjs-2';
import 'chartjs-adapter-moment';
import { elo_ratings, poiss_ratings } from '@prisma/client';

ChartJS.register(
  CategoryScale,
  TimeScale,
  LinearScale,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend
);

export const ArtemisRatingChart = ({rating_data}: {rating_data: poiss_ratings[]}) => {

  const data = {
    labels: rating_data.map(d => d.date*1000),
    datasets: [
      {
        label: 'Off rating',
        data: rating_data.map(d => d.off_rating),
        backgroundColor: 'blue',
      },
      {
        label: 'Def rating',
        data: rating_data.map(d => d.def_rating),
        backgroundColor: 'red',
      },
    ],
  };

  const options: any = {
    plugins: {
      title: {
        display: true,
        text: 'Artemis Rating last two years',
      },
    },
    scales: {
      x: {
        type: 'time',
        time: {
            unit: 'month'
        },
        adapters: { 
          date: {
            locale: "enEN",
          },
        }, 
      }
    },
  };

  return (
    <div style={{maxWidth: '800px', marginBottom: '2rem'}}>
      <Line options={options} data={data} />
    </div>
  )
}

export const AresRatingChart = ({rating_data}: {rating_data: elo_ratings[]}) => {
  const data = {
    labels: rating_data.map(d => d.date*1000),
    datasets: [
      {
        label: 'Rating',
        data: rating_data.map(d => d.rating),
        backgroundColor: 'blue',
      },
    ],
  };

  const options: any = {
    plugins: {
      title: {
        display: true,
        text: 'Ares Rating last two years',
      },
    },
    scales: {
      x: {
        type: 'time',
        time: {
          unit: 'month',
        },
        adapters: { 
          date: {
            locale: "enEN",
          },
        }, 
      }
    },
  };

  return (
    <div style={{maxWidth: '800px', marginBottom: '2rem'}}>
      <Line options={options} data={data} />
    </div>
  )
}
