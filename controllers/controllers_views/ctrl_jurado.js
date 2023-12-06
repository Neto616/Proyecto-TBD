const jurado = {
    jura: async(req, res) =>{
        try {
            res.render('jurado')
        } catch (error) {
            console.log(error);
        }
    }
}

module.exports = jurado