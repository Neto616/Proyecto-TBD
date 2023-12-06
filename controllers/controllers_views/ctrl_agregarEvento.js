const eventosN = {
    Areven: async(req, res) =>{
        try {
            res.render('agregar-evento')
        } catch (error) {
            console.log(error);
        }
    }
}

module.exports = eventosN
