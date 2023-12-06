const eventos = {
    even: async(req, res) =>{
        try {
            res.render('eventos')
        } catch (error) {
            console.log(error);
        }
    }
}

module.exports = eventos
