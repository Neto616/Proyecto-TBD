const { bd } = require("../../config/conexion")

const equipos = {
    equi: async(req, res) =>{
        try {
            bd.query('select * from equipo', (error, resultado) =>{
                if(error) console.log(error);
                // console.log(resultado)
                if(resultado.length > 0)
                res.render('equipo',{resultado})
                else
                res.render('equiposSinregistro')

            })
        } catch (error) {
            console.log(error);
            res.render('404');
        }
    } 
}

module.exports = equipos