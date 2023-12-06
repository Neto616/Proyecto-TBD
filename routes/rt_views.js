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
const jurado = require('../controllers/controllers_views/ctrl_jurado');
const Act_jurado = require('../controllers/controllers_views/ctrl_actualizar-jurado');
const Njurado = require('../controllers/controllers_views/ctrl_AgregarJ');
const reporte = require('../controllers/controllers_views/ctrl_reportes');
const Alunmo = require('../controllers/controllers_views/ctrl_alunmo');
const Act_Alunmo = require('../controllers/controllers_views/ctrl_actualizar-alunmo');
const Agr_Alunmo = require('../controllers/controllers_views/ctrl_agregarAlunmo');
const equipos = require('../controllers/controllers_views/ctrl_equipos');
const { eque } = require('../controllers/controllers_views/ctrl_agregarEquipo');
const equipo = require('../controllers/controllers_views/ctrl_agregarEquipo');
const { equq } = require('../controllers/controllers_views/ctrl_actualizarEquipo');
const equip = require('../controllers/controllers_views/ctrl_actualizarEquipo');
const ev = require('../controllers/controllers_views/ctrl_eve');
const asesor = require('../controllers/controllers_views/ctrl_asesor');
const Agr_asesor = require('../controllers/controllers_views/ctrl_agregarAsesor');
const Jeve = require('../controllers/controllers_views/ctrl_eventosJ');


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
router.get('/jurado', jurado.jura)
router.get('/agregar-jurado', Njurado.juradoN);
router.get('/actualizar-jurado', Act_jurado.juradoA);

//institutos
router.get('/instituciones',[mdwAdmin]); //Visualizar a todas las instituciones

//reportes
router.get('/reportes', reporte.repo);

//----------------------------------------------------------------------------------------------------------------------------//

//Vistas Juez
router.get('/eventos-juez', Jeve.Jase)

//Vistas institucion
router.get('/alunmo', Alunmo.alu);
router.get('/actualizar-alunmo', Act_Alunmo.alunmo);
router.get('/agregar-alunmo', Agr_Alunmo.alun);
router.get('/equipos', equipos.equi);
router.get('/agregar-equipo', equipo.eque);
router.get('/actualizar-equipo', equip.equq);
router.get('/ins-evento', ev.eve);
router.get('/asesor', asesor.as);
router.get('/agregar-asesor', Agr_asesor.ase);

/*Vistas asesor
El asesor unicamente tendra una vista que es la principal ya que solo puede ver a los equipos que tiene
*/


module.exports = router;