const { bd } = require("../../config/conexion")

const Alunmo = {
    alu: async(req, res) =>{
        try {
            bd.query(`call alumnos('${req.session.sesion.numeroControl}')`, (error, resultado) =>{
                if(error) console.log(error);
                console.log(resultado[0])
                if(resultado.length > 0)
                res.render('alunmo',{resp: resultado[0]})
                else
                res.render('alunmosSinRegistro')

            })
        } catch (error) {
            console.log(error);
            res.render('404');
        }
    }   
}    

module.exports = Alunmo