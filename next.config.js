/** @type {import('next').NextConfig} */
const nextConfig = {}

module.exports = nextConfig

const { parsed: env } = require('dotenv').config();

module.exports = {
  env: {
    DB_HOST: env.DB_HOST,
    DB_USER: env.DB_USER,
    DB_PASSWORD: env.DB_PASSWORD,
    DB_DATABASE: env.DB_DATABASE,
  },
};