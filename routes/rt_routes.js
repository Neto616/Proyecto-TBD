const { Router } = require ( 'express' );
const { ctrlUsuario } = require('../controllers/controllers_routes/ctrl_rtusuario');
const { sede, instituto, juez, evento } = require('../controllers/controllers_routes/ctrl_rtAdmin');
const { ctrlEscuela } = require('../controllers/controllers_routes/ctrl_rtEscuela');
const ctrl_juez = require('../controllers/controllers_routes/ctrl_rtJuez');
const router = Router()

//-----------------------------Usuarios---------------------------------------------------------------
router.post('/rt-olvidar-contrasena', ctrlUsuario.rtContraOlvidada)
router.post('/rt-iniciar-sesion', ctrlUsuario.rtInicioSesion);
router.post('/rt-alta-escuela', ctrlUsuario.registrarEscuela);
router.post('/rt-alta-juez', ctrlUsuario.registrarJuez);

//----------------------Administrador-----------------------------------------------------------

//sedes
router.post('/rt-alta-sede', sede.altaSede);
router.post('/rt-baja-sede/:nombre_sede', sede.bajaSede);
router.post('/rt-modificar-sede', sede.modificarSede);
//Evento
router.post('/rt-alta-evento', evento.alta);
router.post('/rt-actualizar-eventos', evento.actualizar);
router.post('/rt-baja-evento/:nombre_evento', evento.baja);
//Instituto
router.post('/rt-baja-instituto/:nombre_instituto/:nivel_instituto', instituto.bajaInstituto)
//Juez
router.post('/rt-baja-juez/:nombre_juez/:apellidop_Juez/:apellidom_juez', juez.baja)


//---------------------------Escuelas-------------------------------------------------------------
router.post('/rt-integrante-nuevo', ctrlEscuela.integranteNuevo);
router.post('/rt-modificar-integrante', ctrlEscuela.modificarIntegrante);
router.post('/rt-baja-alumno/:nombre/:apellidoPat/:apellidoMat', ctrlEscuela.bajaIntegrante);
router.post('/rt-alta-asesor', ctrlEscuela.registrarAsesor);
router.post('/rt-baja-asesor/:id', ctrlEscuela.bajaAsesor);
//--------------------------juez------------------------------------------------------------
router.post('/rt-participar-juez',ctrl_juez.rtParticiparEvento)
router.post('/rt-calificar-equipo',ctrl_juez.rtCalificarEquipo)
// router.delete('/baja-sede',[mdwAdmin],); //Borrar sede
// router.delete('/baja-evento', [mdwAdmin]); //Borrar evento
module.exports = router