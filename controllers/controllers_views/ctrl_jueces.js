const { bd } = require("../../config/conexion")

const juez  = {
    eventos: async(req, res) =>{
        try {
            bd.query('call evento()',(error,resultado)=>{
                if(error) console.log(error)
                res.render('eventos-juez',{evento:resultado[0]})            
            })

        } catch (error) {
            console.log(error)
        }
    }
}

module.exports = {juez}