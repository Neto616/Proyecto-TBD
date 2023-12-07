const pool = require("../../config/conexion");

const usuario = {
    alta_escuela: async(req, res) => {
        try {
            res.render('registro-escuela');
        } catch (error) {
            console.log(error);
            res.render('404');
        }
    },
    alta_juez: async(req, res) => {
        try {
            res.render('registro-juez');
        } catch (error) {
            console.log(error);
            res.render('404');
        }
    },
    iniciar_sesion: async(req, res) => {
        try {
            res.render('iniciar')
        } catch (error) {
            console.log(error);
            res.render('404')
        }
    },

    contraseña_olvidada: async(req, res) =>{
        try {
            res.render('olvidar-contrasena')
        } catch (error) {
            console.log(error);
            res.render('404')
        }
    },
}


module.exports = usuario;
