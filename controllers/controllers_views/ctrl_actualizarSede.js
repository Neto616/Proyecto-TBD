const Act_sede = {
    Actualizar_sede: async(req, res) =>{
        try {
            res.render('actualizar-sede')
        } catch (error) {
            console.log(error);
        }
    }
}

module.exports = Act_sede
