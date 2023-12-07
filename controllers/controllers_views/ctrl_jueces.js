const juez  = {
    eventos: async(req, res) =>{
        try {
            res.render('eventos-juez')            
        } catch (error) {
            console.log(error)
        }
    }
}

module.exports = {juez}