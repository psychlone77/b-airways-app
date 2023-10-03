export async function GET() {
  try {
    const query = "SELECT * from organizational_info";
    const values = [];
    const pool = require('../../database/db')
    // create the connection
    // const dbconnection = await mysql.createConnection({
    //   host: DB_HOST,
    //   user: DB_USER,
    //   database: DB_DATABASE,
    //   password: DB_PASSWORD,
    // });
    // query database
    const [rows] = await pool.execute(query, values);
    //console.log(rows);
    return Response.json(rows[0] );
  } catch (error) {
    return Response.json({ error });
  }
}
