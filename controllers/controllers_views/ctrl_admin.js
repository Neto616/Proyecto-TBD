const { bd } = require("../../config/conexion")

const sede = {
    sedes: async(req, res) =>{
        try {
            bd.query('select * from sedes', (error, resultado) =>{
                if(error) console.log(error);
                console.log(resultado)
                res.render('sedes',{resultado})
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
            res.render('actualizar-sede')
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
            res.render('actualizar-evento')
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