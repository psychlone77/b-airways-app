import connection from '../../database/db';

export async function GET(){
    // try {
    const query = "SELECT * from organizational_info";
    const values = [];

    //     const [rows, fields] = await connection.execute(query, value);

    //     // Do something with the rows (results)
    //     console.log(rows);

    //     // Don't close the connection here, you might want to reuse it for subsequent queries

    //     return Response.json({ data: rows });

    // } catch (error) {
    //     return Response.json({error: error.message})
    // }
    // const [rows] = await connection.execute(query, values);
    // console.log(rows);
    // return Response.json({});
    // get the client
    const mysql = require('mysql2/promise');
    // create the connection
    const connection = await mysql.createConnection({host:'localhost', user: 'root', database: 'b_airways', password: 'shalud23'});
    // query database
    const [rows, fields] = await connection.execute(query,values);
    console.log(rows);
    return Response.json({data: rows});
}