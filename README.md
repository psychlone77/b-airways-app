# Airline Reservation System
**Project for CS3043 - Database Systems**

This `README.md` file will detail everything about this project.

### Contents
1. [Startup Guide](https://github.com/psychlone77/b-airways-app#getting-started)

This is a [Next.js](https://nextjs.org/) project bootstrapped with [`create-next-app`](https://github.com/vercel/next.js/tree/canary/packages/create-next-app).

## Getting Started
### Prerequisites
- Nodejs
- MySQL Server (version 5.0 onwards)

### Step 1
First, clone this repository onto your onto your local machine.

### Step 2
Run the SQL scripts from the `/SQL_files` folder on your MySQL server. Run the files in this order

1. `DDL.sql`
2. `functions 1.sql`
3. `functions 2.sql`
4. `views.sql`
5. `reports.sql`
6. Optionally you can run the insert statement files or include your own.

### Step 3
Create a `.env` file at the root of your project folder using the template given below. Fill these variables to connect to your SQL database.

```
DB_HOST='host'
DB_USER='your SQL username'
DB_PASSWORD='password'
DB_DATABASE='schema name - default is ars'
```

### Step 4
Run `npm install` to install all the dependencies for this project.

### Step 5
Run the development server using the appropriate command and go to the appropriate localhost to view the web site (Default - https://localhost:3000).
```bash
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```
