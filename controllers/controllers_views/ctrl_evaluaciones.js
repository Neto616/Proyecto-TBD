const evaluaciones = {
    evua: async(req, res) =>{
        try {
            res.render('evaluaciones')
        } catch (error) {
            console.log(error);
        }
    }
}

module.exports = evaluaciones