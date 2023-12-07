const { bd } = require("../../config/conexion")

const Act_Alunmo = {
    alunmo: async (req, res) => {
        try {
            const { nombre_integrante } = req.params; 
            bd.query(`CALL buscar_integrante('${nombre_integrante}', @mensaje)`, (error, resultado) => {
                if (error) {
                    console.log(error);
                }
                
                res.render('act-alunmo', {
                    nombre: resultado[0][0].nombre,
                    apellido1: resultado[0][0].apellido1,
                    apellido2: resultado[0][0].apellido2
                });
            });
        } catch (error) {
            console.log(error);
            res.render('404');
        }
    }
}

module.exports = Act_Alunmo