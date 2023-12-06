const jueces = {
    jue: async(req, res) =>{
        try {
            res.render('jueces')
        } catch (error) {
            console.log(error);
        }
    }
}

module.exports = jueces
