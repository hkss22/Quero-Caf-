import mysql from 'mysql';

// Conexao com o banco
const db = mysql.createPool({
    host: "viaduct.proxy.rlwy.net",
    user: "root",
    password: "SEGREDO... xP",
    database: "railway"
});


export default db;