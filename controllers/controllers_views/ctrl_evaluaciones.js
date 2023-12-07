const { error } = require("jquery");
const { bd } = require("../../config/conexion");

const evaluaciones = {
    evua: async(req, res) =>{
        try {
            bd.query('call equipos()',(error,resultado)=>{
                if(error) console.log(error)

                res.render('evaluaciones',{equipo:resultado[0]})
            })
        } catch (error) {
            console.log(error);
        }
    }
}

module.exports = evaluaciones