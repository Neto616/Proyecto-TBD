const { bd } = require("../../config/conexion")

const ev = {
    eve: async(req, res) =>{
        try {
            bd.query('select * from Vista_Eventos_Con_Sedes', (error, resultado) =>{
                if(error) console.log(error);
                // console.log(resultado)
                if(resultado.length > 0)
                res.render('ins-evento', {resultado});
                else
                res.render('nohay')
                       
            })
        } catch (error) {
            console.log(error);
            res.render('404');
        }
    },
}

module.exports = ev