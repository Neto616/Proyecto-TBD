const index = {
    inicio: async(req, res) =>{
        try {
            res.render('index')
        } catch (error) {
            console.log(error);
        }
    }
}

module.exports = index
