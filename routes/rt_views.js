const express = require('express');
const index = require('../controllers/controllers_views/ctrl_index');
const { mdwAdmin, mdwSesion } = require('../extras/middlewares');
const router = express.Router()

//login
router.get('/', index.inicio);

//Ventana principal compartida
router.get('/menu', [mdwSesion]); //Ventana principal que tendra varios discriminantes para los botones.

//Vistas Admin

//sede
router.get('/sede',[mdwAdmin]);
router.get('/nueva-sede',[mdwAdmin]);
router.get('/baja-sede',[mdwAdmin]);
router.get('/cambio-sede',[mdwAdmin]);

//Evento
router.get('/eventos', [mdwAdmin]);
router.get('/nuevo-evento', [mdwAdmin]);
router.get('/baja-evento', [mdwAdmin]);
router.get('/cambio-evento', [mdwAdmin]);

//Juez
router.get('/jueces',);

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