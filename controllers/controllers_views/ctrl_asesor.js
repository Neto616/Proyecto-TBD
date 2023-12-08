const { bd } = require("../../config/conexion")

const asesor = {
    as:async(req, res) =>{
        try {
            bd.query('select * from asesor', (error, resultado) =>{
                if(error) console.log(error);
                console.log(resultado)
                if(resultado.length > 0)
                res.render('asesor',{resultado})
                else
                res.render('no asesor')

            })
        } catch (error) {
            console.log(error);
            res.render('404');
        }
    }   
}

module.exports = asesor