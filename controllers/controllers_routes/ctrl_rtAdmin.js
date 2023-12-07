const { bd } = require("../../config/conexion");

const sede = {
    altaSede: async(req, res) =>{
        const {nombreSede, direccion} = req.body;

        bd.query(`call alta_sede ('${nombreSede}', "${direccion}", @mensaje);`, (error, resultado) => {
            if(error){
                console.log(error);
                return res.json({estatus: 'ERR', mensaje: 'Error al dar de alta'})
            }

            console.log(resultado[0][0].resultado)
            if(resultado[0][0].resultado === 'Sede agregada exitosamente')
                return res.json({estatus: 'OK', mensaje: resultado[0][0].resultado});
            else
                return res.json({estatus: 'ERR', mensaje: resultado[0][0].resultado})
        })
    },
    bajaSede: async(req, res) => {
        const nombre_sede = req.params.nombre_sede;

        bd.query(`call baja_sede('${nombre_sede}', @mensaje);`, (error, resultado) =>{
            if(error){
                console.log(error);
                return res.json({estatus: 'ERR', mensaje: 'Error al dar de baja'})
            }

            console.log(resultado[0][0].resultado)
            if(resultado[0][0].resultado === 'Sede elimnada exitosamente')
                return res.json({estatus: 'OK', mensaje: resultado[0][0].resultado})
            else
                return res.json({estatus: 'ERR' ,resultado: resultado[0][0].resultado})
        })
    }
}


module.exports ={
    sede,
}