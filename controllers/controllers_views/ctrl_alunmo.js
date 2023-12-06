const Alunmo = {
    alu: async(req, res) =>{
        try {
            res.render('alunmo')
        } catch (error) {
            console.log(error);
        }
    }
}

module.exports = Alunmo