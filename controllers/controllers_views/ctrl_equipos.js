const equipos = {
    equi: async(req, res) =>{
        try {
            res.render('equipos')
        } catch (error) {
            console.log(error);
        }
    }
}

module.exports = equipos