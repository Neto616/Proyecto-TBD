const { bd } = require("../../config/conexion");

function fechaHoraHtml (fecha = ''){
    nuevaFecha = '';
    for(let i=0; i<fecha.length; i++){
        if (fecha[i] != ' ') nuevaFecha = nuevaFecha.concat(fecha[i]);
        else nuevaFecha = nuevaFecha.concat('T');
    }
    return nuevaFecha;
}

const sede = {
    altaSede: async(req, res) =>{
        const {nombreSede, direccion} = req.body;

        bd.query(`call alta_sede ('${nombreSede}', "${direccion}", @mensaje);`, (error, resultado) => {
            if(error){
                console.log(error);
                return res.json({estatus: 'ERR', mensaje: 'Error al dar de alta'})
            }
            if(resultado[0][0].resultado === 'Sede agregada exitosamente')
                return res.json({estatus: 'OK', mensaje: resultado[0][0].resultado});
            else
                return res.json({estatus: 'ERR', mensaje: resultado[0][0].resultado})
        })
    },
    bajaSede: async(req, res) => {
        const nombre_sede = req.params.nombre_sede;

        bd.query(`call baja_sede('${nombre_sede}', @mensaje);`, (error, resultado) =>{
            if(error){
                console.log(error);
                return res.json({estatus: 'ERR', mensaje: 'Error al dar de baja'})
            }

            console.log(resultado[0][0].resultado)
            if(resultado[0][0].resultado === 'Sede elimnada exitosamente')
                return res.json({estatus: 'OK', mensaje: resultado[0][0].resultado})
            else
                return res.json({estatus: 'ERR' ,resultado: resultado[0][0].resultado})
        })
    },
    modificarSede: async(req, res) => {
        const {nombreAntiguo, nombre, direccion} = req.body;
    
        bd.query(`call modificar_sede ('${nombreAntiguo}','${nombre}','${direccion}',@mensaje)`, (error, resultado) =>{
            if(error){
                console.log(error);
                return res.json({estatus: 'ERR', mensaje: 'Error al actualizar'});
            }
            console.log(resultado[0][0].resultado)
            if(resultado[0][0].resultado === 'Actualizacion realizada con exito')
                return res.json({estatus: 'OK', mensaje: resultado[0][0].resultado})
            else
                return res.json({estatus: 'ERR' ,resultado: resultado[0][0].resultado})
        })
    }
}

const instituto = {
    bajaInstituto: async (req, res) => {
        const nombre_instituto = req.params.nombre_instituto;
        const nivel_instituto = req.params.nivel_instituto;

        bd.query(`call  baja_institucion ("${nombre_instituto}","${nivel_instituto}", @mensaje);`, (error, resultado) =>{
            if(error){
                console.log(error);
                return res.json({estatus: 'ERR', mensaje: 'Error al dar de baja'});
            }
            console.log(resultado[0][0].resultado)
            if(resultado[0][0].resultado === 'Instituto eliminado correctamente')
                return res.json({estatus: 'OK', mensaje: resultado[0][0].resultado})
            else
                return res.json({estatus: 'ERR' ,resultado: resultado[0][0].resultado})
        })
    }
}

const juez = {
    baja: async (req, res) => {
        const nombre_juez = req.params.nombre_juez;
        const apellidop_Juez = req.params.apellidop_Juez;
        const apellidom_juez = req.params.apellidom_juez;

        bd.query(`call baja_juez ("${nombre_juez}","${apellidop_Juez}","${apellidom_juez}", @mensaje)`, (error, resultado) => {
            if(error){
                console.log(error);
                return res.json({estatus: 'ERR', mensaje: 'Error al dar de baja al juez'});
            }
            console.log(resultado[0][0].resultado)
            if(resultado[0][0].resultado === 'Juez eliminado correctamente')
                return res.json({estatus: 'OK', mensaje: resultado[0][0].resultado})
            else
                return res.json({estatus: 'ERR' ,resultado: resultado[0][0].resultado})
        })
    }
}

const evento = {
    alta: async (req, res) => {
        const {nombreEvento, nombreSede, direccionSede, fechaInicio, fechaFin} = req.body;

        bd.query(`call alta_evento ("${nombreEvento}","${fechaInicio}","${fechaFin}","${nombreSede}","${direccionSede}", @mensaje)`, (error, resultado) => {
            if(error){
                console.log(error);
                return res.json({estatus: 'ERR', mensaje: 'Error al dar de alta el evento'});
            }
            console.log(resultado[0][0].resultado)
            if(resultado[0][0].resultado === 'Evento creado sede existente' || resultado[0][0].resultado === 'Evento creado exitosamente sede no creada')
                return res.json({estatus: 'OK', mensaje: 'Evento creado exitosamente'});
            else
                return res.json({estatus: 'ERR' ,resultado: resultado[0][0].resultado});
        })
    },
    actualizar: async (req, res) => {
        const {nombreActual, nombre} = req.body;
        
        bd.query(`call modificar_evento("${nombreActual}","${nombre}",@mensaje)`, (error, resultado) =>{
            if(error){
                console.log(error);
                return res.json({estatus: 'ERR', mensaje: 'Error al dar de alta el evento'});
            }
            if(resultado[0][0].resultado === 'Evento actualizado correctamente')
                return res.json({estatus: 'OK', mensaje: resultado[0][0].resultado});
            else
                return res.json({estatus: 'ERR' ,resultado: resultado[0][0].resultado});
        })
    },
    baja: async(req, res) => {
        const nombre_evento = req.params.nombre_evento;

        bd.query(`call baja_evento ("${nombre_evento}", @mensaje)`, (error, resultado) => {
            if(error){
                console.log(error);
                return res.json({estatus: 'ERR', mensaje: 'Error al dar de baja el evento'});
            }
            if(resultado[0][0].resultado === 'Evento eliminado de manera correcta')
                return res.json({estatus: 'OK', mensaje: resultado[0][0].resultado});
            else
                return res.json({estatus: 'ERR' ,resultado: resultado[0][0].resultado}); 
        })
    }
}

module.exports ={
    sede,
    instituto,
    juez,
    evento
}