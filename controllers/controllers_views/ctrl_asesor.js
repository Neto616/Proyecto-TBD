const { bd } = require("../../config/conexion")

const asesor = {
    as:async(req, res) =>{
        try {
            bd.query(`call usuario_id_escuela ('${req.session.sesion.numeroControl}');`, (error, resultado) =>{
                if(error) console.log(error);
                console.log(resultado)
                bd.query(`select * from asesores where instituto = '${resultado[0][0].nombreInst}'`, (error, result) =>{  
                    if (error) console.log(error);
                    console.log(result);
                    res.render('asesor',{result});
                  
                })
            })
        } catch (error) {
            console.log(error);
            res.render('404');
        }
    }   
}

module.exports = asesor