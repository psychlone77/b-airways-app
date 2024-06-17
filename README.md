# Airline Reservation System
**Project for CS3043 - Database Systems**

This `README.md` file will detail everything about this project.

### Contents
1. [Startup Guide](https://github.com/psychlone77/b-airways-app#getting-started)
2. [Customer User Interfaces](https://github.com/psychlone77/b-airways-app#customer-user-interfaces)
3. [Admin User Interfaces](https://github.com/psychlone77/b-airways-app#admin-user-interfaces)

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

# Customer User Interfaces
**Using Tailwind CSS**
## Home Page
![image](https://github.com/psychlone77/b-airways-app/assets/127029023/e67b8766-028b-4189-924a-9a67e11f4a77)

## Login Page

![image](https://github.com/psychlone77/b-airways-app/assets/127029023/447c216e-dd68-4411-842f-bce96598b09d)

## Register Page
![image](https://github.com/psychlone77/b-airways-app/assets/127029023/3ce381fd-9b49-4990-8bba-46e1522781af)

## Search Page
### On Load
<img width="1120" alt="Screenshot 2023-11-03 094049" src="https://github.com/psychlone77/b-airways-app/assets/127029023/15a32ad7-7e12-430b-b499-c51dfcfd143e">

### On Search
<img width="1120" alt="Screenshot 2023-11-03 094133" src="https://github.com/psychlone77/b-airways-app/assets/127029023/daa78ceb-9f8f-4359-ac6a-354ce029b0c8">

## Flight Booking
<img width="1120" alt="Screenshot 2023-11-03 094158" src="https://github.com/psychlone77/b-airways-app/assets/127029023/1da8d9e5-ac36-41ab-bfa7-bce5f801d64f">

## Seat Selection
<img width="1120" alt="Screenshot 2023-11-03 094222" src="https://github.com/psychlone77/b-airways-app/assets/127029023/79aee2dd-cabf-46f5-b080-721710b51166">

## Confirm Booking
<img width="1120" alt="Screenshot 2023-11-03 094238" src="https://github.com/psychlone77/b-airways-app/assets/127029023/6df9e813-b864-4e72-88a7-434d501f6143">

# Admin User Interfaces
## Login Page
<img width="1120" alt="Screenshot 2023-11-03 094349" src="https://github.com/psychlone77/b-airways-app/assets/127029023/c74942e5-7990-4bdd-82fb-994257d0d450">

## Admin Dashboard
<img width="1120" alt="Screenshot 2023-11-03 094431" src="https://github.com/psychlone77/b-airways-app/assets/127029023/3bb26551-ba60-4755-8d5f-9d8339166c34">
