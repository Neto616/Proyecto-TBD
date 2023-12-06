const Agr_Alunmo = {
    alun: async(req, res) =>{
        try {
            res.render('agregar-alunmo')
        } catch (error) {
            console.log(error);
        }
    }
}

module.exports = Agr_Alunmo