const sede = {
    sedesV: async(req, res) =>{
        try {
            res.render('sedes')
        } catch (error) {
            console.log(error);
        }
    }
}

module.exports = sede
