const registroJ = {
    rej: async(req, res) =>{
        try {
            res.render('registro-juez')
        } catch (error) {
            console.log(error);
        }
    }
}

module.exports = registroJ