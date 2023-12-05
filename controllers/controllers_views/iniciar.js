const ini = {
    log: async(req, res) =>{
        try {
            res.render('iniciar')
        } catch (error) {
            console.log(error);
        }
    }
}

module.exports = ini
