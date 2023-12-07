var mysql = require('mysql');

var bd= mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "Neto_616",
    database: "evaluacionPrototipos"
})

bd.connect((err) =>{
    if(err){
        throw err;
    }else{
        console.log('Conectado');
    }
})
module.exports = {bd};