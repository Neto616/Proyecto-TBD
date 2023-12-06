const Act_Alunmo = {
    alunmo: async(req, res) =>{
        try {
            res.render('act-alunmo')
        } catch (error) {
            console.log(error);
        }
    }
}

module.exports = Act_Alunmo