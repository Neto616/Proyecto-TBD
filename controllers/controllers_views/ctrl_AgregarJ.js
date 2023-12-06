const Njurado = {
    juradoN: async(req, res) =>{
        try {
            res.render('agregar-jurado')
        } catch (error) {
            console.log(error);
        }
    }
}

module.exports = Njurado