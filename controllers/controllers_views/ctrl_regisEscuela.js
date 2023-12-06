const registro = {
    re: async(req, res) =>{
        try {
            res.render('regis-escuela')
        } catch (error) {
            console.log(error);
        }
    }
}

module.exports = registro