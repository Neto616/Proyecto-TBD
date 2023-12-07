const { bd} = require("../../config/conexion");

const ctrlEscuela = {
    integranteNuevo: async(req, res) => {
        const {nombre, apellido1, apellido2, fechaNacimiento} = req.body;

        bd.query(`call alta_integrante('${nombre}', '${apellido1}', '${apellido2}', '${fechaNacimiento}', @mensaje);`, (error, resultado) => {
            if(error){
                console.log(error);
                return res.json({estatus: 'ERR', mensaje: 'Error'});
            } 

            console.log(resultado[0][0].resultado)
            if(resultado[0][0].resultado !== "El integrante ya existe")
                return res.json({estatus: 'OK', mensaje: resultado[0][0].resultado});
            else
                return res.json({estatus: 'ERR', mensaje: resultado[0][0].resultado});
   
        })
    },
   
}

module.exports = {
    ctrlEscuela
};