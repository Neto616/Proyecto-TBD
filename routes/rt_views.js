const express = require('express');
const index = require('../controllers/controllers_views/ctrl_index');
const usuario = require('../controllers/controllers_views/ctrl_usuario');
const vis = require('../controllers/controllers_views/ctrl_vista');
const { juez } = require('../controllers/controllers_views/ctrl_jueces');
const { sede, institucion, jueces, evento, reporte } = require('../controllers/controllers_views/ctrl_admin');
const { mdwAdmin, mdwSesion } = require('../extras/middlewares');

const jurado = require('../controllers/controllers_views/ctrl_jurado');
const Act_jurado = require('../controllers/controllers_views/ctrl_actualizar-jurado');
const Njurado = require('../controllers/controllers_views/ctrl_AgregarJ');

const Alunmo = require('../controllers/controllers_views/ctrl_alunmo');
const Act_Alunmo = require('../controllers/controllers_views/ctrl_actualizar-alunmo');
const Agr_Alunmo = require('../controllers/controllers_views/ctrl_agregarAlunmo');
const equipos = require('../controllers/controllers_views/ctrl_equipos');
const equipo = require('../controllers/controllers_views/ctrl_agregarEquipo');
const equip = require('../controllers/controllers_views/ctrl_actualizarEquipo');
const ev = require('../controllers/controllers_views/ctrl_eve');
const asesor = require('../controllers/controllers_views/ctrl_asesor');
const Agr_asesor = require('../controllers/controllers_views/ctrl_agregarAsesor');
const evaluaciones = require('../controllers/controllers_views/ctrl_evaluaciones');
const part = require('../controllers/controllers_views/ctrl_eventos_participan');


const router = express.Router()
//Error
router.get('/404', async(req,res)=>{
    try{
        res.render('404');
    }catch(err){
        console.log(err);
        res.render('404');
    }
})
//Cookie
router.get('/sesion', async(req,res)=>{
    try{
        res.json(req.session)
    }catch(err){
        console.log(err)
    }
})

//login
router.get('/cerrar-sesion', [mdwSesion], async(req, res) => {
    try{
    req.session.destroy();

    return res.redirect('/');
    
}catch(err){
    alert('No tiene una sesión activa');
}})
router.get('/', index.inicio);
router.get('/iniciar',usuario.iniciar_sesion);
router.get('/registrar-escuela',usuario.alta_escuela)
router.get('/registrar-juez', usuario.alta_juez)
router.get('/olvidar-contrasena', usuario.contraseña_olvidada);

//Ventana principal compartida
router.get('/vista-principal', [mdwSesion], vis.gen); //Ventana principal que tendra varios discriminantes para los botones.

//Vistas Admin

//sede
router.get('/sedes', [mdwAdmin],sede.sedes);
router.get('/agregar-sede', [mdwAdmin],sede.nuevaSede);
router.get('/actualizar-sede/:nombre_sede', [mdwAdmin],sede.actualizarSede );

//Evento
router.get('/eventos', [mdwAdmin],evento.eventos );
router.get('/agregar-evento', [mdwAdmin],evento.nuevoEvento);
router.get('/actualizar-evento/:nombre_evento',[mdwAdmin],evento.actualizarEvento);

// Escuela 
router.get('/escuela', [mdwAdmin],institucion.instituciones);

//Juez
router.get('/jueces',[mdwAdmin], jueces.jueces);

//Jurado
// router.get('/jurado', jurado.jura)
// router.get('/agregar-jurado', Njurado.juradoN);
// router.get('/actualizar-jurado', Act_jurado.juradoA);

//institutos
router.get('/instituciones',[mdwAdmin],); //Visualizar a todas las instituciones

//reportes
router.get('/reportes', [mdwAdmin],reporte.reportes);
router.get('/todos-equipos', [mdwAdmin],reporte.equipos);
router.get('/equipos-primaria', [mdwAdmin],reporte.equipos_primaria);
router.get('/equipos-secundaria', [mdwAdmin],reporte.equipos_secundaria);
router.get('/equipos-bachillerato', [mdwAdmin],reporte.equipos_bachillerato);
router.get('/equipos-profesional', [mdwAdmin],reporte.equipos_profesional);

//----------------------------------------------------------------------------------------------------------------------------//

//Vistas Juez
router.get('/eventos-juez', juez.eventos);;
router.get('/evaluaciones', evaluaciones.evua);

//Vistas institucion
router.get('/alunmo', Alunmo.alu);
router.get('/agregar-alunmo', Agr_Alunmo.alun);

router.get('/equipos', equipos.equi);
router.get('/agregar-equipo', equipo.eque);
router.get('/actualizar-equipo', equip.equq);
router.get('/ins-evento', ev.eve);
router.get('/asesor', asesor.as);
router.get('/agregar-asesor', Agr_asesor.ase);
router.get('/eventos-participan', part.pareve);

/*Vistas asesor
El asesor unicamente tendra una vista que es la principal ya que solo puede ver a los equipos que tiene
*/


module.exports = router;