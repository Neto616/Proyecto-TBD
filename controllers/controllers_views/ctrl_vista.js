const vis = {
    gen: async(req, res) =>{
        try {
            res.render('vista-principal')
        } catch (error) {
            console.log(error);
        }
    }
}

module.exports = vis
