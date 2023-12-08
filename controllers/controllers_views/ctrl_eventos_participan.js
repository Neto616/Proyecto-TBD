const { bd } = require("../../config/conexion")

const part = {
pareve: async(req, res) =>{
    try {
        bd.query('select * from Vista_Eventos_Con_Sedes', (error, resultado) =>{
            if(error) console.log(error);
            // console.log(resultado)
            if(resultado.length > 0)
            res.render('eventos-participan', {resultado});
            else
            res.render('no')
                   
        })
    } catch (error) {
        console.log(error);
        res.render('404');
    }
},
}
module.exports = part