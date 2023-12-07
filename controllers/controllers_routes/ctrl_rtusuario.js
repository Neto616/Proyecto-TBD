
const { bd} = require("../../config/conexion");

const ctrlUsuario = {
    registrarEscuela: async(req, res) => {
        const {instituto, nivelAcademico, direccion, correo, contraseña} = req.body;

        bd.query(`call alta_institucion('${correo}', '${contraseña}', '${instituto}', '${nivelAcademico}', '${direccion}', @mensaje);`, (error, resultado) => {
            if(error){
                console.log(error);
                return res.json({estatus: 'ERR', mensaje: 'Error'});
            } 

            console.log(resultado[0][0].resultado)
            if(resultado[0][0].resultado !== "Instituto existente")
                return res.json({estatus: 'OK', mensaje: resultado[0][0].resultado});
            else
                return res.json({estatus: 'ERR', mensaje: resultado[0][0].resultado});

        })
    },
    registrarJuez: async(req, res) => {
        const {nombre, apellidoP, apellidoM, direccion, nivelAcademico, institucionJuez, correoJuez, contrasena} = req.body;

        bd.query(`call alta_juez ('${correoJuez}', "${contrasena}","${nombre}","${apellidoP}","${apellidoM}","${direccion}","${nivelAcademico}", "${institucionJuez}", @mensaje);`, (error, resultado) => {
            if(error){
                console.log(error);
                return res.json({estatus: 'ERR', mensaje: 'Error'});
            }
            console.log(resultado[0][0].resultado);
            if(resultado[0][0].resultado === "Agregado correctamente")
                return res.json({estatus: 'OK', mensaje: resultado[0][0].resultado});
            else
                return res.json({estatus: 'ERR', mensaje: resultado[0][0].resultado});
        })
    },
    rtInicioSesion: async(req, res) => {
        try {
            const {correo, contraseña} = req.body;

            bd.query(`call inicio_sesion("${correo}","${contraseña}")`, (error, resultado) =>{
                if(error) console.log(error);
                console.log(resultado[0][0])
                if(resultado[0][0].resultado !== "No existe"){

                    const usuario= {
                        id: resultado[0][0].idUs,
                        puesto: resultado[0][0].puesto
                    };
                    
                    req.session.sesion ={
                        numeroControl: usuario.id,
                        puesto: usuario.puesto,
                        correoUs: correo 
                    }
                    console.log(usuario.id+'\n'+usuario.puesto)
                    return res.json({estatus:'OK', id: usuario.id ,puesto: usuario.puesto, mensaje: 'Bienvenido ^u^'});
                }else{
                    return res.json({estatus: 'ERR', mensaje: "Contraseña o correo incorrectos favor de verificar"});
                }
            })
        } catch (error) {
            console.log(error)
        }
    },
    rtContraOlvidada: async(req, res) => {
        try {
            const {correo} = req.body;
            bd.query(`Call recuperar_contrasena("${correo}")`, (error, resultado) =>{
                if(error) console.log(error);
                const contrasenaUs = resultado[0][0].contraseñaUs
                res.json({estatus:'OK', contraUsuario: contrasenaUs})
            })
        } catch (error) {
            console.log(error)
        }
    }
}

module.exports = {
    ctrlUsuario
};