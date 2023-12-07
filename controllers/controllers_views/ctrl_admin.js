const { bd } = require("../../config/conexion")


function fechaHoraHtml (fecha = ''){
    nuevaFecha = '';
    for(let i=0; i<fecha.length-3; i++){
        if (fecha[i] != ' ') nuevaFecha = nuevaFecha.concat(fecha[i]);
        else nuevaFecha = nuevaFecha.concat('T');
    }
    return nuevaFecha;
}

const sede = {
    sedes: async(req, res) =>{
        try {
            bd.query('select * from sedes', (error, resultado) =>{
                if(error) console.log(error);
                console.log(resultado)
                if(resultado.length > 0)
                res.render('sedes',{resultado})
                else
                res.render('sedesSinRegistro')

            })
        } catch (error) {
            console.log(error);
            res.render('404');
        }
    },
    nuevaSede: async(req, res) => {
        try {
            res.render('agregar-sede')
        } catch (error) {
            console.log(error);
            res.render('404');
        }
    },
    actualizarSede: async(req, res) =>{
        try {
            const nombre_sede = req.params.nombre_sede
            bd.query(`call buscar_sede ('${nombre_sede}', @mensaje)`, (error, resultado) => {
                if(error) console.log(error);
                console.log(resultado)
                
                res.render('actualizar-sede',{
                    nombre: resultado[0][0].sede,
                    direccion: resultado[0][0].direccion
                })

            })

        } catch (error) {
            console.log(error);
            res.render('404');
        }
    },

}

const institucion = {
    instituciones: async(req, res) =>{
        try {
            bd.query('select * from escuelas', (error, resultado) =>{
                if(error) console.log(error);
                res.render('escuela', {resultado})    
            })
        } catch (error) {
            console.log(error);
            res.render('404');
        }
    }
}

const jueces = {
    jueces: async(req, res) =>{
        try {
          bd.query('select * from jueces', (error, resultado) =>{
            if (error) console.log(error);
            res.render('jueces', {resultado});
          })  
        } catch (error) {
            console.log(error);
            res.render('404');
        }
    }
}

const reporte = {
    reportes: async(req, res) =>{
        try {
            res.render('reportes')
        } catch (error) {
            console.log(error);
        }
    }
}

const evento = {
    eventos: async(req, res) =>{
        try {
            bd.query('select * from eventos', (error, resultado) =>{
                if(error) console.log(error);
                res.render('eventos', {resultado});
            })
        } catch (error) {
            console.log(error);
            res.render('404');
        }
    },
    nuevoEvento: async(req, res) =>{
        try {
            res.render('agregar-evento')
        } catch (error) {
            console.log(error);
            res.render('404');
        }
    },
    actualizarEvento: async(req, res) =>{
        try {
            const nombre_evento = req.params.nombre_evento;

            bd.query(`call buscar_evento ("${nombre_evento}")`, (error, resultado) =>{
                if(error) console.log(error);
                res.render('actualizar-evento',{
                    eventoAntiguo: resultado[0][0].evento,
                    evento: resultado[0][0].evento,
                    sede: resultado[0][0].sede,
                })
            })
        } catch (error) {
            console.log(error);
            res.render('404');
        }
    }
}
module.exports = {
    sede,
    institucion,
    jueces,
    evento,
    reporte
}