const asesor = {
    as: async(req, res) =>{
        try {
            res.render('asesor')
        } catch (error) {
            console.log(error);
        }
    }
}

module.exports = asesor