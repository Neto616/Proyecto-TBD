const { pool } = require("../../config/conexion");

const usuario = {
    iniciar_sesion: async(req, res) =>{
        try {
            // const resul = await pool.query('Select * from sedes');
            // console.log(resul);
            res.render('iniciar')
        } catch (error) {
            console.log(error);
        }
    },

    contraseña_olvidada: async(req, res) =>{
        try {
            res.render('olvidar-contrasena')
        } catch (error) {
            console.log(error);
        }
    },
}


module.exports = usuario;
