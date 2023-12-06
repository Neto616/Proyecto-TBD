const Act_eventos = {
    Evento_Act: async(req, res) =>{
        try {
            res.render('actualizar-evento')
        } catch (error) {
            console.log(error);
        }
    }
}

module.exports = Act_eventos
