const Act_jurado = {
    juradoA: async(req, res) =>{
        try {
            res.render('actualizar-jurado')
        } catch (error) {
            console.log(error);
        }
    }
}

module.exports = Act_jurado