const { Router } = require ( 'express' );
const { ctrlUsuario } = require('../controllers/controllers_routes/ctrl_rtusuario');
const router = Router()

//Usuarios
router.post('/rt-olvidar-contrasena', ctrlUsuario.rtContraOlvidada)
router.post('/rt-iniciar-sesion', ctrlUsuario.rtInicioSesion);
router.post('/rt-alta-escuela', ctrlUsuario.registrarEscuela);
router.post('/rt-alta-juez', ctrlUsuario.registrarJuez);
//Administrador
// router.delete('/baja-sede',[mdwAdmin],); //Borrar sede
// router.delete('/baja-evento', [mdwAdmin]); //Borrar evento
module.exports = router