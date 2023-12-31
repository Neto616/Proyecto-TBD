const { bd} = require("../../config/conexion");

const ctrlEscuela = {
    integranteNuevo: async(req, res) => {
        const {nombre, apellido1, apellido2, fecha_nacimiento} = req.body;

        bd.query(`call alta_integrante('${req.session.sesion.numeroControl}','${nombre}', '${apellido1}', '${apellido2}', '${fecha_nacimiento}', @mensaje);`, (error, resultado) => {
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
    bajaIntegrante: async (req, res) => {
        const nombre = req.params.nombre;
        const apellidoPat = req.params.apellidoPat;
        const apellidoMat = req.params.apellidoMat;
    
        bd.query(`call baja_integrante("${nombre}", "${apellidoPat}", "${apellidoMat}", @mensaje);`, (error, resultado) => {
            if (error) {
                console.log(error);
                return res.json({ estatus: 'ERR', mensaje: 'Error al eliminar' });
            }
            
            // console.log(resultado[0][0].resultado);
    
            if (resultado[0][0].resultado === 'Eliminación exitosa') {
                return res.json({ estatus: 'OK', mensaje: resultado[0][0].resultado });
            } else {
                return res.json({ estatus: 'ERR', resultado: resultado[0][0].resultado });
            }
        });
    },
    modificarIntegrante: async (req, res) => {
        const { nombreAntiguo, nombre, apellido1, apellido2 } = req.body;
    
        bd.query(`CALL modificar_integrante('${nombreAntiguo}', '${nombre}', '${apellido1}', '${apellido2}', @mensaje);`, (error, resultado) => {
            if (error) {
                console.log(error);
                return res.json({ estatus: 'ERR', mensaje: 'Error al actualizar' });
            }
    
            // console.log(resultado[0][0].resultado);
            if (resultado[0][0].resultado === 'Actualización realizada con éxito') {
                return res.json({ estatus: 'OK', mensaje: resultado[0][0].resultado });
            } else {
                return res.json({ estatus: 'ERR', resultado: resultado[0][0].resultado });
            }
        });
    },
    registrarAsesor: async (req, res) => {
        const { nombre, apellido1, apellido2, nivel_institucion, correo, contraseña } = req.body;
        bd.query(`call evaluacionprototipos.alta_asesor('${req.session.sesion.numeroControl}', '${correo}', '${contraseña}', '${nombre}', '${apellido1}', '${apellido2}', '${nivel_institucion}', @mensaje); `,
            (error, resultado) => {
                if (error) {
                    console.log(error);
                    return res.json({ estatus: 'ERR', mensaje: 'Error' });
                }
                console.log(resultado[0][0].resultado);
                if (resultado[0][0].resultado === 'Agregado correctamente') {
                    return res.json({ estatus: 'OK', mensaje: resultado[0][0].resultado });
                } else {
                    return res.json({ estatus: 'ERR', mensaje: resultado[0][0].resultado });
                }
            }
        );
    },
    bajaAsesor: async(req, res) => {
        const id = req.params.id;
        console.log(id);
        bd.query(`call baja_asesor ('${id}', @mensaje)`, (error, resultado) =>{
            if (error) {
             console.log(error);
             return res.json({estatus: 'ERR', mensaje: 'Error al eliminar asesor'});   
            }
            console.log(resultado[0][0].resultado);
            if (resultado[0][0].resultado === 'Eliminados de manera exitosa') {
                return res.json({ estatus: 'OK', mensaje: resultado[0][0].resultado });
            } else {
                return res.json({ estatus: 'ERR', mensaje: resultado[0][0].resultado });
            }
        })
    }
    
    
}


module.exports = {
    ctrlEscuela
};