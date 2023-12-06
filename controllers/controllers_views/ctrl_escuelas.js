const escuelas = {
    escula: async(req, res) =>{
        try {
            res.render('escuela')
        } catch (error) {
            console.log(error);
        }
    }
}

module.exports = escuelas