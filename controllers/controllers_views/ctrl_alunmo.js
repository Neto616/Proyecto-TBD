const { bd } = require("../../config/conexion")

const Alunmo = {
    alu: async(req, res) =>{
        try {
            bd.query('select * from integrante', (error, resultado) =>{
                if(error) console.log(error);
                console.log(resultado)
                if(resultado.length > 0)
                res.render('alunmo',{resultado})
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