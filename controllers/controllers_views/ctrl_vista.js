const { bd } = require("../../config/conexion")

const vis = {
    gen: async(req, res) =>{
        try {
            const puestoUs = req.session.sesion.puesto
            const idUs = req.session.sesion.numeroControl
            
                res.render('vista-principal', {puesto: puestoUs,
                id: idUs})
        } catch (error) {
            console.log(error);
            res.render('404')
        }
    }
}

module.exports = vis
