/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './pages/**/*.{js,ts,jsx,tsx,mdx}',
    './components/**/*.{js,ts,jsx,tsx,mdx}',
    './app/**/*.{js,ts,jsx,tsx,mdx}',
],
theme: {
  extend: {
    backgroundImage: {
      'gradient-radial': 'radial-gradient(var(--tw-gradient-stops))',
      'gradient-conic':
      'conic-gradient(from 180deg at 50% 50%, var(--tw-gradient-stops))',
      'airplane': "url('/public/airplane.jpg')",
    },
    colors: {
      primary: '#6B21A8',
      secondary: '#605DEC',
      tertiary: '#8d8ce6',
    },
    fontFamily: {
      nunito: ["Nunito Sans", 'sans-serif'],
      museo: ["MuseoModerno", "sans-serif"],
      tiltneon: ["Tilt Neon", "sans-serif"]
    },
  },
},
  plugins: [],
}

