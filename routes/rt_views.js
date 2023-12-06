const express = require('express');
const index = require('../controllers/controllers_views/ctrl_index');
const { mdwAdmin, mdwSesion } = require('../extras/middlewares');
const usuario = require('../controllers/controllers_views/ctrl_usuario');
const vis = require('../controllers/controllers_views/ctrl_vista');
const sede = require('../controllers/controllers_views/ctrl_sedes');
const Nueva_sede = require('../controllers/controllers_views/ctrl_nuevaSede');
const Act_sede = require('../controllers/controllers_views/ctrl_actualizarSede');
const eventos = require('../controllers/controllers_views/ctrl_eventos');
const eventosN = require('../controllers/controllers_views/ctrl_agregarEvento');
const Act_eventos = require('../controllers/controllers_views/ctrl_actualizarEvento');
const escuelas = require('../controllers/controllers_views/ctrl_escuelas');
const jueces = require('../controllers/controllers_views/ctrl_jueces');


const router = express.Router()

//login
router.get('/', index.inicio);
router.get('/iniciar', usuario.iniciar_sesion);

router.get('/olvidar-contrasena', usuario.contraseña_olvidada);

//Ventana principal compartida
router.get('/vista-principal', vis.gen, ); //Ventana principal que tendra varios discriminantes para los botones.

//Vistas Admin

//sede
router.get('/sedes', sede.sedesV, );
router.get('/agregar-sede', Nueva_sede.sedeN, );
router.get('/baja-sede',[mdwAdmin]);
router.get('/actualizar-sede', Act_sede.Actualizar_sede, );

//Evento
router.get('/eventos', eventos.even, );
router.get('/agregar-evento', eventosN.Areven);
router.get('/baja-evento', [mdwAdmin]);
router.get('/actualizar-evento', Act_eventos.Evento_Act);

// Escuela
router.get('/escuela', escuelas.escula);

//Juez
router.get('/jueces', jueces.jue);

//Jurado
router.get('/nuevo-jurado', [mdwAdmin]);
router.get('/cambio-jurado', [mdwAdmin]);

//institutos
router.get('/instituciones',[mdwAdmin]); //Visualizar a todas las instituciones

//reportes


//----------------------------------------------------------------------------------------------------------------------------//

//Vistas Juez


//Vistas institucion

/*Vistas asesor
El asesor unicamente tendra una vista que es la principal ya que solo puede ver a los equipos que tiene
*/


module.exports = router;