const { Router } = require ( 'express' );
const { ctrlUsuario } = require('../controllers/controllers_routes/ctrl_rtusuario');
const { sede } = require('../controllers/controllers_routes/ctrl_rtAdmin');
const router = Router()

//Usuarios
router.post('/rt-olvidar-contrasena', ctrlUsuario.rtContraOlvidada)
router.post('/rt-iniciar-sesion', ctrlUsuario.rtInicioSesion);
router.post('/rt-alta-escuela', ctrlUsuario.registrarEscuela);
router.post('/rt-alta-juez', ctrlUsuario.registrarJuez);
//Administrador

//sedes
router.post('/rt-alta-sede', sede.altaSede);
router.post('/rt-baja-sede/:nombre_sede', sede.bajaSede);

// router.delete('/baja-sede',[mdwAdmin],); //Borrar sede
// router.delete('/baja-evento', [mdwAdmin]); //Borrar evento
module.exports = router